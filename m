From: David Miller <davem@davemloft.net>
Date: Tue, 09 Sep 2008 03:55:25 +0000
Subject: sun4m test needed [PATCH]: sparc32: Use OF device probing for
Message-Id: <20080908.205525.31518934.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


If someone could validate this on any sun4m machine, I'd appreciate
it.  It's against sparc-next-2.6

sparc32: Use OF device probing for timer registers.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/timer_32.h |   43 ----------
 arch/sparc/kernel/sun4m_irq.c     |  154 ++++++++++++++++++++-----------------
 2 files changed, 85 insertions(+), 112 deletions(-)

diff --git a/arch/sparc/include/asm/timer_32.h b/arch/sparc/include/asm/timer_32.h
index adab3de..8906e98 100644
--- a/arch/sparc/include/asm/timer_32.h
+++ b/arch/sparc/include/asm/timer_32.h
@@ -35,49 +35,6 @@ struct sun4c_timer_info {
 
 #define SUN_TIMER_PHYSADDR   0xf3000000
 
-/* A sun4m has two blocks of registers which are probably of the same
- * structure. LSI Logic's L64851 is told to _decrement_ from the limit
- * value. Aurora behaves similarly but its limit value is compacted in
- * other fashion (it's wider). Documented fields are defined here.
- */
-
-/* As with the interrupt register, we have two classes of timer registers
- * which are per-cpu and master.  Per-cpu timers only hit that cpu and are
- * only level 14 ticks, master timer hits all cpus and is level 10.
- */
-
-#define SUN4M_PRM_CNT_L       0x80000000
-#define SUN4M_PRM_CNT_LVALUE  0x7FFFFC00
-
-struct sun4m_timer_percpu_info {
-  __volatile__ unsigned int l14_timer_limit;    /* Initial value is 0x009c4000 */
-  __volatile__ unsigned int l14_cur_count;
-
-  /* This register appears to be write only and/or inaccessible
-   * on Uni-Processor sun4m machines.
-   */
-  __volatile__ unsigned int l14_limit_noclear;  /* Data access error is here */
-
-  __volatile__ unsigned int cntrl;            /* =1 after POST on Aurora */
-  __volatile__ unsigned char space[PAGE_SIZE - 16];
-};
-
-struct sun4m_timer_regs {
-	struct sun4m_timer_percpu_info cpu_timers[SUN4M_NCPUS];
-	volatile unsigned int l10_timer_limit;
-	volatile unsigned int l10_cur_count;
-
-	/* Again, this appears to be write only and/or inaccessible
-	 * on uni-processor sun4m machines.
-	 */
-	volatile unsigned int l10_limit_noclear;
-
-	/* This register too, it must be magic. */
-	volatile unsigned int foobar;
-
-	volatile unsigned int cfg;     /* equals zero at boot time... */
-};
-
 #define SUN4D_PRM_CNT_L       0x80000000
 #define SUN4D_PRM_CNT_LVALUE  0x7FFFFC00
 
diff --git a/arch/sparc/kernel/sun4m_irq.c b/arch/sparc/kernel/sun4m_irq.c
index 3481fec..534f61b 100644
--- a/arch/sparc/kernel/sun4m_irq.c
+++ b/arch/sparc/kernel/sun4m_irq.c
@@ -267,95 +267,80 @@ static void sun4m_set_udt(int cpu)
 }
 #endif
 
+struct sun4m_timer_percpu {
+	u32		l14_limit;
+	u32		l14_count;
+	u32		l14_limit_noclear;
+	u32		user_timer_start_stop;
+};
+
+static struct sun4m_timer_percpu __iomem *timers_percpu[SUN4M_NCPUS];
+
+struct sun4m_timer_global {
+	u32		l10_limit;
+	u32		l10_count;
+	u32		l10_limit_noclear;
+	u32		reserved;
+	u32		timer_config;
+};
+
+static struct sun4m_timer_global __iomem *timers_global;
+
 #define OBIO_INTR	0x20
 #define TIMER_IRQ  	(OBIO_INTR | 10)
-#define PROFILE_IRQ	(OBIO_INTR | 14)
 
-static struct sun4m_timer_regs *sun4m_timers;
 unsigned int lvl14_resolution = (((1000000/HZ) + 1) << 10);
 
 static void sun4m_clear_clock_irq(void)
 {
-	volatile unsigned int clear_intr;
-	clear_intr = sun4m_timers->l10_timer_limit;
+	sbus_readl(&timers_global->l10_limit);
 }
 
 static void sun4m_clear_profile_irq(int cpu)
 {
-	volatile unsigned int clear;
-    
-	clear = sun4m_timers->cpu_timers[cpu].l14_timer_limit;
+	sbus_readl(&timers_percpu[cpu]->l14_limit);
 }
 
 static void sun4m_load_profile_irq(int cpu, unsigned int limit)
 {
-	sun4m_timers->cpu_timers[cpu].l14_timer_limit = limit;
+	sbus_writel(limit, &timers_percpu[cpu]->l14_limit);
 }
 
