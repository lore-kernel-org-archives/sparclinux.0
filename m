From: Jiang Liu <jiang.liu@linux.intel.com>
Date: Mon, 04 May 2015 03:15:32 +0000
Subject: [RFC v1 04/11] genirq: Move field 'handler_data' from struct irq_data into struct irq_common_data
Message-Id: <1430709339-29083-5-git-send-email-jiang.liu@linux.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1430709339-29083-1-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1430709339-29083-1-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Randy Dunlap <rdunlap@infradead.org>, Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>, "David S. Miller" <davem@davemloft.net>, x86@kernel.org, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, bob picco <bpicco@meloft.net>, Jiang Liu <jiang.liu@linux.intel.com>, Andy Lutomirski <luto@amacapital.net>, Jason Cooper <jason@lakedaemon.net>, Grant Likely <grant.likely@linaro.org>, Kevin Cernekee <cernekee@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, sparclinux@vger.kernel.org, linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org

Handler data (handler_data) is per-irq instead of per irqchip, so move
it into struct irq_common_data.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/sparc/kernel/irq_64.c    |   15 +++++++++------
 arch/sparc/kernel/sun4d_irq.c |    4 ++--
 arch/sparc/kernel/sun4m_irq.c |    6 ++++--
 arch/x86/kernel/apic/msi.c    |    2 +-
 arch/x86/kernel/hpet.c        |    4 ++--
 drivers/gpio/gpio-davinci.c   |    2 +-
 drivers/sh/intc/virq.c        |    4 ++--
 include/linux/irq.h           |    8 ++++----
 include/linux/irqdesc.h       |    2 +-
 kernel/irq/chip.c             |    2 +-
 kernel/irq/irqdesc.c          |    3 ++-
 11 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index 4033c23bdfa6..5130f6e3e68e 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -210,21 +210,21 @@ struct irq_handler_data {
 
 static inline unsigned int irq_data_to_handle(struct irq_data *data)
 {
-	struct irq_handler_data *ihd = data->handler_data;
+	struct irq_handler_data *ihd = irq_data_get_irq_handler_data(data);
 
 	return ihd->dev_handle;
 }
 
 static inline unsigned int irq_data_to_ino(struct irq_data *data)
 {
-	struct irq_handler_data *ihd = data->handler_data;
+	struct irq_handler_data *ihd = irq_data_get_irq_handler_data(data);
 
 	return ihd->dev_ino;
 }
 
 static inline unsigned long irq_data_to_sysino(struct irq_data *data)
 {
-	struct irq_handler_data *ihd = data->handler_data;
+	struct irq_handler_data *ihd = irq_data_get_irq_handler_data(data);
 
 	return ihd->sysino;
 }
@@ -370,8 +370,9 @@ static int irq_choose_cpu(unsigned int irq, const struct cpumask *affinity)
 
 static void sun4u_irq_enable(struct irq_data *data)
 {
-	struct irq_handler_data *handler_data = data->handler_data;
+	struct irq_handler_data *handler_data;
 
+	handler_data = irq_data_get_irq_handler_data(data);
 	if (likely(handler_data)) {
 		unsigned long cpuid, imap, val;
 		unsigned int tid;
@@ -393,8 +394,9 @@ static void sun4u_irq_enable(struct irq_data *data)
 static int sun4u_set_affinity(struct irq_data *data,
 			       const struct cpumask *mask, bool force)
 {
-	struct irq_handler_data *handler_data = data->handler_data;
+	struct irq_handler_data *handler_data;
 
+	handler_data = irq_data_get_irq_handler_data(data);
 	if (likely(handler_data)) {
 		unsigned long cpuid, imap, val;
 		unsigned int tid;
@@ -438,8 +440,9 @@ static void sun4u_irq_disable(struct irq_data *data)
 
 static void sun4u_irq_eoi(struct irq_data *data)
 {
-	struct irq_handler_data *handler_data = data->handler_data;
+	struct irq_handler_data *handler_data;
 
+	handler_data = irq_data_get_irq_handler_data(data);
 	if (likely(handler_data))
 		upa_writeq(ICLR_IDLE, handler_data->iclr);
 }
diff --git a/arch/sparc/kernel/sun4d_irq.c b/arch/sparc/kernel/sun4d_irq.c
index a1bb2675b280..a87d0e47c168 100644
--- a/arch/sparc/kernel/sun4d_irq.c
+++ b/arch/sparc/kernel/sun4d_irq.c
@@ -188,7 +188,7 @@ void sun4d_handler_irq(unsigned int pil, struct pt_regs *regs)
 
 static void sun4d_mask_irq(struct irq_data *data)
 {
-	struct sun4d_handler_data *handler_data = data->handler_data;
+	struct sun4d_handler_data *handler_data = irq_data_get_irq_handler_data(data);
 	unsigned int real_irq;
 #ifdef CONFIG_SMP
 	int cpuid = handler_data->cpuid;
@@ -206,7 +206,7 @@ static void sun4d_mask_irq(struct irq_data *data)
 
 static void sun4d_unmask_irq(struct irq_data *data)
 {
-	struct sun4d_handler_data *handler_data = data->handler_data;
+	struct sun4d_handler_data *handler_data = irq_data_get_irq_handler_data(data);
 	unsigned int real_irq;
 #ifdef CONFIG_SMP
 	int cpuid = handler_data->cpuid;
diff --git a/arch/sparc/kernel/sun4m_irq.c b/arch/sparc/kernel/sun4m_irq.c
index 8bb3b3fddea7..da737c712fa8 100644
--- a/arch/sparc/kernel/sun4m_irq.c
+++ b/arch/sparc/kernel/sun4m_irq.c
@@ -188,9 +188,10 @@ static unsigned long sun4m_imask[0x50] = {
 
 static void sun4m_mask_irq(struct irq_data *data)
 {
-	struct sun4m_handler_data *handler_data = data->handler_data;
+	struct sun4m_handler_data *handler_data;
 	int cpu = smp_processor_id();
 
+	handler_data = irq_data_get_irq_handler_data(data);
 	if (handler_data->mask) {
 		unsigned long flags;
 
@@ -206,9 +207,10 @@ static void sun4m_mask_irq(struct irq_data *data)
 
 static void sun4m_unmask_irq(struct irq_data *data)
 {
-	struct sun4m_handler_data *handler_data = data->handler_data;
+	struct sun4m_handler_data *handler_data;
 	int cpu = smp_processor_id();
 
+	handler_data = irq_data_get_irq_handler_data(data);
 	if (handler_data->mask) {
 		unsigned long flags;
 
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 58fde664e7c0..e87655fcf30e 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -263,7 +263,7 @@ static inline int hpet_dev_id(struct irq_domain *domain)
 
 static void hpet_msi_write_msg(struct irq_data *data, struct msi_msg *msg)
 {
-	hpet_msi_write(data->handler_data, msg);
+	hpet_msi_write(irq_data_get_irq_handler_data(data), msg);
 }
 
 static struct irq_chip hpet_msi_controller = {
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index e2449cf38b06..40cf79a55fe7 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -426,7 +426,7 @@ static struct irq_domain *hpet_domain;
 
 void hpet_msi_unmask(struct irq_data *data)
 {
-	struct hpet_dev *hdev = data->handler_data;
+	struct hpet_dev *hdev = irq_data_get_irq_handler_data(data);
 	unsigned int cfg;
 
 	/* unmask it */
@@ -437,7 +437,7 @@ void hpet_msi_unmask(struct irq_data *data)
 
 void hpet_msi_mask(struct irq_data *data)
 {
-	struct hpet_dev *hdev = data->handler_data;
+	struct hpet_dev *hdev = irq_data_get_irq_handler_data(data);
 	unsigned int cfg;
 
 	/* mask it */
diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index c5e05c82d67c..477d5b8616ab 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -396,7 +396,7 @@ static int gpio_irq_type_unbanked(struct irq_data *data, unsigned trigger)
 	struct davinci_gpio_regs __iomem *g;
 	u32 mask;
 
-	d = (struct davinci_gpio_controller *)data->handler_data;
+	d = (struct davinci_gpio_controller *)irq_data_get_irq_handler_data(data);
 	g = (struct davinci_gpio_regs __iomem *)d->regs;
 	mask = __gpio_mask(data->irq - d->gpio_irq);
 
diff --git a/drivers/sh/intc/virq.c b/drivers/sh/intc/virq.c
index f30ac9354ff2..3dbc21696924 100644
--- a/drivers/sh/intc/virq.c
+++ b/drivers/sh/intc/virq.c
@@ -87,8 +87,8 @@ static int add_virq_to_pirq(unsigned int irq, unsigned int virq)
 	struct irq_data *data = irq_get_irq_data(irq);
 
 	/* scan for duplicates */
-	last = (struct intc_virq_list **)&data->handler_data;
-	for_each_virq(entry, data->handler_data) {
+	last = (struct intc_virq_list **)&data->common->handler_data;
+	for_each_virq(entry, irq_data_get_irq_handler_data(data)) {
 		if (entry->irq = virq)
 			return 0;
 		last = &entry->next;
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 0138f046642c..43581e166298 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -130,12 +130,14 @@ struct irq_domain;
  * @state_use_accessors: status information for irq chip functions.
  *			Use accessor functions to deal with it
  * @node:		node index useful for balancing
+ * @handler_data:	per-IRQ data for the irq_chip methods
  */
 struct irq_common_data {
 	unsigned int		state_use_accessors;
 #ifdef CONFIG_NUMA
 	unsigned int		node;
 #endif
+	void			*handler_data;
 };
 
 /**
@@ -149,7 +151,6 @@ struct irq_common_data {
  *			between hwirq number and linux irq number.
  * @parent_data:	pointer to parent struct irq_data to support hierarchy
  *			irq_domain
- * @handler_data:	per-IRQ data for the irq_chip methods
  * @chip_data:		platform-specific per-chip private data for the chip
  *			methods, to allow shared chip implementations
  * @msi_desc:		MSI descriptor
@@ -169,7 +170,6 @@ struct irq_data {
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 	struct irq_data		*parent_data;
 #endif
-	void			*handler_data;
 	void			*chip_data;
 	struct msi_desc		*msi_desc;
 	cpumask_var_t		affinity;
@@ -611,12 +611,12 @@ static inline void *irq_data_get_irq_chip_data(struct irq_data *d)
 static inline void *irq_get_handler_data(unsigned int irq)
 {
 	struct irq_data *d = irq_get_irq_data(irq);
-	return d ? d->handler_data : NULL;
+	return d ? d->common->handler_data : NULL;
 }
 
 static inline void *irq_data_get_irq_handler_data(struct irq_data *d)
 {
-	return d->handler_data;
+	return d->common->handler_data;
 }
 
 static inline struct msi_desc *irq_get_msi_desc(unsigned int irq)
diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 3010e99abf3e..5d5776f40129 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -111,7 +111,7 @@ static inline void *irq_desc_get_chip_data(struct irq_desc *desc)
 
 static inline void *irq_desc_get_handler_data(struct irq_desc *desc)
 {
-	return desc->irq_data.handler_data;
+	return desc->irq_common_data.handler_data;
 }
 
 static inline struct msi_desc *irq_desc_get_msi_desc(struct irq_desc *desc)
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index eb9a4ea394ab..46c487fc71dd 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -83,7 +83,7 @@ int irq_set_handler_data(unsigned int irq, void *data)
 
 	if (!desc)
 		return -EINVAL;
-	desc->irq_data.handler_data = data;
+	desc->irq_common_data.handler_data = data;
 	irq_put_desc_unlock(desc, flags);
 	return 0;
 }
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 0c3057e42906..7f881792ad5f 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -72,11 +72,12 @@ static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int node,
 {
 	int cpu;
 
+	desc->irq_common_data.handler_data = NULL;
+
 	desc->irq_data.common = &desc->irq_common_data;
 	desc->irq_data.irq = irq;
 	desc->irq_data.chip = &no_irq_chip;
 	desc->irq_data.chip_data = NULL;
-	desc->irq_data.handler_data = NULL;
 	desc->irq_data.msi_desc = NULL;
 	irq_settings_clr_and_set(desc, ~0, _IRQ_DEFAULT_INIT_FLAGS);
 	irqd_set(&desc->irq_data, IRQD_IRQ_DISABLED);
-- 
1.7.10.4

