From: Bob Picco <bpicco@meloft.net>
Date: Mon, 16 Sep 2013 13:46:38 +0000
Subject: [PATCH 3/4] sparc64 four level page table support
Message-Id: <1379339199-9388-4-git-send-email-bpicco@meloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: bob picco <bpicco@meloft.net>

This patch adds the code required for the remaining parts of the four
page table scheme. We allow enable utilization of this code in a subsequent
patch.

Signed-off-by: Bob Picco <bob.picco@oracle.com>
---
 arch/sparc/include/asm/page_64_lvl4.h    |   21 ++++
 arch/sparc/include/asm/pgalloc_64.h      |   16 +++
 arch/sparc/include/asm/pgtable_64.h      |    2 +-
 arch/sparc/include/asm/pgtable_64_lvl4.h |  191 ++++++++++++++++++++++++++++++
 arch/sparc/include/asm/tsb.h             |   55 +++++++++
 arch/sparc/kernel/smp_64.c               |    7 ++
 arch/sparc/mm/init_64.c                  |   25 +++-
 7 files changed, 315 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/page_64_lvl4.h b/arch/sparc/include/asm/page_64_lvl4.h
new file mode 100644
index 0000000..39bbf88
--- /dev/null
+++ b/arch/sparc/include/asm/page_64_lvl4.h
@@ -0,0 +1,21 @@
+#ifndef _SPARC64_PAGE_LVL4_H
+#define _SPARC64_PAGE_LVL4_H
+
+#ifdef STRICT_MM_TYPECHECKS
+/* These are used to make use of C type-checking.. */
+typedef struct { unsigned long pmd; } pmd_t;
+typedef struct { unsigned long pud; } pud_t;
+typedef struct { unsigned long pgd; } pgd_t;
+
+#define	__pud(x)	((pud_t) { (x) } )
+
+#else
+typedef unsigned long pmd_t;
+typedef unsigned long pud_t;
+typedef unsigned long pgd_t;
+
+#define	__pud(x)	(x)
+
+#endif /* (STRICT_MM_TYPECHECKS) */
+
+#endif /* !_SPARC64_PAGE_LVL4_H */
diff --git a/arch/sparc/include/asm/pgalloc_64.h b/arch/sparc/include/asm/pgalloc_64.h
index bcfe063..355acdb 100644
--- a/arch/sparc/include/asm/pgalloc_64.h
+++ b/arch/sparc/include/asm/pgalloc_64.h
@@ -27,6 +27,18 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 
 #define pud_populate(MM, PUD, PMD)	pud_set(PUD, PMD)
 
