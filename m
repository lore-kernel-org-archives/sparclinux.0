From: Julian Calaby <julian.calaby@gmail.com>
Date: Thu, 08 Jan 2009 12:30:36 +0000
Subject: [PATCH v2 3/5] sparc64: move EXPORT_SYMBOL to the symbols definition
Message-Id: <4965F1EC.6050803@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>

sparc64: move EXPORT_SYMBOL to the symbols definition

Move all applicable EXPORT_SYMBOL()s to the file where the respective
symbol is defined.

Removed all the includes that are no longer needed in sparc_ksyms_64.c

Comment all remaining EXPORT_SYMBOL()s in sparc_ksyms_64.c

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Additions by Julian Calaby:
* Moved EXPORT_SYMBOL()s for prom functions to their rightful places.
* Made some minor cleanups to the includes and comments of sparc_ksyms_64.c
* Updated and tidied commit message.
* Rebased patch over sparc-2.6.git HEAD.
* Ensured that all modified files have the correct includes.

Signed-off-by: Julian Calaby <julian.calaby@gmail.com>
---
 arch/sparc/kernel/auxio_64.c       |    2 +
 arch/sparc/kernel/pci.c            |    1 +
 arch/sparc/kernel/process_64.c     |    2 +
 arch/sparc/kernel/sbus.c           |    1 +
 arch/sparc/kernel/setup_64.c       |    3 +
 arch/sparc/kernel/sparc_ksyms_64.c |  136 +++-----------------------------=
---
 arch/sparc/kernel/sys_sparc_64.c   |    2 +
 arch/sparc/kernel/time_64.c        |    2 +
 arch/sparc/kernel/traps_64.c       |    2 +
 arch/sparc/lib/PeeCeeI.c           |    8 ++
 arch/sparc/lib/user_fixup.c        |    5 ++
 arch/sparc/mm/generic_64.c         |    1 +
 arch/sparc/mm/init_64.c            |    4 +
 arch/sparc/prom/misc_64.c          |    3 +
 arch/sparc/prom/tree_64.c          |   20 +++++-
 15 files changed, 66 insertions(+), 126 deletions(-)

diff --git a/arch/sparc/kernel/auxio_64.c b/arch/sparc/kernel/auxio_64.c
index 8b67347..9f52db2 100644
--- a/arch/sparc/kernel/auxio_64.c
+++ b/arch/sparc/kernel/auxio_64.c
@@ -72,6 +72,7 @@ void auxio_set_led(int on)
 	bit =3D (ebus ? AUXIO_PCIO_LED : AUXIO_AUX1_LED);
 	__auxio_set_bit(bit, on, ebus);
 }
+EXPORT_SYMBOL(auxio_set_led);
=20
 static void __auxio_sbus_set_lte(int on)
 {
@@ -90,6 +91,7 @@ void auxio_set_lte(int on)
 		break;
 	}
 }
+EXPORT_SYMBOL(auxio_set_lte);
=20
 static struct of_device_id __initdata auxio_match[] =3D {
 	{
diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index bdb7c0a..1f5ea94 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -1077,6 +1077,7 @@ int pci_dma_supported(struct pci_dev *pdev, u64 devic=
e_mask)
=20
 	return (device_mask & dma_addr_mask) =3D dma_addr_mask;
 }
+EXPORT_SYMBOL(pci_dma_supported);
=20
 void pci_resource_to_user(const struct pci_dev *pdev, int bar,
 			  const struct resource *rp, resource_size_t *start,
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index d5e2ace..cc8b560 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -678,6 +678,7 @@ pid_t kernel_thread(int (*fn)(void *), void * arg, unsi=
gned long flags)
 			     "g1", "g2", "g3", "o0", "o1", "memory", "cc");
 	return retval;
 }
+EXPORT_SYMBOL(kernel_thread);
=20
 typedef struct {
 	union {
@@ -743,6 +744,7 @@ int dump_fpu (struct pt_regs * regs, elf_fpregset_t * f=
pregs)
 	}
 	return 1;
 }
