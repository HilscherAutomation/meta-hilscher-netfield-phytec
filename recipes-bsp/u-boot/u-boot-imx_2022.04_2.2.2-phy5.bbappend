FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}_${PV}:"

DEPENDS:append = " u-boot-tools-native python3-setuptools-native"

require recipes-bsp/u-boot/u-boot-netfield.inc

SRC_URI:append = " \
	file://machine_config.h \
	file://defconfig \
	file://0001-Changed-config-file-from-machine-to-distro-specific-.patch \
	"

inherit dts-sign
# Setup public key patching into dts
DTS_SIGN_ENFORCE="${PLATFORM_SIGN}"
DTS_SIGN_KEY_DIR="${PLATFORM_KEYDIR}"
DTS_SIGN_KEY_NAME="${PLATFORM_KEYNAME}"
DTS_TO_SIGN="${@d.getVar('S') + '/arch/arm/dts/' + d.getVar('UBOOT_DTB_NAME').replace('.dtb','.dts')}"
