From: David Miller <davem@davemloft.net>
Date: Fri, 19 Sep 2008 22:39:17 +0000
Subject: [PATCH 10/13]: sparc32: Use PROM device probing for sun4c timers.
Message-Id: <20080919.153917.96937415.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc32: Use PROM device probing for sun4c timers.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/timer_32.h |   24 ---------------
 arch/sparc/kernel/sun4c_irq.c     |   59 ++++++++++++++++++++++++------------
 2 files changed, 39 insertions(+), 44 deletions(-)

diff --git a/arch/sparc/include/asm/timer_32.h b/arch/sparc/include/asm/timer_32.h
index 860a05e..351f257 100644
--- a/arch/sparc/include/asm/timer_32.h
+++ b/arch/sparc/include/asm/timer_32.h
@@ -11,30 +11,6 @@
 #include <asm/system.h>  /* For SUN4M_NCPUS */
 #include <asm/btfixup.h>
 
-/* Timer structures. The interrupt timer has two properties which
- * are the counter (which is handled in do_timer in sched.c) and the limit.
- * This limit is where the timer's counter 'wraps' around. Oddly enough,
- * the sun4c timer when it hits the limit wraps back to 1 and not zero
- * thus when calculating the value at which it will fire a microsecond you
- * must adjust by one.  Thanks SUN for designing such great hardware ;(
- */
-
-/* Note that I am only going to use the timer that interrupts at
- * Sparc IRQ 10.  There is another one available that can fire at
- * IRQ 14. Currently it is left untouched, we keep the PROM's limit
- * register value and let the prom take these interrupts.  This allows
- * L1-A to work.
- */
-
-struct sun4c_timer_info {
-  __volatile__ unsigned int cur_count10;
-  __volatile__ unsigned int timer_limit10;
-  __volatile__ unsigned int cur_count14;
-  __volatile__ unsigned int timer_limit14;
-};
-
-#define SUN_TIMER_PHYSADDR   0xf3000000
-
 extern __volatile__ unsigned int *master_l10_counter;
 extern __volatile__ unsigned int *master_l10_limit;
 
diff --git a/arch/sparc/kernel/sun4c_irq.c b/arch/sparc/kernel/sun4c_irq.c
index 8033132..92096ba 100644
--- a/arch/sparc/kernel/sun4c_irq.c
+++ b/arch/sparc/kernel/sun4c_irq.c
@@ -119,16 +119,18 @@ static void sun4c_enable_irq(unsigned int irq_nr)
 	local_irq_restore(flags);
 }
 
-#define TIMER_IRQ  	10    /* Also at level 14, but we ignore that one. */
-#define PROFILE_IRQ	14    /* Level14 ticker.. used by OBP for polling */
+struct sun4c_timer_info {
+	u32		l10_count;
+	u32		l10_limit;
+	u32		l14_count;
+	u32		l14_limit;
+};
 
-volatile struct sun4c_timer_info *sun4c_timers;
+static struct sun4c_timer_info __iomem *sun4c_timers;
 
 static void sun4c_clear_clock_irq(void)
 {
-	volatile unsigned int clear_intr;
-
-	clear_intr = sun4c_timers->timer_limit10;
+	sbus_readl(&sun4c_timers->l10_limit);
 }
 
 static void sun4c_load_profile_irq(int cpu, unsigned int limit)
@@ -138,32 +140,49 @@ static void sun4c_load_profile_irq(int cpu, unsigned int limit)
 
 static void __init sun4c_init_timers(irq_handler_t counter_fn)
 {
-	int irq;
+	const struct linux_prom_irqs *irq;
+	struct device_node *dp;
+	const u32 *addr;
+	int err;
 
-	/* Map the Timer chip, this is implemented in hardware inside
-	 * the cache chip on the sun4c.
-	 */
-	sun4c_timers = ioremap(SUN_TIMER_PHYSADDR,
-	    sizeof(struct sun4c_timer_info));
+	dp = of_find_node_by_name(NULL, "counter-timer");
+	if (!dp) {
+		prom_printf("sun4c_init_timers: Unable to find counter-timer\n");
+		prom_halt();
+	}
+
+	addr = of_get_property(dp, "address", NULL);
+	if (!addr) {
+		prom_printf("sun4c_init_timers: No address property\n");
+		prom_halt();
+	}
+
+	sun4c_timers = (void __iomem *) (unsigned long) addr[0];
+
+	irq = of_get_property(dp, "intr", NULL);
+	if (!irq) {
+		prom_printf("sun4c_init_timers: No intr property\n");
+		prom_halt();
+	}
 
 	/* Have the level 10 timer tick at 100HZ.  We don't touch the
 	 * level 14 timer limit since we are letting the prom handle
 	 * them until we have a real console driver so L1-A works.
 	 */
-	sun4c_timers->timer_limit10 = (((1000000/HZ) + 1) << 10);
-	master_l10_counter = &sun4c_timers->cur_count10;
-	master_l10_limit = &sun4c_timers->timer_limit10;
+	sbus_writel((((1000000/HZ) + 1) << 10), &sun4c_timers->l10_limit);
+
+	master_l10_counter = &sun4c_timers->l10_count;
+	master_l10_limit = &sun4c_timers->l10_limit;
 
-	irq = request_irq(TIMER_IRQ,
-			  counter_fn,
+	err = request_irq(irq[0].pri, counter_fn,
 			  (IRQF_DISABLED | SA_STATIC_ALLOC),
 			  "timer", NULL);
-	if (irq) {
-		prom_printf("time_init: unable to attach IRQ%d\n",TIMER_IRQ);
+	if (err) {
+		prom_printf("sun4c_init_timers: request_irq() fails with %d\n", err);
 		prom_halt();
 	}
     
-	sun4c_disable_irq(PROFILE_IRQ);
+	sun4c_disable_irq(irq[1].pri);
 }
 
 #ifdef CONFIG_SMP
-- 
1.5.6.5

