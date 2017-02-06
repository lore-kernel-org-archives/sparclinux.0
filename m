From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Mon, 06 Feb 2017 20:33:26 +0000
Subject: [PATCH] sparc64: Add 64K page size support
Message-Id: <1486413269-99237-1-git-send-email-nitin.m.gupta@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Nitin Gupta <nitin.m.gupta@oracle.com>, Mike Kravetz <mike.kravetz@oracle.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Paul Gortmaker <paul.gortmaker@windriver.com>, Thomas Tai <thomas.tai@oracle.com>, Chris Hyser <chris.hyser@oracle.com>, Khalid Aziz <khalid.aziz@oracle.com>, Atish Patra <atish.patra@oracle.com>, Michal Hocko <mhocko@suse.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

This patch depends on:
[v6] sparc64: Multi-page size support

- Testing

Tested on Sonoma by running stream benchmark instance which allocated
48G worth of 64K pages.

boot params: default_hugepageszdK hugepageszdK hugepages10720

Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>
---
 arch/sparc/include/asm/page_64.h |  3 ++-
 arch/sparc/mm/hugetlbpage.c      | 54 ++++++++++++++++++++++++++++++++--------
 arch/sparc/mm/init_64.c          |  4 +++
 arch/sparc/mm/tsb.c              |  5 ++--
 4 files changed, 52 insertions(+), 14 deletions(-)

diff --git a/arch/sparc/include/asm/page_64.h b/arch/sparc/include/asm/page_64.h
index d76f38d..f294dd4 100644
--- a/arch/sparc/include/asm/page_64.h
+++ b/arch/sparc/include/asm/page_64.h
@@ -18,6 +18,7 @@
 #define HPAGE_SHIFT		23
 #define REAL_HPAGE_SHIFT	22
 #define HPAGE_256MB_SHIFT	28
+#define HPAGE_64K_SHIFT		16
 #define REAL_HPAGE_SIZE		(_AC(1,UL) << REAL_HPAGE_SHIFT)
 
 #if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
@@ -26,7 +27,7 @@
 #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
 #define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
 #define REAL_HPAGE_PER_HPAGE	(_AC(1,UL) << (HPAGE_SHIFT - REAL_HPAGE_SHIFT))
-#define HUGE_MAX_HSTATE		2
+#define HUGE_MAX_HSTATE		3
 #endif
 
 #ifndef __ASSEMBLY__
diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index 618a568..605bfce 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -149,6 +149,9 @@ static pte_t sun4v_hugepage_shift_to_tte(pte_t entry, unsigned int shift)
 	case HPAGE_SHIFT:
 		pte_val(entry) |= _PAGE_PMD_HUGE;
 		break;
+	case HPAGE_64K_SHIFT:
+		hugepage_size = _PAGE_SZ64K_4V;
+		break;
 	default:
 		WARN_ONCE(1, "unsupported hugepage shift=%u\n", shift);
 	}
@@ -185,6 +188,9 @@ static unsigned int sun4v_huge_tte_to_shift(pte_t entry)
 	case _PAGE_SZ4MB_4V:
 		shift = REAL_HPAGE_SHIFT;
 		break;
+	case _PAGE_SZ64K_4V:
+		shift = HPAGE_64K_SHIFT;
+		break;
 	default:
 		shift = PAGE_SHIFT;
 		break;
@@ -204,6 +210,9 @@ static unsigned int sun4u_huge_tte_to_shift(pte_t entry)
 	case _PAGE_SZ4MB_4U:
 		shift = REAL_HPAGE_SHIFT;
 		break;
+	case _PAGE_SZ64K_4U:
+		shift = HPAGE_64K_SHIFT;
+		break;
 	default:
 		shift = PAGE_SHIFT;
 		break;
@@ -241,12 +250,21 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
 {
 	pgd_t *pgd;
 	pud_t *pud;
+	pmd_t *pmd;
 	pte_t *pte = NULL;
 
 	pgd = pgd_offset(mm, addr);
 	pud = pud_alloc(mm, pgd, addr);
-	if (pud)
-		pte = (pte_t *)pmd_alloc(mm, pud, addr);
+	if (pud) {
+		pmd = pmd_alloc(mm, pud, addr);
+		if (!pmd)
+			return NULL;
+
+		if (sz = PMD_SHIFT)
+			pte = (pte_t *)pmd;
+		else
+			pte = pte_alloc_map(mm, pmd, addr);
+	}
 
 	return pte;
 }
@@ -255,42 +273,52 @@ pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
 	pud_t *pud;
