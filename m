From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 20 Apr 2011 08:39:04 +0000
Subject: [PATCH 2/7 v2] sparc32,leon: add support for extended interrupt controller
Message-Id: <1303288747-28521-2-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The extended IRQ controller gives the LEON 16 more IRQs.

The patch installs a custom handler for the exetended controller
IRQ, where a register is read and the "real" IRQ causing IRQ is
determined.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/leon.h   |    7 +--
 arch/sparc/kernel/leon_kernel.c |   95 +++++++++++++++++++++++++++++----------
 2 files changed, 74 insertions(+), 28 deletions(-)

diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
index c04f96f..1271254 100644
--- a/arch/sparc/include/asm/leon.h
+++ b/arch/sparc/include/asm/leon.h
@@ -183,7 +183,6 @@ static inline void leon_srmmu_enabletlb(void)
 /* macro access for leon_readnobuffer_reg() */
 #define LEON_BYPASSCACHE_LOAD_VA(x) leon_readnobuffer_reg((unsigned long)(x))
 
-extern void sparc_leon_eirq_register(int eirq);
 extern void leon_init(void);
 extern void leon_switch_mm(void);
 extern void leon_init_IRQ(void);
@@ -339,9 +338,9 @@ struct leon2_cacheregs {
 #include <linux/interrupt.h>
 
 struct device_node;
-extern int sparc_leon_eirq_get(int eirq, int cpu);
-extern irqreturn_t sparc_leon_eirq_isr(int dummy, void *dev_id);
-extern void sparc_leon_eirq_register(int eirq);
+extern unsigned int leon_build_device_irq(unsigned int real_irq,
+					   irq_flow_handler_t flow_handler,
+					   const char *name, int do_ack);
 extern void leon_clear_clock_irq(void);
 extern void leon_load_profile_irq(int cpu, unsigned int limit);
 extern void leon_init_timers(irq_handler_t counter_fn);
diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index 390e469..210f4a0 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -19,6 +19,7 @@
 #include <asm/leon_amba.h>
 #include <asm/traps.h>
 #include <asm/cacheflush.h>
+#include <asm/smp.h>
 
 #include "prom.h"
 #include "irq.h"
@@ -36,37 +37,51 @@ static DEFINE_SPINLOCK(leon_irq_lock);
 unsigned long leon3_gptimer_irq; /* interrupt controller irq number */
 unsigned long leon3_gptimer_idx; /* Timer Index (0..6) within Timer Core */
 unsigned int sparc_leon_eirq;
-#define LEON_IMASK ((&leon3_irqctrl_regs->mask[0]))
+#define LEON_IMASK (&leon3_irqctrl_regs->mask[0])
+#define LEON_IACK (&leon3_irqctrl_regs->iclear)
+#define LEON_DO_ACK_HW 1
 
-/* Return the IRQ of the pending IRQ on the extended IRQ controller */
-int sparc_leon_eirq_get(int eirq, int cpu)
+/* Return the last ACKed IRQ by the Extended IRQ controller. It has already
+ * been (automatically) ACKed when the CPU takes the trap.
+ */
+static inline unsigned int leon_eirq_get(int cpu)
 {
 	return LEON3_BYPASS_LOAD_PA(&leon3_irqctrl_regs->intid[cpu]) & 0x1f;
 }
 
-irqreturn_t sparc_leon_eirq_isr(int dummy, void *dev_id)
+/* Handle one or multiple IRQs from the extended interrupt controller */
+static void leon_handle_ext_irq(unsigned int irq, struct irq_desc *desc)
 {
-	printk(KERN_ERR "sparc_leon_eirq_isr: ERROR EXTENDED IRQ\n");
-	return IRQ_HANDLED;
+	unsigned int eirq;
+	int cpu = hard_smp_processor_id();
+
+	eirq = leon_eirq_get(cpu);
+	if ((eirq & 0x10) && irq_map[eirq]->irq) /* bit4 tells if IRQ happened */
+		generic_handle_irq(irq_map[eirq]->irq);
 }
 
 /* The extended IRQ controller has been found, this function registers it */
-void sparc_leon_eirq_register(int eirq)
+void leon_eirq_setup(unsigned int eirq)
 {
-	int irq;
+	unsigned long mask, oldmask;
+	unsigned int veirq;
 
-	/* Register a "BAD" handler for this interrupt, it should never happen */
-	irq = request_irq(eirq, sparc_leon_eirq_isr,
-			  (IRQF_DISABLED | SA_STATIC_ALLOC), "extirq", NULL);
-
-	if (irq) {
-		printk(KERN_ERR
-		       "sparc_leon_eirq_register: unable to attach IRQ%d\n",
-		       eirq);
-	} else {
-		sparc_leon_eirq = eirq;
+	if (eirq < 1 || eirq > 0xf) {
+		printk(KERN_ERR "LEON EXT IRQ NUMBER BAD: %d\n", eirq);
+		return;
 	}
 
+	veirq = leon_build_device_irq(eirq, leon_handle_ext_irq, "extirq", 0);
+
+	/*
+	 * Unmask the Extended IRQ, the IRQs routed through the Ext-IRQ
+	 * controller have a mask-bit of their own, so this is safe.
+	 */
+	irq_link(veirq);
+	mask = 1 << eirq;
+	oldmask = LEON3_BYPASS_LOAD_PA(LEON_IMASK);
+	LEON3_BYPASS_STORE_PA(LEON_IMASK, (oldmask | mask));
+	sparc_leon_eirq = eirq;
 }
 
 static inline unsigned long get_irqmask(unsigned int irq)
@@ -119,16 +134,33 @@ static void leon_shutdown_irq(struct irq_data *data)
 	irq_unlink(data->irq);
 }
 
+/* Used by external level sensitive IRQ handlers on the LEON: ACK IRQ ctrl */
+static void leon_eoi_irq(struct irq_data *data)
+{
+	unsigned long mask = (unsigned long)data->chip_data;
+
+	if (mask & LEON_DO_ACK_HW)
+		LEON3_BYPASS_STORE_PA(LEON_IACK, mask & ~LEON_DO_ACK_HW);
+}
+
 static struct irq_chip leon_irq = {
 	.name		= "leon",
 	.irq_startup	= leon_startup_irq,
 	.irq_shutdown	= leon_shutdown_irq,
 	.irq_mask	= leon_mask_irq,
 	.irq_unmask	= leon_unmask_irq,
+	.irq_eoi	= leon_eoi_irq,
 };
 
-static unsigned int leon_build_device_irq(struct platform_device *op,
-                                          unsigned int real_irq)
+/*
+ * Build a LEON IRQ for the edge triggered LEON IRQ controller:
+ *  Edge (normal) IRQ           - handle_simple_irq, ack=DONT-CARE, never ack
+ *  Level IRQ (PCI|Level-GPIO)  - handle_fasteoi_irq, ack=1, ack after ISR
+ *  Per-CPU Edge                - handle_percpu_irq, ack=0
+ */
+unsigned int leon_build_device_irq(unsigned int real_irq,
+				    irq_flow_handler_t flow_handler,
+				    const char *name, int do_ack)
 {
 	unsigned int irq;
 	unsigned long mask;
@@ -142,17 +174,26 @@ static unsigned int leon_build_device_irq(struct platform_device *op,
 	if (irq = 0)
 		goto out;
 
+	if (do_ack)
+		mask |= LEON_DO_ACK_HW;
+
 	irq_set_chip_and_handler_name(irq, &leon_irq,
-				      handle_simple_irq, "edge");
+				      flow_handler, name);
 	irq_set_chip_data(irq, (void *)mask);
 
 out:
 	return irq;
 }
 
+static unsigned int _leon_build_device_irq(struct platform_device *op,
+					   unsigned int real_irq)
+{
+	return leon_build_device_irq(real_irq, handle_simple_irq, "edge", 0);
+}
+
 void __init leon_init_timers(irq_handler_t counter_fn)
 {
-	int irq;
+	int irq, eirq;
 	struct device_node *rootnp, *np, *nnp;
 	struct property *pp;
 	int len;
@@ -262,11 +303,17 @@ void __init leon_init_timers(irq_handler_t counter_fn)
 		icsel = LEON3_BYPASS_LOAD_PA(&leon3_irqctrl_regs->icsel[cpu/8]);
 		icsel = (icsel >> ((7 - (cpu&0x7)) * 4)) & 0xf;
 		leon3_irqctrl_regs += icsel;
+
+		/* Probe extended IRQ controller */
+		eirq = (LEON3_BYPASS_LOAD_PA(&leon3_irqctrl_regs->mpstatus)
+			>> 16) & 0xf;
+		if (eirq != 0)
+			leon_eirq_setup(eirq);
 	} else {
 		goto bad;
 	}
 
-	irq = leon_build_device_irq(NULL, leon3_gptimer_irq + leon3_gptimer_idx);
+	irq = _leon_build_device_irq(NULL, leon3_gptimer_irq+leon3_gptimer_idx);
 	err = request_irq(irq, counter_fn, IRQF_TIMER, "timer", NULL);
 
 	if (err) {
@@ -394,7 +441,7 @@ void leon_enable_irq_cpu(unsigned int irq_nr, unsigned int cpu)
 void __init leon_init_IRQ(void)
 {
 	sparc_irq_config.init_timers      = leon_init_timers;
-	sparc_irq_config.build_device_irq = leon_build_device_irq;
+	sparc_irq_config.build_device_irq = _leon_build_device_irq;
 
 	BTFIXUPSET_CALL(clear_clock_irq, leon_clear_clock_irq,
 			BTFIXUPCALL_NORM);
-- 
1.5.4

