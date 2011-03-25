From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 25 Mar 2011 14:10:45 +0000
Subject: [patch 1/4] sparc: Use the new genirq functionality
Message-Id: <20110325140946.928691193@linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Make use of the new features in genirq:

1) Set the chip flag IRCHIP_EOI_IF_HANDLED, which ensures in the
   core code that irq_eoi() is only called when the interrupt was
   handled. That removes the extra status check in the callback.

2) Use the preflow handler, which is called from the fasteoi core code
   before the device handler. That avoids another status check and the
   open coded handler redirection.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: sparclinux@vger.kernel.org

---
 arch/sparc/Kconfig         |    1 +
 arch/sparc/kernel/irq_64.c |   32 ++++++++------------------------
 2 files changed, 9 insertions(+), 24 deletions(-)

Index: linux-2.6/arch/sparc/Kconfig
=================================--- linux-2.6.orig/arch/sparc/Kconfig
+++ linux-2.6/arch/sparc/Kconfig
@@ -52,6 +52,7 @@ config SPARC64
 	select PERF_USE_VMALLOC
 	select HAVE_GENERIC_HARDIRQS
 	select GENERIC_HARDIRQS_NO_DEPRECATED
+	select IRQ_PREFLOW_FASTEOI
 
 config ARCH_DEFCONFIG
 	string
Index: linux-2.6/arch/sparc/kernel/irq_64.c
=================================--- linux-2.6.orig/arch/sparc/kernel/irq_64.c
+++ linux-2.6/arch/sparc/kernel/irq_64.c
@@ -344,10 +344,6 @@ static void sun4u_irq_disable(struct irq
 static void sun4u_irq_eoi(struct irq_data *data)
 {
 	struct irq_handler_data *handler_data = data->handler_data;
-	struct irq_desc *desc = irq_desc + data->irq;
-
-	if (unlikely(desc->status & (IRQ_DISABLED|IRQ_INPROGRESS)))
-		return;
 
 	if (likely(handler_data))
 		upa_writeq(ICLR_IDLE, handler_data->iclr);
@@ -402,12 +398,8 @@ static void sun4v_irq_disable(struct irq
 static void sun4v_irq_eoi(struct irq_data *data)
 {
 	unsigned int ino = irq_table[data->irq].dev_ino;
-	struct irq_desc *desc = irq_desc + data->irq;
 	int err;
 
-	if (unlikely(desc->status & (IRQ_DISABLED|IRQ_INPROGRESS)))
-		return;
-
 	err = sun4v_intr_setstate(ino, HV_INTR_STATE_IDLE);
 	if (err != HV_EOK)
 		printk(KERN_ERR "sun4v_intr_setstate(%x): "
@@ -481,13 +473,9 @@ static void sun4v_virq_disable(struct ir
 
 static void sun4v_virq_eoi(struct irq_data *data)
 {
-	struct irq_desc *desc = irq_desc + data->irq;
 	unsigned long dev_handle, dev_ino;
 	int err;
 
-	if (unlikely(desc->status & (IRQ_DISABLED|IRQ_INPROGRESS)))
-		return;
-
 	dev_handle = irq_table[data->irq].dev_handle;
 	dev_ino = irq_table[data->irq].dev_ino;
 
@@ -505,6 +493,7 @@ static struct irq_chip sun4u_irq = {
 	.irq_disable		= sun4u_irq_disable,
 	.irq_eoi		= sun4u_irq_eoi,
 	.irq_set_affinity	= sun4u_set_affinity,
+	.flags			= IRQCHIP_EOI_IF_HANDLED,
 };
 
 static struct irq_chip sun4v_irq = {
@@ -513,6 +502,7 @@ static struct irq_chip sun4v_irq = {
 	.irq_disable		= sun4v_irq_disable,
 	.irq_eoi		= sun4v_irq_eoi,
 	.irq_set_affinity	= sun4v_set_affinity,
+	.flags			= IRQCHIP_EOI_IF_HANDLED,
 };
 
 static struct irq_chip sun4v_virq = {
@@ -521,16 +511,15 @@ static struct irq_chip sun4v_virq = {
 	.irq_disable		= sun4v_virq_disable,
 	.irq_eoi		= sun4v_virq_eoi,
 	.irq_set_affinity	= sun4v_virt_set_affinity,
+	.flags			= IRQCHIP_EOI_IF_HANDLED,
 };
 
-static void pre_flow_handler(unsigned int irq, struct irq_desc *desc)
+static void pre_flow_handler(struct irq_data *d)
 {
-	struct irq_handler_data *handler_data = get_irq_data(irq);
-	unsigned int ino = irq_table[irq].dev_ino;
+	struct irq_handler_data *handler_data = irq_data_get_irq_handler_data(d);
+	unsigned int ino = irq_table[d->irq].dev_ino;
 
 	handler_data->pre_handler(ino, handler_data->arg1, handler_data->arg2);
-
-	handle_fasteoi_irq(irq, desc);
 }
 
 void irq_install_pre_handler(int irq,
@@ -538,13 +527,12 @@ void irq_install_pre_handler(int irq,
 			     void *arg1, void *arg2)
 {
 	struct irq_handler_data *handler_data = get_irq_data(irq);
-	struct irq_desc *desc = irq_desc + irq;
 
 	handler_data->pre_handler = func;
 	handler_data->arg1 = arg1;
 	handler_data->arg2 = arg2;
 
-	desc->handle_irq = pre_flow_handler;
+	__irq_set_preflow_handler(virt_irq, pre_flow_handler);
 }
 
 unsigned int build_irq(int inofixup, unsigned long iclr, unsigned long imap)
@@ -734,7 +722,6 @@ void __irq_entry handler_irq(int pil, st
 	orig_sp = set_hardirq_stack();
 
 	while (bucket_pa) {
-		struct irq_desc *desc;
 		unsigned long next_pa;
 		unsigned int irq;
 
@@ -742,10 +729,7 @@ void __irq_entry handler_irq(int pil, st
 		irq = bucket_get_irq(bucket_pa);
 		bucket_clear_chain_pa(bucket_pa);
 
-		desc = irq_desc + irq;
-
-		if (!(desc->status & IRQ_DISABLED))
-			desc->handle_irq(irq, desc);
+		generic_handle_irq(irq);
 
 		bucket_pa = next_pa;
 	}




