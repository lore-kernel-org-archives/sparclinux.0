From: Bob Picco <bpicco@meloft.net>
Date: Tue, 16 Sep 2014 16:53:24 +0000
Subject: [PATCH] sparc64: vmemmap boot sizing
Message-Id: <1410886404-16359-1-git-send-email-bpicco@meloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: bob picco <bpicco@meloft.net>

This patch attempts to accomodate the coarse grain memory controller unit
(MCU) in Niagara5 and later generations. This is achieved by having a root
array which is array of pointers to arrays of TTE-s for vmemmap. The ktlb
paths are patched when using the root array.

Older sparc64 should have the net effect of being treated similar to before
the introduction of Niagara5 and Athena which caused an increase in memory
footprint of static sparc64 related memory management items.

Cc: sparclinux@vger.kernel.org
Signed-off-by: Bob Picco <bob.picco@oracle.com>
---
 arch/sparc/include/asm/page_64.h |   20 +++
 arch/sparc/kernel/ktlb.S         |   29 ++++-
 arch/sparc/kernel/vmlinux.lds.S  |   10 ++
 arch/sparc/mm/init_64.c          |  278 +++++++++++++++++++++++++++++---------
 arch/sparc/mm/init_64.h          |    2 +-
 5 files changed, 267 insertions(+), 72 deletions(-)

diff --git a/arch/sparc/include/asm/page_64.h b/arch/sparc/include/asm/page_64.h
index 93f6508..172733f 100644
--- a/arch/sparc/include/asm/page_64.h
+++ b/arch/sparc/include/asm/page_64.h
@@ -138,6 +138,26 @@ extern unsigned long PAGE_OFFSET;
  */
 #define	MAX_PHYS_ADDRESS_LOBITS	41
 
+#define NR_PHYS_ADDRESS_LOBITS_PAGES \
+		(1UL << (MAX_PHYS_ADDRESS_LOBITS - PAGE_SHIFT))
+#define	NR_VMEMMAP_ROOT_ENTRIES	\
+		(1UL << (MAX_PHYS_ADDRESS_BITS - MAX_PHYS_ADDRESS_LOBITS))
+/* Virtual space covered by this number of chunks in vmemmap terms.
+ * This assumes sizeof (struct page) = 1<<6.
+ */
+#define	NR_CHUNKS_BITS	(MAX_PHYS_ADDRESS_BITS - MAX_PHYS_ADDRESS_LOBITS)
+#define NR_CHUNKS_SHIFT	(MAX_PHYS_ADDRESS_LOBITS - PAGE_SHIFT + 6)
+#define	NR_CHUNKS_MASK	(~((1UL << NR_CHUNKS_SHIFT) - 1))
+
+/* We align the memblock allocation to 1Mb. We form the address with
+ * a right shift physical address of NR_VMEMMAP_ROOT_SHIFT, deposit into a
+ * sethi with imm22 which and then left shift the imm22 NR_VMEMMAP_ROOT_SHIFT.
+ */
+#define	NR_VMEMMAP_ROOT_ALIGN	(1UL << 20)
+#define NR_VMEMMAP_ROOT_SHIFT	10
+#define NR_VMEMMAP_ROOT_MAXADDR (1UL << 42)
+
+
 /* These two shift counts are used when indexing sparc64_valid_addr_bitmap
  * and kpte_linear_bitmap.
  */
diff --git a/arch/sparc/kernel/ktlb.S b/arch/sparc/kernel/ktlb.S
index d613648..70f823b 100644
--- a/arch/sparc/kernel/ktlb.S
+++ b/arch/sparc/kernel/ktlb.S
@@ -281,14 +281,30 @@
 	 mov		%g5, %g3
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
-kvmap_vmemmap:
+	.globl		kvmap_vmemmap_long
+	/* Should you move the label below, then move the sethi. */
+kvmap_vmemmap_long:
+	sethi		0, %g1
 	sub		%g4, %g5, %g5
