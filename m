From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:24:44 +0000
Subject: [PATCH 33/49]: sparc32: Convert sun4d IRQ code to use generic
Message-Id: <20080827.212444.227115264.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc32: Convert sun4d IRQ code to use generic device tree probing.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/sun4d_irq.c |   83 +++++++++++++++++++++++-----------------
 1 files changed, 48 insertions(+), 35 deletions(-)

diff --git a/arch/sparc/kernel/sun4d_irq.c b/arch/sparc/kernel/sun4d_irq.c
index 1290b59..7424967 100644
--- a/arch/sparc/kernel/sun4d_irq.c
+++ b/arch/sparc/kernel/sun4d_irq.c
@@ -409,47 +409,55 @@ static void sun4d_set_udt(int cpu)
 /* Setup IRQ distribution scheme. */
 void __init sun4d_distribute_irqs(void)
 {
+	struct device_node *dp;
+
 #ifdef DISTRIBUTE_IRQS
-	struct sbus_bus *sbus;
-	unsigned long sbus_serving_map;
+	cpumask_t sbus_serving_map;
 
 	sbus_serving_map = cpu_present_map;
-	for_each_sbus(sbus) {
-		if ((sbus->board * 2) = boot_cpu_id && (cpu_present_map & (1 << (sbus->board * 2 + 1))))
-			sbus_tid[sbus->board] = (sbus->board * 2 + 1);
-		else if (cpu_present_map & (1 << (sbus->board * 2)))
-			sbus_tid[sbus->board] = (sbus->board * 2);
-		else if (cpu_present_map & (1 << (sbus->board * 2 + 1)))
-			sbus_tid[sbus->board] = (sbus->board * 2 + 1);
+	for_each_node_by_name(dp, "sbi") {
+		int board = of_getintprop_default(dp, "board#", 0);
+
+		if ((board * 2) = boot_cpu_id && cpu_isset(board * 2 + 1, cpu_present_map))
+			sbus_tid[board] = (board * 2 + 1);
+		else if (cpu_isset(board * 2, cpu_present_map))
+			sbus_tid[board] = (board * 2);
+		else if (cpu_isset(board * 2 + 1, cpu_present_map))
+			sbus_tid[board] = (board * 2 + 1);
 		else
-			sbus_tid[sbus->board] = 0xff;
-		if (sbus_tid[sbus->board] != 0xff)
-			sbus_serving_map &= ~(1 << sbus_tid[sbus->board]);
+			sbus_tid[board] = 0xff;
+		if (sbus_tid[board] != 0xff)
+			cpu_clear(sbus_tid[board], sbus_serving_map);
 	}
-	for_each_sbus(sbus)
-		if (sbus_tid[sbus->board] = 0xff) {
+	for_each_node_by_name(dp, "sbi") {
+		int board = of_getintprop_default(dp, "board#", 0);
+		if (sbus_tid[board] = 0xff) {
 			int i = 31;
 				
-			if (!sbus_serving_map)
+			if (cpus_empty(sbus_serving_map))
 				sbus_serving_map = cpu_present_map;
-			while (!(sbus_serving_map & (1 << i)))
+			while (cpu_isset(i, sbus_serving_map))
 				i--;
-			sbus_tid[sbus->board] = i;
-			sbus_serving_map &= ~(1 << i);
+			sbus_tid[board] = i;
+			cpu_clear(i, sbus_serving_map);
 		}
-	for_each_sbus(sbus) {
-		printk("sbus%d IRQs directed to CPU%d\n", sbus->board, sbus_tid[sbus->board]);
-		set_sbi_tid(sbus->devid, sbus_tid[sbus->board] << 3);
+	}
+	for_each_node_by_name(dp, "sbi") {
+		int devid = of_getintprop_default(dp, "device-id", 0);
+		int board = of_getintprop_default(dp, "board#", 0);
+		printk("sbus%d IRQs directed to CPU%d\n", board, sbus_tid[board]);
+		set_sbi_tid(devid, sbus_tid[board] << 3);
 	}
 #else
-	struct sbus_bus *sbus;
 	int cpuid = cpu_logical_map(1);
 
 	if (cpuid = -1)
 		cpuid = cpu_logical_map(0);
-	for_each_sbus(sbus) {
-		sbus_tid[sbus->board] = cpuid;
-		set_sbi_tid(sbus->devid, cpuid << 3);
+	for_each_node_by_name(dp, "sbi") {
+		int devid = of_getintprop_default(dp, "device-id", 0);
+		int board = of_getintprop_default(dp, "board#", 0);
+		sbus_tid[board] = cpuid;
+		set_sbi_tid(devid, cpuid << 3);
 	}
 	printk("All sbus IRQs directed to CPU%d\n", cpuid);
 #endif
@@ -541,29 +549,34 @@ static void __init sun4d_init_timers(irq_handler_t counter_fn)
 
 void __init sun4d_init_sbi_irq(void)
 {
-	struct sbus_bus *sbus;
-	unsigned mask;
+	struct device_node *dp;
 
 	nsbi = 0;
-	for_each_sbus(sbus)
+	for_each_node_by_name(dp, "sbi")
 		nsbi++;
 	sbus_actions = kzalloc (nsbi * 8 * 4 * sizeof(struct sbus_action), GFP_ATOMIC);
 	if (!sbus_actions) {
 		prom_printf("SUN4D: Cannot allocate sbus_actions, halting.\n");
 		prom_halt();
 	}
-	for_each_sbus(sbus) {
+	for_each_node_by_name(dp, "sbi") {
+		int devid = of_getintprop_default(dp, "device-id", 0);
+		int board = of_getintprop_default(dp, "board#", 0);
+		unsigned int mask;
+
 #ifdef CONFIG_SMP	
-		extern unsigned char boot_cpu_id;
+		{
+			extern unsigned char boot_cpu_id;
 		
-		set_sbi_tid(sbus->devid, boot_cpu_id << 3);
-		sbus_tid[sbus->board] = boot_cpu_id;
+			set_sbi_tid(devid, boot_cpu_id << 3);
+			sbus_tid[board] = boot_cpu_id;
+		}
 #endif
 		/* Get rid of pending irqs from PROM */
-		mask = acquire_sbi(sbus->devid, 0xffffffff);
+		mask = acquire_sbi(devid, 0xffffffff);
 		if (mask) {
-			printk ("Clearing pending IRQs %08x on SBI %d\n", mask, sbus->board);
-			release_sbi(sbus->devid, mask);
+			printk ("Clearing pending IRQs %08x on SBI %d\n", mask, board);
+			release_sbi(devid, mask);
 		}
 	}
 }
-- 
1.5.6.5.GIT

