From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Tue, 06 Jan 2004 04:08:05 +0000
Subject: [SPARC32] Fix BUG-on-swapout
Message-Id: <20040106040805.GA13026@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This fixes BUG-on-swapout for srmmu-based systems.  The problem is
caused by kmap_atomic_to_page being fed an aliased (pagetable) address
and returning bogons.  This also adjusts the pkmap and fixmap base
addresses so they cannot overlap.

Dave, unless it's braindead, please apply.

diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet 2.5-sparc/arch/sparc/Kconfig 2.5-sparc-smp/arch/sparc/Kconfig
--- 2.5-sparc/arch/sparc/Kconfig	Sat Jan  3 02:08:07 2004
+++ 2.5-sparc-smp/arch/sparc/Kconfig	Sat Jan  3 02:11:02 2004
@@ -313,6 +313,13 @@
 	  This results in a large slowdown, but helps to find certain types
 	  of memory corruptions.
 
+config DEBUG_HIGHMEM
+	bool "Highmem debugging"
+	depends on DEBUG_KERNEL && HIGHMEM
+	help
+	  This options enables addition error checking for high memory systems.
+	  Disable for production systems.
+
 config DEBUG_SPINLOCK_SLEEP
 	bool "Sleep-inside-spinlock checking"
 	depends on DEBUG_KERNEL
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet 2.5-sparc/arch/sparc/mm/fault.c 2.5-sparc-smp/arch/sparc/mm/fault.c
--- 2.5-sparc/arch/sparc/mm/fault.c	Sat Jan  3 02:08:08 2004
+++ 2.5-sparc-smp/arch/sparc/mm/fault.c	Sat Jan  3 02:11:02 2004
@@ -36,7 +36,7 @@
 
 #define ELEMENTS(arr) (sizeof (arr)/sizeof (arr[0]))
 
-extern struct sparc_phys_banks sp_banks[SPARC_PHYS_BANKS];
+extern struct sparc_phys_banks sp_banks[SPARC_PHYS_BANKS+1];
 extern int prom_node_root;
 
 /* At boot time we determine these two values necessary for setting
@@ -72,7 +72,7 @@
 		mlist = mlist->theres_more;
 		bytes = mlist->num_bytes;
 		tally += bytes;
-		if (i >= SPARC_PHYS_BANKS-1) {
+		if (i > SPARC_PHYS_BANKS-1) {
 			printk ("The machine has more banks than "
 				"this kernel can support\n"
 				"Increase the SPARC_PHYS_BANKS "
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet 2.5-sparc/arch/sparc/mm/highmem.c 2.5-sparc-smp/arch/sparc/mm/highmem.c
--- 2.5-sparc/arch/sparc/mm/highmem.c	Sat Jan  3 02:08:08 2004
+++ 2.5-sparc-smp/arch/sparc/mm/highmem.c	Sat Jan  3 02:27:24 2004
@@ -27,6 +27,7 @@
 #include <asm/pgalloc.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
+#include <asm/fixmap.h>
 
 void *kmap_atomic(struct page *page, enum km_type type)
 {
@@ -39,7 +40,7 @@
 		return page_address(page);
 
 	idx = type + KM_TYPE_NR*smp_processor_id();
-	vaddr = fix_kmap_begin + idx * PAGE_SIZE;
+	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
 
 /* XXX Fix - Anton */
 #if 0
@@ -48,11 +49,10 @@
 	flush_cache_all();
 #endif
 
-#if HIGHMEM_DEBUG
-	if (!pte_none(*(kmap_pte+idx)))
-		BUG();
+#ifdef CONFIG_DEBUG_HIGHMEM
+	BUG_ON(!pte_none(*(kmap_pte-idx)));
 #endif
-	set_pte(kmap_pte+idx, mk_pte(page, kmap_prot));
+	set_pte(kmap_pte-idx, mk_pte(page, kmap_prot));
 /* XXX Fix - Anton */
 #if 0
 	__flush_tlb_one(vaddr);
