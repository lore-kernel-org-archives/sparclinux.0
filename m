From: David Miller <davem@davemloft.net>
Date: Mon, 30 Sep 2013 16:32:06 +0000
Subject: [PATCH 6/9] sparc64: Make PAGE_OFFSET variable.
Message-Id: <20130930.123206.578491973911812532.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org


Choose PAGE_OFFSET dynamically based upon cpu type.

Original UltraSPARC-I (spitfire) chips only supported a 44-bit
virtual address space.

Newer chips (T4 and later) support 52-bit virtual addresses
and up to 47-bits of physical memory space.

Therefore we have to adjust PAGE_SIZE dynamically based upon
the capabilities of the chip.

Note that this change alone does not allow us to support > 43-bit
physical memory, to do that we need to re-arrange our page table
support.  The current encodings of the pmd_t and pgd_t pointers
restricts us to "32 + 11" =3D 43 bits.

This change can waste quite a bit of memory for the various tables.
In particular, a future change should work to size and allocate
kern_linear_bitmap[] and sparc64_valid_addr_bitmap[] dynamically.
This isn't easy as we really cannot take a TLB miss when accessing
kern_linear_bitmap[].  We'd have to lock it into the TLB or similar.

Signed-off-by: David S. Miller <davem@davemloft.net>
Acked-by: Bob Picco <bob.picco@oracle.com>
---
 arch/sparc/include/asm/page_64.h | 20 +++------
 arch/sparc/kernel/ktlb.S         | 30 ++++++++++---
 arch/sparc/kernel/vmlinux.lds.S  |  5 +++
 arch/sparc/lib/clear_page.S      |  4 +-
 arch/sparc/lib/copy_page.S       |  4 +-
 arch/sparc/mm/init_64.c          | 92 ++++++++++++++++++++++++++++++++++++=
++++
 arch/sparc/mm/ultra.S            | 12 +++---
 7 files changed, 138 insertions(+), 29 deletions(-)

diff --git a/arch/sparc/include/asm/page_64.h b/arch/sparc/include/asm/page=
_64.h
index 978ea6d..89e07fd 100644
--- a/arch/sparc/include/asm/page_64.h
+++ b/arch/sparc/include/asm/page_64.h
@@ -112,24 +112,16 @@ typedef pte_t *pgtable_t;
=20
 #include <asm-generic/memory_model.h>
=20
-#endif /* !(__ASSEMBLY__) */
-
-/* We used to stick this into a hard-coded global register (%g4)
- * but that does not make sense anymore.
- */
-#define MAX_SUPPORTED_PA_BITS	43
 #define PAGE_OFFSET_BY_BITS(X)	(-(_AC(1,UL) << (X)))
-#define PAGE_OFFSET		PAGE_OFFSET_BY_BITS(MAX_SUPPORTED_PA_BITS)
+extern unsigned long PAGE_OFFSET;
=20
-/* The "virtual" portion of PAGE_OFFSET, used to clip off the non-physical
- * bits of a linear kernel address.
- */
-#define PAGE_OFFSET_VA_BITS	(64 - MAX_SUPPORTED_PA_BITS)
+#endif /* !(__ASSEMBLY__) */
=20
-/* The actual number of physical memory address bits we support, this is
- * used to size various tables used to manage kernel TLB misses.
+/* The maximum number of physical memory address bits we support, this
+ * is used to size various tables used to manage kernel TLB misses and
+ * also the sparsemem code.
  */
-#define MAX_PHYS_ADDRESS_BITS	41
+#define MAX_PHYS_ADDRESS_BITS	47
=20
 /* These two shift counts are used when indexing sparc64_valid_addr_bitmap
  * and kpte_linear_bitmap.
diff --git a/arch/sparc/kernel/ktlb.S b/arch/sparc/kernel/ktlb.S
index 7ad46bc..542e96a 100644
--- a/arch/sparc/kernel/ktlb.S
+++ b/arch/sparc/kernel/ktlb.S
@@ -153,12 +153,19 @@ kvmap_dtlb_tsb4m_miss:
 	/* Clear the PAGE_OFFSET top virtual bits, shift
 	 * down to get PFN, and make sure PFN is in range.
 	 */
