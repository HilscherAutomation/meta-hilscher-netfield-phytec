FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}_${PV}:"

DEPENDS:append = " u-boot-tools-native python3-setuptools-native"

require recipes-bsp/u-boot/u-boot-netfield.inc

SRC_URI:append = " \
	file://machine_config.h \
	file://defconfig \
	file://0001-Changed-config-file-from-machine-to-distro-specific-.patch \
	"

inherit hilscher-deploy

hd_path = "${HDEPLOY_PATH_EXTRAS}/bootloader"

do_hilscher_deploy() {
	cd ${DEPLOYDIR}
	cp -a $(readlink flash.bin) ${hd_path}/
}
do_hilscher_deploy[cleandirs] = "${hd_path}/"
addtask hilscher_deploy before do_build after do_deploy