-	srlx		%g5, ILOG2_4MB, %g5
+	sllx		%g1, NR_VMEMMAP_ROOT_SHIFT, %g1
+	srlx		%g5, (NR_CHUNKS_SHIFT-3), %g2
+	andn		%g2, 7, %g2
+	sllx		%g5, (64 - NR_CHUNKS_SHIFT), %g5
+	srlx		%g5, (64 - NR_CHUNKS_SHIFT + ILOG2_4MB - 3), %g5
+	ba,pt		%xcc, 1f
+	ldxa		[%g1 + %g2] ASI_PHYS_USE_EC, %g1
+kvmap_vmemmap:
 	sethi		%hi(vmemmap_table), %g1
-	sllx		%g5, 3, %g5
 	or		%g1, %lo(vmemmap_table), %g1
+	sub		%g4, %g5, %g5
+	srlx            %g5, ILOG2_4MB - 3, %g5
+1:	andn		%g5, 7, %g5
 	ba,pt		%xcc, kvmap_dtlb_load
-	 ldx		[%g1 + %g5], %g5
+661:	 ldx		[%g1 + %g5], %g5
+	.section	.kvmap_vmemmap_phys_load_patch, "ax"
+	.word		661b
+	 ldxa		[%g1 + %g5] ASI_PHYS_USE_EC, %g5
+	.previous
 #endif
 
 kvmap_dtlb_nonlinear:
@@ -303,7 +319,10 @@
 	mov		(VMEMMAP_BASE >> 40), %g5
 	sllx		%g5, 40, %g5
 	cmp		%g4,%g5
-	bgeu,pn		%xcc, kvmap_vmemmap
+661:	bgeu,pn		%xcc, kvmap_vmemmap
+	.section	.kvmap_vmemmap_root_patch, "ax"
+	.word		661b
+	.previous
 	 nop
 #endif
 
diff --git a/arch/sparc/kernel/vmlinux.lds.S b/arch/sparc/kernel/vmlinux.lds.S
index 422ead9..b8e6e0d 100644
--- a/arch/sparc/kernel/vmlinux.lds.S
+++ b/arch/sparc/kernel/vmlinux.lds.S
@@ -137,6 +137,16 @@ SECTIONS
 		*(.phys_max_ilog2_patch)
 		__phys_max_ilog2_patch_end = .;
 	}
