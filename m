From: Kirill Tkhai <tkhai@yandex.ru>
Date: Thu, 22 Aug 2013 13:39:50 +0000
Subject: [RFC] sparc64: Duplicate kernel text on every NUMA node
Message-Id: <8311377178790@web14g.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi!

There is an idea to duplicate kernel text on every NUMA node. Node access is the fastest,
so this should help to execute kernel text a little faster.

This requires the patch which changes init text place in lds file (http://patchwork.ozlabs.org/patch/264713/).

I assume that original kernel text allocates from node 0, and it is not necessary to allocate
per node kernel text clone for BSP cpu and for its neighbours. So we should do this only
in trampoline_64.S.

I allocate a memory for node copy before page allocator is active. When all kernel patches
are applied then it's the time to copy kernel text on every node. So when cpu is starting
it receives a kernel text copy which corresponds to its node.

The copy doesn't include init text except the cases when it is in the same 4Mb page
with not-init text. In other words (or more correct) tail init text is not copied. It's mapped
from the original image.

It looks no problem with everything above: node is already online, everything is initialized,
kernel text is locked forever. 

Please, tell your comments about this (It's not ready patch, I'm not sure it's completely
good yet). Maybe there are any reasons to do anything in another way than I did.

Thanks,
Kirill
---
diff --git a/arch/sparc/include/asm/page_64.h b/arch/sparc/include/asm/page_64.h
index e155388..c5273e4 100644
--- a/arch/sparc/include/asm/page_64.h
+++ b/arch/sparc/include/asm/page_64.h
@@ -8,6 +8,9 @@
 #define PAGE_SIZE    (_AC(1,UL) << PAGE_SHIFT)
 #define PAGE_MASK    (~(PAGE_SIZE-1))
 
+#define PAGE4MB_SHIFT		22
+#define PAGE4MB_SIZE		(_AC(1,UL) << PAGE4MB_SHIFT)
+
 /* Flushing for D-cache alias handling is only needed if
  * the page size is smaller than 16K.
  */
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 3676031..cd440bd 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -843,6 +843,12 @@ extern pmd_t swapper_low_pmd_dir[2048];
 extern void paging_init(void);
 extern unsigned long find_ecache_flush_span(unsigned long size);
 
+#ifdef CONFIG_NUMA
+extern void numa_copy_kernel_text(void);
+#else
+static inline void numa_copy_kernel_text(void) {}
+#endif
+
 struct seq_file;
 extern void mmu_info(struct seq_file *);
 
diff --git a/arch/sparc/include/asm/trap_block.h b/arch/sparc/include/asm/trap_block.h
index 7e26b2d..a2f0990 100644
--- a/arch/sparc/include/asm/trap_block.h
+++ b/arch/sparc/include/asm/trap_block.h
@@ -138,6 +138,23 @@ extern struct sun4v_2insn_patch_entry __sun4v_2insn_patch,
 	nop;						\
 	.previous;
 
+#ifdef CONFIG_NUMA
+
+#define __GET_NODEID(REG, TMP)				\
+	__GET_CPUID(REG)				\
+	sethi	%hi(numa_cpu_lookup_table), TMP;	\
+	or	TMP, %lo(numa_cpu_lookup_table), TMP;	\
+	sllx	REG, 2, REG;				\
+	add	TMP, REG, TMP;				\
+	lduw	[TMP], REG;
+
+#else /* !CONFIG_NUMA */
+
+#define __GET_NODEID(REG, TMP)				\
+	clr	REG
+
+#endif /* !CONFIG_NUMA */
+
 #ifdef CONFIG_SMP
 
 #define TRAP_LOAD_TRAP_BLOCK(DEST, TMP)		\
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index e142545..f92d31e 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -285,7 +285,7 @@ static void ldom_startcpu_cpuid(unsigned int cpu, unsigned long thread_reg,
 				void **descrp)
 {
 	extern unsigned long sparc64_ttable_tl0;
-	extern unsigned long kern_locked_tte_data;
+	extern unsigned long kern_locked_tte_data[MAX_NUMNODES];
 	struct hvtramp_descr *hdesc;
 	unsigned long trampoline_ra;
 	struct trap_per_cpu *tb;
@@ -315,7 +315,7 @@ static void ldom_startcpu_cpuid(unsigned int cpu, unsigned long thread_reg,
 	hdesc->thread_reg = thread_reg;
 
 	tte_vaddr = (unsigned long) KERNBASE;
-	tte_data = kern_locked_tte_data;
+	tte_data = kern_locked_tte_data[0];
 
 	for (i = 0; i < hdesc->num_mappings; i++) {
 		hdesc->maps[i].vaddr = tte_vaddr;
@@ -1214,6 +1214,10 @@ int setup_profiling_timer(unsigned int multiplier)
 
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
+	/* Dublicate kernel on every node. Do this after
+	 * all kernel patches are applied.
+	 */
+	numa_copy_kernel_text();
 }
 
 void smp_prepare_boot_cpu(void)
diff --git a/arch/sparc/kernel/trampoline_64.S b/arch/sparc/kernel/trampoline_64.S
index e0b1e13..4731dea 100644
--- a/arch/sparc/kernel/trampoline_64.S
+++ b/arch/sparc/kernel/trampoline_64.S
@@ -117,27 +117,43 @@ startup_continue:
 	flushw
 
 	/* Setup the loop variables:
+	 * %l1: Number of 4MB pages containing not-init kernel text
+	 * %l2: TTE base of node 0. Used for DTLB and for rest of __init text
+	 *	ITLB mappings. See numa_alloc_kernel_text() for details.
 	 * %l3: VADDR base
-	 * %l4: TTE base
+	 * %l4: TTE base of current node. Used for ITLB.
 	 * %l5: Loop iterator, iterates from 0 to 'num_kernel_image_mappings'
 	 * %l6: Number of TTE entries to map
 	 * %l7: Highest TTE entry number, we count down
 	 */
 	sethi		%hi(KERNBASE), %l3
 	sethi		%hi(kern_locked_tte_data), %l4
-	ldx		[%l4 + %lo(kern_locked_tte_data)], %l4
+	or		%l4, %lo(kern_locked_tte_data), %l4
+	ldx		[%l4], %l2	! kern_locked_tte_data[0]
+
+	__GET_NODEID(%g2, %g1)
+	sllx		%g2, 3, %g2
+	add		%l4, %g2, %l4
+	ldx		[%l4], %l4	! kern_locked_tte_data[node]
+
 	clr		%l5
 	sethi		%hi(num_kernel_image_mappings), %l6
 	lduw		[%l6 + %lo(num_kernel_image_mappings)], %l6
 	add		%l6, 1, %l6
 
+	sethi		%hi(num_node_copy_mappings), %l1
+	lduw		[%l1 + %lo(num_node_copy_mappings)], %l1
+
 	mov		15, %l7
 	BRANCH_IF_ANY_CHEETAH(g1,g5,2f)
 
 	mov		63, %l7
 2:
-
-3:
+	cmp		%l5, %l1	!__init section
+	bne		4f
+	 nop
+	mov		%l2, %l4	!use node 0 TTE
+4:
 	/* Lock into I-MMU */
 	sethi		%hi(call_method), %g2
 	or		%g2, %lo(call_method), %g2
@@ -191,7 +207,7 @@ startup_continue:
 
 	add		%l3, %g1, %g2
 	stx		%g2, [%sp + 2047 + 128 + 0x28]	! VADDR
-	add		%l4, %g1, %g2
+	add		%l2, %g1, %g2
 	stx		%g2, [%sp + 2047 + 128 + 0x30]	! TTE
 
 	/* TTE index is highest minus loop index.  */
@@ -206,7 +222,7 @@ startup_continue:
 
 	add		%l5, 1, %l5
 	cmp		%l5, %l6
-	bne,pt		%xcc, 3b
+	bne,pt		%xcc, 2b
 	 nop
 
 	sethi		%hi(prom_entry_lock), %g2
@@ -218,13 +234,27 @@ startup_continue:
 niagara_lock_tlb:
 	sethi		%hi(KERNBASE), %l3
 	sethi		%hi(kern_locked_tte_data), %l4
-	ldx		[%l4 + %lo(kern_locked_tte_data)], %l4
+	or		%l4, %lo(kern_locked_tte_data), %l4
+	ldx		[%l4], %l2	! kern_locked_tte_data[0]
+
+	__GET_NODEID(%g2, %g1)
+	sllx		%g2, 3, %g2
+	add		%l4, %g2, %l4
+	ldx		[%l4], %l4	! kern_locked_tte_data[node]
+
 	clr		%l5
 	sethi		%hi(num_kernel_image_mappings), %l6
 	lduw		[%l6 + %lo(num_kernel_image_mappings)], %l6
 	add		%l6, 1, %l6
 
+	sethi		%hi(num_node_copy_mappings), %l1
+	lduw		[%l1 + %lo(num_node_copy_mappings)], %l1
 1:
+	cmp		%l5, %l1	!__init section
+	bne		4f
+	 nop
+	mov		%l2, %l4	!use node 0 TTE
+4:
 	mov		HV_FAST_MMU_MAP_PERM_ADDR, %o5
 	sllx		%l5, 22, %g2
 	add		%l3, %g2, %o0
@@ -237,7 +267,7 @@ niagara_lock_tlb:
 	sllx		%l5, 22, %g2
 	add		%l3, %g2, %o0
 	clr		%o1
-	add		%l4, %g2, %o2
+	add		%l2, %g2, %o2
 	mov		HV_MMU_DMMU, %o3
 	ta		HV_FAST_TRAP
 
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index ed82eda..d99114f 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -186,6 +186,7 @@ unsigned long sparc64_kern_pri_nuc_bits __read_mostly;
 unsigned long sparc64_kern_sec_context __read_mostly;
 
 int num_kernel_image_mappings;
+int num_node_copy_mappings;
 
 #ifdef CONFIG_DEBUG_DCFLUSH
 atomic_t dcpage_flushes = ATOMIC_INIT(0);
@@ -477,7 +478,7 @@ void mmu_info(struct seq_file *m)
 struct linux_prom_translation prom_trans[512] __read_mostly;
 unsigned int prom_trans_ents __read_mostly;
 
-unsigned long kern_locked_tte_data;
+unsigned long kern_locked_tte_data[MAX_NUMNODES];
 
 /* The obp translations are saved based on 8k pagesize, since obp can
  * use a mixture of pagesizes. Misses to the LOW_OBP_ADDRESS ->
@@ -591,7 +592,7 @@ static void __init remap_kernel(void)
 	phys_page = (prom_boot_mapping_phys_low >> 22UL) << 22UL;
 	tte_data = kern_large_tte(phys_page);
 
-	kern_locked_tte_data = tte_data;
+	kern_locked_tte_data[0] = tte_data;
 
 	/* Now lock us into the TLBs via Hypervisor or OBP. */
 	if (tlb_type = hypervisor) {
@@ -1330,6 +1331,78 @@ static void __init bootmem_init_nonnuma(void)
 	node_set_online(0);
 }
 
+#ifdef CONFIG_NUMA
+
+/* Allocate memory for per-node copy of kernel text.
+ * The copying itself will be made after all kernel
+ * patches are applied.
+ */
+static void __init numa_alloc_kernel_text(void)
+{
+	unsigned long init_start = (unsigned long)__init_begin;
+	unsigned int size, node;
+
+	/* The rest init text will be mapped from the original image.
+	 */
+	size = round_up(init_start - KERNBASE, PAGE4MB_SIZE);
+	num_node_copy_mappings = size >> PAGE4MB_SHIFT;
+
+	for (node = 1; node < num_node_masks; node++) {
+		unsigned long tte_data;
+		phys_addr_t new_base_pa;
+
+		new_base_pa = memblock_alloc_nid(size, PAGE4MB_SIZE, node);
+
+		if (new_base_pa) {
+			pr_info("node %d: Allocated memory for copy of "
+				"kernel text: [%016llx, %016llx]\n",
+				 node, new_base_pa, new_base_pa + size);
+			tte_data = kern_large_tte(new_base_pa);
+		} else {
+			pr_err("node %d: Can't allocate memory for kernel "
+			       "text duplicate\n", node);
+			tte_data = kern_locked_tte_data[0];
+		}
+
+		kern_locked_tte_data[node] = tte_data;
+	}
+}
+
+/* Dublicate kernel text on every NUMA node.
+ * Do not copy pages which contain only init text,
+ * because they are mapped from original kernel.
+ */
+void numa_copy_kernel_text(void)
+{
+	unsigned int size, node, tte_data0;
+
+	size = num_node_copy_mappings << PAGE4MB_SHIFT;
+	tte_data0 = kern_locked_tte_data[0];
+
+	for (node = 1; node < num_node_masks; node++) {
+		unsigned long tte_data, phys_addr;
+
+		tte_data = kern_locked_tte_data[node];
+
+		if (tte_data = tte_data0)
+			continue;
+
+		/* PA is [42:12] range */
+		phys_addr = (((tte_data << 21) >> 21) >> 13) << 13;
+
+		memcpy(__va(phys_addr), (void *)KERNBASE, size);
+	}
+}
+
+#else /* CONFIG_NUMA */
+
+static void __init numa_alloc_kernel_text(void)
+{
+}
+
+#endif /* CONFIG_NUMA */
+
+
 static unsigned long __init bootmem_init(unsigned long phys_base)
 {
 	unsigned long end_pfn;
@@ -1341,6 +1414,8 @@ static unsigned long __init bootmem_init(unsigned long phys_base)
 	if (bootmem_init_numa() < 0)
 		bootmem_init_nonnuma();
 
+	numa_alloc_kernel_text();
+
 	/* Dump memblock with node info. */
 	memblock_dump_all();
 
@@ -1830,6 +1905,9 @@ void __init paging_init(void)
 		memblock_add(pavail[i].phys_addr, pavail[i].reg_size);
 	}
 
+#ifdef CONFIG_NUMA
+	kern_size = round_up(kern_size, PAGE4MB_SIZE);
+#endif
 	memblock_reserve(kern_base, kern_size);
 
 	find_ramdisk(phys_base);
@@ -2096,6 +2174,17 @@ void free_initmem(void)
 	 * The init section is aligned to 8k in vmlinux.lds. Page align for >8k pagesizes.
 	 */
 	addr = PAGE_ALIGN((unsigned long)(__init_begin));
+
+#ifdef CONFIG_NUMA
+	if (num_node_masks > 1) {
+		/* Do not free 4KB pages which are lying at 4MB page
+		 * together with normal kernel text. Their addresses
+		 * are forbidden forever.
+		 */
+		addr = round_up(addr, PAGE4MB_SIZE);
+	}
+#endif
+
 	initend = (unsigned long)(__init_end) & PAGE_MASK;
 	for (; addr < initend; addr += PAGE_SIZE) {
 		unsigned long page;
diff --git a/arch/sparc/mm/init_64.h b/arch/sparc/mm/init_64.h
index 0661aa6..d3edd6f 100644
--- a/arch/sparc/mm/init_64.h
+++ b/arch/sparc/mm/init_64.h
@@ -32,7 +32,7 @@ extern struct linux_prom_translation prom_trans[512];
 extern unsigned int prom_trans_ents;
 
 /* Exported for SMP bootup purposes. */
-extern unsigned long kern_locked_tte_data;
+extern unsigned long kern_locked_tte_data[MAX_NUMNODES];
 
 extern void prom_world(int enter);
 
