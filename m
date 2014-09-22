From: David Miller <davem@davemloft.net>
Date: Mon, 22 Sep 2014 04:22:46 +0000
Subject: Re: [PATCH] sparc64: swapper_tsb and swapper_4m_tsb phys correction
Message-Id: <20140922.002246.858083360277042350.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1410886239-15774-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410886239-15774-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Picco <bpicco@meloft.net>
Date: Fri, 19 Sep 2014 15:57:31 -0400

> Hi,
> David Miller wrote:	[Fri Sep 19 2014, 03:28:46PM EDT]
>> From: David Miller <davem@davemloft.net>
>> Date: Thu, 18 Sep 2014 19:16:37 -0400 (EDT)
>> 
>> > I'm half-way done with the "use kernel page tables for everything"
>> > patch, and will post once I have something that at least work for
>> > me.
>> 
>> Bob, I ran into a major roadblock which is going to delay this work
>> a little bit.
> Okay.
>> 
>> In fact it pointed out a bug we introduced when increasing max phys
>> bits to 47.  We broke DEBUG_PAGEALLOC completely.  The issue is that
>> the page table layout only supports up to 43-bits.
> Oh bugger yes. I recall testing this when first introducting four level
> page table layout in late 2012 and early 2013. It just isn't an everyday
> thought but VERY nice to have.
>> 
>> I'll brain storm about this over the weekend.
> Me too.

Ok, here is what I have so far and I just got it working.

The long and short of it is that we have a 4-level page table
but only for the PAGE_OFFSET linear kernel mappings.

To the rest of the kernel this is transparent, because all
vmalloc et al. mappings have virtual addresses which index
to swapper_pg_dir.

The only thing I have to do is bring back 256MB et al. mapping usage
for suitable aligned PAGE_OFFSET linear areas.  It's only using 4MB
mappings at the moment.

diff --git a/arch/sparc/include/asm/page_64.h b/arch/sparc/include/asm/page_64.h
index bf10998..4af4e69 100644
--- a/arch/sparc/include/asm/page_64.h
+++ b/arch/sparc/include/asm/page_64.h
@@ -129,9 +129,6 @@ extern unsigned long PAGE_OFFSET;
  */
 #define MAX_PHYS_ADDRESS_BITS	47
 
-/* These two shift counts are used when indexing sparc64_valid_addr_bitmap
- * and kpte_linear_bitmap.
- */
 #define ILOG2_4MB		22
 #define ILOG2_256MB		28
 
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 3770bf5..d000904 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -61,6 +61,11 @@
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 #define PGDIR_BITS	(PAGE_SHIFT - 3)
 
+#define KPGD_SHIFT	(PAGE_SHIFT + (PAGE_SHIFT-3) + (PAGE_SHIFT-3) + PGDIR_BITS)
+#define KPGD_SIZE	(_AC(1,UL) << KPGD_SHIFT)
+#define KPGD_MASK	(~(KPGD_SIZE-1))
+#define KPGD_BITS	(PAGE_SHIFT - 3)
+
 #if (PGDIR_SHIFT + PGDIR_BITS) != 43
 #error Page table parameters do not cover virtual address space properly.
 #endif
@@ -73,27 +78,13 @@
 
 #include <linux/sched.h>
 
-extern unsigned long sparc64_valid_addr_bitmap[];
-
-/* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
-static inline bool __kern_addr_valid(unsigned long paddr)
-{
-	if ((paddr >> MAX_PHYS_ADDRESS_BITS) != 0UL)
-		return false;
-	return test_bit(paddr >> ILOG2_4MB, sparc64_valid_addr_bitmap);
-}
-
-static inline bool kern_addr_valid(unsigned long addr)
-{
-	unsigned long paddr = __pa(addr);
-
-	return __kern_addr_valid(paddr);
-}
+bool kern_addr_valid(unsigned long addr);
 
 /* Entries per page directory level. */
 #define PTRS_PER_PTE	(1UL << (PAGE_SHIFT-3))
 #define PTRS_PER_PMD	(1UL << PMD_BITS)
 #define PTRS_PER_PGD	(1UL << PGDIR_BITS)
