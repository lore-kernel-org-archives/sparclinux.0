From: Mike Rapoport <rppt@kernel.org>
Date: Sun, 24 May 2020 16:21:51 +0000
Subject: [PATCH 2/2] sparc32: srmmu: improve type safety of __nocache_fix()
Message-Id: <20200524162151.3493-3-rppt@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20200524162151.3493-1-rppt@kernel.org>
In-Reply-To: <20200524162151.3493-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>, Mike Rapoport <rppt@linux.ibm.com>

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
Link: https://lkml.kernel.org/stablestablestablestablestabler/CAHk-=wisORTa7QVPnFqNw9pFs62UiwgsD4C4d=MtYy1o4JPyGQ@mail.gmail.com
---
 arch/sparc/include/asm/pgtsrmmu.h |  2 +-
 arch/sparc/mm/srmmu.c             | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/include/asm/pgtsrmmu.h b/arch/sparc/include/asm/pgtsrmmu.h
index 32a508897501..941d42a59b81 100644
--- a/arch/sparc/include/asm/pgtsrmmu.h
+++ b/arch/sparc/include/asm/pgtsrmmu.h
@@ -143,7 +143,7 @@ extern unsigned long last_valid_pfn;
 extern void *srmmu_nocache_pool;
 #define __nocache_pa(VADDR) (((unsigned long)VADDR) - SRMMU_NOCACHE_VADDR + __pa((unsigned long)srmmu_nocache_pool))
 #define __nocache_va(PADDR) (__va((unsigned long)PADDR) - (unsigned long)srmmu_nocache_pool + SRMMU_NOCACHE_VADDR)
-#define __nocache_fix(VADDR) __va(__nocache_pa(VADDR))
+#define __nocache_fix(VADDR) ((__typeof__(VADDR))__va(__nocache_pa(VADDR)))
 
 /* Accessing the MMU control register. */
 unsigned int srmmu_get_mmureg(void);
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index dbf5334dd084..d86e6c657922 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -724,7 +724,7 @@ static void __init srmmu_early_allocate_ptable_skeleton(unsigned long start,
 			pud_set(__nocache_fix(pudp), pmdp);
 		}
 		pmdp = pmd_offset(__nocache_fix(pudp), start);
-		if (srmmu_pmd_none(*(pmd_t *)__nocache_fix(pmdp))) {
+		if (srmmu_pmd_none(*__nocache_fix(pmdp))) {
 			ptep = __srmmu_get_nocache(PTE_SIZE, PTE_SIZE);
 			if (ptep = NULL)
 				early_pgtable_allocfail("pte");
@@ -836,11 +836,11 @@ static void __init srmmu_inherit_prom_mappings(unsigned long start,
 		p4dp = p4d_offset(pgdp, start);
 		pudp = pud_offset(p4dp, start);
 		if (what = 2) {
-			*(pgd_t *)__nocache_fix(pgdp) = __pgd(probed);
+			*__nocache_fix(pgdp) = __pgd(probed);
 			start += SRMMU_PGDIR_SIZE;
 			continue;
 		}
-		if (pud_none(*(pud_t *)__nocache_fix(pudp))) {
+		if (pud_none(*__nocache_fix(pudp))) {
 			pmdp = __srmmu_get_nocache(SRMMU_PMD_TABLE_SIZE,
 						   SRMMU_PMD_TABLE_SIZE);
 			if (pmdp = NULL)
@@ -849,7 +849,7 @@ static void __init srmmu_inherit_prom_mappings(unsigned long start,
 			pud_set(__nocache_fix(pudp), pmdp);
 		}
 		pmdp = pmd_offset(__nocache_fix(pudp), start);
-		if (srmmu_pmd_none(*(pmd_t *)__nocache_fix(pmdp))) {
+		if (srmmu_pmd_none(*__nocache_fix(pmdp))) {
 			ptep = __srmmu_get_nocache(PTE_SIZE, PTE_SIZE);
 			if (ptep = NULL)
 				early_pgtable_allocfail("pte");
@@ -865,12 +865,12 @@ static void __init srmmu_inherit_prom_mappings(unsigned long start,
 			unsigned long *val;
 			x = (start >> PMD_SHIFT) & 15;
 			val = &pmdp->pmdv[x];
-			*(unsigned long *)__nocache_fix(val) = probed;
+			*__nocache_fix(val) = probed;
 			start += SRMMU_REAL_PMD_SIZE;
 			continue;
 		}
 		ptep = pte_offset_kernel(__nocache_fix(pmdp), start);
-		*(pte_t *)__nocache_fix(ptep) = __pte(probed);
+		*__nocache_fix(ptep) = __pte(probed);
 		start += PAGE_SIZE;
 	}
 }
@@ -884,7 +884,7 @@ static void __init do_large_mapping(unsigned long vaddr, unsigned long phys_base
 	unsigned long big_pte;
 
 	big_pte = KERNEL_PTE(phys_base >> 4);
-	*(pgd_t *)__nocache_fix(pgdp) = __pgd(big_pte);
+	*__nocache_fix(pgdp) = __pgd(big_pte);
 }
 
 /* Map sp_bank entry SP_ENTRY, starting at virtual address VBASE. */
@@ -974,7 +974,7 @@ void __init srmmu_paging_init(void)
 	srmmu_ctx_table_phys = (ctxd_t *)__nocache_pa(srmmu_context_table);
 
 	for (i = 0; i < num_contexts; i++)
-		srmmu_ctxd_set((ctxd_t *)__nocache_fix(&srmmu_context_table[i]), srmmu_swapper_pg_dir);
+		srmmu_ctxd_set(__nocache_fix(&srmmu_context_table[i]), srmmu_swapper_pg_dir);
 
 	flush_cache_all();
 	srmmu_set_ctable_ptr((unsigned long)srmmu_ctx_table_phys);
-- 
2.26.2
