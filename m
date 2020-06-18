From: Sasha Levin <sashal@kernel.org>
Date: Thu, 18 Jun 2020 01:13:15 +0000
Subject: [PATCH AUTOSEL 5.4 070/266] sparc32: mm: Don't try to free page-table pages if ctor() fails
Message-Id: <20200618011631.604574-70-sashal@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
In-Reply-To: <20200618011631.604574-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Will Deacon <will@kernel.org>, "David S . Miller" <davem@davemloft.net>, "Kirill A . Shutemov" <kirill@shutemov.name>, Sasha Levin <sashal@kernel.org>, sparclinux@vger.kernel.org

From: Will Deacon <will@kernel.org>

[ Upstream commit 454b0289c6b5f2c66164654b80212d15fbef7a03 ]

The pages backing page-table allocations for SRMMU are allocated via
memblock as part of the "nocache" region initialisation during
srmmu_paging_init() and should not be freed even if a later call to
pgtable_pte_page_ctor() fails.

Remove the broken call to __free_page().

Cc: David S. Miller <davem@davemloft.net>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Fixes: 1ae9ae5f7df7 ("sparc: handle pgtable_page_ctor() fail")
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sparc/mm/srmmu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index cc3ad64479ac..9e256d4d1f4c 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -379,7 +379,6 @@ pgtable_t pte_alloc_one(struct mm_struct *mm)
 		return NULL;
 	page = pfn_to_page(__nocache_pa(pte) >> PAGE_SHIFT);
 	if (!pgtable_pte_page_ctor(page)) {
-		__free_page(page);
 		return NULL;
 	}
 	return page;
-- 
2.25.1
