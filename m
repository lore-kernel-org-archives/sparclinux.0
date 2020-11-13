From: Peter Zijlstra <peterz@infradead.org>
Date: Fri, 13 Nov 2020 11:19:06 +0000
Subject: [PATCH 5/5] sparc64/mm: Implement pXX_leaf_size() support
Message-Id: <20201113113426.655116103@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20201113111901.743573013@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kan.liang@linux.intel.com, mingo@kernel.org, acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@redhat.com, eranian@google.com
Cc: christophe.leroy@csgroup.eu, npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, will@kernel.org, willy@infradead.org, aneesh.kumar@linux.ibm.com, sparclinux@vger.kernel.org, davem@davemloft.net, catalin.marinas@arm.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, ak@linux.intel.com, dave.hansen@intel.com, kirill.shutemov@linux.intel.com, peterz@infradead.org

Sparc64 has non-pagetable aligned large page support; wire up the
pXX_leaf_size() functions to report the correct TLB page size.

This enables PERF_SAMPLE_{DATA,CODE}_PAGE_SIZE to report accurate TLB
page sizes.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/sparc/include/asm/pgtable_64.h |   13 +++++++++++++
 arch/sparc/mm/hugetlbpage.c         |   19 +++++++++++++------
 2 files changed, 26 insertions(+), 6 deletions(-)

--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -1121,6 +1121,19 @@ extern unsigned long cmdline_memory_size
 
 asmlinkage void do_sparc64_fault(struct pt_regs *regs);
 
+#ifdef CONFIG_HUGETLB_PAGE
+
+#define pud_leaf_size pud_leaf_size
+extern unsigned long pud_leaf_size(pud_t pud);
+
+#define pmd_leaf_size pmd_leaf_size
+extern unsigned long pmd_leaf_size(pmd_t pmd);
+
+#define pte_leaf_size pte_leaf_size
+extern unsigned long pte_leaf_size(pte_t pte);
+
+#endif /* CONFIG_HUGETLB_PAGE */
+
 #endif /* !(__ASSEMBLY__) */
 
 #endif /* !(_SPARC64_PGTABLE_H) */
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -247,14 +247,17 @@ static unsigned int sun4u_huge_tte_to_sh
 	return shift;
 }
 
-static unsigned int huge_tte_to_shift(pte_t entry)
+static unsigned long tte_to_shift(pte_t entry)
 {
-	unsigned long shift;
-
 	if (tlb_type = hypervisor)
-		shift = sun4v_huge_tte_to_shift(entry);
-	else
-		shift = sun4u_huge_tte_to_shift(entry);
+		return sun4v_huge_tte_to_shift(entry);
+
+	return sun4u_huge_tte_to_shift(entry);
+}
+
+static unsigned int huge_tte_to_shift(pte_t entry)
+{
+	unsigned long shift = tte_to_shift(entry);
 
 	if (shift = PAGE_SHIFT)
 		WARN_ONCE(1, "tto_to_shift: invalid hugepage tte=0x%lx\n",
@@ -272,6 +275,10 @@ static unsigned long huge_tte_to_size(pt
 	return size;
 }
 
+unsigned long pud_leaf_size(pud_t pud) { return 1UL << tte_to_shift((pte_t)pud); }
+unsigned long pmd_leaf_size(pmd_t pmd) { return 1UL << tte_to_shift((pte_t)pmd); }
+unsigned long pte_leaf_size(pte_t pte) { return 1UL << tte_to_shift((pte_t)pte); }
+
 pte_t *huge_pte_alloc(struct mm_struct *mm,
 			unsigned long addr, unsigned long sz)
 {
