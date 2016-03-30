From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Wed, 30 Mar 2016 18:17:13 +0000
Subject: [PATCH v4] sparc64: Reduce TLB flushes during hugepte changes
Message-Id: <1459362165-79634-1-git-send-email-nitin.m.gupta@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Nitin Gupta <nitin.m.gupta@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Khalid Aziz <khalid.aziz@oracle.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Adam Buchbinder <adam.buchbinder@gmail.com>, Minchan Kim <minchan@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Sudeep Holla <sudeep.holla@arm.com>, Ingo Molnar <mingo@kernel.org>, Chris Hyser <chris.hyser@oracle.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Toshi Kani <toshi.kani@hpe.com>, Tony Luck <tony.luck@intel.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

During hugepage map/unmap, TSB and TLB flushes are currently
issued at every PAGE_SIZE'd boundary which is unnecessary.
We now issue the flush at REAL_HPAGE_SIZE boundaries only.

Without this patch workloads which unmap a large hugepage
backed VMA region get CPU lockups due to excessive TLB
flush calls.

Orabug: 22365539, 22643230, 22995196

Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>

---
Changelog v4 vs v3:
 - Fix build error when CONFIG_HUGETLB_PAGE is not defined
 - Tested build with randconfig, allyesconfig, allnoconfig
Changelog v3 vs v2:
 - Changed patch title to reflect that both map/unmap cases
   are affected.
 - Don't do TLB flush if original PTE wasn't valid (DaveM)
 - Use tlb_batch_add() instead of directly calling TLB flush
   function. This routine also flushes dcache (needed by older
   sparcs) (DaveM)
Changelog v1 vs v2:
 - Access PTEs in order (David Miller)
 - Issue TLB and TSB flush after clearing PTEs (David Miller)
---
 arch/sparc/include/asm/pgtable_64.h  |   43 +++++++++++++++++++++++++--------
 arch/sparc/include/asm/tlbflush_64.h |    3 +-
 arch/sparc/mm/hugetlbpage.c          |   33 ++++++++++++++++++++++----
 arch/sparc/mm/init_64.c              |   12 ---------
 arch/sparc/mm/tlb.c                  |   25 ++++++++++++++-----
 arch/sparc/mm/tsb.c                  |   32 +++++++++++++------------
 6 files changed, 97 insertions(+), 51 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index f089cfa..5a189bf 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -375,7 +375,7 @@ static inline pgprot_t pgprot_noncached(pgprot_t prot)
 #define pgprot_noncached pgprot_noncached
 
 #if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
-static inline pte_t pte_mkhuge(pte_t pte)
+static inline unsigned long __pte_huge_mask(void)
 {
 	unsigned long mask;
 
@@ -390,8 +390,19 @@ static inline pte_t pte_mkhuge(pte_t pte)
 	: "=r" (mask)
 	: "i" (_PAGE_SZHUGE_4U), "i" (_PAGE_SZHUGE_4V));
 
-	return __pte(pte_val(pte) | mask);
+	return mask;
+}
+
+static inline pte_t pte_mkhuge(pte_t pte)
+{
+	return __pte(pte_val(pte) | __pte_huge_mask());
+}
+
+static inline bool is_hugetlb_pte(pte_t pte)
+{
+	return !!(pte_val(pte) & __pte_huge_mask());
 }
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static inline pmd_t pmd_mkhuge(pmd_t pmd)
 {
@@ -403,6 +414,11 @@ static inline pmd_t pmd_mkhuge(pmd_t pmd)
 	return __pmd(pte_val(pte));
 }
 #endif
+#else
+static inline bool is_hugetlb_pte(pte_t pte)
+{
+	return false;
+}
 #endif
 
 static inline pte_t pte_mkdirty(pte_t pte)
@@ -858,6 +874,19 @@ static inline unsigned long pud_pfn(pud_t pud)
 void tlb_batch_add(struct mm_struct *mm, unsigned long vaddr,
 		   pte_t *ptep, pte_t orig, int fullmm);
 
