From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 08 Mar 2006 10:36:11 +0000
Subject: Re: Best bet for SPARC SMP and Sunfire V240
Message-Id: <20060308.023611.97613447.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <a728f9f90603071426g547ba79at30c36e545db70f01@mail.gmail.com>
In-Reply-To: <a728f9f90603071426g547ba79at30c36e545db70f01@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 08 Mar 2006 00:02:35 -0800 (PST)

> I guess I should code up some sparsemem support, it would help for
> cases like this.

Give this patch a try, it is against 2.6.16-current but should
apply with only minor fixups to things like 2.6.15

Thanks.

diff-tree f9b2926038557a08b652eae008cd487c45f331af (from e5cde15481a62564fe7bb6b5a7ea6325edc7c38c)
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Wed Mar 8 02:18:43 2006 -0800

    [SPARC64]: Move over to sparsemem.
    
    This has been pending for a long time, and the fact
    that we waste a ton of ram on some configurations
    kind of pushed things over the edge.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/arch/sparc64/Kconfig b/arch/sparc64/Kconfig
index 4c0a50a..a253a39 100644
--- a/arch/sparc64/Kconfig
+++ b/arch/sparc64/Kconfig
@@ -186,6 +186,12 @@ endchoice
 
 endmenu
 
+config ARCH_SPARSEMEM_ENABLE
+	def_bool y
+
+config ARCH_SPARSEMEM_DEFAULT
+	def_bool y
+
 source "mm/Kconfig"
 
 config GENERIC_ISA_DMA
diff --git a/arch/sparc64/kernel/sparc64_ksyms.c b/arch/sparc64/kernel/sparc64_ksyms.c
index 3c06bfb..b9f508c 100644
--- a/arch/sparc64/kernel/sparc64_ksyms.c
+++ b/arch/sparc64/kernel/sparc64_ksyms.c
@@ -95,9 +95,6 @@ extern int __ashrdi3(int, int);
 
 extern int dump_fpu (struct pt_regs * regs, elf_fpregset_t * fpregs);
 
-extern unsigned long phys_base;
-extern unsigned long pfn_base;
-
 extern unsigned int sys_call_table[];
 
 extern void xor_vis_2(unsigned long, unsigned long *, unsigned long *);
@@ -342,11 +339,7 @@ EXPORT_SYMBOL(__strncpy_from_user);
 EXPORT_SYMBOL(__bzero_noasi);
 
 /* Various address conversion macros use this. */
-EXPORT_SYMBOL(phys_base);
-EXPORT_SYMBOL(pfn_base);
 EXPORT_SYMBOL(sparc64_valid_addr_bitmap);
-EXPORT_SYMBOL(page_to_pfn);
-EXPORT_SYMBOL(pfn_to_page);
 
 /* No version information on this, heavily used in inline asm,
  * and will always be 'void __ret_efault(void)'.
diff --git a/arch/sparc64/mm/init.c b/arch/sparc64/mm/init.c
index 1e44ee2..cc1fc37 100644
--- a/arch/sparc64/mm/init.c
+++ b/arch/sparc64/mm/init.c
@@ -111,11 +111,9 @@ static void __init read_obp_memory(const
 
 unsigned long *sparc64_valid_addr_bitmap __read_mostly;
 
-/* Ugly, but necessary... -DaveM */
-unsigned long phys_base __read_mostly;
+/* Kernel physical address base and size in bytes.  */
 unsigned long kern_base __read_mostly;
 unsigned long kern_size __read_mostly;
-unsigned long pfn_base __read_mostly;
 
 /* get_new_mmu_context() uses "cache + 1".  */
 DEFINE_SPINLOCK(ctx_alloc_lock);
@@ -320,16 +318,6 @@ void __kprobes flush_icache_range(unsign
 	}
 }
 
