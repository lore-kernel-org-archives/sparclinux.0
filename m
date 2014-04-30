From: David Miller <davem@davemloft.net>
Date: Wed, 30 Apr 2014 21:54:55 +0000
Subject: [PATCH 03/10] sparc64: Fix bugs in get_user_pages_fast() wrt. THP.
Message-Id: <20140430.175455.1304476354319716462.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


The large PMD path needs to check _PAGE_VALID not _PAGE_PRESENT, to
decide if it needs to bail and return 0.

pmd_large() should therefore just check _PAGE_PMD_HUGE.

Calls to gup_huge_pmd() are guarded with a check of pmd_large(), so we
just need to add a valid bit check.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/pgtable_64.h | 2 +-
 arch/sparc/mm/gup.c                 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index e3db4b8..1f28103 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -633,7 +633,7 @@ static inline unsigned long pmd_large(pmd_t pmd)
 {
 	pte_t pte = __pte(pmd_val(pmd));
 
-	return (pte_val(pte) & _PAGE_PMD_HUGE) && pte_present(pte);
+	return pte_val(pte) & _PAGE_PMD_HUGE;
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
diff --git a/arch/sparc/mm/gup.c b/arch/sparc/mm/gup.c
index c4d3da6..1aed043 100644
--- a/arch/sparc/mm/gup.c
+++ b/arch/sparc/mm/gup.c
@@ -73,7 +73,7 @@ static int gup_huge_pmd(pmd_t *pmdp, pmd_t pmd, unsigned long addr,
 	struct page *head, *page, *tail;
 	int refs;
 
-	if (!pmd_large(pmd))
+	if (!(pmd_val(pmd) & _PAGE_VALID))
 		return 0;
 
 	if (write && !pmd_write(pmd))
-- 
1.8.1.2

