require recipes-kernel/linux/netfield-linux.inc
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

# Prevent automatically inclusion of kernel-image into rootfs/image
RDEPENDS_${KERNEL_PACKAGE_NAME}-base = ""

# Add support for yocto-kernel-cache
# ----------------------------------
require recipes-kernel/linux/linux-yocto.inc
KCONFIG_MODE = "--alldefconfig"

LINUX_VERSION ?= "${PV}"
KMETA = "kernel-meta"
KBRANCH = "${BRANCH}"
SRC_URI:append = " git://git.yoctoproject.org/yocto-kernel-cache;type=kmeta;name=meta;branch=yocto-5.15;destsuffix=${KMETA}"
SRCREV_FORMAT = "meta_${@d.getVar('SRCREV', True)[:10]}"
# ----------------------------------

KERNEL_FEATURES:append = " features/bluetooth/bluetooth.scc features/bluetooth/bluetooth-usb.scc features/rfkill/rfkill.scc"
# TPM does not work as TCG_ATMEL is included which results in a kernel crash
KERNEL_FEATURES:remove = " features/tpm/tpm.scc"

SRC_URI:append = " \
	file://defconfig \
	file://disable_msi_if_cifx_found.patch \
	file://tpm.cfg \
	file://led_timer.cfg \
	file://gpio_sysfs.cfg \
	file://netfieldos.cfg \
    file://rfkill_gpio_ofsupport.patch \
"

# Enable module for qemu support
SRC_URI:append = " file://binfmt_misc.cfg"

do_hilscher_deploy() {
    kernel=$(find ${DEPLOYDIR} -type f -name "fitImage-core-image-minimal-initramfs-*.bin")
    cp -a $(readlink -f $kernel) "${hd_path}/"
}

# Don't use u-boot-mkimage to add public key, as this does not work well with out pkcs11 infrastructure
UBOOT_DTB_BINARY=""
# TODO: Disable checking of signature check for fitimage as it does not work
DISABLE_FIT_SIGNATURE_CHECK="1"
# We need a link in deploydir for rootfs generation, but meta-phytec disabled it
KERNEL_ARTIFACT_LINK_NAME = "${MACHINE}"

SRC_URI:append:netfield-quantum-rev1 = " file://netfield-quantum-rev1.dts"
do_patch:append:netfield-quantum-rev1() {
    cp ${WORKDIR}/netfield-quantum-rev1.dts ${S}/arch/arm64/boot/dts/freescale/
}