-unsigned long page_to_pfn(struct page *page)
-{
-	return (unsigned long) ((page - mem_map) + pfn_base);
-}
-
-struct page *pfn_to_page(unsigned long pfn)
-{
-	return (mem_map + (pfn - pfn_base));
-}
-
 void show_mem(void)
 {
 	printk("Mem-info:\n");
@@ -1196,9 +1184,78 @@ void sparc_ultra_dump_dtlb(void)
 
 extern unsigned long cmdline_memory_size;
 
-unsigned long __init bootmem_init(unsigned long *pages_avail)
+/* Find a free area for the bootmem map, avoiding the kernel image
+ * and the initial ramdisk.
+ */
+static unsigned long __init choose_bootmap_pfn(unsigned long start_pfn,
+					       unsigned long end_pfn)
 {
-	unsigned long bootmap_size, start_pfn, end_pfn;
+	unsigned long avoid_start, avoid_end, bootmap_size;
+	int i;
+
+	bootmap_size = ((end_pfn - start_pfn) + 7) / 8;
+	bootmap_size = ALIGN(bootmap_size, sizeof(long));
+
+	avoid_start = avoid_end = 0;
+#ifdef CONFIG_BLK_DEV_INITRD
+	avoid_start = initrd_start;
+	avoid_end = PAGE_ALIGN(initrd_end);
+#endif
+
+#ifdef CONFIG_DEBUG_BOOTMEM
+	prom_printf("choose_bootmap_pfn: kern[%lx:%lx] avoid[%lx:%lx]\n",
+		    kern_base, PAGE_ALIGN(kern_base + kern_size),
+		    avoid_start, avoid_end);
+#endif
+	for (i = 0; i < pavail_ents; i++) {
+		unsigned long start, end;
+
+		start = pavail[i].phys_addr;
+		end = start + pavail[i].reg_size;
+
+		while (start < end) {
+			if (start >= kern_base &&
+			    start < PAGE_ALIGN(kern_base + kern_size)) {
+				start = PAGE_ALIGN(kern_base + kern_size);
+				continue;
+			}
+			if (start >= avoid_start && start < avoid_end) {
+				start = avoid_end;
+				continue;
+			}
+
+			if ((end - start) < bootmap_size)
+				break;
+
+			if (start < kern_base &&
+			    (start + bootmap_size) > kern_base) {
+				start = PAGE_ALIGN(kern_base + kern_size);
+				continue;
+			}
+
+			if (start < avoid_start &&
+			    (start + bootmap_size) > avoid_start) {
+				start = avoid_end;
+				continue;
+			}
+
+			/* OK, it doesn't overlap anything, use it.  */
+#ifdef CONFIG_DEBUG_BOOTMEM
+			prom_printf("choose_bootmap_pfn: Using %lx [%lx]\n",
+				    start >> PAGE_SHIFT, start);
+#endif
+			return start >> PAGE_SHIFT;
+		}
+	}
+
+	prom_printf("Cannot find free area for bootmap, aborting.\n");
+	prom_halt();
+}
+
+static unsigned long __init bootmem_init(unsigned long *pages_avail,
+					 unsigned long phys_base)
+{
+	unsigned long bootmap_size, end_pfn;
 	unsigned long end_of_phys_memory = 0UL;
 	unsigned long bootmap_pfn, bytes_avail, size;
 	int i;
@@ -1236,14 +1293,6 @@ unsigned long __init bootmem_init(unsign
 
 	*pages_avail = bytes_avail >> PAGE_SHIFT;
 
-	/* Start with page aligned address of last symbol in kernel
-	 * image.  The kernel is hard mapped below PAGE_OFFSET in a
-	 * 4MB locked TLB translation.
-	 */
-	start_pfn = PAGE_ALIGN(kern_base + kern_size) >> PAGE_SHIFT;
-
-	bootmap_pfn = start_pfn;
-
 	end_pfn = end_of_phys_memory >> PAGE_SHIFT;
 
 #ifdef CONFIG_BLK_DEV_INITRD
@@ -1260,23 +1309,23 @@ unsigned long __init bootmem_init(unsign
 		                 	 "(0x%016lx > 0x%016lx)\ndisabling initrd\n",
 			       initrd_end, end_of_phys_memory);
 			initrd_start = 0;
-		}
-		if (initrd_start) {
-			if (initrd_start >= (start_pfn << PAGE_SHIFT) &&
-			    initrd_start < (start_pfn << PAGE_SHIFT) + 2 * PAGE_SIZE)
-				bootmap_pfn = PAGE_ALIGN (initrd_end) >> PAGE_SHIFT;
+			initrd_end = 0;
 		}
 	}
 #endif	
 	/* Initialize the boot-time allocator. */
 	max_pfn = max_low_pfn = end_pfn;
-	min_low_pfn = pfn_base;
+	min_low_pfn = (phys_base >> PAGE_SHIFT);
+
+	bootmap_pfn = choose_bootmap_pfn(min_low_pfn, end_pfn);
 
 #ifdef CONFIG_DEBUG_BOOTMEM
 	prom_printf("init_bootmem(min[%lx], bootmap[%lx], max[%lx])\n",
 		    min_low_pfn, bootmap_pfn, max_low_pfn);
 #endif
-	bootmap_size = init_bootmem_node(NODE_DATA(0), bootmap_pfn, pfn_base, end_pfn);
+	bootmap_size = init_bootmem_node(NODE_DATA(0), bootmap_pfn,
+					 (phys_base >> PAGE_SHIFT),
+					 end_pfn);
 
 	/* Now register the available physical memory with the
 	 * allocator.
@@ -1324,6 +1373,20 @@ unsigned long __init bootmem_init(unsign
 	reserve_bootmem((bootmap_pfn << PAGE_SHIFT), size);
 	*pages_avail -= PAGE_ALIGN(size) >> PAGE_SHIFT;
 
+	for (i = 0; i < pavail_ents; i++) {
+		unsigned long start_pfn, end_pfn;
+
+		start_pfn = pavail[i].phys_addr >> PAGE_SHIFT;
+		end_pfn = (start_pfn + (pavail[i].reg_size >> PAGE_SHIFT));
+#ifdef CONFIG_DEBUG_BOOTMEM
+		prom_printf("memory_present(0, %lx, %lx)\n",
+			    start_pfn, end_pfn);
+#endif
+		memory_present(0, start_pfn, end_pfn);
+	}
+
+	sparse_init();
+
 	return end_pfn;
 }
 
@@ -1448,7 +1511,7 @@ pgd_t swapper_pg_dir[2048];
 
 void __init paging_init(void)
 {
-	unsigned long end_pfn, pages_avail, shift;
+	unsigned long end_pfn, pages_avail, shift, phys_base;
 	unsigned long real_end, i;
 
 	/* Find available physical memory... */
@@ -1458,8 +1521,6 @@ void __init paging_init(void)
 	for (i = 0; i < pavail_ents; i++)
 		phys_base = min(phys_base, pavail[i].phys_addr);
 
-	pfn_base = phys_base >> PAGE_SHIFT;
-
 	kern_base = (prom_boot_mapping_phys_low >> 22UL) << 22UL;
 	kern_size = (unsigned long)&_end - (unsigned long)KERNBASE;
 
@@ -1506,7 +1567,9 @@ void __init paging_init(void)
 
 	/* Setup bootmem... */
 	pages_avail = 0;
-	last_valid_pfn = end_pfn = bootmem_init(&pages_avail);
+	last_valid_pfn = end_pfn = bootmem_init(&pages_avail, phys_base);
+
+	max_mapnr = last_valid_pfn - (phys_base >> PAGE_SHIFT);
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
 	kernel_physical_mapping_init();
@@ -1521,7 +1584,7 @@ void __init paging_init(void)
 		for (znum = 0; znum < MAX_NR_ZONES; znum++)
 			zones_size[znum] = zholes_size[znum] = 0;
 
-		npages = end_pfn - pfn_base;
+		npages = end_pfn - (phys_base >> PAGE_SHIFT);
 		zones_size[ZONE_DMA] = npages;
 		zholes_size[ZONE_DMA] = npages - pages_avail;
 
@@ -1596,7 +1659,6 @@ void __init mem_init(void)
 
 	taint_real_pages();
 
-	max_mapnr = last_valid_pfn - pfn_base;
 	high_memory = __va(last_valid_pfn << PAGE_SHIFT);
 
 #ifdef CONFIG_DEBUG_BOOTMEM
diff --git a/include/asm-sparc64/page.h b/include/asm-sparc64/page.h
index 5426bb2..af13d32 100644
--- a/include/asm-sparc64/page.h
+++ b/include/asm-sparc64/page.h
@@ -124,17 +124,10 @@ typedef unsigned long pgprot_t;
 #define __pa(x)			((unsigned long)(x) - PAGE_OFFSET)
 #define __va(x)			((void *)((unsigned long) (x) + PAGE_OFFSET))
 
-/* PFNs are real physical page numbers.  However, mem_map only begins to record
- * per-page information starting at pfn_base.  This is to handle systems where
- * the first physical page in the machine is at some huge physical address,
- * such as 4GB.   This is common on a partitioned E10000, for example.
- */
-extern struct page *pfn_to_page(unsigned long pfn);
-extern unsigned long page_to_pfn(struct page *);
+#define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
 
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr)>>PAGE_SHIFT)
 
