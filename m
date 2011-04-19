From: Daniel Hellstrom <daniel@gaisler.com>
Date: Tue, 19 Apr 2011 16:07:17 +0000
Subject: [PATCH 5/7] sparc32,leon: code cleanup of timer/IRQ controller initialization
Message-Id: <1303229239-21551-5-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Cleaned up leon_init_timers() by removing unnecessary double checking
and one indentation level. Changed LEON_IMASK to LEON_IMASK(cpu).

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/kernel/leon_kernel.c |  156 ++++++++++++++++++---------------------
 1 files changed, 72 insertions(+), 84 deletions(-)

diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index c15bcf3..80ab271 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -37,7 +37,7 @@ unsigned long leon3_gptimer_irq; /* interrupt controller irq number */
 unsigned long leon3_gptimer_idx; /* Timer Index (0..6) within Timer Core */
 int leon3_ticker_irq; /* Timer ticker IRQ */
 unsigned int sparc_leon_eirq;
-#define LEON_IMASK (&leon3_irqctrl_regs->mask[0])
+#define LEON_IMASK(cpu) (&leon3_irqctrl_regs->mask[cpu])
 #define LEON_IACK (&leon3_irqctrl_regs->iclear)
 #define LEON_DO_ACK_HW 1
 
@@ -79,8 +79,8 @@ void leon_eirq_setup(unsigned int eirq)
 	 */
 	irq_link(veirq);
 	mask = 1 << eirq;
-	oldmask = LEON3_BYPASS_LOAD_PA(LEON_IMASK);
-	LEON3_BYPASS_STORE_PA(LEON_IMASK, (oldmask | mask));
+	oldmask = LEON3_BYPASS_LOAD_PA(LEON_IMASK(0));
+	LEON3_BYPASS_STORE_PA(LEON_IMASK(0), (oldmask | mask));
 	sparc_leon_eirq = eirq;
 }
 
@@ -101,23 +101,23 @@ static inline unsigned long get_irqmask(unsigned int irq)
 
 static void leon_unmask_irq(struct irq_data *data)
 {
-	unsigned long mask, flags;
+	unsigned long mask, oldmask, flags;
 
 	mask = (unsigned long)data->chip_data;
 	spin_lock_irqsave(&leon_irq_lock, flags);
-	LEON3_BYPASS_STORE_PA(LEON_IMASK,
-			      (LEON3_BYPASS_LOAD_PA(LEON_IMASK) | (mask)));
+	oldmask = LEON3_BYPASS_LOAD_PA(LEON_IMASK(0));
+	LEON3_BYPASS_STORE_PA(LEON_IMASK(0), (oldmask | mask));
 	spin_unlock_irqrestore(&leon_irq_lock, flags);
 }
 
 static void leon_mask_irq(struct irq_data *data)
 {
-	unsigned long mask, flags;
+	unsigned long mask, oldmask, flags;
 
 	mask = (unsigned long)data->chip_data;
 	spin_lock_irqsave(&leon_irq_lock, flags);
-	LEON3_BYPASS_STORE_PA(LEON_IMASK,
-			      (LEON3_BYPASS_LOAD_PA(LEON_IMASK) & ~(mask)));
+	oldmask = LEON3_BYPASS_LOAD_PA(LEON_IMASK(0));
+	LEON3_BYPASS_STORE_PA(LEON_IMASK(0), (oldmask & ~mask));
 	spin_unlock_irqrestore(&leon_irq_lock, flags);
 }
 
@@ -261,92 +261,83 @@ void __init leon_init_timers(irq_handler_t counter_fn)
 			leon3_gptimer_irq = *(unsigned int *)pp->value;
 	} while (0);
 