-static void __init sun4m_init_timers(irq_handler_t counter_fn)
+static int __devinit counter_probe(struct of_device *op,
+				   const struct of_device_id *match)
 {
-	int reg_count, irq, cpu;
-	struct linux_prom_registers cnt_regs[PROMREG_MAX];
-	int obio_node, cnt_node;
-	struct resource r;
-
-	cnt_node = 0;
-	if((obio_node -	    prom_searchsiblings (prom_getchild(prom_root_node), "obio")) = 0 ||
-	   (obio_node = prom_getchild (obio_node)) = 0 ||
-	   (cnt_node = prom_searchsiblings (obio_node, "counter")) = 0) {
-		prom_printf("Cannot find /obio/counter node\n");
-		prom_halt();
-	}
-	reg_count = prom_getproperty(cnt_node, "reg",
-				     (void *) cnt_regs, sizeof(cnt_regs));
-	reg_count = (reg_count/sizeof(struct linux_prom_registers));
-    
-	/* Apply the obio ranges to the timer registers. */
-	prom_apply_obio_ranges(cnt_regs, reg_count);
-    
-	cnt_regs[4].phys_addr = cnt_regs[reg_count-1].phys_addr;
-	cnt_regs[4].reg_size = cnt_regs[reg_count-1].reg_size;
-	cnt_regs[4].which_io = cnt_regs[reg_count-1].which_io;
-	for(obio_node = 1; obio_node < 4; obio_node++) {
-		cnt_regs[obio_node].phys_addr -			cnt_regs[obio_node-1].phys_addr + PAGE_SIZE;
-		cnt_regs[obio_node].reg_size = cnt_regs[obio_node-1].reg_size;
-		cnt_regs[obio_node].which_io = cnt_regs[obio_node-1].which_io;
+	int i, err, num_cpu_timers = op->resource[2].flags ? 4 : 1;
+
+	err = -ENOMEM;
+	for (i = 0; i < num_cpu_timers; i++) {
+		timers_percpu[i] = of_ioremap(&op->resource[i], 0,
+					      resource_size(&op->resource[i]),
+					      "sun4m_timer_percpu");
+		if (!timers_percpu[i])
+			goto out_iounmap_percpu;
 	}
 
-	memset((char*)&r, 0, sizeof(struct resource));
-	/* Map the per-cpu Counter registers. */
-	r.flags = cnt_regs[0].which_io;
-	r.start = cnt_regs[0].phys_addr;
-	sun4m_timers = (struct sun4m_timer_regs *) of_ioremap(&r, 0,
-	    PAGE_SIZE*SUN4M_NCPUS, "sun4m_cpu_cnt");
-	/* Map the system Counter register. */
-	/* XXX Here we expect consequent calls to yeld adjusent maps. */
-	r.flags = cnt_regs[4].which_io;
-	r.start = cnt_regs[4].phys_addr;
-	of_ioremap(&r, 0, cnt_regs[4].reg_size, "sun4m_sys_cnt");
-
-	sun4m_timers->l10_timer_limit =  (((1000000/HZ) + 1) << 10);
-	master_l10_counter = &sun4m_timers->l10_cur_count;
-	master_l10_limit = &sun4m_timers->l10_timer_limit;
-
-	irq = request_irq(TIMER_IRQ,
-			  counter_fn,
-			  (IRQF_DISABLED | SA_STATIC_ALLOC),
-			  "timer", NULL);
-	if (irq) {
-		prom_printf("time_init: unable to attach IRQ%d\n",TIMER_IRQ);
-		prom_halt();
-	}
-   
-	if (!cpu_find_by_instance(1, NULL, NULL)) {
-		for(cpu = 0; cpu < 4; cpu++)
-			sun4m_timers->cpu_timers[cpu].l14_timer_limit = 0;
-		sun4m_interrupts->set = SUN4M_INT_E14;
-	} else {
-		sun4m_timers->cpu_timers[0].l14_timer_limit = 0;
-	}
+	/* XXX 'reg' property only claims a size of 16 */
+	timers_global = of_ioremap(&op->resource[num_cpu_timers], 0, 20,
+				   "sun4m_timer_global");
+	if (!timers_global)
+		goto out_iounmap_percpu;
+
+	sbus_writel((((1000000/HZ) + 1) << 10), &timers_global->l10_limit);
+
+	master_l10_counter = &timers_global->l10_count;
+	master_l10_limit = &timers_global->l10_limit;
+
+	err = request_irq(TIMER_IRQ, match->data,
+			  (IRQF_DISABLED | SA_STATIC_ALLOC), "timer", NULL);
+	if (err)
+		goto out_iounmap_global;
+
+	for (i = 0; i < num_cpu_timers; i++)
+		sbus_writel(0, &timers_percpu[i]->l14_limit);
+	if (num_cpu_timers = 4)
+		sbus_writel(SUN4M_INT_E14, &sun4m_interrupts->set);
+
 #ifdef CONFIG_SMP
 	{
 		unsigned long flags;
@@ -375,6 +360,37 @@ static void __init sun4m_init_timers(irq_handler_t counter_fn)
 		local_irq_restore(flags);
 	}
 #endif
+
+out:
+	return err;
+
+out_iounmap_global:
+	of_iounmap(&op->resource[num_cpu_timers], timers_global, 20);
+
+out_iounmap_percpu:
+	for (i = 0; i < num_cpu_timers; i++) {
+		if (timers_percpu[i])
+			of_iounmap(&op->resource[i], timers_percpu[i],
+				   resource_size(&op->resource[i]));
+	}
+	goto out;
+}
+
+static struct of_device_id __initdata counter_match[] = {
+	{ .name = "counter", }, {},
+};
+MODULE_DEVICE_TABLE(of, counter_match);
+
+static struct of_platform_driver counter_driver = {
+	.name		= "counter",
+	.match_table	= counter_match,
+	.probe		= counter_probe,
+};
+
+static void __init sun4m_init_timers(irq_handler_t counter_fn)
+{
+	counter_match[0].data = counter_fn;
+	(void) of_register_driver(&counter_driver, &of_bus_type);
 }
 
 void __init sun4m_init_IRQ(void)
-- 
1.5.6.5.GIT

