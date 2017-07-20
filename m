From: Allen Pais <allen.pais@oracle.com>
Date: Thu, 20 Jul 2017 07:52:36 +0000
Subject: [PATCH 2/3] sparc64: 5-Level page table support for sparc
Message-Id: <1500536437-14589-2-git-send-email-allen.pais@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Vijay Kumar <vijay.ac.kumar@oracle.com>

Added 5-Level paging for sparc.

Signed-off-by: Vijay Kumar <vijay.ac.kumar@oracle.com>
Reviewed-by: Bob Picco <bob.picco@oracle.com>
Signed-off-by: Allen Pais <allen.pais@oracle.com>
---
 arch/sparc/Kconfig                  |  2 +-
 arch/sparc/include/asm/page_64.h    |  6 +++
 arch/sparc/include/asm/pgalloc_64.h | 25 +++++++++--
 arch/sparc/include/asm/pgtable_64.h | 49 +++++++++++++++++----
 arch/sparc/include/asm/tsb.h        | 10 +++++
 arch/sparc/kernel/signal32.c        |  6 ++-
 arch/sparc/kernel/smp_64.c          | 13 +++++-
 arch/sparc/mm/fault_64.c            |  8 +++-
 arch/sparc/mm/gup.c                 | 28 ++++++++++--
 arch/sparc/mm/hugetlbpage.c         | 88 +++++++++++++++++++++++++++----------
 arch/sparc/mm/init_64.c             | 37 +++++++++++++---
 11 files changed, 222 insertions(+), 50 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index a4a6261..2f715b5 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -159,7 +159,7 @@ config ARCH_SUPPORTS_DEBUG_PAGEALLOC
 	def_bool y if SPARC64
 
 config PGTABLE_LEVELS
-	default 4 if 64BIT
+	default 5 if 64BIT
 	default 3
 
 config ARCH_SUPPORTS_UPROBES
diff --git a/arch/sparc/include/asm/page_64.h b/arch/sparc/include/asm/page_64.h
index 5961b2d..b5c751a 100644
--- a/arch/sparc/include/asm/page_64.h
+++ b/arch/sparc/include/asm/page_64.h
@@ -62,6 +62,7 @@
 typedef struct { unsigned long iopte; } iopte_t;
 typedef struct { unsigned long pmd; } pmd_t;
 typedef struct { unsigned long pud; } pud_t;
+typedef struct { unsigned long p4d; } p4d_t;
 typedef struct { unsigned long pgd; } pgd_t;
 typedef struct { unsigned long pgprot; } pgprot_t;
 
@@ -69,6 +70,7 @@
 #define iopte_val(x)	((x).iopte)
 #define pmd_val(x)      ((x).pmd)
 #define pud_val(x)      ((x).pud)
+#define p4d_val(x)      ((x).p4d)
 #define pgd_val(x)	((x).pgd)
 #define pgprot_val(x)	((x).pgprot)
 
@@ -76,6 +78,7 @@
 #define __iopte(x)	((iopte_t) { (x) } )
 #define __pmd(x)        ((pmd_t) { (x) } )
 #define __pud(x)        ((pud_t) { (x) } )
+#define __p4d(x)        ((p4d_t) { (x) } )
 #define __pgd(x)	((pgd_t) { (x) } )
 #define __pgprot(x)	((pgprot_t) { (x) } )
 
@@ -85,6 +88,7 @@
 typedef unsigned long iopte_t;
 typedef unsigned long pmd_t;
 typedef unsigned long pud_t;
+typedef unsigned long p4d_t;
 typedef unsigned long pgd_t;
 typedef unsigned long pgprot_t;
 
@@ -92,6 +96,7 @@
 #define iopte_val(x)	(x)
 #define pmd_val(x)      (x)
 #define pud_val(x)      (x)
+#define p4d_val(x)      (x)
 #define pgd_val(x)	(x)
 #define pgprot_val(x)	(x)
 
@@ -99,6 +104,7 @@
 #define __iopte(x)	(x)
 #define __pmd(x)        (x)
 #define __pud(x)        (x)
+#define __p4d(x)        (x)
 #define __pgd(x)	(x)
 #define __pgprot(x)	(x)
 
