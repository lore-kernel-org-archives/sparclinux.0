From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 05 Jan 2009 19:48:05 +0000
Subject: [PATCH 2/3] sparc: move EXPORT_SYMBOL to the symbols definition
Message-Id: <1231184886-5113-2-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Move all applicable EXPORT_SYMBOL to the file where the respective
symbol is defined.

Removed all the includes that is no longer needed in sparc_ksyms_32.c

One file are shared with sparc64 thus the export was removed from
the sparc64 specific file too.

This patch do not touch the prom* functions - this is to be adressed later.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/auxio_32.c       |    3 +-
 arch/sparc/kernel/cpu.c            |    2 +
 arch/sparc/kernel/ioport.c         |   15 +++++
 arch/sparc/kernel/irq_32.c         |    1 +
 arch/sparc/kernel/pcic.c           |    6 ++
 arch/sparc/kernel/process_32.c     |    2 +
 arch/sparc/kernel/setup_32.c       |    3 +
 arch/sparc/kernel/sparc_ksyms_32.c |  107 +----------------------------------
 arch/sparc/kernel/sparc_ksyms_64.c |    3 -
 arch/sparc/kernel/time_32.c        |    2 +
 arch/sparc/kernel/traps_32.c       |    1 +
 arch/sparc/mm/generic_32.c         |    1 +
 arch/sparc/mm/highmem.c            |    2 +
 arch/sparc/mm/init_32.c            |    6 ++
 14 files changed, 47 insertions(+), 107 deletions(-)

diff --git a/arch/sparc/kernel/auxio_32.c b/arch/sparc/kernel/auxio_32.c
index 09c8572..45c4123 100644
--- a/arch/sparc/kernel/auxio_32.c
+++ b/arch/sparc/kernel/auxio_32.c
@@ -76,6 +76,7 @@ unsigned char get_auxio(void)
 		return sbus_readb(auxio_register);
 	return 0;
 }
+EXPORT_SYMBOL(get_auxio);
 
 void set_auxio(unsigned char bits_on, unsigned char bits_off)
 {
@@ -102,7 +103,7 @@ void set_auxio(unsigned char bits_on, unsigned char bits_off)
 	};
 	spin_unlock_irqrestore(&auxio_lock, flags);
 }
-
+EXPORT_SYMBOL(set_auxio);
 
 /* sun4m power control register (AUXIO2) */
 
diff --git a/arch/sparc/kernel/cpu.c b/arch/sparc/kernel/cpu.c
index 6c2da24..f0b8255 100644
--- a/arch/sparc/kernel/cpu.c
+++ b/arch/sparc/kernel/cpu.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/smp.h>
 #include <linux/threads.h>
@@ -20,6 +21,7 @@
 #include "kernel.h"
 
 DEFINE_PER_CPU(cpuinfo_sparc, __cpu_data) = { 0 };
+EXPORT_PER_CPU_SYMBOL(__cpu_data);
 
 struct cpu_info {
 	int psr_vers;
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 7ce14f0..87ea0d0 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -120,6 +120,7 @@ void __iomem *ioremap(unsigned long offset, unsigned long size)
 	sprintf(name, "phys_%08x", (u32)offset);
 	return _sparc_alloc_io(0, offset, size, name);
 }
+EXPORT_SYMBOL(ioremap);
 
 /*
  * Comlimentary to ioremap().
@@ -141,6 +142,7 @@ void iounmap(volatile void __iomem *virtual)
 		kfree(res);
 	}
 }
+EXPORT_SYMBOL(iounmap);
 
 void __iomem *of_ioremap(struct resource *res, unsigned long offset,
 			 unsigned long size, char *name)
@@ -237,6 +239,7 @@ void sbus_set_sbus64(struct device *dev, int x)
 {
 	printk("sbus_set_sbus64: unsupported\n");
 }
+EXPORT_SYMBOL(sbus_set_sbus64);
 
 /*
  * Allocate a chunk of memory suitable for DMA.
@@ -436,6 +439,7 @@ void *pci_alloc_consistent(struct pci_dev *pdev, size_t len, dma_addr_t *pba)
 	*pba = virt_to_phys(va); /* equals virt_to_bus (R.I.P.) for us. */
 	return (void *) res->start;
 }
