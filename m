From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 22 Jan 2011 21:32:19 +0000
Subject: [PATCH 6/7] sparc64: rename virt_irq => irq - I
Message-Id: <1295731940-31697-6-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The generic irq support uses the term 'irq' for the
allocated irq number.
Fix it so sparc64 use the same term for an irq as the
generic irq support does.
For a naive reader this is less confusing.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/entry.h  |    4 +-
 arch/sparc/kernel/irq_64.c |  153 +++++++++++++++++++++----------------------
 2 files changed, 77 insertions(+), 80 deletions(-)

diff --git a/arch/sparc/kernel/entry.h b/arch/sparc/kernel/entry.h
index c011b93..d1f1361 100644
--- a/arch/sparc/kernel/entry.h
+++ b/arch/sparc/kernel/entry.h
@@ -213,8 +213,8 @@ extern struct cheetah_err_info *cheetah_error_log;
 struct ino_bucket {
 /*0x00*/unsigned long __irq_chain_pa;
 
-	/* Virtual interrupt number assigned to this INO.  */
-/*0x08*/unsigned int __virt_irq;
+	/* Interrupt number assigned to this INO.  */
+/*0x08*/unsigned int __irq;
 /*0x0c*/unsigned int __pad;
 };
 
diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index f356e4c..eb16e3b 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -82,7 +82,7 @@ static void bucket_clear_chain_pa(unsigned long bucket_pa)
 			       "i" (ASI_PHYS_USE_EC));
 }
 
-static unsigned int bucket_get_virt_irq(unsigned long bucket_pa)
+static unsigned int bucket_get_irq(unsigned long bucket_pa)
 {
 	unsigned int ret;
 
@@ -90,21 +90,20 @@ static unsigned int bucket_get_virt_irq(unsigned long bucket_pa)
 			     : "=&r" (ret)
 			     : "r" (bucket_pa +
 				    offsetof(struct ino_bucket,
-					     __virt_irq)),
+					     __irq)),
 			       "i" (ASI_PHYS_USE_EC));
 
 	return ret;
 }
 
-static void bucket_set_virt_irq(unsigned long bucket_pa,
-				unsigned int virt_irq)
+static void bucket_set_irq(unsigned long bucket_pa, unsigned int irq)
 {
 	__asm__ __volatile__("stwa	%0, [%1] %2"
 			     : /* no outputs */
-			     : "r" (virt_irq),
+			     : "r" (irq),
 			       "r" (bucket_pa +
 				    offsetof(struct ino_bucket,
-					     __virt_irq)),
+					     __irq)),
 			       "i" (ASI_PHYS_USE_EC));
 }
 
@@ -114,50 +113,49 @@ static struct {
 	unsigned int dev_handle;
 	unsigned int dev_ino;
 	unsigned int in_use;
-} virt_irq_table[NR_IRQS];
-static DEFINE_SPINLOCK(virt_irq_alloc_lock);
+} irq_table[NR_IRQS];
+static DEFINE_SPINLOCK(irq_alloc_lock);
 
-unsigned char virt_irq_alloc(unsigned int dev_handle,
-			     unsigned int dev_ino)
+unsigned char irq_alloc(unsigned int dev_handle, unsigned int dev_ino)
 {
 	unsigned long flags;
 	unsigned char ent;
 
 	BUILD_BUG_ON(NR_IRQS >= 256);
 
-	spin_lock_irqsave(&virt_irq_alloc_lock, flags);
+	spin_lock_irqsave(&irq_alloc_lock, flags);
 
 	for (ent = 1; ent < NR_IRQS; ent++) {
-		if (!virt_irq_table[ent].in_use)
+		if (!irq_table[ent].in_use)
 			break;
 	}
 	if (ent >= NR_IRQS) {
 		printk(KERN_ERR "IRQ: Out of virtual IRQs.\n");
 		ent = 0;
 	} else {
-		virt_irq_table[ent].dev_handle = dev_handle;
-		virt_irq_table[ent].dev_ino = dev_ino;
-		virt_irq_table[ent].in_use = 1;
+		irq_table[ent].dev_handle = dev_handle;
+		irq_table[ent].dev_ino = dev_ino;
+		irq_table[ent].in_use = 1;
 	}
 
-	spin_unlock_irqrestore(&virt_irq_alloc_lock, flags);
+	spin_unlock_irqrestore(&irq_alloc_lock, flags);
 
 	return ent;
 }
 
 #ifdef CONFIG_PCI_MSI
