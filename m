From: Konrad Eisele <konrad@gaisler.com>
Date: Tue, 09 Jun 2009 11:22:22 +0000
Subject: [PATCH 7/7] sparc-leon specific SRMMU initialization
Message-Id: <4A2E45EE.40007@gaisler.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------040301030600060906060703"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------040301030600060906060703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

 From 070d1215c236a01aad7eff61858744a6b05ea1ca Mon Sep 17 00:00:00 2001
From: Konrad Eisele <konrad@gaisler.com>
Date: Tue, 9 Jun 2009 13:07:17 +0200
Subject: [PATCH 7/7] sparc-leon specific SRMMU initialization and
bootup fixes. The sparc-leon caches are
virtually tagged so a flush is needed on ctx
switch.

Signed-off-by: Konrad Eisele <konrad@gaisler.com>
---
  arch/sparc/mm/srmmu.c |   67 +++++++++++++++++++++++++++++++++++++++++++++++++
  1 files changed, 67 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 06c9a7d..7bf9ecd 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -46,6 +46,10 @@ #include <asm/tsunami.h>
  #include <asm/swift.h>
  #include <asm/turbosparc.h>

+#if defined(CONFIG_LEON)
+#include <asm/leon.h>
+#endif
+
  #include <asm/btfixup.h>

  enum mbus_module srmmu_modtype;
@@ -568,6 +572,11 @@ static void srmmu_switch_mm(struct mm_st
  		srmmu_ctxd_set(&srmmu_context_table[mm->context], mm->pgd);
  	}

+#if defined(CONFIG_LEON)
+	flush_tlb_mm(0);
+	if (leon_flush_during_switch)
+		leon_flush_cache_all();
+#endif
  	if (is_hypersparc)
  		hyper_flush_whole_icache();

@@ -1976,6 +1985,57 @@ #endif
  	poke_srmmu = poke_viking;
  }

+#if defined(CONFIG_LEON)
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
+
+#endif
+
  /* Probe for the srmmu chip version. */
  static void __init get_srmmu_type(void)
  {
@@ -1991,6 +2051,13 @@ static void __init get_srmmu_type(void)
  	psr_typ = (psr >> 28) & 0xf;
  	psr_vers = (psr >> 24) & 0xf;

+#ifdef CONFIG_LEON
+	psr_typ = 0xf;	/* hardcoded ids for older models/simulators */
+	psr_vers = 2;
+	init_leon();
+	return;
+#endif
+
  	/* First, check for HyperSparc or Cypress. */
  	if(mod_typ == 1) {
  		switch(mod_rev) {
-- 
1.4.2.1


--------------040301030600060906060703
Content-Type: text/plain;
 name="0007-sparc-leon-specific-SRMMU-initialization-and.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0007-sparc-leon-specific-SRMMU-initialization-and.txt"

From 070d1215c236a01aad7eff61858744a6b05ea1ca Mon Sep 17 00:00:00 2001
From: Konrad Eisele <konrad@gaisler.com>
Date: Tue, 9 Jun 2009 13:07:17 +0200
Subject: [PATCH 7/7] sparc-leon specific SRMMU initialization and
bootup fixes. The sparc-leon caches are
virtually tagged so a flush is needed on ctx
switch.

Signed-off-by: Konrad Eisele <konrad@gaisler.com>
---
 arch/sparc/mm/srmmu.c |   67 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 67 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 06c9a7d..7bf9ecd 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -46,6 +46,10 @@ #include <asm/tsunami.h>
 #include <asm/swift.h>
 #include <asm/turbosparc.h>
 
+#if defined(CONFIG_LEON)
+#include <asm/leon.h>
+#endif
+
 #include <asm/btfixup.h>
 
 enum mbus_module srmmu_modtype;
@@ -568,6 +572,11 @@ static void srmmu_switch_mm(struct mm_st
 		srmmu_ctxd_set(&srmmu_context_table[mm->context], mm->pgd);
 	}
 
+#if defined(CONFIG_LEON)
+	flush_tlb_mm(0);
+	if (leon_flush_during_switch)
+		leon_flush_cache_all();
+#endif
 	if (is_hypersparc)
 		hyper_flush_whole_icache();
 
@@ -1976,6 +1985,57 @@ #endif
 	poke_srmmu = poke_viking;
 }
 
+#if defined(CONFIG_LEON)
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
+
+#endif
+
 /* Probe for the srmmu chip version. */
 static void __init get_srmmu_type(void)
 {
@@ -1991,6 +2051,13 @@ static void __init get_srmmu_type(void)
 	psr_typ = (psr >> 28) & 0xf;
 	psr_vers = (psr >> 24) & 0xf;
 
+#ifdef CONFIG_LEON
+	psr_typ = 0xf;	/* hardcoded ids for older models/simulators */
+	psr_vers = 2;
+	init_leon();
+	return;
+#endif
+
 	/* First, check for HyperSparc or Cypress. */
 	if(mod_typ == 1) {
 		switch(mod_rev) {
-- 
1.4.2.1


--------------040301030600060906060703--
