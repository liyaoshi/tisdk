SUMMARY = "Stage provided unwind.h header being used by target gcc installation"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

PR = "r1"

inherit cross

PN = "external-linaro-toolchain-cross-${TARGET_ARCH}"
BPN = "external-linaro-toolchain"

INHIBIT_DEFAULT_DEPS = "1"
INHIBIT_AUTOTOOLS_DEPS = "1"

do_install() {
	install -d ${D}${libdir}/gcc/${TARGET_SYS}/${ELT_VER_GCC}/include/
	cp -a ${TOOLCHAIN_PATH}/lib/gcc/${ELT_TARGET_SYS}/${ELT_VER_GCC}/include/unwind.h ${D}/${libdir}/gcc/${TARGET_SYS}/${ELT_VER_GCC}/include/
}
