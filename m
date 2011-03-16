From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 16 Mar 2011 15:54:50 +0000
Subject: [PATCH 2/2] sparc32,leon: add support for extended interrupt controller
Message-Id: <1300290890-20694-2-git-send-email-daniel@gaisler.com>
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
---
 arch/sparc/include/asm/leon.h   |    7 +--
 arch/sparc/kernel/leon_kernel.c |  114 +++++++++++++++++++++++++++++---------
 2 files changed, 90 insertions(+), 31 deletions(-)

diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
index c04f96f..95fcba5 100644
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
+extern unsigned int _leon_build_device_irq(unsigned int real_irq,
+					   irq_flow_handler_t flow_handler,
+					   const char *name, int do_ack);
 extern void leon_clear_clock_irq(void);
 extern void leon_load_profile_irq(int cpu, unsigned int limit);
 extern void leon_init_timers(irq_handler_t counter_fn);
diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index 4ddf367..e131f22 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -19,6 +19,7 @@
 #include <asm/leon_amba.h>
 #include <asm/traps.h>
 #include <asm/cacheflush.h>
+#include <asm/smp.h>
 
 #include "prom.h"
 #include "irq.h"
@@ -35,37 +36,52 @@ unsigned long amba_system_id;
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
+	if (eirq & 0x10) /* bit4 tells if IRQ has happened */
+		generic_handle_irq(eirq);
 }
 
 /* The extended IRQ controller has been found, this function registers it */
-void sparc_leon_eirq_register(int eirq)
+void leon_eirq_setup(int eirq)
 {
-	int irq;
-
-	/* Register a "BAD" handler for this interrupt, it should never happen */
-	irq = request_irq(eirq, sparc_leon_eirq_isr,
-			  (IRQF_DISABLED | SA_STATIC_ALLOC), "extirq", NULL);
+	unsigned long mask, flags;
 
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
 
+	_leon_build_device_irq(eirq, leon_handle_ext_irq, "extirq", 0);
+
+	/*
+	 * Unmask the Extended IRQ, the IRQs routed through the Ext-IRQ
+	 * controller have a mask-bit of their own, so this is safe.
+	 */
+	irq_link(eirq);
+	mask = 1 << eirq;
+	local_irq_save(flags);
+	LEON3_BYPASS_STORE_PA(LEON_IMASK,
+			      (LEON3_BYPASS_LOAD_PA(LEON_IMASK) | mask));
+	sparc_leon_eirq = eirq;
+	local_irq_restore(flags);
 }
 
 static inline unsigned long get_irqmask(unsigned int irq)
@@ -103,34 +119,56 @@ static void leon_mask_irq(struct irq_data *data)
 	LEON3_BYPASS_STORE_PA(LEON_IMASK,
 			      (LEON3_BYPASS_LOAD_PA(LEON_IMASK) & ~(mask)));
 	local_irq_restore(flags);
-
 }
 
 static unsigned int leon_startup_irq(struct irq_data *data)
 {
-	irq_link(data->irq);
+	/*
+	 * only link non-Extended Interrupts. eirqs share the same pil and
+	 * the exteneded IRQ is already linked during leon_eirq_setup()
+	 */
+	if (!(data->irq > 0xf && data->irq <= 0x1f))
+		irq_link(data->irq);
 	leon_unmask_irq(data);
 	return 0;
 }
 
 static void leon_shutdown_irq(struct irq_data *data)
 {
-	irq_unlink(data->irq);
+	if (!(data->irq > 0xf && data->irq <= 0x1f))
+		irq_unlink(data->irq);
 	leon_mask_irq(data);
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
+unsigned int _leon_build_device_irq(unsigned int real_irq,
+				    irq_flow_handler_t flow_handler,
+				    const char *name, int do_ack)
 {
-	unsigned int irq;
+	unsigned int irq, pil;
 	unsigned long mask;
 
 	irq = 0;
@@ -138,20 +176,36 @@ static unsigned int leon_build_device_irq(struct platform_device *op,
 	if (mask = 0)
 		goto out;
 
-	irq = irq_alloc(real_irq, real_irq);
+	/* All extended IRQs execute at ExtIRQ level */
+	if (sparc_leon_eirq && real_irq > 0xf)
+		pil = sparc_leon_eirq;
+	else
+		pil = real_irq;
+
+	irq = irq_alloc(real_irq, pil);
 	if (irq = 0)
 		goto out;
 
+	if (do_ack)
+		mask |= LEON_DO_ACK_HW;
+
 	set_irq_chip_and_handler_name(irq, &leon_irq,
-				      handle_simple_irq, "LEON");
+				      flow_handler, name);
 	set_irq_chip_data(irq, (void *)mask);
 
 out:
 	return irq;
 }
+
+static unsigned int leon_build_device_irq(struct platform_device *op,
+					   unsigned int real_irq)
+{
+	return _leon_build_device_irq(real_irq, handle_simple_irq, "edge", 0);
+}
+
 void __init leon_init_timers(irq_handler_t counter_fn)
 {
-	int irq;
+	int irq, eirq;
 	struct device_node *rootnp, *np, *nnp;
 	struct property *pp;
 	int len;
@@ -261,6 +315,12 @@ void __init leon_init_timers(irq_handler_t counter_fn)
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
-- 
1.5.4

