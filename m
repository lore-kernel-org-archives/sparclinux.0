From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 01 Jan 2009 20:03:10 +0000
Subject: [PATCH 7/7] sparc: unify openprom.h
Message-Id: <1230840190-31884-7-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

After the preparational steps the unification was simple.

The linux_prom_pci_registers definition did not look like
it could be unified at first look sine the structure is assigned
using prop_getproperty() / of_get_property() so the structure
is assumed to come direct form the prom.

The LINUX_OPPROM_MAGIC was kept even if it is not used by the kernel
on the assumption that userspace may require it.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/Kbuild        |    2 -
 arch/sparc/include/asm/openprom.h    |  277 +++++++++++++++++++++++++++++++++-
 arch/sparc/include/asm/openprom_32.h |  234 ----------------------------
 arch/sparc/include/asm/openprom_64.h |  248 ------------------------------
 4 files changed, 273 insertions(+), 488 deletions(-)
 delete mode 100644 arch/sparc/include/asm/openprom_32.h
 delete mode 100644 arch/sparc/include/asm/openprom_64.h

diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
index 2eb9450..aeaec45 100644
--- a/arch/sparc/include/asm/Kbuild
+++ b/arch/sparc/include/asm/Kbuild
@@ -8,8 +8,6 @@ header-y += envctrl.h
 header-y += fbio.h
 header-y += jsflash.h
 header-y += openprom.h
-header-y += openprom_32.h
-header-y += openprom_64.h
 header-y += openpromio.h
 header-y += perfctr.h
 header-y += psrcompat.h
