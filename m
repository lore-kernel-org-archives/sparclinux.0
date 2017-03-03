From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Fri, 03 Mar 2017 22:40:44 +0000
Subject: [PATCH] sparc64: Fix size check in huge_pte_alloc
Message-Id: <1488580854-92578-1-git-send-email-nitin.m.gupta@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Nitin Gupta <nitin.m.gupta@oracle.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Mike Kravetz <mike.kravetz@oracle.com>, Ingo Molnar <mingo@kernel.org>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>
---
 arch/sparc/mm/hugetlbpage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index 323bc6b..3016850 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -261,7 +261,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
 		if (!pmd)
 			return NULL;
 
-		if (sz = PMD_SHIFT)
+		if (sz >= PMD_SIZE)
 			pte = (pte_t *)pmd;
 		else
 			pte = pte_alloc_map(mm, pmd, addr);
-- 
2.9.2