+#define PTRS_PER_KPGD	(1UL << KPGD_BITS)
 
 /* Kernel has a separate 44bit address space. */
 #define FIRST_USER_ADDRESS	0
@@ -658,26 +649,26 @@ static inline unsigned long pmd_large(pmd_t pmd)
 	return pte_val(pte) & _PAGE_PMD_HUGE;
 }
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-static inline unsigned long pmd_young(pmd_t pmd)
+static inline unsigned long pmd_pfn(pmd_t pmd)
 {
 	pte_t pte = __pte(pmd_val(pmd));
 
-	return pte_young(pte);
+	return pte_pfn(pte);
 }
 
-static inline unsigned long pmd_write(pmd_t pmd)
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static inline unsigned long pmd_young(pmd_t pmd)
 {
 	pte_t pte = __pte(pmd_val(pmd));
 
-	return pte_write(pte);
+	return pte_young(pte);
 }
 
-static inline unsigned long pmd_pfn(pmd_t pmd)
+static inline unsigned long pmd_write(pmd_t pmd)
 {
 	pte_t pte = __pte(pmd_val(pmd));
 
-	return pte_pfn(pte);
+	return pte_write(pte);
 }
 
 static inline unsigned long pmd_trans_huge(pmd_t pmd)
@@ -771,13 +762,11 @@ static inline int pmd_present(pmd_t pmd)
  * the top bits outside of the range of any physical address size we
  * support are clear as well.  We also validate the physical itself.
  */
-#define pmd_bad(pmd)			((pmd_val(pmd) & ~PAGE_MASK) || \
-					 !__kern_addr_valid(pmd_val(pmd)))
+#define pmd_bad(pmd)			(pmd_val(pmd) & ~PAGE_MASK)
 
 #define pud_none(pud)			(!pud_val(pud))
 
-#define pud_bad(pud)			((pud_val(pud) & ~PAGE_MASK) || \
-					 !__kern_addr_valid(pud_val(pud)))
+#define pud_bad(pud)			(pud_val(pud) & ~PAGE_MASK)
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 void set_pmd_at(struct mm_struct *mm, unsigned long addr,
@@ -819,6 +808,8 @@ static inline unsigned long __pmd_page(pmd_t pmd)
 /* Same in both SUN4V and SUN4U.  */
 #define pte_none(pte) 			(!pte_val(pte))
 
+#define kpgd_index(address)	(((address) >> KPGD_SHIFT) & (PTRS_PER_KPGD - 1))
+
 /* to find an entry in a page-table-directory. */
 #define pgd_index(address)	(((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
 #define pgd_offset(mm, address)	((mm)->pgd + pgd_index(address))
@@ -897,6 +888,7 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 })
 #endif
 
+extern unsigned long kpgd_demux[PTRS_PER_PGD];
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 extern pmd_t swapper_low_pmd_dir[PTRS_PER_PMD];
 
diff --git a/arch/sparc/include/asm/tsb.h b/arch/sparc/include/asm/tsb.h
index 11c5047..e570894 100644
--- a/arch/sparc/include/asm/tsb.h
+++ b/arch/sparc/include/asm/tsb.h
@@ -133,27 +133,45 @@ extern struct tsb_phys_patch_entry __tsb_phys_patch, __tsb_phys_patch_end;
 	sub	TSB, 0x8, TSB;   \
 	TSB_STORE(TSB, TAG);
 
-	/* Do a kernel page table walk.  Leaves physical PTE pointer in
+	/* Do a kernel page table walk.  Leaves valid PTE value in
 	 * REG1.  Jumps to FAIL_LABEL on early page table walk termination.
 	 * VADDR will not be clobbered, but REG2 will.
 	 */
 #define KERN_PGTABLE_WALK(VADDR, REG1, REG2, FAIL_LABEL)	\