+EXPORT_SYMBOL(pci_alloc_consistent);
 
 /* Free and unmap a consistent DMA buffer.
  * cpu_addr is what was returned from pci_alloc_consistent,
@@ -477,6 +481,7 @@ void pci_free_consistent(struct pci_dev *pdev, size_t n, void *p, dma_addr_t ba)
 
 	free_pages(pgp, get_order(n));
 }
+EXPORT_SYMBOL(pci_free_consistent);
 
 /* Map a single buffer of the indicated size for DMA in streaming mode.
  * The 32-bit bus address to use is returned.
@@ -491,6 +496,7 @@ dma_addr_t pci_map_single(struct pci_dev *hwdev, void *ptr, size_t size,
 	/* IIep is write-through, not flushing. */
 	return virt_to_phys(ptr);
 }
+EXPORT_SYMBOL(pci_map_single);
 
 /* Unmap a single streaming mode DMA translation.  The dma_addr and size
  * must match what was provided for in a previous pci_map_single call.  All
@@ -508,6 +514,7 @@ void pci_unmap_single(struct pci_dev *hwdev, dma_addr_t ba, size_t size,
 		    (size + PAGE_SIZE-1) & PAGE_MASK);
 	}
 }
+EXPORT_SYMBOL(pci_unmap_single);
 
 /*
  * Same as pci_map_single, but with pages.
@@ -519,6 +526,7 @@ dma_addr_t pci_map_page(struct pci_dev *hwdev, struct page *page,
 	/* IIep is write-through, not flushing. */
 	return page_to_phys(page) + offset;
 }
+EXPORT_SYMBOL(pci_map_page);
 
 void pci_unmap_page(struct pci_dev *hwdev,
 			dma_addr_t dma_address, size_t size, int direction)
@@ -526,6 +534,7 @@ void pci_unmap_page(struct pci_dev *hwdev,
 	BUG_ON(direction = PCI_DMA_NONE);
 	/* mmu_inval_dma_area XXX */
 }
+EXPORT_SYMBOL(pci_unmap_page);
 
 /* Map a set of buffers described by scatterlist in streaming
  * mode for DMA.  This is the scather-gather version of the
@@ -557,6 +566,7 @@ int pci_map_sg(struct pci_dev *hwdev, struct scatterlist *sgl, int nents,
 	}
 	return nents;
 }
+EXPORT_SYMBOL(pci_map_sg);
 
 /* Unmap a set of streaming mode DMA translations.
  * Again, cpu read rules concerning calls here are the same as for
@@ -578,6 +588,7 @@ void pci_unmap_sg(struct pci_dev *hwdev, struct scatterlist *sgl, int nents,
 		}
 	}
 }
+EXPORT_SYMBOL(pci_unmap_sg);
 
 /* Make physical memory consistent for a single
  * streaming mode DMA translation before or after a transfer.
@@ -597,6 +608,7 @@ void pci_dma_sync_single_for_cpu(struct pci_dev *hwdev, dma_addr_t ba, size_t si
 		    (size + PAGE_SIZE-1) & PAGE_MASK);
 	}
 }
+EXPORT_SYMBOL(pci_dma_sync_single_for_cpu);
 
 void pci_dma_sync_single_for_device(struct pci_dev *hwdev, dma_addr_t ba, size_t size, int direction)
 {
@@ -606,6 +618,7 @@ void pci_dma_sync_single_for_device(struct pci_dev *hwdev, dma_addr_t ba, size_t
 		    (size + PAGE_SIZE-1) & PAGE_MASK);
 	}
 }
+EXPORT_SYMBOL(pci_dma_sync_single_for_device);
 
 /* Make physical memory consistent for a set of streaming
  * mode DMA translations after a transfer.
@@ -628,6 +641,7 @@ void pci_dma_sync_sg_for_cpu(struct pci_dev *hwdev, struct scatterlist *sgl, int
 		}
 	}
 }
+EXPORT_SYMBOL(pci_dma_sync_sg_for_cpu);
 
 void pci_dma_sync_sg_for_device(struct pci_dev *hwdev, struct scatterlist *sgl, int nents, int direction)
 {
@@ -644,6 +658,7 @@ void pci_dma_sync_sg_for_device(struct pci_dev *hwdev, struct scatterlist *sgl,
 		}
 	}
 }
+EXPORT_SYMBOL(pci_dma_sync_sg_for_device);
 #endif /* CONFIG_PCI */
 
 #ifdef CONFIG_PROC_FS
