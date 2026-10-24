# Opt-in .deb packaging for bionic.
#   command make deb | deb-dev | deb-static
DEB_TOP := $(abspath $(CURDIR)/..)

DEB_PACKAGES := bionic
# 内核 UAPI 头单独成包（对应 Debian 的 linux-headers）
DEB_HEADERONLY_PACKAGES := linux-headers

# 运行时：libc / libm / libdl 三个 .so 打成一个 bionic 包
DEB_SO_bionic := libc libm libdl
DEB_BUILD_bionic := libc libm libdl

# 静态库模块名是 libc_ndk（NDK 风格静态 libc）
DEB_STATIC_MODULE_bionic := libc_ndk

# bionic-dev 只放 libc 自己的头（stdio.h/sys/... 与 machine/）
DEB_INCDIRCONTENTS_bionic := \
    libc/include \
    libc/arch-arm/include
DEB_DEV_DEPENDS_bionic := linux-headers (= @VERSION@)

# linux-headers：内核 uapi（linux/、asm-generic/、asm/，以及 compiler.h）
DEB_INCDIRS_linux-headers := \
    libc/kernel/uapi/linux \
    libc/kernel/uapi/asm-generic \
    libc/kernel/uapi/asm-arm/asm
DEB_INCDIRCONTENTS_linux-headers := libc/kernel/android/uapi

DEB_DESC_bionic := Android C library (bionic: libc, libm, libdl)
DEB_DESC_linux-headers := Linux UAPI headers (Android bionic kernel headers)

include $(DEB_TOP)/build/make/tools/deb/deb.mk
