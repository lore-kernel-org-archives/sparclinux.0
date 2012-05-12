From: David Miller <davem@davemloft.net>
Date: Sat, 12 May 2012 19:06:57 +0000
Subject: [PATCH] sparc32: Un-btfixup PGDIR_{SHIFT,SIZE,MASK} {USER_,}PTRS_PER_{PGD,PMD}
Message-Id: <20120512.150657.291312435367814872.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Only one set of values exist, the SRMMU ones.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/pgtable_32.h |   20 ++++++--------------
 arch/sparc/mm/srmmu.c               |    9 ---------
 2 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index 4a29b05..2271185 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -28,14 +28,6 @@ struct page;
 extern void load_mmu(void);
 extern unsigned long calc_highpages(void);
 
-BTFIXUPDEF_SIMM13(pgdir_shift)
-BTFIXUPDEF_SETHI(pgdir_size)
-BTFIXUPDEF_SETHI(pgdir_mask)
-
-BTFIXUPDEF_SIMM13(ptrs_per_pmd)
-BTFIXUPDEF_SIMM13(ptrs_per_pgd)
-BTFIXUPDEF_SIMM13(user_ptrs_per_pgd)
-
 #define pte_ERROR(e)   __builtin_trap()
 #define pmd_ERROR(e)   __builtin_trap()
 #define pgd_ERROR(e)   __builtin_trap()
@@ -49,13 +41,13 @@ BTFIXUPDEF_INT(page_kernel)
 #define PMD_SIZE        	(1UL << PMD_SHIFT)
 #define PMD_MASK        	(~(PMD_SIZE-1))
 #define PMD_ALIGN(__addr) 	(((__addr) + ~PMD_MASK) & PMD_MASK)
-#define PGDIR_SHIFT     	BTFIXUP_SIMM13(pgdir_shift)
-#define PGDIR_SIZE      	BTFIXUP_SETHI(pgdir_size)
-#define PGDIR_MASK      	BTFIXUP_SETHI(pgdir_mask)
+#define PGDIR_SHIFT     	SRMMU_PGDIR_SHIFT
+#define PGDIR_SIZE      	SRMMU_PGDIR_SIZE
+#define PGDIR_MASK      	SRMMU_PGDIR_MASK
 #define PTRS_PER_PTE    	1024
-#define PTRS_PER_PMD    	BTFIXUP_SIMM13(ptrs_per_pmd)
-#define PTRS_PER_PGD    	BTFIXUP_SIMM13(ptrs_per_pgd)
-#define USER_PTRS_PER_PGD	BTFIXUP_SIMM13(user_ptrs_per_pgd)
+#define PTRS_PER_PMD    	SRMMU_PTRS_PER_PMD
+#define PTRS_PER_PGD    	SRMMU_PTRS_PER_PGD
+#define USER_PTRS_PER_PGD	PAGE_OFFSET / SRMMU_PGDIR_SIZE
 #define FIRST_USER_ADDRESS	0
 #define PTE_SIZE		(PTRS_PER_PTE*4)
 
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index cb18fa8..38fcb83a 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -1248,8 +1248,6 @@ static inline void map_kernel(void)
 	for (i = 0; sp_banks[i].num_bytes != 0; i++) {
 		map_spbank((unsigned long)__va(sp_banks[i].base_addr), i);
 	}
-
-	BTFIXUPSET_SIMM13(user_ptrs_per_pgd, PAGE_OFFSET / SRMMU_PGDIR_SIZE);
 }
 
 /* Paging initialization on the Sparc Reference MMU. */
@@ -2145,13 +2143,6 @@ void __init ld_mmu_srmmu(void)
 	extern void ld_mmu_iounit(void);
 	extern void ___xchg32_sun4md(void);
 
-	BTFIXUPSET_SIMM13(pgdir_shift, SRMMU_PGDIR_SHIFT);
-	BTFIXUPSET_SETHI(pgdir_size, SRMMU_PGDIR_SIZE);
-	BTFIXUPSET_SETHI(pgdir_mask, SRMMU_PGDIR_MASK);
-
-	BTFIXUPSET_SIMM13(ptrs_per_pmd, SRMMU_PTRS_PER_PMD);
-	BTFIXUPSET_SIMM13(ptrs_per_pgd, SRMMU_PTRS_PER_PGD);
-
 	BTFIXUPSET_INT(page_none, pgprot_val(SRMMU_PAGE_NONE));
 	PAGE_SHARED = pgprot_val(SRMMU_PAGE_SHARED);
 	BTFIXUPSET_INT(page_copy, pgprot_val(SRMMU_PAGE_COPY));
-- 
1.7.10

