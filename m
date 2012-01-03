From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 03 Jan 2012 20:45:16 +0000
Subject: [WIP] sparc32: replace bootmem with memblock
Message-Id: <20120103204516.GA4271@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

sparc32 uses a combination of a local memory handling and bootmem
to handle memory in the early stage of the boot.

Some time ago I started to look at what was required to replace
the local memory handling (sp_banks) with memblock - which I understood
was the generic way to handle memory in the early phases of
the boot.

Tejun have posted a nice series of patches that clean up
memblock so it should be possible to replace bootmem too.

Now that this patchset is most likely hitting mainline
in next merge window I decided to take a fresh look at
introducing memblock for sparc32.

The following is a WIP patch.
It is posted to allow you to take a look and give early feedback.

As time permit I plan to divide the patch in a few smaller
preparational pacthes - and one big patch that do
the actual replacement.
I hope to have something working that I can post in
good time before the 3.3 merge window - I will
need testers before it can be applied to mainline.

The patch is maybe 90% finished - and the diffstat looks promising.
 11 files changed, 133 insertions(+), 391 deletions(-)

What is even better is that much of the added code is simpler
than the code it replaces.

Some notes to the patch:

- The setup of memblock and much of the other memory stuff is
  moved to paging_init().
  We no longer setup memory before calling start_kernel()

- The setup of initrd follows the same scheme as sparc64.
  I have deleted a check that I could not understand - and I
  could see sparc64 deleted the same check some time ago.
  It is:

-               if (initrd_start) {
-                       if (initrd_start >= (start_pfn << PAGE_SHIFT) &&
-                           initrd_start < (start_pfn << PAGE_SHIFT) + 2 * PAGE_SIZE)
-                               bootmap_pfn = PAGE_ALIGN (initrd_end) >> PAGE_SHIFT;
-               }


- Handling og highmen is like wrong.
  I have not found any good source how to deal with highmen.
  What I did was to:
  1) Locate all highmem added to memblock
     (address > (phys_base + SRMMU_MAXMEM))
  2) Map the highmem
  3) reserve all the highmem in memblock - so it is not
     passed over to the page allocator.
  this all takes place in paging_init()

- kern_addr_valid is (temporary) disabled
  I could not grock the code allocating sparc_valid_addr_bitmap
  and I noticed most archs do not implement this check

- There is some code dealing with zholes_size[] that I know is buggy
  but need to understnad it first.

- Printing number of reserved pages are dropped as it was
  not trivial to implment in the same way.

- ARCH_PFN_OFFSET is dropped. It is unused
- pfn_valid is made as a simple range check
- virt_addr_valid is redefined to use pfn_valid - much simpler

My TODO items:
- split up in smaller patches, as feasible
- fix the zholes_size stuff
- add more comments
- address comments from this WIP posting
- get it working on my sparc32 box

Any comments are welcome!

	Sam


 arch/sparc/Kconfig                  |    3 +-
 arch/sparc/include/asm/mmu_32.h     |    3 +
 arch/sparc/include/asm/oplib_32.h   |    1 +
 arch/sparc/include/asm/page_32.h    |   22 +--
 arch/sparc/include/asm/pgtable_32.h |    6 +-
 arch/sparc/kernel/setup_32.c        |   17 --
 arch/sparc/mm/fault_32.c            |   12 --
 arch/sparc/mm/init_32.c             |  336 ++++++++++-------------------------
 arch/sparc/mm/srmmu.c               |   60 ++-----
 arch/sparc/mm/sun4c.c               |    9 +-
 arch/sparc/prom/memory.c            |   55 ++-----
 11 files changed, 133 insertions(+), 391 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 7cb8adf..6faf337 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -26,12 +26,14 @@ config SPARC
 	select HAVE_DMA_API_DEBUG
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_GENERIC_HARDIRQS
+	select HAVE_MEMBLOCK
 	select GENERIC_IRQ_SHOW
 	select USE_GENERIC_SMP_HELPERS if SMP
 
 config SPARC32
 	def_bool !64BIT
 	select GENERIC_ATOMIC64
+	select NO_BOOTMEM
 
 config SPARC64
 	def_bool 64BIT
@@ -43,7 +45,6 @@ config SPARC64
 	select HAVE_KRETPROBES
 	select HAVE_KPROBES
 	select HAVE_RCU_TABLE_FREE if SMP
-	select HAVE_MEMBLOCK
 	select HAVE_SYSCALL_WRAPPERS
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD
diff --git a/arch/sparc/include/asm/mmu_32.h b/arch/sparc/include/asm/mmu_32.h
index 6f056e5..2d9ade2 100644
--- a/arch/sparc/include/asm/mmu_32.h
+++ b/arch/sparc/include/asm/mmu_32.h
@@ -7,4 +7,7 @@ typedef unsigned long mm_context_t;
 /* mm/srmmu.c */
 extern ctxd_t *srmmu_ctx_table_phys;
 
