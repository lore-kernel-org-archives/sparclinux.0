From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Sun, 21 Mar 2004 22:51:45 +0000
Subject: Re: nonzero phys_base
Message-Id: <20040321225145.GA22808@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040316114121.GA5170@spike>
In-Reply-To: <20040316114121.GA5170@spike>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Mar 18, 2004 at 12:58:29AM +0100, Stefan Holst wrote:

> hmm, never thought about highmem support... i'm working on 4mb here - for
> everything ;). i have no idea how to handle this issue yet.

There was actually just one crucial bit wrong that broke highmem;
highstart_pfn was miscalculated.  The assumption that low memory means
low addresses doesn't seem to be used anywhere.

Some Sun systems won't even boot to prom without memory in slot 0;
ss4/5 seem to be this way.  I did test ss20 with and without slot 0
filled, with and without highmem and it seems ok.  I'd still recommend
filling slot 0 on Sun systems.

After fixing that and eliminating a few more useless shifts, I applied
the below patch.  Thanks Stefan.

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/03/21 14:43:40-08:00 wesolows@foobazco.org 
#   [SPARC32]: Support memory starting at physical address other than 0
#   
#   From: Stefan Holst <mail@s-holst.de>
#   
#   Allow physical memory to start at almost arbitrary addresses.  LEON
#   needs it, so do SPARCstation 10/20 without slot 0 populated.  Although
#   Sun do not support this configuration, at least some such systems can
#   boot with this patch.
#   
#   Physical memory starting at or above 0xF4000000 is not supported.
# 
# include/asm-sparc/pgtable.h
#   2004/03/21 14:43:34-08:00 wesolows@foobazco.org +1 -0
#   [SPARC32]: Support memory starting at physical address other than 0
# 
# include/asm-sparc/page.h
#   2004/03/21 14:43:34-08:00 wesolows@foobazco.org +14 -9
#   [SPARC32]: Support memory starting at physical address other than 0
# 
# arch/sparc/mm/sun4c.c
#   2004/03/21 14:43:34-08:00 wesolows@foobazco.org +2 -2
#   [SPARC32]: Support memory starting at physical address other than 0
# 
# arch/sparc/mm/srmmu.c
#   2004/03/21 14:43:34-08:00 wesolows@foobazco.org +6 -10
#   [SPARC32]: Support memory starting at physical address other than 0
# 
# arch/sparc/mm/init.c
#   2004/03/21 14:43:34-08:00 wesolows@foobazco.org +10 -13
#   [SPARC32]: Support memory starting at physical address other than 0
# 
# arch/sparc/kernel/sparc_ksyms.c
#   2004/03/21 14:43:34-08:00 wesolows@foobazco.org +1 -0
#   [SPARC32]: Support memory starting at physical address other than 0
# 
# arch/sparc/kernel/setup.c
#   2004/03/21 14:43:34-08:00 wesolows@foobazco.org +1 -0
#   [SPARC32]: Support memory starting at physical address other than 0
# 
diff -Nru a/arch/sparc/kernel/setup.c b/arch/sparc/kernel/setup.c
--- a/arch/sparc/kernel/setup.c	Sun Mar 21 14:44:13 2004
+++ b/arch/sparc/kernel/setup.c	Sun Mar 21 14:44:13 2004
@@ -331,6 +331,7 @@
 		if (highest_paddr < top)
 			highest_paddr = top;
 	}
+	pfn_base = phys_base >> PAGE_SHIFT;
 
 	if (!root_flags)
 		root_mountflags &= ~MS_RDONLY;
diff -Nru a/arch/sparc/kernel/sparc_ksyms.c b/arch/sparc/kernel/sparc_ksyms.c
--- a/arch/sparc/kernel/sparc_ksyms.c	Sun Mar 21 14:44:13 2004
+++ b/arch/sparc/kernel/sparc_ksyms.c	Sun Mar 21 14:44:13 2004
@@ -145,6 +145,7 @@
 
 EXPORT_SYMBOL(sparc_valid_addr_bitmap);
 EXPORT_SYMBOL(phys_base);