diff --git a/arch/sparc/kernel/irq_32.c b/arch/sparc/kernel/irq_32.c
index f3488c4..819cf80 100644
--- a/arch/sparc/kernel/irq_32.c
+++ b/arch/sparc/kernel/irq_32.c
@@ -294,6 +294,7 @@ void synchronize_irq(unsigned int irq)
 	while (sparc_irq[cpu_irq].flags & SPARC_IRQ_INPROGRESS)
 		cpu_relax();
 }
+EXPORT_SYMBOL(synchronize_irq);
 #endif /* SMP */
 
 void unexpected_irq(int irq, void *dev_id, struct pt_regs * regs)
diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
index 75ed98b..85e7037 100644
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -956,6 +956,7 @@ void outsb(unsigned long addr, const void *src, unsigned long count)
 		/* addr += 1; */
 	}
 }
+EXPORT_SYMBOL(outsb);
 
 void outsw(unsigned long addr, const void *src, unsigned long count)
 {
@@ -966,6 +967,7 @@ void outsw(unsigned long addr, const void *src, unsigned long count)
 		/* addr += 2; */
 	}
 }
+EXPORT_SYMBOL(outsw);
 
 void outsl(unsigned long addr, const void *src, unsigned long count)
 {
@@ -976,6 +978,7 @@ void outsl(unsigned long addr, const void *src, unsigned long count)
 		/* addr += 4; */
 	}
 }
+EXPORT_SYMBOL(outsl);
 
 void insb(unsigned long addr, void *dst, unsigned long count)
 {
@@ -986,6 +989,7 @@ void insb(unsigned long addr, void *dst, unsigned long count)
 		/* addr += 1; */
 	}
 }
+EXPORT_SYMBOL(insb);
 
 void insw(unsigned long addr, void *dst, unsigned long count)
 {
@@ -996,6 +1000,7 @@ void insw(unsigned long addr, void *dst, unsigned long count)
 		/* addr += 2; */
 	}
 }
+EXPORT_SYMBOL(insw);
 
 void insl(unsigned long addr, void *dst, unsigned long count)
 {
@@ -1009,5 +1014,6 @@ void insl(unsigned long addr, void *dst, unsigned long count)
 		/* addr += 4; */
 	}
 }
+EXPORT_SYMBOL(insl);
 
 subsys_initcall(pcic_init);
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index 5a8d8ce..f4bee35 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -44,6 +44,7 @@
  * Set in pm platform drivers (apc.c and pmc.c)
  */
 void (*pm_idle)(void);
+EXPORT_SYMBOL(pm_idle);
 
 /* 
  * Power-off handler instantiation for pm.h compliance
@@ -673,6 +674,7 @@ pid_t kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
 			     "g1", "g2", "g3", "o0", "o1", "memory", "cc");
 	return retval;
 }
+EXPORT_SYMBOL(kernel_thread);
 
 unsigned long get_wchan(struct task_struct *task)
 {
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index c96c65d..998cadb 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -199,7 +199,9 @@ extern unsigned short ram_flags;
 extern int root_mountflags;
 
 char reboot_command[COMMAND_LINE_SIZE];
+
 enum sparc_cpu sparc_cpu_model;
+EXPORT_SYMBOL(sparc_cpu_model);
 
 struct tt_entry *sparc_ttable;
 
@@ -391,6 +393,7 @@ void sun_do_break(void)
 
 	prom_cmdline();
 }
+EXPORT_SYMBOL(sun_do_break);
 
 int stop_a_enabled = 1;
 
diff --git a/arch/sparc/kernel/sparc_ksyms_32.c b/arch/sparc/kernel/sparc_ksyms_32.c
index 1391a4b..7e22767 100644
--- a/arch/sparc/kernel/sparc_ksyms_32.c
+++ b/arch/sparc/kernel/sparc_ksyms_32.c
@@ -6,68 +6,18 @@
  */
 
 #define PROMLIB_INTERNAL
-
 #include <linux/module.h>
-#include <linux/init.h>
-#include <linux/smp.h>
-#include <linux/types.h>
-#include <linux/sched.h>
-#include <linux/interrupt.h>
-#include <linux/in6.h>
-#include <linux/spinlock.h>
-#include <linux/mm.h>
-#include <linux/syscalls.h>
-#ifdef CONFIG_PCI
-#include <linux/pci.h>
-#endif
-#include <linux/pm.h>
-#ifdef CONFIG_HIGHMEM
-#include <linux/highmem.h>
-#endif
 
-#include <asm/oplib.h>
-#include <asm/delay.h>
-#include <asm/system.h>
-#include <asm/auxio.h>
 #include <asm/pgtable.h>
