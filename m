From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 05 Jan 2009 19:48:06 +0000
Subject: [PATCH 3/3] sparc64: move EXPORT_SYMBOL to the symbols definition
Message-Id: <1231184886-5113-3-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Move all applicable EXPORT_SYMBOL to the file where the respective
symbol is defined.

Removed all the includes that is no longer needed in sparc_ksyms_64.c

This patch do not touch the prom* functions - this is to be adressed later.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/auxio_64.c       |    2 +
 arch/sparc/kernel/pci.c            |    1 +
 arch/sparc/kernel/process_64.c     |    2 +
 arch/sparc/kernel/sbus.c           |    1 +
 arch/sparc/kernel/setup_64.c       |    3 +
 arch/sparc/kernel/sparc_ksyms_64.c |  100 ++----------------------------------
 arch/sparc/kernel/sys_sparc_64.c   |    1 +
 arch/sparc/kernel/time_64.c        |    2 +
 arch/sparc/kernel/traps_64.c       |    2 +
 arch/sparc/lib/PeeCeeI.c           |    7 ++-
 arch/sparc/lib/user_fixup.c        |    3 +
 arch/sparc/mm/generic_64.c         |    1 +
 arch/sparc/mm/init_64.c            |    4 ++
 13 files changed, 33 insertions(+), 96 deletions(-)

diff --git a/arch/sparc/kernel/auxio_64.c b/arch/sparc/kernel/auxio_64.c
index 8b67347..9f52db2 100644
--- a/arch/sparc/kernel/auxio_64.c
+++ b/arch/sparc/kernel/auxio_64.c
@@ -72,6 +72,7 @@ void auxio_set_led(int on)
 	bit = (ebus ? AUXIO_PCIO_LED : AUXIO_AUX1_LED);
 	__auxio_set_bit(bit, on, ebus);
 }
+EXPORT_SYMBOL(auxio_set_led);
 
 static void __auxio_sbus_set_lte(int on)
 {
@@ -90,6 +91,7 @@ void auxio_set_lte(int on)
 		break;
 	}
 }
+EXPORT_SYMBOL(auxio_set_lte);
 
 static struct of_device_id __initdata auxio_match[] = {
 	{
diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index bdb7c0a..1f5ea94 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -1077,6 +1077,7 @@ int pci_dma_supported(struct pci_dev *pdev, u64 device_mask)
 
 	return (device_mask & dma_addr_mask) = dma_addr_mask;
 }
+EXPORT_SYMBOL(pci_dma_supported);
 
 void pci_resource_to_user(const struct pci_dev *pdev, int bar,
 			  const struct resource *rp, resource_size_t *start,
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index d5e2ace..cc8b560 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -678,6 +678,7 @@ pid_t kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
 			     "g1", "g2", "g3", "o0", "o1", "memory", "cc");
 	return retval;
 }
+EXPORT_SYMBOL(kernel_thread);
 
 typedef struct {
 	union {
@@ -743,6 +744,7 @@ int dump_fpu (struct pt_regs * regs, elf_fpregset_t * fpregs)
 	}
 	return 1;
 }
+EXPORT_SYMBOL(dump_fpu);
 
 /*
  * sparc_execve() executes a new program after the asm stub has set
diff --git a/arch/sparc/kernel/sbus.c b/arch/sparc/kernel/sbus.c
index 2ead310..406e087 100644
--- a/arch/sparc/kernel/sbus.c
+++ b/arch/sparc/kernel/sbus.c
@@ -117,6 +117,7 @@ void sbus_set_sbus64(struct device *dev, int bursts)
 		val |= (1UL << 4UL);
 	upa_writeq(val, cfg_reg);
 }
+EXPORT_SYMBOL(sbus_set_sbus64);
 
 /* INO number to IMAP register offset for SYSIO external IRQ's.
  * This should conform to both Sunfire/Wildfire server and Fusion
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 555db74..49d061f 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -58,6 +58,7 @@
  * operations in asm/ns87303.h
  */
 DEFINE_SPINLOCK(ns87303_lock);
+EXPORT_SYMBOL(ns87303_lock);
 
 struct screen_info screen_info = {
 	0, 0,			/* orig-x, orig-y */
@@ -425,5 +426,7 @@ void sun_do_break(void)
 
 	prom_cmdline();
 }
+EXPORT_SYMBOL(sun_do_break);
 
 int stop_a_enabled = 1;
