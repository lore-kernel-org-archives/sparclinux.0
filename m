From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Fri, 24 Feb 2017 11:03:16 +0000
Subject: [PATCH] sparc64: Fix build error in flush_tsb_user_page
Message-Id: <1487934216-33897-1-git-send-email-nitin.m.gupta@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Nitin Gupta <nitin.m.gupta@oracle.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Mike Kravetz <mike.kravetz@oracle.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Patch "sparc64: Add 64K page size support"
unconditionally used __flush_huge_tsb_one_entry()
which is available only when hugetlb support is
enabled.

Another issue was incorrect TSB flushing for 64K
pages in flush_tsb_user().

Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>
---
 arch/sparc/mm/hugetlbpage.c |  5 +++--
 arch/sparc/mm/tsb.c         | 20 ++++++++++++++++----
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index 605bfce..e98a3f2 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -309,7 +309,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 
 	addr &= ~(size - 1);
 	orig = *ptep;
-	orig_shift = pte_none(orig) ? PAGE_SIZE : huge_tte_to_shift(orig);
+	orig_shift = pte_none(orig) ? PAGE_SHIFT : huge_tte_to_shift(orig);
 
 	for (i = 0; i < nptes; i++)
 		ptep[i] = __pte(pte_val(entry) + (i << shift));
@@ -335,7 +335,8 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
 	else
 		nptes = size >> PAGE_SHIFT;
 
-	hugepage_shift = pte_none(entry) ? PAGE_SIZE : huge_tte_to_shift(entry);
+	hugepage_shift = pte_none(entry) ? PAGE_SHIFT :
+		huge_tte_to_shift(entry);
 
 	if (pte_present(entry))
 		mm->context.hugetlb_pte_count -= nptes;
diff --git a/arch/sparc/mm/tsb.c b/arch/sparc/mm/tsb.c
index e39fc57..23479c3 100644
--- a/arch/sparc/mm/tsb.c
+++ b/arch/sparc/mm/tsb.c
@@ -120,12 +120,18 @@ void flush_tsb_user(struct tlb_batch *tb)
 
 	spin_lock_irqsave(&mm->context.lock, flags);
 
-	if (tb->hugepage_shift = PAGE_SHIFT) {
+	if (tb->hugepage_shift < HPAGE_SHIFT) {
 		base = (unsigned long) mm->context.tsb_block[MM_TSB_BASE].tsb;
 		nentries = mm->context.tsb_block[MM_TSB_BASE].tsb_nentries;
 		if (tlb_type = cheetah_plus || tlb_type = hypervisor)
 			base = __pa(base);
-		__flush_tsb_one(tb, PAGE_SHIFT, base, nentries);
+		if (tb->hugepage_shift = PAGE_SHIFT)
+			__flush_tsb_one(tb, PAGE_SHIFT, base, nentries);
+#if defined(CONFIG_HUGETLB_PAGE)
+		else
+			__flush_huge_tsb_one(tb, PAGE_SHIFT, base, nentries,
+					     tb->hugepage_shift);
+#endif
 	}
 #if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
 	else if (mm->context.tsb_block[MM_TSB_HUGE].tsb) {
@@ -152,8 +158,14 @@ void flush_tsb_user_page(struct mm_struct *mm, unsigned long vaddr,
 		nentries = mm->context.tsb_block[MM_TSB_BASE].tsb_nentries;
 		if (tlb_type = cheetah_plus || tlb_type = hypervisor)
 			base = __pa(base);
-		__flush_huge_tsb_one_entry(base, vaddr, PAGE_SHIFT, nentries,
-					   hugepage_shift);
+		if (hugepage_shift = PAGE_SHIFT)
+			__flush_tsb_one_entry(base, vaddr, PAGE_SHIFT,
+					      nentries);
+#if defined(CONFIG_HUGETLB_PAGE)
+		else
+			__flush_huge_tsb_one_entry(base, vaddr, PAGE_SHIFT,
+						   nentries, hugepage_shift);
+#endif
 	}
 #if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
 	else if (mm->context.tsb_block[MM_TSB_HUGE].tsb) {
-- 
2.9.2