-#include <asm/io.h>
-#include <asm/irq.h>
+#include <asm/uaccess.h>
 #include <asm/idprom.h>
+#include <asm/delay.h>
 #include <asm/head.h>
-#include <asm/smp.h>
-#include <asm/ptrace.h>
-#include <asm/uaccess.h>
-#include <asm/checksum.h>
-#ifdef CONFIG_SBUS
 #include <asm/dma.h>
-#endif
-#include <asm/io-unit.h>
-#include <asm/bug.h>
-
-extern spinlock_t rtc_lock;
-
-/* used by various drivers */
-EXPORT_SYMBOL(sparc_cpu_model);
-EXPORT_SYMBOL(kernel_thread);
-
-EXPORT_SYMBOL(sparc_valid_addr_bitmap);
-EXPORT_SYMBOL(phys_base);
-EXPORT_SYMBOL(pfn_base);
-
-/* Per-CPU information table */
-EXPORT_PER_CPU_SYMBOL(__cpu_data);
-
-#ifdef CONFIG_SMP
-/* IRQ implementation. */
-EXPORT_SYMBOL(synchronize_irq);
-#endif
 
+/* from entry.S */
 EXPORT_SYMBOL(__udelay);
 EXPORT_SYMBOL(__ndelay);
-EXPORT_SYMBOL(rtc_lock);
-EXPORT_SYMBOL(set_auxio);
-EXPORT_SYMBOL(get_auxio);
-EXPORT_SYMBOL(io_remap_pfn_range);
 
 #ifndef CONFIG_SMP
 EXPORT_SYMBOL(BTFIXUP_CALL(___xchg32));
@@ -83,39 +33,6 @@ EXPORT_SYMBOL(BTFIXUP_CALL(mmu_release_scsi_one));
 
 EXPORT_SYMBOL(BTFIXUP_CALL(pgprot_noncached));
 
-#ifdef CONFIG_SBUS
-EXPORT_SYMBOL(sbus_set_sbus64);
-#endif
-#ifdef CONFIG_PCI
-EXPORT_SYMBOL(insb);
-EXPORT_SYMBOL(outsb);
-EXPORT_SYMBOL(insw);
-EXPORT_SYMBOL(outsw);
-EXPORT_SYMBOL(insl);
-EXPORT_SYMBOL(outsl);
-EXPORT_SYMBOL(pci_alloc_consistent);
-EXPORT_SYMBOL(pci_free_consistent);
-EXPORT_SYMBOL(pci_map_single);
-EXPORT_SYMBOL(pci_unmap_single);
-EXPORT_SYMBOL(pci_dma_sync_single_for_cpu);
-EXPORT_SYMBOL(pci_dma_sync_single_for_device);
-EXPORT_SYMBOL(pci_dma_sync_sg_for_cpu);
-EXPORT_SYMBOL(pci_dma_sync_sg_for_device);
-EXPORT_SYMBOL(pci_map_sg);
-EXPORT_SYMBOL(pci_unmap_sg);
-EXPORT_SYMBOL(pci_map_page);
-EXPORT_SYMBOL(pci_unmap_page);
-/* Actually, ioremap/iounmap are not PCI specific. But it is ok for drivers. */
-EXPORT_SYMBOL(ioremap);
-EXPORT_SYMBOL(iounmap);
-#endif
-
-/* in arch/sparc/mm/highmem.c */
-#ifdef CONFIG_HIGHMEM
-EXPORT_SYMBOL(kmap_atomic);
-EXPORT_SYMBOL(kunmap_atomic);
-#endif
-
 /* prom symbols */
 EXPORT_SYMBOL(idprom);
 EXPORT_SYMBOL(prom_root_node);
@@ -140,22 +57,6 @@ EXPORT_SYMBOL(romvec);
 EXPORT_SYMBOL(__prom_getchild);
 EXPORT_SYMBOL(__prom_getsibling);
 
-/* sparc library symbols */
-EXPORT_SYMBOL(page_kernel);
-
-/* Cache flushing.  */
-EXPORT_SYMBOL(sparc_flush_page_to_ram);
-
-/* For when serial stuff is built as modules. */
-EXPORT_SYMBOL(sun_do_break);
-
+/* from head_32.S */
 EXPORT_SYMBOL(__ret_efault);