+#ifdef CONFIG_SPARC_PGTABLE_LEVEL4
+static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
+{
+	return kmem_cache_alloc(pgtable_cache, GFP_KERNEL|__GFP_REPEAT);
+}
+
+static inline void pud_free(struct mm_struct *mm, pud_t *pud)
+{
+	kmem_cache_free(pgtable_cache, pud);
+}
+#endif
+
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
 	return kmem_cache_alloc(pgtable_cache,
@@ -91,4 +103,8 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pte_t *pte,
 #define __pmd_free_tlb(tlb, pmd, addr)		      \
 	pgtable_free_tlb(tlb, pmd, false)
 
+#ifdef CONFIG_SPARC_PGTABLE_LEVEL4
+#define	__pud_free_tlb(tlb, pud, addr)			\
+	pgtable_free_tlb(tlb, pud, false)
+#endif
 #endif /* _SPARC64_PGALLOC_H */
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 785ead5..5ed8fb1 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -688,7 +688,7 @@ static inline pmd_t pmdp_get_and_clear(struct mm_struct *mm,
 				       pmd_t *pmdp)
 {
 	pmd_t pmd = *pmdp;
-	set_pmd_at(mm, addr, pmdp, __pmd(0U));
+	set_pmd_at(mm, addr, pmdp, __pmd(0UL));
 	return pmd;
 }
 
diff --git a/arch/sparc/include/asm/pgtable_64_lvl4.h b/arch/sparc/include/asm/pgtable_64_lvl4.h
new file mode 100644
index 0000000..dce0b04
--- /dev/null
+++ b/arch/sparc/include/asm/pgtable_64_lvl4.h
@@ -0,0 +1,191 @@
+/* This is for a four level sparc64 software pagetable scheme.
+ * Large parts gratefully taken from x86.
+ */
+
+#ifndef _SPARC64_PGTABLE_LVL4_H
+#define _SPARC64_PGTABLE_LVL4_H
+
+/* Unlike the three level page table scheme for sparc64, the four level
+ * scheme doesn't compress the page frame within an unsigned int. It leaves
+ * the pfn in its pte (TTE data part) form. Though only the first level
+ * is ever actually loaded into the TSB.
+ */
+#define PMD_PADDR_SHIFT _AC(0,UL)
+
+/* PGDIR_SHIFT determines what a top-level page table entry can map
+ */
+#define PGDIR_SHIFT	42
+#define PTRS_PER_PGD	1024
+
+/* 3rd level page
+ */
+#define PUD_SHIFT	32
+#define PTRS_PER_PUD	1024
+
+/* PMD_SHIFT determines the size of the area a middle-level
+ * page table can map
+ */
+#define PMD_SHIFT	22
+#define PTRS_PER_PMD	1024
+
+#define PMD_SIZE	(_AC(1, UL) << PMD_SHIFT)
+#define PMD_MASK	(~(PMD_SIZE - 1))
+#define PUD_SIZE	(_AC(1, UL) << PUD_SHIFT)
+#define PUD_MASK	(~(PUD_SIZE - 1))
+#define PGDIR_SIZE	(_AC(1, UL) << PGDIR_SHIFT)
+#define PGDIR_MASK	(~(PGDIR_SIZE - 1))
+
+#define PTRS_PER_PTE	(1UL << (PAGE_SHIFT-4))
+
+#define pmd_set(mm, pmdp, ptep)				\
+		(pmd_val(*(pmdp)) = __pa((unsigned long) (ptep)))
+#define pmd_clear(pmdp)		(pmd_val(*(pmdp)) = 0UL)
+#define pud_set(pudp, pmdp) (pud_val(*(pudp)) = __pa((unsigned long) (pmdp)))
+#define pud_page(pud)	    pfn_to_page(pud_val(pud) >> PAGE_SHIFT)
+#define pud_val(x)		((x).pud)
+#define pud_ERROR		pgd_ERROR
+#define pgd_set(pgdp, pudp) (pgd_val(*(pgdp)) = __pa((unsigned long) (pudp)))
+#define	pgd_bad(pgd)		(0)
+#define pgd_val(x)		((x).pgd)
+#define pgd_index(address)  (((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
+#define pgd_offset(mm, address)	((mm)->pgd + pgd_index((address)))
+#define pgd_offset_k(address)	pgd_offset(&init_mm, address)
+#define pte_offset_map(dir, address) pte_offset_kernel((dir), (address))
+#define	pte_unmap(pte)		do { } while (0)
+
+#ifndef __ASSEMBLY__
+struct mm_struct;
+#include <linux/sched.h>
+
+/* This fills in the lds slot.
+ */
+extern unsigned int swapper_low_pmd_dir[2048];
+
+extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
+
+static inline void pgd_clear(pgd_t *pgd)
+{
+	pgd_val(*(pgd)) = 0UL;
+}
+
+static inline void pud_clear(pud_t *pud)
+{
+	pud_val((*pud)) = 0UL;
+}
+
+static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, pud_t *pud)
+{
+	pgd_set(pgd, pud);
+}
+
+static inline int pgd_present(pgd_t pgd)
+{
+	return pgd_val(pgd);
+}
+
+static inline unsigned long pud_page_vaddr(pud_t pud)
+{
+	return (unsigned long)__va((unsigned long)pud_val(pud));
+}
+
+static inline int pmd_present(pmd_t pmd)
+{
+	return pmd_val(pmd) != 0UL;
+}
+
+static inline int pmd_none(pmd_t pmd)
+{
+	return pmd_val(pmd) = 0;
+}
+
+static inline unsigned long pmd_index(unsigned long address)
+{
+	return (address >> PMD_SHIFT) & (PTRS_PER_PMD - 1);
+}
+
+static inline pmd_t *pmd_offset(pud_t *pud, unsigned long address)
+{
+	return (pmd_t *) pud_page_vaddr(*pud) + pmd_index(address);
+}
+
+static inline unsigned long pmd_page_vaddr(pmd_t pmd)
+{
+	return (unsigned long) __va(pmd_val(pmd));
+}
+
+static inline unsigned long __pmd_page(pmd_t pmd)
+{
+	unsigned long pmdaddr = pmd_val(pmd);
+
+	pmdaddr &= ~PMD_HUGE_PROTBITS;
+
+	return (unsigned long) __va(pmdaddr);
+}
+
+#define pmd_page(pmd)	virt_to_page((void *)__pmd_page(pmd))
+
+static inline unsigned long pmd_pfn(pmd_t pmd)
+{
+	unsigned long pmdaddr = (unsigned long) pmd_val(pmd);
+
+	pmdaddr &= PAGE_MASK;
+
+	return pmdaddr >> PAGE_SHIFT;
+}
+
+static inline unsigned long pte_index(unsigned long address)
+{
+	return (address >> PAGE_SHIFT) & (PTRS_PER_PTE - 1);
+}
+
+static inline pte_t *pte_offset_kernel(pmd_t *pmd, unsigned long address)
+{
+	return (pte_t *)pmd_page_vaddr(*pmd) + pte_index(address);
+}
+
+static inline int pmd_bad(pmd_t pmd)
+{
+	return 0;
+}
+
+static inline int pud_present(pud_t pud)
+{
+	return pud_val(pud) != 0UL;
+}
+
+static inline unsigned long pgd_page_vaddr(pgd_t pgd)
+{
+	return (unsigned long)__va(pgd_val(pgd));
+}
+
+static inline unsigned long pud_index(unsigned long address)
+{
+	return (address >> PUD_SHIFT) & (PTRS_PER_PUD - 1);
+}
+
+static inline pud_t *pud_offset(pgd_t *pgd, unsigned long address)
+{
+	return (pud_t *) pgd_page_vaddr(*pgd) + pud_index(address);
+}
+
+static inline int pgd_none(pgd_t pgd)
+{
+	return !pgd_val(pgd);
+}
+
+static inline int pud_none(pud_t pud)
+{
+	return !pud_val(pud);
+}
+
+static inline int pud_bad(pud_t pud)
+{
+	return pud_val(pud) = 0UL;
+}
+
+static inline int pte_none(pte_t pte)
+{
+	return !pte_val(pte);
+}
+#endif /* !__ASSEMBLY__ */
+#endif /* !_SPARC64_PGTABLE_LVL4_H */
diff --git a/arch/sparc/include/asm/tsb.h b/arch/sparc/include/asm/tsb.h
index e696432..d8d0fae 100644
--- a/arch/sparc/include/asm/tsb.h
+++ b/arch/sparc/include/asm/tsb.h
@@ -137,6 +137,33 @@ extern struct tsb_phys_patch_entry __tsb_phys_patch, __tsb_phys_patch_end;
 	 * REG1.  Jumps to FAIL_LABEL on early page table walk termination.
 	 * VADDR will not be clobbered, but REG2 will.
 	 */
