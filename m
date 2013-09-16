From: Bob Picco <bpicco@meloft.net>
Date: Mon, 16 Sep 2013 13:46:37 +0000
Subject: [PATCH 2/4] sparc64 move three level page table scheme
Message-Id: <1379339199-9388-3-git-send-email-bpicco@meloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: bob picco <bpicco@meloft.net>

The three level page table scheme to handle unsigned int of pgd_t and pmd_t
is moved to files identifying specifically three level (lvl3) page table.

Signed-off-by: Bob Picco <bob.picco@oracle.com>
---
 arch/sparc/include/asm/page_64.h         |   10 ++-
 arch/sparc/include/asm/page_64_lvl3.h    |   15 ++++
 arch/sparc/include/asm/pgtable_64.h      |  133 ++++--------------------------
 arch/sparc/include/asm/pgtable_64_lvl3.h |  118 ++++++++++++++++++++++++++
 4 files changed, 154 insertions(+), 122 deletions(-)

diff --git a/arch/sparc/include/asm/page_64.h b/arch/sparc/include/asm/page_64.h
index f4e7adf..6226e9b 100644
--- a/arch/sparc/include/asm/page_64.h
+++ b/arch/sparc/include/asm/page_64.h
@@ -49,12 +49,16 @@ extern void copy_user_page(void *to, void *from, unsigned long vaddr, struct pag
 
 #define STRICT_MM_TYPECHECKS
 
+#ifdef CONFIG_SPARC_PGTABLE_LEVEL4
+#include "page_64_lvl4.h"
+#else
+#include "page_64_lvl3.h"
+#endif
+
 #ifdef STRICT_MM_TYPECHECKS
 /* These are used to make use of C type-checking.. */
 typedef struct { unsigned long pte; } pte_t;
 typedef struct { unsigned long iopte; } iopte_t;
-typedef struct { unsigned int pmd; } pmd_t;
-typedef struct { unsigned int pgd; } pgd_t;
 typedef struct { unsigned long pgprot; } pgprot_t;
 
 #define pte_val(x)	((x).pte)
@@ -73,8 +77,6 @@ typedef struct { unsigned long pgprot; } pgprot_t;
 /* .. while these make it easier on the compiler */
 typedef unsigned long pte_t;
 typedef unsigned long iopte_t;
-typedef unsigned int pmd_t;
-typedef unsigned int pgd_t;
 typedef unsigned long pgprot_t;
 
 #define pte_val(x)	(x)
diff --git a/arch/sparc/include/asm/page_64_lvl3.h b/arch/sparc/include/asm/page_64_lvl3.h
new file mode 100644
index 0000000..a9619a0
--- /dev/null
+++ b/arch/sparc/include/asm/page_64_lvl3.h
@@ -0,0 +1,15 @@
+#ifndef _SPARC64_PAGE_LVL3_H
+#define _SPARC64_PAGE_LVL3_H
+
+#ifdef STRICT_MM_TYPECHECKS
+/* These are used to make use of C type-checking.. */
+typedef struct { unsigned int pmd; } pmd_t;
+typedef struct { unsigned int pgd; } pgd_t;
+
+#else
+typedef unsigned int pmd_t;
+typedef unsigned int pgd_t;
+
+#endif /* (STRICT_MM_TYPECHECKS) */
+
+#endif /* !_SPARC64_PAGE_LVL3_H */
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 3676031..785ead5 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -20,9 +20,7 @@
 #include <asm/page.h>
 #include <asm/processor.h>
 
-#include <asm-generic/pgtable-nopud.h>
-
-/* The kernel image occupies 0x4000000 to 0x6000000 (4MB --> 96MB).
+/* The kernel image occupies 0x400000 to 0x6000000 (4MB --> 96MB).
  * The page copy blockops can use 0x6000000 to 0x8000000.
  * The TSB is mapped in the 0x8000000 to 0xa000000 range.
  * The PROM resides in an area spanning 0xf0000000 to 0x100000000.
@@ -45,39 +43,12 @@
 
 #define vmemmap			((struct page *)VMEMMAP_BASE)
 
-/* PMD_SHIFT determines the size of the area a second-level page
- * table can map
- */
-#define PMD_SHIFT	(PAGE_SHIFT + (PAGE_SHIFT-4))
-#define PMD_SIZE	(_AC(1,UL) << PMD_SHIFT)
-#define PMD_MASK	(~(PMD_SIZE-1))
-#define PMD_BITS	(PAGE_SHIFT - 2)
-
-/* PGDIR_SHIFT determines what a third-level page table entry can map */
-#define PGDIR_SHIFT	(PAGE_SHIFT + (PAGE_SHIFT-4) + PMD_BITS)
-#define PGDIR_SIZE	(_AC(1,UL) << PGDIR_SHIFT)
-#define PGDIR_MASK	(~(PGDIR_SIZE-1))
-#define PGDIR_BITS	(PAGE_SHIFT - 2)
-
-#if (PGDIR_SHIFT + PGDIR_BITS) != 44
-#error Page table parameters do not cover virtual address space properly.
-#endif
-
-#if (PMD_SHIFT != HPAGE_SHIFT)
-#error PMD_SHIFT must equal HPAGE_SHIFT for transparent huge pages.
-#endif
-
-/* PMDs point to PTE tables which are 4K aligned.  */
-#define PMD_PADDR	_AC(0xfffffffe,UL)
-#define PMD_PADDR_SHIFT	_AC(11,UL)
-
 #define PMD_ISHUGE	_AC(0x00000001,UL)
 
 /* This is the PMD layout when PMD_ISHUGE is set.  With 4MB huge
  * pages, this frees up a bunch of bits in the layout that we can
  * use for the protection settings and software metadata.
  */
-#define PMD_HUGE_PADDR		_AC(0xfffff800,UL)
 #define PMD_HUGE_PROTBITS	_AC(0x000007ff,UL)
 #define PMD_HUGE_PRESENT	_AC(0x00000400,UL)
 #define PMD_HUGE_WRITE		_AC(0x00000200,UL)
@@ -86,28 +57,23 @@
 #define PMD_HUGE_EXEC		_AC(0x00000040,UL)
 #define PMD_HUGE_SPLITTING	_AC(0x00000020,UL)
 
-/* PGDs point to PMD tables which are 8K aligned.  */
-#define PGD_PADDR	_AC(0xfffffffc,UL)
-#define PGD_PADDR_SHIFT	_AC(11,UL)
-
-#ifndef __ASSEMBLY__
+#define pte_ERROR(e)	__builtin_trap()
+#define pmd_ERROR(e)	__builtin_trap()
+#define pgd_ERROR(e)	__builtin_trap()
 
-#include <linux/sched.h>
+#ifdef CONFIG_SPARC_PGTABLE_LEVEL4
+#include "pgtable_64_lvl4.h"
+#else
+#include "pgtable_64_lvl3.h"
+#endif
 
-/* Entries per page directory level. */
-#define PTRS_PER_PTE	(1UL << (PAGE_SHIFT-4))
-#define PTRS_PER_PMD	(1UL << PMD_BITS)
-#define PTRS_PER_PGD	(1UL << PGDIR_BITS)
+#if (PMD_SHIFT != HPAGE_SHIFT)
+#error PMD_SHIFT must equal HPAGE_SHIFT for transparent huge pages.
+#endif
 
 /* Kernel has a separate 44bit address space. */
 #define FIRST_USER_ADDRESS	0
 
-#define pte_ERROR(e)	__builtin_trap()
-#define pmd_ERROR(e)	__builtin_trap()
-#define pgd_ERROR(e)	__builtin_trap()
-
-#endif /* !(__ASSEMBLY__) */
-
 /* PTE bits which are the same in SUN4U and SUN4V format.  */
 #define _PAGE_VALID	  _AC(0x8000000000000000,UL) /* Valid TTE            */
 #define _PAGE_R	  	  _AC(0x8000000000000000,UL) /* Keep ref bit uptodate*/
@@ -643,13 +609,6 @@ static inline int pmd_write(pmd_t pmd)
 	return pmd_val(pmd) & PMD_HUGE_WRITE;
 }
 