@@ -65,17 +65,17 @@
 
 void kunmap_atomic(void *kvaddr, enum km_type type)
 {
-	unsigned long vaddr = (unsigned long) kvaddr;
+#ifdef CONFIG_DEBUG_HIGHMEM
+	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
 	unsigned long idx = type + KM_TYPE_NR*smp_processor_id();
 
-	if (vaddr < fix_kmap_begin) { // FIXME
+	if (vaddr < FIXADDR_START) { // FIXME
 		dec_preempt_count();
 		preempt_check_resched();
 		return;
 	}
 
-	if (vaddr != fix_kmap_begin + idx * PAGE_SIZE)
-		BUG();
+	BUG_ON(vaddr != __fix_to_virt(FIX_KMAP_BEGIN+idx));
 
 /* XXX Fix - Anton */
 #if 0
@@ -84,12 +84,11 @@
 	flush_cache_all();
 #endif
 
-#ifdef HIGHMEM_DEBUG
 	/*
 	 * force other mappings to Oops if they'll try to access
 	 * this pte without first remap it
 	 */
-	pte_clear(kmap_pte+idx);
+	pte_clear(kmap_pte-idx);
 /* XXX Fix - Anton */
 #if 0
 	__flush_tlb_one(vaddr);
@@ -97,6 +96,25 @@
 	flush_tlb_all();
 #endif
 #endif
+
 	dec_preempt_count();
 	preempt_check_resched();
+}
+
+/* We may be fed a pagetable here by ptep_to_xxx and others. */
+struct page *kmap_atomic_to_page(void *ptr)
+{
+	unsigned long idx, vaddr = (unsigned long)ptr;
+	pte_t *pte;
+
+	if (vaddr < SRMMU_NOCACHE_VADDR)
+		return virt_to_page(ptr);
+	if (vaddr < PKMAP_BASE)
+		return pfn_to_page(__nocache_pa(vaddr) >> PAGE_SHIFT);
+	BUG_ON(vaddr < FIXADDR_START);
+	BUG_ON(vaddr > FIXADDR_TOP);
+
+	idx = virt_to_fix(vaddr);
+	pte = kmap_pte - (idx - FIX_KMAP_BEGIN);
+	return pte_page(*pte);
 }
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet 2.5-sparc/arch/sparc/mm/init.c 2.5-sparc-smp/arch/sparc/mm/init.c
--- 2.5-sparc/arch/sparc/mm/init.c	Sat Jan  3 02:08:08 2004
+++ 2.5-sparc-smp/arch/sparc/mm/init.c	Sat Jan  3 02:11:02 2004
@@ -41,7 +41,7 @@
 
 unsigned long page_kernel;
 
-struct sparc_phys_banks sp_banks[SPARC_PHYS_BANKS];
+struct sparc_phys_banks sp_banks[SPARC_PHYS_BANKS+1];
 unsigned long sparc_unmapped_base;
 
 struct pgtable_cache_struct pgt_quicklists;
@@ -61,17 +61,13 @@
 EXPORT_SYMBOL(kmap_prot);
 EXPORT_SYMBOL(kmap_pte);
 
-/* These are set in {srmmu,sun4c}_paging_init() */
-unsigned long fix_kmap_begin;
-unsigned long fix_kmap_end;
-
-#define kmap_get_fixed_pte(vaddr) \
+#define kmap_get_fixmap_pte(vaddr) \
 	pte_offset_kernel(pmd_offset(pgd_offset_k(vaddr), (vaddr)), (vaddr))
 
 void __init kmap_init(void)
 {
 	/* cache the first kmap pte */
-	kmap_pte = kmap_get_fixed_pte(fix_kmap_begin);
+	kmap_pte = kmap_get_fixmap_pte(__fix_to_virt(FIX_KMAP_BEGIN));
 	kmap_prot = __pgprot(SRMMU_ET_PTE | SRMMU_PRIV | SRMMU_CACHE);
 }
 
@@ -385,12 +381,12 @@
 {
 	unsigned long tmp;
 
-#ifdef DEBUG_HIGHMEM
+#ifdef CONFIG_DEBUG_HIGHMEM
 	printk("mapping high region %08lx - %08lx\n", start_pfn, end_pfn);
 #endif
 
 	for (tmp = start_pfn; tmp < end_pfn; tmp++) {
-		struct page *page = mem_map + tmp;
+		struct page *page = pfn_to_page(tmp);
 
 		ClearPageReserved(page);
 		set_bit(PG_highmem, &page->flags);
@@ -407,7 +403,18 @@
 	int initpages = 0; 
 	int i;
 
-	highmem_start_page = mem_map + highstart_pfn;
+	highmem_start_page = pfn_to_page(highstart_pfn);
+
+	if (PKMAP_BASE+LAST_PKMAP*PAGE_SIZE >= FIXADDR_START) {
+		prom_printf("BUG: fixmap and pkmap areas overlap\n");
+		prom_printf("pkbase: 0x%lx pkend: 0x%lx fixstart 0x%lx\n",
+		       PKMAP_BASE,
+		       (unsigned long)PKMAP_BASE+LAST_PKMAP*PAGE_SIZE,
+		       FIXADDR_START);
+		prom_printf("Please mail sparclinux@vger.kernel.org.\n");
+		prom_halt();
+	}
+
 
 	/* Saves us work later. */
 	memset((void *)&empty_zero_page, 0, PAGE_SIZE);
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet 2.5-sparc/arch/sparc/mm/io-unit.c 2.5-sparc-smp/arch/sparc/mm/io-unit.c
--- 2.5-sparc/arch/sparc/mm/io-unit.c	Sat Jan  3 02:08:08 2004
+++ 2.5-sparc-smp/arch/sparc/mm/io-unit.c	Sat Jan  3 02:11:02 2004
@@ -65,7 +65,7 @@
 	
 	for (xptend = iounit->page_table + (16 * PAGE_SIZE) / sizeof(iopte_t);
 	     xpt < xptend;)
-	     	*xpt++ = 0;
+	     	iopte_val(*xpt++) = 0;
 }
 
 /* One has to hold iounit->lock to call this */
@@ -199,7 +199,7 @@
 			pmdp = pmd_offset(pgdp, addr);
 			ptep = pte_offset_map(pmdp, addr);
 
-			set_pte(ptep, pte_val(mk_pte(virt_to_page(page), dvma_prot)));
+			set_pte(ptep, mk_pte(virt_to_page(page), dvma_prot));
 			
 			i = ((addr - IOUNIT_DMA_BASE) >> PAGE_SHIFT);
 
@@ -207,7 +207,7 @@
 				struct iounit_struct *iounit = (struct iounit_struct *)sbus->iommu;
 
 				iopte = (iopte_t *)(iounit->page_table + i);
-				*iopte = __iopte(MKIOPTE(__pa(page)));
+				*iopte = MKIOPTE(__pa(page));
 			}
 		}
 		addr += PAGE_SIZE;
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet 2.5-sparc/arch/sparc/mm/iommu.c 2.5-sparc-smp/arch/sparc/mm/iommu.c
--- 2.5-sparc/arch/sparc/mm/iommu.c	Sat Jan  3 02:08:08 2004
+++ 2.5-sparc-smp/arch/sparc/mm/iommu.c	Sat Jan  3 02:11:02 2004
@@ -405,7 +405,7 @@
 	iopte_t *iopte = iommu->page_table;
 
 	iopte += ((busa - iommu->start) >> PAGE_SHIFT);
