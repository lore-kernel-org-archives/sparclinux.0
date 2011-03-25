From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 25 Mar 2011 14:10:46 +0000
Subject: [patch 2/4] sparc: Cleanup direct irq_desc access
Message-Id: <20110325140947.024793702@linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Use the proper wrapper functions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/kernel/irq_64.c  |   22 +++++++++-------------
 arch/sparc/kernel/pci_msi.c |    5 +----
 2 files changed, 10 insertions(+), 17 deletions(-)

Index: linux-2.6-tip/arch/sparc/kernel/irq_64.c
=================================--- linux-2.6-tip.orig/arch/sparc/kernel/irq_64.c
+++ linux-2.6-tip/arch/sparc/kernel/irq_64.c
@@ -627,7 +627,6 @@ unsigned int sun4v_build_virq(u32 devhan
 	struct irq_handler_data *handler_data;
 	unsigned long hv_err, cookie;
 	struct ino_bucket *bucket;
-	struct irq_desc *desc;
 	unsigned int irq;
 
 	bucket = kzalloc(sizeof(struct ino_bucket), GFP_ATOMIC);
@@ -660,9 +659,7 @@ unsigned int sun4v_build_virq(u32 devhan
 	 * especially wrt. locking, we do not let request_irq() enable
 	 * the interrupt.
 	 */
-	desc = irq_desc + irq;
-	desc->status |= IRQ_NOAUTOEN;
-
+	irq_set_status_flags(IRQ_NOAUTOEN);
 	set_irq_data(irq, handler_data);
 
 	/* Catch accidental accesses to these things.  IMAP/ICLR handling
@@ -772,19 +769,18 @@ void fixup_irqs(void)
 	unsigned int irq;
 
 	for (irq = 0; irq < NR_IRQS; irq++) {
+		struct irq_desc *desc = irq_to_desc(irq);
+		struct irq_data *data = irq_desc_get_irq_data(desc);
 		unsigned long flags;
 
-		raw_spin_lock_irqsave(&irq_desc[irq].lock, flags);
-		if (irq_desc[irq].action &&
-		    !(irq_desc[irq].status & IRQ_PER_CPU)) {
-			struct irq_data *data = irq_get_irq_data(irq);
-
+		raw_spin_lock_irqsave(&desc->lock, flags);
+		if (desc->action && !irqd_is_per_cpu(data))
 			if (data->chip->irq_set_affinity)
 				data->chip->irq_set_affinity(data,
-				                             data->affinity,
-				                             false);
+							     data->affinity,
+							     false);
 		}
-		raw_spin_unlock_irqrestore(&irq_desc[irq].lock, flags);
+		raw_spin_unlock_irqrestore(&desc->lock, flags);
 	}
 
 	tick_ops->disable_irq();
@@ -1022,5 +1018,5 @@ void __init init_IRQ(void)
 			     : "i" (PSTATE_IE)
 			     : "g1");
 
-	irq_desc[0].action = &timer_irq_action;
+	irq_to_desc(0)->action = &timer_irq_action;
 }
Index: linux-2.6-tip/arch/sparc/kernel/pci_msi.c
=================================--- linux-2.6-tip.orig/arch/sparc/kernel/pci_msi.c
+++ linux-2.6-tip/arch/sparc/kernel/pci_msi.c
@@ -30,13 +30,10 @@ static irqreturn_t sparc64_msiq_interrup
 
 		err = ops->dequeue_msi(pbm, msiqid, &head, &msi);
 		if (likely(err > 0)) {
-			struct irq_desc *desc;
 			unsigned int irq;
 
 			irq = pbm->msi_irq_table[msi - pbm->msi_first];
-			desc = irq_desc + irq;
-
-			desc->handle_irq(irq, desc);
+			generic_handle_irq(irq);
 		}
 
 		if (unlikely(err < 0))