-	sethi		%hi(swapper_pg_dir), REG1; \
-	or		REG1, %lo(swapper_pg_dir), REG1; \
-	sllx		VADDR, 64 - (PGDIR_SHIFT + PGDIR_BITS), REG2; \
+	sethi		%hi(kpgd_demux), REG1; \
+	or		REG1, %lo(kpgd_demux), REG1; \
+	sllx		VADDR, 64 - (KPGD_SHIFT + KPGD_BITS), REG2; \
 	srlx		REG2, 64 - PAGE_SHIFT, REG2; \
 	andn		REG2, 0x7, REG2; \
 	ldx		[REG1 + REG2], REG1; \
 	brz,pn		REG1, FAIL_LABEL; \
+	 sllx		VADDR, 64 - (PGDIR_SHIFT + PGDIR_BITS), REG2; \
+	srlx		REG2, 64 - PAGE_SHIFT, REG2; \
+	andn		REG2, 0x7, REG2; \
+	ldxa		[REG1 + REG2] ASI_PHYS_USE_EC, REG1; \
+	brz,pn		REG1, FAIL_LABEL; \
 	 sllx		VADDR, 64 - (PMD_SHIFT + PMD_BITS), REG2; \
 	srlx		REG2, 64 - PAGE_SHIFT, REG2; \
 	andn		REG2, 0x7, REG2; \
 	ldxa		[REG1 + REG2] ASI_PHYS_USE_EC, REG1; \
+	sethi		%uhi(_PAGE_PMD_HUGE), REG2; \
 	brz,pn		REG1, FAIL_LABEL; \
-	 sllx		VADDR, 64 - PMD_SHIFT, REG2; \
+	 sllx		REG2, 32, REG2; \
+	andcc		REG1, REG2, %g0; \
+	be,pn		%xcc, 698f; \
+	 sethi		%hi(4 * 1024 * 1024), REG2; \
+	brgez,pn	REG1, FAIL_LABEL; \
+	 andn		REG1, REG2, REG1; \
+	and		VADDR, REG2, REG2; \
+	ba,pt		%xcc, 699f; \
+	 or		REG1, REG2, REG1; \
+698:	sllx		VADDR, 64 - PMD_SHIFT, REG2; \
 	srlx		REG2, 64 - PAGE_SHIFT, REG2; \
 	andn		REG2, 0x7, REG2; \
-	add		REG1, REG2, REG1;
+	ldxa		[REG1 + REG2] ASI_PHYS_USE_EC, REG1; \
+	brgez,pn	REG1, FAIL_LABEL; \
+	 nop; \
+699:
 
 	/* PMD has been loaded into REG1, interpret the value, seeing
 	 * if it is a HUGE PMD or a normal one.  If it is not valid
diff --git a/arch/sparc/kernel/ktlb.S b/arch/sparc/kernel/ktlb.S
index 605d492..94a1e66 100644
--- a/arch/sparc/kernel/ktlb.S
+++ b/arch/sparc/kernel/ktlb.S
@@ -47,14 +47,6 @@ kvmap_itlb_vmalloc_addr:
 	KERN_PGTABLE_WALK(%g4, %g5, %g2, kvmap_itlb_longpath)
 
 	TSB_LOCK_TAG(%g1, %g2, %g7)
-
-	/* Load and check PTE.  */
-	ldxa		[%g5] ASI_PHYS_USE_EC, %g5
-	mov		1, %g7
-	sllx		%g7, TSB_TAG_INVALID_BIT, %g7
-	brgez,a,pn	%g5, kvmap_itlb_longpath
-	 TSB_STORE(%g1, %g7)
-
 	TSB_WRITE(%g1, %g5, %g6)
 
 	/* fallthrough to TLB load */
@@ -118,6 +110,12 @@ kvmap_dtlb_obp:
 	ba,pt		%xcc, kvmap_dtlb_load
 	 nop
 
