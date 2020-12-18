From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 18 Dec 2020 18:43:38 +0000
Subject: [PATCH v1 04/13] sparc32: Drop auxio support
Message-Id: <20201218184347.2180772-5-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20201218184347.2180772-1-sam@ravnborg.org>
In-Reply-To: <20201218184347.2180772-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David S Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@kernel.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Anshuman Khandual <anshuman.khandual@arm.com>, Arvind Sankar <nivedita@alum.mit.edu>, Christian Brauner <christian.brauner@ubuntu.com>, Denis Efremov <efremov@linux.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ira Weiny <ira.weiny@intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@kernel.org>, Pekka Enberg <penberg@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org, debian-sparc@lists.debian.org, gentoo-sparc@l.g.o

auxio is not supported by LEON - so drop it.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/include/asm/auxio_32.h |  73 +---------------
 arch/sparc/kernel/Makefile        |   2 +-
 arch/sparc/kernel/apc.c           |  14 ---
 arch/sparc/kernel/auxio_32.c      | 140 ------------------------------
 arch/sparc/kernel/devices.c       |   3 -
 arch/sparc/kernel/kernel.h        |   4 -
 arch/sparc/kernel/pmc.c           |  10 ---
 arch/sparc/kernel/process_32.c    |  10 ---
 arch/sparc/prom/misc_32.c         |   2 -
 9 files changed, 3 insertions(+), 255 deletions(-)
 delete mode 100644 arch/sparc/kernel/auxio_32.c

diff --git a/arch/sparc/include/asm/auxio_32.h b/arch/sparc/include/asm/auxio_32.h
index 852457c7a265..e2335ddd359d 100644
--- a/arch/sparc/include/asm/auxio_32.h
+++ b/arch/sparc/include/asm/auxio_32.h
@@ -1,43 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * auxio.h:  Definitions and code for the Auxiliary I/O register.
+ * Dummy definitions for the Auxiliary I/O register.
  *
  * Copyright (C) 1995 David S. Miller (davem@caip.rutgers.edu)
  */
 #ifndef _SPARC_AUXIO_H
 #define _SPARC_AUXIO_H
 
-#include <asm/vaddrs.h>
-
-/* This register is an unsigned char in IO space.  It does two things.
- * First, it is used to control the front panel LED light on machines
- * that have it (good for testing entry points to trap handlers and irq's)
- * Secondly, it controls various floppy drive parameters.
- */
-#define AUXIO_ORMEIN      0xf0    /* All writes must set these bits. */
-#define AUXIO_ORMEIN4M    0xc0    /* sun4m - All writes must set these bits. */
-#define AUXIO_FLPY_DENS   0x20    /* Floppy density, high if set. Read only. */
-#define AUXIO_FLPY_DCHG   0x10    /* A disk change occurred.  Read only. */
-#define AUXIO_EDGE_ON     0x10    /* sun4m - On means Jumper block is in. */
-#define AUXIO_FLPY_DSEL   0x08    /* Drive select/start-motor. Write only. */
-#define AUXIO_LINK_TEST   0x08    /* sun4m - On means TPE Carrier detect. */
-
-/* Set the following to one, then zero, after doing a pseudo DMA transfer. */
-#define AUXIO_FLPY_TCNT   0x04    /* Floppy terminal count. Write only. */
-
-/* Set the following to zero to eject the floppy. */
-#define AUXIO_FLPY_EJCT   0x02    /* Eject floppy disk.  Write only. */
-#define AUXIO_LED         0x01    /* On if set, off if unset. Read/Write */
-
-#ifndef __ASSEMBLY__
-
-/*
- * NOTE: these routines are implementation dependent--
- * understand the hardware you are querying!
- */
-void set_auxio(unsigned char bits_on, unsigned char bits_off);
-unsigned char get_auxio(void); /* .../asm/floppy.h */
-
 /*
  * The following routines are provided for driver-compatibility
  * with sparc64 (primarily sunlance.c)
@@ -46,44 +15,6 @@ unsigned char get_auxio(void); /* .../asm/floppy.h */
 #define AUXIO_LTE_ON    1
 #define AUXIO_LTE_OFF   0
 
