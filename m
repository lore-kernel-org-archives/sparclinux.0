From: Daniel Hellstrom <daniel@gaisler.com>
Date: Tue, 19 Apr 2011 16:07:19 +0000
Subject: [PATCH 7/7] sparc32,leon: implement genirq CPU affinity
Message-Id: <1303229239-21551-7-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

A simple implementation of CPU affinity, the first CPU in
the affinity CPU mask always takes the IRQ.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/kernel/leon_kernel.c |   66 +++++++++++++++++++++++++++++++++------
 1 files changed, 56 insertions(+), 10 deletions(-)

diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index 26acc75..e12f4e8 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -100,25 +100,68 @@ static inline unsigned long get_irqmask(unsigned int irq)
 	return mask;
 }
 
+#ifdef CONFIG_SMP
+static int irq_choose_cpu(const struct cpumask *affinity)
+{
+	cpumask_t mask;
+
+	cpus_and(mask, cpu_online_map, *affinity);
+	if (cpus_equal(mask, cpu_online_map) || cpus_empty(mask))
+		return leon3_boot_cpu;
+	else
+		return first_cpu(mask);
+}
+
+int leon_set_affinity(struct irq_data *data, const struct cpumask *dest,
+		      bool force)
+{
+	unsigned long mask, oldmask, flags;
+	int oldcpu, newcpu;
+
+	mask = (unsigned long)data->chip_data;
+	oldcpu = irq_choose_cpu(data->affinity);
+	newcpu = irq_choose_cpu(dest);
+
+	if (oldcpu = newcpu)
+		goto out;
+
+	/* unmask on old CPU first before enabling on the selected CPU */
+	spin_lock_irqsave(&leon_irq_lock, flags);
+	oldmask = LEON3_BYPASS_LOAD_PA(LEON_IMASK(oldcpu));
+	LEON3_BYPASS_STORE_PA(LEON_IMASK(oldcpu), (oldmask & ~mask));
+	oldmask = LEON3_BYPASS_LOAD_PA(LEON_IMASK(newcpu));
+	LEON3_BYPASS_STORE_PA(LEON_IMASK(newcpu), (oldmask | mask));
+	spin_unlock_irqrestore(&leon_irq_lock, flags);
+out:
+	return IRQ_SET_MASK_OK;
+}
+#else
+#define irq_choose_cpu(affinity) leon3_boot_cpu
+#endif
+
 static void leon_unmask_irq(struct irq_data *data)
 {
 	unsigned long mask, oldmask, flags;
+	int cpu;
 
 	mask = (unsigned long)data->chip_data;
+	cpu = irq_choose_cpu(data->affinity);
 	spin_lock_irqsave(&leon_irq_lock, flags);
-	oldmask = LEON3_BYPASS_LOAD_PA(LEON_IMASK(leon3_boot_cpu));
-	LEON3_BYPASS_STORE_PA(LEON_IMASK(leon3_boot_cpu), (oldmask | mask));
+	oldmask = LEON3_BYPASS_LOAD_PA(LEON_IMASK(cpu));
+	LEON3_BYPASS_STORE_PA(LEON_IMASK(cpu), (oldmask | mask));
 	spin_unlock_irqrestore(&leon_irq_lock, flags);
 }
 
 static void leon_mask_irq(struct irq_data *data)
 {
 	unsigned long mask, oldmask, flags;
+	int cpu;
 
 	mask = (unsigned long)data->chip_data;
+	cpu = irq_choose_cpu(data->affinity);
 	spin_lock_irqsave(&leon_irq_lock, flags);
-	oldmask = LEON3_BYPASS_LOAD_PA(LEON_IMASK(leon3_boot_cpu));
-	LEON3_BYPASS_STORE_PA(LEON_IMASK(leon3_boot_cpu), (oldmask & ~mask));
+	oldmask = LEON3_BYPASS_LOAD_PA(LEON_IMASK(cpu));
+	LEON3_BYPASS_STORE_PA(LEON_IMASK(cpu), (oldmask & ~mask));
 	spin_unlock_irqrestore(&leon_irq_lock, flags);
 }
 
@@ -145,12 +188,15 @@ static void leon_eoi_irq(struct irq_data *data)
 }
 
 static struct irq_chip leon_irq = {
-	.name		= "leon",
-	.irq_startup	= leon_startup_irq,
-	.irq_shutdown	= leon_shutdown_irq,
-	.irq_mask	= leon_mask_irq,
-	.irq_unmask	= leon_unmask_irq,
-	.irq_eoi	= leon_eoi_irq,
+	.name			= "leon",
+	.irq_startup		= leon_startup_irq,
+	.irq_shutdown		= leon_shutdown_irq,
+	.irq_mask		= leon_mask_irq,
+	.irq_unmask		= leon_unmask_irq,
+	.irq_eoi		= leon_eoi_irq,
+#ifdef CONFIG_SMP
+	.irq_set_affinity	= leon_set_affinity,
+#endif
 };
 
 /*
-- 
1.5.4

