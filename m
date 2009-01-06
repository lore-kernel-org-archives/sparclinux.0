From: Julian Calaby <julian.calaby@gmail.com>
Date: Tue, 06 Jan 2009 14:58:23 +0000
Subject: [PATCH 2/5] sparc: move EXPORT_SYMBOL to the symbols definition
Message-Id: <4963718F.5050705@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>

sparc: move EXPORT_SYMBOL to the symbols definition

Move all applicable EXPORT_SYMBOL()s to the file where the respective
symbol is defined.

Removed all the includes that are no longer needed in sparc_ksyms_32.c

Comment all remaining EXPORT_SYMBOL()s in sparc_ksyms_32.c

Two symbols are shared with sparc64 thus the exports were removed from
the sparc_ksyms_64.c too, along with the include their ommission made
redundant.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Additions by Julian Calaby:
* Moved EXPORT_SYMBOL()s for prom functions to their rightful places.
* Made some minor cleanups to the includes and comments of sparc_ksyms_32.c
* Made another subtraction from sparc_ksyms_64.c
* Updated and tidied commit message.
* Rebased patch over sparc-2.6.git HEAD.

Signed-off-by: Julian Calaby <julian.calaby@gmail.com>

---

This patch was originally made by Sam Ravnborg, but this version has
some additions from Julian Calaby. I've had a go at marking this in the
patch, but I'm not sure I've gotten it right.

I can submit my parts separately if needed.
---
  arch/sparc/kernel/auxio_32.c       |    3 +-
  arch/sparc/kernel/cpu.c            |    2 +
  arch/sparc/kernel/idprom.c         |    2 +
  arch/sparc/kernel/ioport.c         |   15 ++++
  arch/sparc/kernel/irq_32.c         |    1 +
  arch/sparc/kernel/pcic.c           |    6 ++
  arch/sparc/kernel/process_32.c     |    2 +
  arch/sparc/kernel/setup_32.c       |    3 +
  arch/sparc/kernel/sparc_ksyms_32.c |  137
+++---------------------------------
  arch/sparc/kernel/sparc_ksyms_64.c |    5 --
  arch/sparc/kernel/time_32.c        |    2 +
  arch/sparc/kernel/traps_32.c       |    1 +
  arch/sparc/mm/generic_32.c         |    1 +
  arch/sparc/mm/highmem.c            |    2 +
  arch/sparc/mm/init_32.c            |    6 ++
  arch/sparc/prom/init_32.c          |    3 +
  arch/sparc/prom/misc_32.c          |    1 +
  arch/sparc/prom/ranges.c           |    1 +
  arch/sparc/prom/tree_32.c          |   16 ++++
  19 files changed, 75 insertions(+), 134 deletions(-)

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
@@ -102,7 +103,7 @@ void set_auxio(unsigned char bits_on, unsigned char
bits_off)
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

  DEFINE_PER_CPU(cpuinfo_sparc, __cpu_data) =3D { 0 };
+EXPORT_PER_CPU_SYMBOL(__cpu_data);

  struct cpu_info {
  	int psr_vers;
diff --git a/arch/sparc/kernel/idprom.c b/arch/sparc/kernel/idprom.c
index c16135e..19ec377 100644
--- a/arch/sparc/kernel/idprom.c
+++ b/arch/sparc/kernel/idprom.c
@@ -13,6 +13,8 @@
  #include <asm/idprom.h>

  struct idprom *idprom;
+EXPORT_SYMBOL(idprom);
+
  static struct idprom idprom_buffer;

  #ifdef CONFIG_SPARC32
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 7ce14f0..87ea0d0 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -120,6 +120,7 @@ void __iomem *ioremap(unsigned long offset, unsigned
long size)
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
@@ -436,6 +439,7 @@ void *pci_alloc_consistent(struct pci_dev *pdev,
size_t len, dma_addr_t *pba)
  	*pba =3D virt_to_phys(va); /* equals virt_to_bus (R.I.P.) for us. */
  	return (void *) res->start;
  }
+EXPORT_SYMBOL(pci_alloc_consistent);

  /* Free and unmap a consistent DMA buffer.
   * cpu_addr is what was returned from pci_alloc_consistent,
@@ -477,6 +481,7 @@ void pci_free_consistent(struct pci_dev *pdev,
size_t n, void *p, dma_addr_t ba)

  	free_pages(pgp, get_order(n));
  }
+EXPORT_SYMBOL(pci_free_consistent);

  /* Map a single buffer of the indicated size for DMA in streaming mode.
   * The 32-bit bus address to use is returned.
@@ -491,6 +496,7 @@ dma_addr_t pci_map_single(struct pci_dev *hwdev,
void *ptr, size_t size,
  	/* IIep is write-through, not flushing. */
  	return virt_to_phys(ptr);
  }
