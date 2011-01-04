From: Daniel Hellstrom <daniel@gaisler.com>
Date: Tue, 04 Jan 2011 11:41:29 +0000
Subject: [PATCH 1/7] SPARC/LEON: find IRQCTRL and Timer via OF-Tree, instead of hardcoded.
Message-Id: <1294141295-26584-1-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/kernel/leon_kernel.c |   44 +++++++++++++++++++++++++++++++++-----
 1 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index f01c426..80ba8f5 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -23,15 +23,15 @@
 #include "prom.h"
 #include "irq.h"
 
-struct leon3_irqctrl_regs_map *leon3_irqctrl_regs; /* interrupt controller base address, initialized by amba_init() */
-struct leon3_gptimer_regs_map *leon3_gptimer_regs; /* timer controller base address, initialized by amba_init() */
+struct leon3_irqctrl_regs_map *leon3_irqctrl_regs; /* interrupt controller base address */
+struct leon3_gptimer_regs_map *leon3_gptimer_regs; /* timer controller base address */
 struct amba_apb_device leon_percpu_timer_dev[16];
 
 int leondebug_irq_disable;
 int leon_debug_irqout;
 static int dummy_master_l10_counter;
 
-unsigned long leon3_gptimer_irq; /* interrupt controller irq number, initialized by amba_init() */
+unsigned long leon3_gptimer_irq; /* interrupt controller irq number */
 unsigned int sparc_leon_eirq;
 #define LEON_IMASK ((&leon3_irqctrl_regs->mask[0]))
 
@@ -105,13 +105,41 @@ static void leon_disable_irq(unsigned int irq_nr)
 void __init leon_init_timers(irq_handler_t counter_fn)
 {
 	int irq;
+	struct device_node *rootnp, *np;
+	struct property *pp;
+	int len;
 
 	leondebug_irq_disable = 0;
 	leon_debug_irqout = 0;
 	master_l10_counter = (unsigned int *)&dummy_master_l10_counter;
 	dummy_master_l10_counter = 0;
 
-	if (leon3_gptimer_regs && leon3_irqctrl_regs) {
+	/*Find IRQMP IRQ Controller Registers base address otherwise bail out.*/
+	rootnp = of_find_node_by_path("/ambapp0");
+	if (!rootnp)
+		goto bad;
+	np = of_find_node_by_name(rootnp, "GAISLER_IRQMP");
+	if (!np)
+		goto bad;
+	pp = of_find_property(np, "reg", &len);
+	if (!pp)
+		goto bad;
+	leon3_irqctrl_regs = *(struct leon3_irqctrl_regs_map **)pp->value;
+
+	/* Find GPTIMER Timer Registers base address otherwise bail out. */
+	np = of_find_node_by_name(rootnp, "GAISLER_GPTIMER");
+	if (!np)
+		goto bad;
+	pp = of_find_property(np, "reg", &len);
+	if (!pp)
+		goto bad;
+	leon3_gptimer_regs = *(struct leon3_gptimer_regs_map **)pp->value;
+	pp = of_find_property(np, "interrupts", &len);
+	if (!pp)
+		goto bad;
+	leon3_gptimer_irq = *(unsigned int *)pp->value;
+
+	if (leon3_gptimer_regs && leon3_irqctrl_regs && leon3_gptimer_irq) {
 		LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[0].val, 0);
 		LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[0].rld,
 				      (((1000000 / HZ) - 1)));
@@ -133,8 +161,7 @@ void __init leon_init_timers(irq_handler_t counter_fn)
 # endif
 
 	} else {
-		printk(KERN_ERR "No Timer/irqctrl found\n");
-		BUG();
+		goto bad;
 	}
 
 	irq = request_irq(leon3_gptimer_irq,
@@ -183,6 +210,11 @@ void __init leon_init_timers(irq_handler_t counter_fn)
 #endif
 
 	}
+	return;
+bad:
+	printk(KERN_ERR "No Timer/irqctrl found\n");
+	BUG();
+	return;
 }
 
 void leon_clear_clock_irq(void)
-- 
1.5.4

