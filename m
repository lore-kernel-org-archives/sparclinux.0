From: konrad@gaisler.com
Date: Fri, 12 Jun 2009 08:44:36 +0000
Subject: round2 [PATCH 6/6] sparc-leon specific SRMMU initialization and bootup fixes. The sparc-leon caches
Message-Id: <1244796276-7386-1-git-send-email-konrad@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Konrad Eisele <konrad@gaisler.com>

---
 arch/sparc/mm/srmmu.c |   66 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 65 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 06c9a7d..ae217cc 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -45,6 +45,7 @@
 #include <asm/tsunami.h>
 #include <asm/swift.h>
 #include <asm/turbosparc.h>
+#include <asm/leon.h>
 
 #include <asm/btfixup.h>
 
@@ -568,6 +569,10 @@ static void srmmu_switch_mm(struct mm_struct *old_mm, struct mm_struct *mm,
 		srmmu_ctxd_set(&srmmu_context_table[mm->context], mm->pgd);
 	}
 
+	if (sparc_cpu_model = sparc_leon) {
+		leon_switch_mm();
+	}
+	
 	if (is_hypersparc)
 		hyper_flush_whole_icache();
 
@@ -1976,6 +1981,58 @@ static void __init init_viking(void)
 	poke_srmmu = poke_viking;
 }
 
+#ifdef CONFIG_SPARC_LEON
+
+extern void leon_flush_icache_all(void);
+extern void leon_flush_dcache_all(void);
+extern void leon_flush_pcache_all(struct vm_area_struct *vma,
+				  unsigned long page);
+extern void leon_flush_cache_all(void);
+extern void leon_flush_tlb_all(void);
+extern int leon_flush_during_switch ;
+extern int leon_flush_needed(void);
+extern void leon_flush_pcache_all(struct vm_area_struct *vma,
+				  unsigned long page);
+
+void __init poke_leonsparc(void)
+{
+}
+
+void __init init_leon(void)
+{
+
+	srmmu_name = "Leon";
+
+	BTFIXUPSET_CALL(flush_cache_all, leon_flush_cache_all,
+			BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(flush_cache_mm, leon_flush_cache_all,
+			BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(flush_cache_page, leon_flush_pcache_all,
+			BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(flush_cache_range, leon_flush_cache_all,
+			BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(flush_page_for_dma, leon_flush_dcache_all,
+			BTFIXUPCALL_NORM);
+
+	BTFIXUPSET_CALL(flush_tlb_all, leon_flush_tlb_all, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(flush_tlb_mm, leon_flush_tlb_all, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(flush_tlb_page, leon_flush_tlb_all, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(flush_tlb_range, leon_flush_tlb_all, BTFIXUPCALL_NORM);
+
+	BTFIXUPSET_CALL(__flush_page_to_ram, leon_flush_cache_all,
+			BTFIXUPCALL_NOP);
+	BTFIXUPSET_CALL(flush_sig_insns, leon_flush_cache_all, BTFIXUPCALL_NOP);
+
+	poke_srmmu = poke_leonsparc;
+
+	srmmu_cache_pagetables = 0;
+
+	leon_flush_during_switch = leon_flush_needed();
+}
+#else
+#define init_leon()
+#endif
+
 /* Probe for the srmmu chip version. */
 static void __init get_srmmu_type(void)
 {
@@ -1990,7 +2047,14 @@ static void __init get_srmmu_type(void)
 	mod_rev = (mreg & 0x0f000000) >> 24;
 	psr_typ = (psr >> 28) & 0xf;
 	psr_vers = (psr >> 24) & 0xf;
-
+	
+	if (sparc_cpu_model = sparc_leon) {
+		psr_typ = 0xf;	/* hardcoded ids for older models/simulators */
+		psr_vers = 2;
+		init_leon(); /* macro if !CONFIG_SPARC_LEON */
+		return;
+	}
+	
 	/* First, check for HyperSparc or Cypress. */
 	if(mod_typ = 1) {
 		switch(mod_rev) {
-- 
1.6.3.2

