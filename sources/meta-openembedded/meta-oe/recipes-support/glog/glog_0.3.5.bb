DESCRIPTION = "The glog library implements application-level logging. This \
library provides logging APIs based on C++-style streams and various helper \
macros."
HOMEPAGE = "https://github.com/google/glog"

LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM = "file://COPYING;md5=dc9db360e0bbd4e46672f3fd91dd6c4b"

DEPENDS = "libunwind"

SRC_URI = " \
    git://github.com/google/glog.git \
"

SRCREV = "3ba8976592274bc1f907c402ce22558011d6fc5e"

S = "${WORKDIR}/git"

inherit cmake

RDEPENDS_${PN} += "libunwind"

EXTRA_OECMAKE += "-DBUILD_SHARED_LIBS=ON"
