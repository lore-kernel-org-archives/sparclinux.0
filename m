From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 29 Jan 2011 08:08:22 +0000
Subject: [PATCH 6/8] sparc32,sun4d: drop unused code in sun4d_distribute_irqs()
Message-Id: <1296288504-15933-6-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The preprocessor symbol was not defined and the code
was therefore not in use.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/sun4d_irq.c |   47 -----------------------------------------
 1 files changed, 0 insertions(+), 47 deletions(-)

diff --git a/arch/sparc/kernel/sun4d_irq.c b/arch/sparc/kernel/sun4d_irq.c
index 5fc4c22..b2e3fbf 100644
--- a/arch/sparc/kernel/sun4d_irq.c
+++ b/arch/sparc/kernel/sun4d_irq.c
@@ -38,13 +38,6 @@
  *    have interrupts pending for that SBUS interrupt level.
  */
 
-/*
- * If you trust current SCSI layer to handle different
- * SCSI IRQs, enable this.
- * I don't trust it... -jj
- */
-/* #define DISTRIBUTE_IRQS */
-
 struct sun4d_timer_regs {
 	u32	l10_timer_limit;
 	u32	l10_cur_countx;
@@ -412,45 +405,6 @@ void __init sun4d_distribute_irqs(void)
 {
 	struct device_node *dp;
 
-#ifdef DISTRIBUTE_IRQS
-	cpumask_t sbus_serving_map;
-
-	sbus_serving_map = cpu_present_map;
-	for_each_node_by_name(dp, "sbi") {
-		int board = of_getintprop_default(dp, "board#", 0);
-
-		if ((board * 2) = boot_cpu_id && cpu_isset(board * 2 + 1, cpu_present_map))
-			sbus_tid[board] = (board * 2 + 1);
-		else if (cpu_isset(board * 2, cpu_present_map))
-			sbus_tid[board] = (board * 2);
-		else if (cpu_isset(board * 2 + 1, cpu_present_map))
-			sbus_tid[board] = (board * 2 + 1);
-		else
-			sbus_tid[board] = 0xff;
-		if (sbus_tid[board] != 0xff)
-			cpu_clear(sbus_tid[board], sbus_serving_map);
-	}
-	for_each_node_by_name(dp, "sbi") {
-		int board = of_getintprop_default(dp, "board#", 0);
-		if (sbus_tid[board] = 0xff) {
-			int i = 31;
-
-			if (cpus_empty(sbus_serving_map))
-				sbus_serving_map = cpu_present_map;
-			while (cpu_isset(i, sbus_serving_map))
-				i--;
-			sbus_tid[board] = i;
-			cpu_clear(i, sbus_serving_map);
-		}
-	}
-	for_each_node_by_name(dp, "sbi") {
-		int devid = of_getintprop_default(dp, "device-id", 0);
-		int board = of_getintprop_default(dp, "board#", 0);
-		printk(KERN_ERR "sbus%d IRQs directed to CPU%d\n",
-		       board, sbus_tid[board]);
-		set_sbi_tid(devid, sbus_tid[board] << 3);
-	}
-#else
 	int cpuid = cpu_logical_map(1);
 
 	if (cpuid = -1)
@@ -462,7 +416,6 @@ void __init sun4d_distribute_irqs(void)
 		set_sbi_tid(devid, cpuid << 3);
 	}
 	printk(KERN_ERR "All sbus IRQs directed to CPU%d\n", cpuid);
-#endif
 }
 #endif
 
-- 
1.6.0.6