-	return pfn_to_page((pte_val(*iopte) & IOPTE_PAGE) >> (PAGE_SHIFT-4));
+	return pfn_to_page((iopte_val(*iopte) & IOPTE_PAGE) >> (PAGE_SHIFT-4));
 }
 #endif
 
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet 2.5-sparc/arch/sparc/mm/srmmu.c 2.5-sparc-smp/arch/sparc/mm/srmmu.c
--- 2.5-sparc/arch/sparc/mm/srmmu.c	Sat Jan  3 02:08:08 2004
+++ 2.5-sparc-smp/arch/sparc/mm/srmmu.c	Sat Jan  3 02:11:02 2004
@@ -139,10 +139,6 @@
 /* these will be initialized in srmmu_nocache_calcsize() */
 unsigned long srmmu_nocache_size;
 unsigned long srmmu_nocache_end;
-unsigned long pkmap_base;
-unsigned long pkmap_base_end;
-extern unsigned long fix_kmap_begin;
-extern unsigned long fix_kmap_end;
 
 /* 1 bit <=> 256 bytes of nocache <=> 64 PTEs */
 #define SRMMU_NOCACHE_BITMAP_SHIFT (PAGE_SHIFT - 4)
@@ -154,11 +150,6 @@
 void *srmmu_nocache_bitmap;
 static struct bit_map srmmu_nocache_map;
 