-	if (leon3_gptimer_regs && leon3_irqctrl_regs && leon3_gptimer_irq) {
-		LEON3_BYPASS_STORE_PA(
-			&leon3_gptimer_regs->e[leon3_gptimer_idx].val, 0);
-		LEON3_BYPASS_STORE_PA(
-			&leon3_gptimer_regs->e[leon3_gptimer_idx].rld,
-			(((1000000 / HZ) - 1)));
-		LEON3_BYPASS_STORE_PA(
+	if (!(leon3_gptimer_regs && leon3_irqctrl_regs && leon3_gptimer_irq))
+		goto bad;
+
+	LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[leon3_gptimer_idx].val, 0);
+	LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[leon3_gptimer_idx].rld,
+				(((1000000 / HZ) - 1)));
+	LEON3_BYPASS_STORE_PA(
 			&leon3_gptimer_regs->e[leon3_gptimer_idx].ctrl, 0);
 
 #ifdef CONFIG_SMP
-		leon3_ticker_irq = leon3_gptimer_irq + 1 + leon3_gptimer_idx;
-
-		if (!(LEON3_BYPASS_LOAD_PA(&leon3_gptimer_regs->config) &
-		      (1<<LEON3_GPTIMER_SEPIRQ))) {
-			prom_printf("irq timer not configured with separate irqs\n");
-			BUG();
-		}
+	leon3_ticker_irq = leon3_gptimer_irq + 1 + leon3_gptimer_idx;
 
-		LEON3_BYPASS_STORE_PA(
-			&leon3_gptimer_regs->e[leon3_gptimer_idx+1].val, 0);
-		LEON3_BYPASS_STORE_PA(
-			&leon3_gptimer_regs->e[leon3_gptimer_idx+1].rld,
-			(((1000000/HZ) - 1)));
-		LEON3_BYPASS_STORE_PA(
-			&leon3_gptimer_regs->e[leon3_gptimer_idx+1].ctrl, 0);
-# endif
-
-		/*
-		 * The IRQ controller may (if implemented) consist of multiple
-		 * IRQ controllers, each mapped on a 4Kb boundary.
-		 * Each CPU may be routed to different IRQCTRLs, however
-		 * we assume that all CPUs (in SMP system) is routed to the
-		 * same IRQ Controller, and for non-SMP only one IRQCTRL is
-		 * accessed anyway.
-		 * In AMP systems, Linux must run on CPU0 for the time being.
-		 */
-		cpu = sparc_leon3_cpuid();
-		icsel = LEON3_BYPASS_LOAD_PA(&leon3_irqctrl_regs->icsel[cpu/8]);
-		icsel = (icsel >> ((7 - (cpu&0x7)) * 4)) & 0xf;
-		leon3_irqctrl_regs += icsel;
-
-		/* Probe extended IRQ controller */
-		eirq = (LEON3_BYPASS_LOAD_PA(&leon3_irqctrl_regs->mpstatus)
-			>> 16) & 0xf;
-		if (eirq != 0)
-			leon_eirq_setup(eirq);
-	} else {
-		goto bad;
+	if (!(LEON3_BYPASS_LOAD_PA(&leon3_gptimer_regs->config) &
+	      (1<<LEON3_GPTIMER_SEPIRQ))) {
+		printk(KERN_ERR "timer not configured with separate irqs\n");
+		BUG();
 	}
 
+	LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[leon3_gptimer_idx+1].val,
+				0);
+	LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[leon3_gptimer_idx+1].rld,
+				(((1000000/HZ) - 1)));
+	LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[leon3_gptimer_idx+1].ctrl,
+				0);
+#endif
+
+	/*
+	 * The IRQ controller may (if implemented) consist of multiple
+	 * IRQ controllers, each mapped on a 4Kb boundary.
+	 * Each CPU may be routed to different IRQCTRLs, however
+	 * we assume that all CPUs (in SMP system) is routed to the
+	 * same IRQ Controller, and for non-SMP only one IRQCTRL is
+	 * accessed anyway.
+	 * In AMP systems, Linux must run on CPU0 for the time being.
+	 */
+	cpu = sparc_leon3_cpuid();
+	icsel = LEON3_BYPASS_LOAD_PA(&leon3_irqctrl_regs->icsel[cpu/8]);
+	icsel = (icsel >> ((7 - (cpu&0x7)) * 4)) & 0xf;
+	leon3_irqctrl_regs += icsel;
+
+	/* Probe extended IRQ controller */
+	eirq = (LEON3_BYPASS_LOAD_PA(&leon3_irqctrl_regs->mpstatus)
+		>> 16) & 0xf;
+	if (eirq != 0)
+		leon_eirq_setup(eirq);
+
 	irq = _leon_build_device_irq(NULL, leon3_gptimer_irq+leon3_gptimer_idx);
 	err = request_irq(irq, counter_fn, IRQF_TIMER, "timer", NULL);
