From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Fri, 15 Jul 2016 20:08:42 +0000
Subject: [PATCH] sparc64 mm: Fix base TSB sizing when hugetlb pages are used
Message-Id: <1468613322-8491-1-git-send-email-mike.kravetz@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Nitin Gupta <nitin.m.gupta@oracle.com>, Mike Kravetz <mike.kravetz@oracle.com>

do_sparc64_fault() calculates both the base and huge page RSS sizes and
uses this information in calls to tsb_grow().  The calculation for base
page TSB size is not correct if the task uses hugetlb pages.  hugetlb
pages are not accounted for in RSS, therefore the call to get_mm_rss(mm)
does not include hugetlb pages.  However, the number of pages based on
huge_pte_count (which does include hugetlb pages) is subtracted from
this value.  This will result in an artificially small and often negative
RSS calculation.  The base TSB size is then often set to max_tsb_size
as the passed RSS is unsigned, so a negative value looks really big.

THP pages are also accounted for in huge_pte_count, and THP pages are
accounted for in RSS so the calculation in do_sparc64_fault() is correct
if a task only uses THP pages.

A single huge_pte_count is not sufficient for TSB sizing if both hugetlb
and THP pages can be used.  Instead of a single counter, use two:  one
for hugetlb and one for THP.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 arch/sparc/include/asm/mmu_64.h |    3 ++-
 arch/sparc/mm/fault_64.c        |    6 +++---
 arch/sparc/mm/hugetlbpage.c     |    4 ++--
 arch/sparc/mm/init_64.c         |    3 ++-
 arch/sparc/mm/tlb.c             |    4 ++--
 arch/sparc/mm/tsb.c             |   14 ++++++++------
 6 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/arch/sparc/include/asm/mmu_64.h b/arch/sparc/include/asm/mmu_64.h
index 70067ce..f7de0db 100644
--- a/arch/sparc/include/asm/mmu_64.h
+++ b/arch/sparc/include/asm/mmu_64.h
@@ -92,7 +92,8 @@ struct tsb_config {
 typedef struct {
 	spinlock_t		lock;
 	unsigned long		sparc64_ctx_val;
-	unsigned long		huge_pte_count;
+	unsigned long		hugetlb_pte_count;
+	unsigned long		thp_pte_count;
 	struct tsb_config	tsb_block[MM_NUM_TSBS];
 	struct hv_tsb_descr	tsb_descr[MM_NUM_TSBS];
 } mm_context_t;
diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
index cb841a3..877656d 100644
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -476,14 +476,14 @@ good_area:
 	up_read(&mm->mmap_sem);
 
 	mm_rss = get_mm_rss(mm);
-#if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
-	mm_rss -= (mm->context.huge_pte_count * (HPAGE_SIZE / PAGE_SIZE));
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE)
+	mm_rss -= (mm->context.thp_pte_count * (HPAGE_SIZE / PAGE_SIZE));
 #endif
 	if (unlikely(mm_rss >
 		     mm->context.tsb_block[MM_TSB_BASE].tsb_rss_limit))
 		tsb_grow(mm, MM_TSB_BASE, mm_rss);
 #if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
-	mm_rss = mm->context.huge_pte_count;
+	mm_rss = mm->context.hugetlb_pte_count + mm->context.thp_pte_count;
 	if (unlikely(mm_rss >
 		     mm->context.tsb_block[MM_TSB_HUGE].tsb_rss_limit)) {
 		if (mm->context.tsb_block[MM_TSB_HUGE].tsb)
diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index 4977800..080fa43 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -178,7 +178,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 	int i;
 
 	if (!pte_present(*ptep) && pte_present(entry))
-		mm->context.huge_pte_count++;
+		mm->context.hugetlb_pte_count++;
 
 	addr &= HPAGE_MASK;
 	for (i = 0; i < (1 << HUGETLB_PAGE_ORDER); i++) {
@@ -197,7 +197,7 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
 
 	entry = *ptep;
 	if (pte_present(entry))
-		mm->context.huge_pte_count--;
+		mm->context.hugetlb_pte_count--;
 
 	addr &= HPAGE_MASK;
 
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 09e8388..fbeeb44 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -358,7 +358,8 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t *
 	spin_lock_irqsave(&mm->context.lock, flags);
 
 #if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
-	if (mm->context.huge_pte_count && is_hugetlb_pte(pte))
+	if ((mm->context.hugetlb_pte_count || mm->context.thp_pte_count) &&
+	    is_hugetlb_pte(pte))
 		__update_mmu_tsb_insert(mm, MM_TSB_HUGE, REAL_HPAGE_SHIFT,
 					address, pte_val(pte));
 	else
diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
index 9df2190..d5a3989 100644
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -165,9 +165,9 @@ void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 
 	if ((pmd_val(pmd) ^ pmd_val(orig)) & _PAGE_PMD_HUGE) {
 		if (pmd_val(pmd) & _PAGE_PMD_HUGE)
-			mm->context.huge_pte_count++;
+			mm->context.thp_pte_count++;
 		else
-			mm->context.huge_pte_count--;
+			mm->context.thp_pte_count--;
 
 		/* Do not try to allocate the TSB hash table if we
 		 * don't have one already.  We have various locks held
diff --git a/arch/sparc/mm/tsb.c b/arch/sparc/mm/tsb.c
index a065766..4882248 100644
--- a/arch/sparc/mm/tsb.c
+++ b/arch/sparc/mm/tsb.c
@@ -468,7 +468,7 @@ retry_tsb_alloc:
 int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
 #if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
-	unsigned long huge_pte_count;
+	unsigned long total_huge_pte_count;
 #endif
 	unsigned int i;
 
@@ -477,12 +477,14 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 	mm->context.sparc64_ctx_val = 0UL;
 
 #if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
-	/* We reset it to zero because the fork() page copying
+	/* We reset them to zero because the fork() page copying
 	 * will re-increment the counters as the parent PTEs are
 	 * copied into the child address space.
 	 */
-	huge_pte_count = mm->context.huge_pte_count;
-	mm->context.huge_pte_count = 0;
+	total_huge_pte_count = mm->context.hugetlb_pte_count +
+			 mm->context.thp_pte_count;
+	mm->context.hugetlb_pte_count = 0;
+	mm->context.thp_pte_count = 0;
 #endif
 
 	/* copy_mm() copies over the parent's mm_struct before calling
@@ -498,8 +500,8 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 	tsb_grow(mm, MM_TSB_BASE, get_mm_rss(mm));
 
 #if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
-	if (unlikely(huge_pte_count))
-		tsb_grow(mm, MM_TSB_HUGE, huge_pte_count);
+	if (unlikely(total_huge_pte_count))
+		tsb_grow(mm, MM_TSB_HUGE, total_huge_pte_count);
 #endif
 
 	if (unlikely(!mm->context.tsb_block[MM_TSB_BASE].tsb))
-- 
1.7.1