-	sllx		%g4, PAGE_OFFSET_VA_BITS, %g5
+661:	sllx		%g4, 0, %g5
+	.section	.page_offset_shift_patch, "ax"
+	.word		661b
+	.previous
=20
 	/* Check to see if we know about valid memory at the 4MB
 	 * chunk this physical address will reside within.
 	 */
-	srlx		%g5, PAGE_OFFSET_VA_BITS + MAX_PHYS_ADDRESS_BITS, %g2
+661:	srlx		%g5, MAX_PHYS_ADDRESS_BITS, %g2
+	.section	.page_offset_shift_patch, "ax"
+	.word		661b
+	.previous
+
 	brnz,pn		%g2, kvmap_dtlb_longpath
 	 nop
=20
@@ -176,7 +183,11 @@ valid_addr_bitmap_patch:
 	or		%g7, %lo(sparc64_valid_addr_bitmap), %g7
 	.previous
=20
-	srlx		%g5, PAGE_OFFSET_VA_BITS + ILOG2_4MB, %g2
+661:	srlx		%g5, ILOG2_4MB, %g2
+	.section	.page_offset_shift_patch, "ax"
+	.word		661b
+	.previous
+
 	srlx		%g2, 6, %g5
 	and		%g2, 63, %g2
 	sllx		%g5, 3, %g5
@@ -189,9 +200,18 @@ valid_addr_bitmap_patch:
 2:	 sethi		%hi(kpte_linear_bitmap), %g2
=20
 	/* Get the 256MB physical address index. */
-	sllx		%g4, PAGE_OFFSET_VA_BITS, %g5
+661:	sllx		%g4, 0, %g5
+	.section	.page_offset_shift_patch, "ax"
+	.word		661b
+	.previous
+
 	or		%g2, %lo(kpte_linear_bitmap), %g2
-	srlx		%g5, PAGE_OFFSET_VA_BITS + ILOG2_256MB, %g5
+
+661:	srlx		%g5, ILOG2_256MB, %g5
+	.section	.page_offset_shift_patch, "ax"
+	.word		661b
+	.previous
+
 	and		%g5, (32 - 1), %g7
=20
 	/* Divide by 32 to get the offset into the bitmask.  */
diff --git a/arch/sparc/kernel/vmlinux.lds.S b/arch/sparc/kernel/vmlinux.ld=
s.S
index 0bacceb..932ff90 100644
--- a/arch/sparc/kernel/vmlinux.lds.S
+++ b/arch/sparc/kernel/vmlinux.lds.S
@@ -122,6 +122,11 @@ SECTIONS
 		*(.swapper_4m_tsb_phys_patch)
 		__swapper_4m_tsb_phys_patch_end =3D .;
 	}
