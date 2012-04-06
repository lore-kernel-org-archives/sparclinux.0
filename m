From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 06 Apr 2012 15:26:19 +0000
Subject: sparc32 paging fault which I cannot explain
Message-Id: <20120406152619.GA17138@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

While working on the conversion of sparc32 to use memblock
I have hit a bug that I do not understand.

In srmmu_nocache_init() we do the first allocation:

     srmmu_nocache_pool = __alloc_bootmem(srmmu_nocache_size,
                                          SRMMU_NOCACHE_ALIGN_MAX, 0UL);

Everything looks like it is properly setup when we do so.
But the allocation fails with a paging fault:

    Unable to handle kernel paging request at virtual address f1d40000

The fault happens in the nobootmem.c code where we do a memset()
usign the virtual address. This is the first time we reference the virtual address.

I my system I have RAM here:

    [0x00000000000000-0x000000001fa0fff]

PAGE_OFFSET is 0xf0000000 - which explains the offset from the physical address.

And I have checked the size of the allocation - it is within the limits.

What I think happens is that the MMU is not setup to handle virtual addresses
in this area - as this is a much higher address than what we would have seen
with the old bootmem allocator. memblock allocates top-down, where bootmem
allocates bottom-up.

I think the following code in head_32.S plays a role:

                /* The following is for non-4/4xx sun4 MMU's. */
sun4_normal_remap:
                mov     0, %g3                  ! source base
                set     KERNBASE, %g4           ! destination base
                set     0x300000, %g5           ! upper bound 3MB
                mov     1, %l6
                sll     %l6, 18, %l6            ! sun4 mmu segmap size
sun4_normal_loop:
                lduha   [%g3] ASI_SEGMAP, %g6   ! load phys_seg
                stha    %g6, [%g4] ASI_SEGMAP   ! stort new virt mapping
                add     %g3, %l6, %g3           ! increment source pointer
                subcc   %g3, %g5, %g0           ! reached limit?
                blu     sun4_normal_loop        ! nope, loop again
                 add    %g4, %l6, %g4           ! delay, increment dest ptr
                b       go_to_highmem
                 nop

But I failed to dechiper this....

So some clue would be good!

Maybe what I need is to convince memblock to give me RAM in a lower area.
But until now I have not tried that - I wanted to understand what is going
on first.

The full Oops (hand-copied):

ARCH: SUN4M
Type: SPARCstation 5
Ethernet address: 08:00:20:90:87:7a
Boot time fixup v1.6: 4/Mar/98 Jakub Jelinek (jj@ultra.linux.cz). Patching kernel for srmmu[Fujitsu TurboSparc]/iommu
MEMBLOCK configuration:
 memory size = 0x1fa1000 reserved size = 0x0
 memory.cnt = 0x1
 memory[0x0]   [0x00000000000000-0x000000001fa0fff], 0x1fa1000 bytes on node 0
 reserved.cnt = 0x1
 reserved[0x0]  [0x00000000000000-0xffffffffffffffff], 0x0 bytes on node 0
memblock_reserve: [0x00000000000000-0x000000003a9000] clock_stop_probe+0xb8/0x140
Found ramdisk at physical address 0x3ab000, size 4022272
memblock_reserve: [0x000000003ab000-0x00000000781000] cpu_type_probe+0x1b0/0x1f8

srmmu_nocache_init 1
Unable to handle kernel paging request at virtual address f1d40000
tsk->{mm,active_mm}->context = ffffffff
tsk->{mm,active_mm}->pgd = f0008000

    \|/ ____ \|/ 
    "@'/ .. \`@" 
    /_| \__/ |_\ 
       \__U_/ 

