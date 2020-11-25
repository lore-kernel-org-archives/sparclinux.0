From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Date: Wed, 25 Nov 2020 03:46:54 +0000
Subject: [PATCH 1/2] sparc: Fix handling of page table constructor failure
Message-Id: <20201125034655.27687-1-willy@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@linux-foundation.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, davem@davemloft.net, rppt@kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org

The page has just been allocated, so its refcount is 1.  free_unref_page()
is for use on pages which have a zero refcount.  Use __free_page()
like the other implementations of pte_alloc_one().

Fixes: 1ae9ae5f7df7 ("sparc: handle pgtable_page_ctor() fail")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/sparc/mm/init_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 96edf64d4fb3..182bb7bdaa0a 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2894,7 +2894,7 @@ pgtable_t pte_alloc_one(struct mm_struct *mm)
 	if (!page)
 		return NULL;
 	if (!pgtable_pte_page_ctor(page)) {
-		free_unref_page(page);
+		__free_page(page);
 		return NULL;
 	}
 	return (pte_t *) page_address(page);
-- 
2.29.2
