From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 20 Jul 2012 07:55:44 +0000
Subject: [PATCH 9/9] sparc32: drop fixmap.h
Message-Id: <1342770944-17476-9-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

sparc32 does not support fixmaps - so do not pretend so by
having the fixmap.h file.
Move relevant parts to vaddrs.h.

I looked at simplifying this even more but failed to understand
the reasoning behind the extra guard page involved and due to
missing testing possibilities only the trivial conversion was done.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/fixmap.h  |   26 --------------------------
 arch/sparc/include/asm/highmem.h |    1 -
 arch/sparc/include/asm/vaddrs.h  |   22 ++++++++++++++++++++++
 arch/sparc/mm/highmem.c          |    7 ++++---
 4 files changed, 26 insertions(+), 30 deletions(-)
 delete mode 100644 arch/sparc/include/asm/fixmap.h

diff --git a/arch/sparc/include/asm/fixmap.h b/arch/sparc/include/asm/fixmap.h
deleted file mode 100644
index 0bdec93..0000000
--- a/arch/sparc/include/asm/fixmap.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/* Highmem related constants */
-
-#ifndef _ASM_FIXMAP_H
-#define _ASM_FIXMAP_H
-
-#include <asm/kmap_types.h>
-
-enum fixed_addresses {
-	FIX_HOLE,
-#ifdef CONFIG_HIGHMEM
-	FIX_KMAP_BEGIN,
-	FIX_KMAP_END = (KM_TYPE_NR * NR_CPUS),
-#endif
-	__end_of_fixed_addresses
-};
-
-/* Leave one empty page between IO pages at 0xfd000000 and
- * the top of the fixmap.
- */
-#define FIXADDR_TOP	(0xfcfff000UL)
-#define FIXADDR_SIZE	((FIX_KMAP_END + 1) << PAGE_SHIFT)
-#define FIXADDR_START	(FIXADDR_TOP - FIXADDR_SIZE)
-
-#define __fix_to_virt(x)	(FIXADDR_TOP - ((x) << PAGE_SHIFT))
-
-#endif
diff --git a/arch/sparc/include/asm/highmem.h b/arch/sparc/include/asm/highmem.h
index a31b2a1..6393383 100644
--- a/arch/sparc/include/asm/highmem.h
+++ b/arch/sparc/include/asm/highmem.h
@@ -21,7 +21,6 @@
 #ifdef __KERNEL__
 
 #include <linux/interrupt.h>
-#include <asm/fixmap.h>
 #include <asm/vaddrs.h>
 #include <asm/kmap_types.h>
 #include <asm/pgtable.h>
diff --git a/arch/sparc/include/asm/vaddrs.h b/arch/sparc/include/asm/vaddrs.h
index da6535d..c3dbcf9 100644
--- a/arch/sparc/include/asm/vaddrs.h
+++ b/arch/sparc/include/asm/vaddrs.h
@@ -30,6 +30,28 @@
  */
 #define SRMMU_NOCACHE_ALCRATIO	64	/* 256 pages per 64MB of system RAM */
 
+#ifndef __ASSEMBLY__
+#include <asm/kmap_types.h>
+
+enum fixed_addresses {
+	FIX_HOLE,
+#ifdef CONFIG_HIGHMEM
+	FIX_KMAP_BEGIN,
+	FIX_KMAP_END = (KM_TYPE_NR * NR_CPUS),
+#endif
+	__end_of_fixed_addresses
+};
+#endif
+
+/* Leave one empty page between IO pages at 0xfd000000 and
+ * the top of the fixmap.
+ */
+#define FIXADDR_TOP		(0xfcfff000UL)
+#define FIXADDR_SIZE		((FIX_KMAP_END + 1) << PAGE_SHIFT)
+#define FIXADDR_START		(FIXADDR_TOP - FIXADDR_SIZE)
+
+#define __fix_to_virt(x)        (FIXADDR_TOP - ((x) << PAGE_SHIFT))
+
 #define SUN4M_IOBASE_VADDR	0xfd000000 /* Base for mapping pages */
 #define IOBASE_VADDR		0xfe000000
 #define IOBASE_END		0xfe600000
diff --git a/arch/sparc/mm/highmem.c b/arch/sparc/mm/highmem.c
index 856432a..4d5f8b3 100644
--- a/arch/sparc/mm/highmem.c
+++ b/arch/sparc/mm/highmem.c
@@ -22,13 +22,14 @@
  * shared by CPUs, and so precious, and establishing them requires IPI.
  * Atomic kmaps are lightweight and we may have NCPUS more of them.
  */
-#include <linux/mm.h>
 #include <linux/highmem.h>
 #include <linux/export.h>
-#include <asm/pgalloc.h>
+#include <linux/mm.h>
+
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
-#include <asm/fixmap.h>
+#include <asm/pgalloc.h>
+#include <asm/vaddrs.h>
 
 void *kmap_atomic(struct page *page)
 {
-- 
1.6.0.6

