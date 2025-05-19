FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}_${PV}:"

DEPENDS:append = " u-boot-tools-native python3-setuptools-native"

require recipes-bsp/u-boot/u-boot-netfield.inc

SRC_URI:append = " \
	file://machine_config.h \
	file://0001-Changed-config-file-from-machine-to-distro-specific-.patch \
	file://pollux_defconfig_netfield.patch \
	file://0002-fix-boot-script-issues-related-to-unit-addressing.patch \
	file://0003-fix-console-handling.patch \
	"

inherit dts-sign
# Setup public key patching into dts
DTS_SIGN_ENFORCE="${PLATFORM_SIGN}"
DTS_SIGN_KEY_DIR="${PLATFORM_KEYDIR}"
DTS_SIGN_KEY_NAME="${PLATFORM_KEYNAME}"
DTS_TO_SIGN="${@d.getVar('S') + '/arch/arm/dts/' + d.getVar('UBOOT_DTB_NAME').replace('.dtb','.dts')}"

do_configure:prepend() {
    cp ${WORKDIR}/machine_config.h ${S}/include/configs/
}

SRC_URI:append:netfield-quantum-rev1 = " \
    file://netfield-quantum-rev1.dts \
    file://netfield-quantum-rev1-u-boot.dtsi \
    "

do_patch:append:netfield-quantum-rev1() {
    bb.build.exec_func('do_copy_dts', d)
}

do_copy_dts() {
    cp ${WORKDIR}/netfield-quantum-rev1.dts ${S}/arch/arm/dts/
    cp ${WORKDIR}/netfield-quantum-rev1-u-boot.dtsi ${S}/arch/arm/dts/

    sed -e 's/CONFIG_DEFAULT_DEVICE_TREE.*/CONFIG_DEFAULT_DEVICE_TREE="netfield-quantum-rev1"/g' \
        -i ${S}/configs/phycore-imx8mp_defconfig
}
