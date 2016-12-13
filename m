From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Tue, 13 Dec 2016 18:03:18 +0000
Subject: [PATCH v4] sparc64: Multi-page size support
Message-Id: <1481652247-12751-1-git-send-email-nitin.m.gupta@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Nitin Gupta <nitin.m.gupta@oracle.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Julian Calaby <julian.calaby@gmail.com>, Hugh Dickins <hughd@google.com>, Adam Buchbinder <adam.buchbinder@gmail.com>, Minchan Kim <minchan@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Paul Gortmaker <paul.gortmaker@windriver.com>, Thomas Tai <thomas.tai@oracle.com>, Chris Hyser <chris.hyser@oracle.com>, Atish Patra <atish.patra@oracle.com>, Michal Hocko <mhocko@suse.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Add support for using multiple hugepage sizes simultaneously
on mainline. Currently, support for 256M has been added which
can be used along with 8M pages.

Page tables are set like this (e.g. for 256M page):
    VA + (8M * x) -> PA + (8M * x) (sz bit = 256M) where x in [0, 31]

and TSB is set similarly:
    VA + (4M * x) -> PA + (4M * x) (sz bit = 256M) where x in [0, 63]

- Testing

Tested on Sonoma (which supports 256M pages) by running stream
benchmark instances in parallel: one instance uses 8M pages and
another uses 256M pages, consuming 48G each.

Boot params used:

default_hugepagesz%6M hugepagesz%6M hugepages00 hugepagesz=8M
hugepages000

Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>
---
Changelog v3 vs v4:
 - Remove incorrect WARN_ON in __flush_huge_tsb_one_entry()

Changelog v2 vs v3:
 - Remove unused label in tsb.S (David)
 - Order local variables from longest to shortest line (David)

Changelog v1 vs v2:
 - Fix warning due to unused __flush_huge_tsb_one() when
   CONFIG_HUGETLB is not defined.
---
 arch/sparc/include/asm/page_64.h     |   3 +-
 arch/sparc/include/asm/pgtable_64.h  |  23 +++--
 arch/sparc/include/asm/tlbflush_64.h |   5 +-
 arch/sparc/kernel/tsb.S              |  21 +----
 arch/sparc/mm/hugetlbpage.c          | 160 +++++++++++++++++++++++++++++++----
 arch/sparc/mm/init_64.c              |  45 +++++++++-
 arch/sparc/mm/tlb.c                  |  17 ++--
 arch/sparc/mm/tsb.c                  |  44 ++++++++--
 8 files changed, 256 insertions(+), 62 deletions(-)

diff --git a/arch/sparc/include/asm/page_64.h b/arch/sparc/include/asm/page_64.h
index c1263fc..d76f38d 100644
--- a/arch/sparc/include/asm/page_64.h
+++ b/arch/sparc/include/asm/page_64.h
@@ -17,7 +17,7 @@
 
 #define HPAGE_SHIFT		23
 #define REAL_HPAGE_SHIFT	22
-
+#define HPAGE_256MB_SHIFT	28
 #define REAL_HPAGE_SIZE		(_AC(1,UL) << REAL_HPAGE_SHIFT)
 
 #if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
@@ -26,6 +26,7 @@
 #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
 #define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
 #define REAL_HPAGE_PER_HPAGE	(_AC(1,UL) << (HPAGE_SHIFT - REAL_HPAGE_SHIFT))
+#define HUGE_MAX_HSTATE		2
 #endif
 
 #ifndef __ASSEMBLY__
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 314b668..7932a4a 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -375,7 +375,10 @@ static inline pgprot_t pgprot_noncached(pgprot_t prot)
 #define pgprot_noncached pgprot_noncached
 
 #if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
