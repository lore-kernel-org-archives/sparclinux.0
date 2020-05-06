From: Jason Yan <yanaijie@huawei.com>
Date: Wed, 06 May 2020 06:16:59 +0000
Subject: [PATCH] sparc: mm: return true,false in kern_addr_valid()
Message-Id: <20200506061659.19128-1-yanaijie@huawei.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, akpm@linux-foundation.org, rppt@linux.ibm.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jason Yan <yanaijie@huawei.com>

This function's return type is bool and returns both true/false and 0/1.
This fixes the following coccicheck warning:

arch/sparc/mm/init_64.c:1652:9-10: WARNING: return of 0/1 in function
'kern_addr_valid' with return type bool

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 arch/sparc/mm/init_64.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 5774529ceb43..2ef6826a6ca6 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1649,29 +1649,29 @@ bool kern_addr_valid(unsigned long addr)
 
 	pgd = pgd_offset_k(addr);
 	if (pgd_none(*pgd))
-		return 0;
+		return false;
 
 	p4d = p4d_offset(pgd, addr);
 	if (p4d_none(*p4d))
-		return 0;
+		return false;
 
 	pud = pud_offset(p4d, addr);
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
2.21.1
