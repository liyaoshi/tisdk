INHIBIT_PACKAGE_DEBUG_SPLIT = "0"
INHIBIT_PACKAGE_STRIP = "0"

ALLOW_EMPTY_${PN}-utils = "1"
ALLOW_EMPTY_ldd = "1"

ALLOW_EMPTY_libstdc++ = "1"
ALLOW_EMPTY_libgomp = "1"

PR_append = ".arago36"

PROVIDES += "virtual/libc-locale"

RPROVIDES_${PN}-staticdev += "glibc-staticdev"

PACKAGES := "${@oe.utils.str_filter_out('libgcc-dev', '${PACKAGES}', d)}"
PACKAGES =+ "libgcc-dev"

RDEPENDS_${PN}-utils = ""

RDEPENDS_tzcode += "bash"
RDEPENDS_ldd += "bash"
RDEPENDS_libasan += "libstdc++"
RDEPENDS_libubsan += "libstdc++"

PKGV = "${ELT_VER_LIBC}"
PKGV_glibc-thread-db = "${ELT_VER_LIBC}"

FILES_${PN} = "${libc_baselibs} ${libexecdir}/* ${@bb.utils.contains('DISTRO_FEATURES', 'ldconfig', '${base_sbindir}/ldconfig ${sysconfdir}/ld.so.conf', '', d)}"
FILES_${PN} += "\
	${libdir}/bin \
	${libdir}/locale \
	${libdir}/gconv/gconv-modules \
	${datadir}/zoneinfo \
	${base_libdir}/libcrypt*.so.* \
	${base_libdir}/libcrypt-*.so \
	${base_libdir}/libc.so.* \
	${libdir}/libc.so.* \
	${base_libdir}/libc-*.so \
	${base_libdir}/libm*.so.* \
	${base_libdir}/libm-*.so \
	${base_libdir}/ld*.so.* \
	${base_libdir}/ld-*.so \
	${base_libdir}/libpthread*.so.* \
	${base_libdir}/libpthread-*.so \
	${base_libdir}/libresolv*.so.* \
	${base_libdir}/libresolv-*.so \
	${base_libdir}/librt*.so.* \
	${base_libdir}/librt-*.so \
	${base_libdir}/libutil*.so.* \
	${base_libdir}/libutil-*.so \
	${base_libdir}/libnsl*.so.* \
	${base_libdir}/libnsl-*.so \
	${base_libdir}/libnss_files*.so.* \
	${base_libdir}/libnss_files-*.so \
	${base_libdir}/libnss_compat*.so.* \
	${base_libdir}/libnss_compat-*.so \
	${base_libdir}/libnss_dns*.so.* \
	${base_libdir}/libnss_dns-*.so \
	${base_libdir}/libnss_nis*.so.* \
	${base_libdir}/libnss_nisplus-*.so \
	${base_libdir}/libnss_nisplus*.so.* \
	${base_libdir}/libnss_nis-*.so \
	${base_libdir}/libnss_hesiod*.so.* \
	${base_libdir}/libnss_hesiod-*.so \
	${base_libdir}/libdl*.so.* \
	${base_libdir}/libdl-*.so \
	${base_libdir}/libanl*.so.* \
	${base_libdir}/libanl-*.so \
	${base_libdir}/libBrokenLocale*.so.* \
	${base_libdir}/libBrokenLocale-*.so \
	${base_libdir}/libcidn*.so.* \
	${base_libdir}/libcidn-*.so \
	${base_libdir}/libmemusage.so \
	${base_libdir}/libpcprofile.so \
"

FILES_linux-libc-headers = ""

FILES_linux-libc-headers-dev = "\
	${includedir}/asm* \
	${includedir}/linux \
	${includedir}/mtd \
	${includedir}/rdma \
	${includedir}/scsi \
	${includedir}/sound \
	${includedir}/video \
"

FILES_libgcc-dev += "\
	${libdir}/libgcc.a \
"

FILES_libstdc++-dev += "\
	/include/c++ \
"

FILES_${PN}-dbg_remove = "${base_libdir}/debug"

FILES_libstdc++-dbg = "\
	${base_libdir}/debug/libstdc++*.* \
"

PRIVATE_LIBS_libstdc++-dbg = "libstdc++.so.6"

FILES_libgomp-dev += "\
	${libdir}/gcc/${TARGET_SYS}/${ELT_VER_GCC}/include/omp.h \
	${libdir}/gcc/${ELT_TARGET_SYS} \
"

ELT_LIC_LIBC ?= ""
ELT_LIC_GCC ?= ""
ELT_LIC_RLE ?= ""
ELT_LIC_GDB ?= ""
ELT_LIC_BFD ?= ""
ELT_LICENSE ?= "MIT"

