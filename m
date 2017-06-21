From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Wed, 21 Jun 2017 01:05:57 +0000
Subject: [PATCH 4/4] sparc64: Cleanup hugepage table walk functions
Message-Id: <9baea6330082770ed7531aeead928f870a2f3c49.1498005968.git.nitin.m.gupta@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1498005968.git.nitin.m.gupta@oracle.com>
In-Reply-To: <cover.1498005968.git.nitin.m.gupta@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Nitin Gupta <nitin.m.gupta@oracle.com>, Mike Kravetz <mike.kravetz@oracle.com>, Michal Hocko <mhocko@suse.com>, Ingo Molnar <mingo@kernel.org>, Hugh Dickins <hughd@google.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Flatten out nested code structure in huge_pte_offset()
and huge_pte_alloc().

Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>
---
 arch/sparc/mm/hugetlbpage.c | 54 +++++++++++++++++----------------------------
 1 file changed, 20 insertions(+), 34 deletions(-)

diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index f0bb42d..e8b7245 100644
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
 
 pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
@@ -294,27 +286,21 @@ pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
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