-static inline unsigned long __pte_huge_mask(void)
+extern pte_t arch_make_huge_pte(pte_t entry, struct vm_area_struct *vma,
+				struct page *page, int writable);
+#define arch_make_huge_pte arch_make_huge_pte
+static inline unsigned long __pte_default_huge_mask(void)
 {
 	unsigned long mask;
 
@@ -395,12 +398,14 @@ static inline unsigned long __pte_huge_mask(void)
 
 static inline pte_t pte_mkhuge(pte_t pte)
 {
-	return __pte(pte_val(pte) | _PAGE_PMD_HUGE | __pte_huge_mask());
+	return __pte(pte_val(pte) | __pte_default_huge_mask());
 }
 
-static inline bool is_hugetlb_pte(pte_t pte)
+static inline bool is_default_hugetlb_pte(pte_t pte)
 {
-	return !!(pte_val(pte) & __pte_huge_mask());
+	unsigned long mask = __pte_default_huge_mask();
+
+	return (pte_val(pte) & mask) = mask;
 }
 
 static inline bool is_hugetlb_pmd(pmd_t pmd)
@@ -875,10 +880,12 @@ static inline unsigned long pud_pfn(pud_t pud)
 
 /* Actual page table PTE updates.  */
 void tlb_batch_add(struct mm_struct *mm, unsigned long vaddr,
-		   pte_t *ptep, pte_t orig, int fullmm);
+		   pte_t *ptep, pte_t orig, int fullmm,
+		   unsigned int hugepage_shift);
 
 static void maybe_tlb_batch_add(struct mm_struct *mm, unsigned long vaddr,
-				pte_t *ptep, pte_t orig, int fullmm)
+				pte_t *ptep, pte_t orig, int fullmm,
+				unsigned int hugepage_shift)
 {
 	/* It is more efficient to let flush_tlb_kernel_range()
 	 * handle init_mm tlb flushes.
@@ -887,7 +894,7 @@ static void maybe_tlb_batch_add(struct mm_struct *mm, unsigned long vaddr,
 	 *             and SUN4V pte layout, so this inline test is fine.
 	 */
 	if (likely(mm != &init_mm) && pte_accessible(mm, orig))
-		tlb_batch_add(mm, vaddr, ptep, orig, fullmm);
+		tlb_batch_add(mm, vaddr, ptep, orig, fullmm, hugepage_shift);
 }
 
 #define __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR
@@ -906,7 +913,7 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 	pte_t orig = *ptep;
 
 	*ptep = pte;
-	maybe_tlb_batch_add(mm, addr, ptep, orig, fullmm);
+	maybe_tlb_batch_add(mm, addr, ptep, orig, fullmm, PAGE_SHIFT);
 }
 
 #define set_pte_at(mm,addr,ptep,pte)	\
