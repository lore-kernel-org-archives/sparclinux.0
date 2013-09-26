From: David Miller <davem@redhat.com>
Date: Thu, 26 Sep 2013 20:52:49 +0000
Subject: [PATCH 2/3] sparc64: Move to 64-bit PGDs and PMDs.
Message-Id: <20130926.165249.1727437467162318327.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


To make the page tables compact, we were using 32-bit PGDs and PMDs.
We only had to support <= 43 bits of physical addresses so this was
quite feasible.

In order to support larger physical addresses we have to move to
64-bit PGDs and PMDs.

Most of the changes are straight-forward:

1) {pgd,pmd}_t --> unsigned long

2) Anything that tries to use plain "unsigned int" types with pgd/pmd
   values needs to be adjusted.  In particular things like "0U" become
   "0UL".

3) {PGDIR,PMD}_BITS decrease by one.

4) In the assembler page table walkers, use "ldxa" instead of "lduwa"
   and adjust the low bit masks to clear out the low 3 bits instead of
   just the low 2 bits during pgd/pmd address formation.

Also, use PTRS_PER_PGD and PTRS_PER_PMD in the sizing of the
swapper_{pg_dir,low_pmd_dir} arrays.

This patch does not try to take advantage of having 64-bits in the
PMDs to simplify the hugepage code, that will come in a subsequent
change.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/page_64.h    |  8 ++++----
 arch/sparc/include/asm/pgtable_64.h | 22 +++++++++++-----------
 arch/sparc/include/asm/tsb.h        | 16 ++++++++--------
 arch/sparc/mm/init_64.c             |  2 +-
 4 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/sparc/include/asm/page_64.h b/arch/sparc/include/asm/page_64.h
index e96353f..2a6c45a 100644
--- a/arch/sparc/include/asm/page_64.h
+++ b/arch/sparc/include/asm/page_64.h
@@ -54,8 +54,8 @@ extern void copy_user_page(void *to, void *from, unsigned long vaddr, struct pag
 /* These are used to make use of C type-checking.. */
 typedef struct { unsigned long pte; } pte_t;
 typedef struct { unsigned long iopte; } iopte_t;
-typedef struct { unsigned int pmd; } pmd_t;
-typedef struct { unsigned int pgd; } pgd_t;
+typedef struct { unsigned long pmd; } pmd_t;
+typedef struct { unsigned long pgd; } pgd_t;
 typedef struct { unsigned long pgprot; } pgprot_t;
 
 #define pte_val(x)	((x).pte)
@@ -74,8 +74,8 @@ typedef struct { unsigned long pgprot; } pgprot_t;
 /* .. while these make it easier on the compiler */
 typedef unsigned long pte_t;
 typedef unsigned long iopte_t;
-typedef unsigned int pmd_t;
-typedef unsigned int pgd_t;
+typedef unsigned long pmd_t;
+typedef unsigned long pgd_t;
 typedef unsigned long pgprot_t;
 
 #define pte_val(x)	(x)
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 012b6ee..eee803e 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -51,15 +51,15 @@
 #define PMD_SHIFT	(PAGE_SHIFT + (PAGE_SHIFT-3))
 #define PMD_SIZE	(_AC(1,UL) << PMD_SHIFT)
 #define PMD_MASK	(~(PMD_SIZE-1))
-#define PMD_BITS	(PAGE_SHIFT - 2)
+#define PMD_BITS	(PAGE_SHIFT - 3)
 
 /* PGDIR_SHIFT determines what a third-level page table entry can map */
 #define PGDIR_SHIFT	(PAGE_SHIFT + (PAGE_SHIFT-3) + PMD_BITS)
 #define PGDIR_SIZE	(_AC(1,UL) << PGDIR_SHIFT)
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
-#define PGDIR_BITS	(PAGE_SHIFT - 2)
+#define PGDIR_BITS	(PAGE_SHIFT - 3)
 
-#if (PGDIR_SHIFT + PGDIR_BITS) != 45
+#if (PGDIR_SHIFT + PGDIR_BITS) != 43
 #error Page table parameters do not cover virtual address space properly.
 #endif
 
@@ -714,7 +714,7 @@ extern pgprot_t pmd_pgprot(pmd_t entry);
 
 static inline int pmd_present(pmd_t pmd)
 {
-	return pmd_val(pmd) != 0U;
+	return pmd_val(pmd) != 0UL;
 }
 
 #define pmd_none(pmd)			(!pmd_val(pmd))
@@ -741,7 +741,7 @@ static inline void pmd_set(struct mm_struct *mm, pmd_t *pmdp, pte_t *ptep)
 	(pud_val(*(pudp)) = (__pa((unsigned long) (pmdp)) >> PGD_PADDR_SHIFT))
 static inline unsigned long __pmd_page(pmd_t pmd)
 {
-	unsigned long paddr = (unsigned long) pmd_val(pmd);
+	unsigned long paddr = pmd_val(pmd);
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	if (pmd_val(pmd) & PMD_ISHUGE)
 		paddr &= PMD_HUGE_PADDR;
@@ -751,14 +751,14 @@ static inline unsigned long __pmd_page(pmd_t pmd)
 }
 #define pmd_page(pmd) 			virt_to_page((void *)__pmd_page(pmd))
 #define pud_page_vaddr(pud)		\
-	((unsigned long) __va((((unsigned long)pud_val(pud))<<PGD_PADDR_SHIFT)))
+	((unsigned long) __va((pud_val(pud)<<PGD_PADDR_SHIFT)))
 #define pud_page(pud) 			virt_to_page((void *)pud_page_vaddr(pud))
 #define pmd_bad(pmd)			(0)
-#define pmd_clear(pmdp)			(pmd_val(*(pmdp)) = 0U)
+#define pmd_clear(pmdp)			(pmd_val(*(pmdp)) = 0UL)
 #define pud_none(pud)			(!pud_val(pud))
 #define pud_bad(pud)			(0)
 #define pud_present(pud)		(pud_val(pud) != 0U)
-#define pud_clear(pudp)			(pud_val(*(pudp)) = 0U)
+#define pud_clear(pudp)			(pud_val(*(pudp)) = 0UL)
 
 /* Same in both SUN4V and SUN4U.  */
 #define pte_none(pte) 			(!pte_val(pte))
@@ -793,7 +793,7 @@ static inline pmd_t pmdp_get_and_clear(struct mm_struct *mm,
 				       pmd_t *pmdp)
 {
 	pmd_t pmd = *pmdp;
-	set_pmd_at(mm, addr, pmdp, __pmd(0U));
+	set_pmd_at(mm, addr, pmdp, __pmd(0UL));
 	return pmd;
 }
 
@@ -841,8 +841,8 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 })
 #endif
 
