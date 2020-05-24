From: Mike Rapoport <rppt@kernel.org>
Date: Sun, 24 May 2020 16:21:50 +0000
Subject: [PATCH 1/2] sparc32: use PUD rather than PGD to get PMD in srmmu_inherit_prom_mappings()
Message-Id: <20200524162151.3493-2-rppt@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20200524162151.3493-1-rppt@kernel.org>
In-Reply-To: <20200524162151.3493-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>, Mike Rapoport <rppt@linux.ibm.com>

From: Mike Rapoport <rppt@linux.ibm.com>

This is a misprint in the page table traversal in
srmmu_inherit_prom_mappings`() function which accessed a PMD entry using
PGD rather than PUD.

Since sparc32 has only 3 page table levels, the PGD and PUD are
essentially the same and usage of __nocache_fix() removed the type
checking.

Use PUD for the consistency and to avoid breakage because of upcoming
addition of type checking into __nocache_fix().

Fixes: 7235db268a2777bc38 ("sparc32: use pgtable-nopud instead of 4level-fixup")
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/sparc/mm/srmmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index a8c2f2615fc6..dbf5334dd084 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -848,7 +848,7 @@ static void __init srmmu_inherit_prom_mappings(unsigned long start,
 			memset(__nocache_fix(pmdp), 0, SRMMU_PMD_TABLE_SIZE);
 			pud_set(__nocache_fix(pudp), pmdp);
 		}
-		pmdp = pmd_offset(__nocache_fix(pgdp), start);
+		pmdp = pmd_offset(__nocache_fix(pudp), start);
 		if (srmmu_pmd_none(*(pmd_t *)__nocache_fix(pmdp))) {
 			ptep = __srmmu_get_nocache(PTE_SIZE, PTE_SIZE);
 			if (ptep = NULL)
-- 
2.26.2
