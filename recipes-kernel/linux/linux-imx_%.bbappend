
require recipes-kernel/linux/netfield-linux.inc

do_kernel_configme() {
    :
}

addtask do_kernel_configme before do_configure after do_unpack_and_patch