+EXPORT_SYMBOL(dump_fpu);
=20
 /*
  * sparc_execve() executes a new program after the asm stub has set
diff --git a/arch/sparc/kernel/sbus.c b/arch/sparc/kernel/sbus.c
index 2ead310..406e087 100644
--- a/arch/sparc/kernel/sbus.c
+++ b/arch/sparc/kernel/sbus.c
@@ -117,6 +117,7 @@ void sbus_set_sbus64(struct device *dev, int bursts)
 		val |=3D (1UL << 4UL);
 	upa_writeq(val, cfg_reg);
 }
+EXPORT_SYMBOL(sbus_set_sbus64);
=20
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
=20
 struct screen_info screen_info =3D {
 	0, 0,			/* orig-x, orig-y */
@@ -425,5 +426,7 @@ void sun_do_break(void)
=20
 	prom_cmdline();
 }
+EXPORT_SYMBOL(sun_do_break);
=20
 int stop_a_enabled =3D 1;
+EXPORT_SYMBOL(stop_a_enabled);
diff --git a/arch/sparc/kernel/sparc_ksyms_64.c b/arch/sparc/kernel/sparc_k=
syms_64.c
index 62b5a91..e92ad12 100644
--- a/arch/sparc/kernel/sparc_ksyms_64.c
+++ b/arch/sparc/kernel/sparc_ksyms_64.c
@@ -8,43 +8,15 @@
 #define PROMLIB_INTERNAL
=20
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
 #include <linux/init.h>
-#include <linux/rwsem.h>
-#include <net/compat.h>
=20
-#include <asm/oplib.h>
+#include <asm/spinlock.h>
 #include <asm/system.h>
-#include <asm/auxio.h>
-#include <asm/pgtable.h>
-#include <asm/io.h>
-#include <asm/irq.h>
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
 #include <asm/cpudata.h>
-#include <asm/ftrace.h>
+#include <asm/uaccess.h>
+#include <asm/spitfire.h>
+#include <asm/oplib.h>
 #include <asm/hypervisor.h>