-/* This makes sense. Honest it does - Anton */
-#define __nocache_pa(VADDR) (((unsigned long)VADDR) - SRMMU_NOCACHE_VADDR + __pa((unsigned long)srmmu_nocache_pool))
-#define __nocache_va(PADDR) (__va((unsigned long)PADDR) - (unsigned long)srmmu_nocache_pool + SRMMU_NOCACHE_VADDR)
-#define __nocache_fix(VADDR) __va(__nocache_pa(VADDR))
-
 static unsigned long srmmu_pte_pfn(pte_t pte)
 {
 	if (srmmu_device_memory(pte_val(pte))) {
@@ -322,10 +313,7 @@
 		printk("Size 0x%x unaligned int nocache request\n", size);
 		size += SRMMU_NOCACHE_BITMAP_SHIFT-1;
 	}
-	if (align > SRMMU_NOCACHE_ALIGN_MAX) {
-		BUG();
-		return 0;
-	}
+	BUG_ON(align > SRMMU_NOCACHE_ALIGN_MAX);
 
 	offset = bit_map_string_get(&srmmu_nocache_map,
 		       			size >> SRMMU_NOCACHE_BITMAP_SHIFT,
@@ -361,7 +349,7 @@
 		    vaddr, (unsigned long)SRMMU_NOCACHE_VADDR);
 		BUG();
 	}
-	if (vaddr >= srmmu_nocache_end) {
+	if (vaddr+size >= srmmu_nocache_end) {
 		printk("Vaddr %lx is bigger than nocache end 0x%lx\n",
 		    vaddr, srmmu_nocache_end);
 		BUG();
@@ -403,17 +391,15 @@
 
  /* P3 XXX The 4x overuse: corroborated by /proc/meminfo. */
 	// if (srmmu_nocache_npages < 256) srmmu_nocache_npages = 256;
-	if (srmmu_nocache_npages < 550) srmmu_nocache_npages = 550;
+	if (srmmu_nocache_npages < SRMMU_MIN_NOCACHE_PAGES)
+		srmmu_nocache_npages = SRMMU_MIN_NOCACHE_PAGES;
 
 	/* anything above 1280 blows up */
-	if (srmmu_nocache_npages > 1280) srmmu_nocache_npages = 1280;
+	if (srmmu_nocache_npages > SRMMU_MAX_NOCACHE_PAGES)
+		srmmu_nocache_npages = SRMMU_MAX_NOCACHE_PAGES;
 
 	srmmu_nocache_size = srmmu_nocache_npages * PAGE_SIZE;
 	srmmu_nocache_end = SRMMU_NOCACHE_VADDR + srmmu_nocache_size;
-	fix_kmap_begin = srmmu_nocache_end;
-	fix_kmap_end = fix_kmap_begin + (KM_TYPE_NR * NR_CPUS - 1) * PAGE_SIZE;
-	pkmap_base = SRMMU_NOCACHE_VADDR + srmmu_nocache_size + 0x40000;
-	pkmap_base_end = pkmap_base + LAST_PKMAP * PAGE_SIZE;
 }
 
 void srmmu_nocache_init(void)
@@ -453,7 +439,7 @@
 		if (srmmu_cache_pagetables)
 			pteval |= SRMMU_CACHE;
 
-		srmmu_set_pte(__nocache_fix(pte), pteval);
+		srmmu_set_pte(__nocache_fix(pte), __pte(pteval));
 
 		vaddr += PAGE_SIZE;
 		paddr += PAGE_SIZE;
@@ -1083,6 +1069,8 @@
 			memset(__nocache_fix(ptep), 0, SRMMU_PTE_SZ_SOFT);
 			srmmu_pmd_set(__nocache_fix(pmdp), ptep);
 		}