-static inline unsigned long pmd_pfn(pmd_t pmd)
-{
-	unsigned long val = pmd_val(pmd) & PMD_HUGE_PADDR;
-
-	return val >> (PAGE_SHIFT - PMD_PADDR_SHIFT);
-}
-
 static inline int pmd_trans_splitting(pmd_t pmd)
 {
 	return (pmd_val(pmd) & (PMD_ISHUGE|PMD_HUGE_SPLITTING)) =
@@ -708,12 +667,9 @@ static inline pmd_t pmd_mksplitting(pmd_t pmd)
 extern pgprot_t pmd_pgprot(pmd_t entry);
 #endif
 
-static inline int pmd_present(pmd_t pmd)
-{
-	return pmd_val(pmd) != 0U;
-}
-
-#define pmd_none(pmd)			(!pmd_val(pmd))
+/* Actual page table PTE updates.  */
+extern void tlb_batch_add(struct mm_struct *mm, unsigned long vaddr,
+			  pte_t *ptep, pte_t orig, int fullmm);
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 extern void set_pmd_at(struct mm_struct *mm, unsigned long addr,
@@ -726,63 +682,6 @@ static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 }
 #endif
 
-static inline void pmd_set(struct mm_struct *mm, pmd_t *pmdp, pte_t *ptep)
-{
-	unsigned long val = __pa((unsigned long) (ptep)) >> PMD_PADDR_SHIFT;
-
-	pmd_val(*pmdp) = val;
-}
-
-#define pud_set(pudp, pmdp)	\
-	(pud_val(*(pudp)) = (__pa((unsigned long) (pmdp)) >> PGD_PADDR_SHIFT))
-static inline unsigned long __pmd_page(pmd_t pmd)
-{
-	unsigned long paddr = (unsigned long) pmd_val(pmd);
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	if (pmd_val(pmd) & PMD_ISHUGE)
-		paddr &= PMD_HUGE_PADDR;
-#endif
-	paddr <<= PMD_PADDR_SHIFT;
-	return ((unsigned long) __va(paddr));
-}
-#define pmd_page(pmd) 			virt_to_page((void *)__pmd_page(pmd))
-#define pud_page_vaddr(pud)		\
-	((unsigned long) __va((((unsigned long)pud_val(pud))<<PGD_PADDR_SHIFT)))
-#define pud_page(pud) 			virt_to_page((void *)pud_page_vaddr(pud))
-#define pmd_bad(pmd)			(0)
-#define pmd_clear(pmdp)			(pmd_val(*(pmdp)) = 0U)
-#define pud_none(pud)			(!pud_val(pud))
-#define pud_bad(pud)			(0)
-#define pud_present(pud)		(pud_val(pud) != 0U)
-#define pud_clear(pudp)			(pud_val(*(pudp)) = 0U)
-
-/* Same in both SUN4V and SUN4U.  */
-#define pte_none(pte) 			(!pte_val(pte))
-
-/* to find an entry in a page-table-directory. */
-#define pgd_index(address)	(((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
-#define pgd_offset(mm, address)	((mm)->pgd + pgd_index(address))
-
-/* to find an entry in a kernel page-table-directory */
-#define pgd_offset_k(address) pgd_offset(&init_mm, address)
-
-/* Find an entry in the second-level page table.. */
-#define pmd_offset(pudp, address)	\
-	((pmd_t *) pud_page_vaddr(*(pudp)) + \
-	 (((address) >> PMD_SHIFT) & (PTRS_PER_PMD-1)))
-
-/* Find an entry in the third-level page table.. */
-#define pte_index(dir, address)	\
-	((pte_t *) __pmd_page(*(dir)) + \
-	 ((address >> PAGE_SHIFT) & (PTRS_PER_PTE - 1)))
-#define pte_offset_kernel		pte_index
-#define pte_offset_map			pte_index
-#define pte_unmap(pte)			do { } while (0)
-
-/* Actual page table PTE updates.  */
-extern void tlb_batch_add(struct mm_struct *mm, unsigned long vaddr,
-			  pte_t *ptep, pte_t orig, int fullmm);
-
 #define __HAVE_ARCH_PMDP_GET_AND_CLEAR
 static inline pmd_t pmdp_get_and_clear(struct mm_struct *mm,
 				       unsigned long addr,
@@ -837,8 +736,6 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 })
 #endif
 
