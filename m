From: Valentin Schneider <valentin.schneider@arm.com>
Date: Fri, 03 Jul 2020 15:56:45 +0000
Subject: [PATCH 2/2] genirq: Remove preflow handler support
Message-Id: <20200703155645.29703-3-valentin.schneider@arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200703155645.29703-1-valentin.schneider@arm.com>
In-Reply-To: <20200703155645.29703-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>

That was put in place for sparc64, and blackfin also used it for some time;
sparc64 no longer uses those, and blackfin is dead.

As there are no more users, remove preflow handlers.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 include/linux/irqdesc.h    | 15 ---------------
 include/linux/irqhandler.h |  1 -
 kernel/irq/Kconfig         |  4 ----
 kernel/irq/chip.c          | 13 -------------
 4 files changed, 33 deletions(-)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 8f2820c5e69e..5745491303e0 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -22,7 +22,6 @@ struct pt_regs;
  * @irq_common_data:	per irq and chip data passed down to chip functions
  * @kstat_irqs:		irq stats per cpu
  * @handle_irq:		highlevel irq-events handler
- * @preflow_handler:	handler called before the flow handler (currently used by sparc)
  * @action:		the irq action chain
  * @status_use_accessors: status information
  * @core_internal_state__do_not_mess_with_it: core internal status information
@@ -58,9 +57,6 @@ struct irq_desc {
 	struct irq_data		irq_data;
 	unsigned int __percpu	*kstat_irqs;
 	irq_flow_handler_t	handle_irq;
-#ifdef CONFIG_IRQ_PREFLOW_FASTEOI
-	irq_preflow_handler_t	preflow_handler;
-#endif
 	struct irqaction	*action;	/* IRQ action list */
 	unsigned int		status_use_accessors;
 	unsigned int		core_internal_state__do_not_mess_with_it;
@@ -268,15 +264,4 @@ irq_set_lockdep_class(unsigned int irq, struct lock_class_key *lock_class,
 	}
 }
 
-#ifdef CONFIG_IRQ_PREFLOW_FASTEOI
-static inline void
-__irq_set_preflow_handler(unsigned int irq, irq_preflow_handler_t handler)
-{
-	struct irq_desc *desc;
-
-	desc = irq_to_desc(irq);
-	desc->preflow_handler = handler;
-}
-#endif
-
 #endif
diff --git a/include/linux/irqhandler.h b/include/linux/irqhandler.h
index 1e6f4e7123d6..c30f454a9518 100644
--- a/include/linux/irqhandler.h
+++ b/include/linux/irqhandler.h
@@ -10,6 +10,5 @@
 struct irq_desc;
 struct irq_data;
 typedef	void (*irq_flow_handler_t)(struct irq_desc *desc);
-typedef	void (*irq_preflow_handler_t)(struct irq_data *data);
 
 #endif
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index d63c324895ea..58f0e996a2c3 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -51,10 +51,6 @@ config GENERIC_IRQ_INJECTION
 config HARDIRQS_SW_RESEND
        bool
 
-# Preflow handler support for fasteoi (sparc64)
-config IRQ_PREFLOW_FASTEOI
-       bool
-
 # Edge style eoi based handler (cell)
 config IRQ_EDGE_EOI_HANDLER
        bool
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 41e7e37a0928..75bbaa8b38f1 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -656,16 +656,6 @@ void handle_level_irq(struct irq_desc *desc)
 }
 EXPORT_SYMBOL_GPL(handle_level_irq);
 
-#ifdef CONFIG_IRQ_PREFLOW_FASTEOI
-static inline void preflow_handler(struct irq_desc *desc)
-{
-	if (desc->preflow_handler)
-		desc->preflow_handler(&desc->irq_data);
-}
-#else
-static inline void preflow_handler(struct irq_desc *desc) { }
-#endif
-
 static void cond_unmask_eoi_irq(struct irq_desc *desc, struct irq_chip *chip)
 {
 	if (!(desc->istate & IRQS_ONESHOT)) {
@@ -721,7 +711,6 @@ void handle_fasteoi_irq(struct irq_desc *desc)
 	if (desc->istate & IRQS_ONESHOT)
 		mask_irq(desc);
 
-	preflow_handler(desc);
 	handle_irq_event(desc);
 
 	cond_unmask_eoi_irq(desc, chip);
@@ -1231,7 +1220,6 @@ void handle_fasteoi_ack_irq(struct irq_desc *desc)
 	/* Start handling the irq */
 	desc->irq_data.chip->irq_ack(&desc->irq_data);
 
-	preflow_handler(desc);
 	handle_irq_event(desc);
 
 	cond_unmask_eoi_irq(desc, chip);
@@ -1281,7 +1269,6 @@ void handle_fasteoi_mask_irq(struct irq_desc *desc)
 	if (desc->istate & IRQS_ONESHOT)
 		mask_irq(desc);
 
-	preflow_handler(desc);
 	handle_irq_event(desc);
 
 	cond_unmask_eoi_irq(desc, chip);
-- 
2.27.0