+kvmap_linear_early:
+	sethi		%hi(kern_linear_pte_xor), %g7
+	ldx		[%g7 + %lo(kern_linear_pte_xor)], %g2
+	ba,pt		%xcc, kvmap_dtlb_tsb4m_load
+	 xor		%g2, %g4, %g5
+
 	.align		32
 kvmap_dtlb_tsb4m_load:
 	TSB_LOCK_TAG(%g1, %g2, %g7)
@@ -146,105 +144,17 @@ kvmap_dtlb_4v:
 	/* Correct TAG_TARGET is already in %g6, check 4mb TSB.  */
 	KERN_TSB4M_LOOKUP_TL1(%g6, %g5, %g1, %g2, %g3, kvmap_dtlb_load)
 #endif
-	/* TSB entry address left in %g1, lookup linear PTE.
-	 * Must preserve %g1 and %g6 (TAG).
-	 */
-kvmap_dtlb_tsb4m_miss:
-	/* Clear the PAGE_OFFSET top virtual bits, shift
-	 * down to get PFN, and make sure PFN is in range.
-	 */
-661:	sllx		%g4, 0, %g5
-	.section	.page_offset_shift_patch, "ax"
-	.word		661b
-	.previous
-
-	/* Check to see if we know about valid memory at the 4MB
-	 * chunk this physical address will reside within.
+	/* Linear mapping TSB lookup failed.  Fallthrough to kernel
+	 * page table based lookup.
 	 */
-661:	srlx		%g5, MAX_PHYS_ADDRESS_BITS, %g2
-	.section	.page_offset_shift_patch, "ax"
-	.word		661b
-	.previous
-
-	brnz,pn		%g2, kvmap_dtlb_longpath
-	 nop
-
-	/* This unconditional branch and delay-slot nop gets patched
-	 * by the sethi sequence once the bitmap is properly setup.
-	 */
-	.globl		valid_addr_bitmap_insn
-valid_addr_bitmap_insn:
-	ba,pt		%xcc, 2f
-	 nop
-	.subsection	2
-	.globl		valid_addr_bitmap_patch
-valid_addr_bitmap_patch:
-	sethi		%hi(sparc64_valid_addr_bitmap), %g7
-	or		%g7, %lo(sparc64_valid_addr_bitmap), %g7
-	.previous
-
-661:	srlx		%g5, ILOG2_4MB, %g2
-	.section	.page_offset_shift_patch, "ax"
-	.word		661b
-	.previous
-
-	srlx		%g2, 6, %g5
-	and		%g2, 63, %g2
-	sllx		%g5, 3, %g5
-	ldx		[%g7 + %g5], %g5
-	mov		1, %g7
-	sllx		%g7, %g2, %g7
-	andcc		%g5, %g7, %g0
-	be,pn		%xcc, kvmap_dtlb_longpath
-
-2:	 sethi		%hi(kpte_linear_bitmap), %g2
-
-	/* Get the 256MB physical address index. */
-661:	sllx		%g4, 0, %g5
-	.section	.page_offset_shift_patch, "ax"
-	.word		661b
-	.previous
-
-	or		%g2, %lo(kpte_linear_bitmap), %g2
-
-661:	srlx		%g5, ILOG2_256MB, %g5
-	.section	.page_offset_shift_patch, "ax"
-	.word		661b
-	.previous
-
-	and		%g5, (32 - 1), %g7
-
-	/* Divide by 32 to get the offset into the bitmask.  */
-	srlx		%g5, 5, %g5
-	add		%g7, %g7, %g7
-	sllx		%g5, 3, %g5
-
-	/* kern_linear_pte_xor[(mask >> shift) & 3)] */
-	ldx		[%g2 + %g5], %g2
-	srlx		%g2, %g7, %g7
-	sethi		%hi(kern_linear_pte_xor), %g5
-	and		%g7, 3, %g7
-	or		%g5, %lo(kern_linear_pte_xor), %g5
-	sllx		%g7, 3, %g7
-	ldx		[%g5 + %g7], %g2
-
 	.globl		kvmap_linear_patch
 kvmap_linear_patch:
