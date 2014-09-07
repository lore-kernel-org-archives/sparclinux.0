From: Bob Picco <bpicco@meloft.net>
Date: Sun, 07 Sep 2014 15:45:07 +0000
Subject: [PATCH] sparc64: sparse irq
Message-Id: <1410104707-21563-1-git-send-email-bpicco@meloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: bob picco <bpicco@meloft.net>

This patch attempts to do a few things. The highlights are:  1) provides the
option to enable SPARSE_IRQ, 2) allocates ivector_table at boot time and
3) default to cookie only VIRQ mechanism for supported firmware. The
first firmware with cookie only support for me appears on T5. You can
optionally force the HV firmware to not cookie only mode which is the
sysino support.

The sysino is a deprecated HV mechanism according to the most recent
SPARC Virtual Machine Specification. HV_GRP_INTR is what controls the
cookie/sysino firmware versioning. The history appears to be something like
this:
	major version 2 was dropped.
	major version 3 is where a cookie only VIRQ
	is possible. Using version 3 means ivector_table isn't required.

A new boot option is provided should cookie only HV support have issues.
hvirq - this is the version for HV_GRP_INTR. This is related to HV API
versioning.  The code attempts major=3 first by default. The option can
be used to override this default.

I've tested with SPARSE_IRQ on T5-8, M7-4 and T4-X and Ultra 45. I've also
tested Ultra45 (Jalap?no) with !SPARSE_IRQ.

Cc: sparclinux@vger.kernel.org
Signed-off-by: Bob Picco <bob.picco@oracle.com>
---
 arch/sparc/Kconfig              |    1 +
 arch/sparc/include/asm/irq_64.h |   22 ++-
 arch/sparc/kernel/irq_64.c      |  523 +++++++++++++++++++++++++++++++++------
 3 files changed, 464 insertions(+), 82 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index a537816..4ddb81e 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -67,6 +67,7 @@ config SPARC64
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_CONTEXT_TRACKING
 	select HAVE_DEBUG_KMEMLEAK
+	select MAY_HAVE_SPARSE_IRQ
 	select RTC_DRV_CMOS
 	select RTC_DRV_BQ4802
 	select RTC_DRV_SUN4V
diff --git a/arch/sparc/include/asm/irq_64.h b/arch/sparc/include/asm/irq_64.h
index 91d2193..54c2622 100644
--- a/arch/sparc/include/asm/irq_64.h
+++ b/arch/sparc/include/asm/irq_64.h
@@ -37,7 +37,17 @@
  *
  * ino_bucket->irq allocation is made during {sun4v_,}build_irq().
  */
