From: Palmer Dabbelt <palmer@dabbelt.com>
Date: Tue, 23 May 2017 22:05:43 +0000
Subject: [PATCH 4/7] mips: Use lib/{ashldi3,ashrdi3,cmpdi2,lshrdi3,ucmpdi2}.c
Message-Id: <20170523220546.16758-5-palmer@dabbelt.com>
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
 arch/mips/Kconfig       |  1 +
 arch/mips/lib/Makefile  |  2 +-
 arch/mips/lib/ashldi3.c |  2 +-
 arch/mips/lib/ashrdi3.c |  2 +-
 arch/mips/lib/cmpdi2.c  |  2 +-
 arch/mips/lib/libgcc.h  | 25 -------------------------
 arch/mips/lib/lshrdi3.c |  2 +-
 arch/mips/lib/ucmpdi2.c | 21 ---------------------
 8 files changed, 6 insertions(+), 51 deletions(-)
 delete mode 100644 arch/mips/lib/libgcc.h
 delete mode 100644 arch/mips/lib/ucmpdi2.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2828ecde133d..b106e6165db0 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -70,6 +70,7 @@ config MIPS
 	select HAVE_EXIT_THREAD
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_COPY_THREAD_TLS
+	select LIB_UCMPDI3
 
 menu "Machine selection"
 
diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index 0344e575f522..e38dbafea074 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -15,4 +15,4 @@ obj-$(CONFIG_CPU_R3000)		+= r3k_dump_tlb.o
 obj-$(CONFIG_CPU_TX39XX)	+= r3k_dump_tlb.o
 
 # libgcc-style stuff needed in the kernel
-obj-y += ashldi3.o ashrdi3.o bswapsi.o bswapdi.o cmpdi2.o lshrdi3.o ucmpdi2.o
+obj-y += ashldi3.o ashrdi3.o bswapsi.o bswapdi.o cmpdi2.o lshrdi3.o
diff --git a/arch/mips/lib/ashldi3.c b/arch/mips/lib/ashldi3.c
index c3e22053d13e..b3d706155fce 100644
--- a/arch/mips/lib/ashldi3.c
+++ b/arch/mips/lib/ashldi3.c
@@ -1,6 +1,6 @@
 #include <linux/export.h>
 
-#include "libgcc.h"
+#include <lib/libgcc.h>
 
 long long notrace __ashldi3(long long u, word_type b)
 {
diff --git a/arch/mips/lib/ashrdi3.c b/arch/mips/lib/ashrdi3.c
index 17456024873d..bca87aca6f5c 100644
--- a/arch/mips/lib/ashrdi3.c
+++ b/arch/mips/lib/ashrdi3.c
@@ -1,6 +1,6 @@
 #include <linux/export.h>
 
-#include "libgcc.h"
+#include <lib/libgcc.h>
 
 long long notrace __ashrdi3(long long u, word_type b)
 {
diff --git a/arch/mips/lib/cmpdi2.c b/arch/mips/lib/cmpdi2.c
index 9d849d8743c9..774b109921b5 100644
--- a/arch/mips/lib/cmpdi2.c
+++ b/arch/mips/lib/cmpdi2.c
@@ -1,6 +1,6 @@
 #include <linux/export.h>
 
-#include "libgcc.h"
+#include <lib/libgcc.h>
 
 word_type notrace __cmpdi2(long long a, long long b)
 {
diff --git a/arch/mips/lib/libgcc.h b/arch/mips/lib/libgcc.h
deleted file mode 100644
index 05909d58e2fe..000000000000
--- a/arch/mips/lib/libgcc.h
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
diff --git a/arch/mips/lib/lshrdi3.c b/arch/mips/lib/lshrdi3.c
index 221167c1be55..ceb1a5c14bc8 100644
--- a/arch/mips/lib/lshrdi3.c
+++ b/arch/mips/lib/lshrdi3.c
@@ -1,6 +1,6 @@
 #include <linux/export.h>
 
-#include "libgcc.h"
+#include <lib/libgcc.h>
 
 long long notrace __lshrdi3(long long u, word_type b)
 {
diff --git a/arch/mips/lib/ucmpdi2.c b/arch/mips/lib/ucmpdi2.c
deleted file mode 100644
index 08067fa538f2..000000000000
--- a/arch/mips/lib/ucmpdi2.c
+++ /dev/null
@@ -1,21 +0,0 @@
-#include <linux/export.h>
-
-#include "libgcc.h"
-
-word_type notrace __ucmpdi2(unsigned long long a, unsigned long long b)
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
-
-EXPORT_SYMBOL(__ucmpdi2);
-- 
2.13.0

