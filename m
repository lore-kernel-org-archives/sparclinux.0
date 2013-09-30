From: David Miller <davem@davemloft.net>
Date: Mon, 30 Sep 2013 16:32:22 +0000
Subject: [PATCH 9/9] sparc64: Encode huge PMDs using PTE encoding.
Message-Id: <20130930.123222.1547411297490879126.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Now that we have 64-bits for PMDs we can stop using special encodings
for the huge PMD values, and just put real PTEs in there.

We allocate a _PAGE_PMD_HUGE bit to distinguish between plain PMDs and
huge ones.  It is the same for both 4U and 4V PTE layouts.

We also use _PAGE_SPECIAL to indicate the splitting state, since a
huge PMD cannot also be special.

All of the PMD --> PTE translation code disappears, and most of the
huge PMD bit modifications and tests just degenerate into the PTE
operations.  In particular USER_PGTABLE_CHECK_PMD_HUGE becomes
trivial.

As a side effect, normal PMDs don't shift the physical address around.
This also speeds up the page table walks in the TLB miss paths since
they don't have to do the shifts any more.

Another non-trivial aspect is that pte_modify() has to be changed
to preserve the _PAGE_PMD_HUGE bits as well as the page size field
of the pte.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/pgtable_64.h | 181 ++++++++++++++++++++++--------------
 arch/sparc/include/asm/tsb.h        |  92 +++---------------
 arch/sparc/mm/gup.c                 |   9 +-
 arch/sparc/mm/init_64.c             | 102 +-------------------
 arch/sparc/mm/tlb.c                 |   9 +-
 5 files changed, 131 insertions(+), 262 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index eee803e..8358dc1 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -67,29 +67,6 @@
 #error PMD_SHIFT must equal HPAGE_SHIFT for transparent huge pages.
 #endif
 
-/* PMDs point to PTE tables which are 4K aligned.  */
-#define PMD_PADDR	_AC(0xfffffffe,UL)
-#define PMD_PADDR_SHIFT	_AC(11,UL)
-
-#define PMD_ISHUGE	_AC(0x00000001,UL)
-
-/* This is the PMD layout when PMD_ISHUGE is set.  With 4MB huge
- * pages, this frees up a bunch of bits in the layout that we can
- * use for the protection settings and software metadata.
- */
-#define PMD_HUGE_PADDR		_AC(0xfffff800,UL)
-#define PMD_HUGE_PROTBITS	_AC(0x000007ff,UL)
-#define PMD_HUGE_PRESENT	_AC(0x00000400,UL)
-#define PMD_HUGE_WRITE		_AC(0x00000200,UL)
-#define PMD_HUGE_DIRTY		_AC(0x00000100,UL)
-#define PMD_HUGE_ACCESSED	_AC(0x00000080,UL)
-#define PMD_HUGE_EXEC		_AC(0x00000040,UL)
-#define PMD_HUGE_SPLITTING	_AC(0x00000020,UL)
-
-/* PGDs point to PMD tables which are 8K aligned.  */
-#define PGD_PADDR	_AC(0xfffffffc,UL)
-#define PGD_PADDR_SHIFT	_AC(11,UL)
-
 #ifndef __ASSEMBLY__
 
 #include <linux/sched.h>
@@ -112,6 +89,7 @@
 #define _PAGE_VALID	  _AC(0x8000000000000000,UL) /* Valid TTE            */
 #define _PAGE_R	  	  _AC(0x8000000000000000,UL) /* Keep ref bit uptodate*/
 #define _PAGE_SPECIAL     _AC(0x0200000000000000,UL) /* Special page         */
+#define _PAGE_PMD_HUGE    _AC(0x0100000000000000,UL) /* Huge page            */
 
 /* Advertise support for _PAGE_SPECIAL */
 #define __HAVE_ARCH_PTE_SPECIAL
