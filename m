From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 05 Jan 2011 10:42:39 +0000
Subject: [PATCH] SPARC/LEON: Made sysclk and per-cpu ticker use same timer
Message-Id: <1294224160-7333-1-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This patch makes the per-cpu ticker share the timer with the system clock,
it will save HZ interrupts on the boot CPU and free one timer resource.

The LEON SMP port requires only one timer from now on.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/include/asm/leon.h      |    2 +-
 arch/sparc/include/asm/leon_amba.h |    3 +-
 arch/sparc/kernel/entry.S          |    3 +-
 arch/sparc/kernel/leon_kernel.c    |   45 ++++++++----------------------------
 arch/sparc/kernel/leon_smp.c       |    9 ++++++-
 5 files changed, 23 insertions(+), 39 deletions(-)

diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
index 8580d17..b9df4a9 100644
--- a/arch/sparc/include/asm/leon.h
+++ b/arch/sparc/include/asm/leon.h
@@ -240,7 +240,7 @@ static inline int sparc_leon3_cpuid(void)
 
 #ifdef CONFIG_SMP
 # define LEON3_IRQ_RESCHEDULE		13
-# define LEON3_IRQ_TICKER		(leon_percpu_timer_dev[0].irq)
+# define LEON3_IRQ_TICKER		(leon3_gptimer_irq + leon3_gptimer_idx)
 # define LEON3_IRQ_CROSS_CALL		15
 #endif
 
diff --git a/arch/sparc/include/asm/leon_amba.h b/arch/sparc/include/asm/leon_amba.h
index 263c719..db3f408 100644
--- a/arch/sparc/include/asm/leon_amba.h
+++ b/arch/sparc/include/asm/leon_amba.h
@@ -182,11 +182,12 @@ void _amba_init(struct device_node *dp, struct device_node ***nextp);
 
 extern struct leon3_irqctrl_regs_map *leon3_irqctrl_regs;
 extern struct leon3_gptimer_regs_map *leon3_gptimer_regs;
-extern struct amba_apb_device leon_percpu_timer_dev[16];
 extern int leondebug_irq_disable;
 extern int leon_debug_irqout;
 extern unsigned long leon3_gptimer_irq;
+extern unsigned long leon3_gptimer_idx; /*Timer Index (0..6) within Timer Core*/
 extern unsigned int sparc_leon_eirq;
+extern unsigned long leon3_cpu_idx;
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index 1504df8..d34c180 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -411,8 +411,9 @@ smpleon_ticker:
 	WRITE_PAUSE
 	wr	%g2, PSR_ET, %psr
 	WRITE_PAUSE
+	mov	%l7, %o0		! irq level
 	call	leon_percpu_timer_interrupt
-	 add	%sp, STACKFRAME_SZ, %o0
+	 add	%sp, STACKFRAME_SZ, %o1 ! pt_regs
 	wr	%l0, PSR_ET, %psr
 	WRITE_PAUSE
 	RESTORE_ALL
diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index fdab7f8..81efad1 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -25,7 +25,6 @@
 
 struct leon3_irqctrl_regs_map *leon3_irqctrl_regs; /* interrupt controller base address */
 struct leon3_gptimer_regs_map *leon3_gptimer_regs; /* timer controller base address */
-struct amba_apb_device leon_percpu_timer_dev[16];
 
 int leondebug_irq_disable;
 int leon_debug_irqout;
@@ -34,6 +33,7 @@ static int dummy_master_l10_counter;
 unsigned long leon3_gptimer_irq; /* interrupt controller irq number */
 unsigned long leon3_gptimer_idx; /* Timer Index (0..6) within Timer Core */
 unsigned int sparc_leon_eirq;
+unsigned long leon3_cpu_idx; /* Boot CPU Index */
 #define LEON_IMASK ((&leon3_irqctrl_regs->mask[0]))
 
 /* Return the IRQ of the pending IRQ on the extended IRQ controller */
@@ -109,13 +109,14 @@ void __init leon_init_timers(irq_handler_t counter_fn)
 	struct device_node *rootnp, *np, *nnp;
 	struct property *pp;
 	int len;
-	int cpu, icsel;
+	int icsel;
 	int ampopts;
 
 	leondebug_irq_disable = 0;
 	leon_debug_irqout = 0;
 	master_l10_counter = (unsigned int *)&dummy_master_l10_counter;
 	dummy_master_l10_counter = 0;
+	leon3_cpu_idx = sparc_leon3_cpuid();
 
 	/*Find IRQMP IRQ Controller Registers base address otherwise bail out.*/
 	rootnp = of_find_node_by_path("/ambapp0");
@@ -175,26 +176,11 @@ void __init leon_init_timers(irq_handler_t counter_fn)
 		LEON3_BYPASS_STORE_PA(
 			&leon3_gptimer_regs->e[leon3_gptimer_idx].ctrl, 0);
 
-#ifdef CONFIG_SMP
-		leon_percpu_timer_dev[0].start = (int)leon3_gptimer_regs;
-		leon_percpu_timer_dev[0].irq = leon3_gptimer_irq + 1 +
-					       leon3_gptimer_idx;
-
 		if (!(LEON3_BYPASS_LOAD_PA(&leon3_gptimer_regs->config) &
 		      (1<<LEON3_GPTIMER_SEPIRQ))) {
-			prom_printf("irq timer not configured with separate irqs\n");
-			BUG();
+			printk(KERN_WARNING "GPTIMER use shared irqs, using other timers will fail.\n");
 		}
 