swapper(0): Oops [#1]
PSR: 04401fe7 PC: f015fb70 NPC: f015fb74 Y:00000000   Not tainted
PC: <__bzero+0x38/0x144>
%G: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
%O: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
PRC: <   (null)>
Unable to handle kernel NULL pointer reference

The patch so far is included below for reference.
Note that this is work-in-progress - and especially the highmem support
is missing/faulty.
The patch also include some of my debugging printk - please ignore these!

I have concentrated on the code up until srmmu_nocache_init() for now.

	Sam


 Kconfig                  |    5
 include/asm/leon.h       |    4
 include/asm/mmu_32.h     |    7
 include/asm/oplib_32.h   |    2
 include/asm/page_32.h    |   21 --
 include/asm/pgtable_32.h |   15 +-
 kernel/setup_32.c        |   17 --
 mm/fault_32.c            |   12 -
 mm/init_32.c             |  341 +++++++++++------------------------------------
 mm/srmmu.c               |   86 ++---------
 mm/sun4c.c               |   28 ---
 prom/init_32.c           |    3
 prom/memory.c            |   55 +------
 13 files changed, 142 insertions(+), 454 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 6c0683d..a6dcfde 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -26,6 +26,8 @@ config SPARC
 	select HAVE_DMA_API_DEBUG
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_GENERIC_HARDIRQS
+	select HAVE_MEMBLOCK
+	select HAVE_MEMBLOCK_NODE_MAP
 	select GENERIC_IRQ_SHOW
 	select USE_GENERIC_SMP_HELPERS if SMP
 	select GENERIC_PCI_IOMAP
@@ -35,6 +37,7 @@ config SPARC32
 	def_bool !64BIT
 	select GENERIC_ATOMIC64
 	select CLZ_TAB
+	select NO_BOOTMEM
 
 config SPARC64
 	def_bool 64BIT
@@ -46,8 +49,6 @@ config SPARC64
 	select HAVE_KRETPROBES
 	select HAVE_KPROBES
 	select HAVE_RCU_TABLE_FREE if SMP
-	select HAVE_MEMBLOCK
-	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_SYSCALL_WRAPPERS
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD
diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
index a4e457f..0cf7f46 100644
--- a/arch/sparc/include/asm/leon.h
+++ b/arch/sparc/include/asm/leon.h
@@ -164,8 +164,6 @@ extern void leon_init(void);
 extern void leon_switch_mm(void);
 extern void leon_init_IRQ(void);
 
-extern unsigned long last_valid_pfn;
-
 static inline unsigned long sparc_leon3_get_dcachecfg(void)
 {
 	unsigned int retval;
@@ -368,7 +366,7 @@ extern int leon_ipi_irq;
 
 /* macros used in leon_mm.c */
 #define PFN(x)           ((x) >> PAGE_SHIFT)
-#define _pfn_valid(pfn)	 ((pfn < last_valid_pfn) && (pfn >= PFN(phys_base)))
+#define _pfn_valid(pfn)	 ((pfn < max_low_pfn) && (pfn >= PFN(phys_base)))
 #define _SRMMU_PTE_PMASK_LEON 0xffffffff
 
 #else /* defined(CONFIG_SPARC_LEON) */
diff --git a/arch/sparc/include/asm/mmu_32.h b/arch/sparc/include/asm/mmu_32.h
index 6f056e5..f2d6b60 100644
--- a/arch/sparc/include/asm/mmu_32.h
+++ b/arch/sparc/include/asm/mmu_32.h
@@ -7,4 +7,11 @@ typedef unsigned long mm_context_t;
 /* mm/srmmu.c */
 extern ctxd_t *srmmu_ctx_table_phys;
 
+/* mm/init_32.c */
+#ifdef CONFIG_BLK_DEV_INITRD
+void __init find_ramdisk(unsigned long phys_base);
+#else
+static inline find_ramdisk(unsigned long phys_base) {}
+#endif
+
 #endif
diff --git a/arch/sparc/include/asm/oplib_32.h b/arch/sparc/include/asm/oplib_32.h
index 71e5e9a..3c52997 100644
--- a/arch/sparc/include/asm/oplib_32.h
+++ b/arch/sparc/include/asm/oplib_32.h
@@ -114,7 +114,7 @@ extern void prom_putsegment(int context, unsigned long virt_addr,
 			    int physical_segment);
 
 /* Initialize the memory lists based upon the prom version. */
-void prom_meminit(void);
+void prom_memblock_add_mem(void);
 
 /* PROM device tree traversal functions... */
 
diff --git a/arch/sparc/include/asm/page_32.h b/arch/sparc/include/asm/page_32.h
index bb5c2ac..d93fccc 100644
--- a/arch/sparc/include/asm/page_32.h
+++ b/arch/sparc/include/asm/page_32.h
@@ -29,22 +29,6 @@
 		sparc_flush_page_to_ram(page);	\
 	} while (0)
 
-/* The following structure is used to hold the physical
- * memory configuration of the machine.  This is filled in
- * prom_meminit() and is later used by mem_init() to set up
- * mem_map[].  We statically allocate SPARC_PHYS_BANKS+1 of
- * these structs, this is arbitrary.  The entry after the
- * last valid one has num_bytes=0.
- */
-struct sparc_phys_banks {
-  unsigned long base_addr;
-  unsigned long num_bytes;
-};
-
-#define SPARC_PHYS_BANKS 32
-
-extern struct sparc_phys_banks sp_banks[SPARC_PHYS_BANKS+1];
-
 /* Cache alias structure.  Entry is valid if context != -1. */
 struct cache_palias {
 	unsigned long vaddr;
@@ -131,6 +115,7 @@ BTFIXUPDEF_SETHI(sparc_unmapped_base)
 #ifndef __ASSEMBLY__
 extern unsigned long phys_base;
 extern unsigned long pfn_base;
+extern unsigned long max_low_pfn;
 #endif
 #define __pa(x)			((unsigned long)(x) - PAGE_OFFSET + phys_base)
 #define __va(x)			((void *)((unsigned long) (x) - phys_base + PAGE_OFFSET))
@@ -141,8 +126,8 @@ extern unsigned long pfn_base;
 #define ARCH_PFN_OFFSET		(pfn_base)
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
 
-#define pfn_valid(pfn)		(((pfn) >= (pfn_base)) && (((pfn)-(pfn_base)) < max_mapnr))
-#define virt_addr_valid(kaddr)	((((unsigned long)(kaddr)-PAGE_OFFSET)>>PAGE_SHIFT) < max_mapnr)
+#define pfn_valid(pfn)		((pfn) >= pfn_base && (pfn) < max_low_pfn)
+#define virt_addr_valid(kaddr)	pfn_valid(PFN_DOWN(__pa(kaddr)))
 
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index 3d71018..b7a2650 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -121,6 +121,12 @@ extern int num_contexts;
 extern unsigned long phys_base;
 extern unsigned long pfn_base;
 
+/* No memory beyond this pfn */
+extern unsigned long max_low_pfn;
+
+/* Memory may be limited by mem=xxx */
+extern unsigned long cmdline_memory_size;
+
 /*
  * BAD_PAGETABLE is used when we need a bogus page-table, while
  * BAD_PAGE is used for a bogus page.
@@ -425,11 +431,10 @@ __get_iospace (unsigned long addr)
 	}
 }
 
-extern unsigned long *sparc_valid_addr_bitmap;
-
-/* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
-#define kern_addr_valid(addr) \
-	(test_bit(__pa((unsigned long)(addr))>>20, sparc_valid_addr_bitmap))
+/* We default to always valid because we cannot lookup this
+ * in any existing data-structure.
+ */
+#define kern_addr_valid(addr) (1)
 
 /*
  * For sparc32&64, the pfn in io_remap_pfn_range() carries <iospace> in
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index d444468..d90465d 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -209,9 +209,6 @@ struct pt_regs fake_swapper_regs;
 
 void __init setup_arch(char **cmdline_p)
 {
-	int i;
-	unsigned long highest_paddr;
-
 	sparc_ttable = (struct tt_entry *) &trapbase;
 
 	/* Initialize PROM console and command line. */
@@ -279,20 +276,6 @@ void __init setup_arch(char **cmdline_p)
 		sun4c_probe_vac();
 	load_mmu();
 
-	phys_base = 0xffffffffUL;
-	highest_paddr = 0UL;
-	for (i = 0; sp_banks[i].num_bytes != 0; i++) {
-		unsigned long top;
-
-		if (sp_banks[i].base_addr < phys_base)
-			phys_base = sp_banks[i].base_addr;
-		top = sp_banks[i].base_addr +
-			sp_banks[i].num_bytes;
-		if (highest_paddr < top)
-			highest_paddr = top;
-	}
-	pfn_base = phys_base >> PAGE_SHIFT;
-
 	if (!root_flags)
 		root_mountflags &= ~MS_RDONLY;
 	ROOT_DEV = old_decode_dev(root_dev);
diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index 7705c67..32608a6 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -48,18 +48,6 @@ int vac_size, vac_linesize, vac_do_hw_vac_flushes;
 int vac_entries_per_context, vac_entries_per_segment;
 int vac_entries_per_page;
 
-/* Return how much physical memory we have.  */
-unsigned long probe_memory(void)
-{
-	unsigned long total = 0;
-	int i;
-
-	for (i = 0; sp_banks[i].num_bytes; i++)
-		total += sp_banks[i].num_bytes;
-
-	return total;
-}
-
 extern void sun4c_complete_all_stores(void);
 
 /* Whee, a level 15 NMI interrupt memory error.  Let's have fun... */
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index c5f9021..8e9ca96 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -7,6 +7,7 @@
  *  Copyright (C) 2000 Anton Blanchard (anton@samba.org)
  */
 
+#include <linux/memblock.h>
 #include <linux/module.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
@@ -36,9 +37,6 @@
 #include <asm/prom.h>
 #include <asm/leon.h>
 
-unsigned long *sparc_valid_addr_bitmap;
-EXPORT_SYMBOL(sparc_valid_addr_bitmap);
-
 unsigned long phys_base;
 EXPORT_SYMBOL(phys_base);
 
@@ -48,7 +46,6 @@ EXPORT_SYMBOL(pfn_base);
 unsigned long page_kernel;
 EXPORT_SYMBOL(page_kernel);
 
-struct sparc_phys_banks sp_banks[SPARC_PHYS_BANKS+1];
 unsigned long sparc_unmapped_base;
 
 struct pgtable_cache_struct pgt_quicklists;
@@ -57,8 +54,6 @@ struct pgtable_cache_struct pgt_quicklists;
 extern unsigned int sparc_ramdisk_image;
 extern unsigned int sparc_ramdisk_size;
 
-unsigned long highstart_pfn, highend_pfn;
-
 pte_t *kmap_pte;
 pgprot_t kmap_prot;
 
@@ -89,6 +84,34 @@ void show_mem(unsigned int filter)
 #endif
 }
 
+#ifdef CONFIG_BLK_DEV_INITRD
+/* Reserve memory for initrd (if present) */
+void __init find_ramdisk(unsigned long phys_base)
+{
+	if (!sparc_ramdisk_image)
+		return;
+
+	/* The bootloader normalizes the physical address to KERNBASE,
+	 * so we have to factor that back out and add in the lowest valid
+	 * physical page address to get the true physical address.
+	 */
+	if (sparc_ramdisk_image >= (unsigned long)&_end - 2 * PAGE_SIZE)
+		sparc_ramdisk_image -= KERNBASE;
+
+	initrd_start = sparc_ramdisk_image + phys_base;
+
+	printk(KERN_INFO "Found ramdisk at physical address 0x%lx, size %u\n",
+	       initrd_start, sparc_ramdisk_size);
+
+	if (memblock_reserve(initrd_start, sparc_ramdisk_size))
+	{
+		printk(KERN_CRIT "initrd reservation failed (0x%016lx:0x%016xl)",
+				  initrd_start, sparc_ramdisk_size);
+		initrd_start = 0;
+	}
+}
+#endif
+
 void __init sparc_context_init(int numctx)
 {
 	int ctx;
@@ -108,182 +131,24 @@ void __init sparc_context_init(int numctx)
 		add_to_free_ctxlist(ctx_list_pool + ctx);
 }
 
-extern unsigned long cmdline_memory_size;
-unsigned long last_valid_pfn;
-
-unsigned long calc_highpages(void)
+static void himem_init(unsigned long *normal, unsigned long *himem)
 {
-	int i;
-	int nr = 0;
-
-	for (i = 0; sp_banks[i].num_bytes != 0; i++) {
-		unsigned long start_pfn = sp_banks[i].base_addr >> PAGE_SHIFT;
-		unsigned long end_pfn = (sp_banks[i].base_addr + sp_banks[i].num_bytes) >> PAGE_SHIFT;
+	unsigned long himem_base;
 
-		if (end_pfn <= max_low_pfn)
-			continue;
+	himem_base = phys_base + SRMMU_MAXMEM;
 
-		if (start_pfn < max_low_pfn)
-			start_pfn = max_low_pfn;
-
-		nr += end_pfn - start_pfn;
+	if (memblock_end_of_DRAM() > himem_base)
+	{
+		/* Prevent highmem to be used */
+		memblock_reserve(himem_base, memblock_end_of_DRAM() - himem_base);
+		*himem = PFN_DOWN(himem_base);
 	}
-
-	return nr;
-}
-
-static unsigned long calc_max_low_pfn(void)
-{
-	int i;
-	unsigned long tmp = pfn_base + (SRMMU_MAXMEM >> PAGE_SHIFT);
-	unsigned long curr_pfn, last_pfn;
-
-	last_pfn = (sp_banks[0].base_addr + sp_banks[0].num_bytes) >> PAGE_SHIFT;
-	for (i = 1; sp_banks[i].num_bytes != 0; i++) {
-		curr_pfn = sp_banks[i].base_addr >> PAGE_SHIFT;
-
-		if (curr_pfn >= tmp) {
-			if (last_pfn < tmp)
-				tmp = last_pfn;
-			break;
-		}
-
-		last_pfn = (sp_banks[i].base_addr + sp_banks[i].num_bytes) >> PAGE_SHIFT;
+	else
+	{
+		*himem = 0;
 	}
-
-	return tmp;
-}
-
-unsigned long __init bootmem_init(unsigned long *pages_avail)
-{
-	unsigned long bootmap_size, start_pfn;
-	unsigned long end_of_phys_memory = 0UL;
-	unsigned long bootmap_pfn, bytes_avail, size;
-	int i;
-
-	bytes_avail = 0UL;
-	for (i = 0; sp_banks[i].num_bytes != 0; i++) {
-		end_of_phys_memory = sp_banks[i].base_addr +
-			sp_banks[i].num_bytes;
-		bytes_avail += sp_banks[i].num_bytes;
-		if (cmdline_memory_size) {
-			if (bytes_avail > cmdline_memory_size) {
-				unsigned long slack = bytes_avail - cmdline_memory_size;
-
-				bytes_avail -= slack;
-				end_of_phys_memory -= slack;
-
-				sp_banks[i].num_bytes -= slack;
-				if (sp_banks[i].num_bytes = 0) {
-					sp_banks[i].base_addr = 0xdeadbeef;
-				} else {
-					sp_banks[i+1].num_bytes = 0;
-					sp_banks[i+1].base_addr = 0xdeadbeef;
-				}
-				break;
-			}
-		}
-	}
-
-	/* Start with page aligned address of last symbol in kernel
-	 * image.  
-	 */
-	start_pfn  = (unsigned long)__pa(PAGE_ALIGN((unsigned long) &_end));
-
-	/* Now shift down to get the real physical page frame number. */
-	start_pfn >>= PAGE_SHIFT;
-
-	bootmap_pfn = start_pfn;
-
-	max_pfn = end_of_phys_memory >> PAGE_SHIFT;
-
-	max_low_pfn = max_pfn;
-	highstart_pfn = highend_pfn = max_pfn;
-
-	if (max_low_pfn > pfn_base + (SRMMU_MAXMEM >> PAGE_SHIFT)) {
-		highstart_pfn = pfn_base + (SRMMU_MAXMEM >> PAGE_SHIFT);
-		max_low_pfn = calc_max_low_pfn();
-		printk(KERN_NOTICE "%ldMB HIGHMEM available.\n",
-		    calc_highpages() >> (20 - PAGE_SHIFT));
-	}
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	/* Now have to check initial ramdisk, so that bootmap does not overwrite it */
-	if (sparc_ramdisk_image) {
-		if (sparc_ramdisk_image >= (unsigned long)&_end - 2 * PAGE_SIZE)
-			sparc_ramdisk_image -= KERNBASE;
-		initrd_start = sparc_ramdisk_image + phys_base;
-		initrd_end = initrd_start + sparc_ramdisk_size;
-		if (initrd_end > end_of_phys_memory) {
-			printk(KERN_CRIT "initrd extends beyond end of memory "
-		                 	 "(0x%016lx > 0x%016lx)\ndisabling initrd\n",
-			       initrd_end, end_of_phys_memory);
-			initrd_start = 0;
-		}
-		if (initrd_start) {
-			if (initrd_start >= (start_pfn << PAGE_SHIFT) &&
-			    initrd_start < (start_pfn << PAGE_SHIFT) + 2 * PAGE_SIZE)
-				bootmap_pfn = PAGE_ALIGN (initrd_end) >> PAGE_SHIFT;
-		}
-	}
-#endif	
-	/* Initialize the boot-time allocator. */
-	bootmap_size = init_bootmem_node(NODE_DATA(0), bootmap_pfn, pfn_base,
-					 max_low_pfn);
-
-	/* Now register the available physical memory with the
-	 * allocator.
-	 */
-	*pages_avail = 0;
-	for (i = 0; sp_banks[i].num_bytes != 0; i++) {
-		unsigned long curr_pfn, last_pfn;
-
-		curr_pfn = sp_banks[i].base_addr >> PAGE_SHIFT;
-		if (curr_pfn >= max_low_pfn)
-			break;
-
-		last_pfn = (sp_banks[i].base_addr + sp_banks[i].num_bytes) >> PAGE_SHIFT;
-		if (last_pfn > max_low_pfn)
-			last_pfn = max_low_pfn;
-
-		/*
-		 * .. finally, did all the rounding and playing
-		 * around just make the area go away?
-		 */
-		if (last_pfn <= curr_pfn)
-			continue;
-
-		size = (last_pfn - curr_pfn) << PAGE_SHIFT;
-		*pages_avail += last_pfn - curr_pfn;
-
-		free_bootmem(sp_banks[i].base_addr, size);
-	}
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	if (initrd_start) {
-		/* Reserve the initrd image area. */
-		size = initrd_end - initrd_start;
-		reserve_bootmem(initrd_start, size, BOOTMEM_DEFAULT);
-		*pages_avail -= PAGE_ALIGN(size) >> PAGE_SHIFT;
-
-		initrd_start = (initrd_start - phys_base) + PAGE_OFFSET;
-		initrd_end = (initrd_end - phys_base) + PAGE_OFFSET;		
-	}
-#endif
-	/* Reserve the kernel text/data/bss. */
-	size = (start_pfn << PAGE_SHIFT) - phys_base;
-	reserve_bootmem(phys_base, size, BOOTMEM_DEFAULT);
-	*pages_avail -= PAGE_ALIGN(size) >> PAGE_SHIFT;
-
-	/* Reserve the bootmem map.   We do not account for it
-	 * in pages_avail because we will release that memory
-	 * in free_all_bootmem.
-	 */
-	size = bootmap_size;
-	reserve_bootmem((bootmap_pfn << PAGE_SHIFT), size, BOOTMEM_DEFAULT);
-	*pages_avail -= PAGE_ALIGN(size) >> PAGE_SHIFT;
-
-	return max_pfn;
+	*normal = PFN_DOWN(memblock_end_of_DRAM());
+	high_memory = __va(memblock_end_of_DRAM());
 }
 
 /*
@@ -317,6 +182,38 @@ EXPORT_SYMBOL(PAGE_SHARED);
 
 void __init paging_init(void)
 {
+	unsigned long max_zone_pfns[MAX_NR_ZONES];
+	unsigned long kernel_align_end;
+	unsigned long normal_end_pfn;
+	unsigned long himem_end_pfn;
+
+memblock_debug = 1;
+
+	/* read memory info from prom */
+	// prom_memblock_add_mem();
+
+	/* limit memory if "mem=xxx" was specified on command line */
+	memblock_enforce_memory_limit(cmdline_memory_size);
+
+	/* prepare memblock for later use */
+	memblock_allow_resize();
+
+	/* tell user about out memblocks (if memblock_debug) */
+	memblock_dump_all();
+
+	/* Lowest address in available */
+	phys_base = memblock_start_of_DRAM();
+	pfn_base = PFN_DOWN(phys_base);
+
+	/* Highest valid pfn - from highest address */
+	max_low_pfn = PFN_DOWN(memblock_end_of_DRAM());
+
+	/* reserve memory for the kernel */
+	kernel_align_end = __pa(PAGE_ALIGN((unsigned long)&_end));
+	memblock_reserve(phys_base, kernel_align_end - phys_base);
+
+	himem_init(&normal_end_pfn, &himem_end_pfn);
+
 	switch(sparc_cpu_model) {
 	case sun4c:
 	case sun4e:
@@ -341,6 +238,13 @@ void __init paging_init(void)
 		prom_halt();
 	}
 
+	/* Pass memory from memblock to the kernel buddy allocator */
+	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
+
+	max_zone_pfns[ZONE_NORMAL] = normal_end_pfn;
+	max_zone_pfns[ZONE_HIGHMEM] = himem_end_pfn;
+	free_area_init_nodes(max_zone_pfns);
+
 	/* Initialize the protection map with non-constant, MMU dependent values. */
 	protection_map[0] = PAGE_NONE;
 	protection_map[1] = PAGE_READONLY;
@@ -364,48 +268,11 @@ void __init paging_init(void)
 	device_scan();
 }
 
-static void __init taint_real_pages(void)
-{
-	int i;
-
-	for (i = 0; sp_banks[i].num_bytes; i++) {
-		unsigned long start, end;
-
-		start = sp_banks[i].base_addr;
-		end = start + sp_banks[i].num_bytes;
-
-		while (start < end) {
-			set_bit(start >> 20, sparc_valid_addr_bitmap);
-			start += PAGE_SIZE;
-		}
-	}
-}
-
-static void map_high_region(unsigned long start_pfn, unsigned long end_pfn)
-{
-	unsigned long tmp;
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-	printk("mapping high region %08lx - %08lx\n", start_pfn, end_pfn);
-#endif
-
-	for (tmp = start_pfn; tmp < end_pfn; tmp++) {
-		struct page *page = pfn_to_page(tmp);
-
-		ClearPageReserved(page);
-		init_page_count(page);
-		__free_page(page);
-		totalhigh_pages++;
-	}
-}
-
 void __init mem_init(void)
 {
 	int codepages = 0;
 	int datapages = 0;
-	int initpages = 0; 
-	int reservedpages = 0;
-	int i;
+	int initpages = 0;
 
 	if (PKMAP_BASE+LAST_PKMAP*PAGE_SIZE >= FIXADDR_START) {
 		prom_printf("BUG: fixmap and pkmap areas overlap\n");
@@ -417,43 +284,10 @@ void __init mem_init(void)
 		prom_halt();
 	}
 
-
 	/* Saves us work later. */
 	memset((void *)&empty_zero_page, 0, PAGE_SIZE);
 
-	i = last_valid_pfn >> ((20 - PAGE_SHIFT) + 5);
-	i += 1;
-	sparc_valid_addr_bitmap = (unsigned long *)
-		__alloc_bootmem(i << 2, SMP_CACHE_BYTES, 0UL);
-
-	if (sparc_valid_addr_bitmap = NULL) {
-		prom_printf("mem_init: Cannot alloc valid_addr_bitmap.\n");
-		prom_halt();
-	}
-	memset(sparc_valid_addr_bitmap, 0, i << 2);
-
-	taint_real_pages();
-
-	max_mapnr = last_valid_pfn - pfn_base;
-	high_memory = __va(max_low_pfn << PAGE_SHIFT);
-
 	totalram_pages = free_all_bootmem();
-
-	for (i = 0; sp_banks[i].num_bytes != 0; i++) {
-		unsigned long start_pfn = sp_banks[i].base_addr >> PAGE_SHIFT;
-		unsigned long end_pfn = (sp_banks[i].base_addr + sp_banks[i].num_bytes) >> PAGE_SHIFT;
-
-		num_physpages += sp_banks[i].num_bytes >> PAGE_SHIFT;
-
-		if (end_pfn <= highstart_pfn)
-			continue;
-
-		if (start_pfn < highstart_pfn)
-			start_pfn = highstart_pfn;
-
-		map_high_region(start_pfn, end_pfn);
-	}
-	
 	totalram_pages += totalhigh_pages;
 
 	codepages = (((unsigned long) &_etext) - ((unsigned long)&_start));
@@ -463,18 +297,11 @@ void __init mem_init(void)
 	initpages = (((unsigned long) &__init_end) - ((unsigned long) &__init_begin));
 	initpages = PAGE_ALIGN(initpages) >> PAGE_SHIFT;
 
-	/* Ignore memory holes for the purpose of counting reserved pages */
-	for (i=0; i < max_low_pfn; i++)
-		if (test_bit(i >> (20 - PAGE_SHIFT), sparc_valid_addr_bitmap)
-		    && PageReserved(pfn_to_page(i)))
-			reservedpages++;
-
-	printk(KERN_INFO "Memory: %luk/%luk available (%dk kernel code, %dk reserved, %dk data, %dk init, %ldk highmem)\n",
+	printk(KERN_INFO "Memory: %luk/%luk available (%dk kernel code, %dk data, %dk init, %ldk highmem)\n",
 	       nr_free_pages() << (PAGE_SHIFT-10),
 	       num_physpages << (PAGE_SHIFT - 10),
 	       codepages << (PAGE_SHIFT-10),
-	       reservedpages << (PAGE_SHIFT - 10),
-	       datapages << (PAGE_SHIFT-10), 
+	       datapages << (PAGE_SHIFT-10),
 	       initpages << (PAGE_SHIFT-10),
 	       totalhigh_pages << (PAGE_SHIFT-10));
 }
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index cbef74e..370df17 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -8,6 +8,7 @@
  * Copyright (C) 1999,2000 Anton Blanchard (anton@samba.org)
  */
 
+#include <linux/memblock.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/vmalloc.h>
@@ -57,8 +58,6 @@ int vac_line_size;
 
 extern struct resource sparc_iomap;
 
-extern unsigned long last_valid_pfn;
-
 extern unsigned long page_kernel;
 
 static pgd_t *srmmu_swapper_pg_dir;
@@ -373,15 +372,13 @@ static void srmmu_free_nocache(unsigned long vaddr, int size)
 static void srmmu_early_allocate_ptable_skeleton(unsigned long start,
 						 unsigned long end);
 
-extern unsigned long probe_memory(void);	/* in fault.c */
-
 /*
  * Reserve nocache dynamically proportionally to the amount of
  * system RAM. -- Tomas Szepe <szepe@pinerecords.com>, June 2002
  */
 static void srmmu_nocache_calcsize(void)
 {
-	unsigned long sysmemavail = probe_memory() / 1024;
+	unsigned long sysmemavail = memblock_phys_mem_size() / 1024;
 	int srmmu_nocache_npages;
 
 	srmmu_nocache_npages @@ -410,10 +407,13 @@ static void __init srmmu_nocache_init(void)
 	unsigned long pteval;
 
 	bitmap_bits = srmmu_nocache_size >> SRMMU_NOCACHE_BITMAP_SHIFT;
-
+printk(KERN_ERR "srmmu_nocache_init 1");
 	srmmu_nocache_pool = __alloc_bootmem(srmmu_nocache_size,
 		SRMMU_NOCACHE_ALIGN_MAX, 0UL);
+
+printk(KERN_ERR "srmmu_nocache_init 2");
 	memset(srmmu_nocache_pool, 0, srmmu_nocache_size);
+printk(KERN_ERR "srmmu_nocache_init 3");
 
 	srmmu_nocache_bitmap = __alloc_bootmem(bitmap_bits >> 3, SMP_CACHE_BYTES, 0UL);
 	bit_map_init(&srmmu_nocache_map, srmmu_nocache_bitmap, bitmap_bits);
@@ -1208,46 +1208,25 @@ static void __init do_large_mapping(unsigned long vaddr, unsigned long phys_base
 	*(pgd_t *)__nocache_fix(pgdp) = __pgd(big_pte);
 }
 
-/* Map sp_bank entry SP_ENTRY, starting at virtual address VBASE. */
-static unsigned long __init map_spbank(unsigned long vbase, int sp_entry)
-{
-	unsigned long pstart = (sp_banks[sp_entry].base_addr & SRMMU_PGDIR_MASK);
-	unsigned long vstart = (vbase & SRMMU_PGDIR_MASK);
-	unsigned long vend = SRMMU_PGDIR_ALIGN(vbase + sp_banks[sp_entry].num_bytes);
-	/* Map "low" memory only */
-	const unsigned long min_vaddr = PAGE_OFFSET;
-	const unsigned long max_vaddr = PAGE_OFFSET + SRMMU_MAXMEM;
-
-	if (vstart < min_vaddr || vstart >= max_vaddr)
-		return vstart;
-	
-	if (vend > max_vaddr || vend < min_vaddr)
-		vend = max_vaddr;
-
-	while(vstart < vend) {
-		do_large_mapping(vstart, pstart);
-		vstart += SRMMU_PGDIR_SIZE; pstart += SRMMU_PGDIR_SIZE;
-	}
-	return vstart;
-}
-
-static inline void memprobe_error(char *msg)
-{
-	prom_printf(msg);
-	prom_printf("Halting now...\n");
-	prom_halt();
-}
-
 static inline void map_kernel(void)
 {
-	int i;
+	struct memblock_region *reg;
 
 	if (phys_base > 0) {
 		do_large_mapping(PAGE_OFFSET, phys_base);
 	}
 
-	for (i = 0; sp_banks[i].num_bytes != 0; i++) {
-		map_spbank((unsigned long)__va(sp_banks[i].base_addr), i);
+	for_each_memblock(memory, reg) {
+		unsigned long vbase = (unsigned long)__va(reg->base);
+		unsigned long pstart = reg->base & SRMMU_PGDIR_MASK;
+		unsigned long vstart = vbase & SRMMU_PGDIR_MASK;
+		unsigned long vend = SRMMU_PGDIR_ALIGN(vbase + reg->size);
+
+		while (vstart < vend) {
+			do_large_mapping(vstart, pstart);
+			vstart += SRMMU_PGDIR_SIZE;
+			pstart += SRMMU_PGDIR_SIZE;
+		}
 	}
 
 	BTFIXUPSET_SIMM13(user_ptrs_per_pgd, PAGE_OFFSET / SRMMU_PGDIR_SIZE);
@@ -1258,8 +1237,6 @@ extern void sparc_context_init(int);
 
 void (*poke_srmmu)(void) __cpuinitdata = NULL;
 
-extern unsigned long bootmem_init(unsigned long *pages_avail);
-
 void __init srmmu_paging_init(void)
 {
 	int i;
@@ -1268,7 +1245,6 @@ void __init srmmu_paging_init(void)
 	pgd_t *pgd;
 	pmd_t *pmd;
 	pte_t *pte;
-	unsigned long pages_avail;
 
 	sparc_iomap.start = SUN4M_IOBASE_VADDR;	/* 16MB of IOSPACE on all sun4m's. */
 
@@ -1292,9 +1268,7 @@ void __init srmmu_paging_init(void)
 		prom_printf("Something wrong, can't find cpu node in paging_init.\n");
 		prom_halt();
 	}
-
-	pages_avail = 0;
-	last_valid_pfn = bootmem_init(&pages_avail);
+	find_ramdisk(phys_base);
 
 	srmmu_nocache_calcsize();
 	srmmu_nocache_init();
@@ -1334,29 +1308,7 @@ void __init srmmu_paging_init(void)
 	flush_tlb_all();
 
 	sparc_context_init(num_contexts);
-
 	kmap_init();
-
-	{
-		unsigned long zones_size[MAX_NR_ZONES];
-		unsigned long zholes_size[MAX_NR_ZONES];
-		unsigned long npages;
-		int znum;
-
-		for (znum = 0; znum < MAX_NR_ZONES; znum++)
-			zones_size[znum] = zholes_size[znum] = 0;
-
-		npages = max_low_pfn - pfn_base;
-
-		zones_size[ZONE_DMA] = npages;
-		zholes_size[ZONE_DMA] = npages - pages_avail;
-
-		npages = highend_pfn - max_low_pfn;
-		zones_size[ZONE_HIGHMEM] = npages;
-		zholes_size[ZONE_HIGHMEM] = npages - calc_highpages();
-
-		free_area_init_node(0, zones_size, pfn_base, zholes_size);
-	}
 }
 
 static void srmmu_mmu_info(struct seq_file *m)
diff --git a/arch/sparc/mm/sun4c.c b/arch/sparc/mm/sun4c.c
index 1cf4f19..4e1edb0 100644
--- a/arch/sparc/mm/sun4c.c
+++ b/arch/sparc/mm/sun4c.c
@@ -1945,21 +1945,17 @@ void sun4c_update_mmu_cache(struct vm_area_struct *vma, unsigned long address, p
 
 extern void sparc_context_init(int);
 extern unsigned long bootmem_init(unsigned long *pages_avail);
-extern unsigned long last_valid_pfn;
 
 void __init sun4c_paging_init(void)
 {
 	int i, cnt;
 	unsigned long kernel_end, vaddr;
 	extern struct resource sparc_iomap;
-	unsigned long end_pfn, pages_avail;
 
 	kernel_end = (unsigned long) &_end;
 	kernel_end = SUN4C_REAL_PGDIR_ALIGN(kernel_end);
 
-	pages_avail = 0;
-	last_valid_pfn = bootmem_init(&pages_avail);
-	end_pfn = last_valid_pfn;
+	find_ramdisk(phys_base);
 
 	sun4c_probe_mmu();
 	invalid_segment = (num_segmaps - 1);
@@ -1991,27 +1987,7 @@ void __init sun4c_paging_init(void)
 	swapper_pg_dir[vaddr>>SUN4C_PGDIR_SHIFT] = __pgd(PGD_TABLE | (unsigned long) pg3);
 	sun4c_init_ss2_cache_bug();
 	sparc_context_init(num_contexts);
-
-	{
-		unsigned long zones_size[MAX_NR_ZONES];
-		unsigned long zholes_size[MAX_NR_ZONES];
-		unsigned long npages;
-		int znum;
-
-		for (znum = 0; znum < MAX_NR_ZONES; znum++)
-			zones_size[znum] = zholes_size[znum] = 0;
-
-		npages = max_low_pfn - pfn_base;
-
-		zones_size[ZONE_DMA] = npages;
-		zholes_size[ZONE_DMA] = npages - pages_avail;
-
-		npages = highend_pfn - max_low_pfn;
-		zones_size[ZONE_HIGHMEM] = npages;
-		zholes_size[ZONE_HIGHMEM] = npages - calc_highpages();
-
-		free_area_init_node(0, zones_size, pfn_base, zholes_size);
-	}
+	/* SAM pass memory to buddy */
 
 	cnt = 0;
 	for (i = 0; i < num_segmaps; i++)
diff --git a/arch/sparc/prom/init_32.c b/arch/sparc/prom/init_32.c
index 26c64ce..bb3b352 100644
--- a/arch/sparc/prom/init_32.c
+++ b/arch/sparc/prom/init_32.c
@@ -31,7 +31,6 @@ struct linux_nodeops *prom_nodeops;
  * failure.  It gets passed the pointer to the PROM vector.
  */
 
-extern void prom_meminit(void);
 extern void prom_ranges_init(void);
 
 void __init prom_init(struct linux_romvec *rp)
@@ -67,7 +66,7 @@ void __init prom_init(struct linux_romvec *rp)
 	   (((unsigned long) prom_nodeops) = -1))
 		prom_halt();
 
-	prom_meminit();
+	prom_memblock_add_mem();
 
 	prom_ranges_init();
 
diff --git a/arch/sparc/prom/memory.c b/arch/sparc/prom/memory.c
index 3f263a6..4bfddcf 100644
--- a/arch/sparc/prom/memory.c
+++ b/arch/sparc/prom/memory.c
@@ -5,30 +5,23 @@
  * Copyright (C) 1997 Michael A. Griffith (grif@acm.org)
  */
 
+#include <linux/memblock.h>
 #include <linux/kernel.h>
-#include <linux/sort.h>
 #include <linux/init.h>
 
 #include <asm/openprom.h>
 #include <asm/oplib.h>
 #include <asm/page.h>
 
-static int __init prom_meminit_v0(void)
+static void __init prom_memblock_add_v0(void)
 {
 	struct linux_mlist_v0 *p;
-	int index;
 
-	index = 0;
-	for (p = *(romvec->pv_v0mem.v0_available); p; p = p->theres_more) {
-		sp_banks[index].base_addr = (unsigned long) p->start_adr;
-		sp_banks[index].num_bytes = p->num_bytes;
-		index++;
-	}
-
-	return index;
+	for (p = *(romvec->pv_v0mem.v0_available); p; p = p->theres_more)
+		memblock_add(p->start_adr, p->num_bytes);
 }
 
-static int __init prom_meminit_v2(void)
+static void __init prom_memblock_add_v2(void)
 {
 	struct linux_prom_registers reg[64];
 	phandle node;
@@ -38,50 +31,24 @@ static int __init prom_meminit_v2(void)
 	size = prom_getproperty(node, "available", (char *) reg, sizeof(reg));
 	num_ents = size / sizeof(struct linux_prom_registers);
 
-	for (i = 0; i < num_ents; i++) {
-		sp_banks[i].base_addr = reg[i].phys_addr;
-		sp_banks[i].num_bytes = reg[i].reg_size;
-	}
-
-	return num_ents;
-}
-
-static int sp_banks_cmp(const void *a, const void *b)
-{
-	const struct sparc_phys_banks *x = a, *y = b;
-
-	if (x->base_addr > y->base_addr)
-		return 1;
-	if (x->base_addr < y->base_addr)
-		return -1;
-	return 0;
+	for (i = 0; i < num_ents; i++)
+		memblock_add_node(reg[i].phys_addr, reg[i].reg_size, 0);
 }
 
-/* Initialize the memory lists based upon the prom version. */
-void __init prom_meminit(void)
+/* Read memory layout definitions from prom and add to memblock. */
+void __init prom_memblock_add_mem(void)
 {
-	int i, num_ents = 0;
-
 	switch (prom_vers) {
 	case PROM_V0:
-		num_ents = prom_meminit_v0();
+		prom_memblock_add_v0();
 		break;
 
 	case PROM_V2:
 	case PROM_V3:
-		num_ents = prom_meminit_v2();
+		prom_memblock_add_v2();
 		break;
 
 	default:
 		break;
 	}
-	sort(sp_banks, num_ents, sizeof(struct sparc_phys_banks),
-	     sp_banks_cmp, NULL);
-
-	/* Sentinel.  */
-	sp_banks[num_ents].base_addr = 0xdeadbeef;
-	sp_banks[num_ents].num_bytes = 0;
-
-	for (i = 0; i < num_ents; i++)
-		sp_banks[i].num_bytes &= PAGE_MASK;
 }