=20
 struct poll {
@@ -53,19 +25,6 @@ struct poll {
 	short revents;
 };
=20
-extern void die_if_kernel(char *str, struct pt_regs *regs);
-extern pid_t kernel_thread(int (*fn)(void *), void * arg, unsigned long fl=
ags);
-extern void sys_sigsuspend(void);
-extern int compat_sys_ioctl(unsigned int fd, unsigned int cmd, u32 arg);
-extern int (*handle_mathemu)(struct pt_regs *, struct fpustate *);
-extern long sparc32_open(const char __user * filename, int flags, int mode=
);
-extern int io_remap_pfn_range(struct vm_area_struct *vma, unsigned long fr=
om,
-	unsigned long pfn, unsigned long size, pgprot_t prot);
-
-extern int __ashrdi3(int, int);
-
-extern int dump_fpu (struct pt_regs * regs, elf_fpregset_t * fpregs);
-
 /* used by various drivers */
 #ifdef CONFIG_SMP
 /* Out of line rw-locking implementation. */
@@ -76,37 +35,24 @@ EXPORT_SYMBOL(__write_unlock);
 EXPORT_SYMBOL(__write_trylock);
 #endif /* CONFIG_SMP */
=20
-EXPORT_SYMBOL(sparc64_get_clock_tick);
-
+/* from helpers.S */
 EXPORT_SYMBOL(__flushw_user);
+EXPORT_SYMBOL_GPL(real_hard_smp_processor_id);
=20
+/* from head_64.S */
+EXPORT_SYMBOL(__ret_efault);
 EXPORT_SYMBOL(tlb_type);
 EXPORT_SYMBOL(sun4v_chip_type);
-EXPORT_SYMBOL(get_fb_unmapped_area);
-EXPORT_SYMBOL(flush_icache_range);
-
-EXPORT_SYMBOL(flush_dcache_page);
-#ifdef DCACHE_ALIASING_POSSIBLE
-EXPORT_SYMBOL(__flush_dcache_range);
-#endif
+EXPORT_SYMBOL(prom_root_node);
=20
+/* from hvcalls.S */
 EXPORT_SYMBOL(sun4v_niagara_getperf);
 EXPORT_SYMBOL(sun4v_niagara_setperf);
 EXPORT_SYMBOL(sun4v_niagara2_getperf);
 EXPORT_SYMBOL(sun4v_niagara2_setperf);
=20
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
+/* inline functions in asm/pci_64.h */
 EXPORT_SYMBOL(pci_alloc_consistent);
 EXPORT_SYMBOL(pci_free_consistent);
 EXPORT_SYMBOL(pci_map_single);
@@ -115,65 +61,7 @@ EXPORT_SYMBOL(pci_map_sg);
 EXPORT_SYMBOL(pci_unmap_sg);
 EXPORT_SYMBOL(pci_dma_sync_single_for_cpu);
 EXPORT_SYMBOL(pci_dma_sync_sg_for_cpu);
-EXPORT_SYMBOL(pci_dma_supported);
 #endif
=20
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
-EXPORT_SYMBOL(prom_finddevice);
-EXPORT_SYMBOL(prom_feval);
-EXPORT_SYMBOL(prom_getbool);
-EXPORT_SYMBOL(prom_getstring);
-EXPORT_SYMBOL(prom_getint);
-EXPORT_SYMBOL(prom_getintdefault);
-EXPORT_SYMBOL(__prom_getchild);
-EXPORT_SYMBOL(__prom_getsibling);
-
-/* Moving data to/from/in userspace. */
-EXPORT_SYMBOL(copy_to_user_fixup);
-EXPORT_SYMBOL(copy_from_user_fixup);
-EXPORT_SYMBOL(copy_in_user_fixup);
-
-/* Various address conversion macros use this. */
-EXPORT_SYMBOL(sparc64_valid_addr_bitmap);
-
-/* No version information on this, heavily used in inline asm,
- * and will always be 'void __ret_efault(void)'.
- */
-EXPORT_SYMBOL(__ret_efault);
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
-EXPORT_SYMBOL_GPL(real_hard_smp_processor_id);
diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc=
_64.c
index 39749e3..09058fc 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -23,6 +23,7 @@
 #include <linux/ipc.h>
 #include <linux/personality.h>
 #include <linux/random.h>
+#include <linux/module.h>
=20
 #include <asm/uaccess.h>
 #include <asm/utrap.h>
@@ -354,6 +355,7 @@ unsigned long get_fb_unmapped_area(struct file *filp, u=
nsigned long orig_addr, u
=20
 	return addr;
 }
+EXPORT_SYMBOL(get_fb_unmapped_area);
=20
 /* Essentially the same as PowerPC... */
 void arch_pick_mmap_layout(struct mm_struct *mm)
diff --git a/arch/sparc/kernel/time_64.c b/arch/sparc/kernel/time_64.c
index 9df8f09..0d1c011 100644
--- a/arch/sparc/kernel/time_64.c
+++ b/arch/sparc/kernel/time_64.c
@@ -176,6 +176,7 @@ static struct sparc64_tick_ops tick_operations __read_m=
ostly =3D {
 };
=20
 struct sparc64_tick_ops *tick_ops __read_mostly =3D &tick_operations;
+EXPORT_SYMBOL(tick_ops);
=20
 static void stick_disable_irq(void)
 {
@@ -639,6 +640,7 @@ unsigned long sparc64_get_clock_tick(unsigned int cpu)
 		return ft->clock_tick_ref;
 	return cpu_data(cpu).clock_tick;
 }
+EXPORT_SYMBOL(sparc64_get_clock_tick);
=20
 #ifdef CONFIG_CPU_FREQ
=20
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
=20
 static DEFINE_SPINLOCK(dimm_handler_lock);
@@ -2261,6 +2262,7 @@ void die_if_kernel(char *str, struct pt_regs *regs)
 		do_exit(SIGKILL);
 	do_exit(SIGSEGV);
 }
