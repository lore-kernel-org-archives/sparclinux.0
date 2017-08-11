From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Fri, 11 Aug 2017 23:46:50 +0000
Subject: [PATCH v6 2/3] sparc64: Add 16GB hugepage support
Message-Id: <1502495225-199727-3-git-send-email-nitin.m.gupta@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1502495225-199727-1-git-send-email-nitin.m.gupta@oracle.com>
In-Reply-To: <1502495225-199727-1-git-send-email-nitin.m.gupta@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Anthony Yznaga <anthony.yznaga@oracle.com>, Nitin Gupta <nitin.m.gupta@oracle.com>, Bob Picco <bob.picco@oracle.com>, Mike Kravetz <mike.kravetz@oracle.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Tom Hromatka <tom.hromatka@oracle.com>, Ingo Molnar <mingo@kernel.org>, Dave Aldridge <david.j.aldridge@oracle.com>, Rob Gardner <rob.gardner@oracle.com>, Babu Moger <babu.moger@oracle.com>, Allen Pais <allen.pais@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Pavel Tatashin <pasha.tatashin@oracle.com>, Chris Metcalf <cmetcalf@mellanox.com>, Steve Capper <steve.capper@arm.com>, Hugh Dickins <hughd@google.com>, Punit Agrawal <punit.agrawal@arm.com>, Steven Sistare <steven.sistare@oracle.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Thomas Tai <thomas.tai@oracle.com>, Atish Patra <atish.patra@oracle.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Adds support for 16GB hugepage size. To use this page size
use kernel parameters as:

default_hugepageszG hugepageszG hugepages

Testing:

Tested with the stream benchmark which allocates 48G of
arrays backed by 16G hugepages and does RW operation on
them in parallel.

Orabug: 25362942

Cc: Anthony Yznaga <anthony.yznaga@oracle.com>
Reviewed-by: Bob Picco <bob.picco@oracle.com>
Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>
---
 arch/sparc/include/asm/hugetlb.h    |  7 ++++
 arch/sparc/include/asm/page_64.h    |  3 +-
 arch/sparc/include/asm/pgtable_64.h |  5 +++
 arch/sparc/include/asm/tsb.h        | 36 ++++++++++++++++++
 arch/sparc/kernel/head_64.S         |  2 +-
 arch/sparc/kernel/tsb.S             |  2 +-
 arch/sparc/kernel/vmlinux.lds.S     |  5 +++
 arch/sparc/mm/hugetlbpage.c         | 74 ++++++++++++++++++++++++++-----------
 arch/sparc/mm/init_64.c             | 54 +++++++++++++++++++++++----
 9 files changed, 157 insertions(+), 31 deletions(-)

diff --git a/arch/sparc/include/asm/hugetlb.h b/arch/sparc/include/asm/hugetlb.h
index d1f837d..0ca7caa 100644
--- a/arch/sparc/include/asm/hugetlb.h
+++ b/arch/sparc/include/asm/hugetlb.h
@@ -4,6 +4,13 @@
 #include <asm/page.h>
 #include <asm-generic/hugetlb.h>
 
+#ifdef CONFIG_HUGETLB_PAGE
+struct pud_huge_patch_entry {
+	unsigned int addr;
+	unsigned int insn;
+};
+extern struct pud_huge_patch_entry __pud_huge_patch, __pud_huge_patch_end;
+#endif
 
 void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 		     pte_t *ptep, pte_t pte);
diff --git a/arch/sparc/include/asm/page_64.h b/arch/sparc/include/asm/page_64.h
index 5961b2d..8ee1f97 100644
--- a/arch/sparc/include/asm/page_64.h
+++ b/arch/sparc/include/asm/page_64.h
@@ -17,6 +17,7 @@
 
 #define HPAGE_SHIFT		23
 #define REAL_HPAGE_SHIFT	22