LICENSE = "${ELT_LICENSE}"
LICENSE_ldd = "${ELT_LIC_LIBC}"
LICENSE_glibc = "${ELT_LIC_LIBC}"
LICENSE_glibc-thread-db = "${ELT_LIC_LIBC}"
LICENSE_libgcc = "${ELT_LIC_RLE}"
LICENSE_libgcc-dev = "${ELT_LIC_RLE}"
LICENSE_libstdc++ = "${ELT_LIC_RLE}"
LICENSE_libstdc++-dev = "${ELT_LIC_RLE}"
LICENSE_libstdc++-staticdev = "${ELT_LIC_RLE}"
LICENSE_gdbserver = "${ELT_LIC_GDB}"
#LICENSE_binutils-dev = "${ELT_LIC_BFD}"

do_install_append() {
	sed -i -e "s# /lib/${ELT_TARGET_SYS}# ../../lib#g" -e "s# /usr/lib/${ELT_TARGET_SYS}# .#g" -e "s# /lib/ld-linux# ../../lib/ld-linux#g" ${D}${libdir}/libc.so
	sed -i -e "s# /lib/# ../../lib/#g" -e "s# /usr/lib/# ./#g" ${D}${libdir}/libc.so

	sed -i -e "s# /lib/${ELT_TARGET_SYS}# ../../lib#g" -e "s# /usr/lib/${ELT_TARGET_SYS}# .#g" ${D}${libdir}/libpthread.so
	sed -i -e "s# /lib/# ../../lib/#g" -e "s# /usr/lib/# ./#g" ${D}${libdir}/libpthread.so

	if [ -d ${TOOLCHAIN_PATH}/${ELT_TARGET_SYS}/libc/${bindir} ]; then
		install -d ${D}${bindir}
		cp -a ${TOOLCHAIN_PATH}/${ELT_TARGET_SYS}/libc/${bindir}/* ${D}${bindir}
	fi

	install -d ${D}${base_sbindir}
	cp -a ${TOOLCHAIN_PATH}/${ELT_TARGET_SYS}/libc/${base_sbindir}/ldconfig ${D}${base_sbindir}/
	install -d ${D}${sysconfdir}
	echo -e "/lib\n/usr/lib" >> ${D}${sysconfdir}/ld.so.conf

	install -d ${D}/include
	install -d ${D}${includedir}
	cp -a ${TOOLCHAIN_PATH}/${ELT_TARGET_SYS}/include/* ${D}${includedir}
	if [ ${ELT_TARGET_SYS} != ${TARGET_SYS} ]; then
		ln -sf ${ELT_TARGET_SYS} ${D}${includedir}/c++/${ELT_VER_GCC}/${TARGET_SYS}
	fi
	ln -sf ../usr/include/c++ ${D}/include/c++

	install -d ${D}${libdir}/gcc/${TARGET_SYS}/${ELT_VER_GCC}/include
	cp -a ${TOOLCHAIN_PATH}/${base_libdir}/gcc/${ELT_TARGET_SYS}/${ELT_VER_GCC}/include/omp.h ${D}${libdir}/gcc/${TARGET_SYS}/${ELT_VER_GCC}/include
	if [ ${ELT_TARGET_SYS} != ${TARGET_SYS} ]; then
		ln -sf ${TARGET_SYS} ${D}${libdir}/gcc/${ELT_TARGET_SYS}
	fi

	cp -a ${TOOLCHAIN_PATH}/${base_libdir}/gcc/${ELT_TARGET_SYS}/${ELT_VER_GCC}/libgcc.a ${D}${libdir}
	cp -a ${TOOLCHAIN_PATH}/${base_libdir}/gcc/${ELT_TARGET_SYS}/${ELT_VER_GCC}/crt*.o ${D}${libdir}
}

# Latest Linaro toolchain 2017.11 comes with glibc 2.25, while OE-Core provides 2.26
# Need to override armmultilib from OE-Core here to not fail on new bits/pthreadtypes-arch.h
# that did not exist in glibc 2.25
do_install_armmultilib () {

	oe_multilib_header bits/endian.h bits/fcntl.h bits/fenv.h bits/fp-fast.h bits/hwcap.h bits/ipc.h bits/link.h bits/wordsize.h
	oe_multilib_header bits/local_lim.h bits/mman.h bits/msq.h bits/pthreadtypes.h bits/sem.h  bits/semaphore.h bits/setjmp.h
	oe_multilib_header bits/shm.h bits/sigstack.h bits/stat.h bits/statfs.h bits/typesizes.h

	oe_multilib_header fpu_control.h gnu/lib-names.h gnu/stubs.h ieee754.h

	oe_multilib_header sys/elf.h sys/procfs.h sys/ptrace.h sys/ucontext.h sys/user.h
}
