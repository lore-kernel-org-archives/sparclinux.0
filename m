From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Wed, 03 Feb 2016 23:00:23 +0000
Subject: [PATCH v2] sparc64: Reduce TLB flushes during hugepage unmap
Message-Id: <1454540423-67071-1-git-send-email-nitin.m.gupta@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

During hugepage unmap, TSB and TLB flushes are currently
issued at every PAGE_SIZE'd boundary which is unnecessary.
We now issue the flush at REAL_HPAGE_SIZE boundaries only.

Without this patch workloads which unmap a large hugepage
backed VMA region get CPU lockups due to excessive TLB
flush calls.

Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>
---
 arch/sparc/include/asm/tlbflush_64.h |  3 ++-
 arch/sparc/mm/hugetlbpage.c          |  7 ++++++-
 arch/sparc/mm/tlb.c                  |  2 +-
 arch/sparc/mm/tsb.c                  | 21 ++++++++++++++-------
 4 files changed, 23 insertions(+), 10 deletions(-)

Changelog v1 vs v2:
 - Access PTEs in order (David Miller)
 - Issue TLB and TSB flush after clearing PTEs (David Miller)
 
diff --git a/arch/sparc/include/asm/tlbflush_64.h b/arch/sparc/include/asm/tlbflush_64.h
index dea1cfa..5c28f78 100644
--- a/arch/sparc/include/asm/tlbflush_64.h
+++ b/arch/sparc/include/asm/tlbflush_64.h
@@ -16,7 +16,8 @@ struct tlb_batch {
 
 void flush_tsb_kernel_range(unsigned long start, unsigned long end);
 void flush_tsb_user(struct tlb_batch *tb);
-void flush_tsb_user_page(struct mm_struct *mm, unsigned long vaddr);
+void flush_tsb_user_page(struct mm_struct *mm, unsigned long vaddr,
+			 bool is_huge);
 
 /* TLB flush operations. */
 
diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index 131eaf4..d8f625c 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -202,10 +202,15 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
 	addr &= HPAGE_MASK;
 
 	for (i = 0; i < (1 << HUGETLB_PAGE_ORDER); i++) {
-		pte_clear(mm, addr, ptep);
+		*ptep = __pte(0UL);
 		addr += PAGE_SIZE;
 		ptep++;
 	}
+	/* Issue TSB and TLB flush at REAL_HPAGE_SIZE boundaries */
+	flush_tsb_user_page(mm, addr, true);
+	flush_tsb_user_page(mm, addr + REAL_HPAGE_SIZE, true);
+	global_flush_tlb_page(mm, addr);
+	global_flush_tlb_page(mm, addr + REAL_HPAGE_SIZE);
 
 	return entry;
 }
diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
index 9df2190..1a5de57 100644
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -84,7 +84,7 @@ static void tlb_batch_add_one(struct mm_struct *mm, unsigned long vaddr,
 	}
 
 	if (!tb->active) {
-		flush_tsb_user_page(mm, vaddr);
+		flush_tsb_user_page(mm, vaddr, false);
 		global_flush_tlb_page(mm, vaddr);
 		goto out;
 	}
diff --git a/arch/sparc/mm/tsb.c b/arch/sparc/mm/tsb.c
index a065766..3af2848 100644
--- a/arch/sparc/mm/tsb.c
+++ b/arch/sparc/mm/tsb.c
@@ -94,18 +94,25 @@ void flush_tsb_user(struct tlb_batch *tb)
 	spin_unlock_irqrestore(&mm->context.lock, flags);
 }
 
-void flush_tsb_user_page(struct mm_struct *mm, unsigned long vaddr)
+/*
+ * @is_huge is true if the page containing @vaddr is guaranteed to
+ * be a huge page. If false, then TSBs for both, base and huge page
+ * size are flushed.
+ */
+void flush_tsb_user_page(struct mm_struct *mm, unsigned long vaddr,
+			 bool is_huge)
 {
 	unsigned long nentries, base, flags;
 
 	spin_lock_irqsave(&mm->context.lock, flags);
 
-	base = (unsigned long) mm->context.tsb_block[MM_TSB_BASE].tsb;
-	nentries = mm->context.tsb_block[MM_TSB_BASE].tsb_nentries;
-	if (tlb_type = cheetah_plus || tlb_type = hypervisor)
-		base = __pa(base);
-	__flush_tsb_one_entry(base, vaddr, PAGE_SHIFT, nentries);
-
+	if (!is_huge) {
+		base = (unsigned long) mm->context.tsb_block[MM_TSB_BASE].tsb;
+		nentries = mm->context.tsb_block[MM_TSB_BASE].tsb_nentries;
+		if (tlb_type = cheetah_plus || tlb_type = hypervisor)
+			base = __pa(base);
+		__flush_tsb_one_entry(base, vaddr, PAGE_SHIFT, nentries);
+	}
 #if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
 	if (mm->context.tsb_block[MM_TSB_HUGE].tsb) {
 		base = (unsigned long) mm->context.tsb_block[MM_TSB_HUGE].tsb;
-- 
2.6.4