-/* auxio_set_lte - Set Link Test Enable (TPE Link Detect)
- *
- * on - AUXIO_LTE_ON or AUXIO_LTE_OFF
- */
-#define auxio_set_lte(on) \
-do { \
-	if(on) { \
-		set_auxio(AUXIO_LINK_TEST, 0); \
-	} else { \
-		set_auxio(0, AUXIO_LINK_TEST); \
-	} \
-} while (0)
-
-#define AUXIO_LED_ON    1
-#define AUXIO_LED_OFF   0
-
-/* auxio_set_led - Set system front panel LED
- *
- * on - AUXIO_LED_ON or AUXIO_LED_OFF
- */
-#define auxio_set_led(on) \
-do { \
-	if(on) { \
-		set_auxio(AUXIO_LED, 0); \
-	} else { \
-		set_auxio(0, AUXIO_LED); \
-	} \
-} while (0)
-
-#endif /* !(__ASSEMBLY__) */
-
-
-/* AUXIO2 (Power Off Control) */
-extern volatile u8 __iomem *auxio_power_register;
-
-#define	AUXIO_POWER_DETECT_FAILURE	32
-#define	AUXIO_POWER_CLEAR_FAILURE	2
-#define	AUXIO_POWER_OFF			1
-
+#define auxio_set_lte(on)
 
 #endif /* !(_SPARC_AUXIO_H) */
diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index b6c9ca1d6c66..b2735fb29c89 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -84,7 +84,7 @@ obj-$(CONFIG_SMP)         += trampoline_$(BITS).o smp_$(BITS).o
 obj-$(CONFIG_SPARC32_SMP) += sun4m_smp.o sun4d_smp.o leon_smp.o
 obj-$(CONFIG_SPARC64_SMP) += hvtramp.o
 
-obj-y                     += auxio_$(BITS).o
+obj-$(CONFIG_SPARC64)     += auxio_64.o
 obj-$(CONFIG_SUN_PM)      += apc.o pmc.o
 
 obj-$(CONFIG_MODULES)     += module.o
diff --git a/arch/sparc/kernel/apc.c b/arch/sparc/kernel/apc.c
index ecd05bc0a104..93f5934bbbe1 100644
--- a/arch/sparc/kernel/apc.c
+++ b/arch/sparc/kernel/apc.c
@@ -19,15 +19,9 @@
 #include <asm/io.h>
 #include <asm/oplib.h>
 #include <linux/uaccess.h>
-#include <asm/auxio.h>
 #include <asm/apc.h>
 #include <asm/processor.h>
 
-/* Debugging
- * 
- * #define APC_DEBUG_LED
- */
-
 #define APC_MINOR	MISC_DYNAMIC_MINOR
 #define APC_OBPNAME	"power-management"
 #define APC_DEVNAME "apc"
@@ -60,15 +54,7 @@ __setup("apc=", apc_setup);
  */
 static void apc_swift_idle(void)
 {
-#ifdef APC_DEBUG_LED
-	set_auxio(0x00, AUXIO_LED); 
-#endif
-
 	apc_writeb(apc_readb(APC_IDLE_REG) | APC_IDLE_ON, APC_IDLE_REG);
-
-#ifdef APC_DEBUG_LED
-	set_auxio(AUXIO_LED, 0x00); 
-#endif
 } 
 
 static inline void apc_free(struct platform_device *op)