-extern pgd_t swapper_pg_dir[2048];
-extern pmd_t swapper_low_pmd_dir[2048];
 
 extern void paging_init(void);
 extern unsigned long find_ecache_flush_span(unsigned long size);
diff --git a/arch/sparc/include/asm/pgtable_64_lvl3.h b/arch/sparc/include/asm/pgtable_64_lvl3.h
new file mode 100644
index 0000000..b762f0b
--- /dev/null
+++ b/arch/sparc/include/asm/pgtable_64_lvl3.h
@@ -0,0 +1,118 @@
+#ifndef _SPARC64_PGTABLE_LVL3_H
+#define _SPARC64_PGTABLE_LVL3_H
+/* This is for a three level page table scheme.
+ */
+
+#include <asm-generic/pgtable-nopud.h>
+
+/* PMD_SHIFT determines the size of the area a second-level page
+ * table can map
+ */
+#define PMD_SHIFT	(PAGE_SHIFT + (PAGE_SHIFT-4))
+#define PMD_SIZE	(_AC(1,UL) << PMD_SHIFT)
+#define PMD_MASK	(~(PMD_SIZE-1))
+#define PMD_BITS	(PAGE_SHIFT - 2)
+
+/* PGDIR_SHIFT determines what a third-level page table entry can map */
+#define PGDIR_SHIFT	(PAGE_SHIFT + (PAGE_SHIFT-4) + PMD_BITS)
+#define PGDIR_SIZE	(_AC(1,UL) << PGDIR_SHIFT)
+#define PGDIR_MASK	(~(PGDIR_SIZE-1))
+#define PGDIR_BITS	(PAGE_SHIFT - 2)
+
+#if (PGDIR_SHIFT + PGDIR_BITS) != 44
+#error Page table parameters do not cover virtual address space properly.
+#endif
+
+/* PMDs point to PTE tables which are 4K aligned.  */
+#define PMD_PADDR	_AC(0xfffffffe,UL)
+#define PMD_PADDR_SHIFT	_AC(11,UL)
+
+#define PMD_HUGE_PADDR		_AC(0xfffff800,UL)
+/* PGDs point to PMD tables which are 8K aligned.  */
+#define PGD_PADDR	_AC(0xfffffffc,UL)
+#define PGD_PADDR_SHIFT	_AC(11,UL)
+
+#ifndef __ASSEMBLY__
+
+#include <linux/sched.h>
+
+/* Entries per page directory level. */
+#define PTRS_PER_PTE	(1UL << (PAGE_SHIFT-4))
+#define PTRS_PER_PMD	(1UL << PMD_BITS)
+#define PTRS_PER_PGD	(1UL << PGDIR_BITS)
+
+static inline unsigned long pmd_pfn(pmd_t pmd)
+{
+	unsigned long val = pmd_val(pmd) & PMD_HUGE_PADDR;
+
+	return val >> (PAGE_SHIFT - PMD_PADDR_SHIFT);
+}
+
+static inline int pmd_present(pmd_t pmd)
+{
+	return pmd_val(pmd) != 0U;
+}
+
+#define pmd_none(pmd)			(!pmd_val(pmd))
+
+static inline void pmd_set(struct mm_struct *mm, pmd_t *pmdp, pte_t *ptep)
+{
+	unsigned long val = __pa((unsigned long) (ptep)) >> PMD_PADDR_SHIFT;
+
+	pmd_val(*pmdp) = val;
+}
+
+#define pud_set(pudp, pmdp)	\
+	(pud_val(*(pudp)) = (__pa((unsigned long) (pmdp)) >> PGD_PADDR_SHIFT))
+static inline unsigned long __pmd_page(pmd_t pmd)
+{
+	unsigned long paddr = (unsigned long) pmd_val(pmd);
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	if (pmd_val(pmd) & PMD_ISHUGE)
+		paddr &= PMD_HUGE_PADDR;
+#endif
+	paddr <<= PMD_PADDR_SHIFT;
+	return ((unsigned long) __va(paddr));
+}
+#define pmd_page(pmd) 			virt_to_page((void *)__pmd_page(pmd))
+#define pud_page_vaddr(pud)		\
+	((unsigned long) __va((((unsigned long)pud_val(pud))<<PGD_PADDR_SHIFT)))
+#define pud_page(pud) 			virt_to_page((void *)pud_page_vaddr(pud))
+#define pmd_bad(pmd)			(0)
+#define pmd_clear(pmdp)			(pmd_val(*(pmdp)) = 0U)
+#define pud_none(pud)			(!pud_val(pud))
+#define pud_bad(pud)			(0)
+#define pud_present(pud)		(pud_val(pud) != 0U)
+#define pud_clear(pudp)			(pud_val(*(pudp)) = 0U)
+
+/* Same in both SUN4V and SUN4U.  */
+#define pte_none(pte) 			(!pte_val(pte))
+
+/* to find an entry in a page-table-directory. */
+#define pgd_index(address)	(((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
+#define pgd_offset(mm, address)	((mm)->pgd + pgd_index(address))
+
+/* to find an entry in a kernel page-table-directory */
+#define pgd_offset_k(address) pgd_offset(&init_mm, address)
+
+/* Find an entry in the second-level page table.. */
+#define pmd_offset(pudp, address)	\
+	((pmd_t *) pud_page_vaddr(*(pudp)) + \
+	 (((address) >> PMD_SHIFT) & (PTRS_PER_PMD-1)))
+
+/* Find an entry in the third-level page table.. */
+#define pte_index(dir, address)	\
+	((pte_t *) __pmd_page(*(dir)) + \
+	 ((address >> PAGE_SHIFT) & (PTRS_PER_PTE - 1)))
+#define pte_offset_kernel		pte_index
+#define pte_offset_map			pte_index
+#define pte_unmap(pte)			do { } while (0)
+
+#endif /* !(__ASSEMBLY__) */
+
+#ifndef __ASSEMBLY__
+extern pgd_t swapper_pg_dir[2048];
+extern pmd_t swapper_low_pmd_dir[2048];
+#endif /* !__ASSEMBLY__ */
+
+#endif /* !_SPARC64_PGTABLE_LVL3_H */
-- 
1.7.10.4

