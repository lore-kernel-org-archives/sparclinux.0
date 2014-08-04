From: David Miller <davem@davemloft.net>
Date: Mon, 04 Aug 2014 23:35:11 +0000
Subject: [PATCH] sparc64: Do not insert non-valid PTEs into the TSB hash table.
Message-Id: <20140804.163511.1994683572417020890.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


The assumption was that update_mmu_cache() (and the equivalent for PMDs) would
only be called when the PTE being installed will be accessible by the user.

This is not true for code paths originating from remove_migration_pte().

There are dire consequences for placing a non-valid PTE into the TSB.  The TLB
miss frramework assumes thatwhen a TSB entry matches we can just load it into
the TLB and return from the TLB miss trap.

So if a non-valid PTE is in there, we will deadlock taking the TLB miss over
and over, never satisfying the miss.

Just exit early from update_mmu_cache() and friends in this situation.

Based upon a report and patch from Christopher Alexander Tobias Schulze.

Signed-off-by: David S. Miller <davem@davemloft.net>
---

I committed this to the sparc GIT tree and will queue this up for -stable.

 arch/sparc/mm/init_64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 16b58ff..db5ddde 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -351,6 +351,10 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t *
 
 	mm = vma->vm_mm;
 
+	/* Don't insert a non-valid PTE into the TSB, we'll deadlock.  */
+	if (!pte_accessible(mm, pte))
+		return;
+
 	spin_lock_irqsave(&mm->context.lock, flags);
 
 #if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
@@ -2619,6 +2623,10 @@ void update_mmu_cache_pmd(struct vm_area_struct *vma, unsigned long addr,
 
 	pte = pmd_val(entry);
 
+	/* Don't insert a non-valid PMD into the TSB, we'll deadlock.  */
+	if (!(pte & _PAGE_VALID))
+		return;
+
 	/* We are fabricating 8MB pages using 4MB real hw pages.  */
 	pte |= (addr & (1UL << REAL_HPAGE_SHIFT));
 
-- 
1.8.1.2

