From: David Dillow <dave@thedillows.org>
Date: Wed, 04 Feb 2004 06:41:33 +0000
Subject: AIO userspace for sparc 32-bit userspace
Message-Id: <1075876892.5040.58.camel@ori.thedillows.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-H+ADZUM0jldO/YCkreOI"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-H+ADZUM0jldO/YCkreOI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The attached patch adds sparc support to libaio. It works with sparc and
the 32 bit userland of sparc64.

This is only the userland side, kernel patches are needed, as the system
call numbers are duplicated.

To get the base libaio tarball, go to
ftp://ftp.kernel.org/pub/linux/kernel/people/bcrl/aio

It passes all test cases, except case 5.t, where it expects an -EFAULT,
but sees a -EHOSTDOWN. The message with the kernel patch points towards
the problem.

Enjoy!

Dave

--=-H+ADZUM0jldO/YCkreOI
Content-Disposition: attachment; filename=aio.patch
Content-Type: text/plain; name=aio.patch; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

--- libaio-0.3.92/src/libaio.h	2002-09-16 18:45:18.000000000 -0400
+++ libaio-new/src/libaio.h	2004-01-23 10:26:09.000000000 -0500
@@ -47,6 +47,10 @@
 #define PADDED(x, y)	x; unsigned y
 #define PADDEDptr(x, y)	x; unsigned y
 #define PADDEDul(x, y)	unsigned long x; unsigned y
+#elif defined(__sparc__) /* big endian, 32 bits */
+#define PADDED(x, y)	unsigned y; x
+#define PADDEDptr(x, y)	unsigned y; x
+#define PADDEDul(x, y)	unsigned y; unsigned long x
 #elif defined(__ia64__) || defined(__x86_64__)
 #define PADDED(x, y)	x, y
 #define PADDEDptr(x, y)	x
--- libaio-0.3.92/src/syscall.h	2002-09-13 19:07:20.000000000 -0400
+++ libaio-new/src/syscall.h	2004-01-22 01:24:51.000000000 -0500
@@ -10,6 +10,8 @@
 #include "syscall-x86_64.h"
 #elif defined(__ia64__)
 #include "syscall-ia64.h"
+#elif defined(__sparc__)
+#include "syscall-sparc.h"
 #else
 #error "add syscall-arch.h"
 #endif
--- libaio-0.3.92/src/syscall-sparc.h	1969-12-31 19:00:00.000000000 -0500
+++ libaio-new/src/syscall-sparc.h	2004-02-04 01:32:50.000000000 -0500
@@ -0,0 +1,104 @@
+/* GPL'd, as this is from the kernel, asm-sparc/unistd.h
+ */
+#define __NR_io_setup		268
+#define __NR_io_destroy		232
+#define __NR_io_submit		269
+#define __NR_io_cancel		270
+#define __NR_io_getevents	271
+
+#define io_syscall1(type,name,type1,arg1) \
+type name(type1 arg1) \
+{ \
+long __res; \
+register long __g1 __asm__ ("g1") =3D __NR_##name; \
+register long __o0 __asm__ ("o0") =3D (long)(arg1); \
+__asm__ __volatile__ ("t 0x10\n\t" \
+		      "bcc 1f\n\t" \
+		      "mov %%o0, %0\n\t" \
+		      "sub %%g0, %%o0, %0\n\t" \
+		      "1:\n\t" \
+		      : "=3Dr" (__res), "=3D&r" (__o0) \
+		      : "1" (__o0), "r" (__g1) \
+		      : "cc"); \
+	return (type) __res; \
+}
+
+#define io_syscall2(type,name,type1,arg1,type2,arg2) \
+type name(type1 arg1,type2 arg2) \
+{ \
+long __res; \
+register long __g1 __asm__ ("g1") =3D __NR_##name; \
+register long __o0 __asm__ ("o0") =3D (long)(arg1); \
+register long __o1 __asm__ ("o1") =3D (long)(arg2); \
+__asm__ __volatile__ ("t 0x10\n\t" \
+		      "bcc 1f\n\t" \
+		      "mov %%o0, %0\n\t" \
+		      "sub %%g0, %%o0, %0\n\t" \
+		      "1:\n\t" \
+		      : "=3Dr" (__res), "=3D&r" (__o0) \
+		      : "1" (__o0), "r" (__o1), "r" (__g1) \
+		      : "cc"); \
+	return (type) __res; \
+}
+
+#define io_syscall3(type,name,type1,arg1,type2,arg2,type3,arg3) \
+type name(type1 arg1,type2 arg2,type3 arg3) \
+{ \
+long __res; \
+register long __g1 __asm__ ("g1") =3D __NR_##name; \
+register long __o0 __asm__ ("o0") =3D (long)(arg1); \
+register long __o1 __asm__ ("o1") =3D (long)(arg2); \
+register long __o2 __asm__ ("o2") =3D (long)(arg3); \
+__asm__ __volatile__ ("t 0x10\n\t" \
+		      "bcc 1f\n\t" \
+		      "mov %%o0, %0\n\t" \
+		      "sub %%g0, %%o0, %0\n\t" \
+		      "1:\n\t" \
+		      : "=3Dr" (__res), "=3D&r" (__o0) \
+		      : "1" (__o0), "r" (__o1), "r" (__o2), "r" (__g1) \
+		      : "cc"); \
+	return (type) __res; \
+}
+
+#define io_syscall4(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4)=
 \
+type name (type1 arg1, type2 arg2, type3 arg3, type4 arg4) \
+{ \
+long __res; \
+register long __g1 __asm__ ("g1") =3D __NR_##name; \
+register long __o0 __asm__ ("o0") =3D (long)(arg1); \
+register long __o1 __asm__ ("o1") =3D (long)(arg2); \
+register long __o2 __asm__ ("o2") =3D (long)(arg3); \
+register long __o3 __asm__ ("o3") =3D (long)(arg4); \
+__asm__ __volatile__ ("t 0x10\n\t" \
+		      "bcc 1f\n\t" \
+		      "mov %%o0, %0\n\t" \
+		      "sub %%g0, %%o0, %0\n\t" \
+		      "1:\n\t" \
+		      : "=3Dr" (__res), "=3D&r" (__o0) \
+		      : "1" (__o0), "r" (__o1), "r" (__o2), "r" (__o3), "r" (__g1) \
+		      : "cc"); \
+	return (type) __res; \
+}=20
+
+#define io_syscall5(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4,=
 \
+	  type5,arg5) \
+type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5) \
+{ \
+long __res; \
+register long __g1 __asm__ ("g1") =3D __NR_##name; \
+register long __o0 __asm__ ("o0") =3D (long)(arg1); \
+register long __o1 __asm__ ("o1") =3D (long)(arg2); \
+register long __o2 __asm__ ("o2") =3D (long)(arg3); \
+register long __o3 __asm__ ("o3") =3D (long)(arg4); \
+register long __o4 __asm__ ("o4") =3D (long)(arg5); \
+__asm__ __volatile__ ("t 0x10\n\t" \
+		      "bcc 1f\n\t" \
+		      "mov %%o0, %0\n\t" \
+		      "sub %%g0, %%o0, %0\n\t" \
+		      "1:\n\t" \
+		      : "=3Dr" (__res), "=3D&r" (__o0) \
+		      : "1" (__o0), "r" (__o1), "r" (__o2), "r" (__o3), "r" (__o4), "r" =
(__g1) \
+		      : "cc"); \
+	return (type) __res; \
+}
+

--=-H+ADZUM0jldO/YCkreOI--
