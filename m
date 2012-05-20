From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 20 May 2012 06:02:49 +0000
Subject: [PATCH 6/8] sparc32,leon: move leon mmu functions to leon_mm.c
Message-Id: <1337493771-18535-6-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

We already have a leaon specific file - so
keep all the laon stuff in one place.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Konrad Eisele <konrad@gaisler.com>
---
 arch/sparc/mm/leon_mm.c |   80 +++++++++++++++++++++++++++++++++++++++++++++
 arch/sparc/mm/srmmu.c   |   83 +---------------------------------------------
 arch/sparc/mm/srmmu.h   |    4 ++
 3 files changed, 86 insertions(+), 81 deletions(-)
 create mode 100644 arch/sparc/mm/srmmu.h

diff --git a/arch/sparc/mm/leon_mm.c b/arch/sparc/mm/leon_mm.c
index 13c2169..ccbcba4 100644
--- a/arch/sparc/mm/leon_mm.c
+++ b/arch/sparc/mm/leon_mm.c
@@ -15,6 +15,8 @@
 #include <asm/leon.h>
 #include <asm/tlbflush.h>
 
+#include "srmmu.h"
+
 int leon_flush_during_switch = 1;
 int srmmu_swprobe_trace;
 
@@ -258,3 +260,81 @@ void leon_switch_mm(void)
 	if (leon_flush_during_switch)
 		leon_flush_cache_all();
 }
+
+static void leon_flush_cache_mm(struct mm_struct *mm)
+{
+	leon_flush_cache_all();
+}
+
+static void leon_flush_cache_page(struct vm_area_struct *vma, unsigned long page)
+{
+	leon_flush_pcache_all(vma, page);
+}
+
+static void leon_flush_cache_range(struct vm_area_struct *vma,
+				   unsigned long start,
+				   unsigned long end)
+{
+	leon_flush_cache_all();
+}
+
+static void leon_flush_tlb_mm(struct mm_struct *mm)
+{
+	leon_flush_tlb_all();
+}
+
+static void leon_flush_tlb_page(struct vm_area_struct *vma,
+				unsigned long page)
+{
+	leon_flush_tlb_all();
+}
+
+static void leon_flush_tlb_range(struct vm_area_struct *vma,
+				 unsigned long start,
+				 unsigned long end)
+{
+	leon_flush_tlb_all();
+}
+
+static void leon_flush_page_to_ram(unsigned long page)
+{
+	leon_flush_cache_all();
+}
+
+static void leon_flush_sig_insns(struct mm_struct *mm, unsigned long page)
+{
+	leon_flush_cache_all();
+}
+
+static void leon_flush_page_for_dma(unsigned long page)
+{
+	leon_flush_dcache_all();
+}
+
+void __init poke_leonsparc(void)
+{
+}
+
+static const struct sparc32_cachetlb_ops leon_ops = {
+	.cache_all	= leon_flush_cache_all,
+	.cache_mm	= leon_flush_cache_mm,
+	.cache_page	= leon_flush_cache_page,
+	.cache_range	= leon_flush_cache_range,
+	.tlb_all	= leon_flush_tlb_all,
+	.tlb_mm		= leon_flush_tlb_mm,
+	.tlb_page	= leon_flush_tlb_page,
+	.tlb_range	= leon_flush_tlb_range,
+	.page_to_ram	= leon_flush_page_to_ram,
+	.sig_insns	= leon_flush_sig_insns,
+	.page_for_dma	= leon_flush_page_for_dma,
+};
+
+void __init init_leon(void)
+{
+	srmmu_name = "LEON";
+	sparc32_cachetlb_ops = &leon_ops;
+	poke_srmmu = poke_leonsparc;
+
+	leon_flush_during_switch = leon_flush_needed();
+}
+
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 4875fcd..a02c56a 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -48,6 +48,8 @@
 #include <asm/turbosparc.h>
 #include <asm/leon.h>
 
+#include "srmmu.h"
+
 enum mbus_module srmmu_modtype;
 static unsigned int hwbug_bitmask;
 int vac_cache_size;
@@ -1479,87 +1481,6 @@ static void __init init_viking(void)
 	poke_srmmu = poke_viking;
 }
 
-#ifdef CONFIG_SPARC_LEON
-static void leon_flush_cache_mm(struct mm_struct *mm)
-{
-	leon_flush_cache_all();
-}
-
-static void leon_flush_cache_page(struct vm_area_struct *vma, unsigned long page)
-{
-	leon_flush_pcache_all(vma, page);
-}
-
-static void leon_flush_cache_range(struct vm_area_struct *vma,
-				   unsigned long start,
-				   unsigned long end)
-{
-	leon_flush_cache_all();
-}
-
-static void leon_flush_tlb_mm(struct mm_struct *mm)
-{
-	leon_flush_tlb_all();
-}
-
-static void leon_flush_tlb_page(struct vm_area_struct *vma,
-				unsigned long page)
-{
-	leon_flush_tlb_all();
-}
-
-static void leon_flush_tlb_range(struct vm_area_struct *vma,
-				 unsigned long start,
-				 unsigned long end)
-{
-	leon_flush_tlb_all();
-}
-
-static void leon_flush_page_to_ram(unsigned long page)
-{
-	leon_flush_cache_all();
-}
-
-static void leon_flush_sig_insns(struct mm_struct *mm, unsigned long page)
-{
-	leon_flush_cache_all();
-}
-
-static void leon_flush_page_for_dma(unsigned long page)
-{
-	leon_flush_dcache_all();
-}
-
-void __init poke_leonsparc(void)
-{
-}
-
-static const struct sparc32_cachetlb_ops leon_ops = {
-	.cache_all	= leon_flush_cache_all,
-	.cache_mm	= leon_flush_cache_mm,
-	.cache_page	= leon_flush_cache_page,
-	.cache_range	= leon_flush_cache_range,
-	.tlb_all	= leon_flush_tlb_all,
-	.tlb_mm		= leon_flush_tlb_mm,
-	.tlb_page	= leon_flush_tlb_page,
-	.tlb_range	= leon_flush_tlb_range,
-	.page_to_ram	= leon_flush_page_to_ram,
-	.sig_insns	= leon_flush_sig_insns,
-	.page_for_dma	= leon_flush_page_for_dma,
-};
-
-void __init init_leon(void)
-{
-	srmmu_name = "LEON";
-	sparc32_cachetlb_ops = &leon_ops;
-	poke_srmmu = poke_leonsparc;
-
-	srmmu_cache_pagetables = 0;
-
-	leon_flush_during_switch = leon_flush_needed();
-}
-#endif
-
 /* Probe for the srmmu chip version. */
 static void __init get_srmmu_type(void)
 {
diff --git a/arch/sparc/mm/srmmu.h b/arch/sparc/mm/srmmu.h
new file mode 100644
index 0000000..5703274
--- /dev/null
+++ b/arch/sparc/mm/srmmu.h
@@ -0,0 +1,4 @@
+/* srmmu.c */
+extern char *srmmu_name;
+
+extern void (*poke_srmmu)(void);
-- 
1.6.0.6