diff --git a/arch/sparc/include/asm/tlbflush_64.h b/arch/sparc/include/asm/tlbflush_64.h
index a8e192e..54be88a 100644
--- a/arch/sparc/include/asm/tlbflush_64.h
+++ b/arch/sparc/include/asm/tlbflush_64.h
@@ -8,7 +8,7 @@
 #define TLB_BATCH_NR	192
 
 struct tlb_batch {
-	bool huge;
+	unsigned int hugepage_shift;
 	struct mm_struct *mm;
 	unsigned long tlb_nr;
 	unsigned long active;
@@ -17,7 +17,8 @@ struct tlb_batch {
 
 void flush_tsb_kernel_range(unsigned long start, unsigned long end);
 void flush_tsb_user(struct tlb_batch *tb);
-void flush_tsb_user_page(struct mm_struct *mm, unsigned long vaddr, bool huge);
+void flush_tsb_user_page(struct mm_struct *mm, unsigned long vaddr,
+			 unsigned int hugepage_shift);
 
 /* TLB flush operations. */
 
diff --git a/arch/sparc/kernel/tsb.S b/arch/sparc/kernel/tsb.S
index d568c82..10689cf 100644
--- a/arch/sparc/kernel/tsb.S
+++ b/arch/sparc/kernel/tsb.S
@@ -117,26 +117,11 @@ tsb_miss_page_table_walk_sun4v_fastpath:
 	/* Valid PTE is now in %g5.  */
 
 #if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
-661:	sethi		%uhi(_PAGE_SZALL_4U), %g7
+	sethi		%uhi(_PAGE_PMD_HUGE), %g7
 	sllx		%g7, 32, %g7
-	.section	.sun4v_2insn_patch, "ax"
-	.word		661b
-	mov		_PAGE_SZALL_4V, %g7
-	nop
-	.previous
-
-	and		%g5, %g7, %g2
-
-661:	sethi		%uhi(_PAGE_SZHUGE_4U), %g7
-	sllx		%g7, 32, %g7
-	.section	.sun4v_2insn_patch, "ax"
-	.word		661b
-	mov		_PAGE_SZHUGE_4V, %g7
-	nop
-	.previous
 
-	cmp		%g2, %g7
-	bne,pt		%xcc, 60f
+	andcc		%g5, %g7, %g0
+	be,pt		%xcc, 60f
 	 nop
 
 	/* It is a huge page, use huge page TSB entry address we
diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index 988acc8..e05b330 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -28,6 +28,7 @@ static unsigned long hugetlb_get_unmapped_area_bottomup(struct file *filp,
 							unsigned long pgoff,
 							unsigned long flags)
 {
+	struct hstate *h = hstate_file(filp);
 	unsigned long task_size = TASK_SIZE;
 	struct vm_unmapped_area_info info;
 
@@ -38,7 +39,7 @@ static unsigned long hugetlb_get_unmapped_area_bottomup(struct file *filp,
 	info.length = len;
 	info.low_limit = TASK_UNMAPPED_BASE;
 	info.high_limit = min(task_size, VA_EXCLUDE_START);
-	info.align_mask = PAGE_MASK & ~HPAGE_MASK;
+	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
 	info.align_offset = 0;
 	addr = vm_unmapped_area(&info);
 
@@ -58,6 +59,7 @@ hugetlb_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 				  const unsigned long pgoff,
 				  const unsigned long flags)
 {
+	struct hstate *h = hstate_file(filp);
 	struct mm_struct *mm = current->mm;
 	unsigned long addr = addr0;
 	struct vm_unmapped_area_info info;
@@ -69,7 +71,7 @@ hugetlb_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	info.length = len;
 	info.low_limit = PAGE_SIZE;
 	info.high_limit = mm->mmap_base;
-	info.align_mask = PAGE_MASK & ~HPAGE_MASK;
+	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
 	info.align_offset = 0;
 	addr = vm_unmapped_area(&info);
 
@@ -94,6 +96,7 @@ unsigned long
 hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags)
 {
+	struct hstate *h = hstate_file(file);
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	unsigned long task_size = TASK_SIZE;
@@ -101,7 +104,7 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 	if (test_thread_flag(TIF_32BIT))
 		task_size = STACK_TOP32;
 
-	if (len & ~HPAGE_MASK)
+	if (len & ~huge_page_mask(h))
 		return -EINVAL;
 	if (len > task_size)
 		return -ENOMEM;
@@ -113,7 +116,7 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 	}
 
 	if (addr) {
-		addr = ALIGN(addr, HPAGE_SIZE);
+		addr = ALIGN(addr, huge_page_size(h));
 		vma = find_vma(mm, addr);
 		if (task_size - len >= addr &&
 		    (!vma || addr + len <= vma->vm_start))
@@ -127,6 +130,112 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 				pgoff, flags);
 }
 
+static pte_t sun4u_hugepage_shift_to_tte(pte_t entry, unsigned int shift)
+{
+	return entry;
+}
+
+static pte_t sun4v_hugepage_shift_to_tte(pte_t entry, unsigned int shift)
+{
+	unsigned long hugepage_size = _PAGE_SZ4MB_4V;
+
+	pte_val(entry) = pte_val(entry) & ~_PAGE_SZALL_4V;
+
+	switch (shift) {
+	case HPAGE_256MB_SHIFT:
+		hugepage_size = _PAGE_SZ256MB_4V;
+		pte_val(entry) |= _PAGE_PMD_HUGE;
+		break;
+	case HPAGE_SHIFT:
+		pte_val(entry) |= _PAGE_PMD_HUGE;
+		break;
+	default:
+		WARN_ONCE(1, "unsupported hugepage shift=%u\n", shift);
+	}
+
+	pte_val(entry) = pte_val(entry) | hugepage_size;
+	return entry;
+}
+
+static pte_t hugepage_shift_to_tte(pte_t entry, unsigned int shift)
+{
+	if (tlb_type = hypervisor)
+		return sun4v_hugepage_shift_to_tte(entry, shift);
+	else
+		return sun4u_hugepage_shift_to_tte(entry, shift);
+}
+
+pte_t arch_make_huge_pte(pte_t entry, struct vm_area_struct *vma,
+			 struct page *page, int writeable)
+{
+	unsigned int shift = huge_page_shift(hstate_vma(vma));
+
+	return hugepage_shift_to_tte(entry, shift);
+}
+
+static unsigned int sun4v_huge_tte_to_shift(pte_t entry)
+{
+	unsigned long tte_szbits = pte_val(entry) & _PAGE_SZALL_4V;
+	unsigned int shift;
+
+	switch (tte_szbits) {
+	case _PAGE_SZ256MB_4V:
+		shift = HPAGE_256MB_SHIFT;
+		break;
+	case _PAGE_SZ4MB_4V:
+		shift = REAL_HPAGE_SHIFT;
+		break;
+	default:
+		shift = PAGE_SHIFT;
+		break;
+	}
+	return shift;
+}
+
+static unsigned int sun4u_huge_tte_to_shift(pte_t entry)
+{
+	unsigned long tte_szbits = pte_val(entry) & _PAGE_SZALL_4V;
+	unsigned int shift;
+
+	switch (tte_szbits) {
+	case _PAGE_SZ256MB_4U:
+		shift = HPAGE_256MB_SHIFT;
+		break;
+	case _PAGE_SZ4MB_4U:
+		shift = REAL_HPAGE_SHIFT;
+		break;
+	default:
+		shift = PAGE_SHIFT;
+		break;
+	}
+	return shift;
+}
+
+static unsigned int huge_tte_to_shift(pte_t entry)
+{
+	unsigned long shift;
+
+	if (tlb_type = hypervisor)
+		shift = sun4v_huge_tte_to_shift(entry);
+	else
+		shift = sun4u_huge_tte_to_shift(entry);
+
+	if (shift = PAGE_SHIFT)
+		WARN_ONCE(1, "tto_to_shift: invalid hugepage tte=0x%lx\n",
+			  pte_val(entry));
+
+	return shift;
+}
+
+static unsigned long huge_tte_to_size(pte_t pte)
+{
+	unsigned long size = 1UL << huge_tte_to_shift(pte);
+
+	if (size = REAL_HPAGE_SIZE)
+		size = HPAGE_SIZE;
+	return size;
+}
+
 pte_t *huge_pte_alloc(struct mm_struct *mm,
 			unsigned long addr, unsigned long sz)
 {
@@ -160,35 +269,54 @@ pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
 void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 		     pte_t *ptep, pte_t entry)
 {
+	unsigned int i, nptes, hugepage_shift;
+	unsigned long size;
 	pte_t orig;
 
+	size = huge_tte_to_size(entry);
+	nptes = size >> PMD_SHIFT;
+
 	if (!pte_present(*ptep) && pte_present(entry))
-		mm->context.hugetlb_pte_count++;
+		mm->context.hugetlb_pte_count += nptes;
 
-	addr &= HPAGE_MASK;
+	addr &= ~(size - 1);
 	orig = *ptep;
-	*ptep = entry;
+	hugepage_shift = pte_none(orig) ? PAGE_SIZE : huge_tte_to_shift(orig);
 
-	/* Issue TLB flush at REAL_HPAGE_SIZE boundaries */
-	maybe_tlb_batch_add(mm, addr, ptep, orig, 0);
-	maybe_tlb_batch_add(mm, addr + REAL_HPAGE_SIZE, ptep, orig, 0);
+	for (i = 0; i < nptes; i++)
+		ptep[i] = __pte(pte_val(entry) + (i << PMD_SHIFT));
+
+	maybe_tlb_batch_add(mm, addr, ptep, orig, 0, hugepage_shift);
+	/* An HPAGE_SIZE'ed page is composed of two REAL_HPAGE_SIZE'ed pages */
+	if (size = HPAGE_SIZE)
+		maybe_tlb_batch_add(mm, addr + REAL_HPAGE_SIZE, ptep, orig, 0,
+				    hugepage_shift);
 }
 
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep)
 {
+	unsigned int i, nptes, hugepage_shift;
+	unsigned long size;
 	pte_t entry;
 
 	entry = *ptep;
+	size = huge_tte_to_size(entry);
+	nptes = size >> PMD_SHIFT;
+	hugepage_shift = pte_none(entry) ? PAGE_SIZE : huge_tte_to_shift(entry);
+
 	if (pte_present(entry))
-		mm->context.hugetlb_pte_count--;
+		mm->context.hugetlb_pte_count -= nptes;
 
-	addr &= HPAGE_MASK;
-	*ptep = __pte(0UL);
+	addr &= ~(size - 1);
+	for (i = 0; i < nptes; i++)
+		ptep[i] = __pte(0UL);
 
-	/* Issue TLB flush at REAL_HPAGE_SIZE boundaries */
-	maybe_tlb_batch_add(mm, addr, ptep, entry, 0);
-	maybe_tlb_batch_add(mm, addr + REAL_HPAGE_SIZE, ptep, entry, 0);
+	maybe_tlb_batch_add(mm, addr, ptep, entry, 0, hugepage_shift);
+	/* An HPAGE_SIZE'ed page is composed of two REAL_HPAGE_SIZE'ed pages */
+	if (size = HPAGE_SIZE)
+		maybe_tlb_batch_add(mm, addr + REAL_HPAGE_SIZE, ptep, entry, 0,
+				    hugepage_shift);
 
 	return entry;
 }
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 37aa537..31e28dd 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -324,6 +324,49 @@ static void __update_mmu_tsb_insert(struct mm_struct *mm, unsigned long tsb_inde
 	tsb_insert(tsb, tag, tte);
 }
 