+EXPORT_SYMBOL(die_if_kernel);
=20
 #define VIS_OPCODE_MASK	((0x3 << 30) | (0x3f << 19))
 #define VIS_OPCODE_VAL	((0x2 << 30) | (0x36 << 19))
diff --git a/arch/sparc/lib/PeeCeeI.c b/arch/sparc/lib/PeeCeeI.c
index 46053e6..6529f86 100644
--- a/arch/sparc/lib/PeeCeeI.c
+++ b/arch/sparc/lib/PeeCeeI.c
@@ -4,6 +4,8 @@
  * Copyright (C) 1997 David S. Miller (davem@caip.rutgers.edu)
  */
=20
+#include <linux/module.h>
+
 #include <asm/io.h>
 #include <asm/byteorder.h>
=20
@@ -15,6 +17,7 @@ void outsb(unsigned long __addr, const void *src, unsigne=
d long count)
 	while (count--)
 		outb(*p++, addr);
 }
+EXPORT_SYMBOL(outsb);
=20
 void outsw(unsigned long __addr, const void *src, unsigned long count)
 {
@@ -25,6 +28,7 @@ void outsw(unsigned long __addr, const void *src, unsigne=
d long count)
 		src +=3D sizeof(u16);
 	}
 }
+EXPORT_SYMBOL(outsw);
=20
 void outsl(unsigned long __addr, const void *src, unsigned long count)
 {
@@ -78,6 +82,7 @@ void outsl(unsigned long __addr, const void *src, unsigne=
d long count)
 		break;
 	}
 }
+EXPORT_SYMBOL(outsl);
=20
 void insb(unsigned long __addr, void *dst, unsigned long count)
 {
@@ -105,6 +110,7 @@ void insb(unsigned long __addr, void *dst, unsigned lon=
g count)
 			*pb++ =3D inb(addr);
 	}
 }
+EXPORT_SYMBOL(insb);
=20
 void insw(unsigned long __addr, void *dst, unsigned long count)
 {
@@ -132,6 +138,7 @@ void insw(unsigned long __addr, void *dst, unsigned lon=
g count)
 			*ps =3D le16_to_cpu(inw(addr));
 	}
 }
+EXPORT_SYMBOL(insw);
=20
 void insl(unsigned long __addr, void *dst, unsigned long count)
 {
@@ -200,4 +207,5 @@ void insl(unsigned long __addr, void *dst, unsigned lon=
g count)
 		}
 	}
 }
+EXPORT_SYMBOL(insl);
=20
diff --git a/arch/sparc/lib/user_fixup.c b/arch/sparc/lib/user_fixup.c
index 05a361b..ac96ae2 100644
--- a/arch/sparc/lib/user_fixup.c
+++ b/arch/sparc/lib/user_fixup.c
@@ -7,6 +7,8 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/errno.h>
+#include <linux/module.h>
+
 #include <asm/uaccess.h>
=20
 /* Calculating the exact fault address when using
@@ -40,6 +42,7 @@ unsigned long copy_from_user_fixup(void *to, const void _=
_user *from, unsigned l
=20
 	return size;
 }
+EXPORT_SYMBOL(copy_from_user_fixup);
=20
 unsigned long copy_to_user_fixup(void __user *to, const void *from, unsign=
ed long size)
 {
@@ -47,6 +50,7 @@ unsigned long copy_to_user_fixup(void __user *to, const v=
oid *from, unsigned lon
=20
 	return compute_size((unsigned long) to, size, &offset);
 }
+EXPORT_SYMBOL(copy_to_user_fixup);
=20
 unsigned long copy_in_user_fixup(void __user *to, void __user *from, unsig=
ned long size)
 {
@@ -64,3 +68,4 @@ unsigned long copy_in_user_fixup(void __user *to, void __=
user *from, unsigned lo
=20
 	return size;
 }
+EXPORT_SYMBOL(copy_in_user_fixup);
diff --git a/arch/sparc/mm/generic_64.c b/arch/sparc/mm/generic_64.c
index f362c20..04f2bf4 100644
--- a/arch/sparc/mm/generic_64.c
+++ b/arch/sparc/mm/generic_64.c
@@ -161,3 +161,4 @@ int io_remap_pfn_range(struct vm_area_struct *vma, unsi=
gned long from,
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
=20
 unsigned long *sparc64_valid_addr_bitmap __read_mostly;
+EXPORT_SYMBOL(sparc64_valid_addr_bitmap);
=20
 /* Kernel physical address base and size in bytes.  */
 unsigned long kern_base __read_mostly;
