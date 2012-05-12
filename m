From: David Miller <davem@davemloft.net>
Date: Sat, 12 May 2012 20:35:34 +0000
Subject: [PATCH] sparc32: Un-btfixup pmd_{bad,present}().
Message-Id: <20120512.163534.277257917580558260.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/pgtable_32.h |   14 +++++++++-----
 arch/sparc/mm/srmmu.c               |    9 ---------
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index 9b4ff5a..ac85f9b 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -153,17 +153,21 @@ static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *pt
 	__pte_clear(ptep);
 }
 
-BTFIXUPDEF_CALL_CONST(int, pmd_bad, pmd_t)
-BTFIXUPDEF_CALL_CONST(int, pmd_present, pmd_t)
+static inline int pmd_bad(pmd_t pmd)
+{
+	return (pmd_val(pmd) & SRMMU_ET_MASK) != SRMMU_ET_PTD;
+}
+
+static inline int pmd_present(pmd_t pmd)
+{
+	return ((pmd_val(pmd) & SRMMU_ET_MASK) = SRMMU_ET_PTD);
+}
 
 static inline int pmd_none(pmd_t pmd)
 {
 	return !pmd_val(pmd);
 }
 
-#define pmd_bad(pmd) BTFIXUP_CALL(pmd_bad)(pmd)
-#define pmd_present(pmd) BTFIXUP_CALL(pmd_present)(pmd)
-
 static inline void pmd_clear(pmd_t *pmdp)
 {
 	int i;
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 94dcd06..87e4d32 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -118,12 +118,6 @@ static inline int srmmu_pte_present(pte_t pte)
 static inline int srmmu_pmd_none(pmd_t pmd)
 { return !(pmd_val(pmd) & 0xFFFFFFF); }
 
-static inline int srmmu_pmd_bad(pmd_t pmd)
-{ return (pmd_val(pmd) & SRMMU_ET_MASK) != SRMMU_ET_PTD; }
-
-static inline int srmmu_pmd_present(pmd_t pmd)
-{ return ((pmd_val(pmd) & SRMMU_ET_MASK) = SRMMU_ET_PTD); }
-
 static inline pte_t srmmu_pte_wrprotect(pte_t pte)
 { return __pte(pte_val(pte) & ~SRMMU_WRITE);}
 
@@ -2078,9 +2072,6 @@ void __init ld_mmu_srmmu(void)
 
 	BTFIXUPSET_CALL(pte_present, srmmu_pte_present, BTFIXUPCALL_NORM);
 
-	BTFIXUPSET_CALL(pmd_bad, srmmu_pmd_bad, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(pmd_present, srmmu_pmd_present, BTFIXUPCALL_NORM);
-
 	BTFIXUPSET_CALL(mk_pte, srmmu_mk_pte, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(mk_pte_phys, srmmu_mk_pte_phys, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(mk_pte_io, srmmu_mk_pte_io, BTFIXUPCALL_NORM);
-- 
1.7.10

