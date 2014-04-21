From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 Apr 2014 19:39:20 +0000
Subject: [PATCH 05/29] sparc32: fix sparse "Should it be static?" in mm/
Message-Id: <1398109184-3283-5-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warnings:
srmmu.c:870:13: warning: symbol 'srmmu_paging_init' was not declared. Should it be static?
iommu.c:430:13: warning: symbol 'ld_mmu_iommu' was not declared. Should it be static?
leon_mm.c:21:5: warning: symbol 'srmmu_swprobe_trace' was not declared. Should it be static?

Add proper prototypes or define static to fix them.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/mm/leon_mm.c | 2 +-
 arch/sparc/mm/mm_32.h   | 7 +++++++
 arch/sparc/mm/srmmu.c   | 3 ---
 3 files changed, 8 insertions(+), 4 deletions(-)

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
index 443e62e..bac570f 100644
--- a/arch/sparc/mm/mm_32.h
+++ b/arch/sparc/mm/mm_32.h
@@ -16,3 +16,10 @@ extern int flush_page_for_dma_global;
 extern void (*poke_srmmu)(void);
 
 void __init srmmu_paging_init(void);
+
+/* iommu.c */
+void ld_mmu_iommu(void);
+
+/* io-unit.c */
+void ld_mmu_iounit(void);
+
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