diff --git a/arch/sparc/include/asm/openprom.h b/arch/sparc/include/asm/openprom.h
index aaeae90..963e1a4 100644
--- a/arch/sparc/include/asm/openprom.h
+++ b/arch/sparc/include/asm/openprom.h
@@ -1,8 +1,277 @@
-#ifndef ___ASM_SPARC_OPENPROM_H
-#define ___ASM_SPARC_OPENPROM_H
+#ifndef __SPARC_OPENPROM_H
+#define __SPARC_OPENPROM_H
+
+/* openprom.h:  Prom structures and defines for access to the OPENBOOT
+ *              prom routines and data areas.
+ *
+ * Copyright (C) 1995,1996 David S. Miller (davem@caip.rutgers.edu)
+ */
+
+/* Empirical constants... */
+#define LINUX_OPPROM_MAGIC      0x10010407
+
+#ifndef __ASSEMBLY__
+/* V0 prom device operations. */
+struct linux_dev_v0_funcs {
+	int (*v0_devopen)(char *device_str);
+	int (*v0_devclose)(int dev_desc);
+	int (*v0_rdblkdev)(int dev_desc, int num_blks, int blk_st, char *buf);
+	int (*v0_wrblkdev)(int dev_desc, int num_blks, int blk_st, char *buf);
+	int (*v0_wrnetdev)(int dev_desc, int num_bytes, char *buf);
+	int (*v0_rdnetdev)(int dev_desc, int num_bytes, char *buf);
+	int (*v0_rdchardev)(int dev_desc, int num_bytes, int dummy, char *buf);
+	int (*v0_wrchardev)(int dev_desc, int num_bytes, int dummy, char *buf);
+	int (*v0_seekdev)(int dev_desc, long logical_offst, int from);
+};
+
+/* V2 and later prom device operations. */
+struct linux_dev_v2_funcs {
+	int (*v2_inst2pkg)(int d);	/* Convert ihandle to phandle */
+	char * (*v2_dumb_mem_alloc)(char *va, unsigned sz);
+	void (*v2_dumb_mem_free)(char *va, unsigned sz);
+
+	/* To map devices into virtual I/O space. */
+	char * (*v2_dumb_mmap)(char *virta, int which_io, unsigned paddr, unsigned sz);
+	void (*v2_dumb_munmap)(char *virta, unsigned size);
+
+	int (*v2_dev_open)(char *devpath);
+	void (*v2_dev_close)(int d);
+	int (*v2_dev_read)(int d, char *buf, int nbytes);
+	int (*v2_dev_write)(int d, char *buf, int nbytes);
+	int (*v2_dev_seek)(int d, int hi, int lo);
+
+	/* Never issued (multistage load support) */
+	void (*v2_wheee2)(void);
+	void (*v2_wheee3)(void);
+};
+
+struct linux_mlist_v0 {
+	struct linux_mlist_v0 *theres_more;
+	unsigned int start_adr;
+	unsigned num_bytes;
+};
+
+struct linux_mem_v0 {
+	struct linux_mlist_v0 **v0_totphys;
+	struct linux_mlist_v0 **v0_prommap;
+	struct linux_mlist_v0 **v0_available; /* What we can use */
+};
+
+/* Arguments sent to the kernel from the boot prompt. */
+struct linux_arguments_v0 {
+	char *argv[8];
+	char args[100];
+	char boot_dev[2];
+	int boot_dev_ctrl;
+	int boot_dev_unit;
+	int dev_partition;
+	char *kernel_file_name;
+	void *aieee1;           /* XXX */
+};
+
+/* V2 and up boot things. */
+struct linux_bootargs_v2 {
+	char **bootpath;
+	char **bootargs;
+	int *fd_stdin;
+	int *fd_stdout;
+};
+
+/* The top level PROM vector. */
+struct linux_romvec {
+	/* Version numbers. */
+	unsigned int pv_magic_cookie;
+	unsigned int pv_romvers;
+	unsigned int pv_plugin_revision;
+	unsigned int pv_printrev;
+
+	/* Version 0 memory descriptors. */
+	struct linux_mem_v0 pv_v0mem;
+
+	/* Node operations. */
+	struct linux_nodeops *pv_nodeops;
+
+	char **pv_bootstr;
+	struct linux_dev_v0_funcs pv_v0devops;
+
+	char *pv_stdin;
+	char *pv_stdout;
+#define	PROMDEV_KBD	0		/* input from keyboard */
+#define	PROMDEV_SCREEN	0		/* output to screen */
+#define	PROMDEV_TTYA	1		/* in/out to ttya */
+#define	PROMDEV_TTYB	2		/* in/out to ttyb */
+
+	/* Blocking getchar/putchar.  NOT REENTRANT! (grr) */
+	int (*pv_getchar)(void);
+	void (*pv_putchar)(int ch);
+
+	/* Non-blocking variants. */
+	int (*pv_nbgetchar)(void);
+	int (*pv_nbputchar)(int ch);
+
+	void (*pv_putstr)(char *str, int len);
+
+	/* Miscellany. */
+	void (*pv_reboot)(char *bootstr);
+	void (*pv_printf)(__const__ char *fmt, ...);
+	void (*pv_abort)(void);
+	__volatile__ int *pv_ticks;
+	void (*pv_halt)(void);
+	void (**pv_synchook)(void);
+
+	/* Evaluate a forth string, not different proto for V0 and V2->up. */
+	union {
+		void (*v0_eval)(int len, char *str);
+		void (*v2_eval)(char *str);
+	} pv_fortheval;
+
+	struct linux_arguments_v0 **pv_v0bootargs;
+
+	/* Get ether address. */
+	unsigned int (*pv_enaddr)(int d, char *enaddr);
+
+	struct linux_bootargs_v2 pv_v2bootargs;
+	struct linux_dev_v2_funcs pv_v2devops;
+
+	int filler[15];
+
+	/* This one is sun4c/sun4 only. */
+	void (*pv_setctxt)(int ctxt, char *va, int pmeg);
+
+	/* Prom version 3 Multiprocessor routines. This stuff is crazy.
+	 * No joke. Calling these when there is only one cpu probably
+	 * crashes the machine, have to test this. :-)
+	 */
+
+	/* v3_cpustart() will start the cpu 'whichcpu' in mmu-context
+	 * 'thiscontext' executing at address 'prog_counter'
+	 */
+	int (*v3_cpustart)(unsigned int whichcpu, int ctxtbl_ptr,
+			   int thiscontext, char *prog_counter);
+
+	/* v3_cpustop() will cause cpu 'whichcpu' to stop executing
+	 * until a resume cpu call is made.
+	 */
+	int (*v3_cpustop)(unsigned int whichcpu);
+
+	/* v3_cpuidle() will idle cpu 'whichcpu' until a stop or
+	 * resume cpu call is made.
+	 */
+	int (*v3_cpuidle)(unsigned int whichcpu);
+
+	/* v3_cpuresume() will resume processor 'whichcpu' executing
+	 * starting with whatever 'pc' and 'npc' were left at the
+	 * last 'idle' or 'stop' call.
+	 */
+	int (*v3_cpuresume)(unsigned int whichcpu);
+};
+
+/* Routines for traversing the prom device tree. */
+struct linux_nodeops {
+	int (*no_nextnode)(int node);
+	int (*no_child)(int node);
+	int (*no_proplen)(int node, const char *name);
+	int (*no_getprop)(int node, const char *name, char *val);
+	int (*no_setprop)(int node, const char *name, char *val, int len);
+	char * (*no_nextprop)(int node, char *name);
+};
+
+/* More fun PROM structures for device probing. */
 #if defined(__sparc__) && defined(__arch64__)