+	.kvmap_vmemmap_phys_load_patch :{
+		__kvmap_vmemmap_phys_load_patch = .;
+		*(.kvmap_vmemmap_phys_load_patch)
+		__kvmap_vmemmap_phys_load_patch_end = .;
+	}
+	.kvmap_vmemmap_root_patch :{
+		__kvmap_vmemmap_root_patch = .;
+		*(.kvmap_vmemmap_root_patch)
+		__kvmap_vmemmap_root_patch_end = .;
+	}
 	.swapper_phys_low_1mb_patch : {
 		__swapper_phys_low_1mb_patch = .;
 		*(.swapper_phys_low_1mb_patch)
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 4edda2c..24ca110 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1328,6 +1328,217 @@ static int bootmem_init_numa(void)
 
 #endif
 
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+static unsigned int __meminitdata vmemmap_table_root_entries;
+unsigned long vmemmap_table[VMEMMAP_SIZE];
+unsigned long *vmemmap_table_root;
+static bool __meminitdata vmemmap_table_taken;
+static long __meminitdata addr_start, addr_end;
+static int __meminitdata node_start;
+
+static unsigned long *vmemmap_table_chunk(unsigned long addr)
+{
+	unsigned long *chunk = vmemmap_table + (addr >> VMEMMAP_CHUNK_SHIFT);
+
+	return chunk;
+}
+
+static unsigned long __init vmemmap_alloc_root_entry(unsigned int root_index,
+						     int node)
+{
+	unsigned long root_entry = 0UL;
+
+	if (vmemmap_table_taken = false)
+		root_entry = kern_base +
+			((unsigned long) &vmemmap_table[0] - KERNBASE);
+	else {
+		void *root_entry_addr;
+
+		root_entry_addr = vmemmap_alloc_block(VMEMMAP_SIZE *
+					sizeof(unsigned long), node);
+		if (root_entry_addr)
+			root_entry = __pa(root_entry_addr);
+	}
+	if (root_entry = 0UL) {
+		prom_printf("vmemmap_alloc_root_entry: Allocation failed.\n");
+		prom_halt();
+	}
+	vmemmap_table_taken = true;
+	return root_entry;
+}
+
+static unsigned long __init *vmemmap_alloc_entry(unsigned long addr, int node)
+{
+	unsigned long root_entry;
+	unsigned int root_index;
+	unsigned long *chunk;
+
+	if (!vmemmap_table_root_entries)
+		return vmemmap_table_chunk(addr);
+
+	root_index = addr >> NR_CHUNKS_SHIFT;
+	root_entry = vmemmap_table_root[root_index];
+
+	if (root_entry = 0UL) {
+		root_entry = vmemmap_alloc_root_entry(root_index, node);
+		vmemmap_table_root[root_index] = root_entry;
+	}
+	chunk = __va(root_entry);
+	chunk = chunk + ((addr & ~NR_CHUNKS_MASK) >> VMEMMAP_CHUNK_SHIFT);
+	return chunk;
+}
+
+int __meminit vmemmap_populate(unsigned long vstart, unsigned long vend,
+			       int node)
+{
+	unsigned long phys_start = (vstart - VMEMMAP_BASE);
+	unsigned long addr = phys_start & VMEMMAP_CHUNK_MASK;
+	unsigned long phys_end = (vend - VMEMMAP_BASE);
+	unsigned long end = VMEMMAP_ALIGN(phys_end);
+	unsigned long pte_base;
+
+	pte_base = (_PAGE_VALID | _PAGE_SZ4MB_4U |
+		    _PAGE_CP_4U | _PAGE_CV_4U |
+		    _PAGE_P_4U | _PAGE_W_4U);
+	if (tlb_type = hypervisor)
+		pte_base = (_PAGE_VALID | _PAGE_SZ4MB_4V |
+			    _PAGE_CP_4V | _PAGE_CV_4V |
+			    _PAGE_P_4V | _PAGE_W_4V);
+
+	for (; addr < end; addr += VMEMMAP_CHUNK) {
+		unsigned long *vmem_pp = vmemmap_alloc_entry(addr, node);
+		void *block;
+
+		if (!(*vmem_pp & _PAGE_VALID)) {
+			block = vmemmap_alloc_block(1UL << ILOG2_4MB, node);
+			if (!block)
+				return -ENOMEM;
+
+			*vmem_pp = pte_base | __pa(block);
+
+			/* check to see if we have contiguous blocks */
+			if (addr_end != addr || node_start != node) {
+				if (addr_start)
+					printk(KERN_DEBUG " [%lx-%lx] on node %d\n",
+					       addr_start, addr_end-1, node_start);
+				addr_start = addr;
+				node_start = node;
+			}
+			addr_end = addr + VMEMMAP_CHUNK;
+		}
+	}
+	return 0;
+}
+
+void __meminit vmemmap_populate_print_last(void)
+{
+	if (addr_start) {
+		printk(KERN_DEBUG " [%lx-%lx] on node %d\n",
+		       addr_start, addr_end-1, node_start);
+		addr_start = 0;
+		addr_end = 0;
+		node_start = 0;
+	}
+}
+
+void vmemmap_free(unsigned long start, unsigned long end)
+{
+}
+
+static void __init sparse_root_patch_phys_load(void)
+{
+	struct kvmap_vmemmap_phys_load_patch {unsigned int addr, inst; } *p;
+	extern unsigned int __kvmap_vmemmap_phys_load_patch;
+	unsigned int *inst;
+
+	p = (struct kvmap_vmemmap_phys_load_patch *)
+		&__kvmap_vmemmap_phys_load_patch;
+	inst = (unsigned int *) (unsigned long) (p->addr);
+	*inst = p->inst;
+
+	__asm__ __volatile__("flush %0\n\t"
+		: /* no outputs */
+		: "r" (inst));
+}
+
+static void __init sparse_root_patch_branch(void)
+{
+	extern unsigned int __kvmap_vmemmap_root_patch;
+	extern unsigned int kvmap_vmemmap_long;
+	unsigned int btarget = (unsigned int)
+		(unsigned long) &kvmap_vmemmap_long;
+	unsigned int *insn, *p, disp19;
+
+	p = &__kvmap_vmemmap_root_patch;
+	insn = (unsigned int *)(unsigned long)*p;
+	disp19 = (btarget - (unsigned int) (unsigned long) insn);
+	disp19 = disp19 >> 2;
+	disp19 = disp19 & (0x7ffff);
+	*insn = *insn & ~0x7ffff;
+	*insn = *insn | disp19;
+
+	__asm__ __volatile__("flush %0\n\t"
+		: /* no outputs */
+		: "r" (insn));
+}
+
+static void __init sparse_root_patch_root_address(void)
+{
+	unsigned long paddr = __pa(vmemmap_table_root);
+	extern unsigned int kvmap_vmemmap_long;
+	unsigned int *addr = &kvmap_vmemmap_long;
+	unsigned int insn = *addr;
+
+	/* Shift it twice. Once to form address and again for opcode.*/
+	paddr  = (paddr >> (NR_VMEMMAP_ROOT_SHIFT + NR_VMEMMAP_ROOT_SHIFT));
+	insn = insn | paddr;
+	*addr = insn;
+
+	__asm__ __volatile__("flush %0\n\t"
+		: /* no outputs */
+		: "r" (addr));
+}
+
+static void __init sparse_root_patch(void)
+{
+	sparse_root_patch_phys_load();
+	sparse_root_patch_branch();
+	sparse_root_patch_root_address();
+}
+
+static void __init sparse_root_alloc(void)
+{
+	phys_addr_t size = NR_VMEMMAP_ROOT_ENTRIES * sizeof (unsigned long);
+	phys_addr_t align = NR_VMEMMAP_ROOT_ALIGN;
+	phys_addr_t max_addr = NR_VMEMMAP_ROOT_MAXADDR;
+	phys_addr_t addr = memblock_alloc_base(size, align, max_addr);
+
+	vmemmap_table_root = (unsigned long *) __va(addr);
+}
+
+void __init sparse_root_init(void)
+{
+	/* The sizeof (struct page) needs to be 1UL<<6.
+	 * It needs to be a powerof2 for vmemmap.
+	 */
+	BUILD_BUG_ON(sizeof (struct page) != 64);
+	BUILD_BUG_ON(MAX_PHYS_ADDRESS_BITS < MAX_PHYS_ADDRESS_LOBITS);
+	vmemmap_table_root_entries = max_pfn / NR_PHYS_ADDRESS_LOBITS_PAGES;
+	if (vmemmap_table_root_entries >= NR_VMEMMAP_ROOT_ENTRIES) {
+		prom_printf("MAX_PHYS_ADDRESS_BITS and/or"
+			" MAX_PHYS_ADDRESS_LOBITS must be adjusted.\n");
+		prom_halt();
+	}
+
+	if (vmemmap_table_root_entries) {
+		sparse_root_alloc();
+		sparse_root_patch();
+	}
+}
+#else /* !CONFIG_SPARSEMEM_VMEMMAP */
+static void __init sparse_root_init(void) {}
+#endif /* CONFIG_SPARSEMEM_VMEMMAP */
+
 static void __init bootmem_init_nonnuma(void)
 {
 	unsigned long top_of_ram = memblock_end_of_DRAM();
@@ -1362,6 +1573,7 @@ static unsigned long __init bootmem_init(unsigned long phys_base)
 
 	/* XXX cpu notifier XXX */
 
+	sparse_root_init();
 	sparse_memory_present_with_active_regions(MAX_NUMNODES);
 	sparse_init();
 
@@ -2419,72 +2631,6 @@ EXPORT_SYMBOL(_PAGE_E);
 unsigned long _PAGE_CACHE __read_mostly;
 EXPORT_SYMBOL(_PAGE_CACHE);
 
-#ifdef CONFIG_SPARSEMEM_VMEMMAP
-unsigned long vmemmap_table[VMEMMAP_SIZE];
-
-static long __meminitdata addr_start, addr_end;
-static int __meminitdata node_start;
-
-int __meminit vmemmap_populate(unsigned long vstart, unsigned long vend,
-			       int node)
-{
-	unsigned long phys_start = (vstart - VMEMMAP_BASE);
-	unsigned long phys_end = (vend - VMEMMAP_BASE);
-	unsigned long addr = phys_start & VMEMMAP_CHUNK_MASK;
-	unsigned long end = VMEMMAP_ALIGN(phys_end);
-	unsigned long pte_base;
-
-	pte_base = (_PAGE_VALID | _PAGE_SZ4MB_4U |
-		    _PAGE_CP_4U | _PAGE_CV_4U |
-		    _PAGE_P_4U | _PAGE_W_4U);
-	if (tlb_type = hypervisor)
-		pte_base = (_PAGE_VALID | _PAGE_SZ4MB_4V |
-			    _PAGE_CP_4V | _PAGE_CV_4V |
-			    _PAGE_P_4V | _PAGE_W_4V);
-
-	for (; addr < end; addr += VMEMMAP_CHUNK) {
-		unsigned long *vmem_pp -			vmemmap_table + (addr >> VMEMMAP_CHUNK_SHIFT);
-		void *block;
-
-		if (!(*vmem_pp & _PAGE_VALID)) {
-			block = vmemmap_alloc_block(1UL << ILOG2_4MB, node);
-			if (!block)
-				return -ENOMEM;
-
-			*vmem_pp = pte_base | __pa(block);
-
-			/* check to see if we have contiguous blocks */
-			if (addr_end != addr || node_start != node) {
-				if (addr_start)
-					printk(KERN_DEBUG " [%lx-%lx] on node %d\n",
-					       addr_start, addr_end-1, node_start);
-				addr_start = addr;
-				node_start = node;
-			}
-			addr_end = addr + VMEMMAP_CHUNK;
-		}
-	}
-	return 0;
-}
-
-void __meminit vmemmap_populate_print_last(void)
-{
-	if (addr_start) {
-		printk(KERN_DEBUG " [%lx-%lx] on node %d\n",
-		       addr_start, addr_end-1, node_start);
-		addr_start = 0;
-		addr_end = 0;
-		node_start = 0;
-	}
-}
-
-void vmemmap_free(unsigned long start, unsigned long end)
-{
-}
-
-#endif /* CONFIG_SPARSEMEM_VMEMMAP */
-
 static void prot_init_common(unsigned long page_none,
 			     unsigned long page_shared,
 			     unsigned long page_copy,
diff --git a/arch/sparc/mm/init_64.h b/arch/sparc/mm/init_64.h
index 5c86c14..9b70c23 100644
--- a/arch/sparc/mm/init_64.h
+++ b/arch/sparc/mm/init_64.h
@@ -43,7 +43,7 @@ void prom_world(int enter);
 #define VMEMMAP_CHUNK_MASK	~(VMEMMAP_CHUNK - 1UL)
 #define VMEMMAP_ALIGN(x)	(((x)+VMEMMAP_CHUNK-1UL)&VMEMMAP_CHUNK_MASK)
 
-#define VMEMMAP_SIZE	((((1UL << MAX_PHYSADDR_BITS) >> PAGE_SHIFT) * \
+#define VMEMMAP_SIZE	((((1UL << MAX_PHYS_ADDRESS_LOBITS) >> PAGE_SHIFT) * \
 			  sizeof(struct page)) >> VMEMMAP_CHUNK_SHIFT)
 extern unsigned long vmemmap_table[VMEMMAP_SIZE];
 #endif
-- 
1.7.1

