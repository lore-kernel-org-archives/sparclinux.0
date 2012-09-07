From: David Miller <davem@davemloft.net>
Date: Fri, 07 Sep 2012 05:34:17 +0000
Subject: [PATCH 1/3] sparc64: Support 2GB and 16GB page sizes for kernel linear mappings.
Message-Id: <20120907.013417.70689328072654014.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


SPARC-T4 supports 2GB pages.

So convert kpte_linear_bitmap into an array of 2-bit values which
index into kern_linear_pte_xor.

Now kern_linear_pte_xor is used for 4 page size aligned regions,
4MB, 256MB, 2GB, and 16GB respectively.

Enabling 2GB pages is currently hardcoded using a check against
sun4v_chip_type.  In the future this will be done more cleanly
by interrogating the machine description which is the correct
way to determine this kind of thing.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/ktlb.S |   25 ++++-----
 arch/sparc/mm/init_64.c  |  137 +++++++++++++++++++++++++++++++++++++---------
 arch/sparc/mm/init_64.h  |    4 +-
 3 files changed, 122 insertions(+), 44 deletions(-)

diff --git a/arch/sparc/kernel/ktlb.S b/arch/sparc/kernel/ktlb.S
index 79f3103..0746e5e 100644
--- a/arch/sparc/kernel/ktlb.S
+++ b/arch/sparc/kernel/ktlb.S
@@ -188,31 +188,26 @@ valid_addr_bitmap_patch:
 	be,pn		%xcc, kvmap_dtlb_longpath
 
 2:	 sethi		%hi(kpte_linear_bitmap), %g2
-	or		%g2, %lo(kpte_linear_bitmap), %g2
 
 	/* Get the 256MB physical address index. */
 	sllx		%g4, 21, %g5
-	mov		1, %g7
+	or		%g2, %lo(kpte_linear_bitmap), %g2
 	srlx		%g5, 21 + 28, %g5
+	and		%g5, (32 - 1), %g7
 
-	/* Don't try this at home kids... this depends upon srlx
-	 * only taking the low 6 bits of the shift count in %g5.
-	 */
-	sllx		%g7, %g5, %g7
-
-	/* Divide by 64 to get the offset into the bitmask.  */
-	srlx		%g5, 6, %g5
+	/* Divide by 32 to get the offset into the bitmask.  */
+	srlx		%g5, 5, %g5
+	add		%g7, %g7, %g7
 	sllx		%g5, 3, %g5
 
-	/* kern_linear_pte_xor[((mask & bit) ? 1 : 0)] */
+	/* kern_linear_pte_xor[(mask >> shift) & 3)] */
 	ldx		[%g2 + %g5], %g2
-	andcc		%g2, %g7, %g0
+	srlx		%g2, %g7, %g7
 	sethi		%hi(kern_linear_pte_xor), %g5
+	and		%g7, 3, %g7
 	or		%g5, %lo(kern_linear_pte_xor), %g5
-	bne,a,pt	%xcc, 1f
-	 add		%g5, 8, %g5
-
-1:	ldx		[%g5], %g2
+	sllx		%g7, 3, %g7
+	ldx		[%g5 + %g7], %g2
 
 	.globl		kvmap_linear_patch
 kvmap_linear_patch:
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index d58edf5..c0fc25b 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -51,18 +51,34 @@
 
 #include "init_64.h"
 
-unsigned long kern_linear_pte_xor[2] __read_mostly;
+unsigned long kern_linear_pte_xor[4] __read_mostly;
 
-/* A bitmap, one bit for every 256MB of physical memory.  If the bit
- * is clear, we should use a 4MB page (via kern_linear_pte_xor[0]) else
- * if set we should use a 256MB page (via kern_linear_pte_xor[1]).
+/* A bitmap, two bits for every 256MB of physical memory.  These two
+ * bits determine what page size we use for kernel linear
+ * translations.  They form an index into kern_linear_pte_xor[].  The
+ * value in the indexed slot is XOR'd with the TLB miss virtual
+ * address to form the resulting TTE.  The mapping is:
+ *
+ *	0	=>	4MB
+ *	1	=>	256MB
+ *	2	=>	2GB
+ *	3	=>	16GB
+ *
+ * All sun4v chips support 256MB pages.  Only SPARC-T4 and later
+ * support 2GB pages, and hopefully future cpus will support the 16GB
+ * pages as well.  For slots 2 and 3, we encode a 256MB TTE xor there
+ * if these larger page sizes are not supported by the cpu.
+ *
+ * It would be nice to determine this from the machine description
+ * 'cpu' properties, but we need to have this table setup before the
+ * MDESC is initialized.
  */
 unsigned long kpte_linear_bitmap[KPTE_BITMAP_BYTES / sizeof(unsigned long)];
 
 #ifndef CONFIG_DEBUG_PAGEALLOC