-#include <asm/openprom_64.h>
+#define PROMREG_MAX     24
+#define PROMVADDR_MAX   16
+#define PROMINTR_MAX    32
 #else
-#include <asm/openprom_32.h>
+#define PROMREG_MAX     16
+#define PROMVADDR_MAX   16
+#define PROMINTR_MAX    15
 #endif
+
+struct linux_prom_registers {
+	unsigned int which_io;	/* hi part of physical address */
+	unsigned int phys_addr;	/* The physical address of this register */
+	unsigned int reg_size;	/* How many bytes does this register take up? */
+};
+
+struct linux_prom64_registers {
+	unsigned long phys_addr;
+	unsigned long reg_size;
+};
+
+struct linux_prom_irqs {
+	int pri;    /* IRQ priority */
+	int vector; /* This is foobar, what does it do? */
+};
+
+/* Element of the "ranges" vector */
+struct linux_prom_ranges {
+	unsigned int ot_child_space;
+	unsigned int ot_child_base;		/* Bus feels this */
+	unsigned int ot_parent_space;
+	unsigned int ot_parent_base;		/* CPU looks from here */
+	unsigned int or_size;
+};
+
+/*
+ * Ranges and reg properties are a bit different for PCI.
+ */
+#if defined(__sparc__) && defined(__arch64__)
+struct linux_prom_pci_registers {
+	unsigned int phys_hi;
+	unsigned int phys_mid;
+	unsigned int phys_lo;
+
+	unsigned int size_hi;
+	unsigned int size_lo;
+};
+#else
+struct linux_prom_pci_registers {
+	/*
+	 * We don't know what information this field contain.
+	 * We guess, PCI device function is in bits 15:8
+	 * So, ...
+	 */
+	unsigned int which_io;  /* Let it be which_io */
+
+	unsigned int phys_hi;
+	unsigned int phys_lo;
+
+	unsigned int size_hi;
+	unsigned int size_lo;
+};
+
 #endif
