# Opt-in .deb packaging for bionic.
#   command make deb | deb-dev | deb-static
DEB_TOP := $(abspath $(CURDIR)/..)

DEB_PACKAGES := bionic

# 运行时：libc / libm / libdl 三个 .so 打成一个 bionic 包
DEB_SO_bionic := libc libm libdl
DEB_BUILD_bionic := libc libm libdl

# 静态库模块名是 libc_ndk（NDK 风格静态 libc）
DEB_STATIC_MODULE_bionic := libc_ndk

# 头文件：libc 公共头 + arm 架构头铺到 /system/include；
# kernel uapi 的 linux/、asm-generic/、asm/ 按原目录名保留
DEB_INCDIRCONTENTS_bionic := \
    libc/include \
    libc/arch-arm/include \
    libc/kernel/android/uapi
DEB_INCDIRS_bionic := \
    libc/kernel/uapi/linux \
    libc/kernel/uapi/asm-generic \
    libc/kernel/uapi/asm-arm/asm

DEB_DESC_bionic := Android C library (bionic: libc, libm, libdl)

include $(DEB_TOP)/build/make/tools/deb/deb.mk
