From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 23 Jan 2011 21:41:08 +0000
Subject: [PATCH 5/7] sparc32,sun4d: irq, smp files cleanup
Message-Id: <1295818870-25450-5-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

- drop filename in file header
- drop unused includes
- add description of sun4d interrupts (from davem)
- add KERN_* to printk
- fix spaces => tabs
- add spaces after reserved words
- fix indent of a whole code block in smp4d_boot_one_cpu()
  Note: two printk() was updated from debug to KERN_INFO in this code block
- drop all externs, they are now in header files

This is partly based on a patch from: David Miller <davem@davemloft.net>

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/sun4d_irq.c |  195 +++++++++++++++++++++++------------------
 arch/sparc/kernel/sun4d_smp.c |  176 ++++++++++++++-----------------------
 2 files changed, 174 insertions(+), 197 deletions(-)

diff --git a/arch/sparc/kernel/sun4d_irq.c b/arch/sparc/kernel/sun4d_irq.c
index e11b461..14d6253 100644
--- a/arch/sparc/kernel/sun4d_irq.c
+++ b/arch/sparc/kernel/sun4d_irq.c
@@ -1,49 +1,48 @@
 /*
- *  arch/sparc/kernel/sun4d_irq.c:
- *			SS1000/SC2000 interrupt handling.
+ * SS1000/SC2000 interrupt handling.
  *
  *  Copyright (C) 1997,1998 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
  *  Heavily based on arch/sparc/kernel/irq.c.
  */
 
-#include <linux/errno.h>
-#include <linux/linkage.h>
 #include <linux/kernel_stat.h>
-#include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/ptrace.h>
-#include <linux/interrupt.h>
-#include <linux/slab.h>
-#include <linux/random.h>
-#include <linux/init.h>
-#include <linux/smp.h>
-#include <linux/spinlock.h>
 #include <linux/seq_file.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
-
-#include <asm/ptrace.h>
-#include <asm/processor.h>
-#include <asm/system.h>
-#include <asm/psr.h>
-#include <asm/smp.h>
-#include <asm/vaddrs.h>
+
 #include <asm/timer.h>
-#include <asm/openprom.h>
-#include <asm/oplib.h>
 #include <asm/traps.h>
 #include <asm/irq.h>
 #include <asm/io.h>
-#include <asm/pgalloc.h>
-#include <asm/pgtable.h>
 #include <asm/sbi.h>
 #include <asm/cacheflush.h>
-#include <asm/irq_regs.h>
 
 #include "kernel.h"
 #include "irq.h"
 
