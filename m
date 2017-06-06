From: Palmer Dabbelt <palmer@dabbelt.com>
Date: Tue, 06 Jun 2017 19:10:22 +0000
Subject: [PATCH 6/7] sparc: Use lib/{cmpdi2,ucmpdi2}.c
Message-Id: <20170606191023.24581-7-palmer@dabbelt.com>
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
 arch/sparc/Kconfig       |  2 ++
 arch/sparc/lib/Makefile  |  4 ++--
 arch/sparc/lib/cmpdi2.c  | 27 ---------------------------
 arch/sparc/lib/libgcc.h  | 18 ------------------
 arch/sparc/lib/ucmpdi2.c | 19 -------------------
 5 files changed, 4 insertions(+), 66 deletions(-)
 delete mode 100644 arch/sparc/lib/cmpdi2.c
 delete mode 100644 arch/sparc/lib/libgcc.h
 delete mode 100644 arch/sparc/lib/ucmpdi2.c

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 58243b0d21c0..cbb1aeb0d419 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -52,6 +52,8 @@ config SPARC32
 	select CLZ_TAB
 	select HAVE_UID16
 	select OLD_SIGACTION
+	select GENERIC_CMPDI2
+	select GENERIC_UCMPDI2
 
 config SPARC64
 	def_bool 64BIT
diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
index 69912d2f8b54..815b4a336aa8 100644
--- a/arch/sparc/lib/Makefile
+++ b/arch/sparc/lib/Makefile
@@ -14,7 +14,7 @@ lib-$(CONFIG_SPARC32) += divdi3.o udivdi3.o
 lib-$(CONFIG_SPARC32) += copy_user.o locks.o
 lib-$(CONFIG_SPARC64) += atomic_64.o
 lib-$(CONFIG_SPARC32) += lshrdi3.o ashldi3.o
-lib-$(CONFIG_SPARC32) += muldi3.o bitext.o cmpdi2.o
+lib-$(CONFIG_SPARC32) += muldi3.o bitext.o
 
 lib-$(CONFIG_SPARC64) += copy_page.o clear_page.o bzero.o
 lib-$(CONFIG_SPARC64) += csum_copy.o csum_copy_from_user.o csum_copy_to_user.o
@@ -42,5 +42,5 @@ lib-$(CONFIG_SPARC64) += copy_in_user.o memmove.o
 lib-$(CONFIG_SPARC64) += mcount.o ipcsum.o xor.o hweight.o ffs.o
 
 obj-$(CONFIG_SPARC64) += iomap.o
-obj-$(CONFIG_SPARC32) += atomic32.o ucmpdi2.o
+obj-$(CONFIG_SPARC32) += atomic32.o
 obj-$(CONFIG_SPARC64) += PeeCeeI.o
diff --git a/arch/sparc/lib/cmpdi2.c b/arch/sparc/lib/cmpdi2.c
deleted file mode 100644
index 8c1306437ed1..000000000000
--- a/arch/sparc/lib/cmpdi2.c
+++ /dev/null
@@ -1,27 +0,0 @@
-#include <linux/module.h>
-
-#include "libgcc.h"
-
-word_type __cmpdi2(long long a, long long b)
-{
-	const DWunion au = {
-		.ll = a
-	};
-	const DWunion bu = {
-		.ll = b
-	};
-
-	if (au.s.high < bu.s.high)
-		return 0;
-	else if (au.s.high > bu.s.high)
-		return 2;
-
-	if ((unsigned int) au.s.low < (unsigned int) bu.s.low)
-		return 0;
-	else if ((unsigned int) au.s.low > (unsigned int) bu.s.low)
-		return 2;
-
-	return 1;
-}
-
-EXPORT_SYMBOL(__cmpdi2);
diff --git a/arch/sparc/lib/libgcc.h b/arch/sparc/lib/libgcc.h
deleted file mode 100644
index b84fd797f3ea..000000000000
--- a/arch/sparc/lib/libgcc.h
+++ /dev/null
@@ -1,18 +0,0 @@
-#ifndef __ASM_LIBGCC_H
-#define __ASM_LIBGCC_H
-
-#include <asm/byteorder.h>
-
-typedef int word_type __attribute__ ((mode (__word__)));
-
-struct DWstruct {
-	int high, low;
-};
-
-typedef union
-{
-	struct DWstruct s;
-	long long ll;
-} DWunion;
-
-#endif /* __ASM_LIBGCC_H */
diff --git a/arch/sparc/lib/ucmpdi2.c b/arch/sparc/lib/ucmpdi2.c
deleted file mode 100644
index 1e06ed500682..000000000000
--- a/arch/sparc/lib/ucmpdi2.c
+++ /dev/null
@@ -1,19 +0,0 @@
-#include <linux/module.h>
-#include "libgcc.h"
-
-word_type __ucmpdi2(unsigned long long a, unsigned long long b)
-{
-	const DWunion au = {.ll = a};
-	const DWunion bu = {.ll = b};
-
-	if ((unsigned int) au.s.high < (unsigned int) bu.s.high)
-		return 0;
-	else if ((unsigned int) au.s.high > (unsigned int) bu.s.high)
-		return 2;
-	if ((unsigned int) au.s.low < (unsigned int) bu.s.low)
-		return 0;
-	else if ((unsigned int) au.s.low > (unsigned int) bu.s.low)
-		return 2;
-	return 1;
-}
-EXPORT_SYMBOL(__ucmpdi2);
-- 
2.13.0