+EXPORT_SYMBOL(pfn_base);
 
 /* Atomic operations. */
 EXPORT_SYMBOL(___atomic24_add);
diff -Nru a/arch/sparc/mm/init.c b/arch/sparc/mm/init.c
--- a/arch/sparc/mm/init.c	Sun Mar 21 14:44:13 2004
+++ b/arch/sparc/mm/init.c	Sun Mar 21 14:44:13 2004
@@ -38,6 +38,7 @@
 unsigned long *sparc_valid_addr_bitmap;
 
 unsigned long phys_base;
+unsigned long pfn_base;
 
 unsigned long page_kernel;
 
@@ -134,7 +135,7 @@
 unsigned long calc_max_low_pfn(void)
 {
 	int i;
-	unsigned long tmp = (SRMMU_MAXMEM >> PAGE_SHIFT);
+	unsigned long tmp = pfn_base + (SRMMU_MAXMEM >> PAGE_SHIFT);
 	unsigned long curr_pfn, last_pfn;
 
 	last_pfn = (sp_banks[0].base_addr + sp_banks[0].num_bytes) >> PAGE_SHIFT;
@@ -189,9 +190,6 @@
 	 */
 	start_pfn  = (unsigned long)__pa(PAGE_ALIGN((unsigned long) &_end));
 
-	/* Adjust up to the physical address where the kernel begins. */
-	start_pfn += phys_base;
-
 	/* Now shift down to get the real physical page frame number. */
 	start_pfn >>= PAGE_SHIFT;
 
@@ -202,8 +200,8 @@
 	max_low_pfn = max_pfn;
 	highstart_pfn = highend_pfn = max_pfn;
 
-	if (max_low_pfn > (SRMMU_MAXMEM >> PAGE_SHIFT)) {
-		highstart_pfn = (SRMMU_MAXMEM >> PAGE_SHIFT);
+	if (max_low_pfn > pfn_base + (SRMMU_MAXMEM >> PAGE_SHIFT)) {
+		highstart_pfn = pfn_base + (SRMMU_MAXMEM >> PAGE_SHIFT);
 		max_low_pfn = calc_max_low_pfn();
 		printk(KERN_NOTICE "%ldMB HIGHMEM available.\n",
 		    calc_highpages() >> (20 - PAGE_SHIFT));
@@ -230,7 +228,8 @@
 	}
 #endif	
 	/* Initialize the boot-time allocator. */
-	bootmap_size = init_bootmem_node(NODE_DATA(0), bootmap_pfn, phys_base>>PAGE_SHIFT, max_low_pfn);
+	bootmap_size = init_bootmem_node(NODE_DATA(0), bootmap_pfn, pfn_base,
+					 max_low_pfn);
 
 	/* Now register the available physical memory with the
 	 * allocator.
@@ -267,8 +266,8 @@
 		reserve_bootmem(initrd_start, size);
 		*pages_avail -= PAGE_ALIGN(size) >> PAGE_SHIFT;
 
-		initrd_start += PAGE_OFFSET;
-		initrd_end += PAGE_OFFSET;
+		initrd_start = (initrd_start - phys_base) + PAGE_OFFSET;
+		initrd_end = (initrd_end - phys_base) + PAGE_OFFSET;		
 	}
 #endif
 	/* Reserve the kernel text/data/bss. */
@@ -432,7 +431,7 @@
 
 	taint_real_pages();
 
-	max_mapnr = last_valid_pfn - (phys_base >> PAGE_SHIFT);
+	max_mapnr = last_valid_pfn - pfn_base;
 	high_memory = __va(max_low_pfn << PAGE_SHIFT);
 
 	num_physpages = totalram_pages = free_all_bootmem();
@@ -474,11 +473,9 @@
 
 	addr = (unsigned long)(&__init_begin);
 	for (; addr < (unsigned long)(&__init_end); addr += PAGE_SIZE) {
-		unsigned long page;
 		struct page *p;
 
-		page = addr + phys_base;
-		p = virt_to_page(page);
+		p = virt_to_page(addr);
 
 		ClearPageReserved(p);
 		set_page_count(p, 1);
diff -Nru a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
--- a/arch/sparc/mm/srmmu.c	Sun Mar 21 14:44:13 2004
+++ b/arch/sparc/mm/srmmu.c	Sun Mar 21 14:44:13 2004
@@ -213,7 +213,7 @@
  * and a page entry and page directory to the page they refer to.
  */
 static pte_t srmmu_mk_pte(struct page *page, pgprot_t pgprot)
-{ return __pte(((page - mem_map) << (PAGE_SHIFT-4)) | pgprot_val(pgprot)); }
+{ return __pte((page_to_pfn(page) << (PAGE_SHIFT-4)) | pgprot_val(pgprot)); }
 
 static pte_t srmmu_mk_pte_phys(unsigned long page, pgprot_t pgprot)
 { return __pte(((page) >> 4) | pgprot_val(pgprot)); }
@@ -245,7 +245,7 @@
 	unsigned long ptp;	/* Physical address, shifted right by 4 */
 	int i;
 
-	ptp = (ptep - mem_map) << (PAGE_SHIFT-4);	/* watch for overflow */
+	ptp = page_to_pfn(ptep) << (PAGE_SHIFT-4);	/* watch for overflow */
 	for (i = 0; i < SRMMU_PTRS_PER_PTE_SOFT/SRMMU_PTRS_PER_PTE; i++) {
 		srmmu_set_pte((pte_t *)&pmdp->pmdv[i], SRMMU_ET_PTD | ptp);
 		ptp += (SRMMU_PTRS_PER_PTE*sizeof(pte_t) >> 4);
@@ -480,7 +480,7 @@
 
 	if ((pte = (unsigned long)srmmu_pte_alloc_one_kernel(mm, address)) = 0)
 		return NULL;
-	return mem_map + (__nocache_pa(pte) >> PAGE_SHIFT);
+	return pfn_to_page( __nocache_pa(pte) >> PAGE_SHIFT );
 }
 
 static void srmmu_free_pte_fast(pte_t *pte)
@@ -495,7 +495,7 @@
 	p = (unsigned long)page_address(pte);	/* Cached address (for test) */
 	if (p = 0)
 		BUG();
-	p = ((pte - mem_map) << PAGE_SHIFT);	/* Physical address */
+	p = page_to_pfn(pte) << PAGE_SHIFT;	/* Physical address */
 	p = (unsigned long) __nocache_va(p);	/* Nocached virtual */
 	srmmu_free_nocache(p, SRMMU_PTE_SZ_SOFT);
 }
@@ -1316,7 +1316,7 @@
 		for (znum = 0; znum < MAX_NR_ZONES; znum++)
 			zones_size[znum] = zholes_size[znum] = 0;
 
-		npages = max_low_pfn - (phys_base >> PAGE_SHIFT);
+		npages = max_low_pfn - pfn_base;
 
 		zones_size[ZONE_DMA] = npages;
 		zholes_size[ZONE_DMA] = npages - pages_avail;
@@ -1326,13 +1326,9 @@
 		zholes_size[ZONE_HIGHMEM] = npages - calc_highpages();
 
 		free_area_init_node(0, &contig_page_data, NULL, zones_size,
-				    phys_base >> PAGE_SHIFT, zholes_size);
+				    pfn_base, zholes_size);
 		mem_map = contig_page_data.node_mem_map;
 	}