-void virt_irq_free(unsigned int virt_irq)
+void irq_free(unsigned int irq)
 {
 	unsigned long flags;
 
-	if (virt_irq >= NR_IRQS)
+	if (irq >= NR_IRQS)
 		return;
 
-	spin_lock_irqsave(&virt_irq_alloc_lock, flags);
+	spin_lock_irqsave(&irq_alloc_lock, flags);
 
-	virt_irq_table[virt_irq].in_use = 0;
+	irq_table[irq].in_use = 0;
 
-	spin_unlock_irqrestore(&virt_irq_alloc_lock, flags);
+	spin_unlock_irqrestore(&irq_alloc_lock, flags);
 }
 #endif
 
@@ -253,25 +251,25 @@ struct irq_handler_data {
 };
 
 #ifdef CONFIG_SMP
-static int irq_choose_cpu(unsigned int virt_irq, const struct cpumask *affinity)
+static int irq_choose_cpu(unsigned int irq, const struct cpumask *affinity)
 {
 	cpumask_t mask;
 	int cpuid;
 
 	cpumask_copy(&mask, affinity);
 	if (cpus_equal(mask, cpu_online_map)) {
-		cpuid = map_to_cpu(virt_irq);
+		cpuid = map_to_cpu(irq);
 	} else {
 		cpumask_t tmp;
 
 		cpus_and(tmp, cpu_online_map, mask);
-		cpuid = cpus_empty(tmp) ? map_to_cpu(virt_irq) : first_cpu(tmp);
+		cpuid = cpus_empty(tmp) ? map_to_cpu(irq) : first_cpu(tmp);
 	}
 
 	return cpuid;
 }
 #else
-#define irq_choose_cpu(virt_irq, affinity)	\
+#define irq_choose_cpu(irq, affinity)	\
 	real_hard_smp_processor_id()
 #endif
 
