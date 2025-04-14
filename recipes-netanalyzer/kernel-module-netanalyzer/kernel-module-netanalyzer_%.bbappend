FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " file://fix_alignment_panic.patch"
