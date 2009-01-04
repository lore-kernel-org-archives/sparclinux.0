From: Julian Calaby <julian.calaby@gmail.com>
Date: Sun, 04 Jan 2009 02:43:42 +0000
Subject: [PATCH] sparc: Merge sparc_ksyms_{32,64}.c
Message-Id: <4960225E.1000801@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

sparc: Merge sparc_ksyms_{32,64}.c

Signed-off-by: Julian Calaby <julian.calaby@gmail.com>

---

Sorry about the formatting of this patch, I can't seem to convince git 
to recognise that sparc_ksyms.c is modified from sparc_ksyms_64.c

Sigh.

Furthermore, this is a rather mechanical patch that produces a huge set 
of ifdefs - I've shuffled some of the code to reduce these, but..... - 
so I'm not going to be surprised if you ask me to re-do it.

Oh, and this also changes the order of the declarations in both SPARC32 
and SPARC64, but it shouldn't be an issue.

Anyway, this has been built on SPARC64 and an equivalent patch has been 
boot tested on SPARC64.

Thanks,

Julian Calaby

  arch/sparc/kernel/Makefile         |    2 +-
  arch/sparc/kernel/sparc_ksyms.c    |  470 
++++++++++++++++++++++++++++++++++++
  arch/sparc/kernel/sparc_ksyms_32.c |  253 -------------------
  arch/sparc/kernel/sparc_ksyms_64.c |  284 ----------------------
  4 files changed, 471 insertions(+), 538 deletions(-)
  create mode 100644 arch/sparc/kernel/sparc_ksyms.c
  delete mode 100644 arch/sparc/kernel/sparc_ksyms_32.c
  delete mode 100644 arch/sparc/kernel/sparc_ksyms_64.c

diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index 53adcaa..ebb1dbb 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -69,7 +69,7 @@ obj-y                     += auxio_$(BITS).o
  obj-$(CONFIG_SUN_PM)      += apc.o pmc.o

  obj-$(CONFIG_MODULES)     += module.o
-obj-$(CONFIG_MODULES)     += sparc_ksyms_$(BITS).o
+obj-$(CONFIG_MODULES)     += sparc_ksyms.o
  obj-$(CONFIG_SPARC_LED)   += led.o
  obj-$(CONFIG_KGDB)        += kgdb_$(BITS).o

