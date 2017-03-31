From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Fri, 31 Mar 2017 22:48:53 +0000
Subject: [PATCH] sparc64: Fix memory corruption when THP is enabled
Message-Id: <1491000547-243467-1-git-send-email-nitin.m.gupta@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Nitin Gupta <nitin.m.gupta@oracle.com>, Mike Kravetz <mike.kravetz@oracle.com>, Ingo Molnar <mingo@kernel.org>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

The memory corruption was happening due to incorrect
TLB/TSB flushing of hugepages.

Reported-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>
---
 arch/sparc/mm/tlb.c | 6 +++---
 arch/sparc/mm/tsb.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
index afda3bb..ee8066c 100644
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -154,7 +154,7 @@ static void tlb_batch_pmd_scan(struct mm_struct *mm, unsigned long vaddr,
 		if (pte_val(*pte) & _PAGE_VALID) {
 			bool exec = pte_exec(*pte);
 
-			tlb_batch_add_one(mm, vaddr, exec, false);
+			tlb_batch_add_one(mm, vaddr, exec, PAGE_SHIFT);
 		}
 		pte++;
 		vaddr += PAGE_SIZE;
@@ -209,9 +209,9 @@ void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 			pte_t orig_pte = __pte(pmd_val(orig));
 			bool exec = pte_exec(orig_pte);
 
-			tlb_batch_add_one(mm, addr, exec, true);
+			tlb_batch_add_one(mm, addr, exec, REAL_HPAGE_SHIFT);
 			tlb_batch_add_one(mm, addr + REAL_HPAGE_SIZE, exec,
-					true);
+					  REAL_HPAGE_SHIFT);
 		} else {
 			tlb_batch_pmd_scan(mm, addr, orig);
 		}
diff --git a/arch/sparc/mm/tsb.c b/arch/sparc/mm/tsb.c
index 0a04811..bedf08b 100644
--- a/arch/sparc/mm/tsb.c
+++ b/arch/sparc/mm/tsb.c
@@ -122,7 +122,7 @@ void flush_tsb_user(struct tlb_batch *tb)
 
 	spin_lock_irqsave(&mm->context.lock, flags);
 
-	if (tb->hugepage_shift < HPAGE_SHIFT) {
+	if (tb->hugepage_shift < REAL_HPAGE_SHIFT) {
 		base = (unsigned long) mm->context.tsb_block[MM_TSB_BASE].tsb;
 		nentries = mm->context.tsb_block[MM_TSB_BASE].tsb_nentries;
 		if (tlb_type = cheetah_plus || tlb_type = hypervisor)
@@ -155,7 +155,7 @@ void flush_tsb_user_page(struct mm_struct *mm, unsigned long vaddr,
 
 	spin_lock_irqsave(&mm->context.lock, flags);
 
-	if (hugepage_shift < HPAGE_SHIFT) {
+	if (hugepage_shift < REAL_HPAGE_SHIFT) {
 		base = (unsigned long) mm->context.tsb_block[MM_TSB_BASE].tsb;
 		nentries = mm->context.tsb_block[MM_TSB_BASE].tsb_nentries;
 		if (tlb_type = cheetah_plus || tlb_type = hypervisor)
-- 
2.9.2

