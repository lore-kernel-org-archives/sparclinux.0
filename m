From: Stefan Holst <mail@s-holst.de>
Date: Tue, 16 Mar 2004 11:41:21 +0000
Subject: nonzero phys_base
Message-Id: <20040316114121.GA5170@spike>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

hello,

since konrad eisele has discontinued his work on leon2-support in linux,
i'm currently busy maintaining a updated patchset for newer kernel
versions. you will find some info about my patchset (and the patches
itself of course) here:

http://www.ra.informatik.uni-stuttgart.de/~holstsn/

what i have done yet besides some fixes is a big cleanup and make the
patches as least invasive as possible. my long term goal is to merge
them into mainstream kernel to finally get linux run on this free
processor core.
for those who are not familiar with leon2, see www.gaisler.com and/or
the archive of this list.

the whole patchset isn't yet ready for merging. but there is a feature
leon depends on and currently maked as broken in kernel: phys_base != 0.
the following small patch tries to fix this issue. the is completely
independent from leon support and changes as far as i see nothing, if
phys_base is zero.

how do you think about this fix? any chances to get this into the
kernel? if yes, how? this is the first time i send kernel patches,
so hints and comments are very welcome :).


diff -urN a/arch/sparc/mm/init.c b/arch/sparc/mm/init.c
--- a/arch/sparc/mm/init.c	2004-02-29 23:35:40.000000000 +0100
+++ b/arch/sparc/mm/init.c	2004-03-15 23:57:23.593256720 +0100
@@ -134,7 +134,7 @@
 unsigned long calc_max_low_pfn(void)
 {
 	int i;
-	unsigned long tmp = (SRMMU_MAXMEM >> PAGE_SHIFT);
+	unsigned long tmp = ((phys_base + SRMMU_MAXMEM) >> PAGE_SHIFT);
 	unsigned long curr_pfn, last_pfn;
 
 	last_pfn = (sp_banks[0].base_addr + sp_banks[0].num_bytes) >> PAGE_SHIFT;
@@ -189,9 +189,6 @@
 	 */
 	start_pfn  = (unsigned long)__pa(PAGE_ALIGN((unsigned long) &_end));
 
-	/* Adjust up to the physical address where the kernel begins. */
-	start_pfn += phys_base;
-
 	/* Now shift down to get the real physical page frame number. */
 	start_pfn >>= PAGE_SHIFT;
 
@@ -202,7 +199,7 @@
 	max_low_pfn = max_pfn;
 	highstart_pfn = highend_pfn = max_pfn;
 
-	if (max_low_pfn > (SRMMU_MAXMEM >> PAGE_SHIFT)) {
+	if (max_low_pfn > ((phys_base + SRMMU_MAXMEM) >> PAGE_SHIFT)) {
 		highstart_pfn = (SRMMU_MAXMEM >> PAGE_SHIFT);
 		max_low_pfn = calc_max_low_pfn();
 		printk(KERN_NOTICE "%ldMB HIGHMEM available.\n",
@@ -267,8 +264,8 @@
 		reserve_bootmem(initrd_start, size);
 		*pages_avail -= PAGE_ALIGN(size) >> PAGE_SHIFT;
 
-		initrd_start += PAGE_OFFSET;
-		initrd_end += PAGE_OFFSET;
+		initrd_start = (initrd_start - phys_base) + PAGE_OFFSET;
+		initrd_end = (initrd_end - phys_base) + PAGE_OFFSET;		
 	}
 #endif
 	/* Reserve the kernel text/data/bss. */
@@ -477,7 +474,7 @@
 		unsigned long page;
 		struct page *p;
 
-		page = addr + phys_base;
+		page = addr;
 		p = virt_to_page(page);
 
 		ClearPageReserved(p);
diff -urN a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
--- a/arch/sparc/mm/srmmu.c	2004-03-11 11:32:58.000000000 +0100
+++ b/arch/sparc/mm/srmmu.c	2004-03-15 23:57:23.992196072 +0100
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
diff -urN a/include/asm-sparc/page.h b/include/asm-sparc/page.h
--- a/include/asm-sparc/page.h	2004-02-29 23:35:48.000000000 +0100
+++ b/include/asm-sparc/page.h	2004-03-15 23:57:23.993195920 +0100
@@ -156,17 +156,22 @@
 #define PAGE_ALIGN(addr)  (((addr)+PAGE_SIZE-1)&PAGE_MASK)
 
 #define PAGE_OFFSET	0xf0000000
-#define __pa(x)                 ((unsigned long)(x) - PAGE_OFFSET)
-#define __va(x)                 ((void *)((unsigned long) (x) + PAGE_OFFSET))
+#ifndef __ASSEMBLY__
+extern unsigned long phys_base;
+#endif
+#define __pa(x)			((unsigned long)(x) - PAGE_OFFSET + phys_base)
+#define __va(x)			((void *)((unsigned long) (x) - phys_base + PAGE_OFFSET))
 
 #define virt_to_phys(x)		__pa((unsigned long)(x))
 #define phys_to_virt(x)		__va((unsigned long)(x))
 
-#define pfn_to_page(pfn)        (mem_map + (pfn))
-#define page_to_pfn(page)       ((unsigned long)((page) - mem_map))
-#define virt_to_page(kaddr)	(mem_map + (__pa(kaddr) >> PAGE_SHIFT))
-#define pfn_valid(pfn)		((pfn) < max_mapnr)
-#define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
+#define PFN(x)			((x) >> PAGE_SHIFT)
+#define PADDR(x)		((x) << PAGE_SHIFT)
+#define pfn_to_page(pfn)	(mem_map + (((unsigned long)pfn) - PFN(phys_base)))
+#define page_to_pfn(page)	(((unsigned long)((page) - mem_map)) + PFN(phys_base))
+#define virt_to_page(kaddr)	pfn_to_page(PFN(__pa(kaddr)))
+#define pfn_valid(pfn)		(((pfn) >= PFN(phys_base)) && (((pfn)-PFN(phys_base)) < max_mapnr))
+#define virt_addr_valid(kaddr)	pfn_valid(PFN(__pa(kaddr)))
 
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)



-- 
RY  Stefan
+-----------------+----------------+
| mail@s-holst.de | www.s-holst.de |
+-----------------+----------------+