+		if (start > (0xffffffffUL - SRMMU_PMD_SIZE_SOFT))
+			break;
 		start = (start + SRMMU_PMD_SIZE) & SRMMU_PMD_MASK;
 	}
 }
@@ -1111,6 +1099,8 @@
 			memset(ptep, 0, SRMMU_PTE_SZ_SOFT);
 			srmmu_pmd_set(pmdp, ptep);
 		}
+		if (start > (0xffffffffUL - SRMMU_PMD_SIZE_SOFT))
+			break;
 		start = (start + SRMMU_PMD_SIZE) & SRMMU_PMD_MASK;
 	}
 }
@@ -1315,12 +1305,13 @@
 	srmmu_allocate_ptable_skeleton(DVMA_VADDR, DVMA_END);
 #endif
 
-	srmmu_allocate_ptable_skeleton(fix_kmap_begin, fix_kmap_end);
-	srmmu_allocate_ptable_skeleton(pkmap_base, pkmap_base_end);
-
-	pgd = pgd_offset_k(pkmap_base);
-	pmd = srmmu_pmd_offset(pgd, pkmap_base);
-	pte = srmmu_pte_offset(pmd, pkmap_base);
+	srmmu_allocate_ptable_skeleton(
+		__fix_to_virt(__end_of_fixed_addresses - 1), FIXADDR_TOP);
+	srmmu_allocate_ptable_skeleton(PKMAP_BASE, PKMAP_END);
+
+	pgd = pgd_offset_k(PKMAP_BASE);
+	pmd = srmmu_pmd_offset(pgd, PKMAP_BASE);
+	pte = srmmu_pte_offset(pmd, PKMAP_BASE);
 	pkmap_page_table = pte;
 
 	flush_cache_all();
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet 2.5-sparc/arch/sparc/mm/sun4c.c 2.5-sparc-smp/arch/sparc/mm/sun4c.c
--- 2.5-sparc/arch/sparc/mm/sun4c.c	Sat Jan  3 02:08:08 2004
+++ 2.5-sparc-smp/arch/sparc/mm/sun4c.c	Sat Jan  3 02:11:02 2004
@@ -2028,18 +2028,12 @@
 extern unsigned long bootmem_init(unsigned long *pages_avail);
 extern unsigned long last_valid_pfn;
 
