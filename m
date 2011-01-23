From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 23 Jan 2011 21:41:07 +0000
Subject: [PATCH 4/7] sparc32,sun4m: irq, smp files cleanup
Message-Id: <1295818870-25450-4-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

- drop filename in file header
- drop unused includes
- add description of sun4m interrupts (from davem)
- add KERN_* to printk
- fix spaces => tabs
- add spaces after reserved words
- drop all externs, they are now in header files

This is partly based on a patch from: David Miller <davem@davemloft.net>

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/sun4m_irq.c |  182 +++++++++++++++++++++--------------------
 arch/sparc/kernel/sun4m_smp.c |   91 +++++----------------
 2 files changed, 115 insertions(+), 158 deletions(-)

diff --git a/arch/sparc/kernel/sun4m_irq.c b/arch/sparc/kernel/sun4m_irq.c
index 7f3b97f..3c6657a 100644
--- a/arch/sparc/kernel/sun4m_irq.c
+++ b/arch/sparc/kernel/sun4m_irq.c
@@ -1,5 +1,5 @@
-/*  sun4m_irq.c
- *  arch/sparc/kernel/sun4m_irq.c:
+/*
+ * sun4m irq support
  *
  *  djhr: Hacked out of irq.c into a CPU dependent version.
  *
@@ -9,36 +9,92 @@
  *  Copyright (C) 1996 Dave Redman (djhr@tadpole.co.uk)
  */
 
-#include <linux/errno.h>
-#include <linux/linkage.h>
-#include <linux/kernel_stat.h>
-#include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/ptrace.h>
-#include <linux/smp.h>
-#include <linux/interrupt.h>
-#include <linux/init.h>
-#include <linux/ioport.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
-
-#include <asm/ptrace.h>
-#include <asm/processor.h>
-#include <asm/system.h>
-#include <asm/psr.h>
-#include <asm/vaddrs.h>
 #include <asm/timer.h>
-#include <asm/openprom.h>
-#include <asm/oplib.h>
 #include <asm/traps.h>
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
-#include <asm/smp.h>
 #include <asm/irq.h>
 #include <asm/io.h>
 #include <asm/cacheflush.h>
 
 #include "irq.h"
