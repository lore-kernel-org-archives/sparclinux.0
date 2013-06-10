From: Andreas Larsson <andreas@gaisler.com>
Date: Mon, 10 Jun 2013 06:53:28 +0000
Subject: [PATCH] sparc32, leon: Remove separate "ticker" timer for SMP
Message-Id: <1370847208-20597-1-git-send-email-andreas@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This reduces the need from two timers to one timer.

Moreover, without this patch, when the "ticker" timer triggers timer_cs_read via
tick_periodic it reads the value of the usual timer it can get an wrapped timer
value without timer_cs_internal_counter having been updated leading to the clock
going backwards. This effectively hangs one cpu that gets stuck in
update_wall_time with an offset slightly smaller than 0xffffffffffffffff.

Signed-off-by: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/include/asm/leon.h      |    2 +-
 arch/sparc/include/asm/leon_amba.h |    1 +
 arch/sparc/kernel/leon_kernel.c    |   54 ++++++++++++------------------------
 3 files changed, 19 insertions(+), 38 deletions(-)

diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
index 15a7169..b836e92 100644
--- a/arch/sparc/include/asm/leon.h
+++ b/arch/sparc/include/asm/leon.h
@@ -135,7 +135,7 @@ static inline int sparc_leon3_cpuid(void)
 
 #ifdef CONFIG_SMP
 # define LEON3_IRQ_IPI_DEFAULT		13
-# define LEON3_IRQ_TICKER		(leon3_ticker_irq)
+# define LEON3_IRQ_TICKER		(leon3_gptimer_irq)
 # define LEON3_IRQ_CROSS_CALL		15
 #endif
 
diff --git a/arch/sparc/include/asm/leon_amba.h b/arch/sparc/include/asm/leon_amba.h
index f3034ed..24ec48c 100644
--- a/arch/sparc/include/asm/leon_amba.h
+++ b/arch/sparc/include/asm/leon_amba.h
@@ -47,6 +47,7 @@ struct amba_prom_registers {
 #define LEON3_GPTIMER_LD 4
 #define LEON3_GPTIMER_IRQEN 8
 #define LEON3_GPTIMER_SEPIRQ 8
+#define LEON3_GPTIMER_TIMERS 0x7
 
 #define LEON23_REG_TIMER_CONTROL_EN    0x00000001 /* 1 = enable counting */
 /* 0 = hold scalar and counter */
diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index 7c0231d..b7c6897 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -38,7 +38,6 @@ static DEFINE_SPINLOCK(leon_irq_lock);
 
 unsigned long leon3_gptimer_irq; /* interrupt controller irq number */
 unsigned long leon3_gptimer_idx; /* Timer Index (0..6) within Timer Core */
-int leon3_ticker_irq; /* Timer ticker IRQ */
 unsigned int sparc_leon_eirq;
 #define LEON_IMASK(cpu) (&leon3_irqctrl_regs->mask[cpu])
 #define LEON_IACK (&leon3_irqctrl_regs->iclear)
@@ -278,6 +277,9 @@ irqreturn_t leon_percpu_timer_ce_interrupt(int irq, void *unused)
 
 	leon_clear_profile_irq(cpu);
 
+	if (cpu = boot_cpu_id)
+		timer_interrupt(irq, NULL);
+
 	ce = &per_cpu(sparc32_clockevent, cpu);
 
 	irq_enter();
@@ -299,6 +301,7 @@ void __init leon_init_timers(void)
 	int icsel;
 	int ampopts;
 	int err;
+	u32 config;
 
 	sparc_config.get_cycles_offset = leon_cycles_offset;
 	sparc_config.cs_period = 1000000 / HZ;
@@ -377,23 +380,6 @@ void __init leon_init_timers(void)
 	LEON3_BYPASS_STORE_PA(
 			&leon3_gptimer_regs->e[leon3_gptimer_idx].ctrl, 0);
 
-#ifdef CONFIG_SMP
-	leon3_ticker_irq = leon3_gptimer_irq + 1 + leon3_gptimer_idx;
-
-	if (!(LEON3_BYPASS_LOAD_PA(&leon3_gptimer_regs->config) &
-	      (1<<LEON3_GPTIMER_SEPIRQ))) {
-		printk(KERN_ERR "timer not configured with separate irqs\n");
-		BUG();
-	}
-
-	LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[leon3_gptimer_idx+1].val,
-				0);
-	LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[leon3_gptimer_idx+1].rld,
-				(((1000000/HZ) - 1)));
-	LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[leon3_gptimer_idx+1].ctrl,
-				0);
-#endif
-
 	/*
 	 * The IRQ controller may (if implemented) consist of multiple
 	 * IRQ controllers, each mapped on a 4Kb boundary.
@@ -416,13 +402,6 @@ void __init leon_init_timers(void)
 	if (eirq != 0)
 		leon_eirq_setup(eirq);
 
-	irq = _leon_build_device_irq(NULL, leon3_gptimer_irq+leon3_gptimer_idx);
-	err = request_irq(irq, timer_interrupt, IRQF_TIMER, "timer", NULL);
-	if (err) {
-		printk(KERN_ERR "unable to attach timer IRQ%d\n", irq);
-		prom_halt();
-	}
-
 #ifdef CONFIG_SMP
 	{
 		unsigned long flags;
@@ -439,30 +418,31 @@ void __init leon_init_timers(void)
 	}
 #endif
 
-	LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[leon3_gptimer_idx].ctrl,
-			      LEON3_GPTIMER_EN |
-			      LEON3_GPTIMER_RL |
-			      LEON3_GPTIMER_LD |
-			      LEON3_GPTIMER_IRQEN);
+	config = LEON3_BYPASS_LOAD_PA(&leon3_gptimer_regs->config);
+	if (config & (1 << LEON3_GPTIMER_SEPIRQ))
+		leon3_gptimer_irq += leon3_gptimer_idx;
+	else if ((config & LEON3_GPTIMER_TIMERS) > 1)
+		pr_warn("GPTIMER uses shared irqs, using other timers of the same core will fail.\n");
 
 #ifdef CONFIG_SMP
 	/* Install per-cpu IRQ handler for broadcasted ticker */
-	irq = leon_build_device_irq(leon3_ticker_irq, handle_percpu_irq,
+	irq = leon_build_device_irq(leon3_gptimer_irq, handle_percpu_irq,
 				    "per-cpu", 0);
 	err = request_irq(irq, leon_percpu_timer_ce_interrupt,
-			  IRQF_PERCPU | IRQF_TIMER, "ticker",
-			  NULL);
+			  IRQF_PERCPU | IRQF_TIMER, "timer", NULL);
+#else
+	irq = _leon_build_device_irq(NULL, leon3_gptimer_irq);
+	err = request_irq(irq, timer_interrupt, IRQF_TIMER, "timer", NULL);
+#endif
 	if (err) {
-		printk(KERN_ERR "unable to attach ticker IRQ%d\n", irq);
+		pr_err("Unable to attach timer IRQ%d\n", irq);
 		prom_halt();
 	}
-
-	LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[leon3_gptimer_idx+1].ctrl,
+	LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[leon3_gptimer_idx].ctrl,
 			      LEON3_GPTIMER_EN |
 			      LEON3_GPTIMER_RL |
 			      LEON3_GPTIMER_LD |
 			      LEON3_GPTIMER_IRQEN);
-#endif
 	return;
 bad:
 	printk(KERN_ERR "No Timer/irqctrl found\n");
-- 
1.7.10.4

