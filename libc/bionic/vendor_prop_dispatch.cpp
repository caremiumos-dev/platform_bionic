/*
 * Vendor (XTC) property-client dispatch hooks.
 *
 * The device's /system/lib/libnetd_client.so has an undefined reference to
 * __propClientDispatch (OBJECT, 28 bytes) and the vendor libc also exports
 * __propClientDispatchWrite (OBJECT, 16 bytes). A libc built from plain AOSP
 * lacks both, so vendor libraries fail to link with:
 *
 *   cannot locate symbol "__propClientDispatch" referenced by
 *   "/system/lib/libnetd_client.so"
 *
 * Provide the same data objects (size and visibility) so a libc built from
 * this tree is ABI-compatible with the vendor binaries. They are zero
 * initialized; the vendor client library owns their contents.
 */

#include <stdint.h>

extern "C" {

__attribute__((visibility("default")))
uint32_t __propClientDispatch[7]; /* 28 bytes, matches the vendor libc */

__attribute__((visibility("default")))
uint32_t __propClientDispatchWrite[4]; /* 16 bytes, matches the vendor libc */

}  // extern "C"
