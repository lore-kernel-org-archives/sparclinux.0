From: xiakaixu1987@gmail.com
Date: Mon, 09 Nov 2020 08:06:56 +0000
Subject: [PATCH] sparc32: Fix comparing pointer to 0 coccicheck warning
Message-Id: <1604909216-16572-1-git-send-email-kaixuxia@tencent.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>

From: Kaixu Xia <kaixuxia@tencent.com>

Fixes coccicheck warning:

/arch/sparc/mm/srmmu.c:354:42-43: WARNING comparing pointer to 0

Avoid pointer type value compared to 0.

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 arch/sparc/mm/srmmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 0070f8b9a753..26d444223ab1 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -351,7 +351,7 @@ pgtable_t pte_alloc_one(struct mm_struct *mm)
 	pte_t *ptep;
 	struct page *page;
 
-	if ((ptep = pte_alloc_one_kernel(mm)) = 0)
+	if (!(ptep = pte_alloc_one_kernel(mm)))
 		return NULL;
 	page = pfn_to_page(__nocache_pa((unsigned long)ptep) >> PAGE_SHIFT);
 	spin_lock(&mm->page_table_lock);
-- 
2.20.0