+EXPORT_SYMBOL(pci_map_single);

  /* Unmap a single streaming mode DMA translation.  The dma_addr and size
   * must match what was provided for in a previous pci_map_single call.
  All
@@ -508,6 +514,7 @@ void pci_unmap_single(struct pci_dev *hwdev,
dma_addr_t ba, size_t size,
  		    (size + PAGE_SIZE-1) & PAGE_MASK);
  	}
  }
+EXPORT_SYMBOL(pci_unmap_single);

  /*
   * Same as pci_map_single, but with pages.
@@ -519,6 +526,7 @@ dma_addr_t pci_map_page(struct pci_dev *hwdev,
struct page *page,
  	/* IIep is write-through, not flushing. */
  	return page_to_phys(page) + offset;
  }
+EXPORT_SYMBOL(pci_map_page);

  void pci_unmap_page(struct pci_dev *hwdev,
  			dma_addr_t dma_address, size_t size, int direction)
@@ -526,6 +534,7 @@ void pci_unmap_page(struct pci_dev *hwdev,
  	BUG_ON(direction =3D PCI_DMA_NONE);
  	/* mmu_inval_dma_area XXX */
  }
+EXPORT_SYMBOL(pci_unmap_page);

  /* Map a set of buffers described by scatterlist in streaming
   * mode for DMA.  This is the scather-gather version of the
@@ -557,6 +566,7 @@ int pci_map_sg(struct pci_dev *hwdev, struct
scatterlist *sgl, int nents,
  	}
  	return nents;
  }
+EXPORT_SYMBOL(pci_map_sg);

  /* Unmap a set of streaming mode DMA translations.
   * Again, cpu read rules concerning calls here are the same as for
@@ -578,6 +588,7 @@ void pci_unmap_sg(struct pci_dev *hwdev, struct
scatterlist *sgl, int nents,
  		}
  	}
  }
+EXPORT_SYMBOL(pci_unmap_sg);

  /* Make physical memory consistent for a single
   * streaming mode DMA translation before or after a transfer.
@@ -597,6 +608,7 @@ void pci_dma_sync_single_for_cpu(struct pci_dev
*hwdev, dma_addr_t ba, size_t si
  		    (size + PAGE_SIZE-1) & PAGE_MASK);
  	}
  }
+EXPORT_SYMBOL(pci_dma_sync_single_for_cpu);

  void pci_dma_sync_single_for_device(struct pci_dev *hwdev, dma_addr_t
ba, size_t size, int direction)
  {
@@ -606,6 +618,7 @@ void pci_dma_sync_single_for_device(struct pci_dev
*hwdev, dma_addr_t ba, size_t
  		    (size + PAGE_SIZE-1) & PAGE_MASK);
  	}
  }
+EXPORT_SYMBOL(pci_dma_sync_single_for_device);

  /* Make physical memory consistent for a set of streaming
   * mode DMA translations after a transfer.
@@ -628,6 +641,7 @@ void pci_dma_sync_sg_for_cpu(struct pci_dev *hwdev,
struct scatterlist *sgl, int
  		}
  	}
  }
+EXPORT_SYMBOL(pci_dma_sync_sg_for_cpu);

  void pci_dma_sync_sg_for_device(struct pci_dev *hwdev, struct
scatterlist *sgl, int nents, int direction)
  {
@@ -644,6 +658,7 @@ void pci_dma_sync_sg_for_device(struct pci_dev
*hwdev, struct scatterlist *sgl,
  		}
  	}
  }
+EXPORT_SYMBOL(pci_dma_sync_sg_for_device);
  #endif /* CONFIG_PCI */

  #ifdef CONFIG_PROC_FS
diff --git a/arch/sparc/kernel/irq_32.c b/arch/sparc/kernel/irq_32.c
index 1eff942..44dd5ee 100644
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
@@ -956,6 +956,7 @@ void outsb(unsigned long addr, const void *src,
unsigned long count)
  		/* addr +=3D 1; */
  	}
  }
+EXPORT_SYMBOL(outsb);

  void outsw(unsigned long addr, const void *src, unsigned long count)
  {
@@ -966,6 +967,7 @@ void outsw(unsigned long addr, const void *src,
unsigned long count)
  		/* addr +=3D 2; */
  	}
  }
