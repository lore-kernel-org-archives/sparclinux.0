From: Palmer Dabbelt <palmer@dabbelt.com>
Date: Tue, 23 May 2017 22:05:41 +0000
Subject: [PATCH 2/7] m32r: Use lib/ucmpdi2.c
Message-Id: <20170523220546.16758-3-palmer@dabbelt.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170523220546.16758-1-palmer@dabbelt.com>
In-Reply-To: <20170523220546.16758-1-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: monstr@monstr.eu, ralf@linux-mips.org, liqin.linux@gmail.com, lennox.wu@gmail.com, ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, geert@linux-m68k.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>

These files are functionally identical to the shared copies that I
recently added.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 arch/m32r/Kconfig       |  1 +
 arch/m32r/lib/Makefile  |  3 +--
 arch/m32r/lib/libgcc.h  | 23 -----------------------
 arch/m32r/lib/ucmpdi2.c | 17 -----------------
 4 files changed, 2 insertions(+), 42 deletions(-)
 delete mode 100644 arch/m32r/lib/libgcc.h
 delete mode 100644 arch/m32r/lib/ucmpdi2.c

diff --git a/arch/m32r/Kconfig b/arch/m32r/Kconfig
index 95474460b367..2fbe3aa3e0c4 100644
--- a/arch/m32r/Kconfig
+++ b/arch/m32r/Kconfig
@@ -19,6 +19,7 @@ config M32R
 	select HAVE_DEBUG_STACKOVERFLOW
 	select CPU_NO_EFFICIENT_FFS
 	select DMA_NOOP_OPS
+	select LIB_UCMPDI3
 
 config SBUS
 	bool
diff --git a/arch/m32r/lib/Makefile b/arch/m32r/lib/Makefile
index 5889eb9610b5..0a753a833bbf 100644
--- a/arch/m32r/lib/Makefile
+++ b/arch/m32r/lib/Makefile
@@ -3,5 +3,4 @@
 #
 
 lib-y  := checksum.o ashxdi3.o memset.o memcpy.o \
-	  delay.o strlen.o usercopy.o csum_partial_copy.o \
-	  ucmpdi2.o
+	  delay.o strlen.o usercopy.o csum_partial_copy.o
diff --git a/arch/m32r/lib/libgcc.h b/arch/m32r/lib/libgcc.h
deleted file mode 100644
index 267aa435bc35..000000000000
--- a/arch/m32r/lib/libgcc.h
+++ /dev/null
@@ -1,23 +0,0 @@
-#ifndef __ASM_LIBGCC_H
-#define __ASM_LIBGCC_H
-
-#include <asm/byteorder.h>
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
diff --git a/arch/m32r/lib/ucmpdi2.c b/arch/m32r/lib/ucmpdi2.c
deleted file mode 100644
index 9d3c682c89b5..000000000000
--- a/arch/m32r/lib/ucmpdi2.c
+++ /dev/null
@@ -1,17 +0,0 @@
-#include "libgcc.h"
-
-int __ucmpdi2(unsigned long long a, unsigned long long b)
-{
-	const DWunion au = {.ll = a};
-	const DWunion bu = {.ll = b};
-
-	if ((unsigned int)au.s.high < (unsigned int)bu.s.high)
-		return 0;
-	else if ((unsigned int)au.s.high > (unsigned int)bu.s.high)
-		return 2;
-	if ((unsigned int)au.s.low < (unsigned int)bu.s.low)
-		return 0;
-	else if ((unsigned int)au.s.low > (unsigned int)bu.s.low)
-		return 2;
-	return 1;
-}
-- 
2.13.0

