# Opt-in .deb packaging for bionic.
#   command make deb | deb-dev | deb-static
DEB_TOP := $(abspath $(CURDIR)/..)

DEB_PACKAGES := bionic
# 内核 UAPI 头单独成包（对应 Debian 的 linux-headers）
DEB_HEADERONLY_PACKAGES := linux-headers

# linux-headers 的版本跟随内核头版本（external/kernel-headers 的
# LINUX_VERSION_CODE），并加 -generic 后缀：Android 的 uapi 头兼容多个内核版本
KERNEL_VERSION_CODE := $(shell sed -n 's/^#define LINUX_VERSION_CODE \([0-9]*\)/\1/p' $(DEB_TOP)/external/kernel-headers/original/uapi/linux/version.h)
ifneq ($(strip $(KERNEL_VERSION_CODE)),)
DEB_VERSION_linux-headers := $(shell c=$(KERNEL_VERSION_CODE); echo $$((c/65536)).$$((c%65536/256)).$$((c%256)))-generic
else
DEB_VERSION_linux-headers := 4.10.0-generic
endif

# 运行时：libc / libm / libdl 三个 .so 打成一个 bionic 包
DEB_SO_bionic := libc libm libdl
DEB_BUILD_bionic := libc libm libdl

# 静态库模块名是 libc_ndk（NDK 风格静态 libc）
DEB_STATIC_MODULE_bionic := libc_ndk

# bionic-dev 只放 libc 自己的头（stdio.h/sys/... 与 machine/）
DEB_INCDIRCONTENTS_bionic := \
    libc/include \
    libc/arch-arm/include
DEB_DEV_DEPENDS_bionic := linux-headers (= $(DEB_VERSION_linux-headers))

# linux-headers：内核 uapi（linux/、asm-generic/、asm/，以及 compiler.h）
DEB_INCDIRS_linux-headers := \
    libc/kernel/uapi/linux \
    libc/kernel/uapi/asm-generic \
    libc/kernel/uapi/asm-arm/asm
DEB_INCDIRCONTENTS_linux-headers := libc/kernel/android/uapi

DEB_DESC_bionic := Android C library (bionic: libc, libm, libdl)
DEB_DESC_linux-headers := Linux UAPI headers (Android bionic kernel headers)

include $(DEB_TOP)/build/make/tools/deb/deb.mk
