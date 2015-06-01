From: Jiang Liu <jiang.liu@linux.intel.com>
Date: Mon, 01 Jun 2015 08:05:35 +0000
Subject: [Patch v3 26/36] sparc, irq: Use access helper irq_data_get_affinity_mask()
Message-Id: <1433145945-789-27-git-send-email-jiang.liu@linux.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Randy Dunlap <rdunlap@infradead.org>, Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>, "David S. Miller" <davem@davemloft.net>, bob picco <bpicco@meloft.net>, Jiang Liu <jiang.liu@linux.intel.com>, Andreas Larsson <andreas@gaisler.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, sparclinux@vger.kernel.org

Use access helper irq_data_get_affinity_mask() to hide implementation
details of struct irq_desc.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/sparc/kernel/irq_64.c      |   12 +++++++-----
 arch/sparc/kernel/leon_kernel.c |    6 +++---
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index 5130f6e3e68e..e22416ce56ea 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -377,7 +377,8 @@ static void sun4u_irq_enable(struct irq_data *data)
 		unsigned long cpuid, imap, val;
 		unsigned int tid;
 
-		cpuid = irq_choose_cpu(data->irq, data->affinity);
+		cpuid = irq_choose_cpu(data->irq,
+				       irq_data_get_affinity_mask(data));
 		imap = handler_data->imap;
 
 		tid = sun4u_compute_tid(imap, cpuid);
@@ -449,7 +450,8 @@ static void sun4u_irq_eoi(struct irq_data *data)
 
 static void sun4v_irq_enable(struct irq_data *data)
 {
-	unsigned long cpuid = irq_choose_cpu(data->irq, data->affinity);
+	unsigned long cpuid = irq_choose_cpu(data->irq,
+					     irq_data_get_affinity_mask(data));
 	unsigned int ino = irq_data_to_sysino(data);
 	int err;
 
@@ -511,7 +513,7 @@ static void sun4v_virq_enable(struct irq_data *data)
 	unsigned long cpuid;
 	int err;
 
-	cpuid = irq_choose_cpu(data->irq, data->affinity);
+	cpuid = irq_choose_cpu(data->irq, irq_data_get_affinity_mask(data));
 
 	err = sun4v_vintr_set_target(dev_handle, dev_ino, cpuid);
 	if (err != HV_EOK)
@@ -884,8 +886,8 @@ void fixup_irqs(void)
 		if (desc->action && !irqd_is_per_cpu(data)) {
 			if (data->chip->irq_set_affinity)
 				data->chip->irq_set_affinity(data,
-							     data->affinity,
-							     false);
+					irq_data_get_affinity_mask(data),
+					false);
 		}
 		raw_spin_unlock_irqrestore(&desc->lock, flags);
 	}
diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index 9bbb8f2bbfcc..0299f052a2ef 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -126,7 +126,7 @@ static int leon_set_affinity(struct irq_data *data, const struct cpumask *dest,
 	int oldcpu, newcpu;
 
 	mask = (unsigned long)data->chip_data;
-	oldcpu = irq_choose_cpu(data->affinity);
+	oldcpu = irq_choose_cpu(irq_data_get_affinity_mask(data));
 	newcpu = irq_choose_cpu(dest);
 
 	if (oldcpu = newcpu)
@@ -149,7 +149,7 @@ static void leon_unmask_irq(struct irq_data *data)
 	int cpu;
 
 	mask = (unsigned long)data->chip_data;
-	cpu = irq_choose_cpu(data->affinity);
+	cpu = irq_choose_cpu(irq_data_get_affinity_mask(data));
 	spin_lock_irqsave(&leon_irq_lock, flags);
 	oldmask = LEON3_BYPASS_LOAD_PA(LEON_IMASK(cpu));
 	LEON3_BYPASS_STORE_PA(LEON_IMASK(cpu), (oldmask | mask));
@@ -162,7 +162,7 @@ static void leon_mask_irq(struct irq_data *data)
 	int cpu;
 
 	mask = (unsigned long)data->chip_data;
-	cpu = irq_choose_cpu(data->affinity);
+	cpu = irq_choose_cpu(irq_data_get_affinity_mask(data));
 	spin_lock_irqsave(&leon_irq_lock, flags);
 	oldmask = LEON3_BYPASS_LOAD_PA(LEON_IMASK(cpu));
 	LEON3_BYPASS_STORE_PA(LEON_IMASK(cpu), (oldmask & ~mask));
-- 
1.7.10.4

