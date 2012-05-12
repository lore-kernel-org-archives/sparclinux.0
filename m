From: David Miller <davem@davemloft.net>
Date: Sat, 12 May 2012 20:59:44 +0000
Subject: [PATCH] sparc32: Un-btfixup more PTE constants and PTE ops.
Message-Id: <20120512.165944.255713204352831514.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


pte_{filei,wrprotecti,mkcleani,mkoldi}
pte_{mkwrite,mkdirty,mkyoung}

Signed-off-by: David S. Miller <davem@davemloft.net>
---

Ok, that's enough for now, I think I'll take a little break
and continue with this later today :-)

 arch/sparc/include/asm/pgtable_32.h |   39 +++++++++++++++--------------------
 arch/sparc/mm/srmmu.c               |   16 --------------
 2 files changed, 17 insertions(+), 38 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index 4b46396..6c823f9 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -225,12 +225,9 @@ static inline int pte_young(pte_t pte)
 /*
  * The following only work if pte_present() is not true.
  */
-BTFIXUPDEF_HALF(pte_filei)
-
-static int pte_file(pte_t pte) __attribute_const__;
 static inline int pte_file(pte_t pte)
 {
-	return pte_val(pte) & BTFIXUP_HALF(pte_filei);
+	return pte_val(pte) & SRMMU_FILE;
 }
 
 static inline int pte_special(pte_t pte)
@@ -238,37 +235,35 @@ static inline int pte_special(pte_t pte)
 	return 0;
 }
 
-/*
- */
-BTFIXUPDEF_HALF(pte_wrprotecti)
-BTFIXUPDEF_HALF(pte_mkcleani)
-BTFIXUPDEF_HALF(pte_mkoldi)
-
-static pte_t pte_wrprotect(pte_t pte) __attribute_const__;
 static inline pte_t pte_wrprotect(pte_t pte)
 {
-	return __pte(pte_val(pte) & ~BTFIXUP_HALF(pte_wrprotecti));
+	return __pte(pte_val(pte) & ~SRMMU_WRITE);
 }
 
-static pte_t pte_mkclean(pte_t pte) __attribute_const__;
 static inline pte_t pte_mkclean(pte_t pte)
 {
-	return __pte(pte_val(pte) & ~BTFIXUP_HALF(pte_mkcleani));
+	return __pte(pte_val(pte) & ~SRMMU_DIRTY);
 }
 
-static pte_t pte_mkold(pte_t pte) __attribute_const__;
 static inline pte_t pte_mkold(pte_t pte)
 {
-	return __pte(pte_val(pte) & ~BTFIXUP_HALF(pte_mkoldi));
+	return __pte(pte_val(pte) & ~SRMMU_REF);
 }
 
-BTFIXUPDEF_CALL_CONST(pte_t, pte_mkwrite, pte_t)
-BTFIXUPDEF_CALL_CONST(pte_t, pte_mkdirty, pte_t)
-BTFIXUPDEF_CALL_CONST(pte_t, pte_mkyoung, pte_t)
+static inline pte_t pte_mkwrite(pte_t pte)
+{
+	return __pte(pte_val(pte) | SRMMU_WRITE);
+}
 
-#define pte_mkwrite(pte) BTFIXUP_CALL(pte_mkwrite)(pte)
-#define pte_mkdirty(pte) BTFIXUP_CALL(pte_mkdirty)(pte)
-#define pte_mkyoung(pte) BTFIXUP_CALL(pte_mkyoung)(pte)
+static inline pte_t pte_mkdirty(pte_t pte)
+{
+	return __pte(pte_val(pte) | SRMMU_DIRTY);
+}
+
+static inline pte_t pte_mkyoung(pte_t pte)
+{
+	return __pte(pte_val(pte) | SRMMU_REF);
+}
 
 #define pte_mkspecial(pte)    (pte)
 
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index b01c735..54efa92 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -128,15 +128,6 @@ static inline pte_t srmmu_pte_mkclean(pte_t pte)
 static inline pte_t srmmu_pte_mkold(pte_t pte)
 { return __pte(pte_val(pte) & ~SRMMU_REF);}
 
-static inline pte_t srmmu_pte_mkwrite(pte_t pte)
-{ return __pte(pte_val(pte) | SRMMU_WRITE);}
-
-static inline pte_t srmmu_pte_mkdirty(pte_t pte)
-{ return __pte(pte_val(pte) | SRMMU_DIRTY);}
-
-static inline pte_t srmmu_pte_mkyoung(pte_t pte)
-{ return __pte(pte_val(pte) | SRMMU_REF);}
-
 /* XXX should we hyper_flush_whole_icache here - Anton */
 static inline void srmmu_ctxd_set(ctxd_t *ctxp, pgd_t *pgdp)
 { set_pte((pte_t *)ctxp, (SRMMU_ET_PTD | (__nocache_pa((unsigned long) pgdp) >> 4))); }
@@ -2073,13 +2064,6 @@ void __init load_mmu(void)
 	BTFIXUPSET_CALL(free_pgd_fast, srmmu_free_pgd_fast, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(get_pgd_fast, srmmu_get_pgd_fast, BTFIXUPCALL_NORM);
 
-	BTFIXUPSET_HALF(pte_filei, SRMMU_FILE);
-	BTFIXUPSET_HALF(pte_wrprotecti, SRMMU_WRITE);
-	BTFIXUPSET_HALF(pte_mkcleani, SRMMU_DIRTY);
-	BTFIXUPSET_HALF(pte_mkoldi, SRMMU_REF);
-	BTFIXUPSET_CALL(pte_mkwrite, srmmu_pte_mkwrite, BTFIXUPCALL_ORINT(SRMMU_WRITE));
-	BTFIXUPSET_CALL(pte_mkdirty, srmmu_pte_mkdirty, BTFIXUPCALL_ORINT(SRMMU_DIRTY));
-	BTFIXUPSET_CALL(pte_mkyoung, srmmu_pte_mkyoung, BTFIXUPCALL_ORINT(SRMMU_REF));
 	BTFIXUPSET_CALL(update_mmu_cache, srmmu_update_mmu_cache, BTFIXUPCALL_NOP);
 	BTFIXUPSET_CALL(destroy_context, srmmu_destroy_context, BTFIXUPCALL_NORM);
 
-- 
1.7.10

