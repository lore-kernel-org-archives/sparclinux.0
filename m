From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 11 May 2012 21:35:17 +0000
Subject: [PATCH 14/14] sparc32: use inline versions of pgprot_noncached, pte_to_pgoff and pgoff_to_pte
Message-Id: <1336772117-1539-14-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

We no longer have different versions of these so use a few simple
static inline functions.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/pgtable_32.h |   20 ++++++++++++++------
 arch/sparc/kernel/sparc_ksyms_32.c  |    1 -
 arch/sparc/mm/srmmu.c               |   21 ---------------------
 3 files changed, 14 insertions(+), 28 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index 225030b..f451d43 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -267,13 +267,17 @@ BTFIXUPDEF_CALL_CONST(pte_t, mk_pte, struct page *, pgprot_t)
 
 BTFIXUPDEF_CALL_CONST(pte_t, mk_pte_phys, unsigned long, pgprot_t)
 BTFIXUPDEF_CALL_CONST(pte_t, mk_pte_io, unsigned long, pgprot_t, int)
-BTFIXUPDEF_CALL_CONST(pgprot_t, pgprot_noncached, pgprot_t)
 
 #define mk_pte(page,pgprot) BTFIXUP_CALL(mk_pte)(page,pgprot)
 #define mk_pte_phys(page,pgprot) BTFIXUP_CALL(mk_pte_phys)(page,pgprot)
 #define mk_pte_io(page,pgprot,space) BTFIXUP_CALL(mk_pte_io)(page,pgprot,space)
 
-#define pgprot_noncached(pgprot) BTFIXUP_CALL(pgprot_noncached)(pgprot)
+#define pgprot_noncached pgprot_noncached
+static inline pgprot_t pgprot_noncached(pgprot_t prot)
+{
+	prot &= ~__pgprot(SRMMU_CACHE);
+	return prot;
+}
 
 BTFIXUPDEF_INT(pte_modify_mask)
 
@@ -352,11 +356,15 @@ BTFIXUPDEF_CALL(swp_entry_t, __swp_entry, unsigned long, unsigned long)
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val })
 
 /* file-offset-in-pte helpers */
-BTFIXUPDEF_CALL(unsigned long, pte_to_pgoff, pte_t pte);
-BTFIXUPDEF_CALL(pte_t, pgoff_to_pte, unsigned long pgoff);
+static inline unsigned long pte_to_pgoff(pte_t pte)
+{
+	return pte_val(pte) >> SRMMU_PTE_FILE_SHIFT;
+}
 
-#define pte_to_pgoff(pte) BTFIXUP_CALL(pte_to_pgoff)(pte)
-#define pgoff_to_pte(off) BTFIXUP_CALL(pgoff_to_pte)(off)
+static inline pte_t pgoff_to_pte(unsigned long pgoff)
+{
+	return __pte((pgoff << SRMMU_PTE_FILE_SHIFT) | SRMMU_FILE);
+}
 
 /*
  * This is made a constant because mm/fremap.c required a constant.
diff --git a/arch/sparc/kernel/sparc_ksyms_32.c b/arch/sparc/kernel/sparc_ksyms_32.c
index baeab87..fd38a92 100644
--- a/arch/sparc/kernel/sparc_ksyms_32.c
+++ b/arch/sparc/kernel/sparc_ksyms_32.c
@@ -40,7 +40,6 @@ EXPORT_SYMBOL(BTFIXUP_CALL(mmu_get_scsi_sgl));
 EXPORT_SYMBOL(BTFIXUP_CALL(mmu_get_scsi_one));
 EXPORT_SYMBOL(BTFIXUP_CALL(mmu_release_scsi_sgl));
 EXPORT_SYMBOL(BTFIXUP_CALL(mmu_release_scsi_one));
-EXPORT_SYMBOL(BTFIXUP_CALL(pgprot_noncached));
 
 /* Exporting a symbol from /init/main.c */
 EXPORT_SYMBOL(saved_command_line);
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 2663b92..d85da15 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -2144,23 +2144,6 @@ static void smp_flush_page_for_dma(unsigned long page)
 
 #endif
 
-static pte_t srmmu_pgoff_to_pte(unsigned long pgoff)
-{
-	return __pte((pgoff << SRMMU_PTE_FILE_SHIFT) | SRMMU_FILE);
-}
-
-static unsigned long srmmu_pte_to_pgoff(pte_t pte)
-{
-	return pte_val(pte) >> SRMMU_PTE_FILE_SHIFT;
-}
-
-static pgprot_t srmmu_pgprot_noncached(pgprot_t prot)
-{
-	prot &= ~__pgprot(SRMMU_CACHE);
-
-	return prot;
-}
-
 /* Load up routines and constants for sun4m and sun4d mmu */
 void __init ld_mmu_srmmu(void)
 {
@@ -2183,7 +2166,6 @@ void __init ld_mmu_srmmu(void)
 	page_kernel = pgprot_val(SRMMU_PAGE_KERNEL);
 
 	/* Functions */
-	BTFIXUPSET_CALL(pgprot_noncached, srmmu_pgprot_noncached, BTFIXUPCALL_NORM);
 #ifndef CONFIG_SMP	
 	BTFIXUPSET_CALL(___xchg32, ___xchg32_sun4md, BTFIXUPCALL_SWAPG1G2);
 #endif
@@ -2250,9 +2232,6 @@ void __init ld_mmu_srmmu(void)
 
 	BTFIXUPSET_CALL(mmu_info, srmmu_mmu_info, BTFIXUPCALL_NORM);
 
-	BTFIXUPSET_CALL(pte_to_pgoff, srmmu_pte_to_pgoff, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(pgoff_to_pte, srmmu_pgoff_to_pte, BTFIXUPCALL_NORM);
-
 	get_srmmu_type();
 
 #ifdef CONFIG_SMP
-- 
1.6.0.6

