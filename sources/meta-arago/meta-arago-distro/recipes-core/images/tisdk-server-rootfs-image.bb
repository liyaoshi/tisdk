# Arago TI SDK filesystem image

require arago-base-tisdk-image.bb

SPLASH = ""

IMAGE_INSTALL += "\
    packagegroup-arago-tisdk-addons \
    packagegroup-arago-tisdk-addons-extra \
    packagegroup-arago-tisdk-crypto \
    packagegroup-arago-tisdk-multimedia \
    packagegroup-arago-base-tisdk-server-extra \
    packagegroup-arago-tisdk-connectivity \
    packagegroup-arago-test-addons \
"

export IMAGE_BASENAME = "tisdk-server-rootfs-image"

# Disable ubi/ubifs as the filesystem requires more space than is
# available on the HW.
IMAGE_FSTYPES_remove = "ubifs ubi"