@@ -359,6 +360,7 @@ void flush_dcache_page(struct page *page)
 out:
 	put_cpu();
 }
+EXPORT_SYMBOL(flush_dcache_page);
=20
 void __kprobes flush_icache_range(unsigned long start, unsigned long end)
 {
@@ -386,6 +388,7 @@ void __kprobes flush_icache_range(unsigned long start, =
unsigned long end)
 		}
 	}
 }
+EXPORT_SYMBOL(flush_icache_range);
=20
 void mmu_info(struct seq_file *m)
 {
@@ -589,6 +592,7 @@ void __flush_dcache_range(unsigned long start, unsigned=
 long end)
 					       "i" (ASI_DCACHE_INVALIDATE));
 	}
 }
+EXPORT_SYMBOL(__flush_dcache_range);
=20
 /* get_new_mmu_context() uses "cache + 1".  */
 DEFINE_SPINLOCK(ctx_alloc_lock);
diff --git a/arch/sparc/prom/misc_64.c b/arch/sparc/prom/misc_64.c
index 9b0c076..eedffb4 100644
--- a/arch/sparc/prom/misc_64.c
+++ b/arch/sparc/prom/misc_64.c
@@ -11,6 +11,8 @@
 #include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
+#include <linux/module.h>
+
 #include <asm/openprom.h>
 #include <asm/oplib.h>
 #include <asm/system.h>
@@ -54,6 +56,7 @@ void prom_feval(const char *fstring)
 	p1275_cmd("interpret", P1275_ARG(0, P1275_ARG_IN_STRING) |
 		  P1275_INOUT(1, 1), fstring);
 }
+EXPORT_SYMBOL(prom_feval);
=20
 #ifdef CONFIG_SMP
 extern void smp_capture(void);
diff --git a/arch/sparc/prom/tree_64.c b/arch/sparc/prom/tree_64.c
index 281aea4..175c709 100644
--- a/arch/sparc/prom/tree_64.c
+++ b/arch/sparc/prom/tree_64.c
@@ -10,6 +10,7 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
+#include <linux/module.h>
=20
 #include <asm/openprom.h>
 #include <asm/oplib.h>
@@ -22,6 +23,7 @@ inline int __prom_getchild(int node)
 {
 	return p1275_cmd ("child", P1275_INOUT(1, 1), node);
 }
+EXPORT_SYMBOL(__prom_getchild);
=20
 inline int prom_getchild(int node)
 {
@@ -32,6 +34,7 @@ inline int prom_getchild(int node)
 	if(cnode =3D -1) return 0;
 	return (int)cnode;
 }
