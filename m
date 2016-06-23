From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Thu, 23 Jun 2016 22:05:36 +0000
Subject: [PATCH v2 2/2] sparc64: Fix pagetable freeing for hugepage regions
Message-Id: <1466719639-143815-2-git-send-email-nitin.m.gupta@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1466719639-143815-1-git-send-email-nitin.m.gupta@oracle.com>
In-Reply-To: <1466719639-143815-1-git-send-email-nitin.m.gupta@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Nitin Gupta <nitin.m.gupta@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Dominik Dingel <dingel@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

8M pages now allocate page tables till PMD level only.
So, when freeing page table for 8M hugepage backed region,
make sure we don't try to access non-existent PTE level.

Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>
---
 arch/sparc/include/asm/hugetlb.h |   12 ++---
 arch/sparc/mm/hugetlbpage.c      |   98 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/include/asm/hugetlb.h b/arch/sparc/include/asm/hugetlb.h
index 139e711..dcbf985 100644
--- a/arch/sparc/include/asm/hugetlb.h
+++ b/arch/sparc/include/asm/hugetlb.h
@@ -31,14 +31,6 @@ static inline int prepare_hugepage_range(struct file *file,
 	return 0;
 }
 
-static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
-					  unsigned long addr, unsigned long end,
-					  unsigned long floor,
-					  unsigned long ceiling)
-{
-	free_pgd_range(tlb, addr, end, floor, ceiling);
-}
-
 static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
 					 unsigned long addr, pte_t *ptep)
 {
@@ -82,4 +74,8 @@ static inline void arch_clear_hugepage_flags(struct page *page)
 {
 }
 
+void hugetlb_free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
+			    unsigned long end, unsigned long floor,
+			    unsigned long ceiling);
+
 #endif /* _ASM_SPARC64_HUGETLB_H */
diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index cafb5ca..494c390 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -12,6 +12,7 @@
 
 #include <asm/mman.h>
 #include <asm/pgalloc.h>
+#include <asm/pgtable.h>
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
@@ -202,3 +203,100 @@ int pud_huge(pud_t pud)
 {
 	return 0;
 }
+
+static void hugetlb_free_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
+			   unsigned long addr)
+{
+	pgtable_t token = pmd_pgtable(*pmd);
+
+	pmd_clear(pmd);
+	pte_free_tlb(tlb, token, addr);
+	atomic_long_dec(&tlb->mm->nr_ptes);
+}
+
+static void hugetlb_free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
+				   unsigned long addr, unsigned long end,
+				   unsigned long floor, unsigned long ceiling)
+{
+	pmd_t *pmd;
+	unsigned long next;
+	unsigned long start;
+
+	start = addr;
+	pmd = pmd_offset(pud, addr);
+	do {
+		next = pmd_addr_end(addr, end);
+		if (pmd_none(*pmd))
+			continue;
+		if (is_hugetlb_pmd(*pmd))
+			pmd_clear(pmd);
+		else
+			hugetlb_free_pte_range(tlb, pmd, addr);
+	} while (pmd++, addr = next, addr != end);
+
+	start &= PUD_MASK;
+	if (start < floor)
+		return;
+	if (ceiling) {
+		ceiling &= PUD_MASK;
+		if (!ceiling)
+			return;
+	}
+	if (end - 1 > ceiling - 1)
+		return;
+
+	pmd = pmd_offset(pud, start);
+	pud_clear(pud);
+	pmd_free_tlb(tlb, pmd, start);
+	mm_dec_nr_pmds(tlb->mm);
+}
+
+static void hugetlb_free_pud_range(struct mmu_gather *tlb, pgd_t *pgd,
+				   unsigned long addr, unsigned long end,
+				   unsigned long floor, unsigned long ceiling)
+{
+	pud_t *pud;
+	unsigned long next;
+	unsigned long start;
+
+	start = addr;
+	pud = pud_offset(pgd, addr);
+	do {
+		next = pud_addr_end(addr, end);
+		if (pud_none_or_clear_bad(pud))
+			continue;
+		hugetlb_free_pmd_range(tlb, pud, addr, next, floor,
+				       ceiling);
+	} while (pud++, addr = next, addr != end);
+
+	start &= PGDIR_MASK;
+	if (start < floor)
+		return;
+	if (ceiling) {
+		ceiling &= PGDIR_MASK;
+		if (!ceiling)
+			return;
+	}
+	if (end - 1 > ceiling - 1)
+		return;
+
+	pud = pud_offset(pgd, start);
+	pgd_clear(pgd);
+	pud_free_tlb(tlb, pud, start);
+}
+
+void hugetlb_free_pgd_range(struct mmu_gather *tlb,
+			    unsigned long addr, unsigned long end,
+			    unsigned long floor, unsigned long ceiling)
+{
+	pgd_t *pgd;
+	unsigned long next;
+
+	pgd = pgd_offset(tlb->mm, addr);
+	do {
+		next = pgd_addr_end(addr, end);
+		if (pgd_none_or_clear_bad(pgd))
+			continue;
+		hugetlb_free_pud_range(tlb, pgd, addr, next, floor, ceiling);
+	} while (pgd++, addr = next, addr != end);
+}
-- 
1.7.1