+/* mm/init_32.c */
+void __init find_ramdisk(unsigned long phys_base);
+
 #endif
diff --git a/arch/sparc/include/asm/oplib_32.h b/arch/sparc/include/asm/oplib_32.h
index 71e5e9a..e80104f 100644
--- a/arch/sparc/include/asm/oplib_32.h
+++ b/arch/sparc/include/asm/oplib_32.h
@@ -115,6 +115,7 @@ extern void prom_putsegment(int context, unsigned long virt_addr,
 
 /* Initialize the memory lists based upon the prom version. */
 void prom_meminit(void);
+void prom_memblock_add_mem(void);
 
 /* PROM device tree traversal functions... */
 
diff --git a/arch/sparc/include/asm/page_32.h b/arch/sparc/include/asm/page_32.h
index bb5c2ac..522af2f 100644
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
+extern unsigned long last_valid_pfn;
 #endif
 #define __pa(x)			((unsigned long)(x) - PAGE_OFFSET + phys_base)
 #define __va(x)			((void *)((unsigned long) (x) - phys_base + PAGE_OFFSET))
@@ -138,11 +123,10 @@ extern unsigned long pfn_base;
 #define virt_to_phys		__pa
 #define phys_to_virt		__va
 
-#define ARCH_PFN_OFFSET		(pfn_base)
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
 
-#define pfn_valid(pfn)		(((pfn) >= (pfn_base)) && (((pfn)-(pfn_base)) < max_mapnr))
-#define virt_addr_valid(kaddr)	((((unsigned long)(kaddr)-PAGE_OFFSET)>>PAGE_SHIFT) < max_mapnr)
+#define pfn_valid(pfn)		((pfn) >= pfn_base && (pfn) <= last_valid_pfn)
+#define virt_addr_valid(kaddr)	pfn_valid(PFN_DOWN(__pa(kaddr)))
 
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index a790cc6..04234d5 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -425,11 +425,9 @@ __get_iospace (unsigned long addr)
 	}
 }
 
-extern unsigned long *sparc_valid_addr_bitmap;
-
+// extern unsigned long *sparc_valid_addr_bitmap;
 /* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
-#define kern_addr_valid(addr) \
-	(test_bit(__pa((unsigned long)(addr))>>20, sparc_valid_addr_bitmap))
+#define kern_addr_valid(addr) (1)
 
 /*
  * For sparc32&64, the pfn in io_remap_pfn_range() carries <iospace> in
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index fe1e3fc..06d7d6c 100644
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
index 8023fd7..0a4f5dc 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -49,18 +49,6 @@ int vac_size, vac_linesize, vac_do_hw_vac_flushes;
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
index 7b00de6..eb21de6 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -7,6 +7,7 @@
  *  Copyright (C) 2000 Anton Blanchard (anton@samba.org)
  */
 
+#include <linux/memblock.h>
 #include <linux/module.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
@@ -37,23 +38,25 @@
 #include <asm/prom.h>
 #include <asm/leon.h>
 
-unsigned long *sparc_valid_addr_bitmap;
-EXPORT_SYMBOL(sparc_valid_addr_bitmap);
-
 unsigned long phys_base;
 EXPORT_SYMBOL(phys_base);
 
 unsigned long pfn_base;
 EXPORT_SYMBOL(pfn_base);
 
+unsigned long last_valid_pfn;
+
 unsigned long page_kernel;
 EXPORT_SYMBOL(page_kernel);
 
-struct sparc_phys_banks sp_banks[SPARC_PHYS_BANKS+1];
 unsigned long sparc_unmapped_base;
 
 struct pgtable_cache_struct pgt_quicklists;
 
+/* Kernel physical address base and size in bytes.  */
+unsigned long kern_base __read_mostly;
+unsigned long kern_size __read_mostly;
+
 /* Initial ramdisk setup */
 extern unsigned int sparc_ramdisk_image;
 extern unsigned int sparc_ramdisk_size;
@@ -110,181 +113,45 @@ void __init sparc_context_init(int numctx)
 }
 
 extern unsigned long cmdline_memory_size;