-
-/* P3: easy to fix, todo. Current code is utterly broken, though. */
-	if (phys_base != 0)
-		panic("phys_base nonzero");
 }
 
 static void srmmu_mmu_info(struct seq_file *m)
diff -Nru a/arch/sparc/mm/sun4c.c b/arch/sparc/mm/sun4c.c
--- a/arch/sparc/mm/sun4c.c	Sun Mar 21 14:44:13 2004
+++ b/arch/sparc/mm/sun4c.c	Sun Mar 21 14:44:13 2004
@@ -2088,7 +2088,7 @@
 		for (znum = 0; znum < MAX_NR_ZONES; znum++)
 			zones_size[znum] = zholes_size[znum] = 0;
 
-		npages = max_low_pfn - (phys_base >> PAGE_SHIFT);
+		npages = max_low_pfn - pfn_base;
 
 		zones_size[ZONE_DMA] = npages;
 		zholes_size[ZONE_DMA] = npages - pages_avail;
@@ -2098,7 +2098,7 @@
 		zholes_size[ZONE_HIGHMEM] = npages - calc_highpages();
 
 		free_area_init_node(0, &contig_page_data, NULL, zones_size,
-				    phys_base >> PAGE_SHIFT, zholes_size);
+				    pfn_base, zholes_size);
 		mem_map = contig_page_data.node_mem_map;
 	}
 
