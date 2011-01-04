From: Daniel Hellstrom <daniel@gaisler.com>
Date: Tue, 04 Jan 2011 11:41:32 +0000
Subject: [PATCH 4/7] SPARC/LEON: added support for selecting Timer Core and Timer within core
Message-Id: <1294141295-26584-4-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The ability to select Timer Core and Timer instance for system clock
makes it possible for multiple AMP systems to coexist.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/kernel/leon_kernel.c |   80 ++++++++++++++++++++++++++-------------
 1 files changed, 54 insertions(+), 26 deletions(-)

diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index 88ade07..fdab7f8 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -32,6 +32,7 @@ int leon_debug_irqout;
 static int dummy_master_l10_counter;
 
 unsigned long leon3_gptimer_irq; /* interrupt controller irq number */
+unsigned long leon3_gptimer_idx; /* Timer Index (0..6) within Timer Core */
 unsigned int sparc_leon_eirq;
 #define LEON_IMASK ((&leon3_irqctrl_regs->mask[0]))
 
@@ -105,10 +106,11 @@ static void leon_disable_irq(unsigned int irq_nr)
 void __init leon_init_timers(irq_handler_t counter_fn)
 {
 	int irq;
-	struct device_node *rootnp, *np;
+	struct device_node *rootnp, *np, *nnp;
 	struct property *pp;
 	int len;
 	int cpu, icsel;
+	int ampopts;
 
 	leondebug_irq_disable = 0;
 	leon_debug_irqout = 0;
@@ -131,30 +133,52 @@ void __init leon_init_timers(irq_handler_t counter_fn)
 	leon3_irqctrl_regs = *(struct leon3_irqctrl_regs_map **)pp->value;
 
 	/* Find GPTIMER Timer Registers base address otherwise bail out. */
-	np = of_find_node_by_name(rootnp, "GAISLER_GPTIMER");
-	if (!np) {
-		np = of_find_node_by_name(np, "01_011");
-		if (!np)
-			goto bad;
-	}
-	pp = of_find_property(np, "reg", &len);
-	if (!pp)
-		goto bad;
-	leon3_gptimer_regs = *(struct leon3_gptimer_regs_map **)pp->value;
-	pp = of_find_property(np, "interrupts", &len);
-	if (!pp)
-		goto bad;
-	leon3_gptimer_irq = *(unsigned int *)pp->value;
+	nnp = rootnp;
+	do {
+		np = of_find_node_by_name(nnp, "GAISLER_GPTIMER");
+		if (!np) {
+			np = of_find_node_by_name(nnp, "01_011");
+			if (!np)
+				goto bad;
+		}
+
+		ampopts = 0;
+		pp = of_find_property(np, "ampopts", &len);
+		if (pp) {
+			ampopts = *(int *)pp->value;
+			if (ampopts = 0) {
+				/* Skip this instance, resource already
+				 * allocated by other OS */
+				nnp = np;
+				continue;
+			}
+		}
+
+		/* Select Timer-Instance on Timer Core. Default is zero */
+		leon3_gptimer_idx = ampopts & 0x7;
+
+		pp = of_find_property(np, "reg", &len);
+		if (pp)
+			leon3_gptimer_regs = *(struct leon3_gptimer_regs_map **)
+						pp->value;
+		pp = of_find_property(np, "interrupts", &len);
+		if (pp)
+			leon3_gptimer_irq = *(unsigned int *)pp->value;
+	} while (0);
 
 	if (leon3_gptimer_regs && leon3_irqctrl_regs && leon3_gptimer_irq) {
-		LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[0].val, 0);
-		LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[0].rld,
-				      (((1000000 / HZ) - 1)));
-		LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[0].ctrl, 0);
+		LEON3_BYPASS_STORE_PA(
+			&leon3_gptimer_regs->e[leon3_gptimer_idx].val, 0);
+		LEON3_BYPASS_STORE_PA(
+			&leon3_gptimer_regs->e[leon3_gptimer_idx].rld,
+			(((1000000 / HZ) - 1)));
+		LEON3_BYPASS_STORE_PA(
+			&leon3_gptimer_regs->e[leon3_gptimer_idx].ctrl, 0);
 
 #ifdef CONFIG_SMP
 		leon_percpu_timer_dev[0].start = (int)leon3_gptimer_regs;
-		leon_percpu_timer_dev[0].irq = leon3_gptimer_irq+1;
+		leon_percpu_timer_dev[0].irq = leon3_gptimer_irq + 1 +
+					       leon3_gptimer_idx;
 
 		if (!(LEON3_BYPASS_LOAD_PA(&leon3_gptimer_regs->config) &
 		      (1<<LEON3_GPTIMER_SEPIRQ))) {
@@ -162,9 +186,13 @@ void __init leon_init_timers(irq_handler_t counter_fn)
 			BUG();
 		}
 
-		LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[1].val, 0);
-		LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[1].rld, (((1000000/HZ) - 1)));
-		LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[1].ctrl, 0);
+		LEON3_BYPASS_STORE_PA(
+			&leon3_gptimer_regs->e[leon3_gptimer_idx+1].val, 0);
+		LEON3_BYPASS_STORE_PA(
+			&leon3_gptimer_regs->e[leon3_gptimer_idx+1].rld,
+			(((1000000/HZ) - 1)));
+		LEON3_BYPASS_STORE_PA(
+			&leon3_gptimer_regs->e[leon3_gptimer_idx+1].ctrl, 0);
 # endif
 
 		/*
@@ -184,7 +212,7 @@ void __init leon_init_timers(irq_handler_t counter_fn)
 		goto bad;
 	}
 
-	irq = request_irq(leon3_gptimer_irq,
+	irq = request_irq(leon3_gptimer_irq+leon3_gptimer_idx,
 			  counter_fn,
 			  (IRQF_DISABLED | SA_STATIC_ALLOC), "timer", NULL);
 
@@ -216,13 +244,13 @@ void __init leon_init_timers(irq_handler_t counter_fn)
 # endif
 
 	if (leon3_gptimer_regs) {
-		LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[0].ctrl,
+		LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[leon3_gptimer_idx].ctrl,
 				      LEON3_GPTIMER_EN |
 				      LEON3_GPTIMER_RL |
 				      LEON3_GPTIMER_LD | LEON3_GPTIMER_IRQEN);
 
 #ifdef CONFIG_SMP
-		LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[1].ctrl,
+		LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[leon3_gptimer_idx+1].ctrl,
 				      LEON3_GPTIMER_EN |
 				      LEON3_GPTIMER_RL |
 				      LEON3_GPTIMER_LD |
-- 
1.5.4

