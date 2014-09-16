From: Bob Picco <bpicco@meloft.net>
Date: Tue, 16 Sep 2014 16:52:17 +0000
Subject: [PATCH] sparc64: valid physical address bitmap
Message-Id: <1410886337-16116-1-git-send-email-bpicco@meloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: bob picco <bpicco@meloft.net>

We need to constrain the size of sparc64_valid_addr_bitmap. Historically
it has been sized according to maximum physical address and 4Mb DIMM size.
This was sufficient with older sparc64 before larger physical address bits.

This patch limits the bitmap to 64Kb by a smaller value for a physical
address bits which cover the vast majority of sparc64.

The last_valid_pfn is used to limit the physical address limit within
the ktlb miss for identity address checking and increase the megabyte shift
granularity of the check for a valid pfn.

An LDOM guest might have an issue with this depending on how the PA to
RA ranges were assigned by the control domain. Though this issue already
seems to exist for a granularity less than 4Mb which is the current
bitmap shift and test.

Cc: sparclinux@vger.kernel.org
Signed-off-by: Bob Picco <bob.picco@oracle.com>
---
 arch/sparc/include/asm/page_64.h    |    9 ++++
 arch/sparc/include/asm/pgtable_64.h |   10 +++-
 arch/sparc/kernel/ktlb.S            |    6 +++
 arch/sparc/kernel/vmlinux.lds.S     |   10 ++++
 arch/sparc/mm/init_64.c             |   86 ++++++++++++++++++++++++++++++++++-
 arch/sparc/mm/init_64.h             |    5 +-
 6 files changed, 119 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/include/asm/page_64.h b/arch/sparc/include/asm/page_64.h
index bf10998..93f6508 100644
--- a/arch/sparc/include/asm/page_64.h
+++ b/arch/sparc/include/asm/page_64.h
@@ -129,6 +129,15 @@ extern unsigned long PAGE_OFFSET;
  */
 #define MAX_PHYS_ADDRESS_BITS	47
 
+/* This represents a subset of the physical address bits. It is used
+ * to determine how the powerof2 for sparc64_valid_addr_bitmap is changed.
+ * Basically when max_pfn execeeds this shift value we increase the powerof2
+ * for sparc64_valid_addr_bitmap. So increase the power of two one for
+ * each bit above 41. For example, 51 bits of physical address bits would
+ * be ILOG2_4MB+10 - 4Gb DIMMs.
+ */
+#define	MAX_PHYS_ADDRESS_LOBITS	41
+
 /* These two shift counts are used when indexing sparc64_valid_addr_bitmap
  * and kpte_linear_bitmap.
  */
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 3770bf5..f86c658 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -74,13 +74,19 @@
 #include <linux/sched.h>
 
 extern unsigned long sparc64_valid_addr_bitmap[];
