From: David Miller <davem@davemloft.net>
Date: Sat, 12 May 2012 20:52:20 +0000
Subject: [PATCH] sparc32: Un-btfixup pte_{write,dirty,young}i
Message-Id: <20120512.165220.1627852169816157089.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


And we can certainly get rid of the const function attributes, there
is no way that's needed any longer and no other arch uses this kind
of annotation here.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/pgtable_32.h |   13 +++----------
 arch/sparc/mm/srmmu.c               |    3 ---
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index 62e34d9..4b46396 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -207,26 +207,19 @@ static inline void pgd_clear(pgd_t *pgdp)
  * The following only work if pte_present() is true.
  * Undefined behaviour if not..
  */
-BTFIXUPDEF_HALF(pte_writei)
-BTFIXUPDEF_HALF(pte_dirtyi)
-BTFIXUPDEF_HALF(pte_youngi)
-
-static int pte_write(pte_t pte) __attribute_const__;
 static inline int pte_write(pte_t pte)
 {
-	return pte_val(pte) & BTFIXUP_HALF(pte_writei);
+	return pte_val(pte) & SRMMU_WRITE;
 }
 
-static int pte_dirty(pte_t pte) __attribute_const__;
 static inline int pte_dirty(pte_t pte)
 {
-	return pte_val(pte) & BTFIXUP_HALF(pte_dirtyi);
+	return pte_val(pte) & SRMMU_DIRTY;
 }
 
-static int pte_young(pte_t pte) __attribute_const__;
 static inline int pte_young(pte_t pte)
 {
-	return pte_val(pte) & BTFIXUP_HALF(pte_youngi);
+	return pte_val(pte) & SRMMU_REF;
 }
 
 /*
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 224db00..b01c735 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -2073,9 +2073,6 @@ void __init load_mmu(void)
 	BTFIXUPSET_CALL(free_pgd_fast, srmmu_free_pgd_fast, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(get_pgd_fast, srmmu_get_pgd_fast, BTFIXUPCALL_NORM);
 
-	BTFIXUPSET_HALF(pte_writei, SRMMU_WRITE);
-	BTFIXUPSET_HALF(pte_dirtyi, SRMMU_DIRTY);
-	BTFIXUPSET_HALF(pte_youngi, SRMMU_REF);
 	BTFIXUPSET_HALF(pte_filei, SRMMU_FILE);
 	BTFIXUPSET_HALF(pte_wrprotecti, SRMMU_WRITE);
 	BTFIXUPSET_HALF(pte_mkcleani, SRMMU_DIRTY);
-- 
1.7.10

