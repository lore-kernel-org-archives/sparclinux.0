From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Tue, 02 Feb 2016 03:21:21 +0000
Subject: [PATCH] sparc64: Reduce TLB flushes during hugepage unmap
Message-Id: <1454383281-156550-1-git-send-email-nitin.m.gupta@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

During hugepage unmap, TLB flush is currently issued
at every PAGE_SIZE'd boundary which is unnecessary. We
now issue the flush at REAL_HPAGE_SIZE boundaries only.

Without this patch workloads which unmap a large hugepage
backed VMA region get CPU lockups due to excessive TLB
flush calls.

Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>
---
 arch/sparc/mm/hugetlbpage.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index 131eaf4..48927cb 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -193,16 +193,24 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep)
 {
 	pte_t entry;
-	int i;
+	int i, pte_count;
 
 	entry = *ptep;
 	if (pte_present(entry))
 		mm->context.huge_pte_count--;
 
 	addr &= HPAGE_MASK;
+	pte_count = 1 << HUGETLB_PAGE_ORDER;
 
-	for (i = 0; i < (1 << HUGETLB_PAGE_ORDER); i++) {
-		pte_clear(mm, addr, ptep);
+	/*
+	 * pte_clear issues TLB flush which is required
+	 * only for REAL_HPAGE_SIZE aligned addresses.
+	 */
+	pte_clear(mm, addr, ptep);
+	pte_clear(mm, addr + REAL_HPAGE_SIZE, ptep + pte_count / 2);
+	ptep++;
+	for (i = 1; i < pte_count; i++) {
+		*ptep = __pte(0UL);
 		addr += PAGE_SIZE;
 		ptep++;
 	}
-- 
2.6.4