diff --git a/arch/sparc/kernel/auxio_32.c b/arch/sparc/kernel/auxio_32.c
deleted file mode 100644
index a32d588174f2..000000000000
--- a/arch/sparc/kernel/auxio_32.c
+++ /dev/null
@@ -1,140 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* auxio.c: Probing for the Sparc AUXIO register at boot time.
- *
- * Copyright (C) 1996 David S. Miller (davem@caip.rutgers.edu)
- */
-
-#include <linux/stddef.h>
-#include <linux/init.h>
-#include <linux/spinlock.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
-#include <linux/export.h>
-
-#include <asm/oplib.h>
-#include <asm/io.h>
-#include <asm/auxio.h>
-#include <asm/string.h>		/* memset(), Linux has no bzero() */
-#include <asm/cpu_type.h>
-
-#include "kernel.h"
-
-/* Probe and map in the Auxiliary I/O register */
-
-/* auxio_register is not static because it is referenced 
- * in entry.S::floppy_tdone
- */
-void __iomem *auxio_register = NULL;
-static DEFINE_SPINLOCK(auxio_lock);
-
-void __init auxio_probe(void)
-{
-	phandle node, auxio_nd;
-	struct linux_prom_registers auxregs[1];
-	struct resource r;
-
-	switch (sparc_cpu_model) {
-	case sparc_leon:
-	case sun4d:
-		return;
-	default:
-		break;
-	}
-	node = prom_getchild(prom_root_node);
-	auxio_nd = prom_searchsiblings(node, "auxiliary-io");
-	if(!auxio_nd) {
-		node = prom_searchsiblings(node, "obio");
-		node = prom_getchild(node);
-		auxio_nd = prom_searchsiblings(node, "auxio");
-		if(!auxio_nd) {
-#ifdef CONFIG_PCI
-			/* There may be auxio on Ebus */
-			return;
-#else
-			if(prom_searchsiblings(node, "leds")) {
-				/* VME chassis sun4m machine, no auxio exists. */
-				return;
-			}
-			prom_printf("Cannot find auxio node, cannot continue...\n");
-			prom_halt();
-#endif
-		}
-	}
-	if(prom_getproperty(auxio_nd, "reg", (char *) auxregs, sizeof(auxregs)) <= 0)
-		return;
-	prom_apply_obio_ranges(auxregs, 0x1);
-	/* Map the register both read and write */
-	r.flags = auxregs[0].which_io & 0xF;
-	r.start = auxregs[0].phys_addr;
-	r.end = auxregs[0].phys_addr + auxregs[0].reg_size - 1;
-	auxio_register = of_ioremap(&r, 0, auxregs[0].reg_size, "auxio");
-	/* Fix the address on sun4m. */
-	if ((((unsigned long) auxregs[0].phys_addr) & 3) = 3)
-		auxio_register += (3 - ((unsigned long)auxio_register & 3));
-
-	set_auxio(AUXIO_LED, 0);
-}
-
-unsigned char get_auxio(void)
-{
-	if(auxio_register) 
-		return sbus_readb(auxio_register);
-	return 0;
-}
-EXPORT_SYMBOL(get_auxio);
-
-void set_auxio(unsigned char bits_on, unsigned char bits_off)
-{
-	unsigned char regval;
-	unsigned long flags;
-	spin_lock_irqsave(&auxio_lock, flags);
-	switch (sparc_cpu_model) {
-	case sun4m:
-		if(!auxio_register)
-			break;     /* VME chassis sun4m, no auxio. */
-		regval = sbus_readb(auxio_register);
-		sbus_writeb(((regval | bits_on) & ~bits_off) | AUXIO_ORMEIN4M,
-			auxio_register);
-		break;
-	case sun4d:
-		break;
-	default:
-		panic("Can't set AUXIO register on this machine.");
-	}
-	spin_unlock_irqrestore(&auxio_lock, flags);
-}
-EXPORT_SYMBOL(set_auxio);
-
-/* sun4m power control register (AUXIO2) */
-
-volatile u8 __iomem *auxio_power_register = NULL;
-
-void __init auxio_power_probe(void)
-{
-	struct linux_prom_registers regs;
-	phandle node;
-	struct resource r;
-
-	/* Attempt to find the sun4m power control node. */
-	node = prom_getchild(prom_root_node);
-	node = prom_searchsiblings(node, "obio");
-	node = prom_getchild(node);
-	node = prom_searchsiblings(node, "power");
-	if (node = 0 || (s32)node = -1)
-		return;
-
-	/* Map the power control register. */
-	if (prom_getproperty(node, "reg", (char *)&regs, sizeof(regs)) <= 0)
-		return;
-	prom_apply_obio_ranges(&regs, 1);
-	memset(&r, 0, sizeof(r));
-	r.flags = regs.which_io & 0xF;
-	r.start = regs.phys_addr;
-	r.end = regs.phys_addr + regs.reg_size - 1;
-	auxio_power_register -		(u8 __iomem *)of_ioremap(&r, 0, regs.reg_size, "auxpower");
-
-	/* Display a quick message on the console. */
-	if (auxio_power_register)
-		printk(KERN_INFO "Power off control detected.\n");
-}
diff --git a/arch/sparc/kernel/devices.c b/arch/sparc/kernel/devices.c
index 23b6e50d4ada..b3c2d51b22c4 100644
--- a/arch/sparc/kernel/devices.c
+++ b/arch/sparc/kernel/devices.c
@@ -132,7 +132,4 @@ void __init device_scan(void)
 							    0);
 	}
 #endif /* !CONFIG_SMP */