+/* These two externs are used specifically for sparc64_valid_addr_bitmap.*/
+extern unsigned int sparc64_lomem_ilog2, sparc64_phys_address_bits_shift;
 
 /* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
 static inline bool __kern_addr_valid(unsigned long paddr)
 {
-	if ((paddr >> MAX_PHYS_ADDRESS_BITS) != 0UL)
+	int bit_set;
+
+	if ((paddr >> sparc64_phys_address_bits_shift) != 0UL)
 		return false;
-	return test_bit(paddr >> ILOG2_4MB, sparc64_valid_addr_bitmap);
+	bit_set = test_bit(paddr >> sparc64_lomem_ilog2,
+		sparc64_valid_addr_bitmap);
+	return bit_set;
 }
 
 static inline bool kern_addr_valid(unsigned long addr)
diff --git a/arch/sparc/kernel/ktlb.S b/arch/sparc/kernel/ktlb.S
index 605d492..d613648 100644
--- a/arch/sparc/kernel/ktlb.S
+++ b/arch/sparc/kernel/ktlb.S
@@ -165,6 +165,9 @@
 	.section	.page_offset_shift_patch, "ax"
 	.word		661b
 	.previous
+	.section	.phys_max_ilog2_patch, "ax"
+	.word		661b
+	.previous
 
 	brnz,pn		%g2, kvmap_dtlb_longpath
 	 nop
@@ -187,6 +190,9 @@
 	.section	.page_offset_shift_patch, "ax"
 	.word		661b
 	.previous
+	.section	.phys_lomem_ilog2_patch, "ax"
+	.word		661b
+	.previous
 
 	srlx		%g2, 6, %g5
 	and		%g2, 63, %g2
diff --git a/arch/sparc/kernel/vmlinux.lds.S b/arch/sparc/kernel/vmlinux.lds.S
index 2da4f39..422ead9 100644
--- a/arch/sparc/kernel/vmlinux.lds.S
+++ b/arch/sparc/kernel/vmlinux.lds.S
@@ -127,6 +127,16 @@ SECTIONS
 		*(.page_offset_shift_patch)
 		__page_offset_shift_patch_end = .;
 	}
+	.phys_lomem_ilog2_patch : {
+		__phys_lomem_ilog2_patch = .;
+		*(.phys_lomem_ilog2_patch)
+		__phys_lomem_ilog2_patch_end = .;
+	}
+	.phys_max_ilog2_patch : {
+		__phys_max_ilog2_patch = .;
+		*(.phys_max_ilog2_patch)
+		__phys_max_ilog2_patch_end = .;
+	}
 	.swapper_phys_low_1mb_patch : {
 		__swapper_phys_low_1mb_patch = .;
 		*(.swapper_phys_low_1mb_patch)
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 1bf4643..4edda2c 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -165,6 +165,8 @@ static void __init read_obp_memory(const char *property,
 	     cmp_p64, NULL);
 }
 
+unsigned int sparc64_lomem_ilog2 = ILOG2_4MB;
+unsigned int sparc64_phys_address_bits_shift = MAX_PHYS_ADDRESS_BITS;
 unsigned long sparc64_valid_addr_bitmap[VALID_ADDR_BITMAP_BYTES /
 					sizeof(unsigned long)];
 EXPORT_SYMBOL(sparc64_valid_addr_bitmap);
@@ -1659,6 +1661,7 @@ static void __init setup_page_offset(void)
 		PAGE_OFFSET, max_phys_bits);
 
 	page_offset_shift_patch(max_phys_bits);
+	sparc64_phys_address_bits_shift = max_phys_bits;
 }
 
 static void __init tsb_phys_patch(void)
@@ -1946,12 +1949,35 @@ static void __init reduce_memory(phys_addr_t limit_ram)
 	}
 }
 
+/* We need to capture the opcode-s of two patches before setup_page_offset()
+ * modifies them. They are patched again by compute_bitmap_parameters.
+ * compute_bitmap_parameters requires the rs1 register which might be
+ * clobbered by setup_page_offset() patching.
+ */
+#define PHYS_PATCH_CAPTURE_OPCODES	2
+static unsigned int
+	phys_patch_capture_opcodes[PHYS_PATCH_CAPTURE_OPCODES] __initdata;
+static void __init phys_patch_fetch_opcode(unsigned int *p, int index)
+{
+	unsigned int *insn = (unsigned int *)(unsigned long)*p;
+
+	phys_patch_capture_opcodes[index] = *insn;
+}
+static void __init phys_patch_capture(void)
+{
+	extern unsigned int __phys_lomem_ilog2_patch, __phys_max_ilog2_patch;
+
+	phys_patch_fetch_opcode(&__phys_lomem_ilog2_patch, 0);
+	phys_patch_fetch_opcode(&__phys_max_ilog2_patch, 1);
+}
+
 void __init paging_init(void)
 {
 	unsigned long end_pfn, shift, phys_base;
 	unsigned long real_end, i;
 	int node;
 
+	phys_patch_capture();
 	setup_page_offset();
 
 	/* These build time checkes make sure that the dcache_dirty_cpu()
@@ -2193,7 +2219,8 @@ static void __init setup_valid_addr_bitmap_from_pavail(unsigned long *bitmap)
 
 				if (new_start <= old_start &&
 				    new_end >= (old_start + PAGE_SIZE)) {
-					set_bit(old_start >> ILOG2_4MB, bitmap);
+					set_bit(old_start >>
+						sparc64_lomem_ilog2, bitmap);
 					goto do_next_page;
 				}
 			}
@@ -2235,14 +2262,69 @@ static void __init register_page_bootmem_info(void)
 			register_page_bootmem_info_node(NODE_DATA(i));
 #endif
 }
+
+static void __init patch_phys_adjust(unsigned int *p, unsigned int opcode,
+				     unsigned int shift)
+{
+	unsigned int *insn = (unsigned int *)(unsigned long)*p;
+	unsigned int rs1 = opcode & (0x1fU << 14);
+	unsigned int rd = opcode & (0x1fU << 25);
+	unsigned int srlx = 0x81303000U;
+	unsigned int or = 0x80100000U;
+	unsigned int cnt, val;
+
+	/* This sets the shift to page_offset bits cleared from top
+	 * previously plus the new bitmap shift value. We aren't
+	 * modifying the concept of PAGE_OFFSET but preserving it.
+	 */
+	cnt = (64 - sparc64_phys_address_bits_shift) + shift;
+	if (cnt >= 64)
+		val = or | rd;
+	else
+		val = srlx | rd | rs1 | cnt;
+	*insn = val;
+
+	__asm__ __volatile__("flush	%0\n\t"
+		     : /* no outputs */
+		     : "r" (insn));
+}
+
+static void __init compute_bitmap_parameters(void)
+{
+	extern unsigned int __phys_lomem_ilog2_patch, __phys_max_ilog2_patch;
+	unsigned int last_valid_pfn_shift, max_phys_shift;
+
+	/* The maximum architecture physical limit is covered.*/
+	if (sparc64_phys_address_bits_shift <= MAX_PHYS_ADDRESS_LOBITS)
+		return;
+
+	last_valid_pfn_shift = __fls(last_valid_pfn);
+	if (!is_power_of_2(last_valid_pfn))
+		last_valid_pfn_shift++;
+	max_phys_shift = last_valid_pfn_shift + PAGE_SHIFT;
+
+	if (max_phys_shift > MAX_PHYS_ADDRESS_LOBITS)
+		sparc64_lomem_ilog2 = max_phys_shift -
+			MAX_PHYS_ADDRESS_LOBITS + sparc64_lomem_ilog2;
+
+	patch_phys_adjust(&__phys_lomem_ilog2_patch,
+		phys_patch_capture_opcodes[0], sparc64_lomem_ilog2);
+	patch_phys_adjust(&__phys_max_ilog2_patch,
+		phys_patch_capture_opcodes[1], max_phys_shift);
+	sparc64_phys_address_bits_shift = max_phys_shift;
+}
+
 void __init mem_init(void)
 {
 	unsigned long addr, last;
 
+	compute_bitmap_parameters();
+
 	addr = PAGE_OFFSET + kern_base;
 	last = PAGE_ALIGN(kern_size) + addr;
 	while (addr < last) {
-		set_bit(__pa(addr) >> ILOG2_4MB, sparc64_valid_addr_bitmap);
+		set_bit(__pa(addr) >> sparc64_lomem_ilog2,
+				sparc64_valid_addr_bitmap);
 		addr += PAGE_SIZE;
 	}
 
diff --git a/arch/sparc/mm/init_64.h b/arch/sparc/mm/init_64.h
index 0668b36..5c86c14 100644
--- a/arch/sparc/mm/init_64.h
+++ b/arch/sparc/mm/init_64.h
@@ -8,12 +8,11 @@
  */
 
 #define MAX_PHYS_ADDRESS	(1UL << MAX_PHYS_ADDRESS_BITS)
-#define KPTE_BITMAP_CHUNK_SZ		(256UL * 1024UL * 1024UL)
+#define KPTE_BITMAP_CHUNK_SZ	(256UL * 1024UL * 1024UL)
 #define KPTE_BITMAP_BYTES	\
 	((MAX_PHYS_ADDRESS / KPTE_BITMAP_CHUNK_SZ) / 4)
-#define VALID_ADDR_BITMAP_CHUNK_SZ	(4UL * 1024UL * 1024UL)
 #define VALID_ADDR_BITMAP_BYTES	\
-	((MAX_PHYS_ADDRESS / VALID_ADDR_BITMAP_CHUNK_SZ) / 8)
+	(1UL << (MAX_PHYS_ADDRESS_LOBITS - ILOG2_4MB - 3))
 
 extern unsigned long kern_linear_pte_xor[4];
 extern unsigned long kpte_linear_bitmap[KPTE_BITMAP_BYTES / sizeof(unsigned long)];
-- 
1.7.1

