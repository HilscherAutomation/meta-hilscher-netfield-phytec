FILESEXTRAPATHS:prepend := "${THISDIR}/files:${THISDIR}/linux-imx-5.15.71:"

SRC_URI:append = " \
	file://0002-wifi-cfg80211-Add-my-certificate.patch \
	file://0003-wifi-cfg80211-fix-certs-build-to-not-depend-on-file-.patch \
"

SRCREV_meta ?= "52fd26ad165fc5bef6e38651df39bf552e5bb845"

# ----------
# PREEMPT-RT
# ----------
RT_PATCHES = " \
    file://patch-5.15.71-rt51.patch.gz \
    file://enable_preempt_rt.cfg \
"

PV .= "${@bb.utils.contains('MACHINE_FEATURES', 'preempt-rt', '-rt', '', d)}"

SRC_URI:append = " \
    ${@bb.utils.contains('MACHINE_FEATURES', 'preempt-rt', d.getVar('RT_PATCHES', True), '', d)} \
"

LINUX_KERNEL_TYPE = "${@bb.utils.contains('MACHINE_FEATURES', 'preempt-rt', 'preempt-rt', 'standard',  d)}"

do_kernel_configme:append() {
    if [ "${@bb.utils.contains('MACHINE_FEATURES', 'preempt-rt', 'rt', '', d)}" = "rt" ]; then
        sed -i -e 's/CONFIG_PREEMPT=y/# CONFIG_PREEMPT is not set/' \
               -e 's/# CONFIG_PREEMPT_RT is not set/CONFIG_PREEMPT_RT=y/' ${B}/.config
    fi
}
# ----------