+EXPORT_SYMBOL(stop_a_enabled);
diff --git a/arch/sparc/kernel/sparc_ksyms_64.c b/arch/sparc/kernel/sparc_ksyms_64.c
index 9e861fa..4935299 100644
--- a/arch/sparc/kernel/sparc_ksyms_64.c
+++ b/arch/sparc/kernel/sparc_ksyms_64.c
@@ -8,52 +8,10 @@
 #define PROMLIB_INTERNAL
 
 #include <linux/module.h>
-#include <linux/types.h>
-#include <linux/sched.h>
-#include <linux/in6.h>
 #include <linux/pci.h>
-#include <linux/interrupt.h>
-#include <linux/fs_struct.h>
-#include <linux/fs.h>
-#include <linux/mm.h>
-#include <linux/socket.h>
-#include <linux/syscalls.h>
-#include <linux/percpu.h>
-#include <linux/init.h>
-#include <linux/rwsem.h>
-#include <net/compat.h>
 
 #include <asm/oplib.h>
-#include <asm/system.h>
-#include <asm/auxio.h>
-#include <asm/pgtable.h>
-#include <asm/io.h>
-#include <asm/irq.h>
 #include <asm/idprom.h>
-#include <asm/elf.h>
-#include <asm/head.h>
-#include <asm/smp.h>
-#include <asm/ptrace.h>
-#include <asm/uaccess.h>
-#include <asm/checksum.h>
-#include <asm/fpumacro.h>
-#include <asm/pgalloc.h>
-#include <asm/cacheflush.h>
-#ifdef CONFIG_SBUS
-#include <asm/dma.h>
-#endif
-#include <asm/ns87303.h>
-#include <asm/timer.h>
-#include <asm/cpudata.h>
-#include <asm/ftrace.h>
-#include <asm/hypervisor.h>
-
-extern void die_if_kernel(char *str, struct pt_regs *regs);
-extern pid_t kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
-extern int io_remap_pfn_range(struct vm_area_struct *vma, unsigned long from,
-	unsigned long pfn, unsigned long size, pgprot_t prot);
-
-extern int dump_fpu (struct pt_regs * regs, elf_fpregset_t * fpregs);
 
 /* used by various drivers */
 #ifdef CONFIG_SMP
@@ -65,37 +23,21 @@ EXPORT_SYMBOL(__write_unlock);
 EXPORT_SYMBOL(__write_trylock);
 #endif /* CONFIG_SMP */
 
-EXPORT_SYMBOL(sparc64_get_clock_tick);
-
+/* helpers.S */
 EXPORT_SYMBOL(__flushw_user);
 
+/* head_64.S */
 EXPORT_SYMBOL(tlb_type);
 EXPORT_SYMBOL(sun4v_chip_type);
-EXPORT_SYMBOL(get_fb_unmapped_area);
-EXPORT_SYMBOL(flush_icache_range);
-
-EXPORT_SYMBOL(flush_dcache_page);
-#ifdef DCACHE_ALIASING_POSSIBLE
-EXPORT_SYMBOL(__flush_dcache_range);
-#endif
 
+/* hvcalls.S */
 EXPORT_SYMBOL(sun4v_niagara_getperf);
 EXPORT_SYMBOL(sun4v_niagara_setperf);
 EXPORT_SYMBOL(sun4v_niagara2_getperf);
 EXPORT_SYMBOL(sun4v_niagara2_setperf);
 
-EXPORT_SYMBOL(auxio_set_led);
-EXPORT_SYMBOL(auxio_set_lte);
-#ifdef CONFIG_SBUS
-EXPORT_SYMBOL(sbus_set_sbus64);
-#endif
-EXPORT_SYMBOL(outsb);
-EXPORT_SYMBOL(outsw);
-EXPORT_SYMBOL(outsl);
-EXPORT_SYMBOL(insb);
-EXPORT_SYMBOL(insw);
-EXPORT_SYMBOL(insl);
 #ifdef CONFIG_PCI
+/* iinline functions in asm/pci_64.h */
 EXPORT_SYMBOL(pci_alloc_consistent);
 EXPORT_SYMBOL(pci_free_consistent);
 EXPORT_SYMBOL(pci_map_single);
@@ -104,20 +46,8 @@ EXPORT_SYMBOL(pci_map_sg);
 EXPORT_SYMBOL(pci_unmap_sg);
 EXPORT_SYMBOL(pci_dma_sync_single_for_cpu);
 EXPORT_SYMBOL(pci_dma_sync_sg_for_cpu);