diff --git a/arch/sparc/include/asm/pgalloc_64.h b/arch/sparc/include/asm/pgalloc_64.h
index 3529f13..b12847c 100644
--- a/arch/sparc/include/asm/pgalloc_64.h
+++ b/arch/sparc/include/asm/pgalloc_64.h
@@ -15,12 +15,12 @@
 
 extern struct kmem_cache *pgtable_cache;
 
-static inline void __pgd_populate(pgd_t *pgd, pud_t *pud)
+static inline void __pgd_populate(pgd_t *pgd, p4d_t *p4d)
 {
-	pgd_set(pgd, pud);
+	pgd_set(pgd, p4d);
 }
+#define pgd_populate(MM, PGD, P4D)	__pgd_populate(PGD, P4D)
 
-#define pgd_populate(MM, PGD, PUD)	__pgd_populate(PGD, PUD)
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
@@ -32,6 +32,22 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 	kmem_cache_free(pgtable_cache, pgd);
 }
 
+static inline void __p4d_populate(p4d_t *p4d, pud_t *pud)
+{
+	p4d_set(p4d, pud);
+}
+#define p4d_populate(MM, P4D, PUD)	__p4d_populate(P4D, PUD)
+
+static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long addr)
+{
+	return kmem_cache_alloc(pgtable_cache, GFP_KERNEL);
+}
+
+static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
+{
+	kmem_cache_free(pgtable_cache, p4d);
+}
+
 static inline void __pud_populate(pud_t *pud, pmd_t *pmd)
 {
 	pud_set(pud, pmd);
@@ -115,4 +131,7 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pte_t *pte,
 #define __pud_free_tlb(tlb, pud, addr)		      \
 	pgtable_free_tlb(tlb, pud, false)
 
+#define __p4d_free_tlb(tlb, p4d, addr)		      \
+	pgtable_free_tlb(tlb, p4d, false)
+
 #endif /* _SPARC64_PGALLOC_H */
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 6fbd931..665a094 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -12,7 +12,6 @@
  * the SpitFire page tables.
  */
 
-#include <asm-generic/5level-fixup.h>
 #include <linux/compiler.h>
 #include <linux/const.h>
 #include <asm/types.h>
@@ -59,8 +58,16 @@
 #define PUD_MASK	(~(PUD_SIZE-1))
 #define PUD_BITS	(PAGE_SHIFT - 3)
 
-/* PGDIR_SHIFT determines what a fourth-level page table entry can map */
-#define PGDIR_SHIFT	(PUD_SHIFT + PUD_BITS)
+/* P4D_SHIFT determines the size of the area a fourth-level page
+ * table can map
+*/
+#define P4D_SHIFT	(PUD_SHIFT + PUD_BITS)
+#define P4D_SIZE	(_AC(1,UL) << P4D_SHIFT)
+#define P4D_MASK	(~(P4D_SIZE-1))
+#define P4D_BITS	(PAGE_SHIFT - 3)
+
+/* PGDIR_SHIFT determines what a fifth-level page table entry can map */
+#define PGDIR_SHIFT	(P4D_SHIFT + P4D_BITS)
 #define PGDIR_SIZE	(_AC(1,UL) << PGDIR_SHIFT)
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 #define PGDIR_BITS	(PAGE_SHIFT - 3)
@@ -69,7 +76,7 @@
 #error MAX_PHYS_ADDRESS_BITS exceeds what kernel page tables can support
 #endif
 
-#if (PGDIR_SHIFT + PGDIR_BITS) != 53
+#if (PGDIR_SHIFT + PGDIR_BITS) != 63
 #error Page table parameters do not cover virtual address space properly.
 #endif
 
@@ -91,6 +98,7 @@
 #define PTRS_PER_PTE	(1UL << (PAGE_SHIFT-3))
 #define PTRS_PER_PMD	(1UL << PMD_BITS)
 #define PTRS_PER_PUD	(1UL << PUD_BITS)
+#define PTRS_PER_P4D	(1UL << P4D_BITS)
 #define PTRS_PER_PGD	(1UL << PGDIR_BITS)
 
 /* Kernel has a separate 44bit address space. */
@@ -102,6 +110,9 @@
 #define pud_ERROR(e)							\
 	pr_err("%s:%d: bad pud %p(%016lx) seen at (%pS)\n",		\
 	       __FILE__, __LINE__, &(e), pud_val(e), __builtin_return_address(0))
+#define p4d_ERROR(e)							\
+	pr_err("%s:%d: bad p4d %p(%016lx) seen at (%pS)\n",		\
+	       __FILE__, __LINE__, &(e), p4d_val(e), __builtin_return_address(0))
 #define pgd_ERROR(e)							\
 	pr_err("%s:%d: bad pgd %p(%016lx) seen at (%pS)\n",		\
 	       __FILE__, __LINE__, &(e), pgd_val(e), __builtin_return_address(0))
@@ -790,6 +801,10 @@ static inline int pmd_present(pmd_t pmd)
 
 #define pud_bad(pud)			(pud_val(pud) & ~PAGE_MASK)
 
+#define p4d_none(p4d)			(!p4d_val(p4d))
+
+#define p4d_bad(p4d)			(p4d_val(p4d) & ~PAGE_MASK)
+
 #define pgd_none(pgd)			(!pgd_val(pgd))
 
 #define pgd_bad(pgd)			(pgd_val(pgd) & ~PAGE_MASK)
@@ -823,13 +838,24 @@ static inline unsigned long __pmd_page(pmd_t pmd)
 
 	return ((unsigned long) __va(pfn << PAGE_SHIFT));
 }
