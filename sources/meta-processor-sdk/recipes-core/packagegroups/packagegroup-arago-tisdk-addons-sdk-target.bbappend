PR_append = "-tisdk34"

UTILS_append_ti33x = " \
    opencv-dev \
"

UTILS_append_ti43x = " \
    opencv-dev \
"

UTILS_append_omap-a15 = " \
    opencv-dev \
"

UTILS_append_keystone = " \
    opencv-dev \
"

EXTRA_LIBS_append_keystone = " \
    mmap-lld-staticdev \
"
#    ipsecmgr-dev
#    ipsecmgr-staticdev

#EXTRA_LIBS_append_k2hk = " \
#    netapi-dev \
#    netapi-staticdev \
#"

#EXTRA_LIBS_append_k2l = " \
#    netapi-dev \
#    netapi-staticdev \
#"

#EXTRA_LIBS_append_k2e-evm = " \
#    netapi-dev \
#    netapi-staticdev \
#"

EXTRA_LIBS_append_k2g-evm = " \
    icss-emac-lld-dev \
    icss-emac-lld-staticdev \
"

EXTRA_LIBS_append_am57xx-evm = " \
    osal-dev \
    osal-staticdev \
    pruss-lld-dev \
    pruss-lld-staticdev \
    icss-emac-lld-dev \
    icss-emac-lld-staticdev \
"

EXTRA_LIBS_append_am335x-evm = " \
    osal-dev \
    osal-staticdev \
    pruss-lld-dev \
    pruss-lld-staticdev \
    icss-emac-lld-dev \
    icss-emac-lld-staticdev \
    pru-icss-dev \
    pru-icss-staticdev \
"

EXTRA_LIBS_append_am437x-evm = " \
    osal-dev \
    osal-staticdev \
    pruss-lld-dev \
    pruss-lld-staticdev \
    icss-emac-lld-dev \
    icss-emac-lld-staticdev \
"

EXTRA_LIBS_append_dra7xx = " \
    tiovx-lib-host-dev \
    tiovx-lib-host-staticdev \
    tiovx-sys-iface \
"

NEO_AI_PACKAGES = "neo-ai-dlr-dev"
NEO_AI_PACKAGES_armv5 = ""

RDEPENDS_${PN}_append = " ${NEO_AI_PACKAGES}"
