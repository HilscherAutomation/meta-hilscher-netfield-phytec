FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

# Required by *platform_init*
#RDEPENDS:${PN}-platform-init:append:phyboard-pollux-imx8mp-3 = " i2c-tools device-tree"

SRC_URI:append = " file://platform_restore"

do_install:append() {
    install -d ${D}${sbindir}
    install ${WORKDIR}/platform_restore ${D}${sbindir}
}

FILES:${PN}:append = " ${sbindir}/platform_restore"