@@ -357,7 +355,7 @@ static void sun4u_irq_eoi(struct irq_data *data)
 
 static void sun4v_irq_enable(struct irq_data *data)
 {
-	unsigned int ino = virt_irq_table[data->irq].dev_ino;
+	unsigned int ino = irq_table[data->irq].dev_ino;
 	unsigned long cpuid = irq_choose_cpu(data->irq, data->affinity);
 	int err;
 
@@ -378,7 +376,7 @@ static void sun4v_irq_enable(struct irq_data *data)
 static int sun4v_set_affinity(struct irq_data *data,
 			       const struct cpumask *mask, bool force)
 {
-	unsigned int ino = virt_irq_table[data->irq].dev_ino;
+	unsigned int ino = irq_table[data->irq].dev_ino;
 	unsigned long cpuid = irq_choose_cpu(data->irq, mask);
 	int err;
 
@@ -392,7 +390,7 @@ static int sun4v_set_affinity(struct irq_data *data,
 
 static void sun4v_irq_disable(struct irq_data *data)
 {
-	unsigned int ino = virt_irq_table[data->irq].dev_ino;
+	unsigned int ino = irq_table[data->irq].dev_ino;
 	int err;
 
 	err = sun4v_intr_setenabled(ino, HV_INTR_DISABLED);
@@ -403,7 +401,7 @@ static void sun4v_irq_disable(struct irq_data *data)
 
 static void sun4v_irq_eoi(struct irq_data *data)
 {
-	unsigned int ino = virt_irq_table[data->irq].dev_ino;
+	unsigned int ino = irq_table[data->irq].dev_ino;
 	struct irq_desc *desc = irq_desc + data->irq;
 	int err;
 
@@ -423,8 +421,8 @@ static void sun4v_virq_enable(struct irq_data *data)
 
 	cpuid = irq_choose_cpu(data->irq, data->affinity);
 
-	dev_handle = virt_irq_table[data->irq].dev_handle;
-	dev_ino = virt_irq_table[data->irq].dev_ino;
+	dev_handle = irq_table[data->irq].dev_handle;
+	dev_ino = irq_table[data->irq].dev_ino;
 
 	err = sun4v_vintr_set_target(dev_handle, dev_ino, cpuid);
 	if (err != HV_EOK)
@@ -453,8 +451,8 @@ static int sun4v_virt_set_affinity(struct irq_data *data,
 
 	cpuid = irq_choose_cpu(data->irq, mask);
 
-	dev_handle = virt_irq_table[data->irq].dev_handle;
-	dev_ino = virt_irq_table[data->irq].dev_ino;
+	dev_handle = irq_table[data->irq].dev_handle;
+	dev_ino = irq_table[data->irq].dev_ino;
 
 	err = sun4v_vintr_set_target(dev_handle, dev_ino, cpuid);
 	if (err != HV_EOK)
@@ -470,8 +468,8 @@ static void sun4v_virq_disable(struct irq_data *data)
 	unsigned long dev_handle, dev_ino;
 	int err;
 
-	dev_handle = virt_irq_table[data->irq].dev_handle;
-	dev_ino = virt_irq_table[data->irq].dev_ino;
+	dev_handle = irq_table[data->irq].dev_handle;
+	dev_ino = irq_table[data->irq].dev_ino;
 
 	err = sun4v_vintr_set_valid(dev_handle, dev_ino,
 				    HV_INTR_DISABLED);
@@ -490,8 +488,8 @@ static void sun4v_virq_eoi(struct irq_data *data)
 	if (unlikely(desc->status & (IRQ_DISABLED|IRQ_INPROGRESS)))
 		return;
 
-	dev_handle = virt_irq_table[data->irq].dev_handle;
-	dev_ino = virt_irq_table[data->irq].dev_ino;
+	dev_handle = irq_table[data->irq].dev_handle;
+	dev_ino = irq_table[data->irq].dev_ino;
 
 	err = sun4v_vintr_set_state(dev_handle, dev_ino,
 				    HV_INTR_STATE_IDLE);
@@ -525,23 +523,22 @@ static struct irq_chip sun4v_virq = {
 	.irq_set_affinity	= sun4v_virt_set_affinity,
 };
 
-static void pre_flow_handler(unsigned int virt_irq,
-				      struct irq_desc *desc)
+static void pre_flow_handler(unsigned int irq, struct irq_desc *desc)
 {
-	struct irq_handler_data *handler_data = get_irq_data(virt_irq);
-	unsigned int ino = virt_irq_table[virt_irq].dev_ino;
+	struct irq_handler_data *handler_data = get_irq_data(irq);
+	unsigned int ino = irq_table[irq].dev_ino;
 
 	handler_data->pre_handler(ino, handler_data->arg1, handler_data->arg2);
 
-	handle_fasteoi_irq(virt_irq, desc);
+	handle_fasteoi_irq(irq, desc);
 }
 
-void irq_install_pre_handler(int virt_irq,
+void irq_install_pre_handler(int irq,
 			     void (*func)(unsigned int, void *, void *),
 			     void *arg1, void *arg2)
 {
-	struct irq_handler_data *handler_data = get_irq_data(virt_irq);
-	struct irq_desc *desc = irq_desc + virt_irq;
+	struct irq_handler_data *handler_data = get_irq_data(irq);
+	struct irq_desc *desc = irq_desc + irq;
 
 	handler_data->pre_handler = func;
 	handler_data->arg1 = arg1;
@@ -554,24 +551,24 @@ unsigned int build_irq(int inofixup, unsigned long iclr, unsigned long imap)
 {
 	struct ino_bucket *bucket;
 	struct irq_handler_data *handler_data;
-	unsigned int virt_irq;
+	unsigned int irq;
 	int ino;
 
 	BUG_ON(tlb_type = hypervisor);
 
 	ino = (upa_readq(imap) & (IMAP_IGN | IMAP_INO)) + inofixup;
 	bucket = &ivector_table[ino];
-	virt_irq = bucket_get_virt_irq(__pa(bucket));
-	if (!virt_irq) {
-		virt_irq = virt_irq_alloc(0, ino);
-		bucket_set_virt_irq(__pa(bucket), virt_irq);
-		set_irq_chip_and_handler_name(virt_irq,
+	irq = bucket_get_irq(__pa(bucket));
+	if (!irq) {
+		irq = irq_alloc(0, ino);
+		bucket_set_irq(__pa(bucket), irq);
+		set_irq_chip_and_handler_name(irq,
 					      &sun4u_irq,
 					      handle_fasteoi_irq,
 					      "IVEC");
 	}
 
-	handler_data = get_irq_data(virt_irq);
+	handler_data = get_irq_data(irq);
 	if (unlikely(handler_data))
 		goto out;
 
@@ -580,13 +577,13 @@ unsigned int build_irq(int inofixup, unsigned long iclr, unsigned long imap)
 		prom_printf("IRQ: kzalloc(irq_handler_data) failed.\n");
 		prom_halt();
 	}
-	set_irq_data(virt_irq, handler_data);
+	set_irq_data(irq, handler_data);
 
 	handler_data->imap  = imap;
 	handler_data->iclr  = iclr;
 
 out:
-	return virt_irq;
+	return irq;
 }
 
 static unsigned int sun4v_build_common(unsigned long sysino,
@@ -594,21 +591,21 @@ static unsigned int sun4v_build_common(unsigned long sysino,
 {
 	struct ino_bucket *bucket;
 	struct irq_handler_data *handler_data;
-	unsigned int virt_irq;
+	unsigned int irq;
 
 	BUG_ON(tlb_type != hypervisor);
 
 	bucket = &ivector_table[sysino];
-	virt_irq = bucket_get_virt_irq(__pa(bucket));
-	if (!virt_irq) {
-		virt_irq = virt_irq_alloc(0, sysino);
-		bucket_set_virt_irq(__pa(bucket), virt_irq);
-		set_irq_chip_and_handler_name(virt_irq, chip,
+	irq = bucket_get_irq(__pa(bucket));
+	if (!irq) {
+		irq = irq_alloc(0, sysino);
+		bucket_set_irq(__pa(bucket), irq);
+		set_irq_chip_and_handler_name(irq, chip,
 					      handle_fasteoi_irq,
 					      "IVEC");
 	}
 
-	handler_data = get_irq_data(virt_irq);
+	handler_data = get_irq_data(irq);
 	if (unlikely(handler_data))
 		goto out;
 
@@ -617,7 +614,7 @@ static unsigned int sun4v_build_common(unsigned long sysino,
 		prom_printf("IRQ: kzalloc(irq_handler_data) failed.\n");
 		prom_halt();
 	}
-	set_irq_data(virt_irq, handler_data);
+	set_irq_data(irq, handler_data);
 
 	/* Catch accidental accesses to these things.  IMAP/ICLR handling
 	 * is done by hypervisor calls on sun4v platforms, not by direct
@@ -627,7 +624,7 @@ static unsigned int sun4v_build_common(unsigned long sysino,
 	handler_data->iclr = ~0UL;
 
 out:
-	return virt_irq;
+	return irq;
 }
 
 unsigned int sun4v_build_irq(u32 devhandle, unsigned int devino)
@@ -643,7 +640,7 @@ unsigned int sun4v_build_virq(u32 devhandle, unsigned int devino)
 	unsigned long hv_err, cookie;
 	struct ino_bucket *bucket;
 	struct irq_desc *desc;
-	unsigned int virt_irq;
+	unsigned int irq;
 
 	bucket = kzalloc(sizeof(struct ino_bucket), GFP_ATOMIC);
 	if (unlikely(!bucket))
@@ -660,10 +657,10 @@ unsigned int sun4v_build_virq(u32 devhandle, unsigned int devino)
 			     ((unsigned long) bucket +
 			      sizeof(struct ino_bucket)));
 
-	virt_irq = virt_irq_alloc(devhandle, devino);
-	bucket_set_virt_irq(__pa(bucket), virt_irq);
+	irq = irq_alloc(devhandle, devino);
+	bucket_set_irq(__pa(bucket), irq);
 
-	set_irq_chip_and_handler_name(virt_irq, &sun4v_virq,
+	set_irq_chip_and_handler_name(irq, &sun4v_virq,
 				      handle_fasteoi_irq,
 				      "IVEC");
 
@@ -675,10 +672,10 @@ unsigned int sun4v_build_virq(u32 devhandle, unsigned int devino)
 	 * especially wrt. locking, we do not let request_irq() enable
 	 * the interrupt.
 	 */
-	desc = irq_desc + virt_irq;
+	desc = irq_desc + irq;
 	desc->status |= IRQ_NOAUTOEN;
 
-	set_irq_data(virt_irq, handler_data);
+	set_irq_data(irq, handler_data);
 
 	/* Catch accidental accesses to these things.  IMAP/ICLR handling
 	 * is done by hypervisor calls on sun4v platforms, not by direct
@@ -695,18 +692,18 @@ unsigned int sun4v_build_virq(u32 devhandle, unsigned int devino)
 		prom_halt();
 	}
 
-	return virt_irq;
+	return irq;
 }
 
-void ack_bad_irq(unsigned int virt_irq)
+void ack_bad_irq(unsigned int irq)
 {
-	unsigned int ino = virt_irq_table[virt_irq].dev_ino;
+	unsigned int ino = irq_table[irq].dev_ino;
 
 	if (!ino)
 		ino = 0xdeadbeef;
 
-	printk(KERN_CRIT "Unexpected IRQ from ino[%x] virt_irq[%u]\n",
-	       ino, virt_irq);
+	printk(KERN_CRIT "Unexpected IRQ from ino[%x] irq[%u]\n",
+	       ino, irq);
 }
 
 void *hardirq_stack[NR_CPUS];
@@ -739,16 +736,16 @@ void __irq_entry handler_irq(int pil, struct pt_regs *regs)
 	while (bucket_pa) {
 		struct irq_desc *desc;
 		unsigned long next_pa;
-		unsigned int virt_irq;
+		unsigned int irq;
 
 		next_pa = bucket_get_chain_pa(bucket_pa);
-		virt_irq = bucket_get_virt_irq(bucket_pa);
+		irq = bucket_get_irq(bucket_pa);
 		bucket_clear_chain_pa(bucket_pa);
 
-		desc = irq_desc + virt_irq;
+		desc = irq_desc + irq;
 
 		if (!(desc->status & IRQ_DISABLED))
-			desc->handle_irq(virt_irq, desc);
+			desc->handle_irq(irq, desc);
 
 		bucket_pa = next_pa;
 	}
-- 
1.6.0.6

