DESCRIPTION = "Script to warn users of GPLv3 content on the target file system at boot time"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://print-gplv3-packages.sh;beginline=2;endline=18;md5=d134d0d385c53f9201a270fef8448f29"

PR = "r3"

S = "${WORKDIR}"

INITSCRIPT_NAME = "gplv3-notice"
INITSCRIPT_PARAMS = "defaults 99"

inherit allarch update-rc.d systemd

SRC_URI = " file://print-gplv3-packages.sh \
            file://gplv3-notice.service"

do_install(){
	install -d ${D}${sysconfdir}/init.d
	install -m 0755 ${S}/print-gplv3-packages.sh ${D}${sysconfdir}/init.d/gplv3-notice

	install -d ${D}${systemd_system_unitdir}
	install -m0644 ${WORKDIR}/gplv3-notice.service ${D}${systemd_system_unitdir}
}

SYSTEMD_SERVICE_${PN} = "gplv3-notice.service"
