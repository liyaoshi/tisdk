SUMMARY = "Jailhouse inmate example applications"
HOMEPAGE = "http://git.ti.com/processor-sdk/jailhouse-inmate"
LICENSE = "BSD"

LIC_FILES_CHKSUM = "file://${WORKDIR}/git/baremetal/soc/am572x/rules.mk;endline=32;md5=bb11cef62f47eb4facbcf1fde4479719"

BRANCH = "master"
SRC_URI = "git://git.ti.com/processor-sdk/jailhouse-inmate.git;branch=${BRANCH}"
SRCREV = "6e674ce7d6f160e93e0288ded486705812f3689e"

PV = "1.0"
PR = "r8"

require recipes-ti/includes/tisdk-paths.inc

DEPENDS = "gcc-arm-none-eabi-native \
           board-rtos \
           uart-lld-rtos \
           gpio-lld-rtos \
           i2c-lld-rtos \
           common-csl-ip-rtos \
           osal-rtos \
           ti-xdctools-native \
           ti-sysbios \
"

S = "${WORKDIR}/git"

PACKAGE_ARCH = "${MACHINE_ARCH}"

EXTRA_OEMAKE += "PDK_INSTALL_PATH=${PDK_INSTALL_DIR}/packages \
                 XDC_INSTALL_PATH=${XDC_INSTALL_DIR} \
                 BIOS_INSTALL_PATH=${SYSBIOS_INSTALL_DIR} \
                 TOOLCHAIN_PATH_A15=${GCC_ARM_NONE_TOOLCHAIN} \
                 PATH=${GCC_ARM_NONE_TOOLCHAIN}/bin:${PATH} \
                 ROOT_DIR=${S} \
"
export PDK_INSTALL_PATH="${PDK_INSTALL_DIR}/packages"

# Copied from meta-ti/recipes-kernel/jailhouse/jailhouse_git.bb
JH_DATADIR ?= "${datadir}/jailhouse"
JH_EXEC_DIR ?= "${libexecdir}/jailhouse"
CELL_DIR ?= "${JH_DATADIR}/cells"
CELLCONF_DIR ?= "${JH_DATADIR}/configs"
INMATES_DIR ?= "${JH_DATADIR}/inmates"

do_install() {
    # Install the binary for Linux
    install -d ${D}${INMATES_DIR}
    make INSTALL_DIR=${D}${INMATES_DIR} install
}

FILES_${PN} += "${INMATES_DIR}"

CREATE_SRCIPK = "1"
SRCIPK_INSTALL_DIR = "${PROC_SDK_INSTALL_DIR_RECIPE}/demos/jailhouse-inmate"
