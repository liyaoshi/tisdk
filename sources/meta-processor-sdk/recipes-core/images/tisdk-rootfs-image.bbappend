PR_append = ".tisdk7"

IMAGE_INSTALL_append_ti43x = " \
	packagegroup-arago-tisdk-graphics \
	packagegroup-arago-tisdk-hmi \
	packagegroup-ros-ti \
	packagegroup-ros-world \
"

IMAGE_INSTALL_append_ti33x = " \
	packagegroup-arago-tisdk-graphics \
	packagegroup-arago-tisdk-hmi \
	packagegroup-ros-ti \
	packagegroup-ros-world \
"

IMAGE_INSTALL_append_omap-a15 = " \
	packagegroup-arago-tisdk-graphics \
	packagegroup-arago-tisdk-hmi \
"

IMAGE_INSTALL_append_k3 = " \
	packagegroup-arago-tisdk-graphics \
"
