FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " \
	file://0002-wifi-cfg80211-Add-my-certificate.patch \
	file://0003-wifi-cfg80211-fix-certs-build-to-not-depend-on-file-.patch \
"
