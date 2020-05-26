From: Will Deacon <will@kernel.org>
Date: Tue, 26 May 2020 17:33:00 +0000
Subject: [PATCH 1/3] sparc32: mm: Don't try to free page-table pages if ctor() fails
Message-Id: <20200526173302.377-2-will@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20200526173302.377-1-will@kernel.org>
In-Reply-To: <20200526173302.377-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "David S . Miller" <davem@davemloft.net>, Guenter Roeck <linux@roeck-us.net>, Mike Rapoport <rppt@kernel.org>, kernel-team@android.com, "Kirill A . Shutemov" <kirill@shutemov.name>

The pages backing page-table allocations for SRMMU are allocated via
memblock as part of the "nocache" region initialisation during
srmmu_paging_init() and should not be freed even if a later call to
pgtable_pte_page_ctor() fails.

Remove the broken call to __free_page().

Cc: David S. Miller <davem@davemloft.net>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Fixes: 1ae9ae5f7df7 ("sparc: handle pgtable_page_ctor() fail")
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/sparc/mm/srmmu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index c861c0f0df73..589370a21b12 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -365,7 +365,6 @@ pgtable_t pte_alloc_one(struct mm_struct *mm)
 		return NULL;
 	page = pfn_to_page(__nocache_pa((unsigned long)ptep) >> PAGE_SHIFT);
 	if (!pgtable_pte_page_ctor(page)) {
-		__free_page(page);
 		return NULL;
 	}
 	return ptep;
-- 
2.27.0.rc0.183.gde8f92d652-goog