-EXPORT_SYMBOL(pci_dma_supported);
 #endif
 
-/* I/O device mmaping on Sparc64. */
-EXPORT_SYMBOL(io_remap_pfn_range);
-
-EXPORT_SYMBOL(dump_fpu);
-
-/* math-emu wants this */
-EXPORT_SYMBOL(die_if_kernel);
-
-/* Kernel thread creation. */
-EXPORT_SYMBOL(kernel_thread);
-
 /* prom symbols */
 EXPORT_SYMBOL(idprom);
 EXPORT_SYMBOL(prom_root_node);
@@ -140,30 +70,10 @@ EXPORT_SYMBOL(prom_getintdefault);
 EXPORT_SYMBOL(__prom_getchild);
 EXPORT_SYMBOL(__prom_getsibling);
 
-/* Moving data to/from/in userspace. */
-EXPORT_SYMBOL(copy_to_user_fixup);
-EXPORT_SYMBOL(copy_from_user_fixup);
-EXPORT_SYMBOL(copy_in_user_fixup);
-
-/* Various address conversion macros use this. */
-EXPORT_SYMBOL(sparc64_valid_addr_bitmap);
-
 /* No version information on this, heavily used in inline asm,
  * and will always be 'void __ret_efault(void)'.
  */
 EXPORT_SYMBOL(__ret_efault);
 
-/* for input/keybdev */
-EXPORT_SYMBOL(sun_do_break);
-EXPORT_SYMBOL(stop_a_enabled);
-
-#ifdef CONFIG_DEBUG_BUGVERBOSE
-EXPORT_SYMBOL(do_BUG);
-#endif
-
-/* for ns8703 */
-EXPORT_SYMBOL(ns87303_lock);
-
-EXPORT_SYMBOL(tick_ops);
-
+/* from helpers.S */
 EXPORT_SYMBOL_GPL(real_hard_smp_processor_id);
diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index 39749e3..deb0bbb 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -354,6 +354,7 @@ unsigned long get_fb_unmapped_area(struct file *filp, unsigned long orig_addr, u
 
 	return addr;
 }
+EXPORT_SYMBOL(get_fb_unmapped_area);
 
 /* Essentially the same as PowerPC... */
 void arch_pick_mmap_layout(struct mm_struct *mm)
diff --git a/arch/sparc/kernel/time_64.c b/arch/sparc/kernel/time_64.c
index 9df8f09..0d1c011 100644
--- a/arch/sparc/kernel/time_64.c
+++ b/arch/sparc/kernel/time_64.c
@@ -176,6 +176,7 @@ static struct sparc64_tick_ops tick_operations __read_mostly = {
 };
 
 struct sparc64_tick_ops *tick_ops __read_mostly = &tick_operations;
+EXPORT_SYMBOL(tick_ops);
 
 static void stick_disable_irq(void)
 {
@@ -639,6 +640,7 @@ unsigned long sparc64_get_clock_tick(unsigned int cpu)
 		return ft->clock_tick_ref;
 	return cpu_data(cpu).clock_tick;
 }
+EXPORT_SYMBOL(sparc64_get_clock_tick);
 
 #ifdef CONFIG_CPU_FREQ
 
diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index 4638af2..b1bc97e 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -128,6 +128,7 @@ void do_BUG(const char *file, int line)
 	bust_spinlocks(1);
 	printk("kernel BUG at %s:%d!\n", file, line);
 }
+EXPORT_SYMBOL(do_BUG);
 #endif
 
 static DEFINE_SPINLOCK(dimm_handler_lock);
@@ -2261,6 +2262,7 @@ void die_if_kernel(char *str, struct pt_regs *regs)
 		do_exit(SIGKILL);
 	do_exit(SIGSEGV);
 }
+EXPORT_SYMBOL(die_if_kernel);
 
 #define VIS_OPCODE_MASK	((0x3 << 30) | (0x3f << 19))
 #define VIS_OPCODE_VAL	((0x2 << 30) | (0x36 << 19))
diff --git a/arch/sparc/lib/PeeCeeI.c b/arch/sparc/lib/PeeCeeI.c
index 46053e6..a81ce32 100644
--- a/arch/sparc/lib/PeeCeeI.c
+++ b/arch/sparc/lib/PeeCeeI.c
@@ -15,6 +15,7 @@ void outsb(unsigned long __addr, const void *src, unsigned long count)
 	while (count--)
 		outb(*p++, addr);
 }