+
 #define pmd_page(pmd) 			virt_to_page((void *)__pmd_page(pmd))
+#define pmd_clear(pmdp)			(pmd_val(*(pmdp)) = 0UL)
 #define pud_page_vaddr(pud)		\
 	((unsigned long) __va(pud_val(pud)))
 #define pud_page(pud) 			virt_to_page((void *)pud_page_vaddr(pud))
-#define pmd_clear(pmdp)			(pmd_val(*(pmdp)) = 0UL)
 #define pud_present(pud)		(pud_val(pud) != 0U)
 #define pud_clear(pudp)			(pud_val(*(pudp)) = 0UL)
+
+#define p4d_set(p4dp, pudp)	\
+	(p4d_val(*(p4dp)) = (__pa((unsigned long) (pudp))))
+
+#define p4d_page_vaddr(p4d)             \
+	((unsigned long) __va(p4d_val(p4d)))
+#define p4d_page(p4d)                   virt_to_page((void *)p4d_page_vaddr(p4d))
+#define p4d_present(p4d)                (p4d_val(p4d) != 0U)
+#define p4d_clear(p4dp)                 (p4d_val(*(p4dp)) = 0UL)
+
 #define pgd_page_vaddr(pgd)		\
 	((unsigned long) __va(pgd_val(pgd)))
 #define pgd_present(pgd)		(pgd_val(pgd) != 0U)
@@ -852,8 +878,8 @@ static inline unsigned long pud_pfn(pud_t pud)
 /* Same in both SUN4V and SUN4U.  */
 #define pte_none(pte) 			(!pte_val(pte))
 
-#define pgd_set(pgdp, pudp)	\
-	(pgd_val(*(pgdp)) = (__pa((unsigned long) (pudp))))
+#define pgd_set(pgdp, p4dp)	\
+	(pgd_val(*(pgdp)) = (__pa((unsigned long) (p4dp))))
 
 /* to find an entry in a page-table-directory. */
 #define pgd_index(address)	(((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
@@ -862,10 +888,15 @@ static inline unsigned long pud_pfn(pud_t pud)
 /* to find an entry in a kernel page-table-directory */
 #define pgd_offset_k(address) pgd_offset(&init_mm, address)
 
+/* Find an entry in the fourt-level page table.. */
+#define p4d_index(address)	(((address) >> P4D_SHIFT) & (PTRS_PER_P4D - 1))
+#define p4d_offset(pgdp, address)	\
+	((p4d_t *) pgd_page_vaddr(*(pgdp)) + p4d_index(address))
+
 /* Find an entry in the third-level page table.. */
 #define pud_index(address)	(((address) >> PUD_SHIFT) & (PTRS_PER_PUD - 1))
-#define pud_offset(pgdp, address)	\
-	((pud_t *) pgd_page_vaddr(*(pgdp)) + pud_index(address))
+#define pud_offset(p4dp, address)	\
+	((pud_t *) p4d_page_vaddr(*(p4dp)) + pud_index(address))
 
 /* Find an entry in the second-level page table.. */
 #define pmd_offset(pudp, address)	\