diff -Nru a/include/asm-sparc/page.h b/include/asm-sparc/page.h
--- a/include/asm-sparc/page.h	Sun Mar 21 14:44:13 2004
+++ b/include/asm-sparc/page.h	Sun Mar 21 14:44:13 2004
@@ -156,17 +156,22 @@
 #define PAGE_ALIGN(addr)  (((addr)+PAGE_SIZE-1)&PAGE_MASK)
 
 #define PAGE_OFFSET	0xf0000000
-#define __pa(x)                 ((unsigned long)(x) - PAGE_OFFSET)
-#define __va(x)                 ((void *)((unsigned long) (x) + PAGE_OFFSET))
+#ifndef __ASSEMBLY__
+extern unsigned long phys_base;
+extern unsigned long pfn_base;
+#endif
+#define __pa(x)			((unsigned long)(x) - PAGE_OFFSET + phys_base)
+#define __va(x)			((void *)((unsigned long) (x) - phys_base + PAGE_OFFSET))
 
-#define virt_to_phys(x)		__pa((unsigned long)(x))
-#define phys_to_virt(x)		__va((unsigned long)(x))
+#define virt_to_phys		__pa
+#define phys_to_virt		__va
 
-#define pfn_to_page(pfn)        (mem_map + (pfn))
-#define page_to_pfn(page)       ((unsigned long)((page) - mem_map))
-#define virt_to_page(kaddr)	(mem_map + (__pa(kaddr) >> PAGE_SHIFT))
-#define pfn_valid(pfn)		((pfn) < max_mapnr)
-#define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
+#define pfn_to_page(pfn)	(mem_map + ((pfn)-(pfn_base)))
+#define page_to_pfn(page)	((unsigned long)(((page) - mem_map) + pfn_base))
+#define virt_to_page(kaddr)	(mem_map + ((((unsigned long)(kaddr)-PAGE_OFFSET)>>PAGE_SHIFT)))
+
+#define pfn_valid(pfn)		(((pfn) >= (pfn_base)) && (((pfn)-(pfn_base)) < max_mapnr))
+#define virt_addr_valid(kaddr)	((((unsigned long)(kaddr)-PAGE_OFFSET)>>PAGE_SHIFT) < max_mapnr)
 
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
diff -Nru a/include/asm-sparc/pgtable.h b/include/asm-sparc/pgtable.h
--- a/include/asm-sparc/pgtable.h	Sun Mar 21 14:44:13 2004
+++ b/include/asm-sparc/pgtable.h	Sun Mar 21 14:44:13 2004
@@ -181,6 +181,7 @@
  * hit for all __pa()/__va() operations.
  */
 extern unsigned long phys_base;
+extern unsigned long pfn_base;
 
 /*
  * BAD_PAGETABLE is used when we need a bogus page-table, while


-- 
Keith M Wesolowski