-/* If you trust current SCSI layer to handle different SCSI IRQs, enable this. I don't trust it... -jj */
+/* Sun4d interrupts fall roughly into two categories.  SBUS and
+ * cpu local.  CPU local interrupts cover the timer interrupts
+ * and whatnot, and we encode those as normal PILs between
+ * 0 and 15.
+ *
+ * SBUS interrupts are encoded integers including the board number
+ * (plus one), the SBUS level, and the SBUS slot number.  Sun4D
+ * IRQ dispatch is done by:
+ *
+ * 1) Reading the BW local interrupt table in order to get the bus
+ *    interrupt mask.
+ *
+ *    This table is indexed by SBUS interrupt level which can be
+ *    derived from the PIL we got interrupted on.
+ *
+ * 2) For each bus showing interrupt pending from #1, read the
+ *    SBI interrupt state register.  This will indicate which slots
+ *    have interrupts pending for that SBUS interrupt level.
+ */
+
+/*
+ * If you trust current SCSI layer to handle different
+ * SCSI IRQs, enable this.
+ * I don't trust it... -jj
+ */
 /* #define DISTRIBUTE_IRQS */
 
 struct sun4d_timer_regs {
@@ -59,11 +58,9 @@ static struct sun4d_timer_regs __iomem *sun4d_timers;
 #define TIMER_IRQ	10
 
 #define MAX_STATIC_ALLOC	4
-extern int static_irq_count;
 static unsigned char sbus_tid[32];
 
 static struct irqaction *irq_action[NR_IRQS];
-extern spinlock_t irq_action_lock;
 
 static struct sbus_action {
 	struct irqaction *action;
@@ -71,11 +68,33 @@ static struct sbus_action {
 } *sbus_actions;
 
 static int pil_to_sbus[] = {
-	0, 0, 1, 2, 0, 3, 0, 4, 0, 5, 0, 6, 0, 7, 0, 0,
+	0,
+	0,
+	1,
+	2,
+	0,
+	3,
+	0,
+	4,
+	0,
+	5,
+	0,
+	6,
+	0,
+	7,
+	0,
+	0,
 };
 
 static int sbus_to_pil[] = {
-	0, 2, 3, 5, 7, 9, 11, 13,
+	0,
+	2,
+	3,
+	5,
+	7,
+	9,
+	11,
+	13,
 };
 
 static int nsbi;
@@ -86,7 +105,7 @@ DEFINE_SPINLOCK(sun4d_imsk_lock);
 int show_sun4d_interrupts(struct seq_file *p, void *v)
 {
 	int i = *(loff_t *) v, j = 0, k = 0, sbusl;
-	struct irqaction * action;
+	struct irqaction *action;
 	unsigned long flags;
 #ifdef CONFIG_SMP
 	int x;
@@ -96,13 +115,14 @@ int show_sun4d_interrupts(struct seq_file *p, void *v)
 	if (i < NR_IRQS) {
 		sbusl = pil_to_sbus[i];
 		if (!sbusl) {
-	 		action = *(i + irq_action);
-			if (!action) 
-		        	goto out_unlock;
+			action = *(i + irq_action);
+			if (!action)
+				goto out_unlock;
 		} else {
 			for (j = 0; j < nsbi; j++) {
 				for (k = 0; k < 4; k++)
-					if ((action = sbus_actions [(j << 5) + (sbusl << 2) + k].action))
+					action = sbus_actions[(j << 5) + (sbusl << 2) + k].action;
+					if (action)
 						goto found_it;
 			}
 			goto out_unlock;
@@ -125,15 +145,17 @@ found_it:	seq_printf(p, "%3d: ", i);
 					(action->flags & IRQF_DISABLED) ? " +" : "",
 					action->name);
 			}
-			if (!sbusl) break;
+			if (!sbusl)
+				break;
 			k++;
-			if (k < 4)
-				action = sbus_actions [(j << 5) + (sbusl << 2) + k].action;
-			else {
+			if (k < 4) {
+				action = sbus_actions[(j << 5) + (sbusl << 2) + k].action;
+			} else {
 				j++;
-				if (j = nsbi) break;
+				if (j = nsbi)
+					break;
 				k = 0;
-				action = sbus_actions [(j << 5) + (sbusl << 2)].action;
+				action = sbus_actions[(j << 5) + (sbusl << 2)].action;
 			}
 		}
 		seq_putc(p, '\n');
@@ -147,7 +169,7 @@ void sun4d_free_irq(unsigned int irq, void *dev_id)
 {
 	struct irqaction *action, **actionp;
 	struct irqaction *tmp = NULL;
-        unsigned long flags;
+	unsigned long flags;
 
 	spin_lock_irqsave(&irq_action_lock, flags);
 	if (irq < 15)
@@ -156,7 +178,7 @@ void sun4d_free_irq(unsigned int irq, void *dev_id)
 		actionp = &(sbus_actions[irq - (1 << 5)].action);
 	action = *actionp;
 	if (!action) {
-		printk("Trying to free free IRQ%d\n",irq);
+		printk(KERN_ERR "Trying to free free IRQ%d\n", irq);
 		goto out_unlock;
 	}
 	if (dev_id) {
@@ -166,23 +188,25 @@ void sun4d_free_irq(unsigned int irq, void *dev_id)
 			tmp = action;
 		}
 		if (!action) {
-			printk("Trying to free free shared IRQ%d\n",irq);
+			printk(KERN_ERR "Trying to free free shared IRQ%d\n",
+			       irq);
 			goto out_unlock;
 		}
 	} else if (action->flags & IRQF_SHARED) {
-		printk("Trying to free shared IRQ%d with NULL device ID\n", irq);
+		printk(KERN_ERR "Trying to free shared IRQ%d with NULL device ID\n",
+		       irq);
 		goto out_unlock;
 	}
-	if (action->flags & SA_STATIC_ALLOC)
-	{
-		/* This interrupt is marked as specially allocated
+	if (action->flags & SA_STATIC_ALLOC) {
+		/*
+		 * This interrupt is marked as specially allocated
 		 * so it is a bad idea to free it.
 		 */
-		printk("Attempt to free statically allocated IRQ%d (%s)\n",
+		printk(KERN_ERR "Attempt to free statically allocated IRQ%d (%s)\n",
 		       irq, action->name);
 		goto out_unlock;
 	}
-	
+
 	if (tmp)
 		tmp->next = action->next;
 	else
@@ -203,21 +227,19 @@ out_unlock:
 	spin_unlock_irqrestore(&irq_action_lock, flags);
 }
 
-extern void unexpected_irq(int, void *, struct pt_regs *);
-
-void sun4d_handler_irq(int irq, struct pt_regs * regs)
+void sun4d_handler_irq(int irq, struct pt_regs *regs)
 {
 	struct pt_regs *old_regs;
-	struct irqaction * action;
+	struct irqaction *action;
 	int cpu = smp_processor_id();
 	/* SBUS IRQ level (1 - 7) */
 	int sbusl = pil_to_sbus[irq];
-	
+
 	/* FIXME: Is this necessary?? */
 	cc_get_ipen();
-	
+
 	cc_set_iclr(1 << irq);
-	
+
 	old_regs = set_irq_regs(regs);
 	irq_enter();
 	kstat_cpu(cpu).irqs[irq]++;
@@ -235,9 +257,9 @@ void sun4d_handler_irq(int irq, struct pt_regs * regs)
 		struct sbus_action *actionp;
 		unsigned mask, slot;
 		int sbil = (sbusl << 2);
-		
+
 		bw_clear_intr_mask(sbusl, bus_mask);
-		
+
 		/* Loop for each pending SBI */
 		for (sbino = 0; bus_mask; sbino++, bus_mask >>= 1)
 			if (bus_mask & 1) {
@@ -249,7 +271,7 @@ void sun4d_handler_irq(int irq, struct pt_regs * regs)
 					if (mask & slot) {
 						mask &= ~slot;
 						action = actionp->action;
-						
+
 						if (!action)
 							unexpected_irq(irq, NULL, regs);
 						do {
@@ -266,13 +288,13 @@ void sun4d_handler_irq(int irq, struct pt_regs * regs)
 
 int sun4d_request_irq(unsigned int irq,
 		irq_handler_t handler,
-		unsigned long irqflags, const char * devname, void *dev_id)
+		unsigned long irqflags, const char *devname, void *dev_id)
 {
 	struct irqaction *action, *tmp = NULL, **actionp;
 	unsigned long flags;
 	int ret;
-	
-	if(irq > 14 && irq < (1 << 5)) {
+
+	if (irq > 14 && irq < (1 << 5)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -289,7 +311,7 @@ int sun4d_request_irq(unsigned int irq,
 	else
 		actionp = irq + irq_action;
 	action = *actionp;
-	
+
 	if (action) {
 		if ((action->flags & IRQF_SHARED) && (irqflags & IRQF_SHARED)) {
 			for (tmp = action; tmp->next; tmp = tmp->next);
@@ -298,7 +320,8 @@ int sun4d_request_irq(unsigned int irq,
 			goto out_unlock;
 		}
 		if ((action->flags & IRQF_DISABLED) ^ (irqflags & IRQF_DISABLED)) {
-			printk("Attempt to mix fast and slow interrupts on IRQ%d denied\n", irq);
+			printk(KERN_ERR "Attempt to mix fast and slow interrupts on IRQ%d denied\n",
+			       irq);
 			ret = -EBUSY;
 			goto out_unlock;
 		}
@@ -312,14 +335,14 @@ int sun4d_request_irq(unsigned int irq,
 		if (static_irq_count < MAX_STATIC_ALLOC)
 			action = &static_irqaction[static_irq_count++];
 		else
-			printk("Request for IRQ%d (%s) SA_STATIC_ALLOC failed using kmalloc\n", irq, devname);
+			printk(KERN_ERR "Request for IRQ%d (%s) SA_STATIC_ALLOC failed using kmalloc\n",
+			       irq, devname);
 	}
-	
+
 	if (action = NULL)
-		action = kmalloc(sizeof(struct irqaction),
-						     GFP_ATOMIC);
-	
-	if (!action) { 
+		action = kmalloc(sizeof(struct irqaction), GFP_ATOMIC);
+
+	if (!action) {
 		ret = -ENOMEM;
 		goto out_unlock;
 	}
@@ -334,7 +357,7 @@ int sun4d_request_irq(unsigned int irq,
 		tmp->next = action;
 	else
 		*actionp = action;
-		
+
 	__enable_irq(irq);
 
 	ret = 0;
@@ -348,7 +371,7 @@ static void sun4d_disable_irq(unsigned int irq)
 {
 	int tid = sbus_tid[(irq >> 5) - 1];
 	unsigned long flags;
-	
+
 	if (irq < NR_IRQS)
 		return;
 
@@ -361,7 +384,7 @@ static void sun4d_enable_irq(unsigned int irq)
 {
 	int tid = sbus_tid[(irq >> 5) - 1];
 	unsigned long flags;
-	
+
 	if (irq < NR_IRQS)
 		return;
 
@@ -411,7 +434,7 @@ void __init sun4d_distribute_irqs(void)
 		int board = of_getintprop_default(dp, "board#", 0);
 		if (sbus_tid[board] = 0xff) {
 			int i = 31;
-				
+
 			if (cpus_empty(sbus_serving_map))
 				sbus_serving_map = cpu_present_map;
 			while (cpu_isset(i, sbus_serving_map))
@@ -423,7 +446,8 @@ void __init sun4d_distribute_irqs(void)
 	for_each_node_by_name(dp, "sbi") {
 		int devid = of_getintprop_default(dp, "device-id", 0);
 		int board = of_getintprop_default(dp, "board#", 0);
-		printk("sbus%d IRQs directed to CPU%d\n", board, sbus_tid[board]);
+		printk(KERN_ERR "sbus%d IRQs directed to CPU%d\n",
+		       board, sbus_tid[board]);
 		set_sbi_tid(devid, sbus_tid[board] << 3);
 	}
 #else
@@ -437,11 +461,11 @@ void __init sun4d_distribute_irqs(void)
 		sbus_tid[board] = cpuid;
 		set_sbi_tid(devid, cpuid << 3);
 	}
-	printk("All sbus IRQs directed to CPU%d\n", cpuid);
+	printk(KERN_ERR "All sbus IRQs directed to CPU%d\n", cpuid);
 #endif
 }
 #endif
- 
+
 static void sun4d_clear_clock_irq(void)
 {
 	sbus_readl(&sun4d_timers->l10_timer_limit);
@@ -466,10 +490,7 @@ static void __init sun4d_fixup_trap_table(void)
 {
 #ifdef CONFIG_SMP
 	unsigned long flags;
-	extern unsigned long lvl14_save[4];
 	struct tt_entry *trap_table = &sparc_ttable[SP_TRAP_IRQ1 + (14 - 1)];
-	extern unsigned int real_irq_entry[], smp4d_ticker[];
-	extern unsigned int patchme_maybe_smp_msg[];
 
 	/* Adjust so that we jump directly to smp4d_ticker */
 	lvl14_save[2] += smp4d_ticker - real_irq_entry;
@@ -531,7 +552,8 @@ static void __init sun4d_init_timers(irq_handler_t counter_fn)
 			  (IRQF_DISABLED | SA_STATIC_ALLOC),
 			  "timer", NULL);
 	if (err) {
-		prom_printf("sun4d_init_timers: request_irq() failed with %d\n", err);
+		prom_printf("sun4d_init_timers: request_irq() failed with %d\n",
+		             err);
 		prom_halt();
 	}
 	sun4d_load_profile_irqs();
@@ -550,7 +572,7 @@ void __init sun4d_init_sbi_irq(void)
 	nsbi = 0;
 	for_each_node_by_name(dp, "sbi")
 		nsbi++;
-	sbus_actions = kzalloc (nsbi * 8 * 4 * sizeof(struct sbus_action), GFP_ATOMIC);
+	sbus_actions = kzalloc(nsbi * 8 * 4 * sizeof(struct sbus_action), GFP_ATOMIC);
 	if (!sbus_actions) {
 		prom_printf("SUN4D: Cannot allocate sbus_actions, halting.\n");
 		prom_halt();
@@ -566,7 +588,8 @@ void __init sun4d_init_sbi_irq(void)
 		/* Get rid of pending irqs from PROM */
 		mask = acquire_sbi(devid, 0xffffffff);
 		if (mask) {
-			printk ("Clearing pending IRQs %08x on SBI %d\n", mask, board);
+			printk(KERN_ERR "Clearing pending IRQs %08x on SBI %d\n",
+			       mask, board);
 			release_sbi(devid, mask);
 		}
 	}
diff --git a/arch/sparc/kernel/sun4d_smp.c b/arch/sparc/kernel/sun4d_smp.c
index 482f2ab..475d50b 100644
--- a/arch/sparc/kernel/sun4d_smp.c
+++ b/arch/sparc/kernel/sun4d_smp.c
@@ -1,4 +1,4 @@
-/* sun4d_smp.c: Sparc SS1000/SC2000 SMP support.
+/* Sparc SS1000/SC2000 SMP support.
  *
  * Copyright (C) 1998 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
  *
@@ -6,59 +6,23 @@
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
 
-#include <asm/ptrace.h>
-#include <asm/atomic.h>
-#include <asm/irq_regs.h>
-
-#include <asm/irq.h>
-#include <asm/page.h>
-#include <asm/pgalloc.h>
-#include <asm/pgtable.h>
-#include <asm/oplib.h>
 #include <asm/sbi.h>
+#include <asm/mmu.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
-#include <asm/cpudata.h>
 
+#include "kernel.h"
 #include "irq.h"
-#define IRQ_CROSS_CALL		15
 
-extern ctxd_t *srmmu_ctx_table_phys;
+#define IRQ_CROSS_CALL		15
 
-static volatile int smp_processors_ready = 0;
+static volatile int smp_processors_ready;
 static int smp_highest_cpu;
-extern volatile unsigned long cpu_callin_map[NR_CPUS];
-extern cpuinfo_sparc cpu_data[NR_CPUS];
-extern unsigned char boot_cpu_id;
-extern volatile int smp_process_available;
-
-extern cpumask_t smp_commenced_mask;
-
-extern int __smp4d_processor_id(void);
-
-/* #define SMP_DEBUG */
-
-#ifdef SMP_DEBUG
-#define SMP_PRINTK(x)	printk x
-#else
-#define SMP_PRINTK(x)
-#endif
 
 static inline unsigned long sun4d_swap(volatile unsigned long *ptr, unsigned long val)
 {
@@ -69,8 +33,6 @@ static inline unsigned long sun4d_swap(volatile unsigned long *ptr, unsigned lon
 }
 
 static void smp_setup_percpu_timer(void);
-extern void cpu_probe(void);
-extern void sun4d_distribute_irqs(void);
 
 static unsigned char cpu_leds[32];
 
@@ -86,9 +48,8 @@ static inline void show_leds(int cpuid)
 void __cpuinit smp4d_callin(void)
 {
 	int cpuid = hard_smp4d_processor_id();
-	extern spinlock_t sun4d_imsk_lock;
 	unsigned long flags;
-	
+
 	/* Show we are alive */
 	cpu_leds[cpuid] = 0x6;
 	show_leds(cpuid);
@@ -118,15 +79,15 @@ void __cpuinit smp4d_callin(void)
 	sun4d_swap((unsigned long *)&cpu_callin_map[cpuid], 1);
 	local_flush_cache_all();
 	local_flush_tlb_all();
-	
+
 	cpu_probe();
 
-	while((unsigned long)current_set[cpuid] < PAGE_OFFSET)
+	while ((unsigned long)current_set[cpuid] < PAGE_OFFSET)
 		barrier();
-		
-	while(current_set[cpuid]->cpu != cpuid)
+
+	while (current_set[cpuid]->cpu != cpuid)
 		barrier();
-		
+
 	/* Fix idle thread fields. */
 	__asm__ __volatile__("ld [%0], %%g6\n\t"
 			     : : "r" (&current_set[cpuid])
@@ -134,16 +95,16 @@ void __cpuinit smp4d_callin(void)
 
 	cpu_leds[cpuid] = 0x9;
 	show_leds(cpuid);
-	
+
 	/* Attach to the address space of init_task. */
 	atomic_inc(&init_mm.mm_count);
 	current->active_mm = &init_mm;
 
 	local_flush_cache_all();
 	local_flush_tlb_all();
-	
+
 	local_irq_enable();	/* We don't allow PIL 14 yet */
-	
+
 	while (!cpu_isset(cpuid, smp_commenced_mask))
 		barrier();
 
@@ -154,15 +115,9 @@ void __cpuinit smp4d_callin(void)
 
 }
 
-extern void init_IRQ(void);
-extern void cpu_panic(void);
-
 /*
  *	Cycle through the processors asking the PROM to start each one.
  */
- 
-extern struct linux_prom_registers smp_penguin_ctable;
-
 void __init smp4d_boot_cpus(void)
 {
 	if (boot_cpu_id)
@@ -173,43 +128,42 @@ void __init smp4d_boot_cpus(void)
 
 int __cpuinit smp4d_boot_one_cpu(int i)
 {
-			extern unsigned long sun4d_cpu_startup;
-			unsigned long *entry = &sun4d_cpu_startup;
-			struct task_struct *p;
-			int timeout;
-			int cpu_node;
+	unsigned long *entry = &sun4d_cpu_startup;
+	struct task_struct *p;
+	int timeout;
+	int cpu_node;
 
-			cpu_find_by_instance(i, &cpu_node,NULL);
-			/* Cook up an idler for this guy. */
-			p = fork_idle(i);
-			current_set[i] = task_thread_info(p);
+	cpu_find_by_instance(i, &cpu_node, NULL);
+	/* Cook up an idler for this guy. */
+	p = fork_idle(i);
+	current_set[i] = task_thread_info(p);
+
+	/*
+	 * Initialize the contexts table
+	 * Since the call to prom_startcpu() trashes the structure,
+	 * we need to re-initialize it for each cpu
+	 */
+	smp_penguin_ctable.which_io = 0;
+	smp_penguin_ctable.phys_addr = (unsigned int) srmmu_ctx_table_phys;
+	smp_penguin_ctable.reg_size = 0;
+
+	/* whirrr, whirrr, whirrrrrrrrr... */
+	printk(KERN_INFO "Starting CPU %d at %p\n", i, entry);
+	local_flush_cache_all();
+	prom_startcpu(cpu_node,
+		      &smp_penguin_ctable, 0, (char *)entry);
+
+	printk(KERN_INFO "prom_startcpu returned :)\n");
+
+	/* wheee... it's going... */
+	for (timeout = 0; timeout < 10000; timeout++) {
+		if (cpu_callin_map[i])
+			break;
+		udelay(200);
+	}
 
-			/*
-			 * Initialize the contexts table
-			 * Since the call to prom_startcpu() trashes the structure,
-			 * we need to re-initialize it for each cpu
-			 */
-			smp_penguin_ctable.which_io = 0;
-			smp_penguin_ctable.phys_addr = (unsigned int) srmmu_ctx_table_phys;
-			smp_penguin_ctable.reg_size = 0;
-
-			/* whirrr, whirrr, whirrrrrrrrr... */
-			SMP_PRINTK(("Starting CPU %d at %p\n", i, entry));
-			local_flush_cache_all();
-			prom_startcpu(cpu_node,
-				      &smp_penguin_ctable, 0, (char *)entry);
-				      
-			SMP_PRINTK(("prom_startcpu returned :)\n"));
-
-			/* wheee... it's going... */
-			for(timeout = 0; timeout < 10000; timeout++) {
-				if(cpu_callin_map[i])
-					break;
-				udelay(200);
-			}
-			
 	if (!(cpu_callin_map[i])) {
-		printk("Processor %d is stuck.\n", i);
+		printk(KERN_ERR "Processor %d is stuck.\n", i);
 		return -ENODEV;
 
 	}
@@ -255,14 +209,17 @@ static void smp4d_cross_call(smpfunc_t func, cpumask_t mask, unsigned long arg1,
 			     unsigned long arg2, unsigned long arg3,
 			     unsigned long arg4)
 {
-	if(smp_processors_ready) {
+	if (smp_processors_ready) {
 		register int high = smp_highest_cpu;
 		unsigned long flags;
 
 		spin_lock_irqsave(&cross_call_lock, flags);
 
 		{
-			/* If you make changes here, make sure gcc generates proper code... */
+			/*
+			 * If you make changes here, make sure
+			 * gcc generates proper code...
+			 */
 			register smpfunc_t f asm("i0") = func;
 			register unsigned long a1 asm("i1") = arg1;
 			register unsigned long a2 asm("i2") = arg2;
@@ -284,7 +241,7 @@ static void smp4d_cross_call(smpfunc_t func, cpumask_t mask, unsigned long arg1,
 
 			cpu_clear(smp_processor_id(), mask);
 			cpus_and(mask, cpu_online_map, mask);
-			for(i = 0; i <= high; i++) {
+			for (i = 0; i <= high; i++) {
 				if (cpu_isset(i, mask)) {
 					ccall_info.processors_in[i] = 0;
 					ccall_info.processors_out[i] = 0;
@@ -300,17 +257,17 @@ static void smp4d_cross_call(smpfunc_t func, cpumask_t mask, unsigned long arg1,
 			do {
 				if (!cpu_isset(i, mask))
 					continue;
-				while(!ccall_info.processors_in[i])
+				while (!ccall_info.processors_in[i])
 					barrier();
-			} while(++i <= high);
+			} while (++i <= high);
 
 			i = 0;
 			do {
 				if (!cpu_isset(i, mask))
 					continue;
-				while(!ccall_info.processors_out[i])
+				while (!ccall_info.processors_out[i])
 					barrier();
-			} while(++i <= high);
+			} while (++i <= high);
 		}
 
 		spin_unlock_irqrestore(&cross_call_lock, flags);
@@ -336,7 +293,7 @@ void smp4d_percpu_timer_interrupt(struct pt_regs *regs)
 	static char led_mask[] = { 0xe, 0xd, 0xb, 0x7, 0xb, 0xd };
 
 	old_regs = set_irq_regs(regs);
-	bw_get_prof_limit(cpu);	
+	bw_get_prof_limit(cpu);
 	bw_clear_intr_mask(0, 1);	/* INTR_TABLE[0] & 1 is Profile IRQ */
 
 	cpu_tick[cpu]++;
@@ -349,7 +306,7 @@ void smp4d_percpu_timer_interrupt(struct pt_regs *regs)
 
 	profile_tick(CPU_PROFILING);
 
-	if(!--prof_counter(cpu)) {
+	if (!--prof_counter(cpu)) {
 		int user = user_mode(regs);
 
 		irq_enter();
@@ -361,8 +318,6 @@ void smp4d_percpu_timer_interrupt(struct pt_regs *regs)
 	set_irq_regs(old_regs);
 }
 
-extern unsigned int lvl14_resolution;
-
 static void __cpuinit smp_setup_percpu_timer(void)
 {
 	int cpu = hard_smp4d_processor_id();
@@ -374,16 +329,16 @@ static void __cpuinit smp_setup_percpu_timer(void)
 void __init smp4d_blackbox_id(unsigned *addr)
 {
 	int rd = *addr & 0x3e000000;
-	
+
 	addr[0] = 0xc0800800 | rd;		/* lda [%g0] ASI_M_VIKING_TMP1, reg */
-	addr[1] = 0x01000000;    		/* nop */
-	addr[2] = 0x01000000;    		/* nop */
+	addr[1] = 0x01000000;			/* nop */
+	addr[2] = 0x01000000;			/* nop */
 }
 
 void __init smp4d_blackbox_current(unsigned *addr)
 {
 	int rd = *addr & 0x3e000000;
-	
+
 	addr[0] = 0xc0800800 | rd;		/* lda [%g0] ASI_M_VIKING_TMP1, reg */
 	addr[2] = 0x81282002 | rd | (rd >> 11);	/* sll reg, 2, reg */
 	addr[4] = 0x01000000;			/* nop */
@@ -392,17 +347,16 @@ void __init smp4d_blackbox_current(unsigned *addr)
 void __init sun4d_init_smp(void)
 {
 	int i;
-	extern unsigned int t_nmi[], linux_trap_ipi15_sun4d[], linux_trap_ipi15_sun4m[];
 
 	/* Patch ipi15 trap table */
 	t_nmi[1] = t_nmi[1] + (linux_trap_ipi15_sun4d - linux_trap_ipi15_sun4m);
-	
+
 	/* And set btfixup... */
 	BTFIXUPSET_BLACKBOX(hard_smp_processor_id, smp4d_blackbox_id);
 	BTFIXUPSET_BLACKBOX(load_current, smp4d_blackbox_current);
 	BTFIXUPSET_CALL(smp_cross_call, smp4d_cross_call, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(__hard_smp_processor_id, __smp4d_processor_id, BTFIXUPCALL_NORM);
-	
+
 	for (i = 0; i < NR_CPUS; i++) {
 		ccall_info.processors_in[i] = 1;
 		ccall_info.processors_out[i] = 1;
-- 
1.6.0.6

