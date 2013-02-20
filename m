From: David Miller <davem@davemloft.net>
Date: Wed, 20 Feb 2013 06:42:02 +0000
Subject: [PATCH 2/3] sparc64: Handle hugepage TSB being NULL.
Message-Id: <20130220.014202.587957824962927888.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mroos@ut.ee
Cc: linux-mm@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, rientjes@google.com, hannes@cmpxchg.org


Accomodate the possibility that the TSB might be NULL at
the point that update_mmu_cache() is invoked.  This is
necessary because we will sometimes need to defer the TSB
allocation to the first fault that happens in the 'mm'.

Seperate out the hugepage PTE test into a seperate function
so that the logic is clearer.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/mm/init_64.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index c3b7242..0d0bc39 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -314,16 +314,31 @@ static void __update_mmu_tsb_insert(struct mm_struct *mm, unsigned long tsb_inde
 	struct tsb *tsb = mm->context.tsb_block[tsb_index].tsb;
 	unsigned long tag;
 
+	if (unlikely(!tsb))
+		return;
+
 	tsb += ((address >> tsb_hash_shift) &
 		(mm->context.tsb_block[tsb_index].tsb_nentries - 1UL));
 	tag = (address >> 22UL);
 	tsb_insert(tsb, tag, tte);
 }
 
+#if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
+static inline bool is_hugetlb_pte(pte_t pte)
+{
+	if ((tlb_type = hypervisor &&
+	     (pte_val(pte) & _PAGE_SZALL_4V) = _PAGE_SZHUGE_4V) ||
+	    (tlb_type != hypervisor &&
+	     (pte_val(pte) & _PAGE_SZALL_4U) = _PAGE_SZHUGE_4U))
+		return true;
+	return false;
+}
+#endif
+
 void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t *ptep)
 {
-	unsigned long tsb_index, tsb_hash_shift, flags;
 	struct mm_struct *mm;
+	unsigned long flags;
 	pte_t pte = *ptep;
 
 	if (tlb_type != hypervisor) {
@@ -335,25 +350,16 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t *
 
 	mm = vma->vm_mm;
 
-	tsb_index = MM_TSB_BASE;
-	tsb_hash_shift = PAGE_SHIFT;
-
 	spin_lock_irqsave(&mm->context.lock, flags);
 
 #if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
-	if (mm->context.tsb_block[MM_TSB_HUGE].tsb != NULL) {
-		if ((tlb_type = hypervisor &&
-		     (pte_val(pte) & _PAGE_SZALL_4V) = _PAGE_SZHUGE_4V) ||
-		    (tlb_type != hypervisor &&
-		     (pte_val(pte) & _PAGE_SZALL_4U) = _PAGE_SZHUGE_4U)) {
-			tsb_index = MM_TSB_HUGE;
-			tsb_hash_shift = HPAGE_SHIFT;
-		}
-	}
+	if (mm->context.huge_pte_count && is_hugetlb_pte(pte))
+		__update_mmu_tsb_insert(mm, MM_TSB_HUGE, HPAGE_SHIFT,
+					address, pte_val(pte));
+	else
 #endif
-
-	__update_mmu_tsb_insert(mm, tsb_index, tsb_hash_shift,
-				address, pte_val(pte));
+		__update_mmu_tsb_insert(mm, MM_TSB_BASE, PAGE_SHIFT,
+					address, pte_val(pte));
 
 	spin_unlock_irqrestore(&mm->context.lock, flags);
 }
-- 
1.8.1.2