-
-	auxio_probe();
-	auxio_power_probe();
 }
diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index c76e49032273..7328d13875e4 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -175,10 +175,6 @@ asmlinkage void user_unaligned_trap(struct pt_regs *regs, unsigned int insn);
 /* windows.c */
 void try_to_clear_window_buffer(struct pt_regs *regs, int who);
 
-/* auxio_32.c */
-void __init auxio_probe(void);
-void __init auxio_power_probe(void);
-
 /* pcic.c */
 extern void __iomem *pcic_regs;
 void pcic_nmi(unsigned int pend, struct pt_regs *regs);
diff --git a/arch/sparc/kernel/pmc.c b/arch/sparc/kernel/pmc.c
index b5c1eb33b951..441b9fbc27f1 100644
--- a/arch/sparc/kernel/pmc.c
+++ b/arch/sparc/kernel/pmc.c
@@ -17,12 +17,10 @@
 #include <asm/io.h>
 #include <asm/oplib.h>
 #include <linux/uaccess.h>
-#include <asm/auxio.h>
 #include <asm/processor.h>
 
 /* Debug
  *
- * #define PMC_DEBUG_LED
  * #define PMC_NO_IDLE
  */
 
@@ -43,15 +41,7 @@ static u8 __iomem *regs;
  */
 static void pmc_swift_idle(void)
 {
-#ifdef PMC_DEBUG_LED
-	set_auxio(0x00, AUXIO_LED);
-#endif
-
 	pmc_writeb(pmc_readb(PMC_IDLE_REG) | PMC_IDLE_ON, PMC_IDLE_REG);
-
-#ifdef PMC_DEBUG_LED
-	set_auxio(AUXIO_LED, 0x00);
-#endif
 }
 
 static int pmc_probe(struct platform_device *op)
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index a02363735915..cf9ef387c6d5 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -30,7 +30,6 @@
 #include <linux/slab.h>
 #include <linux/cpu.h>
 
-#include <asm/auxio.h>
 #include <asm/oplib.h>
 #include <linux/uaccess.h>
 #include <asm/page.h>
@@ -52,8 +51,6 @@ void (*sparc_idle)(void);
 
 /* 
  * Power-off handler instantiation for pm.h compliance
- * This is done via auxio, but could be used as a fallback
- * handler when auxio is not present-- unused for now...
  */
 void (*pm_power_off)(void) = machine_power_off;
 EXPORT_SYMBOL(pm_power_off);
@@ -107,13 +104,6 @@ void machine_restart(char * cmd)
 
 void machine_power_off(void)
 {
-	if (auxio_power_register &&
-	    (!of_node_is_type(of_console_device, "serial") || scons_pwroff)) {
-		u8 power_register = sbus_readb(auxio_power_register);
-		power_register |= AUXIO_POWER_OFF;
-		sbus_writeb(power_register, auxio_power_register);
-	}
-
 	machine_halt();
 }
 
diff --git a/arch/sparc/prom/misc_32.c b/arch/sparc/prom/misc_32.c
index 625750924860..78dde6bfbf0f 100644
--- a/arch/sparc/prom/misc_32.c
+++ b/arch/sparc/prom/misc_32.c
@@ -13,7 +13,6 @@
 
 #include <asm/openprom.h>
 #include <asm/oplib.h>
-#include <asm/auxio.h>
 
 extern void restore_current(void);
 
@@ -60,7 +59,6 @@ prom_cmdline(void)
 	(*(romvec->pv_abort))();
 	restore_current();
 	spin_unlock_irqrestore(&prom_lock, flags);
-	set_auxio(AUXIO_LED, 0);
 }
 
 /* Drop into the prom, but completely terminate the program.
-- 
2.27.0