-extern pgd_t swapper_pg_dir[2048];
-extern pmd_t swapper_low_pmd_dir[2048];
+extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
+extern pmd_t swapper_low_pmd_dir[PTRS_PER_PMD];
 
 extern void paging_init(void);
 extern unsigned long find_ecache_flush_span(unsigned long size);
diff --git a/arch/sparc/include/asm/tsb.h b/arch/sparc/include/asm/tsb.h
index 16e5777..cc0432f 100644
--- a/arch/sparc/include/asm/tsb.h
+++ b/arch/sparc/include/asm/tsb.h
@@ -142,14 +142,14 @@ extern struct tsb_phys_patch_entry __tsb_phys_patch, __tsb_phys_patch_end;
 	or		REG1, %lo(swapper_pg_dir), REG1; \
 	sllx		VADDR, 64 - (PGDIR_SHIFT + PGDIR_BITS), REG2; \
 	srlx		REG2, 64 - PAGE_SHIFT, REG2; \
-	andn		REG2, 0x3, REG2; \
-	lduw		[REG1 + REG2], REG1; \
+	andn		REG2, 0x7, REG2; \
+	ldx		[REG1 + REG2], REG1; \
 	brz,pn		REG1, FAIL_LABEL; \
 	 sllx		VADDR, 64 - (PMD_SHIFT + PMD_BITS), REG2; \
 	srlx		REG2, 64 - PAGE_SHIFT, REG2; \
 	sllx		REG1, PGD_PADDR_SHIFT, REG1; \
-	andn		REG2, 0x3, REG2; \
-	lduwa		[REG1 + REG2] ASI_PHYS_USE_EC, REG1; \
+	andn		REG2, 0x7, REG2; \
+	ldxa		[REG1 + REG2] ASI_PHYS_USE_EC, REG1; \
 	brz,pn		REG1, FAIL_LABEL; \
 	 sllx		VADDR, 64 - PMD_SHIFT, REG2; \
 	srlx		REG2, 64 - PAGE_SHIFT, REG2; \
@@ -260,14 +260,14 @@ extern struct tsb_phys_patch_entry __tsb_phys_patch, __tsb_phys_patch_end;
 #define USER_PGTABLE_WALK_TL1(VADDR, PHYS_PGD, REG1, REG2, FAIL_LABEL)	\
 	sllx		VADDR, 64 - (PGDIR_SHIFT + PGDIR_BITS), REG2; \
 	srlx		REG2, 64 - PAGE_SHIFT, REG2; \
-	andn		REG2, 0x3, REG2; \
-	lduwa		[PHYS_PGD + REG2] ASI_PHYS_USE_EC, REG1; \
+	andn		REG2, 0x7, REG2; \
+	ldxa		[PHYS_PGD + REG2] ASI_PHYS_USE_EC, REG1; \
 	brz,pn		REG1, FAIL_LABEL; \
 	 sllx		VADDR, 64 - (PMD_SHIFT + PMD_BITS), REG2; \
 	srlx		REG2, 64 - PAGE_SHIFT, REG2; \
 	sllx		REG1, PGD_PADDR_SHIFT, REG1; \
-	andn		REG2, 0x3, REG2; \
-	lduwa		[REG1 + REG2] ASI_PHYS_USE_EC, REG1; \
+	andn		REG2, 0x7, REG2; \
+	ldxa		[REG1 + REG2] ASI_PHYS_USE_EC, REG1; \
 	USER_PGTABLE_CHECK_PMD_HUGE(VADDR, REG1, REG2, FAIL_LABEL, 800f) \
 	sllx		VADDR, 64 - PMD_SHIFT, REG2; \
 	srlx		REG2, 64 - PAGE_SHIFT, REG2; \
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 4d0c99b..db35988 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1842,7 +1842,7 @@ static void __init sun4v_linear_pte_xor_finalize(void)
 /* paging_init() sets up the page tables */
 
 static unsigned long last_valid_pfn;
-pgd_t swapper_pg_dir[2048];
+pgd_t swapper_pg_dir[PTRS_PER_PGD];
 
 static void sun4u_pgprot_init(void);
 static void sun4v_pgprot_init(void);
-- 
1.8.1.2

