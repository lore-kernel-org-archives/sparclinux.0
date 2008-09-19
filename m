From: David Miller <davem@davemloft.net>
Date: Fri, 19 Sep 2008 22:38:51 +0000
Subject: [PATCH 2/13]: sparc32: Use PROM infrastructure for probing and
Message-Id: <20080919.153851.245155034.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc32: Use PROM infrastructure for probing and mapping sun4d timers.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/timer_32.h |   13 ----
 arch/sparc/kernel/sun4d_irq.c     |  139 ++++++++++++++++++++++---------------
 2 files changed, 83 insertions(+), 69 deletions(-)

diff --git a/arch/sparc/include/asm/timer_32.h b/arch/sparc/include/asm/timer_32.h
index 8906e98..860a05e 100644
--- a/arch/sparc/include/asm/timer_32.h
+++ b/arch/sparc/include/asm/timer_32.h
@@ -35,19 +35,6 @@ struct sun4c_timer_info {
 
 #define SUN_TIMER_PHYSADDR   0xf3000000
 
-#define SUN4D_PRM_CNT_L       0x80000000
-#define SUN4D_PRM_CNT_LVALUE  0x7FFFFC00
-
-struct sun4d_timer_regs {
-	volatile unsigned int l10_timer_limit;
-	volatile unsigned int l10_cur_countx;
-	volatile unsigned int l10_limit_noclear;
-	volatile unsigned int ctrl;
-	volatile unsigned int l10_cur_count;
-};
-
-extern struct sun4d_timer_regs *sun4d_timers;
-
 extern __volatile__ unsigned int *master_l10_counter;
 extern __volatile__ unsigned int *master_l10_limit;
 
diff --git a/arch/sparc/kernel/sun4d_irq.c b/arch/sparc/kernel/sun4d_irq.c
index 12541f5..4156bf6 100644
--- a/arch/sparc/kernel/sun4d_irq.c
+++ b/arch/sparc/kernel/sun4d_irq.c
@@ -45,7 +45,16 @@
 /* If you trust current SCSI layer to handle different SCSI IRQs, enable this. I don't trust it... -jj */
 /* #define DISTRIBUTE_IRQS */
 
-struct sun4d_timer_regs *sun4d_timers;
+struct sun4d_timer_regs {
+	u32	l10_timer_limit;
+	u32	l10_cur_countx;
+	u32	l10_limit_noclear;
+	u32	ctrl;
+	u32	l10_cur_count;
+};
+
+static struct sun4d_timer_regs __iomem *sun4d_timers;
+
 #define TIMER_IRQ	10
 
 #define MAX_STATIC_ALLOC	4
@@ -446,8 +455,7 @@ void __init sun4d_distribute_irqs(void)
  
 static void sun4d_clear_clock_irq(void)
 {
-	volatile unsigned int clear_intr;
-	clear_intr = sun4d_timers->l10_timer_limit;
+	sbus_readl(&sun4d_timers->l10_timer_limit);
 }
 
 static void sun4d_clear_profile_irq(int cpu)
@@ -460,71 +468,90 @@ static void sun4d_load_profile_irq(int cpu, unsigned int limit)
 	bw_set_prof_limit(cpu, limit);
 }
 