+	.page_offset_shift_patch : {
+		__page_offset_shift_patch =3D .;
+		*(.page_offset_shift_patch)
+		__page_offset_shift_patch_end =3D .;
+	}
 	.popc_3insn_patch : {
 		__popc_3insn_patch =3D .;
 		*(.popc_3insn_patch)
diff --git a/arch/sparc/lib/clear_page.S b/arch/sparc/lib/clear_page.S
index 77e531f..46272df 100644
--- a/arch/sparc/lib/clear_page.S
+++ b/arch/sparc/lib/clear_page.S
@@ -37,10 +37,10 @@ _clear_page:		/* %o0=DEst */
 	.globl		clear_user_page
 clear_user_page:	/* %o0=DEst, %o1=3Dvaddr */
 	lduw		[%g6 + TI_PRE_COUNT], %o2
-	sethi		%uhi(PAGE_OFFSET), %g2
+	sethi		%hi(PAGE_OFFSET), %g2
 	sethi		%hi(PAGE_SIZE), %o4
=20
-	sllx		%g2, 32, %g2
+	ldx		[%g2 + %lo(PAGE_OFFSET)], %g2
 	sethi		%hi(PAGE_KERNEL_LOCKED), %g3
=20
 	ldx		[%g3 + %lo(PAGE_KERNEL_LOCKED)], %g3
diff --git a/arch/sparc/lib/copy_page.S b/arch/sparc/lib/copy_page.S
index 4d2df32..dd16c61 100644
--- a/arch/sparc/lib/copy_page.S
+++ b/arch/sparc/lib/copy_page.S
@@ -46,10 +46,10 @@
 	.type		copy_user_page,#function
 copy_user_page:		/* %o0=DEst, %o1=3Dsrc, %o2=3Dvaddr */
 	lduw		[%g6 + TI_PRE_COUNT], %o4
-	sethi		%uhi(PAGE_OFFSET), %g2
+	sethi		%hi(PAGE_OFFSET), %g2
 	sethi		%hi(PAGE_SIZE), %o3
=20
-	sllx		%g2, 32, %g2
+	ldx		[%g2 + %lo(PAGE_OFFSET)], %g2
 	sethi		%hi(PAGE_KERNEL_LOCKED), %g3
=20
 	ldx		[%g3 + %lo(PAGE_KERNEL_LOCKED)], %g3
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index e295a5b..7a97b5a 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1557,6 +1557,96 @@ unsigned long __init find_ecache_flush_span(unsigned=
 long size)
 	return ~0UL;
 }
