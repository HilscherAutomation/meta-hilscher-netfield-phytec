SUMMARY="Service to mount/umount the sdcard"
LICENSE="CLOSED"

inherit allarch
PACKAGES="${PN}"

SRC_URI=" \
	file://sdcard-mount.rules \
	file://sdcard-mount@.service \
	file://sdcard-mount.sh \
"

do_install() {
	install -d ${D}${base_libdir}/udev/rules.d/
	install -m 0644 ${WORKDIR}/sdcard-mount.rules ${D}${base_libdir}/udev/rules.d/99-sdcard-mount.rules

	install -d ${D}${systemd_system_unitdir}
	install -m 0644 ${WORKDIR}/sdcard-mount@.service ${D}${systemd_system_unitdir}/sdcard-mount@.service

	install -d ${D}${sbindir}
	install -m 0744 ${WORKDIR}/sdcard-mount.sh ${D}${sbindir}/sdcard-mount.sh
}


FILES:${PN} = "${base_libdir} ${systemd_system_unitdir} ${sbindir}"
