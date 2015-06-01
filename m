From: Jiang Liu <jiang.liu@linux.intel.com>
Date: Mon, 01 Jun 2015 08:05:17 +0000
Subject: [Patch v3 08/36] sparc, irq: Use helper irq_data_get_irq_handler_data() to hide irq_desc details
Message-Id: <1433145945-789-9-git-send-email-jiang.liu@linux.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Randy Dunlap <rdunlap@infradead.org>, Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>, "David S. Miller" <davem@davemloft.net>, bob picco <bpicco@meloft.net>, Jiang Liu <jiang.liu@linux.intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, sparclinux@vger.kernel.org

Use helper function irq_data_get_irq_handler_data() to hide irq_desc
implementation details.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/sparc/kernel/irq_64.c    |   15 +++++++++------
 arch/sparc/kernel/sun4d_irq.c |    4 ++--
 arch/sparc/kernel/sun4m_irq.c |    6 ++++--
 3 files changed, 15 insertions(+), 10 deletions(-)

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
 
-- 
1.7.10.4