-#define NR_IRQS    255
+#ifdef CONFIG_SPARSE_IRQ
+#if	NR_CPUS >	(1024)
+#define NR_IRQS		(8192)
+#elif	NR_CPUS >	(256)
+#define NR_IRQS		(4096)
+#else
+#define	NR_IRQS		(255)
+#endif
+#else
+#define NR_IRQS		(255)
+#endif
 
 void irq_install_pre_handler(int irq,
 			     void (*func)(unsigned int, void *, void *),
@@ -57,11 +67,15 @@ unsigned int sun4u_build_msi(u32 portid, unsigned int *irq_p,
 			     unsigned long iclr_base);
 void sun4u_destroy_msi(unsigned int irq);
 
-unsigned char irq_alloc(unsigned int dev_handle,
-			unsigned int dev_ino);
+#ifdef CONFIG_SPARSE_IRQ
+unsigned int irq_alloc(unsigned int dev_handle, unsigned int dev_ino);
+void irq_free(unsigned int irq);
+#else /* CONFIG_SPARSE_IRQ */
+unsigned char irq_alloc(unsigned int dev_handle, unsigned int dev_ino);
 #ifdef CONFIG_PCI_MSI
 void irq_free(unsigned int irq);
-#endif
+#endif /* CONFIG_PCI_MSI */
+#endif /* CONFIG_SPARSE_IRQ */
 
 void __init init_IRQ(void);
 void fixup_irqs(void);
diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index 666193f..52a094a 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -47,8 +47,6 @@
 #include "cpumap.h"
 #include "kstack.h"
 
-#define NUM_IVECS	(IMAP_INR + 1)
-
 struct ino_bucket *ivector_table;
 unsigned long ivector_table_pa;
 
@@ -107,6 +105,183 @@ static void bucket_set_irq(unsigned long bucket_pa, unsigned int irq)
 
 #define irq_work_pa(__cpu)	&(trap_block[(__cpu)].irq_worklist_pa)
 
+static unsigned long hvirq_major __initdata;
+static int __init early_hvirq_major(char *p)
+{
+	int rc = kstrtoul(p, 10, &hvirq_major);
+
+	return rc;
+}
+early_param("hvirq", early_hvirq_major);
+
+static unsigned long __init irq_group_hv(unsigned long major)
+{
+	unsigned long group = HV_GRP_INTR;
+	unsigned long minor = 0;
+	unsigned long hv_error;
+
+	hv_error = sun4v_hvapi_register(group, major, &minor);
+	if (hv_error)
+		pr_info("HV API register reported = %ld major = %ld\n",
+			hv_error, major);
+
+	return hv_error;
+}
+
+static int hv_irq_version;
+#define HVIRQ_MAJOR	3
+
+static void __init irq_init_hv(void)
+{
+	unsigned long hv_error, major;
+
+	if (tlb_type != hypervisor)
+		return;
+
+	if (hvirq_major)
+		major = hvirq_major;
+	else
+		major = HVIRQ_MAJOR;
+
+	hv_error = irq_group_hv(major);
+	if (!hv_error)
+		hv_irq_version = major;
+	else
+		hv_irq_version = HVIRQ_MAJOR - 1;
+}
+
+#ifdef CONFIG_SPARSE_IRQ
+/* This function is for the timer interrupt.*/
+int __init arch_probe_nr_irqs(void)
+{
+	return 1;
+}
+
+#define DEFAULT_NUM_IVECS	(0xfffU)
+static unsigned int nr_ivec = DEFAULT_NUM_IVECS;
+#define NUM_IVECS (nr_ivec)
+
+static unsigned int __init size_nr_ivec(void)
+{
+	if (tlb_type = hypervisor) {
+		switch (sun4v_chip_type) {
+		/* Athena's devhandle|devino is large.*/
+		case SUN4V_CHIP_SPARC64X:
+			nr_ivec = 0xffff;
+			break;
+		}
+	}
+	return nr_ivec;
+}
+
+struct irq_handler_data {
+	union {
+		struct {
+			unsigned int dev_handle;
+			unsigned int dev_ino;
+		};
+		unsigned long sysino;
+	};
+	struct ino_bucket bucket;
+	unsigned long	iclr;
+	unsigned long	imap;
+};
+
+static inline unsigned int irq_data_to_handle(struct irq_data *data)
+{
+	struct irq_handler_data *ihd = data->handler_data;
+
+	return ihd->dev_handle;
+}
+
+static inline unsigned int irq_data_to_ino(struct irq_data *data)
+{
+	struct irq_handler_data *ihd = data->handler_data;
+
+	return ihd->dev_ino;
+}
+
+static inline unsigned long irq_data_to_sysino(struct irq_data *data)
+{
+	struct irq_handler_data *ihd = data->handler_data;
+
+	return ihd->sysino;
+}
+
+void irq_free(unsigned int irq)
+{
+	void *data = irq_get_handler_data(irq);
+
+	kfree(data);
+	irq_set_handler_data(irq, NULL);
+	irq_free_descs(irq, 1);
+}
+
+unsigned int irq_alloc(unsigned int dev_handle, unsigned int dev_ino)
+{
+	int irq;
+
+	irq = __irq_alloc_descs(-1, 1, 1, -1, NULL);
+	if (irq <= 0)
+		goto out;
+
+	return irq;
+out:
+	return 0;
+}
+
+static unsigned int cookie_exists(u32 devhandle, unsigned int devino)
+{
+	unsigned long hv_err, cookie;
+	struct ino_bucket *bucket;
+	unsigned int irq = 0U;
+
+	hv_err = sun4v_vintr_get_cookie(devhandle, devino, &cookie);
+	if (hv_err) {
+		pr_err("HV get cookie failed hv_err = %ld\n", hv_err);
+		goto out;
+	}
+
+	if (cookie & ((1UL << 63UL))) {
+		cookie = ~cookie;
+		bucket = (struct ino_bucket *) __va(cookie);
+		irq = bucket->__irq;
+	}
+out:
+	return irq;
+}
+
+static unsigned int sysino_exists(u32 devhandle, unsigned int devino)
+{
+	unsigned long sysino = sun4v_devino_to_sysino(devhandle, devino);
+	struct ino_bucket *bucket;
+	unsigned int irq;
+
+	bucket = &ivector_table[sysino];
+	irq = bucket_get_irq(__pa(bucket));
+
+	return irq;
+}
+
+void ack_bad_irq(unsigned int irq)
+{
+	pr_crit("BAD IRQ ack %d\n", irq);
+}
+
+void irq_install_pre_handler(int irq,
+			     void (*func)(unsigned int, void *, void *),
+			     void *arg1, void *arg2)
+{
+	pr_warn("IRQ pre handler NOT supported.\n");
+}
+
+#else	/* !CONFIG_SPARSE_IRQ */
+#define NUM_IVECS	(IMAP_INR + 1)
+static unsigned int __init size_nr_ivec(void)
+{
+	return NUM_IVECS;
+}
+
 static struct {
 	unsigned int dev_handle;
 	unsigned int dev_ino;
@@ -114,6 +289,29 @@ static struct {
 } irq_table[NR_IRQS];
 static DEFINE_SPINLOCK(irq_alloc_lock);
 
+struct irq_handler_data {
+	unsigned long	iclr;
+	unsigned long	imap;
+	void		(*pre_handler)(unsigned int, void *, void *);
+	void		*arg1;
+	void		*arg2;
+};
+
+static inline unsigned int irq_data_to_handle(struct irq_data *data)
+{
+	return irq_table[data->irq].dev_handle;
+}
+
+static inline unsigned int irq_data_to_ino(struct irq_data *data)
+{
+	return irq_table[data->irq].dev_ino;
+}
+
+static inline unsigned int irq_data_to_sysino(struct irq_data *data)
+{
+	return irq_data_to_ino(data);
+}
+
 unsigned char irq_alloc(unsigned int dev_handle, unsigned int dev_ino)
 {
 	unsigned long flags;
@@ -156,6 +354,38 @@ void irq_free(unsigned int irq)
 	spin_unlock_irqrestore(&irq_alloc_lock, flags);
 }
 #endif
+void ack_bad_irq(unsigned int irq)
+{
+	unsigned int ino = irq_table[irq].dev_ino;
+
+	if (!ino)
+		ino = 0xdeadbeef;
+
+	pr_crit("Unexpected IRQ from ino[%x] irq[%u]\n", ino, irq);
+}
+
+static void pre_flow_handler(struct irq_data *d)
+{
+	struct irq_handler_data *handler_data +		irq_data_get_irq_handler_data(d);
+	unsigned int ino = irq_table[d->irq].dev_ino;
+
+	handler_data->pre_handler(ino, handler_data->arg1, handler_data->arg2);
+}
+
+void irq_install_pre_handler(int irq,
+			     void (*func)(unsigned int, void *, void *),
+			     void *arg1, void *arg2)
+{
+	struct irq_handler_data *handler_data = irq_get_handler_data(irq);
+
+	handler_data->pre_handler = func;
+	handler_data->arg1 = arg1;
+	handler_data->arg2 = arg2;
+
+	__irq_set_preflow_handler(irq, pre_flow_handler);
+}
+#endif	/* CONFIG_SPARSE_IRQ */
 
 /*
  * /proc/interrupts printing:
@@ -206,15 +436,6 @@ static unsigned int sun4u_compute_tid(unsigned long imap, unsigned long cpuid)
 	return tid;
 }
 
-struct irq_handler_data {
-	unsigned long	iclr;
-	unsigned long	imap;
-
-	void		(*pre_handler)(unsigned int, void *, void *);
-	void		*arg1;
-	void		*arg2;
-};
-
 #ifdef CONFIG_SMP
 static int irq_choose_cpu(unsigned int irq, const struct cpumask *affinity)
 {
@@ -316,8 +537,8 @@ static void sun4u_irq_eoi(struct irq_data *data)
 
 static void sun4v_irq_enable(struct irq_data *data)
 {
-	unsigned int ino = irq_table[data->irq].dev_ino;
 	unsigned long cpuid = irq_choose_cpu(data->irq, data->affinity);
+	unsigned int ino = irq_data_to_sysino(data);
 	int err;
 
 	err = sun4v_intr_settarget(ino, cpuid);
@@ -337,8 +558,8 @@ static void sun4v_irq_enable(struct irq_data *data)
 static int sun4v_set_affinity(struct irq_data *data,
 			       const struct cpumask *mask, bool force)
 {
-	unsigned int ino = irq_table[data->irq].dev_ino;
 	unsigned long cpuid = irq_choose_cpu(data->irq, mask);
+	unsigned int ino = irq_data_to_sysino(data);
 	int err;
 
 	err = sun4v_intr_settarget(ino, cpuid);
@@ -351,7 +572,7 @@ static int sun4v_set_affinity(struct irq_data *data,
 
 static void sun4v_irq_disable(struct irq_data *data)
 {
-	unsigned int ino = irq_table[data->irq].dev_ino;
+	unsigned int ino = irq_data_to_sysino(data);
 	int err;
 
 	err = sun4v_intr_setenabled(ino, HV_INTR_DISABLED);
@@ -362,7 +583,7 @@ static void sun4v_irq_disable(struct irq_data *data)
 
 static void sun4v_irq_eoi(struct irq_data *data)
 {
-	unsigned int ino = irq_table[data->irq].dev_ino;
+	unsigned int ino = irq_data_to_sysino(data);
 	int err;
 
 	err = sun4v_intr_setstate(ino, HV_INTR_STATE_IDLE);
@@ -373,14 +594,13 @@ static void sun4v_irq_eoi(struct irq_data *data)
 
 static void sun4v_virq_enable(struct irq_data *data)
 {
-	unsigned long cpuid, dev_handle, dev_ino;
+	unsigned long dev_handle = irq_data_to_handle(data);
+	unsigned long dev_ino = irq_data_to_ino(data);
+	unsigned long cpuid;
 	int err;
 
 	cpuid = irq_choose_cpu(data->irq, data->affinity);
 
-	dev_handle = irq_table[data->irq].dev_handle;
-	dev_ino = irq_table[data->irq].dev_ino;
-
 	err = sun4v_vintr_set_target(dev_handle, dev_ino, cpuid);
 	if (err != HV_EOK)
 		printk(KERN_ERR "sun4v_vintr_set_target(%lx,%lx,%lu): "
@@ -403,14 +623,13 @@ static void sun4v_virq_enable(struct irq_data *data)
 static int sun4v_virt_set_affinity(struct irq_data *data,
 				    const struct cpumask *mask, bool force)
 {
-	unsigned long cpuid, dev_handle, dev_ino;
+	unsigned long dev_handle = irq_data_to_handle(data);
+	unsigned long dev_ino = irq_data_to_ino(data);
+	unsigned long cpuid;
 	int err;
 
 	cpuid = irq_choose_cpu(data->irq, mask);
 
-	dev_handle = irq_table[data->irq].dev_handle;
-	dev_ino = irq_table[data->irq].dev_ino;
-
 	err = sun4v_vintr_set_target(dev_handle, dev_ino, cpuid);
 	if (err != HV_EOK)
 		printk(KERN_ERR "sun4v_vintr_set_target(%lx,%lx,%lu): "
@@ -422,11 +641,10 @@ static int sun4v_virt_set_affinity(struct irq_data *data,
 
 static void sun4v_virq_disable(struct irq_data *data)
 {
-	unsigned long dev_handle, dev_ino;
+	unsigned long dev_handle = irq_data_to_handle(data);
+	unsigned long dev_ino = irq_data_to_ino(data);
 	int err;
 
-	dev_handle = irq_table[data->irq].dev_handle;
-	dev_ino = irq_table[data->irq].dev_ino;
 
 	err = sun4v_vintr_set_valid(dev_handle, dev_ino,
 				    HV_INTR_DISABLED);
@@ -438,12 +656,10 @@ static void sun4v_virq_disable(struct irq_data *data)
 
 static void sun4v_virq_eoi(struct irq_data *data)
 {
-	unsigned long dev_handle, dev_ino;
+	unsigned long dev_handle = irq_data_to_handle(data);
+	unsigned long dev_ino = irq_data_to_ino(data);
 	int err;
 
-	dev_handle = irq_table[data->irq].dev_handle;
-	dev_ino = irq_table[data->irq].dev_ino;
-
 	err = sun4v_vintr_set_state(dev_handle, dev_ino,
 				    HV_INTR_STATE_IDLE);
 	if (err != HV_EOK)
@@ -479,31 +695,10 @@ static struct irq_chip sun4v_virq = {
 	.flags			= IRQCHIP_EOI_IF_HANDLED,
 };
 
-static void pre_flow_handler(struct irq_data *d)
-{
-	struct irq_handler_data *handler_data = irq_data_get_irq_handler_data(d);
-	unsigned int ino = irq_table[d->irq].dev_ino;
-
-	handler_data->pre_handler(ino, handler_data->arg1, handler_data->arg2);
-}
-
-void irq_install_pre_handler(int irq,
-			     void (*func)(unsigned int, void *, void *),
-			     void *arg1, void *arg2)
-{
-	struct irq_handler_data *handler_data = irq_get_handler_data(irq);
-
-	handler_data->pre_handler = func;
-	handler_data->arg1 = arg1;
-	handler_data->arg2 = arg2;
-
-	__irq_set_preflow_handler(irq, pre_flow_handler);
-}
-
 unsigned int build_irq(int inofixup, unsigned long iclr, unsigned long imap)
 {
-	struct ino_bucket *bucket;
 	struct irq_handler_data *handler_data;
+	struct ino_bucket *bucket;
 	unsigned int irq;
 	int ino;
 
@@ -537,11 +732,177 @@ unsigned int build_irq(int inofixup, unsigned long iclr, unsigned long imap)
 	return irq;
 }
 
-static unsigned int sun4v_build_common(unsigned long sysino,
-				       struct irq_chip *chip)
+#ifdef CONFIG_SPARSE_IRQ
+
+static unsigned int sun4v_build_common(u32 devhandle, unsigned int devino,
+		void (*handler_data_init)(struct irq_handler_data *data,
+		u32 devhandle, unsigned int devino),
+		struct irq_chip *chip)
+{
+	struct irq_handler_data *data;
+	unsigned int irq;
+
+	irq = irq_alloc(devhandle, devino);
+	if (!irq)
+		goto out;
+
+	data = kzalloc(sizeof(struct irq_handler_data), GFP_ATOMIC);
+	if (unlikely(!data)) {
+		pr_err("IRQ handler data allocation failed.\n");
+		irq_free(irq);
+		irq = 0;
+		goto out;
+	}
+
+	irq_set_handler_data(irq, data);
+	handler_data_init(data, devhandle, devino);
+	irq_set_chip_and_handler_name(irq, chip, handle_fasteoi_irq, "IVEC");
+	data->imap = ~0UL;
+	data->iclr = ~0UL;
+out:
+	return irq;
+}
+
+static unsigned long cookie_assign(unsigned int irq, u32 devhandle,
+		unsigned int devino)
+{
+	struct irq_handler_data *ihd = irq_get_handler_data(irq);
+	unsigned long hv_error, cookie;
+
+	/* handler_irq needs to find the irq. cookie is seen signed in
+	 * sun4v_dev_mondo and treated as a non ivector_table delivery.
+	 */
+	ihd->bucket.__irq = irq;
+	cookie = ~__pa(&ihd->bucket);
+
+	hv_error = sun4v_vintr_set_cookie(devhandle, devino, cookie);
+	if (hv_error)
+		pr_err("HV vintr set cookie failed = %ld\n", hv_error);
+
+	return hv_error;
+}
+
+static void cookie_handler_data(struct irq_handler_data *data,
+		u32 devhandle, unsigned int devino)
+{
+	data->dev_handle = devhandle;
+	data->dev_ino = devino;
+}
+
+static unsigned int cookie_build_irq(u32 devhandle, unsigned int devino,
+			struct irq_chip *chip)
+{
+	unsigned long hv_error;
+	unsigned int irq;
+
+	irq = sun4v_build_common(devhandle, devino, cookie_handler_data, chip);
+
+	hv_error = cookie_assign(irq, devhandle, devino);
+	if (hv_error) {
+		irq_free(irq);
+		irq = 0;
+	}
+
+	return irq;
+}
+
+static unsigned int sun4v_build_cookie(u32 devhandle, unsigned int devino)
+{
+	unsigned int irq;
+
+	irq = cookie_exists(devhandle, devino);
+	if (irq)
+		goto out;
+
+	irq = cookie_build_irq(devhandle, devino, &sun4v_virq);
+
+out:
+	return irq;
+}
+
+static void sysino_set_bucket(unsigned int irq)
 {
+	struct irq_handler_data *ihd = irq_get_handler_data(irq);
 	struct ino_bucket *bucket;
+	unsigned long sysino;
+
+	sysino = sun4v_devino_to_sysino(ihd->dev_handle, ihd->dev_ino);
+	BUG_ON(sysino >= nr_ivec);
+	bucket = &ivector_table[sysino];
+	bucket_set_irq(__pa(bucket), irq);
+}
+
+static void sysino_handler_data(struct irq_handler_data *data,
+		u32 devhandle, unsigned int devino)
+{
+	unsigned long sysino;
+
+	sysino = sun4v_devino_to_sysino(devhandle, devino);
+	data->sysino = sysino;
+}
+
+static unsigned int sysino_build_irq(u32 devhandle, unsigned int devino,
+				struct irq_chip *chip)
+{
+	unsigned int irq;
+
+	irq = sun4v_build_common(devhandle, devino, sysino_handler_data, chip);
+	if (!irq)
+		goto out;
+
+	sysino_set_bucket(irq);
+out:
+	return irq;
+}
+
+static int sun4v_build_sysino(u32 devhandle, unsigned int devino)
+{
+	int irq;
+
+	irq = sysino_exists(devhandle, devino);
+	if (irq)
+		goto out;
+
+	irq = sysino_build_irq(devhandle, devino, &sun4v_irq);
+out:
+	return irq;
+}
+
+unsigned int sun4v_build_irq(u32 devhandle, unsigned int devino)
+{
+	unsigned int irq;
+
+	if (hv_irq_version >= HVIRQ_MAJOR)
+		irq = sun4v_build_cookie(devhandle, devino);
+	else
+		irq = sun4v_build_sysino(devhandle, devino);
+
+	return irq;
+}
+
+unsigned int sun4v_build_virq(u32 devhandle, unsigned int devino)
+{
+	int irq;
+
+	irq = cookie_build_irq(devhandle, devino, &sun4v_virq);
+	if (!irq)
+		goto out;
+
+	/* This is borrowed from the original function.
+	 */
+	irq_set_status_flags(irq, IRQ_NOAUTOEN);
+
+out:
+	return irq;
+}
+
+#else /* !CONFIG_SPARSE_IRQ */
+static unsigned int sun4v_build_common(unsigned int devhandle,
+				unsigned int devino)
+{
+	unsigned long sysino = sun4v_devino_to_sysino(devhandle, devino);
 	struct irq_handler_data *handler_data;
+	struct ino_bucket *bucket;
 	unsigned int irq;
 
 	BUG_ON(tlb_type != hypervisor);
@@ -551,8 +912,8 @@ static unsigned int sun4v_build_common(unsigned long sysino,
 	if (!irq) {
 		irq = irq_alloc(0, sysino);
 		bucket_set_irq(__pa(bucket), irq);
-		irq_set_chip_and_handler_name(irq, chip, handle_fasteoi_irq,
-					      "IVEC");
+		irq_set_chip_and_handler_name(irq, &sun4v_irq,
+				handle_fasteoi_irq, "IVEC");
 	}
 
 	handler_data = irq_get_handler_data(irq);
@@ -579,9 +940,7 @@ static unsigned int sun4v_build_common(unsigned long sysino,
 
 unsigned int sun4v_build_irq(u32 devhandle, unsigned int devino)
 {
-	unsigned long sysino = sun4v_devino_to_sysino(devhandle, devino);
-
-	return sun4v_build_common(sysino, &sun4v_irq);
+	return sun4v_build_common(devhandle, devino);
 }
 
 unsigned int sun4v_build_virq(u32 devhandle, unsigned int devino)
@@ -640,17 +999,7 @@ unsigned int sun4v_build_virq(u32 devhandle, unsigned int devino)
 
 	return irq;
 }
-
-void ack_bad_irq(unsigned int irq)
-{
-	unsigned int ino = irq_table[irq].dev_ino;
-
-	if (!ino)
-		ino = 0xdeadbeef;
-
-	printk(KERN_CRIT "Unexpected IRQ from ino[%x] irq[%u]\n",
-	       ino, irq);
-}
+#endif /* CONFIG_SPARSE_IRQ */
 
 void *hardirq_stack[NR_CPUS];
 void *softirq_stack[NR_CPUS];
@@ -720,9 +1069,12 @@ void fixup_irqs(void)
 
 	for (irq = 0; irq < NR_IRQS; irq++) {
 		struct irq_desc *desc = irq_to_desc(irq);
-		struct irq_data *data = irq_desc_get_irq_data(desc);
+		struct irq_data *data;
 		unsigned long flags;
 
+		if (!desc)
+			continue;
+		data = irq_desc_get_irq_data(desc);
 		raw_spin_lock_irqsave(&desc->lock, flags);
 		if (desc->action && !irqd_is_per_cpu(data)) {
 			if (data->chip->irq_set_affinity)
@@ -922,16 +1274,22 @@ static struct irqaction timer_irq_action = {
 	.name = "timer",
 };
 
-/* Only invoked on boot processor. */
-void __init init_IRQ(void)
+static void __init irq_ivector_init(void)
 {
-	unsigned long size;
+	unsigned long size, order;
+	unsigned int ivecs;
 
-	map_prom_timers();
-	kill_prom_timer();
+	/* Version 3 of HV_GRP_INTR is known to function with cookie
+	 * only virq delivery. We'll hope and assume children function too.
+	 */
+	if (hv_irq_version >= HVIRQ_MAJOR)
+		return;
 
-	size = sizeof(struct ino_bucket) * NUM_IVECS;
-	ivector_table = kzalloc(size, GFP_KERNEL);
+	ivecs = size_nr_ivec();
+	size = sizeof(struct ino_bucket) * ivecs;
+	order = get_order(size);
+	ivector_table = (struct ino_bucket *) __get_free_pages(GFP_KERNEL |
+			__GFP_ZERO, order);
 	if (!ivector_table) {
 		prom_printf("Fatal error, cannot allocate ivector_table\n");
 		prom_halt();
@@ -940,6 +1298,15 @@ void __init init_IRQ(void)
 			     ((unsigned long) ivector_table) + size);
 
 	ivector_table_pa = __pa(ivector_table);
+}
+
+/* Only invoked on boot processor.*/
+void __init init_IRQ(void)
+{
+	irq_init_hv();
+	irq_ivector_init();
+	map_prom_timers();
+	kill_prom_timer();
 
 	if (tlb_type = hypervisor)
 		sun4v_init_mondo_queues();
-- 
1.7.1