-extern unsigned long fix_kmap_begin;
-extern unsigned long fix_kmap_end;
-
 void __init sun4c_paging_init(void)
 {
 	int i, cnt;
 	unsigned long kernel_end, vaddr;
 	extern struct resource sparc_iomap;
 	unsigned long end_pfn, pages_avail;
-
-	fix_kmap_begin = KERNBASE + SRMMU_MAXMEM; /* Why bother with SRMMU_MAXMEM? */
-	fix_kmap_end = fix_kmap_begin + ((KM_TYPE_NR*NR_CPUS)-1)*PAGE_SIZE;
 
 	kernel_end = (unsigned long) &end;
 	kernel_end += (SUN4C_REAL_PGDIR_SIZE * 4);
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet 2.5-sparc/include/asm-sparc/fixmap.h 2.5-sparc-smp/include/asm-sparc/fixmap.h
--- 2.5-sparc/include/asm-sparc/fixmap.h	Wed Dec 31 16:00:00 1969
+++ 2.5-sparc-smp/include/asm-sparc/fixmap.h	Fri Jan  2 09:37:26 2004
@@ -0,0 +1,111 @@
+/*
+ * fixmap.h: compile-time virtual memory allocation
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1998 Ingo Molnar
+ *
+ * Support of BIGMEM added by Gerhard Wichert, Siemens AG, July 1999
+ */
+
+#ifndef _ASM_FIXMAP_H
+#define _ASM_FIXMAP_H
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <asm/page.h>
+#ifdef CONFIG_HIGHMEM
+#include <linux/threads.h>
+#include <asm/kmap_types.h>
+#endif
+
+/*
+ * Here we define all the compile-time 'special' virtual
+ * addresses. The point is to have a constant address at
+ * compile time, but to set the physical address only
+ * in the boot process. We allocate these special  addresses
+ * from the top of unused virtual memory (0xfd000000 - 1 page) backwards.
+ * Also this lets us do fail-safe vmalloc(), we
+ * can guarantee that these special addresses and
+ * vmalloc()-ed addresses never overlap.
+ *
+ * these 'compile-time allocated' memory buffers are
+ * fixed-size 4k pages. (or larger if used with an increment
+ * highger than 1) use fixmap_set(idx,phys) to associate
+ * physical memory with fixmap indices.
+ *
+ * TLB entries of such buffers will not be flushed across
+ * task switches.
+ */
+
+/*
+ * on UP currently we will have no trace of the fixmap mechanism,
+ * no page table allocations, etc. This might change in the
+ * future, say framebuffers for the console driver(s) could be
+ * fix-mapped?
+ */
+enum fixed_addresses {
+	FIX_HOLE,
+#ifdef CONFIG_HIGHMEM
+	FIX_KMAP_BEGIN,
+	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
+#endif
+	__end_of_fixed_addresses
+};
+
+extern void __set_fixmap (enum fixed_addresses idx,
+					unsigned long phys, pgprot_t flags);
+
+#define set_fixmap(idx, phys) \
+		__set_fixmap(idx, phys, PAGE_KERNEL)
+/*
+ * Some hardware wants to get fixmapped without caching.
+ */
+#define set_fixmap_nocache(idx, phys) \
+		__set_fixmap(idx, phys, PAGE_KERNEL_NOCACHE)
+/*
+ * used by vmalloc.c.
+ *
+ * Leave one empty page between IO pages at 0xfd000000 and
+ * the start of the fixmap.
+ */
+#define FIXADDR_TOP	(0xfcfff000UL)
+#define FIXADDR_SIZE	((__end_of_fixed_addresses) << PAGE_SHIFT)
+#define FIXADDR_START	(FIXADDR_TOP - FIXADDR_SIZE)
+
+#define __fix_to_virt(x)	(FIXADDR_TOP - ((x) << PAGE_SHIFT))
+#define __virt_to_fix(x)	((FIXADDR_TOP - ((x)&PAGE_MASK)) >> PAGE_SHIFT)
+
+extern void __this_fixmap_does_not_exist(void);
+
+/*
+ * 'index to address' translation. If anyone tries to use the idx
+ * directly without tranlation, we catch the bug with a NULL-deference
+ * kernel oops. Illegal ranges of incoming indices are caught too.
+ */
+static inline unsigned long fix_to_virt(const unsigned int idx)
+{
+	/*
+	 * this branch gets completely eliminated after inlining,
+	 * except when someone tries to use fixaddr indices in an
+	 * illegal way. (such as mixing up address types or using
+	 * out-of-range indices).
+	 *
+	 * If it doesn't get removed, the linker will complain
+	 * loudly with a reasonably clear error message..
+	 */
+	if (idx >= __end_of_fixed_addresses)
+		__this_fixmap_does_not_exist();
+
+        return __fix_to_virt(idx);
+}
+
+static inline unsigned long virt_to_fix(const unsigned long vaddr)
+{
+	BUG_ON(vaddr >= FIXADDR_TOP || vaddr < FIXADDR_START);
+	return __virt_to_fix(vaddr);
+}
+
+#endif
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet 2.5-sparc/include/asm-sparc/highmem.h 2.5-sparc-smp/include/asm-sparc/highmem.h
--- 2.5-sparc/include/asm-sparc/highmem.h	Sat Jan  3 02:08:30 2004
+++ 2.5-sparc-smp/include/asm-sparc/highmem.h	Sat Jan  3 02:11:28 2004
@@ -21,10 +21,10 @@
 #ifdef __KERNEL__
 
 #include <linux/interrupt.h>
+#include <asm/fixmap.h>
+#include <asm/vaddrs.h>
 #include <asm/kmap_types.h>
-
-/* undef for production */
-#define HIGHMEM_DEBUG 1
+#include <asm/pgtsrmmu.h>
 
 /* declarations for highmem.c */
 extern unsigned long highstart_pfn, highend_pfn;
@@ -33,12 +33,6 @@
 extern pgprot_t kmap_prot;
 extern pte_t *pkmap_page_table;
 
-/* This gets set in {srmmu,sun4c}_paging_init() */
-extern unsigned long fix_kmap_begin;
-
-/* Only used and set with srmmu? */
-extern unsigned long pkmap_base;
-
 extern void kmap_init(void) __init;
 
 /*
@@ -46,19 +40,21 @@
  * easily, subsequent pte tables have to be allocated in one physical
  * chunk of RAM.
  */
+#define PKMAP_BASE (SRMMU_NOCACHE_VADDR + (SRMMU_MAX_NOCACHE_PAGES << PAGE_SHIFT))
 #define LAST_PKMAP 1024
 
 #define LAST_PKMAP_MASK (LAST_PKMAP - 1)
-#define PKMAP_NR(virt)  ((virt - pkmap_base) >> PAGE_SHIFT)
-#define PKMAP_ADDR(nr)  (pkmap_base + ((nr) << PAGE_SHIFT))
+#define PKMAP_NR(virt)  ((virt - PKMAP_BASE) >> PAGE_SHIFT)
+#define PKMAP_ADDR(nr)  (PKMAP_BASE + ((nr) << PAGE_SHIFT))
+
+#define PKMAP_END (PKMAP_ADDR(LAST_PKMAP))
 
 extern void *kmap_high(struct page *page);
 extern void kunmap_high(struct page *page);
 
 static inline void *kmap(struct page *page)
 {
-	if (in_interrupt())
-		BUG();
+	BUG_ON(in_interrupt());
 	if (page < highmem_start_page)
 		return page_address(page);
 	return kmap_high(page);
@@ -66,8 +62,7 @@
 
 static inline void kunmap(struct page *page)
 {
-	if (in_interrupt())
-		BUG();
+	BUG_ON(in_interrupt());
 	if (page < highmem_start_page)
 		return;
 	kunmap_high(page);
@@ -75,19 +70,7 @@
 
 extern void *kmap_atomic(struct page *page, enum km_type type);
 extern void kunmap_atomic(void *kvaddr, enum km_type type);
-
-static inline struct page *kmap_atomic_to_page(void *ptr)
-{
-	unsigned long idx, vaddr = (unsigned long)ptr;
-	pte_t *pte;
-
-	if (vaddr < fix_kmap_begin)
-		return virt_to_page(ptr);
-
-	idx = ((vaddr - fix_kmap_begin) >> PAGE_SHIFT);
-	pte = kmap_pte + idx;
-	return pte_page(*pte);
-}
+extern struct page *kmap_atomic_to_page(void *vaddr);
 
 #define flush_cache_kmaps()	flush_cache_all()
 
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet 2.5-sparc/include/asm-sparc/kmap_types.h 2.5-sparc-smp/include/asm-sparc/kmap_types.h
--- 2.5-sparc/include/asm-sparc/kmap_types.h	Sat Jan  3 02:08:30 2004
+++ 2.5-sparc-smp/include/asm-sparc/kmap_types.h	Sat Jan  3 02:11:28 2004
@@ -11,6 +11,7 @@
 	KM_BIO_DST_IRQ,
 	KM_PTE0,
 	KM_PTE1,
+	KM_PTE2,
 	KM_IRQ0,
 	KM_IRQ1,
 	KM_SOFTIRQ0,
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet 2.5-sparc/include/asm-sparc/page.h 2.5-sparc-smp/include/asm-sparc/page.h
--- 2.5-sparc/include/asm-sparc/page.h	Sat Jan  3 02:08:30 2004
+++ 2.5-sparc-smp/include/asm-sparc/page.h	Sat Jan  3 02:11:28 2004
@@ -54,7 +54,7 @@
 
 #define SPARC_PHYS_BANKS 32
 
-extern struct sparc_phys_banks sp_banks[SPARC_PHYS_BANKS];
+extern struct sparc_phys_banks sp_banks[SPARC_PHYS_BANKS+1];
 
 /* Cache alias structure.  Entry is valid if context != -1. */
 struct cache_palias {
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet 2.5-sparc/include/asm-sparc/pgtsrmmu.h 2.5-sparc-smp/include/asm-sparc/pgtsrmmu.h
--- 2.5-sparc/include/asm-sparc/pgtsrmmu.h	Sat Jan  3 02:08:30 2004
+++ 2.5-sparc-smp/include/asm-sparc/pgtsrmmu.h	Sat Jan  3 02:11:28 2004
@@ -109,6 +109,13 @@
 
 #ifndef __ASSEMBLY__
 
+/* This makes sense. Honest it does - Anton */
+/* XXX Yes but it's ugly as sin.  FIXME. -KMW */
+extern void *srmmu_nocache_pool;
+#define __nocache_pa(VADDR) (((unsigned long)VADDR) - SRMMU_NOCACHE_VADDR + __pa((unsigned long)srmmu_nocache_pool))
+#define __nocache_va(PADDR) (__va((unsigned long)PADDR) - (unsigned long)srmmu_nocache_pool + SRMMU_NOCACHE_VADDR)
+#define __nocache_fix(VADDR) __va(__nocache_pa(VADDR))
+
 /* Accessing the MMU control register. */
 extern __inline__ unsigned int srmmu_get_mmureg(void)
 {
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet 2.5-sparc/include/asm-sparc/vaddrs.h 2.5-sparc-smp/include/asm-sparc/vaddrs.h
--- 2.5-sparc/include/asm-sparc/vaddrs.h	Sat Jan  3 02:08:30 2004
+++ 2.5-sparc-smp/include/asm-sparc/vaddrs.h	Sat Jan  3 02:11:28 2004
@@ -16,6 +16,9 @@
 
 #define SRMMU_NOCACHE_VADDR	(KERNBASE + SRMMU_MAXMEM)
 				/* = 0x0fc000000 */
+/* XXX Empiricals - this needs to go away - KMW */
+#define SRMMU_MIN_NOCACHE_PAGES (550)
+#define SRMMU_MAX_NOCACHE_PAGES	(1280)
 
 /* The following constant is used in mm/srmmu.c::srmmu_nocache_calcsize()
  * to determine the amount of memory that will be reserved as nocache:


-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"May Buddha bless all stubborn people!"
				-- Uliassutai Karakorum Blake