-#define pfn_valid(pfn)		(((pfn)-(pfn_base)) < max_mapnr)
 #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
 
 #define virt_to_phys __pa
diff --git a/include/asm-sparc64/pgtable.h b/include/asm-sparc64/pgtable.h
index f0a9b44..2178796 100644
--- a/include/asm-sparc64/pgtable.h
+++ b/include/asm-sparc64/pgtable.h
@@ -212,9 +212,6 @@
 
 #ifndef __ASSEMBLY__
 
-extern unsigned long phys_base;
-extern unsigned long pfn_base;
-
 extern struct page *mem_map_zero;
 #define ZERO_PAGE(vaddr)	(mem_map_zero)
 
--- a/include/asm-sparc64/numnodes.h	2006-02-15 04:00:56.000000000 -0800
+++ b/include/asm-sparc64/numnodes.h	2006-03-08 02:19:18.000000000 -0800
@@ -0,0 +1,6 @@
+#ifndef _SPARC64_NUMNODES_H
+#define _SPARC64_NUMNODES_H
+
+#define NODES_SHIFT	0
+
+#endif /* !(_SPARC64_NUMNODES_H) */
--- a/include/asm-sparc64/sparsemem.h	2006-02-15 04:00:56.000000000 -0800
+++ b/include/asm-sparc64/sparsemem.h	2006-03-08 02:19:18.000000000 -0800
@@ -0,0 +1,12 @@
+#ifndef _SPARC64_SPARSEMEM_H
+#define _SPARC64_SPARSEMEM_H
+
+#ifdef __KERNEL__
+
+#define SECTION_SIZE_BITS       26
+#define MAX_PHYSADDR_BITS       42
+#define MAX_PHYSMEM_BITS        42
+
+#endif /* !(__KERNEL__) */
+
+#endif /* !(_SPARC64_SPARSEMEM_H) */
