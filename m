From: Stefan Holst <mail@s-holst.de>
Date: Wed, 17 Mar 2004 23:58:29 +0000
Subject: Re: nonzero phys_base
Message-Id: <20040317235828.GB5754@spike>
List-Id: <sparclinux.vger.kernel.org>
References: <20040316114121.GA5170@spike>
In-Reply-To: <20040316114121.GA5170@spike>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 03/16, Pete Zaitcev wrote:
> On Tue, 16 Mar 2004 12:41:21 +0100
> Stefan Holst <mail@s-holst.de> wrote:
> 
> Looks good on the whole, especially in that you accepted a correct
> relationship between PFN and indexing into mem_map.
> 
> The only little problem is:
> 
> > +#define __pa(x)			((unsigned long)(x) - PAGE_OFFSET + phys_base)
> > +#define __va(x)			((void *)((unsigned long) (x) - phys_base + PAGE_OFFSET))
> 
> This, obviously, overflows on highmem systems.

hmm, never thought about highmem support... i'm working on 4mb here - for
everything ;). i have no idea how to handle this issue yet.

> Do we have any users for __pa, __va, virt_to_phys and phys_to_virt?
> It would be helpful if you enumerated all of them and perhaps
> removed some.

greped a bit and saw that the number of users for these macros are almost
equal.

> 
> > -#define virt_to_page(kaddr)	(mem_map + (__pa(kaddr) >> PAGE_SHIFT))
> > +#define virt_to_page(kaddr)	pfn_to_page(PFN(__pa(kaddr)))
> 
> This was correct before, because of the way mem_map was placed,
> its physical address never overflowed. But with nonzero phys_base,
> it is not correct anymore.
> 
> In fact you do not need this, just use
> 
>  mem_map + ((unsigned long)(x) - PAGE_OFFSET)
> 
> > +#define virt_addr_valid(kaddr)	pfn_valid(PFN(__pa(kaddr)))

thanks for the hints.
revised patch below, now also with pfn_base as keith suggested.


diff -ur a/arch/sparc/kernel/setup.c b/arch/sparc/kernel/setup.c
--- a/arch/sparc/kernel/setup.c	2004-03-11 11:32:58.000000000 +0100
+++ b/arch/sparc/kernel/setup.c	2004-03-17 23:57:08.993044448 +0100
@@ -330,6 +330,7 @@
 		if (highest_paddr < top)
 			highest_paddr = top;
 	}
+	pfn_base = phys_base >> PAGE_SHIFT;
 
 	if (!root_flags)
 		root_mountflags &= ~MS_RDONLY;
diff -ur a/arch/sparc/kernel/sparc_ksyms.c b/arch/sparc/kernel/sparc_ksyms.c
--- a/arch/sparc/kernel/sparc_ksyms.c	2004-03-11 11:32:58.000000000 +0100
+++ b/arch/sparc/kernel/sparc_ksyms.c	2004-03-17 23:57:09.005042624 +0100
@@ -145,6 +145,7 @@
 
 EXPORT_SYMBOL(sparc_valid_addr_bitmap);
 EXPORT_SYMBOL(phys_base);
+EXPORT_SYMBOL(pfn_base);
 
 /* Atomic operations. */
 EXPORT_SYMBOL(___atomic24_add);
diff -ur a/arch/sparc/mm/init.c b/arch/sparc/mm/init.c
--- a/arch/sparc/mm/init.c	2004-02-29 23:35:40.000000000 +0100
+++ b/arch/sparc/mm/init.c	2004-03-17 23:57:09.006042472 +0100
@@ -39,6 +39,8 @@
 
 unsigned long phys_base;
 
+unsigned long pfn_base;
+
 unsigned long page_kernel;
 
 struct sparc_phys_banks sp_banks[SPARC_PHYS_BANKS+1];
