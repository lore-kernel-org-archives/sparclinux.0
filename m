From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Fri, 23 Jun 2017 00:15:08 +0000
Subject: [PATCH v2] sparc64: Fix gup_huge_pmd
Message-Id: <1498176950-233141-1-git-send-email-nitin.m.gupta@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Julian Calaby <julian.calaby@gmail.com>, Nitin Gupta <nitin.m.gupta@oracle.com>, Lorenzo Stoakes <lstoakes@gmail.com>, Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

The function assumes that each PMD points to head of a
huge page. This is not correct as a PMD can point to
start of any 8M region with a, say 256M, hugepage. The
fix ensures that it points to the correct head of any PMD
huge page.

Cc: Julian Calaby <julian.calaby@gmail.com>
Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>
---
 Changes since v1
 - Clarify use of 'head' variable (Julian Calaby)

 arch/sparc/mm/gup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/mm/gup.c b/arch/sparc/mm/gup.c
index cd0e32b..f80cfc6 100644
--- a/arch/sparc/mm/gup.c
+++ b/arch/sparc/mm/gup.c
@@ -78,8 +78,8 @@ static int gup_huge_pmd(pmd_t *pmdp, pmd_t pmd, unsigned long addr,
 		return 0;
 
 	refs = 0;
-	head = pmd_page(pmd);
-	page = head + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
+	page = pmd_page(pmd) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
+	head = compound_head(page);
 	do {
 		VM_BUG_ON(compound_head(page) != head);
 		pages[*nr] = page;
-- 
2.9.2

