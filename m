From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 20 Apr 2014 19:56:44 +0000
Subject: [PATCH 5/5] sparc32: fix sparse "Should it be static?" in mm/
Message-Id: <20140420195644.GE17743@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From 76f498f0378514d5456231b9abb5183efa4afff2 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 20 Apr 2014 20:32:29 +0200
Subject: [PATCH 5/5] sparc32: fix sparse "Should it be static?" in mm/

Fix following warnings:
srmmu.c:870:13: warning: symbol 'srmmu_paging_init' was not declared. Should it be static?
iommu.c:430:13: warning: symbol 'ld_mmu_iommu' was not declared. Should it be static?
leon_mm.c:21:5: warning: symbol 'srmmu_swprobe_trace' was not declared. Should it be static?

Add proper prototypes or define static to fix them.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/mm/leon_mm.c | 2 +-
 arch/sparc/mm/mm_32.h   | 6 ++++++
 arch/sparc/mm/srmmu.c   | 3 ---
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/mm/leon_mm.c b/arch/sparc/mm/leon_mm.c
index 649cad6..3b17b6f 100644
--- a/arch/sparc/mm/leon_mm.c
+++ b/arch/sparc/mm/leon_mm.c
@@ -18,7 +18,7 @@
 #include "mm_32.h"
 
 int leon_flush_during_switch = 1;
-int srmmu_swprobe_trace;
+static int srmmu_swprobe_trace;
 
 static inline unsigned long leon_get_ctable_ptr(void)
 {
diff --git a/arch/sparc/mm/mm_32.h b/arch/sparc/mm/mm_32.h
index bf4c56f..e567175 100644
--- a/arch/sparc/mm/mm_32.h
+++ b/arch/sparc/mm/mm_32.h
@@ -16,3 +16,9 @@ extern int flush_page_for_dma_global;
 extern void (*poke_srmmu)(void);
 
 extern void __init srmmu_paging_init(void);
+
+/* iommu.c */
+extern void ld_mmu_iommu(void);
+
+/* io-unit.c */
+extern void ld_mmu_iounit(void);
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 4639d8e..be65f03 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -1769,9 +1769,6 @@ static struct sparc32_cachetlb_ops smp_cachetlb_ops = {
 /* Load up routines and constants for sun4m and sun4d mmu */
 void __init load_mmu(void)
 {
-	extern void ld_mmu_iommu(void);
-	extern void ld_mmu_iounit(void);
-
 	/* Functions */
 	get_srmmu_type();
 
-- 
1.8.3.1