+#define HPAGE_16GB_SHIFT	34
 #define HPAGE_2GB_SHIFT		31
 #define HPAGE_256MB_SHIFT	28
 #define HPAGE_64K_SHIFT		16
@@ -28,7 +29,7 @@
 #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
 #define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
 #define REAL_HPAGE_PER_HPAGE	(_AC(1,UL) << (HPAGE_SHIFT - REAL_HPAGE_SHIFT))
-#define HUGE_MAX_HSTATE		4
+#define HUGE_MAX_HSTATE		5
 #endif
 
 #ifndef __ASSEMBLY__
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 2579f5a..4fefe37 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -414,6 +414,11 @@ static inline bool is_hugetlb_pmd(pmd_t pmd)
 	return !!(pmd_val(pmd) & _PAGE_PMD_HUGE);
 }
 
+static inline bool is_hugetlb_pud(pud_t pud)
+{
+	return !!(pud_val(pud) & _PAGE_PUD_HUGE);
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static inline pmd_t pmd_mkhuge(pmd_t pmd)
 {
diff --git a/arch/sparc/include/asm/tsb.h b/arch/sparc/include/asm/tsb.h
index 32258e0..acf5506 100644
--- a/arch/sparc/include/asm/tsb.h
+++ b/arch/sparc/include/asm/tsb.h
@@ -195,6 +195,41 @@ extern struct tsb_phys_patch_entry __tsb_phys_patch, __tsb_phys_patch_end;
 	 nop; \
 699:
 
+	/* PUD has been loaded into REG1, interpret the value, seeing
+	 * if it is a HUGE PUD or a normal one.  If it is not valid
+	 * then jump to FAIL_LABEL.  If it is a HUGE PUD, and it
+	 * translates to a valid PTE, branch to PTE_LABEL.
+	 *
+	 * We have to propagate bits [32:22] from the virtual address
+	 * to resolve at 4M granularity.
+	 */
+#if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
+#define USER_PGTABLE_CHECK_PUD_HUGE(VADDR, REG1, REG2, FAIL_LABEL, PTE_LABEL) \
+700:	ba 700f;					\
+	 nop;						\
+	.section	.pud_huge_patch, "ax";		\
+	.word		700b;				\
+	nop;						\
+	.previous;					\
+	brz,pn		REG1, FAIL_LABEL;		\
+	 sethi		%uhi(_PAGE_PUD_HUGE), REG2;	\
+	sllx		REG2, 32, REG2;			\
+	andcc		REG1, REG2, %g0;		\
+	be,pt		%xcc, 700f;			\
+	 sethi		%hi(0x1ffc0000), REG2;		\
+	sllx		REG2, 1, REG2;			\
+	brgez,pn	REG1, FAIL_LABEL;		\
+	 andn		REG1, REG2, REG1;		\
+	and		VADDR, REG2, REG2;		\
+	brlz,pt		REG1, PTE_LABEL;		\
+	 or		REG1, REG2, REG1;		\
+700:
+#else
+#define USER_PGTABLE_CHECK_PUD_HUGE(VADDR, REG1, REG2, FAIL_LABEL, PTE_LABEL) \
+	brz,pn		REG1, FAIL_LABEL; \
+	 nop;
+#endif
+
 	/* PMD has been loaded into REG1, interpret the value, seeing
 	 * if it is a HUGE PMD or a normal one.  If it is not valid
 	 * then jump to FAIL_LABEL.  If it is a HUGE PMD, and it
@@ -242,6 +277,7 @@ extern struct tsb_phys_patch_entry __tsb_phys_patch, __tsb_phys_patch_end;
 	srlx		REG2, 64 - PAGE_SHIFT, REG2; \
 	andn		REG2, 0x7, REG2; \
 	ldxa		[REG1 + REG2] ASI_PHYS_USE_EC, REG1; \
+	USER_PGTABLE_CHECK_PUD_HUGE(VADDR, REG1, REG2, FAIL_LABEL, 800f) \
 	brz,pn		REG1, FAIL_LABEL; \
 	 sllx		VADDR, 64 - (PMD_SHIFT + PMD_BITS), REG2; \
 	srlx		REG2, 64 - PAGE_SHIFT, REG2; \
diff --git a/arch/sparc/kernel/head_64.S b/arch/sparc/kernel/head_64.S
index 78e0211..6986d07 100644
--- a/arch/sparc/kernel/head_64.S
+++ b/arch/sparc/kernel/head_64.S
@@ -881,7 +881,6 @@ sparc64_boot_end:
 #include "misctrap.S"
 #include "syscalls.S"
 #include "helpers.S"
-#include "hvcalls.S"
 #include "sun4v_tlb_miss.S"
 #include "sun4v_ivec.S"
 #include "ktlb.S"
@@ -926,6 +925,7 @@ swapper_4m_tsb:
 
 ! 0x0000000000428000
 
+#include "hvcalls.S"
 #include "systbls_64.S"
 
 	.data
diff --git a/arch/sparc/kernel/tsb.S b/arch/sparc/kernel/tsb.S
index db872db..f741153 100644
--- a/arch/sparc/kernel/tsb.S
+++ b/arch/sparc/kernel/tsb.S
@@ -117,7 +117,7 @@ tsb_miss_page_table_walk_sun4v_fastpath:
 	/* Valid PTE is now in %g5.  */
 
 #if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
-	sethi		%uhi(_PAGE_PMD_HUGE), %g7
+	sethi		%uhi(_PAGE_PMD_HUGE | _PAGE_PUD_HUGE), %g7
 	sllx		%g7, 32, %g7
 
 	andcc		%g5, %g7, %g0
diff --git a/arch/sparc/kernel/vmlinux.lds.S b/arch/sparc/kernel/vmlinux.lds.S
index 03b3d65..34d37e6 100644
--- a/arch/sparc/kernel/vmlinux.lds.S
+++ b/arch/sparc/kernel/vmlinux.lds.S
@@ -154,6 +154,11 @@ SECTIONS
 		*(.get_tick_patch)
 		__get_tick_patch_end = .;
 	}
+	.pud_huge_patch : {
+		__pud_huge_patch = .;
+		*(.pud_huge_patch)
+		__pud_huge_patch_end = .;
+	}
 	PERCPU_SECTION(SMP_CACHE_BYTES)
 
 #ifdef CONFIG_JUMP_LABEL
diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index 28ee8d8..7acb84d 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -143,6 +143,10 @@ static pte_t sun4v_hugepage_shift_to_tte(pte_t entry, unsigned int shift)
 	pte_val(entry) = pte_val(entry) & ~_PAGE_SZALL_4V;
 
 	switch (shift) {
+	case HPAGE_16GB_SHIFT:
+		hugepage_size = _PAGE_SZ16GB_4V;
+		pte_val(entry) |= _PAGE_PUD_HUGE;
+		break;
 	case HPAGE_2GB_SHIFT:
 		hugepage_size = _PAGE_SZ2GB_4V;
 		pte_val(entry) |= _PAGE_PMD_HUGE;
@@ -187,6 +191,9 @@ static unsigned int sun4v_huge_tte_to_shift(pte_t entry)
 	unsigned int shift;
 
 	switch (tte_szbits) {
+	case _PAGE_SZ16GB_4V:
+		shift = HPAGE_16GB_SHIFT;
+		break;
 	case _PAGE_SZ2GB_4V:
 		shift = HPAGE_2GB_SHIFT;
 		break;
@@ -263,7 +270,12 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
 
 	pgd = pgd_offset(mm, addr);
 	pud = pud_alloc(mm, pgd, addr);
-	if (pud) {
+	if (!pud)
+		return NULL;
+
+	if (sz >= PUD_SIZE)
+		pte = (pte_t *)pud;
+	else {
 		pmd = pmd_alloc(mm, pud, addr);
 		if (!pmd)
 			return NULL;
@@ -289,12 +301,16 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
 	if (!pgd_none(*pgd)) {
 		pud = pud_offset(pgd, addr);
 		if (!pud_none(*pud)) {
-			pmd = pmd_offset(pud, addr);
-			if (!pmd_none(*pmd)) {
-				if (is_hugetlb_pmd(*pmd))
-					pte = (pte_t *)pmd;
-				else
-					pte = pte_offset_map(pmd, addr);
+			if (is_hugetlb_pud(*pud))
+				pte = (pte_t *)pud;
+			else {
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
@@ -305,12 +321,20 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
 void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 		     pte_t *ptep, pte_t entry)
 {
-	unsigned int i, nptes, orig_shift, shift;
-	unsigned long size;
+	unsigned int nptes, orig_shift, shift;
+	unsigned long i, size;
 	pte_t orig;
 
 	size = huge_tte_to_size(entry);
-	shift = size >= HPAGE_SIZE ? PMD_SHIFT : PAGE_SHIFT;
+
+	shift = PAGE_SHIFT;
+	if (size >= PUD_SIZE)
+		shift = PUD_SHIFT;
+	else if (size >= PMD_SIZE)
+		shift = PMD_SHIFT;
+	else
+		shift = PAGE_SHIFT;
+
 	nptes = size >> shift;
 
 	if (!pte_present(*ptep) && pte_present(entry))
@@ -333,19 +357,23 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep)
 {
-	unsigned int i, nptes, hugepage_shift;
+	unsigned int i, nptes, orig_shift, shift;
 	unsigned long size;
 	pte_t entry;
 
 	entry = *ptep;
 	size = huge_tte_to_size(entry);
-	if (size >= HPAGE_SIZE)
-		nptes = size >> PMD_SHIFT;
+
+	shift = PAGE_SHIFT;
+	if (size >= PUD_SIZE)
+		shift = PUD_SHIFT;
+	else if (size >= PMD_SIZE)
+		shift = PMD_SHIFT;
 	else
-		nptes = size >> PAGE_SHIFT;
+		shift = PAGE_SHIFT;
 
-	hugepage_shift = pte_none(entry) ? PAGE_SHIFT :
-		huge_tte_to_shift(entry);
+	nptes = size >> shift;
+	orig_shift = pte_none(entry) ? PAGE_SHIFT : huge_tte_to_shift(entry);
 
 	if (pte_present(entry))
 		mm->context.hugetlb_pte_count -= nptes;
@@ -354,11 +382,11 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
 	for (i = 0; i < nptes; i++)
 		ptep[i] = __pte(0UL);
 
-	maybe_tlb_batch_add(mm, addr, ptep, entry, 0, hugepage_shift);
+	maybe_tlb_batch_add(mm, addr, ptep, entry, 0, orig_shift);
 	/* An HPAGE_SIZE'ed page is composed of two REAL_HPAGE_SIZE'ed pages */
 	if (size = HPAGE_SIZE)
 		maybe_tlb_batch_add(mm, addr + REAL_HPAGE_SIZE, ptep, entry, 0,
-				    hugepage_shift);
+				    orig_shift);
 
 	return entry;
 }
@@ -371,7 +399,8 @@ int pmd_huge(pmd_t pmd)
 
 int pud_huge(pud_t pud)
 {
-	return 0;
+	return !pud_none(pud) &&
+		(pud_val(pud) & (_PAGE_VALID|_PAGE_PUD_HUGE)) != _PAGE_VALID;
 }
 
 static void hugetlb_free_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
@@ -435,8 +464,11 @@ static void hugetlb_free_pud_range(struct mmu_gather *tlb, pgd_t *pgd,
 		next = pud_addr_end(addr, end);
 		if (pud_none_or_clear_bad(pud))
 			continue;
-		hugetlb_free_pmd_range(tlb, pud, addr, next, floor,
-				       ceiling);
+		if (is_hugetlb_pud(*pud))
+			pud_clear(pud);
+		else
+			hugetlb_free_pmd_range(tlb, pud, addr, next, floor,
+					       ceiling);
 	} while (pud++, addr = next, addr != end);
 
 	start &= PGDIR_MASK;
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index afa0099..b2ba410 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -348,6 +348,18 @@ static int __init hugetlbpage_init(void)
 
 arch_initcall(hugetlbpage_init);
 
+static void __init pud_huge_patch(void)
+{
+	struct pud_huge_patch_entry *p;
+	unsigned long addr;
+
+	p = &__pud_huge_patch;
+	addr = p->addr;
+	*(unsigned int *)addr = p->insn;
+
+	__asm__ __volatile__("flush %0" : : "r" (addr));
+}
+
 static int __init setup_hugepagesz(char *string)
 {
 	unsigned long long hugepage_size;
@@ -360,6 +372,11 @@ static int __init setup_hugepagesz(char *string)
 	hugepage_shift = ilog2(hugepage_size);
 
 	switch (hugepage_shift) {
+	case HPAGE_16GB_SHIFT:
+		hv_pgsz_mask = HV_PGSZ_MASK_16GB;
+		hv_pgsz_idx = HV_PGSZ_IDX_16GB;
+		pud_huge_patch();
+		break;
 	case HPAGE_2GB_SHIFT:
 		hv_pgsz_mask = HV_PGSZ_MASK_2GB;
 		hv_pgsz_idx = HV_PGSZ_IDX_2GB;
@@ -400,6 +417,7 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t *
 {
 	struct mm_struct *mm;
 	unsigned long flags;
+	bool is_huge_tsb;
 	pte_t pte = *ptep;
 
 	if (tlb_type != hypervisor) {
@@ -417,15 +435,37 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t *
 
 	spin_lock_irqsave(&mm->context.lock, flags);
 
+	is_huge_tsb = false;
 #if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
-	if ((mm->context.hugetlb_pte_count || mm->context.thp_pte_count) &&
-	    is_hugetlb_pmd(__pmd(pte_val(pte)))) {
-		/* We are fabricating 8MB pages using 4MB real hw pages.  */
-		pte_val(pte) |= (address & (1UL << REAL_HPAGE_SHIFT));
-		__update_mmu_tsb_insert(mm, MM_TSB_HUGE, REAL_HPAGE_SHIFT,
-					address, pte_val(pte));
-	} else
+	if (mm->context.hugetlb_pte_count || mm->context.thp_pte_count) {
+		unsigned long hugepage_size = PAGE_SIZE;
+
+		if (is_vm_hugetlb_page(vma))
+			hugepage_size = huge_page_size(hstate_vma(vma));
+
+		if (hugepage_size >= PUD_SIZE) {
+			unsigned long mask = 0x1ffc00000UL;
+
+			/* Transfer bits [32:22] from address to resolve
+			 * at 4M granularity.
+			 */
+			pte_val(pte) &= ~mask;
+			pte_val(pte) |= (address & mask);
+		} else if (hugepage_size >= PMD_SIZE) {
+			/* We are fabricating 8MB pages using 4MB
+			 * real hw pages.
+			 */
+			pte_val(pte) |= (address & (1UL << REAL_HPAGE_SHIFT));
+		}
+
+		if (hugepage_size >= PMD_SIZE) {
+			__update_mmu_tsb_insert(mm, MM_TSB_HUGE,
+				REAL_HPAGE_SHIFT, address, pte_val(pte));
+			is_huge_tsb = true;
+		}
+	}
 #endif
+	if (!is_huge_tsb)
 		__update_mmu_tsb_insert(mm, MM_TSB_BASE, PAGE_SHIFT,
 					address, pte_val(pte));
 
-- 
2.9.2

