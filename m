From: Joe Perches <joe@perches.com>
Date: Mon, 30 Mar 2015 23:46:06 +0000
Subject: [PATCH 08/25] sparc: Use bool function return values of true/false not 1/0
Message-Id: <d280667ee6ffa1864c2d9cb5de8b4ec0162fb074.1427759009.git.joe@perches.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1427759009.git.joe@perches.com>
In-Reply-To: <cover.1427759009.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Use the normal return values for bool functions

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/sparc/mm/init_64.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 4ca0d6b..f7c4832 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1389,25 +1389,25 @@ bool kern_addr_valid(unsigned long addr)
 
 	pgd = pgd_offset_k(addr);
 	if (pgd_none(*pgd))
-		return 0;
+		return false;
 
 	pud = pud_offset(pgd, addr);
 	if (pud_none(*pud))
-		return 0;
+		return false;
 
 	if (pud_large(*pud))
 		return pfn_valid(pud_pfn(*pud));
 
 	pmd = pmd_offset(pud, addr);
 	if (pmd_none(*pmd))
-		return 0;
+		return false;
 
 	if (pmd_large(*pmd))
 		return pfn_valid(pmd_pfn(*pmd));
 
 	pte = pte_offset_kernel(pmd, addr);
 	if (pte_none(*pte))
-		return 0;
+		return false;
 
 	return pfn_valid(pte_pfn(*pte));
 }
-- 
2.1.2