+static void maybe_tlb_batch_add(struct mm_struct *mm, unsigned long vaddr,
+				pte_t *ptep, pte_t orig, int fullmm)
+{
+	/* It is more efficient to let flush_tlb_kernel_range()
+	 * handle init_mm tlb flushes.
+	 *
+	 * SUN4V NOTE: _PAGE_VALID is the same value in both the SUN4U
+	 *             and SUN4V pte layout, so this inline test is fine.
+	 */
+	if (likely(mm != &init_mm) && pte_accessible(mm, orig))
+		tlb_batch_add(mm, vaddr, ptep, orig, fullmm);
+}
+
 #define __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR
 static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
 					    unsigned long addr,
@@ -874,15 +903,7 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 	pte_t orig = *ptep;
 
 	*ptep = pte;
-
-	/* It is more efficient to let flush_tlb_kernel_range()
-	 * handle init_mm tlb flushes.
-	 *
-	 * SUN4V NOTE: _PAGE_VALID is the same value in both the SUN4U
-	 *             and SUN4V pte layout, so this inline test is fine.
-	 */
-	if (likely(mm != &init_mm) && pte_accessible(mm, orig))
-		tlb_batch_add(mm, addr, ptep, orig, fullmm);
+	maybe_tlb_batch_add(mm, addr, ptep, orig, fullmm);
 }
 
 #define set_pte_at(mm,addr,ptep,pte)	\