+	pmd_t *pmd;
 	pte_t *pte = NULL;
 
 	pgd = pgd_offset(mm, addr);
 	if (!pgd_none(*pgd)) {
 		pud = pud_offset(pgd, addr);
-		if (!pud_none(*pud))
-			pte = (pte_t *)pmd_offset(pud, addr);
+		if (!pud_none(*pud)) {
+			pmd = pmd_offset(pud, addr);
+			if (!pmd_none(*pmd)) {
+				if (is_hugetlb_pmd(*pmd))
+					pte = (pte_t *)pmd;
+				else
+					pte = pte_offset_map(pmd, addr);
+			}
+		}
 	}
+
 	return pte;
 }
 
 void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 		     pte_t *ptep, pte_t entry)
 {
-	unsigned int i, nptes, hugepage_shift;
+	unsigned int i, nptes, orig_shift, shift;
 	unsigned long size;
 	pte_t orig;
 
 	size = huge_tte_to_size(entry);
-	nptes = size >> PMD_SHIFT;
+	shift = size >= HPAGE_SIZE ? PMD_SHIFT : PAGE_SHIFT;
+	nptes = size >> shift;
 
 	if (!pte_present(*ptep) && pte_present(entry))
 		mm->context.hugetlb_pte_count += nptes;
 
 	addr &= ~(size - 1);
 	orig = *ptep;
-	hugepage_shift = pte_none(orig) ? PAGE_SIZE : huge_tte_to_shift(orig);
+	orig_shift = pte_none(orig) ? PAGE_SIZE : huge_tte_to_shift(orig);
 
 	for (i = 0; i < nptes; i++)
-		ptep[i] = __pte(pte_val(entry) + (i << PMD_SHIFT));
+		ptep[i] = __pte(pte_val(entry) + (i << shift));
 
-	maybe_tlb_batch_add(mm, addr, ptep, orig, 0, hugepage_shift);
+	maybe_tlb_batch_add(mm, addr, ptep, orig, 0, orig_shift);
 	/* An HPAGE_SIZE'ed page is composed of two REAL_HPAGE_SIZE'ed pages */
 	if (size = HPAGE_SIZE)
 		maybe_tlb_batch_add(mm, addr + REAL_HPAGE_SIZE, ptep, orig, 0,
-				    hugepage_shift);
+				    orig_shift);
 }
 
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
@@ -302,7 +330,11 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
 
 	entry = *ptep;
 	size = huge_tte_to_size(entry);
-	nptes = size >> PMD_SHIFT;
+	if (size >= HPAGE_SIZE)
+		nptes = size >> PMD_SHIFT;
+	else
+		nptes = size >> PAGE_SHIFT;
+
 	hugepage_shift = pte_none(entry) ? PAGE_SIZE : huge_tte_to_shift(entry);
 
 	if (pte_present(entry))
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 7ed3975..16c1e46 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -345,6 +345,10 @@ static int __init setup_hugepagesz(char *string)
 		hv_pgsz_mask = HV_PGSZ_MASK_4MB;
 		hv_pgsz_idx = HV_PGSZ_IDX_4MB;
 		break;
+	case HPAGE_64K_SHIFT:
+		hv_pgsz_mask = HV_PGSZ_MASK_64K;
+		hv_pgsz_idx = HV_PGSZ_IDX_64K;
+		break;
 	default:
 		hv_pgsz_mask = 0;
 	}
diff --git a/arch/sparc/mm/tsb.c b/arch/sparc/mm/tsb.c
index 4ccca32..e39fc57 100644
--- a/arch/sparc/mm/tsb.c
+++ b/arch/sparc/mm/tsb.c
@@ -147,12 +147,13 @@ void flush_tsb_user_page(struct mm_struct *mm, unsigned long vaddr,
 
 	spin_lock_irqsave(&mm->context.lock, flags);
 
-	if (hugepage_shift = PAGE_SHIFT) {
+	if (hugepage_shift < HPAGE_SHIFT) {
 		base = (unsigned long) mm->context.tsb_block[MM_TSB_BASE].tsb;
 		nentries = mm->context.tsb_block[MM_TSB_BASE].tsb_nentries;
 		if (tlb_type = cheetah_plus || tlb_type = hypervisor)
 			base = __pa(base);
-		__flush_tsb_one_entry(base, vaddr, PAGE_SHIFT, nentries);
+		__flush_huge_tsb_one_entry(base, vaddr, PAGE_SHIFT, nentries,
+					   hugepage_shift);
 	}
 #if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
 	else if (mm->context.tsb_block[MM_TSB_HUGE].tsb) {
-- 
2.9.2