diff --git a/arch/sparc/include/asm/tsb.h b/arch/sparc/include/asm/tsb.h
index 32258e0..d2e7974 100644
--- a/arch/sparc/include/asm/tsb.h
+++ b/arch/sparc/include/asm/tsb.h
@@ -160,6 +160,11 @@ struct tsb_phys_patch_entry {
 	andn		REG2, 0x7, REG2; \
 	ldx		[REG1 + REG2], REG1; \
 	brz,pn		REG1, FAIL_LABEL; \
+	 sllx		VADDR, 64 - (P4D_SHIFT + P4D_BITS), REG2; \
+	srlx		REG2, 64 - PAGE_SHIFT, REG2; \
+	andn		REG2, 0x7, REG2; \
+	ldxa		[REG1 + REG2] ASI_PHYS_USE_EC, REG1; \
+	brz,pn		REG1, FAIL_LABEL; \
 	 sllx		VADDR, 64 - (PUD_SHIFT + PUD_BITS), REG2; \
 	srlx		REG2, 64 - PAGE_SHIFT, REG2; \
 	andn		REG2, 0x7, REG2; \
@@ -238,6 +243,11 @@ struct tsb_phys_patch_entry {
 	andn		REG2, 0x7, REG2; \
 	ldxa		[PHYS_PGD + REG2] ASI_PHYS_USE_EC, REG1; \
 	brz,pn		REG1, FAIL_LABEL; \
+	 sllx		VADDR, 64 - (P4D_SHIFT + P4D_BITS), REG2; \
+	srlx		REG2, 64 - PAGE_SHIFT, REG2; \
+	andn		REG2, 0x7, REG2; \
+	ldxa		[REG1 + REG2] ASI_PHYS_USE_EC, REG1; \
+	brz,pn		REG1, FAIL_LABEL; \
 	 sllx		VADDR, 64 - (PUD_SHIFT + PUD_BITS), REG2; \
 	srlx		REG2, 64 - PAGE_SHIFT, REG2; \
 	andn		REG2, 0x7, REG2; \
diff --git a/arch/sparc/kernel/signal32.c b/arch/sparc/kernel/signal32.c
index b4096bb..897de4c 100644
--- a/arch/sparc/kernel/signal32.c
+++ b/arch/sparc/kernel/signal32.c
@@ -369,6 +369,7 @@ static void flush_signal_insns(unsigned long address)
 	unsigned long pstate, paddr;
 	pte_t *ptep, pte;
 	pgd_t *pgdp;
+	p4d_t *p4dp;
 	pud_t *pudp;
 	pmd_t *pmdp;
 
@@ -388,7 +389,10 @@ static void flush_signal_insns(unsigned long address)
 	pgdp = pgd_offset(current->mm, address);
 	if (pgd_none(*pgdp))
 		goto out_irqs_on;
-	pudp = pud_offset(pgdp, address);
+	p4dp = p4d_offset(pgdp, address);
+	if (p4d_none(*p4dp))
+		goto out_irqs_on;
+	pudp = pud_offset(p4dp, address);
 	if (pud_none(*pudp))
 		goto out_irqs_on;
 	pmdp = pmd_offset(pudp, address);
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index 3218bc4..da1220b 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1546,17 +1546,26 @@ static int __init pcpu_cpu_distance(unsigned int from, unsigned int to)
 static void __init pcpu_populate_pte(unsigned long addr)
 {
 	pgd_t *pgd = pgd_offset_k(addr);
+	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
 
 	if (pgd_none(*pgd)) {
-		pud_t *new;
+		p4d_t *new;
 
 		new = __alloc_bootmem(PAGE_SIZE, PAGE_SIZE, PAGE_SIZE);
 		pgd_populate(&init_mm, pgd, new);
 	}
 
-	pud = pud_offset(pgd, addr);
+	p4d = p4d_offset(pgd, addr);
+	if (p4d_none(*p4d)) {
+		pud_t *new;
+
+		new = __alloc_bootmem(PAGE_SIZE, PAGE_SIZE, PAGE_SIZE);
+		p4d_populate(&init_mm, p4d, new);
+	}
+
+	pud = pud_offset(p4d, addr);
 	if (pud_none(*pud)) {
 		pmd_t *new;
 
diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
index b84c4dd1..08cf479 100644
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -93,6 +93,7 @@ static void __kprobes bad_kernel_pc(struct pt_regs *regs, unsigned long vaddr)
 static unsigned int get_user_insn(unsigned long tpc)
 {
 	pgd_t *pgdp = pgd_offset(current->mm, tpc);
+	p4d_t *p4dp;
 	pud_t *pudp;
 	pmd_t *pmdp;
 	pte_t *ptep, pte;
@@ -101,7 +102,12 @@ static unsigned int get_user_insn(unsigned long tpc)
 
 	if (pgd_none(*pgdp) || unlikely(pgd_bad(*pgdp)))
 		goto out;
-	pudp = pud_offset(pgdp, tpc);
+
+	p4dp = p4d_offset(pgdp, tpc);
+	if (p4d_none(*p4dp) || unlikely(p4d_bad(*p4dp)))
+		goto out;
+
+	pudp = pud_offset(p4dp, tpc);
 	if (pud_none(*pudp) || unlikely(pud_bad(*pudp)))
 		goto out;
 
diff --git a/arch/sparc/mm/gup.c b/arch/sparc/mm/gup.c
index f80cfc6..6bef809 100644
--- a/arch/sparc/mm/gup.c
+++ b/arch/sparc/mm/gup.c
@@ -128,13 +128,13 @@ static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
 	return 1;
 }
 
-static int gup_pud_range(pgd_t pgd, unsigned long addr, unsigned long end,
+static int gup_pud_range(p4d_t p4d, unsigned long addr, unsigned long end,
 		int write, struct page **pages, int *nr)
 {
 	unsigned long next;
 	pud_t *pudp;
 
-	pudp = pud_offset(&pgd, addr);
+	pudp = pud_offset(&p4d, addr);
 	do {
 		pud_t pud = *pudp;
 
@@ -148,6 +148,26 @@ static int gup_pud_range(pgd_t pgd, unsigned long addr, unsigned long end,
 	return 1;
 }
 
+static int gup_p4d_range(pgd_t pgd, unsigned long addr, unsigned long end,
+			 int write, struct page **pages, int *nr)
+{
+	unsigned long next;
+	p4d_t *p4dp;
+
+	p4dp = p4d_offset(&pgd, addr);
+	do {
+		p4d_t p4d = *p4dp;
+
+		next = p4d_addr_end(addr, end);
+		if (p4d_none(p4d))
+			return 0;
+		if (!gup_pud_range(p4d, addr, next, write, pages, nr))
+			return 0;
+	} while (p4dp++, addr = next, addr != end);
+
+	return 1;
+}
+
 int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 			  struct page **pages)
 {
@@ -170,7 +190,7 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 		next = pgd_addr_end(addr, end);
 		if (pgd_none(pgd))
 			break;
-		if (!gup_pud_range(pgd, addr, next, write, pages, &nr))
+		if (!gup_p4d_range(pgd, addr, next, write, pages, &nr))
 			break;
 	} while (pgdp++, addr = next, addr != end);
 	local_irq_restore(flags);
@@ -218,7 +238,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 		next = pgd_addr_end(addr, end);
 		if (pgd_none(pgd))
 			goto slow;
-		if (!gup_pud_range(pgd, addr, next, write, pages, &nr))
+		if (!gup_p4d_range(pgd, addr, next, write, pages, &nr))
 			goto slow;
 	} while (pgdp++, addr = next, addr != end);
 
diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index 28ee8d8..821af65 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -257,21 +257,25 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
 			unsigned long addr, unsigned long sz)
 {
 	pgd_t *pgd;
+	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte = NULL;
 
 	pgd = pgd_offset(mm, addr);
-	pud = pud_alloc(mm, pgd, addr);
-	if (pud) {
-		pmd = pmd_alloc(mm, pud, addr);
-		if (!pmd)
-			return NULL;
-
-		if (sz >= PMD_SIZE)
-			pte = (pte_t *)pmd;
-		else
-			pte = pte_alloc_map(mm, pmd, addr);
+	p4d = p4d_alloc(mm, pgd, addr);
+	if (p4d) {
+		pud = pud_alloc(mm, p4d, addr);
+		if (pud) {
+			pmd = pmd_alloc(mm, pud, addr);
+			if (!pmd)
+				return NULL;
+
+			if (sz >= PMD_SIZE)
+				pte = (pte_t *)pmd;
+			else
+				pte = pte_alloc_map(mm, pmd, addr);
+		}
 	}
 
 	return pte;
@@ -281,20 +285,24 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
 		       unsigned long addr, unsigned long sz)
 {
 	pgd_t *pgd;
+	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte = NULL;
 
 	pgd = pgd_offset(mm, addr);
 	if (!pgd_none(*pgd)) {
-		pud = pud_offset(pgd, addr);
-		if (!pud_none(*pud)) {
-			pmd = pmd_offset(pud, addr);
-			if (!pmd_none(*pmd)) {
-				if (is_hugetlb_pmd(*pmd))
-					pte = (pte_t *)pmd;
-				else
-					pte = pte_offset_map(pmd, addr);
+		p4d = p4d_offset(pgd, addr);
+		if (!p4d_none(*p4d)) {
+			pud = pud_offset(p4d, addr);
+			if (!pud_none(*pud)) {
+				pmd = pmd_offset(pud, addr);
+				if (!pmd_none(*pmd)) {
+					if (is_hugetlb_pmd(*pmd))
+						pte = (pte_t *)pmd;
+					else
+						pte = pte_offset_map(pmd, addr);
+				}
 			}
 		}
 	}
@@ -421,7 +429,7 @@ static void hugetlb_free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
 	mm_dec_nr_pmds(tlb->mm);
 }
 
-static void hugetlb_free_pud_range(struct mmu_gather *tlb, pgd_t *pgd,
+static void hugetlb_free_pud_range(struct mmu_gather *tlb, p4d_t *p4d,
 				   unsigned long addr, unsigned long end,
 				   unsigned long floor, unsigned long ceiling)
 {
@@ -430,7 +438,7 @@ static void hugetlb_free_pud_range(struct mmu_gather *tlb, pgd_t *pgd,
 	unsigned long start;
 
 	start = addr;
-	pud = pud_offset(pgd, addr);
+	pud = pud_offset(p4d, addr);
 	do {
 		next = pud_addr_end(addr, end);
 		if (pud_none_or_clear_bad(pud))
@@ -439,6 +447,40 @@ static void hugetlb_free_pud_range(struct mmu_gather *tlb, pgd_t *pgd,
 				       ceiling);
 	} while (pud++, addr = next, addr != end);
 
+	start &= P4D_MASK;
+	if (start < floor)
+		return;
+	if (ceiling) {
+		ceiling &= P4D_MASK;
+		if (!ceiling)
+			return;
+	}
+	if (end - 1 > ceiling - 1)
+		return;
+
+	pud = pud_offset(p4d, start);
+	p4d_clear(p4d);
+	pud_free_tlb(tlb, pud, start);
+}
+
+static void hugetlb_free_p4d_range(struct mmu_gather *tlb, pgd_t *pgd,
+				   unsigned long addr, unsigned long end,
+				   unsigned long floor, unsigned long ceiling)
+{
+	p4d_t *p4d;
+	unsigned long next;
+	unsigned long start;
+
+	start = addr;
+	p4d = p4d_offset(pgd, addr);
+	do {
+		next = p4d_addr_end(addr, end);
+		if (p4d_none_or_clear_bad(p4d))
+			continue;
+		hugetlb_free_pud_range(tlb, p4d, addr, next, floor,
+				ceiling);
+	} while (p4d++, addr = next, addr != end);
+
 	start &= PGDIR_MASK;
 	if (start < floor)
 		return;
@@ -450,9 +492,9 @@ static void hugetlb_free_pud_range(struct mmu_gather *tlb, pgd_t *pgd,
 	if (end - 1 > ceiling - 1)
 		return;
 
-	pud = pud_offset(pgd, start);
+	p4d = p4d_offset(pgd, start);
 	pgd_clear(pgd);
-	pud_free_tlb(tlb, pud, start);
+	p4d_free_tlb(tlb, p4d, start);
 }
 
 void hugetlb_free_pgd_range(struct mmu_gather *tlb,
@@ -483,6 +525,6 @@ void hugetlb_free_pgd_range(struct mmu_gather *tlb,
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
-		hugetlb_free_pud_range(tlb, pgd, addr, next, floor, ceiling);
+		hugetlb_free_p4d_range(tlb, pgd, addr, next, floor, ceiling);
 	} while (pgd++, addr = next, addr != end);
 }
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index a111625..612b53a 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -467,7 +467,8 @@ void __kprobes flush_icache_range(unsigned long start, unsigned long end)
 				paddr = kaddr & mask;
 			else {
 				pgd_t *pgdp = pgd_offset_k(kaddr);
-				pud_t *pudp = pud_offset(pgdp, kaddr);
+				p4d_t *p4dp = p4d_offset(pgdp, kaddr);
+				pud_t *pudp = pud_offset(p4dp, kaddr);
 				pmd_t *pmdp = pmd_offset(pudp, kaddr);
 				pte_t *ptep = pte_offset_kernel(pmdp, kaddr);
 
@@ -1591,6 +1592,7 @@ static unsigned long __init bootmem_init(unsigned long phys_base)
 bool kern_addr_valid(unsigned long addr)
 {
 	pgd_t *pgd;
+	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
@@ -1612,7 +1614,11 @@ bool kern_addr_valid(unsigned long addr)
 	if (pgd_none(*pgd))
 		return 0;
 
-	pud = pud_offset(pgd, addr);
+	p4d = p4d_offset(pgd, addr);
+	if (p4d_none(*p4d))
+		return 0;
+
+	pud = pud_offset(p4d, addr);
 	if (pud_none(*pud))
 		return 0;
 
@@ -1738,18 +1744,27 @@ static unsigned long __ref kernel_map_range(unsigned long pstart,
 	while (vstart < vend) {
 		unsigned long this_end, paddr = __pa(vstart);
 		pgd_t *pgd = pgd_offset_k(vstart);
+		p4d_t *p4d;
 		pud_t *pud;
 		pmd_t *pmd;
 		pte_t *pte;
 
 		if (pgd_none(*pgd)) {
-			pud_t *new;
+			p4d_t *new;
 
 			new = __alloc_bootmem(PAGE_SIZE, PAGE_SIZE, PAGE_SIZE);
 			alloc_bytes += PAGE_SIZE;
 			pgd_populate(&init_mm, pgd, new);
 		}
-		pud = pud_offset(pgd, vstart);
+		p4d = p4d_offset(pgd, vstart);
+		if (p4d_none(*p4d)) {
+			pud_t *new;
+
+			new = __alloc_bootmem(PAGE_SIZE, PAGE_SIZE, PAGE_SIZE);
+			alloc_bytes += PAGE_SIZE;
+			p4d_populate(&init_mm, p4d, new);
+		}
+		pud = pud_offset(p4d, vstart);
 		if (pud_none(*pud)) {
 			pmd_t *new;
 
@@ -2565,18 +2580,28 @@ int __meminit vmemmap_populate(unsigned long vstart, unsigned long vend,
 	for (; vstart < vend; vstart += PMD_SIZE) {
 		pgd_t *pgd = pgd_offset_k(vstart);
 		unsigned long pte;
+		p4d_t *p4d;
 		pud_t *pud;
 		pmd_t *pmd;
 
 		if (pgd_none(*pgd)) {
-			pud_t *new = vmemmap_alloc_block(PAGE_SIZE, node);
+			p4d_t *new = vmemmap_alloc_block(PAGE_SIZE, node);
 
 			if (!new)
 				return -ENOMEM;
 			pgd_populate(&init_mm, pgd, new);
 		}
 
-		pud = pud_offset(pgd, vstart);
+		p4d = p4d_offset(pgd, vstart);
+		if (p4d_none(*p4d)) {
+			pud_t *new = vmemmap_alloc_block(PAGE_SIZE, node);
+
+			if (!new)
+				return -ENOMEM;
+			p4d_populate(&init_mm, p4d, new);
+		}
+
+		pud = pud_offset(p4d, vstart);
 		if (pud_none(*pud)) {
 			pmd_t *new = vmemmap_alloc_block(PAGE_SIZE, node);
 
-- 
1.9.1