@@ -125,6 +103,7 @@
 #define _PAGE_IE_4U	  _AC(0x0800000000000000,UL) /* Invert Endianness    */
 #define _PAGE_SOFT2_4U	  _AC(0x07FC000000000000,UL) /* Software bits, set 2 */
 #define _PAGE_SPECIAL_4U  _AC(0x0200000000000000,UL) /* Special page         */
+#define _PAGE_PMD_HUGE_4U _AC(0x0100000000000000,UL) /* Huge page            */
 #define _PAGE_RES1_4U	  _AC(0x0002000000000000,UL) /* Reserved             */
 #define _PAGE_SZ32MB_4U	  _AC(0x0001000000000000,UL) /* (Panther) 32MB page  */
 #define _PAGE_SZ256MB_4U  _AC(0x2001000000000000,UL) /* (Panther) 256MB page */
@@ -155,6 +134,7 @@
 #define _PAGE_READ_4V	  _AC(0x0800000000000000,UL) /* Readable SW Bit      */
 #define _PAGE_WRITE_4V	  _AC(0x0400000000000000,UL) /* Writable SW Bit      */
 #define _PAGE_SPECIAL_4V  _AC(0x0200000000000000,UL) /* Special page         */
+#define _PAGE_PMD_HUGE_4V _AC(0x0100000000000000,UL) /* Huge page            */
 #define _PAGE_PADDR_4V	  _AC(0x00FFFFFFFFFFE000,UL) /* paddr[55:13]         */
 #define _PAGE_IE_4V	  _AC(0x0000000000001000,UL) /* Invert Endianness    */
 #define _PAGE_E_4V	  _AC(0x0000000000000800,UL) /* side-Effect          */
@@ -243,16 +223,13 @@ static inline pte_t pfn_pte(unsigned long pfn, pgprot_t prot)
 #define mk_pte(page, pgprot)	pfn_pte(page_to_pfn(page), (pgprot))
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-extern pmd_t pfn_pmd(unsigned long page_nr, pgprot_t pgprot);
-#define mk_pmd(page, pgprot)	pfn_pmd(page_to_pfn(page), (pgprot))
-
-extern pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot);
-
-static inline pmd_t pmd_mkhuge(pmd_t pmd)
+static inline pmd_t pfn_pmd(unsigned long page_nr, pgprot_t pgprot)
 {
-	/* Do nothing, mk_pmd() does this part.  */
-	return pmd;
+	pte_t pte = pfn_pte(page_nr, pgprot);
+
+	return __pmd(pte_val(pte));
 }
+#define mk_pmd(page, pgprot)	pfn_pmd(page_to_pfn(page), (pgprot))
 #endif
 
 /* This one can be done with two shifts.  */
@@ -313,14 +290,25 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t prot)
 	: "=r" (mask), "=r" (tmp)
 	: "i" (_PAGE_PADDR_4U | _PAGE_MODIFIED_4U | _PAGE_ACCESSED_4U |
 	       _PAGE_CP_4U | _PAGE_CV_4U | _PAGE_E_4U | _PAGE_PRESENT_4U |
-	       _PAGE_SPECIAL),
+	       _PAGE_SPECIAL | _PAGE_PMD_HUGE | _PAGE_SZALL_4U),
 	  "i" (_PAGE_PADDR_4V | _PAGE_MODIFIED_4V | _PAGE_ACCESSED_4V |
 	       _PAGE_CP_4V | _PAGE_CV_4V | _PAGE_E_4V | _PAGE_PRESENT_4V |
-	       _PAGE_SPECIAL));
+	       _PAGE_SPECIAL | _PAGE_PMD_HUGE | _PAGE_SZALL_4V));
 
 	return __pte((pte_val(pte) & mask) | (pgprot_val(prot) & ~mask));
 }
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
+{
+	pte_t pte = __pte(pmd_val(pmd));
+
+	pte = pte_modify(pte, newprot);
+
+	return __pmd(pte_val(pte));
+}
+#endif
+
 static inline pte_t pgoff_to_pte(unsigned long off)
 {
 	off <<= PAGE_SHIFT;
@@ -361,7 +349,7 @@ static inline pgprot_t pgprot_noncached(pgprot_t prot)
  */
 #define pgprot_noncached pgprot_noncached
 
-#ifdef CONFIG_HUGETLB_PAGE
+#if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
 static inline pte_t pte_mkhuge(pte_t pte)
 {
 	unsigned long mask;
@@ -379,6 +367,17 @@ static inline pte_t pte_mkhuge(pte_t pte)
 
 	return __pte(pte_val(pte) | mask);
 }
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static inline pmd_t pmd_mkhuge(pmd_t pmd)
+{
+	pte_t pte = __pte(pmd_val(pmd));
+
+	pte = pte_mkhuge(pte);
+	pte_val(pte) |= _PAGE_PMD_HUGE;
+
+	return __pmd(pte_val(pte));
+}
+#endif
 #endif
 
 static inline pte_t pte_mkdirty(pte_t pte)
@@ -630,86 +629,125 @@ static inline unsigned long pte_special(pte_t pte)
 	return pte_val(pte) & _PAGE_SPECIAL;
 }
 
