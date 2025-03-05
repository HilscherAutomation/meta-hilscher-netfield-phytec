IMAGE_INSTALL += "automount-sdcard"

IMAGE_INSTALL += "${@bb.utils.contains('IMAGE_FEATURES', 'debug-tweaks', 'cifx-iomirror', '',d)}"
IMAGE_INSTALL += "${@bb.utils.contains('IMAGE_FEATURES', 'debug-tweaks', 'cifxsample', '',d)}"