-unsigned long last_valid_pfn;
-
-unsigned long calc_highpages(void)
-{
-	int i;
-	int nr = 0;
-
-	for (i = 0; sp_banks[i].num_bytes != 0; i++) {
-		unsigned long start_pfn = sp_banks[i].base_addr >> PAGE_SHIFT;
-		unsigned long end_pfn = (sp_banks[i].base_addr + sp_banks[i].num_bytes) >> PAGE_SHIFT;
-
-		if (end_pfn <= max_low_pfn)
-			continue;
-
-		if (start_pfn < max_low_pfn)
-			start_pfn = max_low_pfn;
-
-		nr += end_pfn - start_pfn;
-	}
-
-	return nr;
-}
 
-static unsigned long calc_max_low_pfn(void)
+/* Reserve memory for initrd (if present) */
+void __init find_ramdisk(unsigned long phys_base)
 {
-	int i;
-	unsigned long tmp = pfn_base + (SRMMU_MAXMEM >> PAGE_SHIFT);
-	unsigned long curr_pfn, last_pfn;
+#ifdef CONFIG_BLK_DEV_INITRD
+	/* Now have to check initial ramdisk, so that bootmap does not overwrite it */
+	if (!sparc_ramdisk_image)
+		return;
 
-	last_pfn = (sp_banks[0].base_addr + sp_banks[0].num_bytes) >> PAGE_SHIFT;
-	for (i = 1; sp_banks[i].num_bytes != 0; i++) {
-		curr_pfn = sp_banks[i].base_addr >> PAGE_SHIFT;
+	if (sparc_ramdisk_image >= (unsigned long)&_end - 2 * PAGE_SIZE)
+		sparc_ramdisk_image -= KERNBASE;
 
-		if (curr_pfn >= tmp) {
-			if (last_pfn < tmp)
-				tmp = last_pfn;
-			break;
-		}
+	initrd_start = sparc_ramdisk_image + phys_base;
 
-		last_pfn = (sp_banks[i].base_addr + sp_banks[i].num_bytes) >> PAGE_SHIFT;
+	if (memblock_reserve(initrd_start, sparc_ramdisk_size))
+	{
+		printk(KERN_CRIT "initrd reservation failed (0x%016lx:0x%016xl)",
+		                 initrd_start, sparc_ramdisk_size);
+		initrd_start = 0;
 	}
-
-	return tmp;
+#endif
 }
 
-unsigned long __init bootmem_init(unsigned long *pages_avail)
+static void map_high_region(unsigned long start_pfn, unsigned long end_pfn)
 {
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
+	unsigned long tmp;
 
-		size = (last_pfn - curr_pfn) << PAGE_SHIFT;
-		*pages_avail += last_pfn - curr_pfn;
+#ifdef CONFIG_DEBUG_HIGHMEM
+	printk("mapping high region %08lx - %08lx\n", start_pfn, end_pfn);
+#endif
 
-		free_bootmem(sp_banks[i].base_addr, size);
-	}
+	for (tmp = start_pfn; tmp < end_pfn; tmp++) {
+		struct page *page = pfn_to_page(tmp);
 
-#ifdef CONFIG_BLK_DEV_INITRD
-	if (initrd_start) {
-		/* Reserve the initrd image area. */
-		size = initrd_end - initrd_start;
-		reserve_bootmem(initrd_start, size, BOOTMEM_DEFAULT);
-		*pages_avail -= PAGE_ALIGN(size) >> PAGE_SHIFT;
-
-		initrd_start = (initrd_start - phys_base) + PAGE_OFFSET;
-		initrd_end = (initrd_end - phys_base) + PAGE_OFFSET;		
+		ClearPageReserved(page);
+		init_page_count(page);
+		__free_page(page);
+		totalhigh_pages++;
 	}
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
 }
 
 /*
@@ -318,6 +185,64 @@ EXPORT_SYMBOL(PAGE_SHARED);
 
 void __init paging_init(void)
 {
+	struct memblock_region *reg;
+	unsigned long highstart;
+	unsigned long highstart_pfn;
+
+	kern_base = KERNBASE;
+	kern_size = (unsigned long)&_end - (unsigned long)KERNBASE;
+
+	memblock_init();
+
+	/* read memory info from prom */
+	prom_memblock_add_mem();
+
+	/* limit memory if "mem=xxx" was specified on command line */
+	memblock_enforce_memory_limit(cmdline_memory_size);
+
+	/* prepare memblock for later use */
+	memblock_analyze();
+
+	/* reserve memory for the kernel */
+	memblock_reserve(kern_base, kern_size);
+
+	/* Lowest address in available */
+	phys_base = memblock_start_of_DRAM();
+	pfn_base = PFN_DOWN(phys_base);
+
+	/* Highest valid pfn - from highest address */
+	last_valid_pfn = PFN_DOWN(memblock_end_of_DRAM());
+
+	/* Find and reserve highmem.
+         * HighMem is the physical memory above (phys_base + SRMMU_MAXMEM).
+         * Iterate through all memoryblocks until we hit one with a too high address.
+         * then reserve this and remaining memmory.
+         */
+
+	highstart = phys_base + SRMMU_MAXMEM;
+	highstart_pfn = PFN_DOWN(phys_base + SRMMU_MAXMEM);
+	totalhigh_pages = 0;
+
+	for_each_memblock(memory, reg) {
+		unsigned long size = reg->size;
+		unsigned long start_pfn;
+		unsigned long end_pfn;
+
+		start_pfn = PFN_DOWN(reg->base);
+		end_pfn = PFN_DOWN(reg->base + size);
+
+		if (end_pfn <= highstart_pfn)
+			continue;
+
+		if (start_pfn < highstart_pfn)
+                        start_pfn = highstart_pfn;
+
+		map_high_region(start_pfn, end_pfn);
+	}
+	/* Reserve all highmem in memblock - this may be nothing */
+	memblock_reserve(highstart, memblock_end_of_DRAM() - highstart);
+
+
 	switch(sparc_cpu_model) {
 	case sun4c:
 	case sun4e:
@@ -365,48 +290,11 @@ void __init paging_init(void)
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
@@ -418,43 +306,12 @@ void __init mem_init(void)
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
 	high_memory = __va(max_low_pfn << PAGE_SHIFT);
 
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
@@ -464,17 +321,10 @@ void __init mem_init(void)
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
 	       datapages << (PAGE_SHIFT-10), 
 	       initpages << (PAGE_SHIFT-10),
 	       totalhigh_pages << (PAGE_SHIFT-10));
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index cbef74e..128d9e8 100644
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
 
 	srmmu_nocache_npages @@ -1208,46 +1205,25 @@ static void __init do_large_mapping(unsigned long vaddr, unsigned long phys_base
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
@@ -1258,8 +1234,6 @@ extern void sparc_context_init(int);
 
 void (*poke_srmmu)(void) __cpuinitdata = NULL;
 
-extern unsigned long bootmem_init(unsigned long *pages_avail);
-
 void __init srmmu_paging_init(void)
 {
 	int i;
@@ -1268,7 +1242,6 @@ void __init srmmu_paging_init(void)
 	pgd_t *pgd;
 	pmd_t *pmd;
 	pte_t *pte;
-	unsigned long pages_avail;
 
 	sparc_iomap.start = SUN4M_IOBASE_VADDR;	/* 16MB of IOSPACE on all sun4m's. */
 
@@ -1293,8 +1266,7 @@ void __init srmmu_paging_init(void)
 		prom_halt();
 	}
 
-	pages_avail = 0;
-	last_valid_pfn = bootmem_init(&pages_avail);
+	find_ramdisk(phys_base);
 
 	srmmu_nocache_calcsize();
 	srmmu_nocache_init();
@@ -1349,7 +1321,7 @@ void __init srmmu_paging_init(void)
 		npages = max_low_pfn - pfn_base;
 
 		zones_size[ZONE_DMA] = npages;
-		zholes_size[ZONE_DMA] = npages - pages_avail;
+		zholes_size[ZONE_DMA] = npages - 0; // TODO pages_avail;
 
 		npages = highend_pfn - max_low_pfn;
 		zones_size[ZONE_HIGHMEM] = npages;
diff --git a/arch/sparc/mm/sun4c.c b/arch/sparc/mm/sun4c.c
index 1cf4f19..3b423d6 100644
--- a/arch/sparc/mm/sun4c.c
+++ b/arch/sparc/mm/sun4c.c
@@ -1944,22 +1944,17 @@ void sun4c_update_mmu_cache(struct vm_area_struct *vma, unsigned long address, p
 }
 
 extern void sparc_context_init(int);
-extern unsigned long bootmem_init(unsigned long *pages_avail);
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
+	find_ramdisk(phy_base);
 
 	sun4c_probe_mmu();
 	invalid_segment = (num_segmaps - 1);
@@ -2004,7 +1999,7 @@ void __init sun4c_paging_init(void)
 		npages = max_low_pfn - pfn_base;
 
 		zones_size[ZONE_DMA] = npages;
-		zholes_size[ZONE_DMA] = npages - pages_avail;
+		zholes_size[ZONE_DMA] = npages - 0; // TODO pages_avail;
 
 		npages = highend_pfn - max_low_pfn;
 		zones_size[ZONE_HIGHMEM] = npages;
diff --git a/arch/sparc/prom/memory.c b/arch/sparc/prom/memory.c
index 3f263a6..48c6e85 100644
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
+		memblock_add(reg[i].phys_addr, reg[i].reg_size);
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