+EXPORT_SYMBOL(outsw);

  void outsl(unsigned long addr, const void *src, unsigned long count)
  {
@@ -976,6 +978,7 @@ void outsl(unsigned long addr, const void *src,
unsigned long count)
  		/* addr +=3D 4; */
  	}
  }
+EXPORT_SYMBOL(outsl);

  void insb(unsigned long addr, void *dst, unsigned long count)
  {
@@ -986,6 +989,7 @@ void insb(unsigned long addr, void *dst, unsigned
long count)
  		/* addr +=3D 1; */
  	}
  }
+EXPORT_SYMBOL(insb);

  void insw(unsigned long addr, void *dst, unsigned long count)
  {
@@ -996,6 +1000,7 @@ void insw(unsigned long addr, void *dst, unsigned
long count)
  		/* addr +=3D 2; */
  	}
  }
+EXPORT_SYMBOL(insw);

  void insl(unsigned long addr, void *dst, unsigned long count)
  {
@@ -1009,5 +1014,6 @@ void insl(unsigned long addr, void *dst, unsigned
long count)
  		/* addr +=3D 4; */
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
@@ -673,6 +674,7 @@ pid_t kernel_thread(int (*fn)(void *), void * arg,
unsigned long flags)
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

  int stop_a_enabled =3D 1;

diff --git a/arch/sparc/kernel/sparc_ksyms_32.c
b/arch/sparc/kernel/sparc_ksyms_32.c
index f4ee14d..8397871 100644
--- a/arch/sparc/kernel/sparc_ksyms_32.c
+++ b/arch/sparc/kernel/sparc_ksyms_32.c
@@ -9,42 +9,12 @@

  #include <linux/module.h>
  #include <linux/init.h>
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
-#include <asm/idprom.h>
-#include <asm/head.h>
-#include <asm/smp.h>
-#include <asm/ptrace.h>
  #include <asm/uaccess.h>
-#include <asm/checksum.h>
-#ifdef CONFIG_SBUS
+#include <asm/delay.h>
+#include <asm/head.h>
  #include <asm/dma.h>
-#endif
-#include <asm/io-unit.h>
-#include <asm/bug.h>
-
-extern spinlock_t rtc_lock;

  struct poll {
  	int fd;
@@ -52,29 +22,15 @@ struct poll {
  	short revents;
  };

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
-
+/* from entry.S */
  EXPORT_SYMBOL(__udelay);
  EXPORT_SYMBOL(__ndelay);
-EXPORT_SYMBOL(rtc_lock);
-EXPORT_SYMBOL(set_auxio);
-EXPORT_SYMBOL(get_auxio);
-EXPORT_SYMBOL(io_remap_pfn_range);

+/* from head_32.S */
+EXPORT_SYMBOL(__ret_efault);
+EXPORT_SYMBOL(empty_zero_page);
+
+/* Defined using magic */
  #ifndef CONFIG_SMP
  EXPORT_SYMBOL(BTFIXUP_CALL(___xchg32));
  #else
@@ -86,82 +42,7 @@ EXPORT_SYMBOL(BTFIXUP_CALL(mmu_get_scsi_sgl));
  EXPORT_SYMBOL(BTFIXUP_CALL(mmu_get_scsi_one));
  EXPORT_SYMBOL(BTFIXUP_CALL(mmu_release_scsi_sgl));
  EXPORT_SYMBOL(BTFIXUP_CALL(mmu_release_scsi_one));
-
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
-/* Actually, ioremap/iounmap are not PCI specific. But it is ok for
drivers. */
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
-/* prom symbols */
-EXPORT_SYMBOL(idprom);
-EXPORT_SYMBOL(prom_root_node);
-EXPORT_SYMBOL(prom_getchild);
-EXPORT_SYMBOL(prom_getsibling);
-EXPORT_SYMBOL(prom_searchsiblings);
-EXPORT_SYMBOL(prom_firstprop);
-EXPORT_SYMBOL(prom_nextprop);
-EXPORT_SYMBOL(prom_getproplen);
-EXPORT_SYMBOL(prom_getproperty);
-EXPORT_SYMBOL(prom_node_has_property);
-EXPORT_SYMBOL(prom_setprop);
+/* Exporting a symbol from /init/main.c */
  EXPORT_SYMBOL(saved_command_line);
-EXPORT_SYMBOL(prom_apply_obio_ranges);
-EXPORT_SYMBOL(prom_feval);
-EXPORT_SYMBOL(prom_getbool);
-EXPORT_SYMBOL(prom_getstring);
-EXPORT_SYMBOL(prom_getint);
-EXPORT_SYMBOL(prom_getintdefault);
-EXPORT_SYMBOL(prom_finddevice);
-EXPORT_SYMBOL(romvec);
-EXPORT_SYMBOL(__prom_getchild);
-EXPORT_SYMBOL(__prom_getsibling);
-
-/* sparc library symbols */
-EXPORT_SYMBOL(page_kernel);
-
-/* Cache flushing.  */
-EXPORT_SYMBOL(sparc_flush_page_to_ram);
-
-/* For when serial stuff is built as modules. */
-EXPORT_SYMBOL(sun_do_break);
-
-EXPORT_SYMBOL(__ret_efault);
-
-#ifdef CONFIG_DEBUG_BUGVERBOSE
-EXPORT_SYMBOL(do_BUG);
-#endif
-
-/* Sun Power Management Idle Handler */
-EXPORT_SYMBOL(pm_idle);
-
-EXPORT_SYMBOL(empty_zero_page);
diff --git a/arch/sparc/kernel/sparc_ksyms_64.c
b/arch/sparc/kernel/sparc_ksyms_64.c
index 09874ea..62b5a91 100644
--- a/arch/sparc/kernel/sparc_ksyms_64.c
+++ b/arch/sparc/kernel/sparc_ksyms_64.c
@@ -29,7 +29,6 @@
  #include <asm/pgtable.h>
  #include <asm/io.h>
  #include <asm/irq.h>
-#include <asm/idprom.h>
  #include <asm/elf.h>
  #include <asm/head.h>
  #include <asm/smp.h>
@@ -67,9 +66,6 @@ extern int __ashrdi3(int, int);

  extern int dump_fpu (struct pt_regs * regs, elf_fpregset_t * fpregs);

-/* Per-CPU information table */
-EXPORT_PER_CPU_SYMBOL(__cpu_data);
-
  /* used by various drivers */
  #ifdef CONFIG_SMP
  /* Out of line rw-locking implementation. */
@@ -134,7 +130,6 @@ EXPORT_SYMBOL(die_if_kernel);
  EXPORT_SYMBOL(kernel_thread);

  /* prom symbols */
-EXPORT_SYMBOL(idprom);
  EXPORT_SYMBOL(prom_root_node);
  EXPORT_SYMBOL(prom_getchild);
  EXPORT_SYMBOL(prom_getsibling);
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
@@ -95,3 +95,4 @@ int io_remap_pfn_range(struct vm_area_struct *vma,
unsigned long from,
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
diff --git a/arch/sparc/prom/init_32.c b/arch/sparc/prom/init_32.c
index 873217c..14409a9 100644
--- a/arch/sparc/prom/init_32.c
+++ b/arch/sparc/prom/init_32.c
@@ -13,11 +13,14 @@
  #include <asm/oplib.h>

  struct linux_romvec *romvec;
+EXPORT_SYMBOL(romvec);
+
  enum prom_major_version prom_vers;
  unsigned int prom_rev, prom_prev;

  /* The root node of the prom device tree. */
  int prom_root_node;
+EXPORT_SYMBOL(prom_root_node);

  /* Pointer to the device tree operations structure. */
  struct linux_nodeops *prom_nodeops;
diff --git a/arch/sparc/prom/misc_32.c b/arch/sparc/prom/misc_32.c
index cf6c3f6..06b0936 100644
--- a/arch/sparc/prom/misc_32.c
+++ b/arch/sparc/prom/misc_32.c
@@ -44,6 +44,7 @@ prom_feval(char *fstring)
  	restore_current();
  	spin_unlock_irqrestore(&prom_lock, flags);
  }
+EXPORT_SYMBOL(prom_feval);

  /* Drop into the prom, with the chance to continue with the 'go'
   * prom command.
diff --git a/arch/sparc/prom/ranges.c b/arch/sparc/prom/ranges.c
index 64579a3..6f30431 100644
--- a/arch/sparc/prom/ranges.c
+++ b/arch/sparc/prom/ranges.c
@@ -62,6 +62,7 @@ prom_apply_obio_ranges(struct linux_prom_registers
*regs, int nregs)
  	if(num_obio_ranges)
  		prom_adjust_regs(regs, nregs, promlib_obio_ranges, num_obio_ranges);
  }
+EXPORT_SYMBOL(prom_apply_obio_ranges);

  void __init prom_ranges_init(void)
  {
diff --git a/arch/sparc/prom/tree_32.c b/arch/sparc/prom/tree_32.c
index 6d81873..7416827 100644
--- a/arch/sparc/prom/tree_32.c
+++ b/arch/sparc/prom/tree_32.c
@@ -33,6 +33,7 @@ int __prom_getchild(int node)

  	return cnode;
  }
+EXPORT_SYMBOL(__prom_getchild);

  /* Return the child of node 'node' or zero if no this node has no
   * direct descendent.
@@ -50,6 +51,7 @@ int prom_getchild(int node)

  	return cnode;
  }
+EXPORT_SYMBOL(prom_getchild);

  /* Internal version of prom_getsibling that does not alter return
values. */
  int __prom_getsibling(int node)
@@ -64,6 +66,7 @@ int __prom_getsibling(int node)

  	return cnode;
  }
+EXPORT_SYMBOL(__prom_getsibling);

  /* Return the next sibling of node 'node' or zero if no more siblings
   * at this level of depth in the tree.
@@ -81,6 +84,7 @@ int prom_getsibling(int node)

  	return sibnode;
  }
+EXPORT_SYMBOL(prom_getsibling);

  /* Return the length in bytes of property 'prop' at node 'node'.
   * Return -1 on error.
@@ -99,6 +103,7 @@ int prom_getproplen(int node, const char *prop)
  	spin_unlock_irqrestore(&prom_lock, flags);
  	return ret;
  }
+EXPORT_SYMBOL(prom_getproplen);

  /* Acquire a property 'prop' at node 'node' and place it in
   * 'buffer' which has a size of 'bufsize'.  If the acquisition
@@ -119,6 +124,7 @@ int prom_getproperty(int node, const char *prop,
char *buffer, int bufsize)
  	spin_unlock_irqrestore(&prom_lock, flags);
  	return ret;
  }
+EXPORT_SYMBOL(prom_getproperty);

  /* Acquire an integer property and return its value.  Returns -1
   * on failure.
@@ -132,6 +138,7 @@ int prom_getint(int node, char *prop)

  	return -1;
  }
+EXPORT_SYMBOL(prom_getint);

  /* Acquire an integer property, upon error return the passed default
   * integer.
@@ -145,6 +152,7 @@ int prom_getintdefault(int node, char *property, int
deflt)

  	return retval;
  }
+EXPORT_SYMBOL(prom_getintdefault);

  /* Acquire a boolean property, 1=3DTRUE 0=FALSE. */
  int prom_getbool(int node, char *prop)
@@ -155,6 +163,7 @@ int prom_getbool(int node, char *prop)
  	if(retval =3D -1) return 0;
  	return 1;
  }