@@ -134,7 +136,7 @@
 unsigned long calc_max_low_pfn(void)
 {
 	int i;
-	unsigned long tmp = (SRMMU_MAXMEM >> PAGE_SHIFT);
+	unsigned long tmp = ((phys_base + SRMMU_MAXMEM) >> PAGE_SHIFT);
 	unsigned long curr_pfn, last_pfn;
 
 	last_pfn = (sp_banks[0].base_addr + sp_banks[0].num_bytes) >> PAGE_SHIFT;
@@ -189,9 +191,6 @@
 	 */
 	start_pfn  = (unsigned long)__pa(PAGE_ALIGN((unsigned long) &_end));
 
-	/* Adjust up to the physical address where the kernel begins. */
-	start_pfn += phys_base;
-
 	/* Now shift down to get the real physical page frame number. */
 	start_pfn >>= PAGE_SHIFT;
 
@@ -202,7 +201,7 @@
 	max_low_pfn = max_pfn;
 	highstart_pfn = highend_pfn = max_pfn;
 
-	if (max_low_pfn > (SRMMU_MAXMEM >> PAGE_SHIFT)) {
+	if (max_low_pfn > ((phys_base + SRMMU_MAXMEM) >> PAGE_SHIFT)) {
 		highstart_pfn = (SRMMU_MAXMEM >> PAGE_SHIFT);
 		max_low_pfn = calc_max_low_pfn();
 		printk(KERN_NOTICE "%ldMB HIGHMEM available.\n",
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
@@ -477,7 +476,7 @@
 		unsigned long page;
 		struct page *p;
 
-		page = addr + phys_base;
+		page = addr;
 		p = virt_to_page(page);
 
 		ClearPageReserved(p);
diff -ur a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
--- a/arch/sparc/mm/srmmu.c	2004-03-11 11:32:58.000000000 +0100
+++ b/arch/sparc/mm/srmmu.c	2004-03-17 23:56:24.168858760 +0100
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
@@ -1331,10 +1331,6 @@
 				    phys_base >> PAGE_SHIFT, zholes_size);
 		mem_map = contig_page_data.node_mem_map;
 	}
-
-/* P3: easy to fix, todo. Current code is utterly broken, though. */
-	if (phys_base != 0)
-		panic("phys_base nonzero");
 }
 
 static void srmmu_mmu_info(struct seq_file *m)
diff -ur a/include/asm-sparc/page.h b/include/asm-sparc/page.h
--- a/include/asm-sparc/page.h	2004-02-29 23:35:48.000000000 +0100
+++ b/include/asm-sparc/page.h	2004-03-17 23:57:09.006042472 +0100
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
+
+#define virt_to_phys		__pa
+#define phys_to_virt		__va
+
+#define pfn_to_page(pfn)	(mem_map + ((pfn)-(pfn_base)))
+#define page_to_pfn(page)	((unsigned long)(((page) - mem_map) + pfn_base))
+#define virt_to_page(kaddr)	(mem_map + ((((unsigned long)(kaddr)-PAGE_OFFSET)>>PAGE_SHIFT)))
 
-#define virt_to_phys(x)		__pa((unsigned long)(x))
-#define phys_to_virt(x)		__va((unsigned long)(x))
-
-#define pfn_to_page(pfn)        (mem_map + (pfn))
-#define page_to_pfn(page)       ((unsigned long)((page) - mem_map))
-#define virt_to_page(kaddr)	(mem_map + (__pa(kaddr) >> PAGE_SHIFT))
-#define pfn_valid(pfn)		((pfn) < max_mapnr)
-#define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
+#define pfn_valid(pfn)		(((pfn) >= (pfn_base)) && (((pfn)-(pfn_base)) < max_mapnr))
+#define virt_addr_valid(kaddr)	((((unsigned long)(kaddr)-PAGE_OFFSET)>>PAGE_SHIFT) < max_mapnr)
 
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
diff -ur a/include/asm-sparc/pgtable.h b/include/asm-sparc/pgtable.h
--- a/include/asm-sparc/pgtable.h	2004-02-29 23:36:24.000000000 +0100
+++ b/include/asm-sparc/pgtable.h	2004-03-17 23:57:09.039037456 +0100
@@ -181,6 +181,7 @@
  * hit for all __pa()/__va() operations.
  */
 extern unsigned long phys_base;
+extern unsigned long pfn_base;
 
 /*
  * BAD_PAGETABLE is used when we need a bogus page-table, while

-- 
RY  Stefan
+-----------------+----------------+
| mail@s-holst.de | www.s-holst.de |
+-----------------+----------------+