-
 	if (err) {
-		printk(KERN_ERR "leon_time_init: unable to attach IRQ%d\n",
-		       irq);
+		printk(KERN_ERR "unable to attach timer IRQ%d\n", irq);
 		prom_halt();
 	}
 
-	if (leon3_gptimer_regs) {
-		LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[leon3_gptimer_idx].ctrl,
-				      LEON3_GPTIMER_EN |
-				      LEON3_GPTIMER_RL |
-				      LEON3_GPTIMER_LD | LEON3_GPTIMER_IRQEN);
+	LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[leon3_gptimer_idx].ctrl,
+			      LEON3_GPTIMER_EN |
+			      LEON3_GPTIMER_RL |
+			      LEON3_GPTIMER_LD |
+			      LEON3_GPTIMER_IRQEN);
 
 #ifdef CONFIG_SMP
-		/* Install per-cpu IRQ handler for broadcasted ticker */
-		irq = leon_build_device_irq(leon3_ticker_irq,
-						handle_percpu_irq, "per-cpu",
-						0);
-		err = request_irq(irq, leon_percpu_timer_interrupt,
-					IRQF_PERCPU | IRQF_TIMER, "ticker",
-					NULL);
-		if (err) {
-			printk(KERN_ERR "unable to attach ticker IRQ%d\n", irq);
-			prom_halt();
-		}
+	/* Install per-cpu IRQ handler for broadcasted ticker */
+	irq = leon_build_device_irq(leon3_ticker_irq, handle_percpu_irq,
+				    "per-cpu", 0);
+	err = request_irq(irq, leon_percpu_timer_interrupt,
+			  IRQF_PERCPU | IRQF_TIMER, "ticker",
+			  NULL);
+	if (err) {
+		printk(KERN_ERR "unable to attach ticker IRQ%d\n", irq);
+		prom_halt();
+	}
 
-		LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[leon3_gptimer_idx+1].ctrl,
-				      LEON3_GPTIMER_EN |
-				      LEON3_GPTIMER_RL |
-				      LEON3_GPTIMER_LD |
-				      LEON3_GPTIMER_IRQEN);
+	LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[leon3_gptimer_idx+1].ctrl,
+			      LEON3_GPTIMER_EN |
+			      LEON3_GPTIMER_RL |
+			      LEON3_GPTIMER_LD |
+			      LEON3_GPTIMER_IRQEN);
 #endif
-
-	}
 	return;
 bad:
 	printk(KERN_ERR "No Timer/irqctrl found\n");
@@ -363,9 +354,6 @@ void leon_load_profile_irq(int cpu, unsigned int limit)
 	BUG();
 }
 
-
-
-
 void __init leon_trans_init(struct device_node *dp)
 {
 	if (strcmp(dp->type, "cpu") = 0 && strcmp(dp->name, "<NULL>") = 0) {
@@ -420,8 +408,8 @@ void leon_enable_irq_cpu(unsigned int irq_nr, unsigned int cpu)
 	unsigned long mask, flags, *addr;
 	mask = get_irqmask(irq_nr);
 	spin_lock_irqsave(&leon_irq_lock, flags);
-	addr = (unsigned long *)&(leon3_irqctrl_regs->mask[cpu]);
-	LEON3_BYPASS_STORE_PA(addr, (LEON3_BYPASS_LOAD_PA(addr) | (mask)));
+	addr = (unsigned long *)LEON_IMASK(cpu);
+	LEON3_BYPASS_STORE_PA(addr, (LEON3_BYPASS_LOAD_PA(addr) | mask));
 	spin_unlock_irqrestore(&leon_irq_lock, flags);
 }
 
-- 
1.5.4