+#ifdef CONFIG_HUGETLB_PAGE
+static int __init setup_hugepagesz(char *string)
+{
+	unsigned long long hugepage_size;
+	unsigned int hugepage_shift;
+	unsigned short hv_pgsz_idx;
+	unsigned int hv_pgsz_mask;
+	int rc = 0;
+
+	if (tlb_type != hypervisor)
+		goto out;
+
+	hugepage_size = memparse(string, &string);
+	hugepage_shift = ilog2(hugepage_size);
+
+	switch (hugepage_shift) {
+	case HPAGE_256MB_SHIFT:
+		hv_pgsz_mask = HV_PGSZ_MASK_256MB;
+		hv_pgsz_idx = HV_PGSZ_IDX_256MB;
+		break;
+	case HPAGE_SHIFT:
+		hv_pgsz_mask = HV_PGSZ_MASK_4MB;
+		hv_pgsz_idx = HV_PGSZ_IDX_4MB;
+		break;
+	default:
+		hv_pgsz_mask = 0;
+	}
+
+	if ((hv_pgsz_mask & cpu_pgsz_mask) = 0U) {
+		pr_warn("hugepagesz=%llu not supported by MMU.\n",
+			hugepage_size);
+		goto out;
+	}
+
+	hugetlb_add_hstate(hugepage_shift - PAGE_SHIFT);
+	rc = 1;
+
+out:
+	return rc;
+}
+__setup("hugepagesz=", setup_hugepagesz);
+#endif	/* CONFIG_HUGETLB_PAGE */
+
 void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t *ptep)
 {
 	struct mm_struct *mm;
@@ -347,7 +390,7 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t *
 
 #if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
 	if ((mm->context.hugetlb_pte_count || mm->context.thp_pte_count) &&
-	    is_hugetlb_pte(pte)) {
+	    is_hugetlb_pmd(__pmd(pte_val(pte)))) {
 		/* We are fabricating 8MB pages using 4MB real hw pages.  */
 		pte_val(pte) |= (address & (1UL << REAL_HPAGE_SHIFT));
 		__update_mmu_tsb_insert(mm, MM_TSB_HUGE, REAL_HPAGE_SHIFT,
diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
index c56a195..afda3bb 100644
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -67,7 +67,7 @@ void arch_leave_lazy_mmu_mode(void)
 }
 
 static void tlb_batch_add_one(struct mm_struct *mm, unsigned long vaddr,
-			      bool exec, bool huge)
+			      bool exec, unsigned int hugepage_shift)
 {
 	struct tlb_batch *tb = &get_cpu_var(tlb_batch);
 	unsigned long nr;
@@ -84,19 +84,19 @@ static void tlb_batch_add_one(struct mm_struct *mm, unsigned long vaddr,
 	}
 
 	if (!tb->active) {
-		flush_tsb_user_page(mm, vaddr, huge);
+		flush_tsb_user_page(mm, vaddr, hugepage_shift);
 		global_flush_tlb_page(mm, vaddr);
 		goto out;
 	}
 
 	if (nr = 0) {
 		tb->mm = mm;
-		tb->huge = huge;
+		tb->hugepage_shift = hugepage_shift;
 	}
 
-	if (tb->huge != huge) {
+	if (tb->hugepage_shift != hugepage_shift) {
 		flush_tlb_pending();
-		tb->huge = huge;
+		tb->hugepage_shift = hugepage_shift;
 		nr = 0;
 	}
 
@@ -110,10 +110,9 @@ static void tlb_batch_add_one(struct mm_struct *mm, unsigned long vaddr,
 }
 
 void tlb_batch_add(struct mm_struct *mm, unsigned long vaddr,
-		   pte_t *ptep, pte_t orig, int fullmm)
+		   pte_t *ptep, pte_t orig, int fullmm,
+		   unsigned int hugepage_shift)
 {
-	bool huge = is_hugetlb_pte(orig);
-
 	if (tlb_type != hypervisor &&
 	    pte_dirty(orig)) {
 		unsigned long paddr, pfn = pte_pfn(orig);
@@ -139,7 +138,7 @@ void tlb_batch_add(struct mm_struct *mm, unsigned long vaddr,
 
 no_cache_flush:
 	if (!fullmm)
-		tlb_batch_add_one(mm, vaddr, pte_exec(orig), huge);
+		tlb_batch_add_one(mm, vaddr, pte_exec(orig), hugepage_shift);
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
diff --git a/arch/sparc/mm/tsb.c b/arch/sparc/mm/tsb.c
index e20fbba..22cb41f 100644
--- a/arch/sparc/mm/tsb.c
+++ b/arch/sparc/mm/tsb.c
@@ -86,6 +86,33 @@ static void __flush_tsb_one(struct tlb_batch *tb, unsigned long hash_shift,
 		__flush_tsb_one_entry(tsb, tb->vaddrs[i], hash_shift, nentries);
 }
 
+#if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
+static void __flush_huge_tsb_one_entry(unsigned long tsb, unsigned long v,
+				       unsigned long hash_shift,
+				       unsigned long nentries,
+				       unsigned int hugepage_shift)
+{
+	unsigned int hpage_entries;
+	unsigned int i;
+
+	hpage_entries = 1 << (hugepage_shift - REAL_HPAGE_SHIFT);
+	for (i = 0; i < hpage_entries; i++)
+		__flush_tsb_one_entry(tsb, v + i * REAL_HPAGE_SHIFT, hash_shift,
+				      nentries);
+}
+
+static void __flush_huge_tsb_one(struct tlb_batch *tb, unsigned long hash_shift,
+				 unsigned long tsb, unsigned long nentries,
+				 unsigned int hugepage_shift)
+{
+	unsigned long i;
+
+	for (i = 0; i < tb->tlb_nr; i++)
+		__flush_huge_tsb_one_entry(tsb, tb->vaddrs[i], hash_shift,
+					   nentries, hugepage_shift);
+}
+#endif
+
 void flush_tsb_user(struct tlb_batch *tb)
 {
 	struct mm_struct *mm = tb->mm;
@@ -93,7 +120,7 @@ void flush_tsb_user(struct tlb_batch *tb)
 
 	spin_lock_irqsave(&mm->context.lock, flags);
 
-	if (!tb->huge) {
+	if (tb->hugepage_shift = PAGE_SHIFT) {
 		base = (unsigned long) mm->context.tsb_block[MM_TSB_BASE].tsb;
 		nentries = mm->context.tsb_block[MM_TSB_BASE].tsb_nentries;
 		if (tlb_type = cheetah_plus || tlb_type = hypervisor)
@@ -101,24 +128,26 @@ void flush_tsb_user(struct tlb_batch *tb)
 		__flush_tsb_one(tb, PAGE_SHIFT, base, nentries);
 	}
 #if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
-	if (tb->huge && mm->context.tsb_block[MM_TSB_HUGE].tsb) {
+	else if (mm->context.tsb_block[MM_TSB_HUGE].tsb) {
 		base = (unsigned long) mm->context.tsb_block[MM_TSB_HUGE].tsb;
 		nentries = mm->context.tsb_block[MM_TSB_HUGE].tsb_nentries;
 		if (tlb_type = cheetah_plus || tlb_type = hypervisor)
 			base = __pa(base);
-		__flush_tsb_one(tb, REAL_HPAGE_SHIFT, base, nentries);
+		__flush_huge_tsb_one(tb, REAL_HPAGE_SHIFT, base, nentries,
+				     tb->hugepage_shift);
 	}
 #endif
 	spin_unlock_irqrestore(&mm->context.lock, flags);
 }
 
-void flush_tsb_user_page(struct mm_struct *mm, unsigned long vaddr, bool huge)
+void flush_tsb_user_page(struct mm_struct *mm, unsigned long vaddr,
+			 unsigned int hugepage_shift)
 {
 	unsigned long nentries, base, flags;
 
 	spin_lock_irqsave(&mm->context.lock, flags);
 
-	if (!huge) {
+	if (hugepage_shift = PAGE_SHIFT) {
 		base = (unsigned long) mm->context.tsb_block[MM_TSB_BASE].tsb;
 		nentries = mm->context.tsb_block[MM_TSB_BASE].tsb_nentries;
 		if (tlb_type = cheetah_plus || tlb_type = hypervisor)
@@ -126,12 +155,13 @@ void flush_tsb_user_page(struct mm_struct *mm, unsigned long vaddr, bool huge)
 		__flush_tsb_one_entry(base, vaddr, PAGE_SHIFT, nentries);
 	}
 #if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
-	if (huge && mm->context.tsb_block[MM_TSB_HUGE].tsb) {
+	else if (mm->context.tsb_block[MM_TSB_HUGE].tsb) {
 		base = (unsigned long) mm->context.tsb_block[MM_TSB_HUGE].tsb;
 		nentries = mm->context.tsb_block[MM_TSB_HUGE].tsb_nentries;
 		if (tlb_type = cheetah_plus || tlb_type = hypervisor)
 			base = __pa(base);
-		__flush_tsb_one_entry(base, vaddr, REAL_HPAGE_SHIFT, nentries);
+		__flush_huge_tsb_one_entry(base, vaddr, REAL_HPAGE_SHIFT,
+					   nentries, hugepage_shift);
 	}
 #endif
 	spin_unlock_irqrestore(&mm->context.lock, flags);
-- 
2.9.2

