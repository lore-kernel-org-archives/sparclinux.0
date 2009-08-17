From: konrad@gaisler.com
Date: Mon, 17 Aug 2009 10:13:33 +0000
Subject: [PATCH 5/5] sparc,leon: sparc-leon specific SRMMU initialization and bootup fixes.
Message-Id: <1250504013-652-5-git-send-email-konrad@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Konrad Eisele <konrad@gaisler.com>

The sparc-leon caches are virtually tagged so a flush is needed on ctx
switch.

Signed-off-by: Konrad Eisele <konrad@gaisler.com>
Reviewed-by:   Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/mm/srmmu.c |   53 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 52 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index ade4eb3..509b1ff 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -46,6 +46,7 @@
 #include <asm/tsunami.h>
 #include <asm/swift.h>
 #include <asm/turbosparc.h>
+#include <asm/leon.h>
 
 #include <asm/btfixup.h>
 
@@ -569,6 +570,9 @@ static void srmmu_switch_mm(struct mm_struct *old_mm, struct mm_struct *mm,
 		srmmu_ctxd_set(&srmmu_context_table[mm->context], mm->pgd);
 	}
 
+	if (sparc_cpu_model = sparc_leon)
+		leon_switch_mm();
+
 	if (is_hypersparc)
 		hyper_flush_whole_icache();
 
@@ -1977,6 +1981,45 @@ static void __init init_viking(void)
 	poke_srmmu = poke_viking;
 }
 
+#ifdef CONFIG_SPARC_LEON
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
+#endif
+
 /* Probe for the srmmu chip version. */
 static void __init get_srmmu_type(void)
 {
@@ -1992,7 +2035,15 @@ static void __init get_srmmu_type(void)
 	psr_typ = (psr >> 28) & 0xf;
 	psr_vers = (psr >> 24) & 0xf;
 
-	/* First, check for HyperSparc or Cypress. */
+	/* First, check for sparc-leon. */
+	if (sparc_cpu_model = sparc_leon) {
+		psr_typ = 0xf;	/* hardcoded ids for older models/simulators */
+		psr_vers = 2;
+		init_leon();
+		return;
+	}
+
+	/* Second, check for HyperSparc or Cypress. */
 	if(mod_typ = 1) {
 		switch(mod_rev) {
 		case 7:
-- 
1.6.3.2

