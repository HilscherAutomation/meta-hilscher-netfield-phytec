FILESEXTRAPATHS:prepend := "${THISDIR}/files:${THISDIR}/${BPN}-${PV}:"

# ----------
# PREEMPT-RT
# ----------
RT_PATCHES = " \
    file://patch-5.15.158-rt76.patch.gz \
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