-		LEON3_BYPASS_STORE_PA(
-			&leon3_gptimer_regs->e[leon3_gptimer_idx+1].val, 0);
-		LEON3_BYPASS_STORE_PA(
-			&leon3_gptimer_regs->e[leon3_gptimer_idx+1].rld,
-			(((1000000/HZ) - 1)));
-		LEON3_BYPASS_STORE_PA(
-			&leon3_gptimer_regs->e[leon3_gptimer_idx+1].ctrl, 0);
-# endif
-
 		/*
 		 * The IRQ controller may (if implemented) consist of multiple
 		 * IRQ controllers, each mapped on a 4Kb boundary.
@@ -204,9 +190,9 @@ void __init leon_init_timers(irq_handler_t counter_fn)
 		 * accessed anyway.
 		 * In AMP systems, Linux must run on CPU0 for the time being.
 		 */
-		cpu = sparc_leon3_cpuid();
-		icsel = LEON3_BYPASS_LOAD_PA(&leon3_irqctrl_regs->icsel[cpu/8]);
-		icsel = (icsel >> ((7 - (cpu&0x7)) * 4)) & 0xf;
+		icsel = LEON3_BYPASS_LOAD_PA(
+			&leon3_irqctrl_regs->icsel[leon3_cpu_idx/8]);
+		icsel = (icsel >> ((7 - (leon3_cpu_idx & 0x7)) * 4)) & 0xf;
 		leon3_irqctrl_regs += icsel;
 	} else {
 		goto bad;
@@ -215,7 +201,6 @@ void __init leon_init_timers(irq_handler_t counter_fn)
 	irq = request_irq(leon3_gptimer_irq+leon3_gptimer_idx,
 			  counter_fn,
 			  (IRQF_DISABLED | SA_STATIC_ALLOC), "timer", NULL);
-
 	if (irq) {
 		printk(KERN_ERR "leon_time_init: unable to attach IRQ%d\n",
 		       LEON_INTERRUPT_TIMER1);
@@ -225,7 +210,8 @@ void __init leon_init_timers(irq_handler_t counter_fn)
 # ifdef CONFIG_SMP
 	{
 		unsigned long flags;
-		struct tt_entry *trap_table = &sparc_ttable[SP_TRAP_IRQ1 + (leon_percpu_timer_dev[0].irq - 1)];
+		struct tt_entry *trap_table = &sparc_ttable[SP_TRAP_IRQ1 +
+						(LEON3_IRQ_TICKER - 1)];
 
 		/* For SMP we use the level 14 ticker, however the bootup code
 		 * has copied the firmwares level 14 vector into boot cpu's
@@ -243,21 +229,10 @@ void __init leon_init_timers(irq_handler_t counter_fn)
 	}
 # endif
 
-	if (leon3_gptimer_regs) {
-		LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[leon3_gptimer_idx].ctrl,
+	LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[leon3_gptimer_idx].ctrl,
 				      LEON3_GPTIMER_EN |
 				      LEON3_GPTIMER_RL |
 				      LEON3_GPTIMER_LD | LEON3_GPTIMER_IRQEN);
-
-#ifdef CONFIG_SMP
-		LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[leon3_gptimer_idx+1].ctrl,
-				      LEON3_GPTIMER_EN |
-				      LEON3_GPTIMER_RL |
-				      LEON3_GPTIMER_LD |
-				      LEON3_GPTIMER_IRQEN);
-#endif
-
-	}
 	return;
 bad:
 	printk(KERN_ERR "No Timer/irqctrl found\n");
diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
index 16582d8..b026434 100644
--- a/arch/sparc/kernel/leon_smp.c
+++ b/arch/sparc/kernel/leon_smp.c
@@ -51,6 +51,7 @@ extern volatile unsigned long cpu_callin_map[NR_CPUS];
 extern unsigned char boot_cpu_id;
 extern cpumask_t smp_commenced_mask;
 void __init leon_configure_cache_smp(void);
+extern void handler_irq(int irq, struct pt_regs *regs);
 
 static inline unsigned long do_swap(volatile unsigned long *ptr,
 				    unsigned long val)
@@ -384,11 +385,17 @@ void leon_cross_call_irq(void)
 	ccall_info.processors_out[i] = 1;
 }
 
-void leon_percpu_timer_interrupt(struct pt_regs *regs)
+void leon_percpu_timer_interrupt(int irq, struct pt_regs *regs)
 {
 	struct pt_regs *old_regs;
 	int cpu = smp_processor_id();
 
+	/* For the boot-CPU call the generic IRQ handler, the "per-cpu" ticker
+	 * timer IRQ is the same as the system clock timer (same timer).
+	 */
+	if (cpu = leon3_cpu_idx)
+		handler_irq(irq, regs);
+
 	old_regs = set_irq_regs(regs);
 
 	leon_clear_profile_irq(cpu);
-- 
1.5.4