+#ifdef CONFIG_SPARC_PGTABLE_LEVEL4
+#define	PTESLOT		0x3ff
+#define HPTESLOT	0x1ff
+#define KERN_PGTABLE_WALK(VADDR, REG1, REG2, FAIL_LABEL)	\
+	sethi		%hi(swapper_pg_dir), REG1; \
+	or		REG1, %lo(swapper_pg_dir), REG1; \
+	srlx		VADDR, PGDIR_SHIFT , REG2; \
+	and		REG2, PTESLOT, REG2; \
+	sllx		REG2, 3, REG2; \
+	ldx		[REG1 + REG2], REG2; \
+	brz,pn          REG2, FAIL_LABEL; \
+	srlx		VADDR, PUD_SHIFT , REG1; \
+	and		REG1, PTESLOT, REG1; \
+	sllx		REG1, 3, REG1; \
+	ldxa		[REG2 + REG1] ASI_PHYS_USE_EC, REG1; \
+	brz,pn          REG1, FAIL_LABEL; \
+	srlx		VADDR, PMD_SHIFT , REG2; \
+	and		REG2, PTESLOT, REG2; \
+	sllx		REG2, 3, REG2; \
+	ldxa		[REG1 + REG2] ASI_PHYS_USE_EC, REG1; \
+	brz,pn          REG1, FAIL_LABEL; \
+	srlx		VADDR, PAGE_SHIFT , REG2; \
+	and		REG2, HPTESLOT, REG2; \
+	sllx		REG2, 3, REG2; \
+	add		REG1, REG2, REG1;
+
+#else
 #define KERN_PGTABLE_WALK(VADDR, REG1, REG2, FAIL_LABEL)	\
 	sethi		%hi(swapper_pg_dir), REG1; \
 	or		REG1, %lo(swapper_pg_dir), REG1; \
