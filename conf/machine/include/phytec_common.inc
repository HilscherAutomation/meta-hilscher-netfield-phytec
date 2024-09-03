OEROOT := "${TOPDIR}"

#############################################################################
IMAGE_CLASSES:append = " hilscher_image_types"
IMAGE_FSTYPES += "squashfs wic.bz2 swu licenses.tar.bz2"

#############################################################################
# Kernel
#############################################################################
KERNEL_CLASSES:append = " kernel-fitimage"
KERNEL_IMAGETYPES:append = " fitImage"
PREFERRED_VERSION_linux-imx = "${@bb.utils.contains('MACHINE_FEATURES', 'preempt-rt', '5.15.71-rt', '5.15.71', d)}"

#############################################################################
# Preferred components/settings
#############################################################################
INITRAMFS_IMAGE ?= "core-image-minimal-initramfs"
HILSCHER_RESCUE_IMAGE ??= "hilscher-rescue-image"

#############################################################################
# Keys
#############################################################################
PLATFORM_SIGN ??= "1"

KEYS_DIR .= "${TOPDIR}/keys"
KEYS_IMAGE_SIGN_PRIV ??= "${KEYS_DIR}/debug.key"
KEYS_IMAGE_SIGN_CERT ??= "${KEYS_DIR}/debug.crt"
KEYS_IMAGE_SIGN_CERT_DER ??= "${KEYS_DIR}/debug.crt.der"

FIT_HASH_ALG = "sha256"
FIT_SIGN_ALG = "rsa4096"

#############################################################################
# Bootloader
#############################################################################
UBOOT_SIGN_ENABLE = "1"
UBOOT_SIGN_KEYDIR = "${KEYS_DIR}"
UBOOT_SIGN_KEYNAME = "debug"
UBOOT_MKIMAGE_DTCOPTS = "-I dts -O dtb -p 2000"

#############################################################################
# Contents of boot partition (excluding rootfs)
#############################################################################
IMAGE_BOOT_FILES = " \
    ${IMAGE_BOOTLOADER};boot.bin \
    boot-script-fit/fitImage-boot-menu.scr;boot-fit.scr \
"

#############################################################################
# WIC images
#############################################################################
WIC_IMAGE_DEPENDENCIES:append = " boot-script-fit"
IMAGE_BOOTLOADER = "imx-boot"
WICVARS:append = " IMAGE_BOOTLOADER"
# Use WKS_FILE as it is need by initrd-api-part-cfg
WKS_FILE = "hilscher-gpt-boot-rescue-system-lvm.wks.in"
WKS_FILES:${MACHINE} = "${WKS_FILE}"

WIC_BOOT_PART_CONTENT ??= ""
WIC_RESCUE_PART_CONTENT ??= ""
WIC_SYSTEM_PART_CONTENT ??= ""

#############################################################################
# SWU images
#############################################################################
SWU_SCRIPTS += "swupdate/helper.lua;helper.lua"

SWU_RSYNC_PART_UPDATE ??= "boot system"
SWU_BOOT_PART_CONTENT ??= "${IMAGE_BOOT_FILES}"
SWU_SYSTEM_PART_CONTENT ??= "${IMAGE_LINK_NAME}.squashfs nboot.cfg fitImage"

#############################################################################
# System Partitioning
#############################################################################
# Physical device of system partitions
PHYSICAL_SYSTEM_DEVICE ??= "/dev/mmcblk0 /dev/mmcblk1"
# Size of boot partition
IMAGE_PART_BOOT_SIZE ??= "64M"
# Size of rescue partition
IMAGE_PART_RESCUE_SIZE ??= "128M"
# Size of system partition
IMAGE_PART_SYSTEM_SIZE ??= "1G"
# Size of data partition
IMAGE_PART_DATA_SIZE ??= "max"
# Size of logical volume "data" in userdata partition
PART_DATA_LV_DATA_SIZE ??= "60%VG"
# Size of logical volume "backup" in userdata partition
PART_DATA_LV_BACKUP_SIZE ??= "35%VG"
# Size of logical volume "snapshot" in userdata partition
PART_DATA_LV_SNAPSHOT_SIZE ??= "5%VG"

#############################################################################
# rootfs overlay
#############################################################################
HILSCHER_OVERLAY ??= "/dev/mapper/data-data"
HILSCHER_OVERLAYTARGETS ??= "${NETIOT_OVERLAY_DIRS}"