diff --git a/arch/sparc/include/asm/tlbflush_64.h b/arch/sparc/include/asm/tlbflush_64.h
index dea1cfa..a8e192e 100644
--- a/arch/sparc/include/asm/tlbflush_64.h
+++ b/arch/sparc/include/asm/tlbflush_64.h
@@ -8,6 +8,7 @@
 #define TLB_BATCH_NR	192
 
 struct tlb_batch {
+	bool huge;
 	struct mm_struct *mm;
 	unsigned long tlb_nr;
 	unsigned long active;
@@ -16,7 +17,7 @@ struct tlb_batch {
 
 void flush_tsb_kernel_range(unsigned long start, unsigned long end);
 void flush_tsb_user(struct tlb_batch *tb);
-void flush_tsb_user_page(struct mm_struct *mm, unsigned long vaddr);
+void flush_tsb_user_page(struct mm_struct *mm, unsigned long vaddr, bool huge);
 
 /* TLB flush operations. */
 
diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index 4977800..ba52e64 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -176,17 +176,31 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 		     pte_t *ptep, pte_t entry)
 {
 	int i;
+	pte_t orig[2];
+	unsigned long nptes;
 
 	if (!pte_present(*ptep) && pte_present(entry))
 		mm->context.huge_pte_count++;
 
 	addr &= HPAGE_MASK;
-	for (i = 0; i < (1 << HUGETLB_PAGE_ORDER); i++) {
-		set_pte_at(mm, addr, ptep, entry);
+
+	nptes = 1 << HUGETLB_PAGE_ORDER;
+	orig[0] = *ptep;
+	orig[1] = *(ptep + nptes / 2);
+	for (i = 0; i < nptes; i++) {
+		*ptep = entry;
 		ptep++;
 		addr += PAGE_SIZE;
 		pte_val(entry) += PAGE_SIZE;
 	}
+
+	/* Issue TLB flush at REAL_HPAGE_SIZE boundaries */
+	addr -= REAL_HPAGE_SIZE;
+	ptep -= nptes / 2;
+	maybe_tlb_batch_add(mm, addr, ptep, orig[1], 0);
+	addr -= REAL_HPAGE_SIZE;
+	ptep -= nptes / 2;
+	maybe_tlb_batch_add(mm, addr, ptep, orig[0], 0);
 }
 
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
@@ -194,19 +208,28 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
 {
 	pte_t entry;
 	int i;
+	unsigned long nptes;
 
 	entry = *ptep;
 	if (pte_present(entry))
 		mm->context.huge_pte_count--;
 
 	addr &= HPAGE_MASK;
-
-	for (i = 0; i < (1 << HUGETLB_PAGE_ORDER); i++) {
-		pte_clear(mm, addr, ptep);
+	nptes = 1 << HUGETLB_PAGE_ORDER;
+	for (i = 0; i < nptes; i++) {
+		*ptep = __pte(0UL);
 		addr += PAGE_SIZE;
 		ptep++;
 	}
 
+	/* Issue TLB flush at REAL_HPAGE_SIZE boundaries */
+	addr -= REAL_HPAGE_SIZE;
+	ptep -= nptes / 2;
+	maybe_tlb_batch_add(mm, addr, ptep, entry, 0);
+	addr -= REAL_HPAGE_SIZE;
+	ptep -= nptes / 2;
+	maybe_tlb_batch_add(mm, addr, ptep, entry, 0);
+
 	return entry;
 }
 
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 1cfe6aa..bf181a9 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -324,18 +324,6 @@ static void __update_mmu_tsb_insert(struct mm_struct *mm, unsigned long tsb_inde
 	tsb_insert(tsb, tag, tte);
 }
 
-#if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
-static inline bool is_hugetlb_pte(pte_t pte)
-{
-	if ((tlb_type = hypervisor &&
-	     (pte_val(pte) & _PAGE_SZALL_4V) = _PAGE_SZHUGE_4V) ||
-	    (tlb_type != hypervisor &&
-	     (pte_val(pte) & _PAGE_SZALL_4U) = _PAGE_SZHUGE_4U))
-		return true;
-	return false;
-}
-#endif
-
 void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t *ptep)
 {
 	struct mm_struct *mm;
diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
index 9df2190..f81cd97 100644
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -67,7 +67,7 @@ void arch_leave_lazy_mmu_mode(void)
 }
 
 static void tlb_batch_add_one(struct mm_struct *mm, unsigned long vaddr,
-			      bool exec)
+			      bool exec, bool huge)
 {
 	struct tlb_batch *tb = &get_cpu_var(tlb_batch);
 	unsigned long nr;
@@ -84,13 +84,21 @@ static void tlb_batch_add_one(struct mm_struct *mm, unsigned long vaddr,
 	}
 
 	if (!tb->active) {
-		flush_tsb_user_page(mm, vaddr);
+		flush_tsb_user_page(mm, vaddr, huge);
 		global_flush_tlb_page(mm, vaddr);
 		goto out;
 	}
 
-	if (nr = 0)
+	if (nr = 0) {
 		tb->mm = mm;
+		tb->huge = huge;
+	}
+
+	if (tb->huge != huge) {
+		flush_tlb_pending();
+		tb->huge = huge;
+		nr = 0;
+	}
 
 	tb->vaddrs[nr] = vaddr;
 	tb->tlb_nr = ++nr;
@@ -104,6 +112,8 @@ out:
 void tlb_batch_add(struct mm_struct *mm, unsigned long vaddr,
 		   pte_t *ptep, pte_t orig, int fullmm)
 {
+	bool huge = is_hugetlb_pte(orig);
+
 	if (tlb_type != hypervisor &&
 	    pte_dirty(orig)) {
 		unsigned long paddr, pfn = pte_pfn(orig);
@@ -129,7 +139,7 @@ void tlb_batch_add(struct mm_struct *mm, unsigned long vaddr,
 
 no_cache_flush:
 	if (!fullmm)
-		tlb_batch_add_one(mm, vaddr, pte_exec(orig));
+		tlb_batch_add_one(mm, vaddr, pte_exec(orig), huge);
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -145,7 +155,7 @@ static void tlb_batch_pmd_scan(struct mm_struct *mm, unsigned long vaddr,
 		if (pte_val(*pte) & _PAGE_VALID) {
 			bool exec = pte_exec(*pte);
 
-			tlb_batch_add_one(mm, vaddr, exec);
+			tlb_batch_add_one(mm, vaddr, exec, false);
 		}
 		pte++;
 		vaddr += PAGE_SIZE;
@@ -185,8 +195,9 @@ void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 			pte_t orig_pte = __pte(pmd_val(orig));
 			bool exec = pte_exec(orig_pte);
 
-			tlb_batch_add_one(mm, addr, exec);
-			tlb_batch_add_one(mm, addr + REAL_HPAGE_SIZE, exec);
+			tlb_batch_add_one(mm, addr, exec, true);
+			tlb_batch_add_one(mm, addr + REAL_HPAGE_SIZE, exec,
+					true);
 		} else {
 			tlb_batch_pmd_scan(mm, addr, orig);
 		}
diff --git a/arch/sparc/mm/tsb.c b/arch/sparc/mm/tsb.c
index a065766..a0604a4 100644
--- a/arch/sparc/mm/tsb.c
+++ b/arch/sparc/mm/tsb.c
@@ -76,14 +76,15 @@ void flush_tsb_user(struct tlb_batch *tb)
 
 	spin_lock_irqsave(&mm->context.lock, flags);
 
-	base = (unsigned long) mm->context.tsb_block[MM_TSB_BASE].tsb;
-	nentries = mm->context.tsb_block[MM_TSB_BASE].tsb_nentries;
-	if (tlb_type = cheetah_plus || tlb_type = hypervisor)
-		base = __pa(base);
-	__flush_tsb_one(tb, PAGE_SHIFT, base, nentries);
-
+	if (!tb->huge) {
+		base = (unsigned long) mm->context.tsb_block[MM_TSB_BASE].tsb;
+		nentries = mm->context.tsb_block[MM_TSB_BASE].tsb_nentries;
+		if (tlb_type = cheetah_plus || tlb_type = hypervisor)
+			base = __pa(base);
+		__flush_tsb_one(tb, PAGE_SHIFT, base, nentries);
+	}
 #if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
-	if (mm->context.tsb_block[MM_TSB_HUGE].tsb) {
+	if (tb->huge && mm->context.tsb_block[MM_TSB_HUGE].tsb) {
 		base = (unsigned long) mm->context.tsb_block[MM_TSB_HUGE].tsb;
 		nentries = mm->context.tsb_block[MM_TSB_HUGE].tsb_nentries;
 		if (tlb_type = cheetah_plus || tlb_type = hypervisor)
@@ -94,20 +95,21 @@ void flush_tsb_user(struct tlb_batch *tb)
 	spin_unlock_irqrestore(&mm->context.lock, flags);
 }
 
-void flush_tsb_user_page(struct mm_struct *mm, unsigned long vaddr)
+void flush_tsb_user_page(struct mm_struct *mm, unsigned long vaddr, bool huge)
 {
 	unsigned long nentries, base, flags;
 
 	spin_lock_irqsave(&mm->context.lock, flags);
 
-	base = (unsigned long) mm->context.tsb_block[MM_TSB_BASE].tsb;
-	nentries = mm->context.tsb_block[MM_TSB_BASE].tsb_nentries;
-	if (tlb_type = cheetah_plus || tlb_type = hypervisor)
-		base = __pa(base);
-	__flush_tsb_one_entry(base, vaddr, PAGE_SHIFT, nentries);
-
+	if (!huge) {
+		base = (unsigned long) mm->context.tsb_block[MM_TSB_BASE].tsb;
+		nentries = mm->context.tsb_block[MM_TSB_BASE].tsb_nentries;
+		if (tlb_type = cheetah_plus || tlb_type = hypervisor)
+			base = __pa(base);
+		__flush_tsb_one_entry(base, vaddr, PAGE_SHIFT, nentries);
+	}
 #if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
-	if (mm->context.tsb_block[MM_TSB_HUGE].tsb) {
+	if (huge && mm->context.tsb_block[MM_TSB_HUGE].tsb) {
 		base = (unsigned long) mm->context.tsb_block[MM_TSB_HUGE].tsb;
 		nentries = mm->context.tsb_block[MM_TSB_HUGE].tsb_nentries;
 		if (tlb_type = cheetah_plus || tlb_type = hypervisor)
-- 
1.7.1