+#include "kernel.h"
+
+/* Sample sun4m IRQ layout:
+ *
+ * 0x22 - Power
+ * 0x24 - ESP SCSI
+ * 0x26 - Lance ethernet
+ * 0x2b - Floppy
+ * 0x2c - Zilog uart
+ * 0x32 - SBUS level 0
+ * 0x33 - Parallel port, SBUS level 1
+ * 0x35 - SBUS level 2
+ * 0x37 - SBUS level 3
+ * 0x39 - Audio, Graphics card, SBUS level 4
+ * 0x3b - SBUS level 5
+ * 0x3d - SBUS level 6
+ *
+ * Each interrupt source has a mask bit in the interrupt registers.
+ * When the mask bit is set, this blocks interrupt deliver.  So you
+ * clear the bit to enable the interrupt.
+ *
+ * Interrupts numbered less than 0x10 are software triggered interrupts
+ * and unused by Linux.
+ *
+ * Interrupt level assignment on sun4m:
+ *
+ *	level		source
+ * ------------------------------------------------------------
+ *	  1		softint-1
+ *	  2		softint-2, VME/SBUS level 1
+ *	  3		softint-3, VME/SBUS level 2
+ *	  4		softint-4, onboard SCSI
+ *	  5		softint-5, VME/SBUS level 3
+ *	  6		softint-6, onboard ETHERNET
+ *	  7		softint-7, VME/SBUS level 4
+ *	  8		softint-8, onboard VIDEO
+ *	  9		softint-9, VME/SBUS level 5, Module Interrupt
+ *	 10		softint-10, system counter/timer
+ *	 11		softint-11, VME/SBUS level 6, Floppy
+ *	 12		softint-12, Keyboard/Mouse, Serial
+ *	 13		softint-13, VME/SBUS level 7, ISDN Audio
+ *	 14		softint-14, per-processor counter/timer
+ *	 15		softint-15, Asynchronous Errors (broadcast)
+ *
+ * Each interrupt source is masked distinctly in the sun4m interrupt
+ * registers.  The PIL level alone is therefore ambiguous, since multiple
+ * interrupt sources map to a single PIL.
+ *
+ * This ambiguity is resolved in the 'intr' property for device nodes
+ * in the OF device tree.  Each 'intr' property entry is composed of
+ * two 32-bit words.  The first word is the IRQ priority value, which
+ * is what we're intersted in.  The second word is the IRQ vector, which
+ * is unused.
+ *
+ * The low 4 bits of the IRQ priority indicate the PIL, and the upper
+ * 4 bits indicate onboard vs. SBUS leveled vs. VME leveled.  0x20
+ * means onboard, 0x30 means SBUS leveled, and 0x40 means VME leveled.
+ *
+ * For example, an 'intr' IRQ priority value of 0x24 is onboard SCSI
+ * whereas a value of 0x33 is SBUS level 2.  Here are some sample
+ * 'intr' property IRQ priority values from ss4, ss5, ss10, ss20, and
+ * Tadpole S3 GX systems.
+ *
+ * esp:		0x24	onboard ESP SCSI
+ * le:		0x26	onboard Lance ETHERNET
+ * p9100:	0x32	SBUS level 1 P9100 video
+ * bpp:		0x33	SBUS level 2 BPP parallel port device
+ * DBRI:	0x39	SBUS level 5 DBRI ISDN audio
+ * SUNW,leo:	0x39	SBUS level 5 LEO video
+ * pcmcia:	0x3b	SBUS level 6 PCMCIA controller
+ * uctrl:	0x3b	SBUS level 6 UCTRL device
+ * modem:	0x3d	SBUS level 7 MODEM
+ * zs:		0x2c	onboard keyboard/mouse/serial
+ * floppy:	0x2b	onboard Floppy
+ * power:	0x22	onboard power device (XXX unknown mask bit XXX)
+ */
+
 
 struct sun4m_irq_percpu {
 	u32		pending;
@@ -61,9 +117,9 @@ struct sun4m_irq_global __iomem *sun4m_irq_global;
 /* Dave Redman (djhr@tadpole.co.uk)
  * The sun4m interrupt registers.
  */
-#define SUN4M_INT_ENABLE  	0x80000000
-#define SUN4M_INT_E14     	0x00000080
-#define SUN4M_INT_E10     	0x00080000
+#define SUN4M_INT_ENABLE	0x80000000
+#define SUN4M_INT_E14		0x00000080
+#define SUN4M_INT_E10		0x00080000
 
 #define SUN4M_HARD_INT(x)	(0x000000001 << (x))
 #define SUN4M_SOFT_INT(x)	(0x000010000 << (x))
@@ -99,59 +155,6 @@ struct sun4m_irq_global __iomem *sun4m_irq_global;
 #define	OBP_INT_LEVEL_SBUS	0x30
 #define	OBP_INT_LEVEL_VME	0x40
 
-/* Interrupt level assignment on sun4m:
- *
- *	level		source
- * ------------------------------------------------------------
- *        1		softint-1
- *	  2		softint-2, VME/SBUS level 1
- *	  3		softint-3, VME/SBUS level 2
- *	  4		softint-4, onboard SCSI
- *	  5		softint-5, VME/SBUS level 3
- *	  6		softint-6, onboard ETHERNET
- *	  7		softint-7, VME/SBUS level 4
- *	  8		softint-8, onboard VIDEO
- *	  9		softint-9, VME/SBUS level 5, Module Interrupt
- *	 10		softint-10, system counter/timer
- *	 11		softint-11, VME/SBUS level 6, Floppy
- *	 12		softint-12, Keyboard/Mouse, Serial
- *	 13		softint-13, VME/SBUS level 7, ISDN Audio
- *	 14		softint-14, per-processor counter/timer
- *	 15		softint-15, Asynchronous Errors (broadcast)
- *
- * Each interrupt source is masked distinctly in the sun4m interrupt
- * registers.  The PIL level alone is therefore ambiguous, since multiple
- * interrupt sources map to a single PIL.
- *
- * This ambiguity is resolved in the 'intr' property for device nodes
- * in the OF device tree.  Each 'intr' property entry is composed of
- * two 32-bit words.  The first word is the IRQ priority value, which
- * is what we're intersted in.  The second word is the IRQ vector, which
- * is unused.
- *
- * The low 4 bits of the IRQ priority indicate the PIL, and the upper
- * 4 bits indicate onboard vs. SBUS leveled vs. VME leveled.  0x20
- * means onboard, 0x30 means SBUS leveled, and 0x40 means VME leveled.
- *
- * For example, an 'intr' IRQ priority value of 0x24 is onboard SCSI
- * whereas a value of 0x33 is SBUS level 2.  Here are some sample
- * 'intr' property IRQ priority values from ss4, ss5, ss10, ss20, and
- * Tadpole S3 GX systems.
- *
- * esp: 	0x24	onboard ESP SCSI
- * le:  	0x26	onboard Lance ETHERNET
- * p9100:	0x32	SBUS level 1 P9100 video
- * bpp:  	0x33	SBUS level 2 BPP parallel port device
- * DBRI:	0x39	SBUS level 5 DBRI ISDN audio
- * SUNW,leo:	0x39	SBUS level 5 LEO video
- * pcmcia:	0x3b	SBUS level 6 PCMCIA controller
- * uctrl:	0x3b	SBUS level 6 UCTRL device
- * modem:	0x3d	SBUS level 7 MODEM
- * zs:		0x2c	onboard keyboard/mouse/serial
- * floppy:	0x2b	onboard Floppy
- * power:	0x22	onboard power device (XXX unknown mask bit XXX)
- */
-
 static unsigned long irq_mask[0x50] = {
 	/* SMP */
 	0,  SUN4M_SOFT_INT(1),
@@ -193,7 +196,7 @@ static unsigned long irq_mask[0x50] = {
 static unsigned long sun4m_get_irqmask(unsigned int irq)
 {
 	unsigned long mask;
-    
+
 	if (irq < 0x50)
 		mask = irq_mask[irq];
 	else
@@ -217,7 +220,7 @@ static void sun4m_disable_irq(unsigned int irq_nr)
 		sbus_writel(mask, &sun4m_irq_global->mask_set);
 	else
 		sbus_writel(mask, &sun4m_irq_percpu[cpu]->set);
-	local_irq_restore(flags);    
+	local_irq_restore(flags);
 }
 
 static void sun4m_enable_irq(unsigned int irq_nr)
@@ -226,17 +229,17 @@ static void sun4m_enable_irq(unsigned int irq_nr)
 	int cpu = smp_processor_id();
 
 	/* Dreadful floppy hack. When we use 0x2b instead of
-         * 0x0b the system blows (it starts to whistle!).
-         * So we continue to use 0x0b. Fixme ASAP. --P3
-         */
-        if (irq_nr != 0x0b) {
+	 * 0x0b the system blows (it starts to whistle!).
+	 * So we continue to use 0x0b. Fixme ASAP. --P3
+	 */
+	if (irq_nr != 0x0b) {
 		mask = sun4m_get_irqmask(irq_nr);
 		local_irq_save(flags);
 		if (irq_nr > 15)
 			sbus_writel(mask, &sun4m_irq_global->mask_clear);
 		else
 			sbus_writel(mask, &sun4m_irq_percpu[cpu]->clear);
-		local_irq_restore(flags);    
+		local_irq_restore(flags);
 	} else {
 		local_irq_save(flags);
 		sbus_writel(SUN4M_INT_FLOPPY, &sun4m_irq_global->mask_clear);
@@ -260,7 +263,7 @@ static unsigned long cpu_pil_to_imask[16] = {
 /*12*/	SUN4M_INT_SERIAL  | SUN4M_INT_KBDMS,
 /*13*/	SUN4M_INT_SBUS(6) | SUN4M_INT_VME(6) | SUN4M_INT_AUDIO,
 /*14*/	SUN4M_INT_E14,
-/*15*/	SUN4M_INT_ERROR
+/*15*/	SUN4M_INT_ERROR,
 };
 
 /* We assume the caller has disabled local interrupts when these are called,
@@ -280,12 +283,14 @@ static void sun4m_enable_pil_irq(unsigned int pil)
 static void sun4m_send_ipi(int cpu, int level)
 {
 	unsigned long mask = sun4m_get_irqmask(level);
+
 	sbus_writel(mask, &sun4m_irq_percpu[cpu]->set);
 }
 
 static void sun4m_clear_ipi(int cpu, int level)
 {
 	unsigned long mask = sun4m_get_irqmask(level);
+
 	sbus_writel(mask, &sun4m_irq_percpu[cpu]->clear);
 }
 
@@ -314,7 +319,7 @@ struct sun4m_timer_global {
 
 static struct sun4m_timer_global __iomem *timers_global;
 
-#define TIMER_IRQ  	(OBP_INT_LEVEL_ONBOARD | 10)
+#define TIMER_IRQ	(OBP_INT_LEVEL_ONBOARD | 10)
 
 unsigned int lvl14_resolution = (((1000000/HZ) + 1) << 10);
 
@@ -407,7 +412,6 @@ static void __init sun4m_init_timers(irq_handler_t counter_fn)
 #ifdef CONFIG_SMP
 	{
 		unsigned long flags;
-		extern unsigned long lvl14_save[4];
 		struct tt_entry *trap_table = &sparc_ttable[SP_TRAP_IRQ1 + (14 - 1)];
 
 		/* For SMP we use the level 14 ticker, however the bootup code
diff --git a/arch/sparc/kernel/sun4m_smp.c b/arch/sparc/kernel/sun4m_smp.c
index 762d6ee..5cc7dc5 100644
--- a/arch/sparc/kernel/sun4m_smp.c
+++ b/arch/sparc/kernel/sun4m_smp.c
@@ -1,59 +1,22 @@
-/* sun4m_smp.c: Sparc SUN4M SMP support.
+/*
+ *  sun4m SMP support.
  *
  * Copyright (C) 1996 David S. Miller (davem@caip.rutgers.edu)
  */
 
-#include <asm/head.h>
-
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/threads.h>
-#include <linux/smp.h>
 #include <linux/interrupt.h>
-#include <linux/kernel_stat.h>
-#include <linux/init.h>
-#include <linux/spinlock.h>
-#include <linux/mm.h>
-#include <linux/swap.h>
 #include <linux/profile.h>
 #include <linux/delay.h>
 #include <linux/cpu.h>
 
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
-#include <asm/irq_regs.h>
-
-#include <asm/ptrace.h>
-#include <asm/atomic.h>
-
-#include <asm/irq.h>
-#include <asm/page.h>
-#include <asm/pgalloc.h>
-#include <asm/pgtable.h>
-#include <asm/oplib.h>
-#include <asm/cpudata.h>
 
 #include "irq.h"
+#include "kernel.h"
 
 #define IRQ_CROSS_CALL		15
 
-extern ctxd_t *srmmu_ctx_table_phys;
-
-extern volatile unsigned long cpu_callin_map[NR_CPUS];
-extern unsigned char boot_cpu_id;
-
-extern cpumask_t smp_commenced_mask;
-
-extern int __smp4m_processor_id(void);
-
-/*#define SMP_DEBUG*/
-
-#ifdef SMP_DEBUG
-#define SMP_PRINTK(x)	printk x
-#else
-#define SMP_PRINTK(x)
-#endif
-
 static inline unsigned long
 swap_ulong(volatile unsigned long *ptr, unsigned long val)
 {
@@ -64,7 +27,6 @@ swap_ulong(volatile unsigned long *ptr, unsigned long val)
 }
 
 static void smp_setup_percpu_timer(void);
-extern void cpu_probe(void);
 
 void __cpuinit smp4m_callin(void)
 {
@@ -96,7 +58,7 @@ void __cpuinit smp4m_callin(void)
 	/* XXX: What's up with all the flushes? */
 	local_flush_cache_all();
 	local_flush_tlb_all();
-	
+
 	cpu_probe();
 
 	/* Fix idle thread fields. */
@@ -119,9 +81,6 @@ void __cpuinit smp4m_callin(void)
 /*
  *	Cycle through the processors asking the PROM to start each one.
  */
- 
-extern struct linux_prom_registers smp_penguin_ctable;
-
 void __init smp4m_boot_cpus(void)
 {
 	smp_setup_percpu_timer();
@@ -130,7 +89,6 @@ void __init smp4m_boot_cpus(void)
 
 int __cpuinit smp4m_boot_one_cpu(int i)
 {
-	extern unsigned long sun4m_cpu_startup;
 	unsigned long *entry = &sun4m_cpu_startup;
 	struct task_struct *p;
 	int timeout;
@@ -142,7 +100,7 @@ int __cpuinit smp4m_boot_one_cpu(int i)
 	p = fork_idle(i);
 	current_set[i] = task_thread_info(p);
 	/* See trampoline.S for details... */
-	entry += ((i-1) * 3);
+	entry += ((i - 1) * 3);
 
 	/*
 	 * Initialize the contexts table
@@ -154,20 +112,19 @@ int __cpuinit smp4m_boot_one_cpu(int i)
 	smp_penguin_ctable.reg_size = 0;
 
 	/* whirrr, whirrr, whirrrrrrrrr... */
-	printk("Starting CPU %d at %p\n", i, entry);
+	printk(KERN_INFO "Starting CPU %d at %p\n", i, entry);
 	local_flush_cache_all();
-	prom_startcpu(cpu_node,
-		      &smp_penguin_ctable, 0, (char *)entry);
+	prom_startcpu(cpu_node, &smp_penguin_ctable, 0, (char *)entry);
 
 	/* wheee... it's going... */
-	for(timeout = 0; timeout < 10000; timeout++) {
-		if(cpu_callin_map[i])
+	for (timeout = 0; timeout < 10000; timeout++) {
+		if (cpu_callin_map[i])
 			break;
 		udelay(200);
 	}
 
 	if (!(cpu_callin_map[i])) {
-		printk("Processor %d is stuck.\n", i);
+		printk(KERN_ERR "Processor %d is stuck.\n", i);
 		return -ENODEV;
 	}
 
@@ -202,6 +159,7 @@ void __init smp4m_smp_done(void)
 void smp4m_irq_rotate(int cpu)
 {
 	int next = cpu_data(cpu).next;
+
 	if (next != cpu)
 		set_irq_udt(next);
 }
@@ -243,7 +201,7 @@ static void smp4m_cross_call(smpfunc_t func, cpumask_t mask, unsigned long arg1,
 
 			cpu_clear(smp_processor_id(), mask);
 			cpus_and(mask, cpu_online_map, mask);
-			for(i = 0; i < ncpus; i++) {
+			for (i = 0; i < ncpus; i++) {
 				if (cpu_isset(i, mask)) {
 					ccall_info.processors_in[i] = 0;
 					ccall_info.processors_out[i] = 0;
@@ -262,19 +220,18 @@ static void smp4m_cross_call(smpfunc_t func, cpumask_t mask, unsigned long arg1,
 			do {
 				if (!cpu_isset(i, mask))
 					continue;
-				while(!ccall_info.processors_in[i])
+				while (!ccall_info.processors_in[i])
 					barrier();
-			} while(++i < ncpus);
+			} while (++i < ncpus);
 
 			i = 0;
 			do {
 				if (!cpu_isset(i, mask))
 					continue;
-				while(!ccall_info.processors_out[i])
+				while (!ccall_info.processors_out[i])
 					barrier();
-			} while(++i < ncpus);
+			} while (++i < ncpus);
 		}
-
 		spin_unlock_irqrestore(&cross_call_lock, flags);
 }
 
@@ -289,8 +246,6 @@ void smp4m_cross_call_irq(void)
 	ccall_info.processors_out[i] = 1;
 }
 
-extern void sun4m_clear_profile_irq(int cpu);
-
 void smp4m_percpu_timer_interrupt(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs;
@@ -302,7 +257,7 @@ void smp4m_percpu_timer_interrupt(struct pt_regs *regs)
 
 	profile_tick(CPU_PROFILING);
 
-	if(!--prof_counter(cpu)) {
+	if (!--prof_counter(cpu)) {
 		int user = user_mode(regs);
 
 		irq_enter();
@@ -314,8 +269,6 @@ void smp4m_percpu_timer_interrupt(struct pt_regs *regs)
 	set_irq_regs(old_regs);
 }
 
-extern unsigned int lvl14_resolution;
-
 static void __cpuinit smp_setup_percpu_timer(void)
 {
 	int cpu = smp_processor_id();
@@ -323,7 +276,7 @@ static void __cpuinit smp_setup_percpu_timer(void)
 	prof_counter(cpu) = prof_multiplier(cpu) = 1;
 	load_profile_irq(cpu, lvl14_resolution);
 
-	if(cpu = boot_cpu_id)
+	if (cpu = boot_cpu_id)
 		enable_pil_irq(14);
 }
 
@@ -331,9 +284,9 @@ static void __init smp4m_blackbox_id(unsigned *addr)
 {
 	int rd = *addr & 0x3e000000;
 	int rs1 = rd >> 11;
-	
+
 	addr[0] = 0x81580000 | rd;		/* rd %tbr, reg */
-	addr[1] = 0x8130200c | rd | rs1;    	/* srl reg, 0xc, reg */
+	addr[1] = 0x8130200c | rd | rs1;	/* srl reg, 0xc, reg */
 	addr[2] = 0x80082003 | rd | rs1;	/* and reg, 3, reg */
 }
 
@@ -341,9 +294,9 @@ static void __init smp4m_blackbox_current(unsigned *addr)
 {
 	int rd = *addr & 0x3e000000;
 	int rs1 = rd >> 11;
-	
+
 	addr[0] = 0x81580000 | rd;		/* rd %tbr, reg */
-	addr[2] = 0x8130200a | rd | rs1;    	/* srl reg, 0xa, reg */
+	addr[2] = 0x8130200a | rd | rs1;	/* srl reg, 0xa, reg */
 	addr[4] = 0x8008200c | rd | rs1;	/* and reg, 0xc, reg */
 }
 
-- 
1.6.0.6