@@ -156,6 +183,7 @@ extern struct tsb_phys_patch_entry __tsb_phys_patch, __tsb_phys_patch_end;
 	sllx		REG1, PMD_PADDR_SHIFT, REG1; \
 	andn		REG2, 0x7, REG2; \
 	add		REG1, REG2, REG1;
+#endif /* CONFIG_SPARC_PGTABLE_LEVEL4 */
 
 	/* These macros exists only to make the PMD translator below
 	 * easier to read.  It hides the ELF section switch for the
@@ -250,6 +278,32 @@ extern struct tsb_phys_patch_entry __tsb_phys_patch, __tsb_phys_patch_end;
 	 *
 	 * VADDR will not be clobbered, but REG1 and REG2 will.
 	 */
+#ifdef CONFIG_SPARC_PGTABLE_LEVEL4
+#define USER_PGTABLE_WALK_TL1(VADDR, PHYS_PGD, REG1, REG2, FAIL_LABEL)	\
+	srlx		VADDR, PGDIR_SHIFT , REG2; \
+	and		REG2, PTESLOT, REG2; \
+	sllx		REG2, 3, REG2; \
+	ldxa		[PHYS_PGD + REG2] ASI_PHYS_USE_EC, REG2; \
+	brz,pn          REG2, FAIL_LABEL; \
+	srlx		VADDR, PUD_SHIFT , REG1; \
+	and		REG1, PTESLOT, REG1; \
+	sllx		REG1, 3, REG1; \
+	ldxa		[REG2 + REG1] ASI_PHYS_USE_EC, REG1; \
+	brz,pn          REG1, FAIL_LABEL; \
+	srlx		VADDR, PMD_SHIFT , REG2; \
+	and		REG2, PTESLOT, REG2; \
+	sllx		REG2, 3, REG2; \
+	ldxa		[REG1 + REG2] ASI_PHYS_USE_EC, REG1; \
+	USER_PGTABLE_CHECK_PMD_HUGE(VADDR, REG1, REG2, FAIL_LABEL, 800f) \
+	srlx		VADDR, PAGE_SHIFT , REG2; \
+	and		REG2, HPTESLOT, REG2; \
+	sllx		REG2, 3, REG2; \
+	add		REG1, REG2, REG1; \
+	ldxa		[REG1] ASI_PHYS_USE_EC, REG1; \
+	brgez,pn	REG1, FAIL_LABEL; \
+	 nop; \
+800:
+#else
 #define USER_PGTABLE_WALK_TL1(VADDR, PHYS_PGD, REG1, REG2, FAIL_LABEL)	\
 	sllx		VADDR, 64 - (PGDIR_SHIFT + PGDIR_BITS), REG2; \
 	srlx		REG2, 64 - PAGE_SHIFT, REG2; \
