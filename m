From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 20 Apr 2011 09:41:26 +0000
Subject: [PATCH 7/8] sparc32,leon: implement genirq CPU affinity
Message-Id: <1303292487-12623-7-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

A simple implementation of CPU affinity, the first CPU in
the affinity CPU mask always takes the IRQ.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/leon_kernel.c |   64 ++++++++++++++++++++++++++++++++------
 1 files changed, 54 insertions(+), 10 deletions(-)

diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index d8fafea..ab14584 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -99,25 +99,68 @@ static inline unsigned long get_irqmask(unsigned int irq)
 	return mask;
 }
 
+#ifdef CONFIG_SMP
+static int irq_choose_cpu(const struct cpumask *affinity)
+{
+	cpumask_t mask;
+
+	cpus_and(mask, cpu_online_map, *affinity);
+	if (cpus_equal(mask, cpu_online_map) || cpus_empty(mask))
+		return 0;
+	else
+		return first_cpu(mask);
+}
+#else
+#define irq_choose_cpu(affinity) 0
+#endif
+
+static int leon_set_affinity(struct irq_data *data, const struct cpumask *dest,
+			     bool force)
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
+
 static void leon_unmask_irq(struct irq_data *data)
 {
 	unsigned long mask, oldmask, flags;
+	int cpu;
 
 	mask = (unsigned long)data->chip_data;
+	cpu = irq_choose_cpu(data->affinity);
 	spin_lock_irqsave(&leon_irq_lock, flags);
-	oldmask = LEON3_BYPASS_LOAD_PA(LEON_IMASK(0));
-	LEON3_BYPASS_STORE_PA(LEON_IMASK(0), (oldmask | mask));
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
-	oldmask = LEON3_BYPASS_LOAD_PA(LEON_IMASK(0));
-	LEON3_BYPASS_STORE_PA(LEON_IMASK(0), (oldmask & ~mask));
+	oldmask = LEON3_BYPASS_LOAD_PA(LEON_IMASK(cpu));
+	LEON3_BYPASS_STORE_PA(LEON_IMASK(cpu), (oldmask & ~mask));
 	spin_unlock_irqrestore(&leon_irq_lock, flags);
 }
 
@@ -144,12 +187,13 @@ static void leon_eoi_irq(struct irq_data *data)
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
+	.irq_set_affinity	= leon_set_affinity,
 };
 
 /*
-- 
1.5.4

