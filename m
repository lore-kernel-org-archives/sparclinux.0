From: David Miller <davem@davemloft.net>
Date: Tue, 06 May 2014 04:08:16 +0000
Subject: [PATCH 02/11] sparc64: Fix huge PMD invalidation.
Message-Id: <20140506.000816.608880063453493831.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



On sparc64 "present" and "valid" are seperate PTE bits, this allows us to
naturally distinguish between the user explicitly asking for PROT_NONE
with mprotect() and other situations.

However we weren't handling this properly in the huge PMD paths.

First of all, the page table walker in the TSB miss path only checks
for _PAGE_PMD_HUGE.  So the generic pmdp_invalidate() would clear
_PAGE_PRESENT but the TLB miss paths would still load it into the TLB
as a valid huge PMD.

Fix this by clearing the valid bit in pmdp_invalidate(), and also
checking the valid bit in USER_PGTABLE_CHECK_PMD_HUGE using "brgez"
since _PAGE_VALID is bit 63 in both the sun4u and sun4v pte layouts.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/pgtable_64.h | 18 ++++--------------
 arch/sparc/include/asm/tsb.h        |  3 ++-
 arch/sparc/mm/tlb.c                 | 11 +++++++++++
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 0f9e945..e3db4b8 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -719,20 +719,6 @@ static inline pmd_t pmd_mkwrite(pmd_t pmd)
 	return __pmd(pte_val(pte));
 }
 
-static inline pmd_t pmd_mknotpresent(pmd_t pmd)
-{
-	unsigned long mask;
-
-	if (tlb_type = hypervisor)
-		mask = _PAGE_PRESENT_4V;
-	else
-		mask = _PAGE_PRESENT_4U;
-
-	pmd_val(pmd) &= ~mask;
-
-	return pmd;
-}
-
 static inline pmd_t pmd_mksplitting(pmd_t pmd)
 {
 	pte_t pte = __pte(pmd_val(pmd));
@@ -893,6 +879,10 @@ extern void update_mmu_cache(struct vm_area_struct *, unsigned long, pte_t *);
 extern void update_mmu_cache_pmd(struct vm_area_struct *vma, unsigned long addr,
 				 pmd_t *pmd);
 
+#define __HAVE_ARCH_PMDP_INVALIDATE
+extern void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
+			    pmd_t *pmdp);
+
 #define __HAVE_ARCH_PGTABLE_DEPOSIT
 extern void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
 				       pgtable_t pgtable);
diff --git a/arch/sparc/include/asm/tsb.h b/arch/sparc/include/asm/tsb.h
index 2230f80..90916f9 100644
--- a/arch/sparc/include/asm/tsb.h
+++ b/arch/sparc/include/asm/tsb.h
@@ -171,7 +171,8 @@ extern struct tsb_phys_patch_entry __tsb_phys_patch, __tsb_phys_patch_end;
 	andcc		REG1, REG2, %g0;		\
 	be,pt		%xcc, 700f;			\
 	 sethi		%hi(4 * 1024 * 1024), REG2;	\
-	andn		REG1, REG2, REG1;		\
+	brgez,pn	REG1, FAIL_LABEL;		\
+	 andn		REG1, REG2, REG1;		\
 	and		VADDR, REG2, REG2;		\
 	brlz,pt		REG1, PTE_LABEL;		\
 	 or		REG1, REG2, REG1;		\
diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
index c07667f..b89aba2 100644
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -193,6 +193,17 @@ void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 	}
 }
 
+void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
+		     pmd_t *pmdp)
+{
+	pmd_t entry = *pmdp;
+
+	pmd_val(entry) &= ~_PAGE_VALID;
+
+	set_pmd_at(vma->vm_mm, address, pmdp, entry);
+	flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
+}
+
 void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
 				pgtable_t pgtable)
 {
-- 
1.8.1.2