+
+struct linux_prom_pci_ranges {
+	unsigned int child_phys_hi;	/* Only certain bits are encoded here. */
+	unsigned int child_phys_mid;
+	unsigned int child_phys_lo;
+
+	unsigned int parent_phys_hi;
+	unsigned int parent_phys_lo;
+
+	unsigned int size_hi;
+	unsigned int size_lo;
+};
+
+struct linux_prom_pci_intmap {
+	unsigned int phys_hi;
+	unsigned int phys_mid;
+	unsigned int phys_lo;
+
+	unsigned int interrupt;
+
+	int          cnode;
+	unsigned int cinterrupt;
+};
+
+struct linux_prom_pci_intmask {
+	unsigned int phys_hi;
+	unsigned int phys_mid;
+	unsigned int phys_lo;
+	unsigned int interrupt;
+};
+
+#endif /* !(__ASSEMBLY__) */
+
+#endif /* !(__SPARC_OPENPROM_H) */
diff --git a/arch/sparc/include/asm/openprom_32.h b/arch/sparc/include/asm/openprom_32.h
deleted file mode 100644
index 2e58db5..0000000
--- a/arch/sparc/include/asm/openprom_32.h
+++ /dev/null
@@ -1,234 +0,0 @@
-#ifndef __SPARC_OPENPROM_H
-#define __SPARC_OPENPROM_H
-
-/* openprom.h:  Prom structures and defines for access to the OPENBOOT
- *              prom routines and data areas.
- *
- * Copyright (C) 1995 David S. Miller (davem@caip.rutgers.edu)
- */
-
-/* Empirical constants... */
-#define	LINUX_OPPROM_MAGIC      0x10010407
-
-#ifndef __ASSEMBLY__
-/* V0 prom device operations. */
-struct linux_dev_v0_funcs {
-	int (*v0_devopen)(char *device_str);
-	int (*v0_devclose)(int dev_desc);
-	int (*v0_rdblkdev)(int dev_desc, int num_blks, int blk_st, char *buf);
-	int (*v0_wrblkdev)(int dev_desc, int num_blks, int blk_st, char *buf);
-	int (*v0_wrnetdev)(int dev_desc, int num_bytes, char *buf);
-	int (*v0_rdnetdev)(int dev_desc, int num_bytes, char *buf);
-	int (*v0_rdchardev)(int dev_desc, int num_bytes, int dummy, char *buf);
-	int (*v0_wrchardev)(int dev_desc, int num_bytes, int dummy, char *buf);
-	int (*v0_seekdev)(int dev_desc, long logical_offst, int from);
-};
-
-/* V2 and later prom device operations. */
-struct linux_dev_v2_funcs {
-	int (*v2_inst2pkg)(int d);	/* Convert ihandle to phandle */
-	char * (*v2_dumb_mem_alloc)(char *va, unsigned sz);
-	void (*v2_dumb_mem_free)(char *va, unsigned sz);
-
-	/* To map devices into virtual I/O space. */
-	char * (*v2_dumb_mmap)(char *virta, int which_io, unsigned paddr, unsigned sz);
-	void (*v2_dumb_munmap)(char *virta, unsigned size);
-
-	int (*v2_dev_open)(char *devpath);
-	void (*v2_dev_close)(int d);
-	int (*v2_dev_read)(int d, char *buf, int nbytes);
-	int (*v2_dev_write)(int d, char *buf, int nbytes);
-	int (*v2_dev_seek)(int d, int hi, int lo);
-
-	/* Never issued (multistage load support) */
-	void (*v2_wheee2)(void);
-	void (*v2_wheee3)(void);
-};
-
-struct linux_mlist_v0 {
-	struct linux_mlist_v0 *theres_more;
-	unsigned int start_adr;
-	unsigned num_bytes;
-};
-
-struct linux_mem_v0 {
-	struct linux_mlist_v0 **v0_totphys;
-	struct linux_mlist_v0 **v0_prommap;
-	struct linux_mlist_v0 **v0_available; /* What we can use */
-};
-
-/* Arguments sent to the kernel from the boot prompt. */
-struct linux_arguments_v0 {
-	char *argv[8];
-	char args[100];
-	char boot_dev[2];
-	int boot_dev_ctrl;
-	int boot_dev_unit;
-	int dev_partition;
-	char *kernel_file_name;
-	void *aieee1;           /* XXX */
-};
-
-/* V2 and up boot things. */
-struct linux_bootargs_v2 {
-	char **bootpath;
-	char **bootargs;
-	int *fd_stdin;
-	int *fd_stdout;
-};
-
-/* The top level PROM vector. */
-struct linux_romvec {
-	/* Version numbers. */
-	unsigned int pv_magic_cookie;
-	unsigned int pv_romvers;
-	unsigned int pv_plugin_revision;
-	unsigned int pv_printrev;
-
-	/* Version 0 memory descriptors. */
-	struct linux_mem_v0 pv_v0mem;
-
-	/* Node operations. */
-	struct linux_nodeops *pv_nodeops;
-
-	char **pv_bootstr;
-	struct linux_dev_v0_funcs pv_v0devops;
-
-	char *pv_stdin;
-	char *pv_stdout;
-#define	PROMDEV_KBD	0		/* input from keyboard */
-#define	PROMDEV_SCREEN	0		/* output to screen */
-#define	PROMDEV_TTYA	1		/* in/out to ttya */
-#define	PROMDEV_TTYB	2		/* in/out to ttyb */
-
-	/* Blocking getchar/putchar.  NOT REENTRANT! (grr) */
-	int (*pv_getchar)(void);
-	void (*pv_putchar)(int ch);
-
-	/* Non-blocking variants. */
-	int (*pv_nbgetchar)(void);
-	int (*pv_nbputchar)(int ch);
-
-	void (*pv_putstr)(char *str, int len);
-
-	/* Miscellany. */
-	void (*pv_reboot)(char *bootstr);
-	void (*pv_printf)(__const__ char *fmt, ...);
-	void (*pv_abort)(void);
-	__volatile__ int *pv_ticks;
-	void (*pv_halt)(void);
-	void (**pv_synchook)(void);
-
-	/* Evaluate a forth string, not different proto for V0 and V2->up. */
-	union {
-		void (*v0_eval)(int len, char *str);
-		void (*v2_eval)(char *str);
-	} pv_fortheval;
-
-	struct linux_arguments_v0 **pv_v0bootargs;
-
-	/* Get ether address. */
-	unsigned int (*pv_enaddr)(int d, char *enaddr);
-
-	struct linux_bootargs_v2 pv_v2bootargs;
-	struct linux_dev_v2_funcs pv_v2devops;
-
-	int filler[15];
-
-	/* This one is sun4c/sun4 only. */
-	void (*pv_setctxt)(int ctxt, char *va, int pmeg);
-
-	/* Prom version 3 Multiprocessor routines. This stuff is crazy.
-	 * No joke. Calling these when there is only one cpu probably
-	 * crashes the machine, have to test this. :-)
-	 */
-
-	/* v3_cpustart() will start the cpu 'whichcpu' in mmu-context
-	 * 'thiscontext' executing at address 'prog_counter'
-	 */
-	int (*v3_cpustart)(unsigned int whichcpu, int ctxtbl_ptr,
-			   int thiscontext, char *prog_counter);
-
-	/* v3_cpustop() will cause cpu 'whichcpu' to stop executing
-	 * until a resume cpu call is made.
-	 */
-	int (*v3_cpustop)(unsigned int whichcpu);
-
-	/* v3_cpuidle() will idle cpu 'whichcpu' until a stop or
-	 * resume cpu call is made.
-	 */
-	int (*v3_cpuidle)(unsigned int whichcpu);
-
-	/* v3_cpuresume() will resume processor 'whichcpu' executing
-	 * starting with whatever 'pc' and 'npc' were left at the
-	 * last 'idle' or 'stop' call.
-	 */
-	int (*v3_cpuresume)(unsigned int whichcpu);
-};
-
-/* Routines for traversing the prom device tree. */
-struct linux_nodeops {
-	int (*no_nextnode)(int node);
-	int (*no_child)(int node);
-	int (*no_proplen)(int node, const char *name);
-	int (*no_getprop)(int node, const char *name, char *val);
-	int (*no_setprop)(int node, const char *name, char *val, int len);
-	char * (*no_nextprop)(int node, char *name);
-};
-
-/* More fun PROM structures for device probing. */
-#define PROMREG_MAX     16
-#define PROMVADDR_MAX   16
-#define PROMINTR_MAX    15
-
-struct linux_prom_registers {
-	unsigned int which_io;	/* is this in OBIO space? */
-	unsigned int phys_addr;	/* The physical address of this register */
-	unsigned int reg_size;	/* How many bytes does this register take up? */
-};
-
-struct linux_prom_irqs {
-	int pri;    /* IRQ priority */
-	int vector; /* This is foobar, what does it do? */
-};
-
-/* Element of the "ranges" vector */
-struct linux_prom_ranges {
-	unsigned int ot_child_space;
-	unsigned int ot_child_base;		/* Bus feels this */
-	unsigned int ot_parent_space;
-	unsigned int ot_parent_base;		/* CPU looks from here */
-	unsigned int or_size;
-};
-
-/* Ranges and reg properties are a bit different for PCI. */
-struct linux_prom_pci_registers {
-	/*
-	 * We don't know what information this field contain.
-	 * We guess, PCI device function is in bits 15:8
-	 * So, ...
-	 */
-	unsigned int which_io;  /* Let it be which_io */
-
-	unsigned int phys_hi;
-	unsigned int phys_lo;
-
-	unsigned int size_hi;
-	unsigned int size_lo;
-};
-
-struct linux_prom_pci_ranges {
-	unsigned int child_phys_hi;	/* Only certain bits are encoded here. */
-	unsigned int child_phys_mid;
-	unsigned int child_phys_lo;
-
-	unsigned int parent_phys_hi;
-	unsigned int parent_phys_lo;
-
-	unsigned int size_hi;
-	unsigned int size_lo;
-};
-
-#endif /* !(__ASSEMBLY__) */
-
-#endif /* !(__SPARC_OPENPROM_H) */
diff --git a/arch/sparc/include/asm/openprom_64.h b/arch/sparc/include/asm/openprom_64.h
deleted file mode 100644
index 8148900..0000000
--- a/arch/sparc/include/asm/openprom_64.h
+++ /dev/null
@@ -1,248 +0,0 @@
-#ifndef __SPARC64_OPENPROM_H
-#define __SPARC64_OPENPROM_H
-
-/* openprom.h:  Prom structures and defines for access to the OPENBOOT
- *              prom routines and data areas.
- *
- * Copyright (C) 1996 David S. Miller (davem@caip.rutgers.edu)
- */
-
-#ifndef __ASSEMBLY__
-/* V0 prom device operations. */
-struct linux_dev_v0_funcs {
-	int (*v0_devopen)(char *device_str);
-	int (*v0_devclose)(int dev_desc);
-	int (*v0_rdblkdev)(int dev_desc, int num_blks, int blk_st, char *buf);
-	int (*v0_wrblkdev)(int dev_desc, int num_blks, int blk_st, char *buf);
-	int (*v0_wrnetdev)(int dev_desc, int num_bytes, char *buf);
-	int (*v0_rdnetdev)(int dev_desc, int num_bytes, char *buf);
-	int (*v0_rdchardev)(int dev_desc, int num_bytes, int dummy, char *buf);
-	int (*v0_wrchardev)(int dev_desc, int num_bytes, int dummy, char *buf);
-	int (*v0_seekdev)(int dev_desc, long logical_offst, int from);
-};
-
-/* V2 and later prom device operations. */
-struct linux_dev_v2_funcs {
-	int (*v2_inst2pkg)(int d);	/* Convert ihandle to phandle */
-	char * (*v2_dumb_mem_alloc)(char *va, unsigned sz);
-	void (*v2_dumb_mem_free)(char *va, unsigned sz);
-
-	/* To map devices into virtual I/O space. */
-	char * (*v2_dumb_mmap)(char *virta, int which_io, unsigned paddr, unsigned sz);
-	void (*v2_dumb_munmap)(char *virta, unsigned size);
-
-	int (*v2_dev_open)(char *devpath);
-	void (*v2_dev_close)(int d);
-	int (*v2_dev_read)(int d, char *buf, int nbytes);
-	int (*v2_dev_write)(int d, char *buf, int nbytes);
-	int (*v2_dev_seek)(int d, int hi, int lo);
-
-	/* Never issued (multistage load support) */
-	void (*v2_wheee2)(void);
-	void (*v2_wheee3)(void);
-};
-
-struct linux_mlist_v0 {
-	struct linux_mlist_v0 *theres_more;
-	unsigned int start_adr;
-	unsigned num_bytes;
-};
-
-struct linux_mem_v0 {
-	struct linux_mlist_v0 **v0_totphys;
-	struct linux_mlist_v0 **v0_prommap;
-	struct linux_mlist_v0 **v0_available; /* What we can use */
-};
-
-/* Arguments sent to the kernel from the boot prompt. */
-struct linux_arguments_v0 {
-	char *argv[8];
-	char args[100];
-	char boot_dev[2];
-	int boot_dev_ctrl;
-	int boot_dev_unit;
-	int dev_partition;
-	char *kernel_file_name;
-	void *aieee1;           /* XXX */
-};
-
-/* V2 and up boot things. */
-struct linux_bootargs_v2 {
-	char **bootpath;
-	char **bootargs;
-	int *fd_stdin;
-	int *fd_stdout;
-};
-
-/* The top level PROM vector. */
-struct linux_romvec {
-	/* Version numbers. */
-	unsigned int pv_magic_cookie;
-	unsigned int pv_romvers;
-	unsigned int pv_plugin_revision;
-	unsigned int pv_printrev;
-
-	/* Version 0 memory descriptors. */
-	struct linux_mem_v0 pv_v0mem;
-
-	/* Node operations. */
-	struct linux_nodeops *pv_nodeops;
-
-	char **pv_bootstr;
-	struct linux_dev_v0_funcs pv_v0devops;
-
-	char *pv_stdin;
-	char *pv_stdout;
-#define	PROMDEV_KBD	0		/* input from keyboard */
-#define	PROMDEV_SCREEN	0		/* output to screen */
-#define	PROMDEV_TTYA	1		/* in/out to ttya */
-#define	PROMDEV_TTYB	2		/* in/out to ttyb */
-
-	/* Blocking getchar/putchar.  NOT REENTRANT! (grr) */
-	int (*pv_getchar)(void);
-	void (*pv_putchar)(int ch);
-
-	/* Non-blocking variants. */
-	int (*pv_nbgetchar)(void);
-	int (*pv_nbputchar)(int ch);
-
-	void (*pv_putstr)(char *str, int len);
-
-	/* Miscellany. */
-	void (*pv_reboot)(char *bootstr);
-	void (*pv_printf)(__const__ char *fmt, ...);
-	void (*pv_abort)(void);
-	__volatile__ int *pv_ticks;
-	void (*pv_halt)(void);
-	void (**pv_synchook)(void);
-
-	/* Evaluate a forth string, not different proto for V0 and V2->up. */
-	union {
-		void (*v0_eval)(int len, char *str);
-		void (*v2_eval)(char *str);
-	} pv_fortheval;
-
-	struct linux_arguments_v0 **pv_v0bootargs;
-
-	/* Get ether address. */
-	unsigned int (*pv_enaddr)(int d, char *enaddr);
-
-	struct linux_bootargs_v2 pv_v2bootargs;
-	struct linux_dev_v2_funcs pv_v2devops;
-
-	int filler[15];
-
-	/* This one is sun4c/sun4 only. */
-	void (*pv_setctxt)(int ctxt, char *va, int pmeg);
-
-	/* Prom version 3 Multiprocessor routines. This stuff is crazy.
-	 * No joke. Calling these when there is only one cpu probably
-	 * crashes the machine, have to test this. :-)
-	 */
-
-	/* v3_cpustart() will start the cpu 'whichcpu' in mmu-context
-	 * 'thiscontext' executing at address 'prog_counter'
-	 */
-	int (*v3_cpustart)(unsigned int whichcpu, int ctxtbl_ptr,
-			   int thiscontext, char *prog_counter);
-
-	/* v3_cpustop() will cause cpu 'whichcpu' to stop executing
-	 * until a resume cpu call is made.
-	 */
-	int (*v3_cpustop)(unsigned int whichcpu);
-
-	/* v3_cpuidle() will idle cpu 'whichcpu' until a stop or
-	 * resume cpu call is made.
-	 */
-	int (*v3_cpuidle)(unsigned int whichcpu);
-
-	/* v3_cpuresume() will resume processor 'whichcpu' executing
-	 * starting with whatever 'pc' and 'npc' were left at the
-	 * last 'idle' or 'stop' call.
-	 */
-	int (*v3_cpuresume)(unsigned int whichcpu);
-};
-
-/* Routines for traversing the prom device tree. */
-struct linux_nodeops {
-	int (*no_nextnode)(int node);
-	int (*no_child)(int node);
-	int (*no_proplen)(int node, const char *name);
-	int (*no_getprop)(int node, const char *name, char *val);
-	int (*no_setprop)(int node, const char *name, char *val, int len);
-	char * (*no_nextprop)(int node, char *name);
-};
-
-/* More fun PROM structures for device probing. */
-#define PROMREG_MAX     24
-#define PROMVADDR_MAX   16
-#define PROMINTR_MAX    32
-
-struct linux_prom_registers {
-	unsigned int which_io;	/* hi part of physical address */
-	unsigned int phys_addr;	/* The physical address of this register */
-	unsigned int reg_size;	/* How many bytes does this register take up? */
-};
-
-struct linux_prom64_registers {
-	unsigned long phys_addr;
-	unsigned long reg_size;
-};
-
-struct linux_prom_irqs {
-	int pri;    /* IRQ priority */
-	int vector; /* This is foobar, what does it do? */
-};
-
-/* Element of the "ranges" vector */
-struct linux_prom_ranges {
-	unsigned int ot_child_space;
-	unsigned int ot_child_base;		/* Bus feels this */
-	unsigned int ot_parent_space;
-	unsigned int ot_parent_base;		/* CPU looks from here */
-	unsigned int or_size;
-};
-
-/* Ranges and reg properties are a bit different for PCI. */
-struct linux_prom_pci_registers {
-	unsigned int phys_hi;
-	unsigned int phys_mid;
-	unsigned int phys_lo;
-
-	unsigned int size_hi;
-	unsigned int size_lo;
-};
-
-struct linux_prom_pci_ranges {
-	unsigned int child_phys_hi;	/* Only certain bits are encoded here. */
-	unsigned int child_phys_mid;
-	unsigned int child_phys_lo;
-
-	unsigned int parent_phys_hi;
-	unsigned int parent_phys_lo;
-
-	unsigned int size_hi;
-	unsigned int size_lo;
-};
-
-struct linux_prom_pci_intmap {
-	unsigned int phys_hi;
-	unsigned int phys_mid;
-	unsigned int phys_lo;
-
-	unsigned int interrupt;
-
-	int          cnode;
-	unsigned int cinterrupt;
-};
-
-struct linux_prom_pci_intmask {
-	unsigned int phys_hi;
-	unsigned int phys_mid;
-	unsigned int phys_lo;
-	unsigned int interrupt;
-};
-
-#endif /* !(__ASSEMBLY__) */
-
-#endif /* !(__SPARC64_OPENPROM_H) */
-- 
1.6.0.2.GIT

