From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Tue, 08 Mar 2016 02:23:27 +0000
Subject: sparc64: Reduce TLB flushes on hugetlb PTE change
Message-Id: <1457403807-26555-1-git-send-email-nitin.m.gupta@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Flush TSB and TLB only at REAL_HPAGE_SIZE boundaries and
not at every 8K stride.

Orabug: 22643230

Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>
---
 arch/sparc/mm/hugetlbpage.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index d8f625c..0f4f320 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -182,11 +182,17 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 
 	addr &= HPAGE_MASK;
 	for (i = 0; i < (1 << HUGETLB_PAGE_ORDER); i++) {
-		set_pte_at(mm, addr, ptep, entry);
+		*ptep = entry;
 		ptep++;
 		addr += PAGE_SIZE;
 		pte_val(entry) += PAGE_SIZE;
 	}
+
+	/* Issue TSB and TLB flush at REAL_HPAGE_SIZE boundaries */
+	flush_tsb_user_page(mm, addr, true);
+	flush_tsb_user_page(mm, addr + REAL_HPAGE_SIZE, true);
+	global_flush_tlb_page(mm, addr);
+	global_flush_tlb_page(mm, addr + REAL_HPAGE_SIZE);
 }
 
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
-- 
2.6.4