=20
+unsigned long PAGE_OFFSET;
+EXPORT_SYMBOL(PAGE_OFFSET);
+
+static void __init page_offset_shift_patch_one(unsigned int *insn, unsigne=
d long phys_bits)
+{
+	unsigned long final_shift;
+	unsigned int val =3D *insn;
+	unsigned int cnt;
+
+	/* We are patching in ilog2(max_supported_phys_address), and
+	 * we are doing so in a manner similar to a relocation addend.
+	 * That is, we are adding the shift value to whatever value
+	 * is in the shift instruction count field already.
+	 */
+	cnt =3D (val & 0x3f);
+	val &=3D ~0x3f;
+
+	/* If we are trying to shift >=3D 64 bits, clear the destination
+	 * register.  This can happen when phys_bits ends up being equal
+	 * to MAX_PHYS_ADDRESS_BITS.
+	 */
+	final_shift =3D (cnt + (64 - phys_bits));
+	if (final_shift >=3D 64) {
+		unsigned int rd =3D (val >> 25) & 0x1f;
+
+		val =3D 0x80100000 | (rd << 25);
+	} else {
+		val |=3D final_shift;
+	}
+	*insn =3D val;
+
+	__asm__ __volatile__("flush	%0"
+			     : /* no outputs */
+			     : "r" (insn));
+}
+
+static void __init page_offset_shift_patch(unsigned long phys_bits)
+{
+	extern unsigned int __page_offset_shift_patch;
+	extern unsigned int __page_offset_shift_patch_end;
+	unsigned int *p;
+
+	p =3D &__page_offset_shift_patch;
+	while (p < &__page_offset_shift_patch_end) {
+		unsigned int *insn =3D (unsigned int *)(unsigned long)*p;
+
+		page_offset_shift_patch_one(insn, phys_bits);
+
+		p++;
+	}
+}
+
+static void __init setup_page_offset(void)
+{
+	unsigned long max_phys_bits =3D 40;
+
+	if (tlb_type =3D cheetah || tlb_type =3D cheetah_plus) {
+		max_phys_bits =3D 42;
+	} else if (tlb_type =3D hypervisor) {
+		switch (sun4v_chip_type) {
+		case SUN4V_CHIP_NIAGARA1:
+		case SUN4V_CHIP_NIAGARA2:
+			max_phys_bits =3D 39;
+			break;
+		case SUN4V_CHIP_NIAGARA3:
+			max_phys_bits =3D 43;
+			break;
+		case SUN4V_CHIP_NIAGARA4:
+		case SUN4V_CHIP_NIAGARA5:
+		case SUN4V_CHIP_SPARC64X:
+		default:
+			max_phys_bits =3D 47;
+			break;
+		}
+	}
+
+	if (max_phys_bits > MAX_PHYS_ADDRESS_BITS) {
+		prom_printf("MAX_PHYS_ADDRESS_BITS is too small, need %lu\n",
+			    max_phys_bits);
+		prom_halt();
+	}
+
+	PAGE_OFFSET =3D PAGE_OFFSET_BY_BITS(max_phys_bits);
+
+	pr_info("PAGE_OFFSET is 0x%016lx (max_phys_bits =3D %lu)\n",
+		PAGE_OFFSET, max_phys_bits);
+
+	page_offset_shift_patch(max_phys_bits);
+}
+
 static void __init tsb_phys_patch(void)
 {
 	struct tsb_ldquad_phys_patch_entry *pquad;
@@ -1763,6 +1853,8 @@ void __init paging_init(void)
 	unsigned long real_end, i;
 	int node;
=20
+	setup_page_offset();
+
 	/* These build time checkes make sure that the dcache_dirty_cpu()
 	 * page->flags usage will work.
 	 *
diff --git a/arch/sparc/mm/ultra.S b/arch/sparc/mm/ultra.S
index 432aa0c..b4f4733 100644
--- a/arch/sparc/mm/ultra.S
+++ b/arch/sparc/mm/ultra.S
@@ -153,10 +153,10 @@ __spitfire_flush_tlb_mm_slow:
 	.globl		__flush_icache_page
 __flush_icache_page:	/* %o0 =3D phys_page */
 	srlx		%o0, PAGE_SHIFT, %o0
-	sethi		%uhi(PAGE_OFFSET), %g1
+	sethi		%hi(PAGE_OFFSET), %g1
 	sllx		%o0, PAGE_SHIFT, %o0
 	sethi		%hi(PAGE_SIZE), %g2
-	sllx		%g1, 32, %g1
+	ldx		[%g1 + %lo(PAGE_OFFSET)], %g1
 	add		%o0, %g1, %o0
 1:	subcc		%g2, 32, %g2
 	bne,pt		%icc, 1b
@@ -178,8 +178,8 @@ __flush_icache_page:	/* %o0 =3D phys_page */
 	.align		64
 	.globl		__flush_dcache_page
 __flush_dcache_page:	/* %o0=3Dkaddr, %o1=3Dflush_icache */
-	sethi		%uhi(PAGE_OFFSET), %g1
-	sllx		%g1, 32, %g1
+	sethi		%hi(PAGE_OFFSET), %g1
+	ldx		[%g1 + %lo(PAGE_OFFSET)], %g1
 	sub		%o0, %g1, %o0			! physical address
 	srlx		%o0, 11, %o0			! make D-cache TAG
 	sethi		%hi(1 << 14), %o2		! D-cache size
@@ -287,8 +287,8 @@ __cheetah_flush_tlb_pending:	/* 27 insns */
=20
 #ifdef DCACHE_ALIASING_POSSIBLE
 __cheetah_flush_dcache_page: /* 11 insns */
-	sethi		%uhi(PAGE_OFFSET), %g1
-	sllx		%g1, 32, %g1
+	sethi		%hi(PAGE_OFFSET), %g1
+	ldx		[%g1 + %lo(PAGE_OFFSET)], %g1
 	sub		%o0, %g1, %o0
 	sethi		%hi(PAGE_SIZE), %o4
 1:	subcc		%o4, (1 << 5), %o4
--=20
1.8.1.2

