From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 19 May 2012 09:58:30 +0000
Subject: [PATCH] sparc32: add ucmpdi2
Message-Id: <20120519095830.GA4813@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From 44be8ae622596463a6e64542ce8580567cf78f15 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 19 May 2012 11:54:11 +0200
Subject: [PATCH] sparc32: add ucmpdi2

Based on copy from microblaze add ucmpdi2 implementation.
This fixes build of niu driver which failed with:

drivers/built-in.o: In function `niu_get_nfc':
niu.c:(.text+0x91494): undefined reference to `__ucmpdi2'

This driver will never be used on a sparc32 system,
but patch added to fix build breakage with all*config builds.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/lib/Makefile  |    2 +-
 arch/sparc/lib/ucmpdi2.c |   19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletions(-)
 create mode 100644 arch/sparc/lib/ucmpdi2.c

diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
index ead6df2..245bccf 100644
--- a/arch/sparc/lib/Makefile
+++ b/arch/sparc/lib/Makefile
@@ -15,7 +15,7 @@ lib-$(CONFIG_SPARC32) += divdi3.o udivdi3.o
 lib-$(CONFIG_SPARC32) += copy_user.o locks.o
 lib-$(CONFIG_SPARC64) += atomic_64.o
 lib-$(CONFIG_SPARC32) += lshrdi3.o ashldi3.o
-lib-$(CONFIG_SPARC32) += muldi3.o bitext.o cmpdi2.o
+lib-$(CONFIG_SPARC32) += muldi3.o bitext.o cmpdi2.o ucmpdi2.o
 
 lib-$(CONFIG_SPARC64) += copy_page.o clear_page.o bzero.o
 lib-$(CONFIG_SPARC64) += csum_copy.o csum_copy_from_user.o csum_copy_to_user.o
diff --git a/arch/sparc/lib/ucmpdi2.c b/arch/sparc/lib/ucmpdi2.c
new file mode 100644
index 0000000..1e06ed5
--- /dev/null
+++ b/arch/sparc/lib/ucmpdi2.c
@@ -0,0 +1,19 @@
+#include <linux/module.h>
+#include "libgcc.h"
+
+word_type __ucmpdi2(unsigned long long a, unsigned long long b)
+{
+	const DWunion au = {.ll = a};
+	const DWunion bu = {.ll = b};
+
+	if ((unsigned int) au.s.high < (unsigned int) bu.s.high)
+		return 0;
+	else if ((unsigned int) au.s.high > (unsigned int) bu.s.high)
+		return 2;
+	if ((unsigned int) au.s.low < (unsigned int) bu.s.low)
+		return 0;
+	else if ((unsigned int) au.s.low > (unsigned int) bu.s.low)
+		return 2;
+	return 1;
+}
+EXPORT_SYMBOL(__ucmpdi2);
-- 
1.6.0.6

