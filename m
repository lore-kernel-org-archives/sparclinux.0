From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 Apr 2014 19:39:19 +0000
Subject: [PATCH 04/29] sparc32: fix sparse warnings in srmmu.c
Message-Id: <1398109184-3283-4-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warnings:
srmmu.c:78:5: warning: symbol 'flush_page_for_dma_global' was not declared. Should it be static?
srmmu.c:85:5: warning: symbol 'viking_mxcc_present' was not declared. Should it be static?
srmmu.c:103:6: warning: symbol 'srmmu_nocache_bitmap' was not declared. Should it be static?
srmmu.c:176:24: warning: Using plain integer as NULL pointer
srmmu.c:731:46: warning: Using plain integer as NULL pointer
srmmu.c:731:46: warning: Using plain integer as NULL pointer
srmmu.c:731:46: warning: Using plain integer as NULL pointer
srmmu.c:870:13: warning: symbol 'srmmu_paging_init' was not declared. Should it be static?

Add proper prototypes in mm_32.h and drop local prototype in init_32.c
Replace 0 with NULL

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/mm/init_32.c | 3 ++-
 arch/sparc/mm/iommu.c   | 5 ++---
 arch/sparc/mm/mm_32.h   | 4 ++++
 arch/sparc/mm/srmmu.c   | 6 +++---
 4 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index db69870..cf09e6e 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -35,6 +35,8 @@
 #include <asm/prom.h>
 #include <asm/leon.h>
 
+#include "mm_32.h"
+
 unsigned long *sparc_valid_addr_bitmap;
 EXPORT_SYMBOL(sparc_valid_addr_bitmap);
 
@@ -246,7 +248,6 @@ unsigned long __init bootmem_init(unsigned long *pages_avail)
  * init routine based upon the Sun model type on the Sparc.
  *
  */
-extern void srmmu_paging_init(void);
 extern void device_scan(void);
 
 void __init paging_init(void)
diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index 28f96f2..35384cb 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -27,6 +27,8 @@
 #include <asm/iommu.h>
 #include <asm/dma.h>
 
+#include "mm_32.h"
+
 /*
  * This can be sized dynamically, but we will do this
  * only when we have a guidance about actual I/O pressures.
@@ -37,9 +39,6 @@
 #define IOMMU_NPTES	(IOMMU_WINSIZE/PAGE_SIZE)	/* 64K PTEs, 256KB */
 #define IOMMU_ORDER	6				/* 4096 * (1<<6) */
 
-/* srmmu.c */
-extern int viking_mxcc_present;
-extern int flush_page_for_dma_global;
 static int viking_flush;
 /* viking.S */
 extern void viking_flush_page(unsigned long page);
diff --git a/arch/sparc/mm/mm_32.h b/arch/sparc/mm/mm_32.h
index ee773e4..443e62e 100644
--- a/arch/sparc/mm/mm_32.h
+++ b/arch/sparc/mm/mm_32.h
@@ -10,5 +10,9 @@ void window_ret_fault(struct pt_regs *regs);
 
 /* srmmu.c */
 extern char *srmmu_name;
+extern int viking_mxcc_present;
+extern int flush_page_for_dma_global;
 
 extern void (*poke_srmmu)(void);
+
+void __init srmmu_paging_init(void);
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 54e834c..4639d8e 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -100,7 +100,6 @@ static unsigned long srmmu_nocache_end;
 #define SRMMU_NOCACHE_ALIGN_MAX (sizeof(ctxd_t)*SRMMU_MAX_CONTEXTS)
 
 void *srmmu_nocache_pool;
-void *srmmu_nocache_bitmap;
 static struct bit_map srmmu_nocache_map;
 
 static inline int srmmu_pmd_none(pmd_t pmd)
@@ -173,7 +172,7 @@ static void *__srmmu_get_nocache(int size, int align)
 		printk(KERN_ERR "srmmu: out of nocache %d: %d/%d\n",
 		       size, (int) srmmu_nocache_size,
 		       srmmu_nocache_map.used << SRMMU_NOCACHE_BITMAP_SHIFT);
-		return 0;
+		return NULL;
 	}
 
 	addr = SRMMU_NOCACHE_VADDR + (offset << SRMMU_NOCACHE_BITMAP_SHIFT);
@@ -269,6 +268,7 @@ static void __init srmmu_nocache_calcsize(void)
 
 static void __init srmmu_nocache_init(void)
 {
+	void *srmmu_nocache_bitmap;
 	unsigned int bitmap_bits;
 	pgd_t *pgd;
 	pmd_t *pmd;
@@ -728,7 +728,7 @@ static inline unsigned long srmmu_probe(unsigned long vaddr)
 				     "=r" (retval) :
 				     "r" (vaddr | 0x400), "i" (ASI_M_FLUSH_PROBE));
 	} else {
-		retval = leon_swprobe(vaddr, 0);
+		retval = leon_swprobe(vaddr, NULL);
 	}
 	return retval;
 }
-- 
1.8.3.1