-	ba,pt		%xcc, kvmap_dtlb_tsb4m_load
-	 xor		%g2, %g4, %g5
+	ba,a,pt		%xcc, kvmap_linear_early
 
 kvmap_dtlb_vmalloc_addr:
 	KERN_PGTABLE_WALK(%g4, %g5, %g2, kvmap_dtlb_longpath)
 
 	TSB_LOCK_TAG(%g1, %g2, %g7)
-
-	/* Load and check PTE.  */
-	ldxa		[%g5] ASI_PHYS_USE_EC, %g5
-	mov		1, %g7
-	sllx		%g7, TSB_TAG_INVALID_BIT, %g7
-	brgez,a,pn	%g5, kvmap_dtlb_longpath
-	 TSB_STORE(%g1, %g7)
-
 	TSB_WRITE(%g1, %g5, %g6)
 
 	/* fallthrough to TLB load */
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 971ac36..b149872 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -75,7 +75,6 @@ unsigned long kern_linear_pte_xor[4] __read_mostly;
  * 'cpu' properties, but we need to have this table setup before the
  * MDESC is initialized.
  */
-unsigned long kpte_linear_bitmap[KPTE_BITMAP_BYTES / sizeof(unsigned long)];
 
 #ifndef CONFIG_DEBUG_PAGEALLOC
 /* A special kernel TSB for 4MB, 256MB, 2GB and 16GB linear mappings.
@@ -165,10 +164,6 @@ static void __init read_obp_memory(const char *property,
 	     cmp_p64, NULL);
 }
 
-unsigned long sparc64_valid_addr_bitmap[VALID_ADDR_BITMAP_BYTES /
-					sizeof(unsigned long)];
-EXPORT_SYMBOL(sparc64_valid_addr_bitmap);
-
 /* Kernel physical address base and size in bytes.  */
 unsigned long kern_base __read_mostly;
 unsigned long kern_size __read_mostly;
@@ -1369,9 +1364,45 @@ static unsigned long __init bootmem_init(unsigned long phys_base)
 static struct linux_prom64_registers pall[MAX_BANKS] __initdata;
 static int pall_ents __initdata;
 
