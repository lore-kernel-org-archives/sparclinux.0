From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 05 Oct 2017 21:11:17 +0000
Subject: [PATCH v10 03/10] sparc64: simplify vmemmap_populate
Message-Id: <20171005211124.26524-4-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20171005211124.26524-1-pasha.tatashin@oracle.com>
In-Reply-To: <20171005211124.26524-1-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Remove duplicating code by using common functions
vmemmap_pud_populate and vmemmap_pgd_populate.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Reviewed-by: Bob Picco <bob.picco@oracle.com>
Acked-by: David S. Miller <davem@davemloft.net>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 arch/sparc/mm/init_64.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index caed495544e9..6839db3ffe1d 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2652,30 +2652,19 @@ int __meminit vmemmap_populate(unsigned long vstart, unsigned long vend,
 	vstart = vstart & PMD_MASK;
 	vend = ALIGN(vend, PMD_SIZE);
 	for (; vstart < vend; vstart += PMD_SIZE) {
-		pgd_t *pgd = pgd_offset_k(vstart);
+		pgd_t *pgd = vmemmap_pgd_populate(vstart, node);
 		unsigned long pte;
 		pud_t *pud;
 		pmd_t *pmd;
 
-		if (pgd_none(*pgd)) {
-			pud_t *new = vmemmap_alloc_block(PAGE_SIZE, node);
+		if (!pgd)
+			return -ENOMEM;
 
-			if (!new)
-				return -ENOMEM;
-			pgd_populate(&init_mm, pgd, new);
-		}
-
-		pud = pud_offset(pgd, vstart);
-		if (pud_none(*pud)) {
-			pmd_t *new = vmemmap_alloc_block(PAGE_SIZE, node);
-
-			if (!new)
-				return -ENOMEM;
-			pud_populate(&init_mm, pud, new);
-		}
+		pud = vmemmap_pud_populate(pgd, vstart, node);
+		if (!pud)
+			return -ENOMEM;
 
 		pmd = pmd_offset(pud, vstart);
-
 		pte = pmd_val(*pmd);
 		if (!(pte & _PAGE_VALID)) {
 			void *block = vmemmap_alloc_block(PMD_SIZE, node);
-- 
2.14.2

