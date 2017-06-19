From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Mon, 19 Jun 2017 21:48:02 +0000
Subject: [PATCH v2 3/4] sparc64: Fix gup_huge_pmd
Message-Id: <1497908927-93636-3-git-send-email-nitin.m.gupta@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1497908927-93636-1-git-send-email-nitin.m.gupta@oracle.com>
In-Reply-To: <1497908927-93636-1-git-send-email-nitin.m.gupta@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Nitin Gupta <nitin.m.gupta@oracle.com>, Lorenzo Stoakes <lstoakes@gmail.com>, Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

The function assumes that each PMD points to head of a
huge page. This is not correct as a PMD can point to
start of any 8M region with a, say 256M, hugepage. The
fix ensures that it points to the correct head of any PMD
huge page.

Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>
---
 arch/sparc/mm/gup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sparc/mm/gup.c b/arch/sparc/mm/gup.c
index 7cfa9c5..b1c649d 100644
--- a/arch/sparc/mm/gup.c
+++ b/arch/sparc/mm/gup.c
@@ -80,6 +80,8 @@ static int gup_huge_pmd(pmd_t *pmdp, pmd_t pmd, unsigned long addr,
 	refs = 0;
 	head = pmd_page(pmd);
 	page = head + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
+	if (PageTail(head))
+		head = compound_head(head);
 	do {
 		VM_BUG_ON(compound_head(page) != head);
 		pages[*nr] = page;
-- 
2.9.2

