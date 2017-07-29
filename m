From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Sat, 29 Jul 2017 18:42:19 +0000
Subject: [PATCH v5 3/3] sparc64: Cleanup hugepage table walk functions
Message-Id: <bc84ed51c84baf4a7f7ec0dfa98e8508475cdecb.1501353478.git.nitin.m.gupta@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1501353478.git.nitin.m.gupta@oracle.com>
In-Reply-To: <cover.1501353478.git.nitin.m.gupta@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Nitin Gupta <nitin.m.gupta@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Steve Capper <steve.capper@arm.com>, Punit Agrawal <punit.agrawal@arm.com>, Ingo Molnar <mingo@kernel.org>, Hugh Dickins <hughd@google.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Flatten out nested code structure in huge_pte_offset()
and huge_pte_alloc().

Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>
---
 arch/sparc/mm/hugetlbpage.c | 54 +++++++++++++++++----------------------------
 1 file changed, 20 insertions(+), 34 deletions(-)

diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index 7acb84d..bcd8cdb 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -266,27 +266,19 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
 	pgd_t *pgd;
 	pud_t *pud;
 	pmd_t *pmd;
-	pte_t *pte = NULL;
 
 	pgd = pgd_offset(mm, addr);
 	pud = pud_alloc(mm, pgd, addr);
 	if (!pud)
 		return NULL;
-
 	if (sz >= PUD_SIZE)
-		pte = (pte_t *)pud;
-	else {
-		pmd = pmd_alloc(mm, pud, addr);
-		if (!pmd)
-			return NULL;
-
-		if (sz >= PMD_SIZE)
-			pte = (pte_t *)pmd;
-		else
-			pte = pte_alloc_map(mm, pmd, addr);
-	}
-
-	return pte;
+		return (pte_t *)pud;
+	pmd = pmd_alloc(mm, pud, addr);
+	if (!pmd)
+		return NULL;
+	if (sz >= PMD_SIZE)
+		return (pte_t *)pmd;
+	return pte_alloc_map(mm, pmd, addr);
 }
 
 pte_t *huge_pte_offset(struct mm_struct *mm,
@@ -295,27 +287,21 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
 	pgd_t *pgd;
 	pud_t *pud;
 	pmd_t *pmd;
-	pte_t *pte = NULL;
 
 	pgd = pgd_offset(mm, addr);
-	if (!pgd_none(*pgd)) {
-		pud = pud_offset(pgd, addr);
-		if (!pud_none(*pud)) {
-			if (is_hugetlb_pud(*pud))
-				pte = (pte_t *)pud;
-			else {
-				pmd = pmd_offset(pud, addr);
-				if (!pmd_none(*pmd)) {
-					if (is_hugetlb_pmd(*pmd))
-						pte = (pte_t *)pmd;
-					else
-						pte = pte_offset_map(pmd, addr);
-				}
-			}
-		}
-	}
-
-	return pte;
+	if (pgd_none(*pgd))
+		return NULL;
+	pud = pud_offset(pgd, addr);
+	if (pud_none(*pud))
+		return NULL;
+	if (is_hugetlb_pud(*pud))
+		return (pte_t *)pud;
+	pmd = pmd_offset(pud, addr);
+	if (pmd_none(*pmd))
+		return NULL;
+	if (is_hugetlb_pmd(*pmd))
+		return (pte_t *)pmd;
+	return pte_offset_map(pmd, addr);
 }
 
 void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
-- 
2.9.2