+EXPORT_SYMBOL(prom_getchild);
=20
 inline int prom_getparent(int node)
 {
@@ -50,6 +53,7 @@ inline int __prom_getsibling(int node)
 {
 	return p1275_cmd(prom_peer_name, P1275_INOUT(1, 1), node);
 }
+EXPORT_SYMBOL(__prom_getsibling);
=20
 inline int prom_getsibling(int node)
 {
@@ -63,6 +67,7 @@ inline int prom_getsibling(int node)
=20
 	return sibnode;
 }
+EXPORT_SYMBOL(prom_getsibling);
=20
 /* Return the length in bytes of property 'prop' at node 'node'.
  * Return -1 on error.
@@ -75,6 +80,7 @@ inline int prom_getproplen(int node, const char *prop)
 			  P1275_INOUT(2, 1),=20
 			  node, prop);
 }
+EXPORT_SYMBOL(prom_getproplen);
=20
 /* Acquire a property 'prop' at node 'node' and place it in
  * 'buffer' which has a size of 'bufsize'.  If the acquisition
@@ -97,6 +103,7 @@ inline int prom_getproperty(int node, const char *prop,
 				 node, prop, buffer, P1275_SIZE(plen));
 	}
 }
+EXPORT_SYMBOL(prom_getproperty);
=20
 /* Acquire an integer property and return its value.  Returns -1
  * on failure.
@@ -110,6 +117,7 @@ inline int prom_getint(int node, const char *prop)
=20
 	return -1;
 }
+EXPORT_SYMBOL(prom_getint);
=20
 /* Acquire an integer property, upon error return the passed default
  * integer.
@@ -124,6 +132,7 @@ int prom_getintdefault(int node, const char *property, =
int deflt)
=20
 	return retval;
 }
+EXPORT_SYMBOL(prom_getintdefault);
=20
 /* Acquire a boolean property, 1=3DTRUE 0=FALSE. */
 int prom_getbool(int node, const char *prop)
@@ -134,6 +143,7 @@ int prom_getbool(int node, const char *prop)
 	if(retval =3D -1) return 0;
 	return 1;
 }
+EXPORT_SYMBOL(prom_getbool);
=20
 /* Acquire a property whose value is a string, returns a null
  * string on error.  The char pointer is the user supplied string
@@ -148,7 +158,7 @@ void prom_getstring(int node, const char *prop, char *u=
ser_buf, int ubuf_size)
 	user_buf[0] =3D 0;
 	return;
 }
-
+EXPORT_SYMBOL(prom_getstring);
=20
 /* Does the device at node 'node' have name 'name'?
  * YES =3D 1   NO =3D 0
@@ -181,6 +191,7 @@ int prom_searchsiblings(int node_start, const char *nod=
ename)
=20
 	return 0;
 }
+EXPORT_SYMBOL(prom_searchsiblings);
=20
 /* Return the first property type for node 'node'.
  * buffer should be at least 32B in length
@@ -194,6 +205,7 @@ inline char *prom_firstprop(int node, char *buffer)
 			       node, (char *) 0x0, buffer);
 	return buffer;
 }
+EXPORT_SYMBOL(prom_firstprop);
=20
 /* Return the property type string after property type 'oprop'
  * at node 'node' .  Returns NULL string if no more
@@ -217,6 +229,7 @@ inline char *prom_nextprop(int node, const char *oprop,=
 char *buffer)
 				    node, oprop, buffer);=20
 	return buffer;
 }
+EXPORT_SYMBOL(prom_nextprop);
=20
 int
 prom_finddevice(const char *name)
@@ -228,6 +241,7 @@ prom_finddevice(const char *name)
 			 P1275_INOUT(1, 1),=20
 			 name);
 }
+EXPORT_SYMBOL(prom_finddevice);
=20
 int prom_node_has_property(int node, const char *prop)
 {
@@ -241,7 +255,8 @@ int prom_node_has_property(int node, const char *prop)
 	} while (*buf);
 	return 0;
 }
-                                                                          =
                =20
+EXPORT_SYMBOL(prom_node_has_property);
+
 /* Set property 'pname' at node 'node' to value 'value' which has a length
  * of 'size' bytes.  Return the number of bytes the prom accepted.
  */
@@ -264,6 +279,7 @@ prom_setprop(int node, const char *pname, char *value, =
int size)
 					  P1275_INOUT(4, 1),=20
 					  node, pname, value, P1275_SIZE(size));
 }
+EXPORT_SYMBOL(prom_setprop);
=20
 inline int prom_inst2pkg(int inst)
 {