-#ifdef CONFIG_DEBUG_PAGEALLOC
+bool kern_addr_valid(unsigned long addr)
+{
+	unsigned long pgd_pa;
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	pgd_pa = kpgd_demux[kpgd_index(addr)];
+	if (!pgd_pa)
+		return 0;
+
+	pgd = __va(pgd_pa);
+	pgd += pgd_index(addr);
+	if (pgd_none(*pgd))
+		return 0;
+
+	pud = pud_offset(pgd, addr);
+	if (pud_none(*pud))
+		return 0;
+
+	pmd = pmd_offset(pud, addr);
+	if (pmd_none(*pmd))
+		return 0;
+
+	if (pmd_large(*pmd))
+		return pfn_valid(pmd_pfn(*pmd));
+
+	pte = pte_offset_kernel(pmd, addr);
+	if (pte_none(*pte))
+		return 0;
+
+	return pfn_valid(pte_pfn(*pte));
+}
+EXPORT_SYMBOL(kern_addr_valid);
+
 static unsigned long __ref kernel_map_range(unsigned long pstart,
-					    unsigned long pend, pgprot_t prot)
+					    unsigned long pend, pgprot_t prot,
+					    bool use_huge)
 {
 	unsigned long vstart = PAGE_OFFSET + pstart;
 	unsigned long vend = PAGE_OFFSET + pend;
@@ -1385,11 +1416,23 @@ static unsigned long __ref kernel_map_range(unsigned long pstart,
 
 	while (vstart < vend) {
 		unsigned long this_end, paddr = __pa(vstart);
-		pgd_t *pgd = pgd_offset_k(vstart);
+		unsigned long kpgd_demux_index, pgd_pa;
+		pgd_t *pgd;
 		pud_t *pud;
 		pmd_t *pmd;
 		pte_t *pte;
 
+		kpgd_demux_index = kpgd_index(vstart);
+
+		pgd_pa = kpgd_demux[kpgd_demux_index];
+		if (!pgd_pa) {
+			pgd = __alloc_bootmem(PAGE_SIZE, PAGE_SIZE, PAGE_SIZE);
+			alloc_bytes += PAGE_SIZE;
+			kpgd_demux[kpgd_demux_index] = __pa(pgd);
+		} else
+			pgd = __va(pgd_pa);
+		pgd += pgd_index(vstart);
+
 		pud = pud_offset(pgd, vstart);
 		if (pud_none(*pud)) {
 			pmd_t *new;
@@ -1403,6 +1446,14 @@ static unsigned long __ref kernel_map_range(unsigned long pstart,
 		if (!pmd_present(*pmd)) {
 			pte_t *new;
 
+			if (use_huge) {
+				u64 pte_val = vstart ^ kern_linear_pte_xor[0];
+
+				pte_val |= _PAGE_PMD_HUGE;
+				pmd_val(*pmd) = pte_val;
+				vstart += PMD_SIZE;
+				continue;
+			}
 			new = __alloc_bootmem(PAGE_SIZE, PAGE_SIZE, PAGE_SIZE);
 			alloc_bytes += PAGE_SIZE;
 			pmd_populate_kernel(&init_mm, pmd, new);
@@ -1426,99 +1477,15 @@ static unsigned long __ref kernel_map_range(unsigned long pstart,
 }
 
 extern unsigned int kvmap_linear_patch[1];
-#endif /* CONFIG_DEBUG_PAGEALLOC */
-
-static void __init kpte_set_val(unsigned long index, unsigned long val)
-{
-	unsigned long *ptr = kpte_linear_bitmap;
-
-	val <<= ((index % (BITS_PER_LONG / 2)) * 2);
-	ptr += (index / (BITS_PER_LONG / 2));
-
-	*ptr |= val;
-}
-
-static const unsigned long kpte_shift_min = 28; /* 256MB */
-static const unsigned long kpte_shift_max = 34; /* 16GB */
-static const unsigned long kpte_shift_incr = 3;
-
-static unsigned long kpte_mark_using_shift(unsigned long start, unsigned long end,
-					   unsigned long shift)
-{
-	unsigned long size = (1UL << shift);
-	unsigned long mask = (size - 1UL);
-	unsigned long remains = end - start;
-	unsigned long val;
-
-	if (remains < size || (start & mask))
-		return start;
-
-	/* VAL maps:
-	 *
-	 *	shift 28 --> kern_linear_pte_xor index 1
-	 *	shift 31 --> kern_linear_pte_xor index 2
-	 *	shift 34 --> kern_linear_pte_xor index 3
-	 */
-	val = ((shift - kpte_shift_min) / kpte_shift_incr) + 1;
-
-	remains &= ~mask;
-	if (shift != kpte_shift_max)
-		remains = size;
-
-	while (remains) {
-		unsigned long index = start >> kpte_shift_min;
-
-		kpte_set_val(index, val);
-
-		start += 1UL << kpte_shift_min;
-		remains -= 1UL << kpte_shift_min;
-	}
-
-	return start;
-}
-
-static void __init mark_kpte_bitmap(unsigned long start, unsigned long end)
-{
-	unsigned long smallest_size, smallest_mask;
-	unsigned long s;
-
-	smallest_size = (1UL << kpte_shift_min);
-	smallest_mask = (smallest_size - 1UL);
-
-	while (start < end) {
-		unsigned long orig_start = start;
-
-		for (s = kpte_shift_max; s >= kpte_shift_min; s -= kpte_shift_incr) {
-			start = kpte_mark_using_shift(start, end, s);
-
-			if (start != orig_start)
-				break;
-		}
-
-		if (start = orig_start)
-			start = (start + smallest_size) & ~smallest_mask;
-	}
-}
-
-static void __init init_kpte_bitmap(void)
-{
-	unsigned long i;
-
-	for (i = 0; i < pall_ents; i++) {
-		unsigned long phys_start, phys_end;
-
-		phys_start = pall[i].phys_addr;
-		phys_end = phys_start + pall[i].reg_size;
-
-		mark_kpte_bitmap(phys_start, phys_end);
-	}
-}
 
 static void __init kernel_physical_mapping_init(void)
 {
-#ifdef CONFIG_DEBUG_PAGEALLOC
 	unsigned long i, mem_alloced = 0UL;
+	bool use_huge = true;
 
+#ifdef CONFIG_DEBUG_PAGEALLOC
+	use_huge = false;
+#endif
 	for (i = 0; i < pall_ents; i++) {
 		unsigned long phys_start, phys_end;
 
@@ -1526,7 +1493,7 @@ static void __init kernel_physical_mapping_init(void)
 		phys_end = phys_start + pall[i].reg_size;
 
 		mem_alloced += kernel_map_range(phys_start, phys_end,
-						PAGE_KERNEL);
+						PAGE_KERNEL, use_huge);
 	}
 
 	printk("Allocated %ld bytes for kernel page tables.\n",
@@ -1536,7 +1503,6 @@ static void __init kernel_physical_mapping_init(void)
 	flushi(&kvmap_linear_patch[0]);
 
 	__flush_tlb_all();
-#endif
 }
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
@@ -1546,7 +1512,7 @@ void kernel_map_pages(struct page *page, int numpages, int enable)
 	unsigned long phys_end = phys_start + (numpages * PAGE_SIZE);
 
 	kernel_map_range(phys_start, phys_end,
-			 (enable ? PAGE_KERNEL : __pgprot(0)));
+			 (enable ? PAGE_KERNEL : __pgprot(0)), false);
 
 	flush_tsb_kernel_range(PAGE_OFFSET + phys_start,
 			       PAGE_OFFSET + phys_end);
@@ -1878,6 +1844,7 @@ static void __init sun4v_linear_pte_xor_finalize(void)
 /* paging_init() sets up the page tables */
 
 static unsigned long last_valid_pfn;
+unsigned long kpgd_demux[PTRS_PER_PGD];
 pgd_t swapper_pg_dir[PTRS_PER_PGD];
 
 static void sun4u_pgprot_init(void);
@@ -2027,17 +1994,16 @@ void __init paging_init(void)
 	 * work.
 	 */
 	init_mm.pgd += ((shift) / (sizeof(pgd_t)));
+	kpgd_demux[0] = __pa(init_mm.pgd);
 	
 	memset(swapper_low_pmd_dir, 0, sizeof(swapper_low_pmd_dir));
 
 	/* Now can init the kernel/bad page tables. */
 	pud_set(pud_offset(&swapper_pg_dir[0], 0),
 		swapper_low_pmd_dir + (shift / sizeof(pgd_t)));
-	
+
 	inherit_prom_mappings();
 	
-	init_kpte_bitmap();
-
 	/* Ok, we can use our TLB miss and window trap handlers safely.  */
 	setup_tba();
 
@@ -2144,70 +2110,6 @@ int page_in_phys_avail(unsigned long paddr)
 	return 0;
 }
 
-static struct linux_prom64_registers pavail_rescan[MAX_BANKS] __initdata;
-static int pavail_rescan_ents __initdata;
-
-/* Certain OBP calls, such as fetching "available" properties, can
- * claim physical memory.  So, along with initializing the valid
- * address bitmap, what we do here is refetch the physical available
- * memory list again, and make sure it provides at least as much
- * memory as 'pavail' does.
- */
-static void __init setup_valid_addr_bitmap_from_pavail(unsigned long *bitmap)
-{
-	int i;
-
-	read_obp_memory("available", &pavail_rescan[0], &pavail_rescan_ents);
-
-	for (i = 0; i < pavail_ents; i++) {
-		unsigned long old_start, old_end;
-
-		old_start = pavail[i].phys_addr;
-		old_end = old_start + pavail[i].reg_size;
-		while (old_start < old_end) {
-			int n;
-
-			for (n = 0; n < pavail_rescan_ents; n++) {
-				unsigned long new_start, new_end;
-
-				new_start = pavail_rescan[n].phys_addr;
-				new_end = new_start +
-					pavail_rescan[n].reg_size;
-
-				if (new_start <= old_start &&
-				    new_end >= (old_start + PAGE_SIZE)) {
-					set_bit(old_start >> ILOG2_4MB, bitmap);
-					goto do_next_page;
-				}
-			}
-
-			prom_printf("mem_init: Lost memory in pavail\n");
-			prom_printf("mem_init: OLD start[%lx] size[%lx]\n",
-				    pavail[i].phys_addr,
-				    pavail[i].reg_size);
-			prom_printf("mem_init: NEW start[%lx] size[%lx]\n",
-				    pavail_rescan[i].phys_addr,
-				    pavail_rescan[i].reg_size);
-			prom_printf("mem_init: Cannot continue, aborting.\n");
-			prom_halt();
-
-		do_next_page:
-			old_start += PAGE_SIZE;
-		}
-	}
-}
-
-static void __init patch_tlb_miss_handler_bitmap(void)
-{
-	extern unsigned int valid_addr_bitmap_insn[];
-	extern unsigned int valid_addr_bitmap_patch[];
-
-	valid_addr_bitmap_insn[1] = valid_addr_bitmap_patch[1];
-	mb();
-	valid_addr_bitmap_insn[0] = valid_addr_bitmap_patch[0];
-	flushi(&valid_addr_bitmap_insn[0]);
-}
-
 static void __init register_page_bootmem_info(void)
 {
 #ifdef CONFIG_NEED_MULTIPLE_NODES
@@ -2220,18 +2122,6 @@ static void __init register_page_bootmem_info(void)
 }
 void __init mem_init(void)
 {
-	unsigned long addr, last;
-
-	addr = PAGE_OFFSET + kern_base;
-	last = PAGE_ALIGN(kern_size) + addr;
-	while (addr < last) {
-		set_bit(__pa(addr) >> ILOG2_4MB, sparc64_valid_addr_bitmap);
-		addr += PAGE_SIZE;
-	}
-
-	setup_valid_addr_bitmap_from_pavail(sparc64_valid_addr_bitmap);
-	patch_tlb_miss_handler_bitmap();
-
 	high_memory = __va(last_valid_pfn << PAGE_SHIFT);
 
 	register_page_bootmem_info();
diff --git a/arch/sparc/mm/init_64.h b/arch/sparc/mm/init_64.h
index 0668b36..29ff73f 100644
--- a/arch/sparc/mm/init_64.h
+++ b/arch/sparc/mm/init_64.h
@@ -8,15 +8,8 @@
  */
 
 #define MAX_PHYS_ADDRESS	(1UL << MAX_PHYS_ADDRESS_BITS)
-#define KPTE_BITMAP_CHUNK_SZ		(256UL * 1024UL * 1024UL)
-#define KPTE_BITMAP_BYTES	\
-	((MAX_PHYS_ADDRESS / KPTE_BITMAP_CHUNK_SZ) / 4)
-#define VALID_ADDR_BITMAP_CHUNK_SZ	(4UL * 1024UL * 1024UL)
-#define VALID_ADDR_BITMAP_BYTES	\
-	((MAX_PHYS_ADDRESS / VALID_ADDR_BITMAP_CHUNK_SZ) / 8)
 
 extern unsigned long kern_linear_pte_xor[4];
-extern unsigned long kpte_linear_bitmap[KPTE_BITMAP_BYTES / sizeof(unsigned long)];
 extern unsigned int sparc64_highest_unlocked_tlb_ent;
 extern unsigned long sparc64_kern_pri_context;
 extern unsigned long sparc64_kern_pri_nuc_bits;
