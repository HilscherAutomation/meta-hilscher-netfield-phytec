FILESEXTRAPATHS:prepend := "${THISDIR}/files:${THISDIR}/${BPN}-${PV}:"

# ----------
# PREEMPT-RT
# ----------
RT_PATCHES = " \
    https://mirrors.edge.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.160-rt77.patch.xz;name=rtpatch \
    file://enable_preempt_rt.cfg \
"
SRC_URI[rtpatch.sha256sum] = "938f198dd9061bf9fdd333d8b299b28663c7a3c8a842665f5f04e11e66a8a445"

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