+EXPORT_SYMBOL(prom_getbool);

  /* Acquire a property whose value is a string, returns a null
   * string on error.  The char pointer is the user supplied string
@@ -169,6 +178,7 @@ void prom_getstring(int node, char *prop, char
*user_buf, int ubuf_size)
  	user_buf[0] =3D 0;
  	return;
  }
+EXPORT_SYMBOL(prom_getstring);


  /* Does the device at node 'node' have name 'name'?
@@ -204,6 +214,7 @@ int prom_searchsiblings(int node_start, char *nodename)

  	return 0;
  }
+EXPORT_SYMBOL(prom_searchsiblinbs);

  /* Interal version of nextprop that does not alter return values. */
  char * __prom_nextprop(int node, char * oprop)
@@ -228,6 +239,7 @@ char * prom_firstprop(int node, char *bufer)

  	return __prom_nextprop(node, "");
  }
+EXPORT_SYMBOL(prom_firstprop);

  /* Return the property type string after property type 'oprop'
   * at node 'node' .  Returns empty string if no more
@@ -240,6 +252,7 @@ char * prom_nextprop(int node, char *oprop, char
*buffer)

  	return __prom_nextprop(node, oprop);
  }
+EXPORT_SYMBOL(prom_nextprop);

  int prom_finddevice(char *name)
  {
@@ -287,6 +300,7 @@ int prom_finddevice(char *name)
  	}
  	return node;
  }
+EXPORT_SYMBOL(prom_finddevice);

  int prom_node_has_property(int node, char *prop)
  {
@@ -299,6 +313,7 @@ int prom_node_has_property(int node, char *prop)
  	} while (*current_property);
  	return 0;
  }
+EXPORT_SYMBOL(prom_node_has_property);

  /* Set property 'pname' at node 'node' to value 'value' which has a length
   * of 'size' bytes.  Return the number of bytes the prom accepted.
@@ -316,6 +331,7 @@ int prom_setprop(int node, const char *pname, char
*value, int size)
  	spin_unlock_irqrestore(&prom_lock, flags);
  	return ret;
  }
+EXPORT_SYMBOL(prom_setprop);

  int prom_inst2pkg(int inst)
  {