-
-#ifdef CONFIG_DEBUG_BUGVERBOSE
-EXPORT_SYMBOL(do_BUG);
-#endif
-
-/* Sun Power Management Idle Handler */
-EXPORT_SYMBOL(pm_idle);
-
 EXPORT_SYMBOL(empty_zero_page);
diff --git a/arch/sparc/kernel/sparc_ksyms_64.c b/arch/sparc/kernel/sparc_ksyms_64.c
index d52306a..9e861fa 100644
--- a/arch/sparc/kernel/sparc_ksyms_64.c
+++ b/arch/sparc/kernel/sparc_ksyms_64.c
@@ -55,9 +55,6 @@ extern int io_remap_pfn_range(struct vm_area_struct *vma, unsigned long from,
 
 extern int dump_fpu (struct pt_regs * regs, elf_fpregset_t * fpregs);
 
-/* Per-CPU information table */
-EXPORT_PER_CPU_SYMBOL(__cpu_data);
-
 /* used by various drivers */
 #ifdef CONFIG_SMP
 /* Out of line rw-locking implementation. */
diff --git a/arch/sparc/kernel/time_32.c b/arch/sparc/kernel/time_32.c
index 00f7383..614ac7b 100644
--- a/arch/sparc/kernel/time_32.c
+++ b/arch/sparc/kernel/time_32.c
@@ -48,6 +48,8 @@
 #include "irq.h"
 
 DEFINE_SPINLOCK(rtc_lock);
+EXPORT_SYMBOL(rtc_lock);
+
 static int set_rtc_mmss(unsigned long);
 static int sbus_do_settimeofday(struct timespec *tv);
 
diff --git a/arch/sparc/kernel/traps_32.c b/arch/sparc/kernel/traps_32.c
index 213645b..3582833 100644
--- a/arch/sparc/kernel/traps_32.c
+++ b/arch/sparc/kernel/traps_32.c
@@ -424,6 +424,7 @@ void do_BUG(const char *file, int line)
         // bust_spinlocks(1);   XXX Not in our original BUG()
         printk("kernel BUG at %s:%d!\n", file, line);
 }
+EXPORT_SYMBOL(do_BUG);
 #endif
 
 /* Since we have our mappings set up, on multiprocessors we can spin them
diff --git a/arch/sparc/mm/generic_32.c b/arch/sparc/mm/generic_32.c
index a289261..5edcac1 100644
--- a/arch/sparc/mm/generic_32.c
+++ b/arch/sparc/mm/generic_32.c
@@ -95,3 +95,4 @@ int io_remap_pfn_range(struct vm_area_struct *vma, unsigned long from,
 	flush_tlb_range(vma, beg, end);
 	return error;
 }
+EXPORT_SYMBOL(io_remap_pfn_range);
diff --git a/arch/sparc/mm/highmem.c b/arch/sparc/mm/highmem.c
index 01fc6c2..752d0c9 100644
--- a/arch/sparc/mm/highmem.c
+++ b/arch/sparc/mm/highmem.c
@@ -62,6 +62,7 @@ void *kmap_atomic(struct page *page, enum km_type type)
 
 	return (void*) vaddr;
 }
+EXPORT_SYMBOL(kmap_atomic);
 
 void kunmap_atomic(void *kvaddr, enum km_type type)
 {
@@ -98,6 +99,7 @@ void kunmap_atomic(void *kvaddr, enum km_type type)
 
 	pagefault_enable();
 }
+EXPORT_SYMBOL(kunmap_atomic);
 
 /* We may be fed a pagetable here by ptep_to_xxx and others. */
 struct page *kmap_atomic_to_page(void *ptr)
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index fec9260..cbb282d 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -38,11 +38,16 @@
 DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 
 unsigned long *sparc_valid_addr_bitmap;
+EXPORT_SYMBOL(sparc_valid_addr_bitmap);
 
 unsigned long phys_base;
+EXPORT_SYMBOL(phys_base);
+
 unsigned long pfn_base;
+EXPORT_SYMBOL(pfn_base);
 
 unsigned long page_kernel;
+EXPORT_SYMBOL(page_kernel);
 
 struct sparc_phys_banks sp_banks[SPARC_PHYS_BANKS+1];
 unsigned long sparc_unmapped_base;
@@ -522,3 +527,4 @@ void sparc_flush_page_to_ram(struct page *page)
 	if (vaddr)
 		__flush_page_to_ram(vaddr);
 }
+EXPORT_SYMBOL(sparc_flush_page_to_ram);
-- 
1.6.0.2.GIT

