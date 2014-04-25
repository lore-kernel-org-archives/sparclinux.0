From: David Miller <davem@davemloft.net>
Date: Fri, 25 Apr 2014 19:43:44 +0000
Subject: [PATCH 1/3] sparc64: Fix executable bit testing in set_pmd_at() paths.
Message-Id: <20140425.154344.517930119673374172.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org
Cc: mroos@linux.ee, aaro.koskinen@iki.fi, hughd@google.com, linux-kernel@vger.kernel.org


This code was mistakenly using the exec bit from the PMD in all
cases, even when the PMD isn't a huge PMD.

If it's not a huge PMD, test the exec bit in the individual ptes down
in tlb_batch_pmd_scan().

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/mm/tlb.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
index b12cb5e..c07667f 100644
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -134,7 +134,7 @@ no_cache_flush:
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static void tlb_batch_pmd_scan(struct mm_struct *mm, unsigned long vaddr,
-			       pmd_t pmd, bool exec)
+			       pmd_t pmd)
 {
 	unsigned long end;
 	pte_t *pte;
@@ -142,8 +142,11 @@ static void tlb_batch_pmd_scan(struct mm_struct *mm, unsigned long vaddr,
 	pte = pte_offset_map(&pmd, vaddr);
 	end = vaddr + HPAGE_SIZE;
 	while (vaddr < end) {
-		if (pte_val(*pte) & _PAGE_VALID)
+		if (pte_val(*pte) & _PAGE_VALID) {
+			bool exec = pte_exec(*pte);
+
 			tlb_batch_add_one(mm, vaddr, exec);
+		}
 		pte++;
 		vaddr += PAGE_SIZE;
 	}
@@ -177,15 +180,15 @@ void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 	}
 
 	if (!pmd_none(orig)) {
-		pte_t orig_pte = __pte(pmd_val(orig));
-		bool exec = pte_exec(orig_pte);
-
 		addr &= HPAGE_MASK;
 		if (pmd_trans_huge(orig)) {
+			pte_t orig_pte = __pte(pmd_val(orig));
+			bool exec = pte_exec(orig_pte);
+
 			tlb_batch_add_one(mm, addr, exec);
 			tlb_batch_add_one(mm, addr + REAL_HPAGE_SIZE, exec);
 		} else {
-			tlb_batch_pmd_scan(mm, addr, orig, exec);
+			tlb_batch_pmd_scan(mm, addr, orig);
 		}
 	}
 }
-- 
1.9.0

