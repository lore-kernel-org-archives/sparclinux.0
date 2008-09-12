From: David Miller <davem@davemloft.net>
Date: Fri, 12 Sep 2008 02:04:38 +0000
Subject: Re: [PATCH 0/3]: sun4m timer rework, try 2
Message-Id: <20080911.190438.265825363.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080910.235547.243605729.davem@davemloft.net>
In-Reply-To: <20080910.235547.243605729.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Thu, 11 Sep 2008 18:51:34 -0700 (PDT)

> We can't use the generic device layer until much later and
> that's why it's crashing when we try to register the OF driver
> bus type so early.
> 
> I'll have to try and figure out another way to do this.

Ok, get rid of those patches and try just this one instead.

Thanks in advance Robert.

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
index 3481fec..5b17146 100644
--- a/arch/sparc/kernel/sun4m_irq.c
+++ b/arch/sparc/kernel/sun4m_irq.c
@@ -267,95 +267,88 @@ static void sun4m_set_udt(int cpu)
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
 
 static void __init sun4m_init_timers(irq_handler_t counter_fn)
 {
-	int reg_count, irq, cpu;
-	struct linux_prom_registers cnt_regs[PROMREG_MAX];
-	int obio_node, cnt_node;
-	struct resource r;
+	struct device_node *dp = of_find_node_by_name(NULL, "counter");
+	int i, err, len, num_cpu_timers;
+	const u32 *addr;
 
-	cnt_node = 0;
-	if((obio_node -	    prom_searchsiblings (prom_getchild(prom_root_node), "obio")) = 0 ||
-	   (obio_node = prom_getchild (obio_node)) = 0 ||
-	   (cnt_node = prom_searchsiblings (obio_node, "counter")) = 0) {
-		prom_printf("Cannot find /obio/counter node\n");
-		prom_halt();
+	if (!dp) {
+		printk(KERN_ERR "sun4m_init_timers: No 'counter' node.\n");
+		return;
 	}
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
+
+	addr = of_get_property(dp, "address", &len);
+	if (!addr) {
+		printk(KERN_ERR "sun4m_init_timers: No 'address' prop.\n");
+		return;
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
+	num_cpu_timers = (len / sizeof(u32)) - 1;
+	for (i = 0; i < num_cpu_timers; i++) {
+		timers_percpu[i] = (void __iomem *)
+			(unsigned long) addr[i];
 	}
-   
-	if (!cpu_find_by_instance(1, NULL, NULL)) {
-		for(cpu = 0; cpu < 4; cpu++)
-			sun4m_timers->cpu_timers[cpu].l14_timer_limit = 0;
-		sun4m_interrupts->set = SUN4M_INT_E14;
-	} else {
-		sun4m_timers->cpu_timers[0].l14_timer_limit = 0;
+	timers_global = (void __iomem *)
+		(unsigned long) addr[num_cpu_timers];
+
+	sbus_writel((((1000000/HZ) + 1) << 10), &timers_global->l10_limit);
+
+	master_l10_counter = &timers_global->l10_count;
+	master_l10_limit = &timers_global->l10_limit;
+
+	err = request_irq(TIMER_IRQ, counter_fn,
+			  (IRQF_DISABLED | SA_STATIC_ALLOC), "timer", NULL);
+	if (err) {
+		printk(KERN_ERR "sun4m_init_timers: Register IRQ error %d.\n",
+			err);
+		return;
 	}
+
+	for (i = 0; i < num_cpu_timers; i++)
+		sbus_writel(0, &timers_percpu[i]->l14_limit);
+	if (num_cpu_timers = 4)
+		sbus_writel(SUN4M_INT_E14, &sun4m_interrupts->set);
+
 #ifdef CONFIG_SMP
 	{
 		unsigned long flags;
