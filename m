From: Mike Rapoport <rppt@kernel.org>
Date: Sat, 27 Jun 2020 08:16:53 +0000
Subject: [PATCH v2 2/2] sparc32: srmmu: improve type safety of __nocache_fix()
Message-Id: <20200627081653.25311-3-rppt@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20200627081653.25311-1-rppt@kernel.org>
In-Reply-To: <20200627081653.25311-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org
Cc: David Miller <davem@davemloft.net>, Linus Torvalds <torvalds@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>

From: Mike Rapoport <rppt@linux.ibm.com>

The __nocache_fix(VADDR) macro is used to add an offset for pointers and
its "return type" is 'void *'.

We can do better and keep the type information with simply by casting the
return value to (__typeof__(VADDR)).

This will  ".. show when those pgd/p4d/pud pointers get mis-used because
they don't end up dropping the type info.."

The addition of the casting to __nocache_fix() also allows to remove
explicit casts at its call sites.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Link: https://lkml.kernel.org/r/CAHk-=wisORTa7QVPnFqNw9pFs62UiwgsD4C4d=MtYy1o4JPyGQ@mail.gmail.com
---
 arch/sparc/include/asm/pgtsrmmu.h |  2 +-
 arch/sparc/mm/srmmu.c             | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/include/asm/pgtsrmmu.h b/arch/sparc/include/asm/pgtsrmmu.h
index 7708d015712b..6067925972d9 100644
--- a/arch/sparc/include/asm/pgtsrmmu.h
+++ b/arch/sparc/include/asm/pgtsrmmu.h
@@ -113,7 +113,7 @@ extern unsigned long last_valid_pfn;
 extern void *srmmu_nocache_pool;
 #define __nocache_pa(VADDR) (((unsigned long)VADDR) - SRMMU_NOCACHE_VADDR + __pa((unsigned long)srmmu_nocache_pool))
 #define __nocache_va(PADDR) (__va((unsigned long)PADDR) - (unsigned long)srmmu_nocache_pool + SRMMU_NOCACHE_VADDR)
-#define __nocache_fix(VADDR) __va(__nocache_pa(VADDR))
+#define __nocache_fix(VADDR) ((__typeof__(VADDR))__va(__nocache_pa(VADDR)))
 
 /* Accessing the MMU control register. */
 unsigned int srmmu_get_mmureg(void);
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index f5fa07958f34..da4e10b4cb37 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -689,7 +689,7 @@ static void __init srmmu_early_allocate_ptable_skeleton(unsigned long start,
 		pgdp = pgd_offset_k(start);
 		p4dp = p4d_offset(pgdp, start);
 		pudp = pud_offset(p4dp, start);
-		if (pud_none(*(pud_t *)__nocache_fix(pudp))) {
+		if (pud_none(*__nocache_fix(pudp))) {
 			pmdp = __srmmu_get_nocache(
 			    SRMMU_PMD_TABLE_SIZE, SRMMU_PMD_TABLE_SIZE);
 			if (pmdp = NULL)
@@ -698,7 +698,7 @@ static void __init srmmu_early_allocate_ptable_skeleton(unsigned long start,
 			pud_set(__nocache_fix(pudp), pmdp);
 		}
 		pmdp = pmd_offset(__nocache_fix(pudp), start);
-		if (srmmu_pmd_none(*(pmd_t *)__nocache_fix(pmdp))) {
+		if (srmmu_pmd_none(*__nocache_fix(pmdp))) {
 			ptep = __srmmu_get_nocache(PTE_SIZE, PTE_SIZE);
 			if (ptep = NULL)
 				early_pgtable_allocfail("pte");
@@ -810,11 +810,11 @@ static void __init srmmu_inherit_prom_mappings(unsigned long start,
 		p4dp = p4d_offset(pgdp, start);
 		pudp = pud_offset(p4dp, start);
 		if (what = 2) {
-			*(pgd_t *)__nocache_fix(pgdp) = __pgd(probed);
+			*__nocache_fix(pgdp) = __pgd(probed);
 			start += PGDIR_SIZE;
 			continue;
 		}
-		if (pud_none(*(pud_t *)__nocache_fix(pudp))) {
+		if (pud_none(*__nocache_fix(pudp))) {
 			pmdp = __srmmu_get_nocache(SRMMU_PMD_TABLE_SIZE,
 						   SRMMU_PMD_TABLE_SIZE);
 			if (pmdp = NULL)
@@ -828,7 +828,7 @@ static void __init srmmu_inherit_prom_mappings(unsigned long start,
 			start += PMD_SIZE;
 			continue;
 		}
-		if (srmmu_pmd_none(*(pmd_t *)__nocache_fix(pmdp))) {
+		if (srmmu_pmd_none(*__nocache_fix(pmdp))) {
 			ptep = __srmmu_get_nocache(PTE_SIZE, PTE_SIZE);
 			if (ptep = NULL)
 				early_pgtable_allocfail("pte");
@@ -836,7 +836,7 @@ static void __init srmmu_inherit_prom_mappings(unsigned long start,
 			pmd_set(__nocache_fix(pmdp), ptep);
 		}
 		ptep = pte_offset_kernel(__nocache_fix(pmdp), start);
-		*(pte_t *)__nocache_fix(ptep) = __pte(probed);
+		*__nocache_fix(ptep) = __pte(probed);
 		start += PAGE_SIZE;
 	}
 }
@@ -850,7 +850,7 @@ static void __init do_large_mapping(unsigned long vaddr, unsigned long phys_base
 	unsigned long big_pte;
 
 	big_pte = KERNEL_PTE(phys_base >> 4);
-	*(pgd_t *)__nocache_fix(pgdp) = __pgd(big_pte);
+	*__nocache_fix(pgdp) = __pgd(big_pte);
 }
 
 /* Map sp_bank entry SP_ENTRY, starting at virtual address VBASE. */
@@ -940,7 +940,7 @@ void __init srmmu_paging_init(void)
 	srmmu_ctx_table_phys = (ctxd_t *)__nocache_pa(srmmu_context_table);
 
 	for (i = 0; i < num_contexts; i++)
-		srmmu_ctxd_set((ctxd_t *)__nocache_fix(&srmmu_context_table[i]), srmmu_swapper_pg_dir);
+		srmmu_ctxd_set(__nocache_fix(&srmmu_context_table[i]), srmmu_swapper_pg_dir);
 
 	flush_cache_all();
 	srmmu_set_ctable_ptr((unsigned long)srmmu_ctx_table_phys);
-- 
2.26.2