+EXPORT_SYMBOL(outsb);
 
 void outsw(unsigned long __addr, const void *src, unsigned long count)
 {
@@ -25,6 +26,7 @@ void outsw(unsigned long __addr, const void *src, unsigned long count)
 		src += sizeof(u16);
 	}
 }
+EXPORT_SYMBOL(outsw);
 
 void outsl(unsigned long __addr, const void *src, unsigned long count)
 {
@@ -78,6 +80,7 @@ void outsl(unsigned long __addr, const void *src, unsigned long count)
 		break;
 	}
 }
+EXPORT_SYMBOL(outsl);
 
 void insb(unsigned long __addr, void *dst, unsigned long count)
 {
@@ -105,6 +108,7 @@ void insb(unsigned long __addr, void *dst, unsigned long count)
 			*pb++ = inb(addr);
 	}
 }
+EXPORT_SYMBOL(insb);
 
 void insw(unsigned long __addr, void *dst, unsigned long count)
 {
@@ -132,6 +136,7 @@ void insw(unsigned long __addr, void *dst, unsigned long count)
 			*ps = le16_to_cpu(inw(addr));
 	}
 }
+EXPORT_SYMBOL(insw);
 
 void insl(unsigned long __addr, void *dst, unsigned long count)
 {
@@ -200,4 +205,4 @@ void insl(unsigned long __addr, void *dst, unsigned long count)
 		}
 	}
 }
-
+EXPORT_SYMBOL(insl);
diff --git a/arch/sparc/lib/user_fixup.c b/arch/sparc/lib/user_fixup.c
index 05a361b..bddd78b 100644
--- a/arch/sparc/lib/user_fixup.c
+++ b/arch/sparc/lib/user_fixup.c
@@ -40,6 +40,7 @@ unsigned long copy_from_user_fixup(void *to, const void __user *from, unsigned l
 
 	return size;
 }
+EXPORT_SYMBOL(copy_from_user_fixup);
 
 unsigned long copy_to_user_fixup(void __user *to, const void *from, unsigned long size)
 {
@@ -47,6 +48,7 @@ unsigned long copy_to_user_fixup(void __user *to, const void *from, unsigned lon
 
 	return compute_size((unsigned long) to, size, &offset);
 }
+EXPORT_SYMBOL(copy_to_user_fixup);
 
 unsigned long copy_in_user_fixup(void __user *to, void __user *from, unsigned long size)
 {
@@ -64,3 +66,4 @@ unsigned long copy_in_user_fixup(void __user *to, void __user *from, unsigned lo
 
 	return size;
 }
+EXPORT_SYMBOL(copy_in_user_fixup);
diff --git a/arch/sparc/mm/generic_64.c b/arch/sparc/mm/generic_64.c
index f362c20..04f2bf4 100644
--- a/arch/sparc/mm/generic_64.c
+++ b/arch/sparc/mm/generic_64.c
@@ -161,3 +161,4 @@ int io_remap_pfn_range(struct vm_area_struct *vma, unsigned long from,
 	flush_tlb_range(vma, beg, end);
 	return error;
 }
+EXPORT_SYMBOL(io_remap_pfn_range);
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 6ea73da..c04b111 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -146,6 +146,7 @@ static void __init read_obp_memory(const char *property,
 }
 
 unsigned long *sparc64_valid_addr_bitmap __read_mostly;
+EXPORT_SYMBOL(sparc64_valid_addr_bitmap);
 
 /* Kernel physical address base and size in bytes.  */
 unsigned long kern_base __read_mostly;
@@ -359,6 +360,7 @@ void flush_dcache_page(struct page *page)
 out:
 	put_cpu();
 }
+EXPORT_SYMBOL(flush_dcache_page);
 
 void __kprobes flush_icache_range(unsigned long start, unsigned long end)
 {
@@ -386,6 +388,7 @@ void __kprobes flush_icache_range(unsigned long start, unsigned long end)
 		}
 	}
 }
+EXPORT_SYMBOL(flush_icache_range);
 
 void mmu_info(struct seq_file *m)
 {
@@ -589,6 +592,7 @@ void __flush_dcache_range(unsigned long start, unsigned long end)
 					       "i" (ASI_DCACHE_INVALIDATE));
 	}
 }
+EXPORT_SYMBOL(__flush_dcache_range);
 
 /* get_new_mmu_context() uses "cache + 1".  */
 DEFINE_SPINLOCK(ctx_alloc_lock);
-- 
1.6.0.2.GIT