-/* A special kernel TSB for 4MB and 256MB linear mappings.
- * Space is allocated for this right after the trap table
- * in arch/sparc64/kernel/head.S
+/* A special kernel TSB for 4MB, 256MB, 2GB and 16GB linear mappings.
+ * Space is allocated for this right after the trap table in
+ * arch/sparc64/kernel/head.S
  */
 extern struct tsb swapper_4m_tsb[KERNEL_TSB4M_NENTRIES];
 #endif
@@ -1358,32 +1374,75 @@ static unsigned long __ref kernel_map_range(unsigned long pstart,
 extern unsigned int kvmap_linear_patch[1];
 #endif /* CONFIG_DEBUG_PAGEALLOC */
 
-static void __init mark_kpte_bitmap(unsigned long start, unsigned long end)
+static void __init kpte_set_val(unsigned long index, unsigned long val)
 {
-	const unsigned long shift_256MB = 28;
-	const unsigned long mask_256MB = ((1UL << shift_256MB) - 1UL);
-	const unsigned long size_256MB = (1UL << shift_256MB);
+	unsigned long *ptr = kpte_linear_bitmap;
 
-	while (start < end) {
-		long remains;
+	val <<= ((index % (BITS_PER_LONG / 2)) * 2);
+	ptr += (index / (BITS_PER_LONG / 2));
 
-		remains = end - start;
-		if (remains < size_256MB)
-			break;
+	*ptr |= val;
+}
 
-		if (start & mask_256MB) {
-			start = (start + size_256MB) & ~mask_256MB;
-			continue;
-		}
+static const unsigned long kpte_shift_min = 28; /* 256MB */
+static const unsigned long kpte_shift_max = 34; /* 16GB */
+static const unsigned long kpte_shift_incr = 3;
 
-		while (remains >= size_256MB) {
-			unsigned long index = start >> shift_256MB;
+static unsigned long kpte_mark_using_shift(unsigned long start, unsigned long end,
+					   unsigned long shift)
+{
+	unsigned long size = (1UL << shift);
+	unsigned long mask = (size - 1UL);
+	unsigned long remains = end - start;
+	unsigned long val;
 
-			__set_bit(index, kpte_linear_bitmap);
+	if (remains < size || (start & mask))
+		return start;
 
-			start += size_256MB;
-			remains -= size_256MB;
+	/* VAL maps:
+	 *
+	 *	shift 28 --> kern_linear_pte_xor index 1
+	 *	shift 31 --> kern_linear_pte_xor index 2
+	 *	shift 34 --> kern_linear_pte_xor index 3
+	 */
+	val = ((shift - kpte_shift_min) / kpte_shift_incr) + 1;
+
+	remains &= ~mask;
+	if (shift != kpte_shift_max)
+		remains = size;
+
+	while (remains) {
+		unsigned long index = start >> kpte_shift_min;
+
+		kpte_set_val(index, val);
+
+		start += 1UL << kpte_shift_min;
+		remains -= 1UL << kpte_shift_min;
+	}
+
+	return start;
+}
+
+static void __init mark_kpte_bitmap(unsigned long start, unsigned long end)
+{
+	unsigned long smallest_size, smallest_mask;
+	unsigned long s;
+
+	smallest_size = (1UL << kpte_shift_min);
+	smallest_mask = (smallest_size - 1UL);
+
+	while (start < end) {
+		unsigned long orig_start = start;
+
+		for (s = kpte_shift_max; s >= kpte_shift_min; s -= kpte_shift_incr) {
+			start = kpte_mark_using_shift(start, end, s);
+
+			if (start != orig_start)
+				break;
 		}
+
+		if (start = orig_start)
+			start = (start + smallest_size) & ~smallest_mask;
 	}
 }
 
@@ -1577,13 +1636,15 @@ static void __init sun4v_ktsb_init(void)
 	ktsb_descr[0].resv = 0;
 
 #ifndef CONFIG_DEBUG_PAGEALLOC
-	/* Second KTSB for 4MB/256MB mappings.  */
+	/* Second KTSB for 4MB/256MB/2GB/16GB mappings.  */
 	ktsb_pa = (kern_base +
 		   ((unsigned long)&swapper_4m_tsb[0] - KERNBASE));
 
 	ktsb_descr[1].pgsz_idx = HV_PGSZ_IDX_4MB;
 	ktsb_descr[1].pgsz_mask = (HV_PGSZ_MASK_4MB |
 				   HV_PGSZ_MASK_256MB);
+	if (sun4v_chip_type = SUN4V_CHIP_NIAGARA4)
+		ktsb_descr[1].pgsz_mask |= HV_PGSZ_MASK_2GB;
 	ktsb_descr[1].assoc = 1;
 	ktsb_descr[1].num_ttes = KERNEL_TSB4M_NENTRIES;
 	ktsb_descr[1].ctx_idx = 0;
@@ -2110,6 +2171,7 @@ static void __init sun4u_pgprot_init(void)
 {
 	unsigned long page_none, page_shared, page_copy, page_readonly;
 	unsigned long page_exec_bit;
+	int i;
 
 	PAGE_KERNEL = __pgprot (_PAGE_PRESENT_4U | _PAGE_VALID |
 				_PAGE_CACHE_4U | _PAGE_P_4U |
@@ -2138,7 +2200,8 @@ static void __init sun4u_pgprot_init(void)
 				   _PAGE_P_4U | _PAGE_W_4U);
 
 	/* XXX Should use 256MB on Panther. XXX */
-	kern_linear_pte_xor[1] = kern_linear_pte_xor[0];
+	for (i = 1; i < 4; i++)
+		kern_linear_pte_xor[i] = kern_linear_pte_xor[0];
 
 	_PAGE_SZBITS = _PAGE_SZBITS_4U;
 	_PAGE_ALL_SZ_BITS =  (_PAGE_SZ4MB_4U | _PAGE_SZ512K_4U |
@@ -2164,6 +2227,7 @@ static void __init sun4v_pgprot_init(void)
 {
 	unsigned long page_none, page_shared, page_copy, page_readonly;
 	unsigned long page_exec_bit;
+	int i;
 
 	PAGE_KERNEL = __pgprot (_PAGE_PRESENT_4V | _PAGE_VALID |
 				_PAGE_CACHE_4V | _PAGE_P_4V |
@@ -2195,6 +2259,25 @@ static void __init sun4v_pgprot_init(void)
 	kern_linear_pte_xor[1] |= (_PAGE_CP_4V | _PAGE_CV_4V |
 				   _PAGE_P_4V | _PAGE_W_4V);
 
+	i = 2;
+
+	if (sun4v_chip_type = SUN4V_CHIP_NIAGARA4) {
+#ifdef CONFIG_DEBUG_PAGEALLOC
+		kern_linear_pte_xor[2] = (_PAGE_VALID | _PAGE_SZBITS_4V) ^
+			0xfffff80000000000UL;
+#else
+		kern_linear_pte_xor[2] = (_PAGE_VALID | _PAGE_SZ2GB_4V) ^
+			0xfffff80000000000UL;
+#endif
+		kern_linear_pte_xor[2] |= (_PAGE_CP_4V | _PAGE_CV_4V |
+					   _PAGE_P_4V | _PAGE_W_4V);
+
+		i = 3;
+	}
+
+	for (; i < 4; i++)
+		kern_linear_pte_xor[i] = kern_linear_pte_xor[i - 1];
+
 	pg_iobits = (_PAGE_VALID | _PAGE_PRESENT_4V | __DIRTY_BITS_4V |
 		     __ACCESS_BITS_4V | _PAGE_E_4V);
 
diff --git a/arch/sparc/mm/init_64.h b/arch/sparc/mm/init_64.h
index 3e1ac8b..0661aa6 100644
--- a/arch/sparc/mm/init_64.h
+++ b/arch/sparc/mm/init_64.h
@@ -8,12 +8,12 @@
 #define MAX_PHYS_ADDRESS	(1UL << 41UL)
 #define KPTE_BITMAP_CHUNK_SZ		(256UL * 1024UL * 1024UL)
 #define KPTE_BITMAP_BYTES	\
-	((MAX_PHYS_ADDRESS / KPTE_BITMAP_CHUNK_SZ) / 8)
+	((MAX_PHYS_ADDRESS / KPTE_BITMAP_CHUNK_SZ) / 4)
 #define VALID_ADDR_BITMAP_CHUNK_SZ	(4UL * 1024UL * 1024UL)
 #define VALID_ADDR_BITMAP_BYTES	\
 	((MAX_PHYS_ADDRESS / VALID_ADDR_BITMAP_CHUNK_SZ) / 8)
 
-extern unsigned long kern_linear_pte_xor[2];
+extern unsigned long kern_linear_pte_xor[4];
 extern unsigned long kpte_linear_bitmap[KPTE_BITMAP_BYTES / sizeof(unsigned long)];
 extern unsigned int sparc64_highest_unlocked_tlb_ent;
 extern unsigned long sparc64_kern_pri_context;
-- 
1.7.10.4

