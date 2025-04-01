FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " file://use_bytewise_memcmp.patch"