-static inline int pmd_large(pmd_t pmd)
+static inline unsigned long pmd_large(pmd_t pmd)
 {
-	return (pmd_val(pmd) & (PMD_ISHUGE | PMD_HUGE_PRESENT)) =
-		(PMD_ISHUGE | PMD_HUGE_PRESENT);
+	pte_t pte = __pte(pmd_val(pmd));
+
+	return (pte_val(pte) & _PAGE_PMD_HUGE) && pte_present(pte);
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-static inline int pmd_young(pmd_t pmd)
+static inline unsigned long pmd_young(pmd_t pmd)
 {
-	return pmd_val(pmd) & PMD_HUGE_ACCESSED;
+	pte_t pte = __pte(pmd_val(pmd));
+
+	return pte_young(pte);
 }
 
-static inline int pmd_write(pmd_t pmd)
+static inline unsigned long pmd_write(pmd_t pmd)
 {
-	return pmd_val(pmd) & PMD_HUGE_WRITE;
+	pte_t pte = __pte(pmd_val(pmd));
+
+	return pte_write(pte);
 }
 
 static inline unsigned long pmd_pfn(pmd_t pmd)
 {
-	unsigned long val = pmd_val(pmd) & PMD_HUGE_PADDR;
+	pte_t pte = __pte(pmd_val(pmd));
 
-	return val >> (PAGE_SHIFT - PMD_PADDR_SHIFT);
+	return pte_pfn(pte);
 }
 
-static inline int pmd_trans_splitting(pmd_t pmd)
+static inline unsigned long pmd_trans_huge(pmd_t pmd)
 {
-	return (pmd_val(pmd) & (PMD_ISHUGE|PMD_HUGE_SPLITTING)) =
-		(PMD_ISHUGE|PMD_HUGE_SPLITTING);
+	pte_t pte = __pte(pmd_val(pmd));
+
+	return pte_val(pte) & _PAGE_PMD_HUGE;
 }
 
-static inline int pmd_trans_huge(pmd_t pmd)
+static inline unsigned long pmd_trans_splitting(pmd_t pmd)
 {
-	return pmd_val(pmd) & PMD_ISHUGE;
+	pte_t pte = __pte(pmd_val(pmd));
+
+	return pmd_trans_huge(pmd) && pte_special(pte);
 }
 
 #define has_transparent_hugepage() 1
 
 static inline pmd_t pmd_mkold(pmd_t pmd)
 {
-	pmd_val(pmd) &= ~PMD_HUGE_ACCESSED;
-	return pmd;
+	pte_t pte = __pte(pmd_val(pmd));
+
+	pte = pte_mkold(pte);
+
+	return __pmd(pte_val(pte));
 }
 
 static inline pmd_t pmd_wrprotect(pmd_t pmd)
 {
-	pmd_val(pmd) &= ~PMD_HUGE_WRITE;
-	return pmd;
+	pte_t pte = __pte(pmd_val(pmd));
+
+	pte = pte_wrprotect(pte);
+
+	return __pmd(pte_val(pte));
 }
 
 static inline pmd_t pmd_mkdirty(pmd_t pmd)
 {
-	pmd_val(pmd) |= PMD_HUGE_DIRTY;
-	return pmd;
+	pte_t pte = __pte(pmd_val(pmd));
+
+	pte = pte_mkdirty(pte);
+
+	return __pmd(pte_val(pte));
 }
 
 static inline pmd_t pmd_mkyoung(pmd_t pmd)
 {
-	pmd_val(pmd) |= PMD_HUGE_ACCESSED;
-	return pmd;
+	pte_t pte = __pte(pmd_val(pmd));
+
+	pte = pte_mkyoung(pte);
+
+	return __pmd(pte_val(pte));
 }
 
 static inline pmd_t pmd_mkwrite(pmd_t pmd)
 {
-	pmd_val(pmd) |= PMD_HUGE_WRITE;
-	return pmd;
+	pte_t pte = __pte(pmd_val(pmd));
+
+	pte = pte_mkwrite(pte);
+
+	return __pmd(pte_val(pte));
 }
 
 static inline pmd_t pmd_mknotpresent(pmd_t pmd)
 {
-	pmd_val(pmd) &= ~PMD_HUGE_PRESENT;
+	unsigned long mask;
+
+	if (tlb_type = hypervisor)
+		mask = _PAGE_PRESENT_4V;
+	else
+		mask = _PAGE_PRESENT_4U;
+
+	pmd_val(pmd) &= ~mask;
+
 	return pmd;
 }
 
 static inline pmd_t pmd_mksplitting(pmd_t pmd)
 {
-	pmd_val(pmd) |= PMD_HUGE_SPLITTING;
-	return pmd;
+	pte_t pte = __pte(pmd_val(pmd));
+
+	pte = pte_mkspecial(pte);
+
+	return __pmd(pte_val(pte));
 }
 
-extern pgprot_t pmd_pgprot(pmd_t entry);
+static inline pgprot_t pmd_pgprot(pmd_t entry)
+{
+	unsigned long val = pmd_val(entry);
+
+	return __pgprot(val);
+}
 #endif
 
 static inline int pmd_present(pmd_t pmd)
@@ -732,26 +770,25 @@ static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 
 static inline void pmd_set(struct mm_struct *mm, pmd_t *pmdp, pte_t *ptep)
 {
-	unsigned long val = __pa((unsigned long) (ptep)) >> PMD_PADDR_SHIFT;
+	unsigned long val = __pa((unsigned long) (ptep));
 
 	pmd_val(*pmdp) = val;
 }
 
 #define pud_set(pudp, pmdp)	\
-	(pud_val(*(pudp)) = (__pa((unsigned long) (pmdp)) >> PGD_PADDR_SHIFT))
+	(pud_val(*(pudp)) = (__pa((unsigned long) (pmdp))))
 static inline unsigned long __pmd_page(pmd_t pmd)
 {
-	unsigned long paddr = pmd_val(pmd);
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	if (pmd_val(pmd) & PMD_ISHUGE)
-		paddr &= PMD_HUGE_PADDR;
-#endif
-	paddr <<= PMD_PADDR_SHIFT;
-	return ((unsigned long) __va(paddr));
+	pte_t pte = __pte(pmd_val(pmd));
+	unsigned long pfn;
+
+	pfn = pte_pfn(pte);
+
+	return ((unsigned long) __va(pfn << PAGE_SHIFT));
 }
 #define pmd_page(pmd) 			virt_to_page((void *)__pmd_page(pmd))
 #define pud_page_vaddr(pud)		\
-	((unsigned long) __va((pud_val(pud)<<PGD_PADDR_SHIFT)))
+	((unsigned long) __va(pud_val(pud)))
 #define pud_page(pud) 			virt_to_page((void *)pud_page_vaddr(pud))
 #define pmd_bad(pmd)			(0)
 #define pmd_clear(pmdp)			(pmd_val(*(pmdp)) = 0UL)
diff --git a/arch/sparc/include/asm/tsb.h b/arch/sparc/include/asm/tsb.h
index cc0432f..2230f80 100644
--- a/arch/sparc/include/asm/tsb.h
+++ b/arch/sparc/include/asm/tsb.h
@@ -147,100 +147,34 @@ extern struct tsb_phys_patch_entry __tsb_phys_patch, __tsb_phys_patch_end;
 	brz,pn		REG1, FAIL_LABEL; \
 	 sllx		VADDR, 64 - (PMD_SHIFT + PMD_BITS), REG2; \
 	srlx		REG2, 64 - PAGE_SHIFT, REG2; \
-	sllx		REG1, PGD_PADDR_SHIFT, REG1; \
 	andn		REG2, 0x7, REG2; \
 	ldxa		[REG1 + REG2] ASI_PHYS_USE_EC, REG1; \
 	brz,pn		REG1, FAIL_LABEL; \
 	 sllx		VADDR, 64 - PMD_SHIFT, REG2; \
 	srlx		REG2, 64 - PAGE_SHIFT, REG2; \
-	sllx		REG1, PMD_PADDR_SHIFT, REG1; \
 	andn		REG2, 0x7, REG2; \
 	add		REG1, REG2, REG1;
 
-	/* These macros exists only to make the PMD translator below
-	 * easier to read.  It hides the ELF section switch for the
-	 * sun4v code patching.
-	 */
-#define OR_PTE_BIT_1INSN(REG, NAME)			\
-661:	or		REG, _PAGE_##NAME##_4U, REG;	\
-	.section	.sun4v_1insn_patch, "ax";	\
-	.word		661b;				\
-	or		REG, _PAGE_##NAME##_4V, REG;	\
-	.previous;
-
-#define OR_PTE_BIT_2INSN(REG, TMP, NAME)		\
-661:	sethi		%hi(_PAGE_##NAME##_4U), TMP;	\
-	or		REG, TMP, REG;			\
-	.section	.sun4v_2insn_patch, "ax";	\
-	.word		661b;				\
-	mov		-1, TMP;			\
-	or		REG, _PAGE_##NAME##_4V, REG;	\
-	.previous;
-
-	/* Load into REG the PTE value for VALID, CACHE, and SZHUGE.
-	 *
-	 * We are fabricating an 8MB page using 2 4MB HW pages here.
-	 */
-#define BUILD_PTE_VALID_SZHUGE_CACHE(VADDR, PADDR_BITS, REG)		   \
-	sethi		%hi(4 * 1024 * 1024), REG;			   \
-	andn		PADDR_BITS, REG, PADDR_BITS;			   \
-	and		VADDR, REG, REG;				   \
-	or		PADDR_BITS, REG, PADDR_BITS;			   \
-661:	sethi		%uhi(_PAGE_VALID|_PAGE_SZHUGE_4U), REG;		   \
-	.section	.sun4v_1insn_patch, "ax";			   \
-	.word		661b;						   \
-	sethi		%uhi(_PAGE_VALID), REG;				   \
-	.previous;							   \
-	sllx		REG, 32, REG;					   \
-661:	or		REG, _PAGE_CP_4U|_PAGE_CV_4U, REG;		   \
-	.section	.sun4v_1insn_patch, "ax";			   \
-	.word		661b;						   \
-	or		REG, _PAGE_CP_4V|_PAGE_CV_4V|_PAGE_SZHUGE_4V, REG; \
-	.previous;
-
 	/* PMD has been loaded into REG1, interpret the value, seeing
 	 * if it is a HUGE PMD or a normal one.  If it is not valid
 	 * then jump to FAIL_LABEL.  If it is a HUGE PMD, and it
 	 * translates to a valid PTE, branch to PTE_LABEL.
 	 *
-	 * We translate the PMD by hand, one bit at a time,
-	 * constructing the huge PTE.
-	 *
-	 * So we construct the PTE in REG2 as follows:
-	 *
-	 * 1) Extract the PMD PFN from REG1 and place it into REG2.
-	 *
-	 * 2) Translate PMD protection bits in REG1 into REG2, one bit
-	 *    at a time using andcc tests on REG1 and OR's into REG2.
-	 *
-	 *    Only two bits to be concerned with here, EXEC and WRITE.
-	 *    Now REG1 is freed up and we can use it as a temporary.
-	 *
-	 * 3) Construct the VALID, CACHE, and page size PTE bits in
-	 *    REG1, OR with REG2 to form final PTE.
+	 * We have to propagate the 4MB bit of the virtual address
+	 * because we are fabricating 8MB pages using 4MB hw pages.
 	 */
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define USER_PGTABLE_CHECK_PMD_HUGE(VADDR, REG1, REG2, FAIL_LABEL, PTE_LABEL) \
-	brz,pn		REG1, FAIL_LABEL;				      \
-	 andcc		REG1, PMD_ISHUGE, %g0;				      \
-	be,pt		%xcc, 700f;					      \
-	 and		REG1, PMD_HUGE_PRESENT|PMD_HUGE_ACCESSED, REG2;	      \
-	cmp		REG2, PMD_HUGE_PRESENT|PMD_HUGE_ACCESSED;	      \
-	bne,pn		%xcc, FAIL_LABEL;				      \
-	 andn		REG1, PMD_HUGE_PROTBITS, REG2;			      \
-	sllx		REG2, PMD_PADDR_SHIFT, REG2;			      \
-	/* REG2 now holds PFN << PAGE_SHIFT */				      \
-	andcc		REG1, PMD_HUGE_WRITE, %g0;			      \
-	bne,a,pt	%xcc, 1f;					      \
-	 OR_PTE_BIT_1INSN(REG2, W);					      \
-1:	andcc		REG1, PMD_HUGE_EXEC, %g0;			      \
-	be,pt		%xcc, 1f;					      \
-	 nop;								      \
-	OR_PTE_BIT_2INSN(REG2, REG1, EXEC);				      \
-	/* REG1 can now be clobbered, build final PTE */		      \
-1:	BUILD_PTE_VALID_SZHUGE_CACHE(VADDR, REG2, REG1);		      \
-	ba,pt		%xcc, PTE_LABEL;				      \
-	 or		REG1, REG2, REG1;				      \
+	brz,pn		REG1, FAIL_LABEL;		\
+	 sethi		%uhi(_PAGE_PMD_HUGE), REG2;	\
+	sllx		REG2, 32, REG2;			\
+	andcc		REG1, REG2, %g0;		\
+	be,pt		%xcc, 700f;			\
+	 sethi		%hi(4 * 1024 * 1024), REG2;	\
+	andn		REG1, REG2, REG1;		\
+	and		VADDR, REG2, REG2;		\
+	brlz,pt		REG1, PTE_LABEL;		\
+	 or		REG1, REG2, REG1;		\
 700:
 #else
 #define USER_PGTABLE_CHECK_PMD_HUGE(VADDR, REG1, REG2, FAIL_LABEL, PTE_LABEL) \
@@ -265,13 +199,11 @@ extern struct tsb_phys_patch_entry __tsb_phys_patch, __tsb_phys_patch_end;
 	brz,pn		REG1, FAIL_LABEL; \
 	 sllx		VADDR, 64 - (PMD_SHIFT + PMD_BITS), REG2; \
 	srlx		REG2, 64 - PAGE_SHIFT, REG2; \
-	sllx		REG1, PGD_PADDR_SHIFT, REG1; \
 	andn		REG2, 0x7, REG2; \
 	ldxa		[REG1 + REG2] ASI_PHYS_USE_EC, REG1; \
 	USER_PGTABLE_CHECK_PMD_HUGE(VADDR, REG1, REG2, FAIL_LABEL, 800f) \
 	sllx		VADDR, 64 - PMD_SHIFT, REG2; \
 	srlx		REG2, 64 - PAGE_SHIFT, REG2; \
-	sllx		REG1, PMD_PADDR_SHIFT, REG1; \
 	andn		REG2, 0x7, REG2; \
 	add		REG1, REG2, REG1; \
 	ldxa		[REG1] ASI_PHYS_USE_EC, REG1; \
diff --git a/arch/sparc/mm/gup.c b/arch/sparc/mm/gup.c
index 01ee23d..c4d3da6 100644
--- a/arch/sparc/mm/gup.c
+++ b/arch/sparc/mm/gup.c
@@ -71,13 +71,12 @@ static int gup_huge_pmd(pmd_t *pmdp, pmd_t pmd, unsigned long addr,
 			int *nr)
 {
 	struct page *head, *page, *tail;
-	u32 mask;
 	int refs;
 
-	mask = PMD_HUGE_PRESENT;
-	if (write)
-		mask |= PMD_HUGE_WRITE;
-	if ((pmd_val(pmd) & mask) != mask)
+	if (!pmd_large(pmd))
+		return 0;
+
+	if (write && !pmd_write(pmd))
 		return 0;
 
 	refs = 0;
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index db35988..9c0a60d 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2602,121 +2602,21 @@ void pgtable_free(void *table, bool is_page)
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-static pmd_t pmd_set_protbits(pmd_t pmd, pgprot_t pgprot, bool for_modify)
-{
-	if (pgprot_val(pgprot) & _PAGE_VALID)
-		pmd_val(pmd) |= PMD_HUGE_PRESENT;
-	if (tlb_type = hypervisor) {
-		if (pgprot_val(pgprot) & _PAGE_WRITE_4V)
-			pmd_val(pmd) |= PMD_HUGE_WRITE;
-		if (pgprot_val(pgprot) & _PAGE_EXEC_4V)
-			pmd_val(pmd) |= PMD_HUGE_EXEC;
-
-		if (!for_modify) {
-			if (pgprot_val(pgprot) & _PAGE_ACCESSED_4V)
-				pmd_val(pmd) |= PMD_HUGE_ACCESSED;
-			if (pgprot_val(pgprot) & _PAGE_MODIFIED_4V)
-				pmd_val(pmd) |= PMD_HUGE_DIRTY;
-		}
-	} else {
-		if (pgprot_val(pgprot) & _PAGE_WRITE_4U)
-			pmd_val(pmd) |= PMD_HUGE_WRITE;
-		if (pgprot_val(pgprot) & _PAGE_EXEC_4U)
-			pmd_val(pmd) |= PMD_HUGE_EXEC;
-
-		if (!for_modify) {
-			if (pgprot_val(pgprot) & _PAGE_ACCESSED_4U)
-				pmd_val(pmd) |= PMD_HUGE_ACCESSED;
-			if (pgprot_val(pgprot) & _PAGE_MODIFIED_4U)
-				pmd_val(pmd) |= PMD_HUGE_DIRTY;
-		}
-	}
-
-	return pmd;
-}
-
-pmd_t pfn_pmd(unsigned long page_nr, pgprot_t pgprot)
-{
-	pmd_t pmd;
-
-	pmd_val(pmd) = (page_nr << ((PAGE_SHIFT - PMD_PADDR_SHIFT)));
-	pmd_val(pmd) |= PMD_ISHUGE;
-	pmd = pmd_set_protbits(pmd, pgprot, false);
-	return pmd;
-}
-
-pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
-{
-	pmd_val(pmd) &= ~(PMD_HUGE_PRESENT |
-			  PMD_HUGE_WRITE |
-			  PMD_HUGE_EXEC);
-	pmd = pmd_set_protbits(pmd, newprot, true);
-	return pmd;
-}
-
-pgprot_t pmd_pgprot(pmd_t entry)
-{
-	unsigned long pte = 0;
-
-	if (pmd_val(entry) & PMD_HUGE_PRESENT)
-		pte |= _PAGE_VALID;
-
-	if (tlb_type = hypervisor) {
-		if (pmd_val(entry) & PMD_HUGE_PRESENT)
-			pte |= _PAGE_PRESENT_4V;
-		if (pmd_val(entry) & PMD_HUGE_EXEC)
-			pte |= _PAGE_EXEC_4V;
-		if (pmd_val(entry) & PMD_HUGE_WRITE)
-			pte |= _PAGE_W_4V;
-		if (pmd_val(entry) & PMD_HUGE_ACCESSED)
-			pte |= _PAGE_ACCESSED_4V;
-		if (pmd_val(entry) & PMD_HUGE_DIRTY)
-			pte |= _PAGE_MODIFIED_4V;
-		pte |= _PAGE_CP_4V|_PAGE_CV_4V;
-	} else {
-		if (pmd_val(entry) & PMD_HUGE_PRESENT)
-			pte |= _PAGE_PRESENT_4U;
-		if (pmd_val(entry) & PMD_HUGE_EXEC)
-			pte |= _PAGE_EXEC_4U;
-		if (pmd_val(entry) & PMD_HUGE_WRITE)
-			pte |= _PAGE_W_4U;
-		if (pmd_val(entry) & PMD_HUGE_ACCESSED)
-			pte |= _PAGE_ACCESSED_4U;
-		if (pmd_val(entry) & PMD_HUGE_DIRTY)
-			pte |= _PAGE_MODIFIED_4U;
-		pte |= _PAGE_CP_4U|_PAGE_CV_4U;
-	}
-
-	return __pgprot(pte);
-}
-
 void update_mmu_cache_pmd(struct vm_area_struct *vma, unsigned long addr,
 			  pmd_t *pmd)
 {
 	unsigned long pte, flags;
 	struct mm_struct *mm;
 	pmd_t entry = *pmd;
-	pgprot_t prot;
 
 	if (!pmd_large(entry) || !pmd_young(entry))
 		return;
 
-	pte = (pmd_val(entry) & ~PMD_HUGE_PROTBITS);
-	pte <<= PMD_PADDR_SHIFT;
-	pte |= _PAGE_VALID;
+	pte = pmd_val(entry);
 
 	/* We are fabricating 8MB pages using 4MB real hw pages.  */
 	pte |= (addr & (1UL << REAL_HPAGE_SHIFT));
 
-	prot = pmd_pgprot(entry);
-
-	if (tlb_type = hypervisor)
-		pgprot_val(prot) |= _PAGE_SZHUGE_4V;
-	else
-		pgprot_val(prot) |= _PAGE_SZHUGE_4U;
-
-	pte |= pgprot_val(prot);
-
 	mm = vma->vm_mm;
 
 	spin_lock_irqsave(&mm->context.lock, flags);
diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
index 7a91f28..b64f95b 100644
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -161,8 +161,8 @@ void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 	if (mm = &init_mm)
 		return;
 
-	if ((pmd_val(pmd) ^ pmd_val(orig)) & PMD_ISHUGE) {
-		if (pmd_val(pmd) & PMD_ISHUGE)
+	if ((pmd_val(pmd) ^ pmd_val(orig)) & _PAGE_PMD_HUGE) {
+		if (pmd_val(pmd) & _PAGE_PMD_HUGE)
 			mm->context.huge_pte_count++;
 		else
 			mm->context.huge_pte_count--;
@@ -178,10 +178,11 @@ void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 	}
 
 	if (!pmd_none(orig)) {
-		bool exec = ((pmd_val(orig) & PMD_HUGE_EXEC) != 0);
+		pte_t orig_pte = __pte(pmd_val(orig));
+		bool exec = pte_exec(orig_pte);
 
 		addr &= HPAGE_MASK;
-		if (pmd_val(orig) & PMD_ISHUGE)
+		if (pmd_trans_huge(orig))
 			tlb_batch_add_one(mm, addr, exec);
 		else
 			tlb_batch_pmd_scan(mm, addr, orig, exec);
-- 
1.8.1.2

