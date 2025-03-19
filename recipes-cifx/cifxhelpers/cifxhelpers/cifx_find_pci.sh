#!/bin/sh

idx=0

for devdir in $(find /sys/bus/pci/devices/* -exec readlink -f {} \;); do
    vendor_id=$(cat $devdir/vendor)
    if [ "$vendor_id" = "0x15cf" ]; then
        device_id=$(cat $devdir/device)
        subsystem_device_id=$(cat $devdir/subsystem_device)
        subsystem_vendor_id=$(cat $devdir/subsystem_vendor)
        if [ "$device_id" = "0x0000" -a "$subsystem_device_id" = "0x0000" -a "$subsystem_vendor_id" = "0x0000" ]; then
            echo "cifX$idx;$devdir"
            idx=$((idx + 1))
        fi
    fi
done
