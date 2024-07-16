FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"
SRC_URI:append = " \
                   file://0001-set_boot_image_size_to_64MB.patch \
                   file://mkimage-wrapper \
                   file://disable-no-unit-address-check.patch \
                  "

do_install:append() {
        # replace the original mkimage with a wrapper (see script for more info)
        mv ${D}/${bindir}/uboot-mkimage ${D}/${bindir}/uboot-mkimage.bin
        cp ${WORKDIR}/mkimage-wrapper   ${D}/${bindir}/uboot-mkimage

        chmod 755 ${D}/${bindir}/uboot-mkimage
}
