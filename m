From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 20 Jul 2012 07:55:37 +0000
Subject: [PATCH 2/9] sparc32: sort includes in srmmu.c
Message-Id: <1342770944-17476-2-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/mm/srmmu.c |   42 +++++++++++++++++++++---------------------
 1 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index b2ba9d1..533143b 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -8,45 +8,45 @@
  * Copyright (C) 1999,2000 Anton Blanchard (anton@samba.org)
  */
 
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/vmalloc.h>
-#include <linux/pagemap.h>
-#include <linux/init.h>
+#include <linux/seq_file.h>
 #include <linux/spinlock.h>
 #include <linux/bootmem.h>
-#include <linux/fs.h>
-#include <linux/seq_file.h>
+#include <linux/pagemap.h>
+#include <linux/vmalloc.h>
 #include <linux/kdebug.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
 #include <linux/log2.h>
 #include <linux/gfp.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
 
-#include <asm/bitext.h>
-#include <asm/page.h>
+#include <asm/mmu_context.h>
+#include <asm/cacheflush.h>
+#include <asm/tlbflush.h>
+#include <asm/io-unit.h>
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
-#include <asm/io.h>
+#include <asm/bitext.h>
 #include <asm/vaddrs.h>
-#include <asm/traps.h>
-#include <asm/smp.h>
-#include <asm/mbus.h>
 #include <asm/cache.h>
+#include <asm/traps.h>
 #include <asm/oplib.h>
+#include <asm/mbus.h>
+#include <asm/page.h>
 #include <asm/asi.h>
 #include <asm/msi.h>
-#include <asm/mmu_context.h>
-#include <asm/io-unit.h>
-#include <asm/cacheflush.h>
-#include <asm/tlbflush.h>
+#include <asm/smp.h>
+#include <asm/io.h>
 
 /* Now the cpu specific definitions. */
-#include <asm/viking.h>
-#include <asm/mxcc.h>
-#include <asm/ross.h>
+#include <asm/turbosparc.h>
 #include <asm/tsunami.h>
+#include <asm/viking.h>
 #include <asm/swift.h>
-#include <asm/turbosparc.h>
 #include <asm/leon.h>
+#include <asm/mxcc.h>
+#include <asm/ross.h>
 
 #include "srmmu.h"
 
-- 
1.6.0.6