@@ -271,6 +325,7 @@ extern struct tsb_phys_patch_entry __tsb_phys_patch, __tsb_phys_patch_end;
 	brgez,pn	REG1, FAIL_LABEL; \
 	 nop; \
 800:
+#endif	/* CONFIG_SPARC_PGTABLE_LEVEL4 */
 
 /* Lookup a OBP mapping on VADDR in the prom_trans[] table at TL>0.
  * If no entry is found, FAIL_LABEL will be branched to.  On success
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index e142545..37e90f7 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1474,6 +1474,13 @@ static void __init pcpu_populate_pte(unsigned long addr)
 	pud_t *pud;
 	pmd_t *pmd;
 
+	if (pgd_none(*pgd)) {
+		pud_t *pud;
+
+		pud = __alloc_bootmem(PAGE_SIZE,  PAGE_SIZE, PAGE_SIZE);
+		pgd_populate(&init_mm, pgd, pud);
+	}
+
 	pud = pud_offset(pgd, addr);
 	if (pud_none(*pud)) {
 		pmd_t *new;
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 3aebec9..7c871a21 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1376,6 +1376,14 @@ static unsigned long __ref kernel_map_range(unsigned long pstart,
 		pmd_t *pmd;
 		pte_t *pte;
 
+		if (pgd_none(*pgd)) {
+			pud_t *pud;
+
+			pud = __alloc_bootmem(PAGE_SIZE,  PAGE_SIZE, PAGE_SIZE);
+			alloc_bytes += PAGE_SIZE;
+			pgd_populate(&init_mm, pgd, pud);
+		}
+
 		pud = pud_offset(pgd, vstart);
 		if (pud_none(*pud)) {
 			pmd_t *new;
@@ -1752,7 +1760,12 @@ static void __init sun4v_linear_pte_xor_finalize(void)
 /* paging_init() sets up the page tables */
 
 static unsigned long last_valid_pfn;
+#ifdef CONFIG_SPARC_PGTABLE_LEVEL4
+pgd_t swapper_pg_dir[PTRS_PER_PGD];
+static pud_t swapper_pud_dir[PTRS_PER_PUD];
+#else
 pgd_t swapper_pg_dir[2048];
+#endif
 
 static void sun4u_pgprot_init(void);
 static void sun4v_pgprot_init(void);
@@ -1853,11 +1866,21 @@ void __init paging_init(void)
 	 */
 	init_mm.pgd += ((shift) / (sizeof(pgd_t)));
 	
+	/* Now can init the kernel/bad page tables. */
+#ifdef CONFIG_SPARC_PGTABLE_LEVEL4
+	{
+	pud_t *shift_pud = swapper_pud_dir + (shift / sizeof(pud_t));
+	unsigned long  pgdoffset = pgd_offset(&swapper_pg_dir[0], 0UL);
+	pgd_t *pgd = &swapper_pg_dir[pgdoffset];
+
+	pgd_set(pgd, (unsigned long) shift_pud);
+	}
+#else
 	memset(swapper_low_pmd_dir, 0, sizeof(swapper_low_pmd_dir));
 
-	/* Now can init the kernel/bad page tables. */
 	pud_set(pud_offset(&swapper_pg_dir[0], 0),
 		swapper_low_pmd_dir + (shift / sizeof(pgd_t)));
+#endif
 	
 	inherit_prom_mappings();
 	
-- 
1.7.10.4

