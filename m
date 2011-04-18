From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 18 Apr 2011 21:25:42 +0000
Subject: [PATCH 1/3] sparc32,sun4d: rename sbus_tid to board_to_cpu in irq support
Message-Id: <1303161944-13611-1-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The new name reflects the actual usage much better.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/sun4d_irq.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/kernel/sun4d_irq.c b/arch/sparc/kernel/sun4d_irq.c
index 77b4a89..ee35c45 100644
--- a/arch/sparc/kernel/sun4d_irq.c
+++ b/arch/sparc/kernel/sun4d_irq.c
@@ -51,7 +51,11 @@ static struct sun4d_timer_regs __iomem *sun4d_timers;
 #define TIMER_IRQ	10
 
 #define MAX_STATIC_ALLOC	4
-static unsigned char sbus_tid[32];
+
+/* Specify which cpu handle interrupts from which board.
+ * Index is board - value is cpu.
+ */
+static unsigned char board_to_cpu[32];
 
 static struct irqaction *irq_action[NR_IRQS];
 
@@ -363,7 +367,7 @@ out:
 
 static void sun4d_disable_irq(unsigned int irq)
 {
-	int tid = sbus_tid[(irq >> 5) - 1];
+	int tid = board_to_cpu[(irq >> 5) - 1];
 	unsigned long flags;
 
 	if (irq < NR_IRQS)
@@ -376,7 +380,7 @@ static void sun4d_disable_irq(unsigned int irq)
 
 static void sun4d_enable_irq(unsigned int irq)
 {
-	int tid = sbus_tid[(irq >> 5) - 1];
+	int tid = board_to_cpu[(irq >> 5) - 1];
 	unsigned long flags;
 
 	if (irq < NR_IRQS)
@@ -413,7 +417,7 @@ void __init sun4d_distribute_irqs(void)
 	for_each_node_by_name(dp, "sbi") {
 		int devid = of_getintprop_default(dp, "device-id", 0);
 		int board = of_getintprop_default(dp, "board#", 0);
-		sbus_tid[board] = cpuid;
+		board_to_cpu[board] = cpuid;
 		set_sbi_tid(devid, cpuid << 3);
 	}
 	printk(KERN_ERR "All sbus IRQs directed to CPU%d\n", cpuid);
@@ -587,7 +591,7 @@ void __init sun4d_init_sbi_irq(void)
 		unsigned int mask;
 
 		set_sbi_tid(devid, target_cpu << 3);
-		sbus_tid[board] = target_cpu;
+		board_to_cpu[board] = target_cpu;
 
 		/* Get rid of pending irqs from PROM */
 		mask = acquire_sbi(devid, 0xffffffff);
-- 
1.6.0.6

