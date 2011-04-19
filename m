From: Daniel Hellstrom <daniel@gaisler.com>
Date: Tue, 19 Apr 2011 16:07:18 +0000
Subject: [PATCH 6/7] sparc32,leon: operate on boot-cpu IRQ controller registers
Message-Id: <1303229239-21551-6-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Each CPU has a separate set of IRQ controller registers, this
patch makes sure that the boot-cpu registers are used instead
of CPU0's. Note that there are other parts of the SPARC32/LEON
port which does not support booting on other than CPU0 anyway,
however this this cleans up the IRQ controller layer in that
regard.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/include/asm/leon.h   |    1 +
 arch/sparc/kernel/leon_kernel.c |   14 ++++++++------
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
index 31fb2ac..1776f71 100644
--- a/arch/sparc/include/asm/leon.h
+++ b/arch/sparc/include/asm/leon.h
@@ -335,6 +335,7 @@ extern int leon_flush_needed(void);
 extern void leon_switch_mm(void);
 extern int srmmu_swprobe_trace;
 extern int leon3_ticker_irq;
+extern int leon3_boot_cpu;
 
 #ifdef CONFIG_SMP
 extern int leon_smp_nrcpus(void);
diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index 80ab271..26acc75 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -31,6 +31,7 @@ int leondebug_irq_disable;
 int leon_debug_irqout;
 static int dummy_master_l10_counter;
 unsigned long amba_system_id;
+int leon3_boot_cpu;
 static DEFINE_SPINLOCK(leon_irq_lock);
 
 unsigned long leon3_gptimer_irq; /* interrupt controller irq number */
@@ -79,8 +80,8 @@ void leon_eirq_setup(unsigned int eirq)
 	 */
 	irq_link(veirq);
 	mask = 1 << eirq;
-	oldmask = LEON3_BYPASS_LOAD_PA(LEON_IMASK(0));
-	LEON3_BYPASS_STORE_PA(LEON_IMASK(0), (oldmask | mask));
+	oldmask = LEON3_BYPASS_LOAD_PA(LEON_IMASK(leon3_boot_cpu));
+	LEON3_BYPASS_STORE_PA(LEON_IMASK(leon3_boot_cpu), (oldmask | mask));
 	sparc_leon_eirq = eirq;
 }
 
@@ -105,8 +106,8 @@ static void leon_unmask_irq(struct irq_data *data)
 
 	mask = (unsigned long)data->chip_data;
 	spin_lock_irqsave(&leon_irq_lock, flags);
-	oldmask = LEON3_BYPASS_LOAD_PA(LEON_IMASK(0));
-	LEON3_BYPASS_STORE_PA(LEON_IMASK(0), (oldmask | mask));
+	oldmask = LEON3_BYPASS_LOAD_PA(LEON_IMASK(leon3_boot_cpu));
+	LEON3_BYPASS_STORE_PA(LEON_IMASK(leon3_boot_cpu), (oldmask | mask));
 	spin_unlock_irqrestore(&leon_irq_lock, flags);
 }
 
@@ -116,8 +117,8 @@ static void leon_mask_irq(struct irq_data *data)
 
 	mask = (unsigned long)data->chip_data;
 	spin_lock_irqsave(&leon_irq_lock, flags);
-	oldmask = LEON3_BYPASS_LOAD_PA(LEON_IMASK(0));
-	LEON3_BYPASS_STORE_PA(LEON_IMASK(0), (oldmask & ~mask));
+	oldmask = LEON3_BYPASS_LOAD_PA(LEON_IMASK(leon3_boot_cpu));
+	LEON3_BYPASS_STORE_PA(LEON_IMASK(leon3_boot_cpu), (oldmask & ~mask));
 	spin_unlock_irqrestore(&leon_irq_lock, flags);
 }
 
@@ -205,6 +206,7 @@ void __init leon_init_timers(irq_handler_t counter_fn)
 	leon_debug_irqout = 0;
 	master_l10_counter = (unsigned int *)&dummy_master_l10_counter;
 	dummy_master_l10_counter = 0;
+	leon3_boot_cpu = hard_smp_processor_id();
 
 	rootnp = of_find_node_by_path("/ambapp0");
 	if (!rootnp)
-- 
1.5.4