-static void __init sun4d_init_timers(irq_handler_t counter_fn)
+static void __init sun4d_load_profile_irqs(void)
 {
-	int irq;
-	int cpu;
-	struct resource r;
-	int mid;
+	int cpu = 0, mid;
 
-	/* Map the User Timer registers. */
-	memset(&r, 0, sizeof(r));
+	while (!cpu_find_by_instance(cpu, NULL, &mid)) {
+		sun4d_load_profile_irq(mid >> 3, 0);
+		cpu++;
+	}
+}
+
+static void __init sun4d_fixup_trap_table(void)
+{
 #ifdef CONFIG_SMP
-	r.start = CSR_BASE(boot_cpu_id)+BW_TIMER_LIMIT;
-#else
-	r.start = CSR_BASE(0)+BW_TIMER_LIMIT;
+	unsigned long flags;
+	extern unsigned long lvl14_save[4];
+	struct tt_entry *trap_table = &sparc_ttable[SP_TRAP_IRQ1 + (14 - 1)];
+	extern unsigned int real_irq_entry[], smp4d_ticker[];
+	extern unsigned int patchme_maybe_smp_msg[];
+
+	/* Adjust so that we jump directly to smp4d_ticker */
+	lvl14_save[2] += smp4d_ticker - real_irq_entry;
+
+	/* For SMP we use the level 14 ticker, however the bootup code
+	 * has copied the firmware's level 14 vector into the boot cpu's
+	 * trap table, we must fix this now or we get squashed.
+	 */
+	local_irq_save(flags);
+	patchme_maybe_smp_msg[0] = 0x01000000; /* NOP out the branch */
+	trap_table->inst_one = lvl14_save[0];
+	trap_table->inst_two = lvl14_save[1];
+	trap_table->inst_three = lvl14_save[2];
+	trap_table->inst_four = lvl14_save[3];
+	local_flush_cache_all();
+	local_irq_restore(flags);
 #endif
-	r.flags = 0xf;
-	sun4d_timers = (struct sun4d_timer_regs *) of_ioremap(&r, 0,
-	    PAGE_SIZE, "user timer");
+}
+
+static void __init sun4d_init_timers(irq_handler_t counter_fn)
+{
+	struct device_node *dp;
+	struct resource res;
+	const u32 *reg;
+	int err;
+
+	dp = of_find_node_by_name(NULL, "cpu-unit");
+	if (!dp) {
+		prom_printf("sun4d_init_timers: Unable to find cpu-unit\n");
+		prom_halt();
+	}
+
+	/* Which cpu-unit we use is arbitrary, we can view the bootbus timer
+	 * registers via any cpu's mapping.  The first 'reg' property is the
+	 * bootbus.
+	 */
+	reg = of_get_property(dp, "reg", NULL);
+	if (!reg) {
+		prom_printf("sun4d_init_timers: No reg property\n");
+		prom_halt();
+	}
+
+	res.start = reg[1];
+	res.end = reg[2] - 1;
+	res.flags = reg[0] & 0xff;
+	sun4d_timers = of_ioremap(&res, BW_TIMER_LIMIT,
+				  sizeof(struct sun4d_timer_regs), "user timer");
+	if (!sun4d_timers) {
+		prom_printf("sun4d_init_timers: Can't map timer regs\n");
+		prom_halt();
+	}
+
+	sbus_writel((((1000000/HZ) + 1) << 10), &sun4d_timers->l10_timer_limit);
 
-	sun4d_timers->l10_timer_limit =  (((1000000/HZ) + 1) << 10);
 	master_l10_counter = &sun4d_timers->l10_cur_count;
 	master_l10_limit = &sun4d_timers->l10_timer_limit;
 
-	irq = request_irq(TIMER_IRQ,
-			  counter_fn,
+	err = request_irq(TIMER_IRQ, counter_fn,
 			  (IRQF_DISABLED | SA_STATIC_ALLOC),
 			  "timer", NULL);
-	if (irq) {
-		prom_printf("time_init: unable to attach IRQ%d\n",TIMER_IRQ);
+	if (err) {
+		prom_printf("sun4d_init_timers: request_irq() failed with %d\n", err);
 		prom_halt();
 	}
-	
-	/* Enable user timer free run for CPU 0 in BW */
-	/* bw_set_ctrl(0, bw_get_ctrl(0) | BW_CTRL_USER_TIMER); */
-
-	cpu = 0;
-	while (!cpu_find_by_instance(cpu, NULL, &mid)) {
-		sun4d_load_profile_irq(mid >> 3, 0);
-		cpu++;
-	}
-		
-#ifdef CONFIG_SMP
-	{
-		unsigned long flags;
-		extern unsigned long lvl14_save[4];
-		struct tt_entry *trap_table = &sparc_ttable[SP_TRAP_IRQ1 + (14 - 1)];
-		extern unsigned int real_irq_entry[], smp4d_ticker[];
-		extern unsigned int patchme_maybe_smp_msg[];
-
-		/* Adjust so that we jump directly to smp4d_ticker */
-		lvl14_save[2] += smp4d_ticker - real_irq_entry;
-
-		/* For SMP we use the level 14 ticker, however the bootup code
-		 * has copied the firmware's level 14 vector into the boot cpu's
-		 * trap table, we must fix this now or we get squashed.
-		 */
-		local_irq_save(flags);
-		patchme_maybe_smp_msg[0] = 0x01000000; /* NOP out the branch */
-		trap_table->inst_one = lvl14_save[0];
-		trap_table->inst_two = lvl14_save[1];
-		trap_table->inst_three = lvl14_save[2];
-		trap_table->inst_four = lvl14_save[3];
-		local_flush_cache_all();
-		local_irq_restore(flags);
-	}
-#endif
+	sun4d_load_profile_irqs();
+	sun4d_fixup_trap_table();
 }
 
 void __init sun4d_init_sbi_irq(void)
-- 
1.5.6.5