diff --git a/arch/sparc/kernel/sparc_ksyms.c 
b/arch/sparc/kernel/sparc_ksyms.c
new file mode 100644
index 0000000..eb37b79
--- /dev/null
+++ b/arch/sparc/kernel/sparc_ksyms.c
@@ -0,0 +1,470 @@
+/* arch/sparc/kernel/sparc_ksyms.c: Sparc specific ksyms support.
+ *
+ * Copyright (C) 1996, 2007 David S. Miller (davem@davemloft.net)
+ * Copyright (C) 1996 Eddie C. Dost (ecd@skynet.be)
+ * Copyright (C) 1999 Jakub Jelinek (jj@ultra.linux.cz)
+ */
+
+/* Tell string.h we don't want memcpy etc. as cpp defines */
+#define EXPORT_SYMTAB_STROPS
+#define PROMLIB_INTERNAL
+
+#include <linux/module.h>
+#ifdef CONFIG_SPARC32
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/spinlock.h>
+#endif
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/sched.h>
+#include <linux/in6.h>
+#include <linux/interrupt.h>
+#include <linux/fs_struct.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/socket.h>
+#include <linux/syscalls.h>
+#if defined(CONFIG_PCI) || defined(CONFIG_SPARC64)
+#include <linux/pci.h>
+#endif
+#include <linux/percpu.h>
+#include <linux/init.h>
+#include <linux/rwsem.h>
+#include <net/compat.h>
+#ifdef CONFIG_SPARC32
+#include <linux/pm.h>
+#ifdef CONFIG_HIGHMEM
+#include <linux/highmem.h>
+#endif
+#endif
+
+#include <asm/oplib.h>
+#ifdef CONFIG_SPARC32
+#include <asm/delay.h>
+#endif
+#include <asm/system.h>
+#include <asm/auxio.h>
+#include <asm/pgtable.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/idprom.h>
+#include <asm/elf.h>
+#include <asm/head.h>
+#include <asm/smp.h>
+#include <asm/ptrace.h>
+#include <asm/uaccess.h>
+#include <asm/checksum.h>
+#include <asm/fpumacro.h>
+#include <asm/pgalloc.h>
+#include <asm/cacheflush.h>
+#ifdef CONFIG_SBUS
+#include <asm/dma.h>
+#endif
+#include <asm/ns87303.h>
+#include <asm/timer.h>
+#include <asm/cpudata.h>
+#include <asm/ftrace.h>
+#include <asm/hypervisor.h>
+#ifdef CONFIG_SPARC32
+#include <asm/io-unit.h>
+#include <asm/bug.h>
+
+extern spinlock_t rtc_lock;
+#endif
+
+struct poll {
+	int fd;
+	short events;
+	short revents;
+};
+
+#ifdef CONFIG_SPARC64
+extern void die_if_kernel(char *str, struct pt_regs *regs);
+extern pid_t kernel_thread(int (*fn)(void *), void * arg, unsigned long 
flags);
+#else
+extern void (*__copy_1page)(void *, const void *);
+extern void __memmove(void *, const void *, __kernel_size_t);
+extern void (*bzero_1page)(void *);
+#endif /* CONFIG_SPARC64 */
+extern void *__bzero(void *, size_t);
+extern void *__memscan_zero(void *, size_t);
+extern void *__memscan_generic(void *, int, size_t);
+#ifdef CONFIG_SPARC64
+extern __kernel_size_t strlen(const char *);
+extern void sys_sigsuspend(void);
+extern int compat_sys_ioctl(unsigned int fd, unsigned int cmd, u32 arg);
+extern int (*handle_mathemu)(struct pt_regs *, struct fpustate *);
+extern long sparc32_open(const char __user * filename, int flags, int 
mode);
+extern int io_remap_pfn_range(struct vm_area_struct *vma, unsigned long 
from,
+	unsigned long pfn, unsigned long size, pgprot_t prot);
+#else
+extern int __strncmp(const char *, const char *, __kernel_size_t);
+#endif /* CONFIG_SPARC64 */
+
+extern int __ashrdi3(int, int);
+
+#ifdef CONFIG_SPARC64
+extern int dump_fpu (struct pt_regs * regs, elf_fpregset_t * fpregs);
+
+extern void xor_vis_2(unsigned long, unsigned long *, unsigned long *);
+extern void xor_vis_3(unsigned long, unsigned long *, unsigned long *,
+		      unsigned long *);
+extern void xor_vis_4(unsigned long, unsigned long *, unsigned long *,
+		      unsigned long *, unsigned long *);
+extern void xor_vis_5(unsigned long, unsigned long *, unsigned long *,
+		      unsigned long *, unsigned long *, unsigned long *);
+
+extern void xor_niagara_2(unsigned long, unsigned long *, unsigned long *);
+extern void xor_niagara_3(unsigned long, unsigned long *, unsigned long *,
+			  unsigned long *);
+extern void xor_niagara_4(unsigned long, unsigned long *, unsigned long *,
+			  unsigned long *, unsigned long *);
+extern void xor_niagara_5(unsigned long, unsigned long *, unsigned long *,
+			  unsigned long *, unsigned long *, unsigned long *);
+
+/* Per-CPU information table */
+EXPORT_PER_CPU_SYMBOL(__cpu_data);
+
+/* used by various drivers */
+#ifdef CONFIG_SMP
+/* Out of line rw-locking implementation. */
+EXPORT_SYMBOL(__read_lock);
+EXPORT_SYMBOL(__read_unlock);
+EXPORT_SYMBOL(__write_lock);
+EXPORT_SYMBOL(__write_unlock);
+EXPORT_SYMBOL(__write_trylock);
+#endif /* CONFIG_SMP */
+
+#ifdef CONFIG_MCOUNT
+EXPORT_SYMBOL(_mcount);
+#endif /* CONFIG_MCOUNT */
+
+EXPORT_SYMBOL(sparc64_get_clock_tick);
+
+/* RW semaphores */
+EXPORT_SYMBOL(__down_read);
+EXPORT_SYMBOL(__down_read_trylock);
+EXPORT_SYMBOL(__down_write);
+EXPORT_SYMBOL(__down_write_trylock);
+EXPORT_SYMBOL(__up_read);
+EXPORT_SYMBOL(__up_write);
+EXPORT_SYMBOL(__downgrade_write);
+
+/* Atomic counter implementation. */
+EXPORT_SYMBOL(atomic_add);
+EXPORT_SYMBOL(atomic_add_ret);
+EXPORT_SYMBOL(atomic_sub);
+EXPORT_SYMBOL(atomic_sub_ret);
+EXPORT_SYMBOL(atomic64_add);
+EXPORT_SYMBOL(atomic64_add_ret);
+EXPORT_SYMBOL(atomic64_sub);
+EXPORT_SYMBOL(atomic64_sub_ret);
+
+/* Atomic bit operations. */
+EXPORT_SYMBOL(test_and_set_bit);
+EXPORT_SYMBOL(test_and_clear_bit);
+EXPORT_SYMBOL(test_and_change_bit);
+EXPORT_SYMBOL(set_bit);
+EXPORT_SYMBOL(clear_bit);
+EXPORT_SYMBOL(change_bit);
+
+EXPORT_SYMBOL(__flushw_user);
+
+EXPORT_SYMBOL(tlb_type);
+EXPORT_SYMBOL(sun4v_chip_type);
+EXPORT_SYMBOL(get_fb_unmapped_area);
+EXPORT_SYMBOL(flush_icache_range);
+
+EXPORT_SYMBOL(flush_dcache_page);
+#ifdef DCACHE_ALIASING_POSSIBLE
+EXPORT_SYMBOL(__flush_dcache_range);
+#endif /* DCACHE_ALIASING_POSSIBLE */
+
+EXPORT_SYMBOL(sun4v_niagara_getperf);
+EXPORT_SYMBOL(sun4v_niagara_setperf);
+EXPORT_SYMBOL(sun4v_niagara2_getperf);
+EXPORT_SYMBOL(sun4v_niagara2_setperf);
+
+EXPORT_SYMBOL(auxio_set_led);
+EXPORT_SYMBOL(auxio_set_lte);
+#else
+extern int __ashldi3(int, int);
+extern int __lshrdi3(int, int);
+extern int __muldi3(int, int);
+extern int __divdi3(int, int);
+
+/* Private functions with odd calling conventions. */
+extern void ___atomic24_add(void);
+extern void ___atomic24_sub(void);
+extern void ___rw_read_enter(void);
+extern void ___rw_read_try(void);
+extern void ___rw_read_exit(void);
+extern void ___rw_write_enter(void);
+
+/* Alias functions whose names begin with "." and export the aliases.
+ * The module references will be fixed up by module_frob_arch_sections.
+ */
+extern int _Div(int, int);
+extern int _Mul(int, int);
+extern int _Rem(int, int);
+extern unsigned _Udiv(unsigned, unsigned);
+extern unsigned _Umul(unsigned, unsigned);
+extern unsigned _Urem(unsigned, unsigned);
+
+/* used by various drivers */
+EXPORT_SYMBOL(sparc_cpu_model);
+EXPORT_SYMBOL(kernel_thread);
+#ifdef CONFIG_SMP
+// XXX find what uses (or used) these.   AV: see asm/spinlock.h
+EXPORT_SYMBOL(___rw_read_enter);
+EXPORT_SYMBOL(___rw_read_try);
+EXPORT_SYMBOL(___rw_read_exit);
+EXPORT_SYMBOL(___rw_write_enter);
+#endif /* CONFIG_SMP */
+
+EXPORT_SYMBOL(sparc_valid_addr_bitmap);
+EXPORT_SYMBOL(phys_base);
+EXPORT_SYMBOL(pfn_base);
+
+/* Atomic operations. */
+EXPORT_SYMBOL(___atomic24_add);
+EXPORT_SYMBOL(___atomic24_sub);
+
+/* Per-CPU information table */
+EXPORT_PER_CPU_SYMBOL(__cpu_data);
+
+#ifdef CONFIG_SMP
+/* IRQ implementation. */
+EXPORT_SYMBOL(synchronize_irq);
+#endif
+
+EXPORT_SYMBOL(__udelay);
+EXPORT_SYMBOL(__ndelay);
+EXPORT_SYMBOL(rtc_lock);
+EXPORT_SYMBOL(set_auxio);
+EXPORT_SYMBOL(get_auxio);
+EXPORT_SYMBOL(io_remap_pfn_range);
+
+#ifndef CONFIG_SMP
+EXPORT_SYMBOL(BTFIXUP_CALL(___xchg32));
+#else
+EXPORT_SYMBOL(BTFIXUP_CALL(__hard_smp_processor_id));
+#endif
+EXPORT_SYMBOL(BTFIXUP_CALL(mmu_unlockarea));
+EXPORT_SYMBOL(BTFIXUP_CALL(mmu_lockarea));
+EXPORT_SYMBOL(BTFIXUP_CALL(mmu_get_scsi_sgl));
+EXPORT_SYMBOL(BTFIXUP_CALL(mmu_get_scsi_one));
+EXPORT_SYMBOL(BTFIXUP_CALL(mmu_release_scsi_sgl));
+EXPORT_SYMBOL(BTFIXUP_CALL(mmu_release_scsi_one));
+
+EXPORT_SYMBOL(BTFIXUP_CALL(pgprot_noncached));
+#endif /* CONFIG_SPARC64 */
+
+#ifdef CONFIG_SBUS
+EXPORT_SYMBOL(sbus_set_sbus64);
+#endif
+EXPORT_SYMBOL(insb);
+EXPORT_SYMBOL(outsb);
+EXPORT_SYMBOL(insw);
+EXPORT_SYMBOL(outsw);
+EXPORT_SYMBOL(insl);
+EXPORT_SYMBOL(outsl);
+#ifdef CONFIG_PCI
+EXPORT_SYMBOL(pci_alloc_consistent);
+EXPORT_SYMBOL(pci_free_consistent);
+EXPORT_SYMBOL(pci_map_single);
+EXPORT_SYMBOL(pci_unmap_single);
+EXPORT_SYMBOL(pci_map_sg);
+EXPORT_SYMBOL(pci_unmap_sg);
+EXPORT_SYMBOL(pci_dma_sync_single_for_cpu);
+EXPORT_SYMBOL(pci_dma_sync_sg_for_cpu);
+#ifdef CONFIG_SPARC64
+EXPORT_SYMBOL(pci_dma_supported);
+#else
+EXPORT_SYMBOL(pci_dma_sync_single_for_device);
+EXPORT_SYMBOL(pci_dma_sync_sg_for_device);
+EXPORT_SYMBOL(pci_map_page);
+EXPORT_SYMBOL(pci_unmap_page);
+/* Actually, ioremap/iounmap are not PCI specific. But it is ok for 
drivers. */
+EXPORT_SYMBOL(ioremap);
+EXPORT_SYMBOL(iounmap);
+#endif /* CONFIG_SPARC64 */
+#endif /* CONFIG_PCI */
+
+/* in arch/sparc/mm/highmem.c */
+#if defined(CONFIG_HIGHMEM) && defined(CONFIG_SPARC32)
+EXPORT_SYMBOL(kmap_atomic);
+EXPORT_SYMBOL(kunmap_atomic);
+#endif
+
+#ifdef CONFIG_SPARC64
+/* I/O device mmaping on Sparc64. */
+EXPORT_SYMBOL(io_remap_pfn_range);
+
+EXPORT_SYMBOL(dump_fpu);
+
+/* math-emu wants this */
+EXPORT_SYMBOL(die_if_kernel);
+
+/* Kernel thread creation. */
+EXPORT_SYMBOL(kernel_thread);
+#endif /* CONFIG_SPARC64 */
+
+/* prom symbols */
+EXPORT_SYMBOL(idprom);
+EXPORT_SYMBOL(prom_root_node);
+EXPORT_SYMBOL(prom_getchild);
+EXPORT_SYMBOL(prom_getsibling);
+EXPORT_SYMBOL(prom_searchsiblings);
+EXPORT_SYMBOL(prom_firstprop);
+EXPORT_SYMBOL(prom_nextprop);
+EXPORT_SYMBOL(prom_getproplen);
+EXPORT_SYMBOL(prom_getproperty);
+EXPORT_SYMBOL(prom_node_has_property);
+EXPORT_SYMBOL(prom_setprop);
+EXPORT_SYMBOL(saved_command_line);
+EXPORT_SYMBOL(prom_finddevice);
+EXPORT_SYMBOL(prom_feval);
+EXPORT_SYMBOL(prom_getbool);
+EXPORT_SYMBOL(prom_getstring);
+EXPORT_SYMBOL(prom_getint);
+EXPORT_SYMBOL(prom_getintdefault);
+EXPORT_SYMBOL(__prom_getchild);
+EXPORT_SYMBOL(__prom_getsibling);
+
+#ifdef CONFIG_SPARC32
+EXPORT_SYMBOL(prom_apply_obio_ranges);
+EXPORT_SYMBOL(romvec);
+#endif /* CONFIG_SPARC43 */
+
+/* sparc library symbols */
+EXPORT_SYMBOL(strlen);
+#ifdef CONFIG_SPARC64
+EXPORT_SYMBOL(__strlen_user);
+EXPORT_SYMBOL(__strnlen_user);
+#else
+EXPORT_SYMBOL(memscan);
+EXPORT_SYMBOL(strncmp);
+EXPORT_SYMBOL(page_kernel);
+#endif
+
+/* Special internal versions of library functions. */
+#ifdef CONFIG_SPARC64
+EXPORT_SYMBOL(_clear_page);
+EXPORT_SYMBOL(clear_user_page);
+EXPORT_SYMBOL(copy_user_page);
+#else
+EXPORT_SYMBOL(__copy_1page);
+EXPORT_SYMBOL(__memcpy);
+EXPORT_SYMBOL(bzero_1page);
+EXPORT_SYMBOL(__strncmp);
+EXPORT_SYMBOL(__memmove);
+#endif /* CONFIG_SPARC64 */
+EXPORT_SYMBOL(__bzero);
+EXPORT_SYMBOL(__memscan_zero);
+EXPORT_SYMBOL(__memscan_generic);
+EXPORT_SYMBOL(__memset);
+
+#ifdef CONFIG_SPARC64
+EXPORT_SYMBOL(csum_partial);
+EXPORT_SYMBOL(csum_partial_copy_nocheck);
+EXPORT_SYMBOL(__csum_partial_copy_from_user);
+EXPORT_SYMBOL(__csum_partial_copy_to_user);
+EXPORT_SYMBOL(ip_fast_csum);
+#endif /* CONFIG_SPARC64 */
+
+/* Moving data to/from userspace. */
+#ifdef CONFIG_SPARC64
+EXPORT_SYMBOL(___copy_to_user);
+EXPORT_SYMBOL(___copy_from_user);
+EXPORT_SYMBOL(___copy_in_user);
+EXPORT_SYMBOL(copy_to_user_fixup);
+EXPORT_SYMBOL(copy_from_user_fixup);
+EXPORT_SYMBOL(copy_in_user_fixup);
+EXPORT_SYMBOL(__clear_user);
+#else
+EXPORT_SYMBOL(__copy_user);
+EXPORT_SYMBOL(__strnlen_user);
+#endif
+EXPORT_SYMBOL(__strncpy_from_user);
+
+#ifdef CONFIG_SPARC32
+/* Networking helper routines. */
+EXPORT_SYMBOL(__csum_partial_copy_sparc_generic);
+EXPORT_SYMBOL(csum_partial);
+#endif
+
+#ifdef CONFIG_SPARC64
+/* Various address conversion macros use this. */
+EXPORT_SYMBOL(sparc64_valid_addr_bitmap);
+#else
+/* Cache flushing.  */
+EXPORT_SYMBOL(sparc_flush_page_to_ram);
+
+/* For when serial stuff is built as modules. */
+EXPORT_SYMBOL(sun_do_break);
+#endif /* CONFIG_SPARC32 */
+
+/* No version information on this, heavily used in inline asm,
+ * and will always be 'void __ret_efault(void)'.
+ */
+EXPORT_SYMBOL(__ret_efault);
+
+/* No version information on these, as gcc produces such symbols. */
+EXPORT_SYMBOL(memcmp);
+EXPORT_SYMBOL(memcpy);
+EXPORT_SYMBOL(memset);
+EXPORT_SYMBOL(memmove);
+#ifdef CONFIG_SPARC64
+EXPORT_SYMBOL(strncmp);
+
+void VISenter(void);
+/* RAID code needs this */
+EXPORT_SYMBOL(VISenter);
+
+/* for input/keybdev */
+EXPORT_SYMBOL(sun_do_break);
+EXPORT_SYMBOL(stop_a_enabled);
+#else
+EXPORT_SYMBOL(__ashrdi3);
+EXPORT_SYMBOL(__ashldi3);
+EXPORT_SYMBOL(__lshrdi3);
+EXPORT_SYMBOL(__muldi3);
+EXPORT_SYMBOL(__divdi3);
+
+EXPORT_SYMBOL(_Rem);
+EXPORT_SYMBOL(_Urem);
+EXPORT_SYMBOL(_Mul);
+EXPORT_SYMBOL(_Umul);
+EXPORT_SYMBOL(_Div);
+EXPORT_SYMBOL(_Udiv);
+#endif /* CONFIG_SPARC64 */
+
+#ifdef CONFIG_DEBUG_BUGVERBOSE
+EXPORT_SYMBOL(do_BUG);
+#endif
+
+#ifdef CONFIG_SPARC64
+/* for ns8703 */
+EXPORT_SYMBOL(ns87303_lock);
+
+EXPORT_SYMBOL(tick_ops);
+
+EXPORT_SYMBOL(xor_vis_2);
+EXPORT_SYMBOL(xor_vis_3);
+EXPORT_SYMBOL(xor_vis_4);
+EXPORT_SYMBOL(xor_vis_5);
+
+EXPORT_SYMBOL(xor_niagara_2);
+EXPORT_SYMBOL(xor_niagara_3);
+EXPORT_SYMBOL(xor_niagara_4);
+EXPORT_SYMBOL(xor_niagara_5);
+
+EXPORT_SYMBOL_GPL(real_hard_smp_processor_id);
+#else
+/* Sun Power Management Idle Handler */
+EXPORT_SYMBOL(pm_idle);
+
+EXPORT_SYMBOL(empty_zero_page);
+#endif /* CONFIG_SPARC64 */
diff --git a/arch/sparc/kernel/sparc_ksyms_32.c 
b/arch/sparc/kernel/sparc_ksyms_32.c
deleted file mode 100644
index e1e9763..0000000
--- a/arch/sparc/kernel/sparc_ksyms_32.c
+++ /dev/null
@@ -1,253 +0,0 @@
-/*
- * arch/sparc/kernel/ksyms.c: Sparc specific ksyms support.
- *
- * Copyright (C) 1996 David S. Miller (davem@caip.rutgers.edu)
- * Copyright (C) 1996 Eddie C. Dost (ecd@skynet.be)
- */
-
-/* Tell string.h we don't want memcpy etc. as cpp defines */
-#define EXPORT_SYMTAB_STROPS
-#define PROMLIB_INTERNAL
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/smp.h>
-#include <linux/types.h>
-#include <linux/string.h>
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
-
-#include <asm/oplib.h>
-#include <asm/delay.h>
-#include <asm/system.h>
-#include <asm/auxio.h>
-#include <asm/pgtable.h>
-#include <asm/io.h>
-#include <asm/irq.h>
-#include <asm/idprom.h>
-#include <asm/head.h>
-#include <asm/smp.h>
-#include <asm/ptrace.h>
-#include <asm/uaccess.h>
-#include <asm/checksum.h>
-#ifdef CONFIG_SBUS
-#include <asm/dma.h>
-#endif
-#include <asm/io-unit.h>
-#include <asm/bug.h>
-
-extern spinlock_t rtc_lock;
-
-struct poll {
-	int fd;
-	short events;
-	short revents;
-};
-
-extern void (*__copy_1page)(void *, const void *);
-extern void __memmove(void *, const void *, __kernel_size_t);
-extern void (*bzero_1page)(void *);
-extern void *__bzero(void *, size_t);
-extern void *__memscan_zero(void *, size_t);
-extern void *__memscan_generic(void *, int, size_t);
-extern int __strncmp(const char *, const char *, __kernel_size_t);
-
-extern int __ashrdi3(int, int);
-extern int __ashldi3(int, int);
-extern int __lshrdi3(int, int);
-extern int __muldi3(int, int);
-extern int __divdi3(int, int);
-
-/* Private functions with odd calling conventions. */
-extern void ___atomic24_add(void);
-extern void ___atomic24_sub(void);
-extern void ___rw_read_enter(void);
-extern void ___rw_read_try(void);
-extern void ___rw_read_exit(void);
-extern void ___rw_write_enter(void);
-
-/* Alias functions whose names begin with "." and export the aliases.
- * The module references will be fixed up by module_frob_arch_sections.
- */
-extern int _Div(int, int);
-extern int _Mul(int, int);
-extern int _Rem(int, int);
-extern unsigned _Udiv(unsigned, unsigned);
-extern unsigned _Umul(unsigned, unsigned);
-extern unsigned _Urem(unsigned, unsigned);
-
-/* used by various drivers */
-EXPORT_SYMBOL(sparc_cpu_model);
-EXPORT_SYMBOL(kernel_thread);
-#ifdef CONFIG_SMP
-// XXX find what uses (or used) these.   AV: see asm/spinlock.h
-EXPORT_SYMBOL(___rw_read_enter);
-EXPORT_SYMBOL(___rw_read_try);
-EXPORT_SYMBOL(___rw_read_exit);
-EXPORT_SYMBOL(___rw_write_enter);
-#endif
-
-EXPORT_SYMBOL(sparc_valid_addr_bitmap);
-EXPORT_SYMBOL(phys_base);
-EXPORT_SYMBOL(pfn_base);
-
-/* Atomic operations. */
-EXPORT_SYMBOL(___atomic24_add);
-EXPORT_SYMBOL(___atomic24_sub);
-
-/* Per-CPU information table */
-EXPORT_PER_CPU_SYMBOL(__cpu_data);
-
-#ifdef CONFIG_SMP
-/* IRQ implementation. */
-EXPORT_SYMBOL(synchronize_irq);
-#endif
-
-EXPORT_SYMBOL(__udelay);
-EXPORT_SYMBOL(__ndelay);
-EXPORT_SYMBOL(rtc_lock);
-EXPORT_SYMBOL(set_auxio);
-EXPORT_SYMBOL(get_auxio);
-EXPORT_SYMBOL(io_remap_pfn_range);
-
-#ifndef CONFIG_SMP
-EXPORT_SYMBOL(BTFIXUP_CALL(___xchg32));
-#else
-EXPORT_SYMBOL(BTFIXUP_CALL(__hard_smp_processor_id));
-#endif
-EXPORT_SYMBOL(BTFIXUP_CALL(mmu_unlockarea));
-EXPORT_SYMBOL(BTFIXUP_CALL(mmu_lockarea));
-EXPORT_SYMBOL(BTFIXUP_CALL(mmu_get_scsi_sgl));
-EXPORT_SYMBOL(BTFIXUP_CALL(mmu_get_scsi_one));
-EXPORT_SYMBOL(BTFIXUP_CALL(mmu_release_scsi_sgl));
-EXPORT_SYMBOL(BTFIXUP_CALL(mmu_release_scsi_one));
-
-EXPORT_SYMBOL(BTFIXUP_CALL(pgprot_noncached));
-
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
-EXPORT_SYMBOL(saved_command_line);
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
-EXPORT_SYMBOL(memscan);
-EXPORT_SYMBOL(strlen);
-EXPORT_SYMBOL(strncmp);
-EXPORT_SYMBOL(page_kernel);
-
-/* Special internal versions of library functions. */
-EXPORT_SYMBOL(__copy_1page);
-EXPORT_SYMBOL(__memcpy);
-EXPORT_SYMBOL(__memset);
-EXPORT_SYMBOL(bzero_1page);
-EXPORT_SYMBOL(__bzero);
-EXPORT_SYMBOL(__memscan_zero);
-EXPORT_SYMBOL(__memscan_generic);
-EXPORT_SYMBOL(__strncmp);
-EXPORT_SYMBOL(__memmove);
-
-/* Moving data to/from userspace. */
-EXPORT_SYMBOL(__copy_user);
-EXPORT_SYMBOL(__strncpy_from_user);
-EXPORT_SYMBOL(__strnlen_user);
-
-/* Networking helper routines. */
-EXPORT_SYMBOL(__csum_partial_copy_sparc_generic);
-EXPORT_SYMBOL(csum_partial);
-
-/* Cache flushing.  */
-EXPORT_SYMBOL(sparc_flush_page_to_ram);
-
-/* For when serial stuff is built as modules. */
-EXPORT_SYMBOL(sun_do_break);
-
-EXPORT_SYMBOL(__ret_efault);
-
-EXPORT_SYMBOL(memcmp);
-EXPORT_SYMBOL(memcpy);
-EXPORT_SYMBOL(memset);
-EXPORT_SYMBOL(memmove);
-EXPORT_SYMBOL(__ashrdi3);
-EXPORT_SYMBOL(__ashldi3);
-EXPORT_SYMBOL(__lshrdi3);
-EXPORT_SYMBOL(__muldi3);
-EXPORT_SYMBOL(__divdi3);
-
-EXPORT_SYMBOL(_Rem);
-EXPORT_SYMBOL(_Urem);
-EXPORT_SYMBOL(_Mul);
-EXPORT_SYMBOL(_Umul);
-EXPORT_SYMBOL(_Div);
-EXPORT_SYMBOL(_Udiv);
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
deleted file mode 100644
index 0133211..0000000
--- a/arch/sparc/kernel/sparc_ksyms_64.c
+++ /dev/null
@@ -1,284 +0,0 @@
-/* arch/sparc64/kernel/sparc64_ksyms.c: Sparc64 specific ksyms support.
- *
- * Copyright (C) 1996, 2007 David S. Miller (davem@davemloft.net)
- * Copyright (C) 1996 Eddie C. Dost (ecd@skynet.be)
- * Copyright (C) 1999 Jakub Jelinek (jj@ultra.linux.cz)
- */
-
-/* Tell string.h we don't want memcpy etc. as cpp defines */
-#define EXPORT_SYMTAB_STROPS
-#define PROMLIB_INTERNAL
-
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/string.h>
-#include <linux/sched.h>
-#include <linux/in6.h>
-#include <linux/pci.h>
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
-
-#include <asm/oplib.h>
-#include <asm/system.h>
-#include <asm/auxio.h>
-#include <asm/pgtable.h>
-#include <asm/io.h>
-#include <asm/irq.h>
-#include <asm/idprom.h>
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
-struct poll {
-	int fd;
-	short events;
-	short revents;
-};
-
-extern void die_if_kernel(char *str, struct pt_regs *regs);
-extern pid_t kernel_thread(int (*fn)(void *), void * arg, unsigned long 
flags);
-extern void *__bzero(void *, size_t);
-extern void *__memscan_zero(void *, size_t);
-extern void *__memscan_generic(void *, int, size_t);
-extern __kernel_size_t strlen(const char *);
-extern void sys_sigsuspend(void);
-extern int compat_sys_ioctl(unsigned int fd, unsigned int cmd, u32 arg);
-extern int (*handle_mathemu)(struct pt_regs *, struct fpustate *);
-extern long sparc32_open(const char __user * filename, int flags, int 
mode);
-extern int io_remap_pfn_range(struct vm_area_struct *vma, unsigned long 
from,
-	unsigned long pfn, unsigned long size, pgprot_t prot);
-
-extern int __ashrdi3(int, int);
-
-extern int dump_fpu (struct pt_regs * regs, elf_fpregset_t * fpregs);
-
-extern void xor_vis_2(unsigned long, unsigned long *, unsigned long *);
-extern void xor_vis_3(unsigned long, unsigned long *, unsigned long *,
-		      unsigned long *);
-extern void xor_vis_4(unsigned long, unsigned long *, unsigned long *,
-		      unsigned long *, unsigned long *);
-extern void xor_vis_5(unsigned long, unsigned long *, unsigned long *,
-		      unsigned long *, unsigned long *, unsigned long *);
-
-extern void xor_niagara_2(unsigned long, unsigned long *, unsigned long *);
-extern void xor_niagara_3(unsigned long, unsigned long *, unsigned long *,
-			  unsigned long *);
-extern void xor_niagara_4(unsigned long, unsigned long *, unsigned long *,
-			  unsigned long *, unsigned long *);
-extern void xor_niagara_5(unsigned long, unsigned long *, unsigned long *,
-			  unsigned long *, unsigned long *, unsigned long *);
-
-/* Per-CPU information table */
-EXPORT_PER_CPU_SYMBOL(__cpu_data);
-
-/* used by various drivers */
-#ifdef CONFIG_SMP
-/* Out of line rw-locking implementation. */
-EXPORT_SYMBOL(__read_lock);
-EXPORT_SYMBOL(__read_unlock);
-EXPORT_SYMBOL(__write_lock);
-EXPORT_SYMBOL(__write_unlock);
-EXPORT_SYMBOL(__write_trylock);
-#endif /* CONFIG_SMP */
-
-#ifdef CONFIG_MCOUNT
-EXPORT_SYMBOL(_mcount);
-#endif
-
-EXPORT_SYMBOL(sparc64_get_clock_tick);
-
-/* RW semaphores */
-EXPORT_SYMBOL(__down_read);
-EXPORT_SYMBOL(__down_read_trylock);
-EXPORT_SYMBOL(__down_write);
-EXPORT_SYMBOL(__down_write_trylock);
-EXPORT_SYMBOL(__up_read);
-EXPORT_SYMBOL(__up_write);
-EXPORT_SYMBOL(__downgrade_write);
-
-/* Atomic counter implementation. */
-EXPORT_SYMBOL(atomic_add);
-EXPORT_SYMBOL(atomic_add_ret);
-EXPORT_SYMBOL(atomic_sub);
-EXPORT_SYMBOL(atomic_sub_ret);
-EXPORT_SYMBOL(atomic64_add);
-EXPORT_SYMBOL(atomic64_add_ret);
-EXPORT_SYMBOL(atomic64_sub);
-EXPORT_SYMBOL(atomic64_sub_ret);
-
-/* Atomic bit operations. */
-EXPORT_SYMBOL(test_and_set_bit);
-EXPORT_SYMBOL(test_and_clear_bit);
-EXPORT_SYMBOL(test_and_change_bit);
-EXPORT_SYMBOL(set_bit);
-EXPORT_SYMBOL(clear_bit);
-EXPORT_SYMBOL(change_bit);
-
-EXPORT_SYMBOL(__flushw_user);
-
-EXPORT_SYMBOL(tlb_type);
-EXPORT_SYMBOL(sun4v_chip_type);
-EXPORT_SYMBOL(get_fb_unmapped_area);
-EXPORT_SYMBOL(flush_icache_range);
-
-EXPORT_SYMBOL(flush_dcache_page);
-#ifdef DCACHE_ALIASING_POSSIBLE
-EXPORT_SYMBOL(__flush_dcache_range);
-#endif
-
-EXPORT_SYMBOL(sun4v_niagara_getperf);
-EXPORT_SYMBOL(sun4v_niagara_setperf);
-EXPORT_SYMBOL(sun4v_niagara2_getperf);
-EXPORT_SYMBOL(sun4v_niagara2_setperf);
-
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
-#ifdef CONFIG_PCI
-EXPORT_SYMBOL(pci_alloc_consistent);
-EXPORT_SYMBOL(pci_free_consistent);
-EXPORT_SYMBOL(pci_map_single);
-EXPORT_SYMBOL(pci_unmap_single);
-EXPORT_SYMBOL(pci_map_sg);
-EXPORT_SYMBOL(pci_unmap_sg);
-EXPORT_SYMBOL(pci_dma_sync_single_for_cpu);
-EXPORT_SYMBOL(pci_dma_sync_sg_for_cpu);
-EXPORT_SYMBOL(pci_dma_supported);
-#endif
-
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
-EXPORT_SYMBOL(saved_command_line);
-EXPORT_SYMBOL(prom_finddevice);
-EXPORT_SYMBOL(prom_feval);
-EXPORT_SYMBOL(prom_getbool);
-EXPORT_SYMBOL(prom_getstring);
-EXPORT_SYMBOL(prom_getint);
-EXPORT_SYMBOL(prom_getintdefault);
-EXPORT_SYMBOL(__prom_getchild);
-EXPORT_SYMBOL(__prom_getsibling);
-
-/* sparc library symbols */
-EXPORT_SYMBOL(strlen);
-EXPORT_SYMBOL(__strlen_user);
-EXPORT_SYMBOL(__strnlen_user);
-
-/* Special internal versions of library functions. */
-EXPORT_SYMBOL(_clear_page);
-EXPORT_SYMBOL(clear_user_page);
-EXPORT_SYMBOL(copy_user_page);
-EXPORT_SYMBOL(__bzero);
-EXPORT_SYMBOL(__memscan_zero);
-EXPORT_SYMBOL(__memscan_generic);
-EXPORT_SYMBOL(__memset);
-
-EXPORT_SYMBOL(csum_partial);
-EXPORT_SYMBOL(csum_partial_copy_nocheck);
-EXPORT_SYMBOL(__csum_partial_copy_from_user);
-EXPORT_SYMBOL(__csum_partial_copy_to_user);
-EXPORT_SYMBOL(ip_fast_csum);
-
-/* Moving data to/from/in userspace. */
-EXPORT_SYMBOL(___copy_to_user);
-EXPORT_SYMBOL(___copy_from_user);
-EXPORT_SYMBOL(___copy_in_user);
-EXPORT_SYMBOL(copy_to_user_fixup);
-EXPORT_SYMBOL(copy_from_user_fixup);
-EXPORT_SYMBOL(copy_in_user_fixup);
-EXPORT_SYMBOL(__strncpy_from_user);
-EXPORT_SYMBOL(__clear_user);
-
-/* Various address conversion macros use this. */
-EXPORT_SYMBOL(sparc64_valid_addr_bitmap);
-
-/* No version information on this, heavily used in inline asm,
- * and will always be 'void __ret_efault(void)'.
- */
-EXPORT_SYMBOL(__ret_efault);
-
-/* No version information on these, as gcc produces such symbols. */
-EXPORT_SYMBOL(memcmp);
-EXPORT_SYMBOL(memcpy);
-EXPORT_SYMBOL(memset);
-EXPORT_SYMBOL(memmove);
-EXPORT_SYMBOL(strncmp);
-
-void VISenter(void);
-/* RAID code needs this */
-EXPORT_SYMBOL(VISenter);
-
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
-EXPORT_SYMBOL(xor_vis_2);
-EXPORT_SYMBOL(xor_vis_3);
-EXPORT_SYMBOL(xor_vis_4);
-EXPORT_SYMBOL(xor_vis_5);
-
-EXPORT_SYMBOL(xor_niagara_2);
-EXPORT_SYMBOL(xor_niagara_3);
-EXPORT_SYMBOL(xor_niagara_4);
-EXPORT_SYMBOL(xor_niagara_5);
-
-EXPORT_SYMBOL_GPL(real_hard_smp_processor_id);
