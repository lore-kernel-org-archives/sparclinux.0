From: Palmer Dabbelt <palmer@dabbelt.com>
Date: Tue, 06 Jun 2017 19:10:21 +0000
Subject: [PATCH 5/7] sh: Use lib/ashldi3,ashrdi3,lshrdi3}.c
Message-Id: <20170606191023.24581-6-palmer@dabbelt.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170523220546.16758-1-palmer@dabbelt.com>
 <20170606191023.24581-1-palmer@dabbelt.com>
In-Reply-To: <20170606191023.24581-1-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: monstr@monstr.eu, ralf@linux-mips.org, liqin.linux@gmail.com, lennox.wu@gmail.com, ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, geert@linux-m68k.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>

These files are functionally identical to the shared copies that I
recently added.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/sh/Kconfig                  |  3 +++
 arch/sh/boot/compressed/Makefile |  6 +++---
 arch/sh/lib/Makefile             |  4 +---
 arch/sh/lib/ashldi3.c            | 29 -----------------------------
 arch/sh/lib/ashrdi3.c            | 31 -------------------------------
 arch/sh/lib/libgcc.h             | 25 -------------------------
 arch/sh/lib/lshrdi3.c            | 29 -----------------------------
 7 files changed, 7 insertions(+), 120 deletions(-)
 delete mode 100644 arch/sh/lib/ashldi3.c
 delete mode 100644 arch/sh/lib/ashrdi3.c
 delete mode 100644 arch/sh/lib/libgcc.h
 delete mode 100644 arch/sh/lib/lshrdi3.c

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index ee086958b2b2..49b98f74d7a0 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -48,6 +48,9 @@ config SUPERH
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_NMI
+	select GENERIC_ASHLDI3
+	select GENERIC_ASHRDI3
+	select GENERIC_LSHRDI3
 	help
 	  The SuperH is a RISC processor targeted for use in embedded systems
 	  and consumer electronics; it was also used in the Sega Dreamcast
diff --git a/arch/sh/boot/compressed/Makefile b/arch/sh/boot/compressed/Makefile
index c4c47ea9fa94..45a8e1349103 100644
--- a/arch/sh/boot/compressed/Makefile
+++ b/arch/sh/boot/compressed/Makefile
@@ -38,10 +38,10 @@ LDFLAGS_vmlinux := --oformat $(ld-bfd) -Ttext $(IMAGE_OFFSET) -e startup \
 #
 # Pull in the necessary libgcc bits from the in-kernel implementation.
 #
-lib1funcs-$(CONFIG_SUPERH32)	:= ashiftrt.S ashldi3.c ashrsi3.S ashlsi3.S \
-				   lshrsi3.S
+lib1funcs-$(CONFIG_SUPERH32)	:= ashiftrt.S ashrsi3.S ashlsi3.S lshrsi3.S
 lib1funcs-obj			:= \
-	$(addsuffix .o, $(basename $(addprefix $(obj)/, $(lib1funcs-y))))
+	$(addsuffix .o, $(basename $(addprefix $(obj)/, $(lib1funcs-y)))) \
+	$(srctree)/lib/ashldi3.o
 
 lib1funcs-dir		:= $(srctree)/arch/$(SRCARCH)/lib
 ifeq ($(BITS),64)
diff --git a/arch/sh/lib/Makefile b/arch/sh/lib/Makefile
index 3baff31e58cf..971d9ac1e068 100644
--- a/arch/sh/lib/Makefile
+++ b/arch/sh/lib/Makefile
@@ -6,9 +6,7 @@ lib-y  = delay.o memmove.o memchr.o \
 	 checksum.o strlen.o div64.o div64-generic.o
 
 # Extracted from libgcc
-obj-y += movmem.o ashldi3.o ashrdi3.o lshrdi3.o \
-	 ashlsi3.o ashrsi3.o ashiftrt.o lshrsi3.o \
-	 udiv_qrnnd.o
+obj-y += movmem.o ashlsi3.o ashrsi3.o ashiftrt.o lshrsi3.o udiv_qrnnd.o
 
 udivsi3-y			:= udivsi3_i4i-Os.o
 
