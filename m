From: David Miller <davem@davemloft.net>
Date: Fri, 19 Sep 2008 22:38:53 +0000
Subject: [PATCH 3/13]: sparc32: Remove some SMP ifdefs in sun4d_irq.c
Message-Id: <20080919.153853.259406958.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc32: Remove some SMP ifdefs in sun4d_irq.c

Always do the sbus_tid[] handling.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/sun4d_irq.c |   42 +++++++++++++++-------------------------
 1 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/arch/sparc/kernel/sun4d_irq.c b/arch/sparc/kernel/sun4d_irq.c
index 4156bf6..6e3bf6e 100644
--- a/arch/sparc/kernel/sun4d_irq.c
+++ b/arch/sparc/kernel/sun4d_irq.c
@@ -60,9 +60,7 @@ static struct sun4d_timer_regs __iomem *sun4d_timers;
 #define MAX_STATIC_ALLOC	4
 extern struct irqaction static_irqaction[MAX_STATIC_ALLOC];
 extern int static_irq_count;
-#ifdef CONFIG_SMP
 static unsigned char sbus_tid[32];
-#endif
 
 static struct irqaction *irq_action[NR_IRQS];
 extern spinlock_t irq_action_lock;
@@ -81,9 +79,9 @@ static int sbus_to_pil[] = {
 };
 
 static int nsbi;
-#ifdef CONFIG_SMP
+
+/* Exported for sun4d_smp.c */
 DEFINE_SPINLOCK(sun4d_imsk_lock);
-#endif
 
 int show_sun4d_interrupts(struct seq_file *p, void *v)
 {
@@ -349,36 +347,28 @@ out:
 
 static void sun4d_disable_irq(unsigned int irq)
 {
-#ifdef CONFIG_SMP
 	int tid = sbus_tid[(irq >> 5) - 1];
 	unsigned long flags;
-#endif	
 	
-	if (irq < NR_IRQS) return;
-#ifdef CONFIG_SMP
+	if (irq < NR_IRQS)
+		return;
+
 	spin_lock_irqsave(&sun4d_imsk_lock, flags);
 	cc_set_imsk_other(tid, cc_get_imsk_other(tid) | (1 << sbus_to_pil[(irq >> 2) & 7]));
 	spin_unlock_irqrestore(&sun4d_imsk_lock, flags);
-#else		
-	cc_set_imsk(cc_get_imsk() | (1 << sbus_to_pil[(irq >> 2) & 7]));
-#endif
 }
 
 static void sun4d_enable_irq(unsigned int irq)
 {
-#ifdef CONFIG_SMP
 	int tid = sbus_tid[(irq >> 5) - 1];
 	unsigned long flags;
-#endif	
 	
-	if (irq < NR_IRQS) return;
-#ifdef CONFIG_SMP
+	if (irq < NR_IRQS)
+		return;
+
 	spin_lock_irqsave(&sun4d_imsk_lock, flags);
 	cc_set_imsk_other(tid, cc_get_imsk_other(tid) & ~(1 << sbus_to_pil[(irq >> 2) & 7]));
 	spin_unlock_irqrestore(&sun4d_imsk_lock, flags);
-#else		
-	cc_set_imsk(cc_get_imsk() & ~(1 << sbus_to_pil[(irq >> 2) & 7]));
-#endif
 }
 
 #ifdef CONFIG_SMP
@@ -557,6 +547,11 @@ static void __init sun4d_init_timers(irq_handler_t counter_fn)
 void __init sun4d_init_sbi_irq(void)
 {
 	struct device_node *dp;
+	int target_cpu = 0;
+
+#ifdef CONFIG_SMP
+	target_cpu = boot_cpu_id;
+#endif
 
 	nsbi = 0;
 	for_each_node_by_name(dp, "sbi")
@@ -571,14 +566,9 @@ void __init sun4d_init_sbi_irq(void)
 		int board = of_getintprop_default(dp, "board#", 0);
 		unsigned int mask;
 
-#ifdef CONFIG_SMP	
-		{
-			extern unsigned char boot_cpu_id;
-		
-			set_sbi_tid(devid, boot_cpu_id << 3);
-			sbus_tid[board] = boot_cpu_id;
-		}
-#endif
+		set_sbi_tid(devid, target_cpu << 3);
+		sbus_tid[board] = target_cpu;
+
 		/* Get rid of pending irqs from PROM */
 		mask = acquire_sbi(devid, 0xffffffff);
 		if (mask) {
-- 
1.5.6.5

