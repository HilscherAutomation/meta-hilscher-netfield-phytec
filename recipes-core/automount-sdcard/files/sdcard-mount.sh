#!/bin/sh

# This script is called from systemd unit file to mount or unmount a MMC drive.

PATH="$PATH:/usr/bin:/usr/local/bin:/usr/sbin:/usr/local/sbin:/bin:/sbin"
log="logger -t sdcard-mount.sh -s "

usage()
{
    ${log} "Usage: $0 {add|remove} device_name (e.g. mmcblk0p1)"
    exit 1
}

if [[ $# -ne 2 ]]; then
    usage
fi

ACTION=$1
DEVBASE=$2
DEVICE="/dev/${DEVBASE}"

# See if this drive is already mounted, and if so where
MOUNT_POINT=$(mount | grep ${DEVICE} | awk '{ print $3 }')

DEV_LABEL=""

do_mount()
{
    if [[ -n ${MOUNT_POINT} ]]; then
        ${log} "Warning: ${DEVICE} is already mounted at ${MOUNT_POINT}"
        exit 1
    fi

    # Get info for this drive: $ID_FS_LABEL and $ID_FS_TYPE
    eval $(blkid -o udev ${DEVICE} | grep -i -e "ID_FS_LABEL" -e "ID_FS_TYPE")

    # Figure out a mount point to use
    LABEL=${ID_FS_LABEL}
    if grep -q " /mnt/${LABEL} " /etc/mtab; then
        # Already in use, make a unique one
        LABEL="${DEVBASE}-${LABEL}"
    fi
    DEV_LABEL="${LABEL}"

    # Use the device name in case the drive doesn't have label
    if [ -z ${DEV_LABEL} ]; then
        DEV_LABEL="${DEVBASE}"
    fi

    MOUNT_POINT="/mnt/extsd/${DEV_LABEL}"

    ${log} "Mount point: ${MOUNT_POINT}"

    mkdir -p ${MOUNT_POINT}

    # Global mount options
    OPTS="rw,relatime"

    # File system type specific mount options
    if [[ ${ID_FS_TYPE} == "vfat" ]]; then
        OPTS+=",users,gid=100,umask=000,shortname=mixed,utf8=1,flush"
    fi

    if ! mount -o ${OPTS} ${DEVICE} ${MOUNT_POINT}; then
        ${log} "Error mounting ${DEVICE} (status = $?)"
        rmdir "${MOUNT_POINT}"
        exit 1
    else
        # Track the mounted drives
        echo "$(date):${MOUNT_POINT}:${DEVBASE}" | cat >> "/var/log/sdcard-mount.track" 
    fi

    ${log} "Mounted ${DEVICE} at ${MOUNT_POINT}"
}

do_unmount()
{
    if [[ -z ${MOUNT_POINT} ]]; then
        ${log} "Warning: ${DEVICE} is not mounted"
    else
        umount -l ${DEVICE}
        ${log} "Unmounted ${DEVICE} from ${MOUNT_POINT}"
        /bin/rmdir "${MOUNT_POINT}"
        sed -i.bak "\@${MOUNT_POINT}@d" /var/log/sdcard-mount.track
    fi

    [ -z "$(ls /mnt/extsd)" ] && /bin/rmdir /mnt/extsd

}

case "${ACTION}" in
    add)
        do_mount
        ;;
    remove)
        do_unmount
        ;;
    *)
        usage
        ;;
esac