diff --git a/arch/sh/lib/ashldi3.c b/arch/sh/lib/ashldi3.c
deleted file mode 100644
index beb80f316095..000000000000
--- a/arch/sh/lib/ashldi3.c
+++ /dev/null
@@ -1,29 +0,0 @@
-#include <linux/module.h>
-
-#include "libgcc.h"
-
-long long __ashldi3(long long u, word_type b)
-{
-	DWunion uu, w;
-	word_type bm;
-
-	if (b = 0)
-		return u;
-
-	uu.ll = u;
-	bm = 32 - b;
-
-	if (bm <= 0) {
-		w.s.low = 0;
-		w.s.high = (unsigned int) uu.s.low << -bm;
-	} else {
-		const unsigned int carries = (unsigned int) uu.s.low >> bm;
-
-		w.s.low = (unsigned int) uu.s.low << b;
-		w.s.high = ((unsigned int) uu.s.high << b) | carries;
-	}
-
-	return w.ll;
-}
-
-EXPORT_SYMBOL(__ashldi3);
diff --git a/arch/sh/lib/ashrdi3.c b/arch/sh/lib/ashrdi3.c
deleted file mode 100644
index c884a912b660..000000000000
--- a/arch/sh/lib/ashrdi3.c
+++ /dev/null
@@ -1,31 +0,0 @@
-#include <linux/module.h>
-
-#include "libgcc.h"
-
-long long __ashrdi3(long long u, word_type b)
-{
-	DWunion uu, w;
-	word_type bm;
-
-	if (b = 0)
-		return u;
-
-	uu.ll = u;
-	bm = 32 - b;
-
-	if (bm <= 0) {
-		/* w.s.high = 1..1 or 0..0 */
-		w.s.high -		    uu.s.high >> 31;
-		w.s.low = uu.s.high >> -bm;
-	} else {
-		const unsigned int carries = (unsigned int) uu.s.high << bm;
-
-		w.s.high = uu.s.high >> b;
-		w.s.low = ((unsigned int) uu.s.low >> b) | carries;
-	}
-
-	return w.ll;
-}
-
-EXPORT_SYMBOL(__ashrdi3);
diff --git a/arch/sh/lib/libgcc.h b/arch/sh/lib/libgcc.h
deleted file mode 100644
index 05909d58e2fe..000000000000
--- a/arch/sh/lib/libgcc.h
+++ /dev/null
@@ -1,25 +0,0 @@
-#ifndef __ASM_LIBGCC_H
-#define __ASM_LIBGCC_H
-
-#include <asm/byteorder.h>
-
-typedef int word_type __attribute__ ((mode (__word__)));
-
-#ifdef __BIG_ENDIAN
-struct DWstruct {
-	int high, low;
-};
-#elif defined(__LITTLE_ENDIAN)
-struct DWstruct {
-	int low, high;
-};
-#else
-#error I feel sick.
-#endif
-
-typedef union {
-	struct DWstruct s;
-	long long ll;
-} DWunion;
-
-#endif /* __ASM_LIBGCC_H */
diff --git a/arch/sh/lib/lshrdi3.c b/arch/sh/lib/lshrdi3.c
deleted file mode 100644
index dcf8d6810b7c..000000000000
--- a/arch/sh/lib/lshrdi3.c
+++ /dev/null
@@ -1,29 +0,0 @@
-#include <linux/module.h>
-
-#include "libgcc.h"
-
-long long __lshrdi3(long long u, word_type b)
-{
-	DWunion uu, w;
-	word_type bm;
-
-	if (b = 0)
-		return u;
-
-	uu.ll = u;
-	bm = 32 - b;
-
-	if (bm <= 0) {
-		w.s.high = 0;
-		w.s.low = (unsigned int) uu.s.high >> -bm;
-	} else {
-		const unsigned int carries = (unsigned int) uu.s.high << bm;
-
-		w.s.high = (unsigned int) uu.s.high >> b;
-		w.s.low = ((unsigned int) uu.s.low >> b) | carries;
-	}
-
-	return w.ll;
-}
-
-EXPORT_SYMBOL(__lshrdi3);
-- 
2.13.0

