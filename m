From: Bob Breuer <breuerr@mc.net>
Date: Wed, 25 Jan 2006 22:20:37 +0000
Subject: sparc32 smp patch
Message-Id: <43D7F9B5.9050707@mc.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------060208010505030102090802"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------060208010505030102090802
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Here's the latest update of the SMP patch (see [1] for a previous
incarnation).

It may not be ready for upstream merging yet, but it would be helpful to
get some review and testing of it.

Todo items:
 - IRQ_INPROGRESS flag - use sparc64 irq buckets, or generic irq_desc?
 - sun4d
 - re-indent large chunks of sun4m_smp.c
 - some places assume sequential cpu numbering (i.e. 0,1 instead of 0,2)

Last I checked (with 2.6.14), random programs segfault with dual
HyperSPARC.  And with SuperSPARC II's, it seems stable but will
eventually die from a write lock error (wrong lock owner or something).

I haven't tried the HyperSPARC + highmem combination recently, so that
may still be a problem.

Bob

[1] http://marc.theaimsgroup.com/?l=linux-sparc&m=110828111116713&w=2

--------------060208010505030102090802
Content-Type: text/plain;
 name="linux-2.6.14-sparc32-smp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.14-sparc32-smp.patch"

diff -urp -X dontdiff linux-2.6.14-clean/arch/sparc/Kconfig linux-2.6.14smp/arch/sparc/Kconfig
--- linux-2.6.14-clean/arch/sparc/Kconfig	2005-10-28 20:13:28.000000000 -0500
+++ linux-2.6.14smp/arch/sparc/Kconfig	2005-10-30 12:27:09.000000000 -0600
@@ -27,7 +27,6 @@ menu "General machine setup"
 
 config SMP
 	bool "Symmetric multi-processing support (does not work on sun4/sun4c)"
-	depends on BROKEN
 	---help---
 	  This enables support for systems with more than one CPU. If you have
 	  a system with only one CPU, say N. If you have a system with more
diff -urp -X dontdiff linux-2.6.14-clean/arch/sparc/kernel/irq.c linux-2.6.14smp/arch/sparc/kernel/irq.c
--- linux-2.6.14-clean/arch/sparc/kernel/irq.c	2005-06-22 09:03:02.000000000 -0500
+++ linux-2.6.14smp/arch/sparc/kernel/irq.c	2005-11-15 09:22:33.000000000 -0600
@@ -154,9 +154,11 @@ void (*sparc_init_timers)(irqreturn_t (*
 struct irqaction static_irqaction[MAX_STATIC_ALLOC];
 int static_irq_count;
 
-struct irqaction *irq_action[NR_IRQS] = {
-	[0 ... (NR_IRQS-1)] = NULL
-};
+struct {
+	struct irqaction *action;
+	int flags;
+} sparc_irq[NR_IRQS];
+#define SPARC_IRQ_INPROGRESS 1
 
 /* Used to protect the IRQ action lists */
 DEFINE_SPINLOCK(irq_action_lock);
@@ -177,7 +179,7 @@ int show_interrupts(struct seq_file *p, 
 	}
 	spin_lock_irqsave(&irq_action_lock, flags);
 	if (i < NR_IRQS) {
-	        action = *(i + irq_action);
+		action = sparc_irq[i].action;
 		if (!action) 
 			goto out_unlock;
 		seq_printf(p, "%3d: ", i);
@@ -187,7 +189,7 @@ int show_interrupts(struct seq_file *p, 
 		for (j = 0; j < NR_CPUS; j++) {
 			if (cpu_online(j))
 				seq_printf(p, "%10u ",
-				    kstat_cpu(cpu_logical_map(j)).irqs[i]);
+				    kstat_cpu(j).irqs[i]);
 		}
 #endif
 		seq_printf(p, " %c %s",
@@ -208,7 +210,7 @@ out_unlock:
 void free_irq(unsigned int irq, void *dev_id)
 {
 	struct irqaction * action;
-	struct irqaction * tmp = NULL;
+	struct irqaction **actionp;
         unsigned long flags;
 	unsigned int cpu_irq;
 	
@@ -226,7 +228,8 @@ void free_irq(unsigned int irq, void *de
 
 	spin_lock_irqsave(&irq_action_lock, flags);
 
-	action = *(cpu_irq + irq_action);
+	actionp = &sparc_irq[cpu_irq].action;
+	action = *actionp;
 
 	if (!action->handler) {
 		printk("Trying to free free IRQ%d\n",irq);
@@ -236,7 +239,7 @@ void free_irq(unsigned int irq, void *de
 		for (; action; action = action->next) {
 			if (action->dev_id == dev_id)
 				break;
-			tmp = action;
+			actionp = &action->next;
 		}
 		if (!action) {
 			printk("Trying to free free shared IRQ%d\n",irq);
@@ -255,11 +258,8 @@ void free_irq(unsigned int irq, void *de
 		       irq, action->name);
 		goto out_unlock;
 	}
-	
-	if (action && tmp)
-		tmp->next = action->next;
-	else
-		*(cpu_irq + irq_action) = action->next;
+
+	*actionp = action->next;
 
 	spin_unlock_irqrestore(&irq_action_lock, flags);
 
@@ -269,7 +269,7 @@ void free_irq(unsigned int irq, void *de
 
 	kfree(action);
 
-	if (!(*(cpu_irq + irq_action)))
+	if (!sparc_irq[cpu_irq].action)
 		disable_irq(irq);
 
 out_unlock:
@@ -288,8 +288,11 @@ EXPORT_SYMBOL(free_irq);
 #ifdef CONFIG_SMP
 void synchronize_irq(unsigned int irq)
 {
-	printk("synchronize_irq says: implement me!\n");
-	BUG();
+	unsigned int cpu_irq;
+
+	cpu_irq = irq & (NR_IRQS - 1);
+	while (sparc_irq[cpu_irq].flags & SPARC_IRQ_INPROGRESS)
+		cpu_relax();
 }
 #endif /* SMP */
 
@@ -300,7 +303,7 @@ void unexpected_irq(int irq, void *dev_i
 	unsigned int cpu_irq;
 	
 	cpu_irq = irq & (NR_IRQS - 1);
-	action = *(cpu_irq + irq_action);
+	action = sparc_irq[cpu_irq].action;
 
         printk("IO device interrupt, irq = %d\n", irq);
         printk("PC = %08lx NPC = %08lx FP=%08lx\n", regs->pc, 
@@ -331,7 +334,8 @@ void handler_irq(int irq, struct pt_regs
 	if(irq < 10)
 		smp4m_irq_rotate(cpu);
 #endif
-	action = *(irq + irq_action);
+	action = sparc_irq[irq].action;
+	sparc_irq[irq].flags |= SPARC_IRQ_INPROGRESS;
 	kstat_cpu(cpu).irqs[irq]++;
 	do {
 		if (!action || !action->handler)
@@ -339,6 +343,7 @@ void handler_irq(int irq, struct pt_regs
 		action->handler(irq, action->dev_id, regs);
 		action = action->next;
 	} while (action);
+	sparc_irq[irq].flags &= ~SPARC_IRQ_INPROGRESS;
 	enable_pil_irq(irq);
 	irq_exit();
 }
@@ -390,7 +395,7 @@ int request_fast_irq(unsigned int irq,
 
 	spin_lock_irqsave(&irq_action_lock, flags);
 
-	action = *(cpu_irq + irq_action);
+	action = sparc_irq[cpu_irq].action;
 	if(action) {
 		if(action->flags & SA_SHIRQ)
 			panic("Trying to register fast irq when already shared.\n");
@@ -453,7 +458,7 @@ int request_fast_irq(unsigned int irq,
 	action->dev_id = NULL;
 	action->next = NULL;
 
-	*(cpu_irq + irq_action) = action;
+	sparc_irq[cpu_irq].action = action;
 
 	enable_irq(irq);
 
@@ -468,7 +473,7 @@ int request_irq(unsigned int irq,
 		irqreturn_t (*handler)(int, void *, struct pt_regs *),
 		unsigned long irqflags, const char * devname, void *dev_id)
 {
-	struct irqaction * action, *tmp = NULL;
+	struct irqaction * action, **actionp;
 	unsigned long flags;
 	unsigned int cpu_irq;
 	int ret;
@@ -491,20 +496,20 @@ int request_irq(unsigned int irq,
 	    
 	spin_lock_irqsave(&irq_action_lock, flags);
 
-	action = *(cpu_irq + irq_action);
+	actionp = &sparc_irq[cpu_irq].action;
+	action = *actionp;
 	if (action) {
-		if ((action->flags & SA_SHIRQ) && (irqflags & SA_SHIRQ)) {
-			for (tmp = action; tmp->next; tmp = tmp->next);
-		} else {
+		if (!(action->flags & SA_SHIRQ) || !(irqflags & SA_SHIRQ)) {
 			ret = -EBUSY;
 			goto out_unlock;
 		}
-		if ((action->flags & SA_INTERRUPT) ^ (irqflags & SA_INTERRUPT)) {
+		if ((action->flags & SA_INTERRUPT) != (irqflags & SA_INTERRUPT)) {
 			printk("Attempt to mix fast and slow interrupts on IRQ%d denied\n", irq);
 			ret = -EBUSY;
 			goto out_unlock;
-		}   
-		action = NULL;		/* Or else! */
+		}
+		for ( ; action; action = *actionp)
+			actionp = &action->next;
 	}
 
 	/* If this is flagged as statically allocated then we use our
@@ -533,10 +538,7 @@ int request_irq(unsigned int irq,
 	action->next = NULL;
 	action->dev_id = dev_id;
 
-	if (tmp)
-		tmp->next = action;
-	else
-		*(cpu_irq + irq_action) = action;
+	*actionp = action;
 
 	enable_irq(irq);
 
diff -urp -X dontdiff linux-2.6.14-clean/arch/sparc/kernel/smp.c linux-2.6.14smp/arch/sparc/kernel/smp.c
--- linux-2.6.14-clean/arch/sparc/kernel/smp.c	2005-06-22 09:07:18.000000000 -0500
+++ linux-2.6.14smp/arch/sparc/kernel/smp.c	2005-11-06 13:50:44.000000000 -0600
@@ -45,6 +45,7 @@ volatile int __cpu_logical_map[NR_CPUS];
 
 cpumask_t cpu_online_map = CPU_MASK_NONE;
 cpumask_t phys_cpu_present_map = CPU_MASK_NONE;
+cpumask_t smp_commenced_mask = CPU_MASK_NONE;
 
 /* The only guaranteed locking primitive available on all Sparc
  * processors is 'ldstub [%reg + immediate], %dest_reg' which atomically
@@ -57,11 +58,6 @@ cpumask_t phys_cpu_present_map = CPU_MAS
 /* Used to make bitops atomic */
 unsigned char bitops_spinlock = 0;
 
-volatile unsigned long ipi_count;
-
-volatile int smp_process_available=0;
-volatile int smp_commenced = 0;
-
 void __init smp_store_cpu_info(int id)
 {
 	int cpu_node;
@@ -79,6 +75,22 @@ void __init smp_store_cpu_info(int id)
 
 void __init smp_cpus_done(unsigned int max_cpus)
 {
+	extern void smp4m_smp_done(void);
+	unsigned long bogosum = 0;
+	int cpu, num;
+
+	for (cpu = 0, num = 0; cpu < NR_CPUS; cpu++)
+		if (cpu_online(cpu)) {
+			num++;
+			bogosum += cpu_data(cpu).udelay_val;
+		}
+
+	printk("Total of %d processors activated (%lu.%02lu BogoMIPS).\n",
+		num, bogosum/(500000/HZ),
+		(bogosum/(5000/HZ))%100);
+
+	BUG_ON(sparc_cpu_model != sun4m);
+	smp4m_smp_done();
 }
 
 void cpu_panic(void)
@@ -89,17 +101,6 @@ void cpu_panic(void)
 
 struct linux_prom_registers smp_penguin_ctable __initdata = { 0 };
 
-void __init smp_boot_cpus(void)
-{
-	extern void smp4m_boot_cpus(void);
-	extern void smp4d_boot_cpus(void);
-	
-	if (sparc_cpu_model == sun4m)
-		smp4m_boot_cpus();
-	else
-		smp4d_boot_cpus();
-}
-
 void smp_send_reschedule(int cpu)
 {
 	/* See sparc64 */
@@ -253,20 +254,61 @@ int setup_profiling_timer(unsigned int m
 	return 0;
 }
 
-void __init smp_prepare_cpus(unsigned int maxcpus)
+void __init smp_prepare_cpus(unsigned int max_cpus)
 {
+	extern void smp4m_boot_cpus(void);
+	int i, cpuid, ncpus, extra;
+
+	BUG_ON(sparc_cpu_model != sun4m);
+	printk("Entering SMP Mode...\n");
+
+	ncpus = 1;
+	extra = 0;
+	for (i = 0; !cpu_find_by_instance(i, NULL, &cpuid); i++) {
+		if (cpuid == boot_cpu_id)
+			continue;
+		if (cpuid < NR_CPUS && ncpus++ < max_cpus)
+			cpu_set(cpuid, phys_cpu_present_map);
+		else
+			extra++;
+	}
+	if (max_cpus >= NR_CPUS && extra)
+		printk("Warning: NR_CPUS is too low to start all cpus\n");
+
+	smp_store_cpu_info(boot_cpu_id);
+
+	smp4m_boot_cpus();
 }
 
 void __devinit smp_prepare_boot_cpu(void)
 {
-	current_thread_info()->cpu = hard_smp_processor_id();
-	cpu_set(smp_processor_id(), cpu_online_map);
-	cpu_set(smp_processor_id(), phys_cpu_present_map);
+	int cpuid = hard_smp_processor_id();
+
+	if (cpuid >= NR_CPUS) {
+		prom_printf("Serious problem, boot cpu id >= NR_CPUS\n");
+		prom_halt();
+	}
+	if (cpuid != 0)
+		printk("boot cpu id != 0, this could work but is untested\n");
+
+	current_thread_info()->cpu = cpuid;
+	cpu_set(cpuid, cpu_online_map);
+	cpu_set(cpuid, phys_cpu_present_map);
 }
 
 int __devinit __cpu_up(unsigned int cpu)
 {
-	panic("smp doesn't work\n");
+	extern int smp4m_boot_one_cpu(int);
+	int ret;
+
+	ret = smp4m_boot_one_cpu(cpu);
+
+	if (!ret) {
+		cpu_set(cpu, smp_commenced_mask);
+		while (!cpu_online(cpu))
+			mb();
+	}
+	return ret;
 }
 
 void smp_bogo(struct seq_file *m)
diff -urp -X dontdiff linux-2.6.14-clean/arch/sparc/kernel/sparc_ksyms.c linux-2.6.14smp/arch/sparc/kernel/sparc_ksyms.c
--- linux-2.6.14-clean/arch/sparc/kernel/sparc_ksyms.c	2005-10-28 20:13:29.000000000 -0500
+++ linux-2.6.14smp/arch/sparc/kernel/sparc_ksyms.c	2005-10-30 15:26:11.000000000 -0600
@@ -139,10 +139,6 @@ EXPORT_PER_CPU_SYMBOL(__cpu_data);
 /* IRQ implementation. */
 EXPORT_SYMBOL(synchronize_irq);
 
-/* Misc SMP information */
-EXPORT_SYMBOL(__cpu_number_map);
-EXPORT_SYMBOL(__cpu_logical_map);
-
 /* CPU online map and active count. */
 EXPORT_SYMBOL(cpu_online_map);
 EXPORT_SYMBOL(phys_cpu_present_map);
diff -urp -X dontdiff linux-2.6.14-clean/arch/sparc/kernel/sun4d_irq.c linux-2.6.14smp/arch/sparc/kernel/sun4d_irq.c
--- linux-2.6.14-clean/arch/sparc/kernel/sun4d_irq.c	2005-06-22 09:03:03.000000000 -0500
+++ linux-2.6.14smp/arch/sparc/kernel/sun4d_irq.c	2005-10-30 15:31:25.000000000 -0600
@@ -54,7 +54,7 @@ unsigned char cpu_leds[32];
 unsigned char sbus_tid[32];
 #endif
 
-extern struct irqaction *irq_action[];
+static struct irqaction *irq_action[NR_IRQS];
 extern spinlock_t irq_action_lock;
 
 struct sbus_action {
diff -urp -X dontdiff linux-2.6.14-clean/arch/sparc/kernel/sun4d_smp.c linux-2.6.14smp/arch/sparc/kernel/sun4d_smp.c
--- linux-2.6.14-clean/arch/sparc/kernel/sun4d_smp.c	2005-06-22 09:07:18.000000000 -0500
+++ linux-2.6.14smp/arch/sparc/kernel/sun4d_smp.c	2005-10-30 15:35:15.000000000 -0600
@@ -53,7 +53,9 @@ extern volatile int __cpu_number_map[NR_
 extern volatile int __cpu_logical_map[NR_CPUS];
 extern volatile unsigned long ipi_count;
 extern volatile int smp_process_available;
-extern volatile int smp_commenced;
+
+extern cpumask_t smp_commenced_mask;
+
 extern int __smp4d_processor_id(void);
 
 /* #define SMP_DEBUG */
@@ -136,7 +138,7 @@ void __init smp4d_callin(void)
 	
 	local_irq_enable();	/* We don't allow PIL 14 yet */
 	
-	while(!smp_commenced)
+	while (!cpu_isset(cpuid, smp_commenced_mask))
 		barrier();
 
 	spin_lock_irqsave(&sun4d_imsk_lock, flags);
diff -urp -X dontdiff linux-2.6.14-clean/arch/sparc/kernel/sun4m_smp.c linux-2.6.14smp/arch/sparc/kernel/sun4m_smp.c
--- linux-2.6.14-clean/arch/sparc/kernel/sun4m_smp.c	2005-06-22 09:07:18.000000000 -0500
+++ linux-2.6.14smp/arch/sparc/kernel/sun4m_smp.c	2005-10-30 17:20:52.000000000 -0600
@@ -40,15 +40,11 @@ extern ctxd_t *srmmu_ctx_table_phys;
 extern void calibrate_delay(void);
 
 extern volatile int smp_processors_ready;
-extern int smp_num_cpus;
 extern volatile unsigned long cpu_callin_map[NR_CPUS];
 extern unsigned char boot_cpu_id;
-extern int smp_activated;
-extern volatile int __cpu_number_map[NR_CPUS];
-extern volatile int __cpu_logical_map[NR_CPUS];
-extern volatile unsigned long ipi_count;
-extern volatile int smp_process_available;
-extern volatile int smp_commenced;
+
+extern cpumask_t smp_commenced_mask;
+
 extern int __smp4m_processor_id(void);
 
 /*#define SMP_DEBUG*/
@@ -77,8 +73,6 @@ void __init smp4m_callin(void)
 	local_flush_cache_all();
 	local_flush_tlb_all();
 
-	set_irq_udt(boot_cpu_id);
-
 	/* Get our local ticker going. */
 	smp_setup_percpu_timer();
 
@@ -95,8 +89,9 @@ void __init smp4m_callin(void)
 	 * to call the scheduler code.
 	 */
 	/* Allow master to continue. */
-	swap((unsigned long *)&cpu_callin_map[cpuid], 1);
+	swap(&cpu_callin_map[cpuid], 1);
 
+	/* XXX: What's up with all the flushes? */
 	local_flush_cache_all();
 	local_flush_tlb_all();
 	
@@ -111,13 +106,14 @@ void __init smp4m_callin(void)
 	atomic_inc(&init_mm.mm_count);
 	current->active_mm = &init_mm;
 
-	while(!smp_commenced)
-		barrier();
-
-	local_flush_cache_all();
-	local_flush_tlb_all();
+	while (!cpu_isset(cpuid, smp_commenced_mask))
+		mb();
 
 	local_irq_enable();
+
+	cpu_set(cpuid, cpu_online_map);
+	/* last one in gets all the interrupts (for testing) */
+	set_irq_udt(boot_cpu_id);
 }
 
 extern void init_IRQ(void);
@@ -134,45 +130,22 @@ extern unsigned long trapbase_cpu3[];
 
 void __init smp4m_boot_cpus(void)
 {
-	int cpucount = 0;
-	int i, mid;
-
-	printk("Entering SMP Mode...\n");
-
-	local_irq_enable();
-	cpus_clear(cpu_present_map);
-
-	for (i = 0; !cpu_find_by_instance(i, NULL, &mid); i++)
-		cpu_set(mid, cpu_present_map);
-
-	for(i=0; i < NR_CPUS; i++) {
-		__cpu_number_map[i] = -1;
-		__cpu_logical_map[i] = -1;
-	}
-
-	__cpu_number_map[boot_cpu_id] = 0;
-	__cpu_logical_map[0] = boot_cpu_id;
-	current_thread_info()->cpu = boot_cpu_id;
-
-	smp_store_cpu_info(boot_cpu_id);
-	set_irq_udt(boot_cpu_id);
 	smp_setup_percpu_timer();
 	local_flush_cache_all();
-	if(cpu_find_by_instance(1, NULL, NULL))
-		return;  /* Not an MP box. */
-	for(i = 0; i < NR_CPUS; i++) {
-		if(i == boot_cpu_id)
-			continue;
+}
 
-		if (cpu_isset(i, cpu_present_map)) {
+int smp4m_boot_one_cpu(int i)
+{
 			extern unsigned long sun4m_cpu_startup;
 			unsigned long *entry = &sun4m_cpu_startup;
 			struct task_struct *p;
 			int timeout;
+	int cpu_node;
+
+	cpu_find_by_mid(i, &cpu_node);
 
 			/* Cook up an idler for this guy. */
 			p = fork_idle(i);
-			cpucount++;
 			current_set[i] = p->thread_info;
 			/* See trampoline.S for details... */
 			entry += ((i-1) * 3);
@@ -189,7 +162,7 @@ void __init smp4m_boot_cpus(void)
 			/* whirrr, whirrr, whirrrrrrrrr... */
 			printk("Starting CPU %d at %p\n", i, entry);
 			local_flush_cache_all();
-			prom_startcpu(cpu_data(i).prom_node,
+			prom_startcpu(cpu_node,
 				      &smp_penguin_ctable, 0, (char *)entry);
 
 			/* wheee... it's going... */
@@ -198,40 +171,32 @@ void __init smp4m_boot_cpus(void)
 					break;
 				udelay(200);
 			}
-			if(cpu_callin_map[i]) {
-				/* Another "Red Snapper". */
-				__cpu_number_map[i] = i;
-				__cpu_logical_map[i] = i;
-			} else {
-				cpucount--;
-				printk("Processor %d is stuck.\n", i);
-			}
-		}
-		if(!(cpu_callin_map[i])) {
-			cpu_clear(i, cpu_present_map);
-			__cpu_number_map[i] = -1;
-		}
+	if (!(cpu_callin_map[i])) {
+		printk("Processor %d is stuck.\n", i);
+		return -ENODEV;
 	}
 	local_flush_cache_all();
-	if(cpucount == 0) {
-		printk("Error: only one Processor found.\n");
-		cpu_present_map = cpumask_of_cpu(smp_processor_id());
-	} else {
-		unsigned long bogosum = 0;
-		for(i = 0; i < NR_CPUS; i++) {
-			if (cpu_isset(i, cpu_present_map))
-				bogosum += cpu_data(i).udelay_val;
+	return 0;
+}
+
+void __init smp4m_smp_done(void)
+{
+	int i, first;
+	int *prev;
+
+	/* setup cpu list for irq rotation */
+	first = 0;
+	prev = &first;
+	for (i = 0; i < NR_CPUS; i++)
+		if (cpu_online(i)) {
+			*prev = i;
+			prev = &cpu_data(i).next;
 		}
-		printk("Total of %d Processors activated (%lu.%02lu BogoMIPS).\n",
-		       cpucount + 1,
-		       bogosum/(500000/HZ),
-		       (bogosum/(5000/HZ))%100);
-		smp_activated = 1;
-		smp_num_cpus = cpucount + 1;
-	}
+	*prev = first;
+	local_flush_cache_all();
 
 	/* Free unneeded trap tables */
-	if (!cpu_isset(i, cpu_present_map)) {
+	if (!cpu_isset(1, cpu_present_map)) {
 		ClearPageReserved(virt_to_page(trapbase_cpu1));
 		set_page_count(virt_to_page(trapbase_cpu1), 1);
 		free_page((unsigned long)trapbase_cpu1);
@@ -265,6 +230,9 @@ void __init smp4m_boot_cpus(void)
  */
 void smp4m_irq_rotate(int cpu)
 {
+	int next = cpu_data(cpu).next;
+	if (next != cpu)
+		set_irq_udt(next);
 }
 
 /* Cross calls, in order to work efficiently and atomically do all
@@ -291,7 +259,7 @@ void smp4m_message_pass(int target, int 
 
 	smp_cpu_in_msg[me]++;
 	if(target == MSG_ALL_BUT_SELF || target == MSG_ALL) {
-		mask = cpu_present_map;
+		mask = cpu_online_map;
 		if(target == MSG_ALL_BUT_SELF)
 			cpu_clear(me, mask);
 		for(i = 0; i < 4; i++) {
@@ -316,8 +284,8 @@ static struct smp_funcall {
 	unsigned long arg3;
 	unsigned long arg4;
 	unsigned long arg5;
-	unsigned long processors_in[NR_CPUS];  /* Set when ipi entered. */
-	unsigned long processors_out[NR_CPUS]; /* Set when ipi exited. */
+	unsigned long processors_in[SUN4M_NCPUS];  /* Set when ipi entered. */
+	unsigned long processors_out[SUN4M_NCPUS]; /* Set when ipi exited. */
 } ccall_info;
 
 static DEFINE_SPINLOCK(cross_call_lock);
@@ -326,8 +294,7 @@ static DEFINE_SPINLOCK(cross_call_lock);
 void smp4m_cross_call(smpfunc_t func, unsigned long arg1, unsigned long arg2,
 		    unsigned long arg3, unsigned long arg4, unsigned long arg5)
 {
-	if(smp_processors_ready) {
-		register int ncpus = smp_num_cpus;
+		register int ncpus = SUN4M_NCPUS;
 		unsigned long flags;
 
 		spin_lock_irqsave(&cross_call_lock, flags);
@@ -342,7 +309,7 @@ void smp4m_cross_call(smpfunc_t func, un
 
 		/* Init receive/complete mapping, plus fire the IPI's off. */
 		{
-			cpumask_t mask = cpu_present_map;
+			cpumask_t mask = cpu_online_map;
 			register int i;
 
 			cpu_clear(smp_processor_id(), mask);
@@ -375,7 +342,6 @@ void smp4m_cross_call(smpfunc_t func, un
 		}
 
 		spin_unlock_irqrestore(&cross_call_lock, flags);
-	}
 }
 
 /* Running cross calls. */
Only in linux-2.6.14smp/arch/sparc/kernel: vmlinux.lds
diff -urp -X dontdiff linux-2.6.14-clean/arch/sparc/mm/srmmu.c linux-2.6.14smp/arch/sparc/mm/srmmu.c
--- linux-2.6.14-clean/arch/sparc/mm/srmmu.c	2005-10-28 20:13:29.000000000 -0500
+++ linux-2.6.14smp/arch/sparc/mm/srmmu.c	2005-11-15 08:54:53.000000000 -0600
@@ -1302,7 +1302,12 @@ void __init srmmu_paging_init(void)
 
 	flush_cache_all();
 	srmmu_set_ctable_ptr((unsigned long)srmmu_ctx_table_phys);
+#ifdef CONFIG_SMP
+	/* Stop from hanging here... */
+	local_flush_tlb_all();
+#else
 	flush_tlb_all();
+#endif
 	poke_srmmu();
 
 #ifdef CONFIG_SUN_IO
@@ -1419,6 +1424,7 @@ static void __init init_vac_layout(void)
 				max_size = vac_cache_size;
 			if(vac_line_size < min_line_size)
 				min_line_size = vac_line_size;
+			//FIXME: cpus not contiguous!!
 			cpu++;
 			if (cpu >= NR_CPUS || !cpu_online(cpu))
 				break;
diff -urp -X dontdiff linux-2.6.14-clean/include/asm-sparc/cpudata.h linux-2.6.14smp/include/asm-sparc/cpudata.h
--- linux-2.6.14-clean/include/asm-sparc/cpudata.h	2004-10-18 16:54:40.000000000 -0500
+++ linux-2.6.14smp/include/asm-sparc/cpudata.h	2005-10-30 15:38:22.000000000 -0600
@@ -18,6 +18,7 @@ typedef struct {
 	unsigned int counter;
 	int prom_node;
 	int mid;
+	int next;
 } cpuinfo_sparc;
 
 DECLARE_PER_CPU(cpuinfo_sparc, __cpu_data);
diff -urp -X dontdiff linux-2.6.14-clean/include/asm-sparc/smp.h linux-2.6.14smp/include/asm-sparc/smp.h
--- linux-2.6.14-clean/include/asm-sparc/smp.h	2005-10-28 20:15:32.000000000 -0500
+++ linux-2.6.14smp/include/asm-sparc/smp.h	2005-10-30 15:45:37.000000000 -0600
@@ -81,16 +81,9 @@ static inline int smp_call_function(void
 	return 0;
 }
 
-extern __volatile__ int __cpu_number_map[NR_CPUS];
-extern __volatile__ int __cpu_logical_map[NR_CPUS];
-
 static inline int cpu_logical_map(int cpu)
 {
-	return __cpu_logical_map[cpu];
-}
-static inline int cpu_number_map(int cpu)
-{
-	return __cpu_number_map[cpu];
+	return cpu;
 }
 
 static inline int hard_smp4m_processor_id(void)
diff -urp -X dontdiff linux-2.6.14-clean/include/asm-sparc/spinlock.h linux-2.6.14smp/include/asm-sparc/spinlock.h
--- linux-2.6.14-clean/include/asm-sparc/spinlock.h	2005-10-28 20:15:32.000000000 -0500
+++ linux-2.6.14smp/include/asm-sparc/spinlock.h	2005-11-09 22:47:21.000000000 -0600
@@ -94,7 +94,7 @@ static inline void __read_lock(raw_rwloc
 #define __raw_read_lock(lock) \
 do {	unsigned long flags; \
 	local_irq_save(flags); \
-	__raw_read_lock(lock); \
+	__read_lock(lock); \
 	local_irq_restore(flags); \
 } while(0)
 
@@ -114,11 +114,11 @@ static inline void __read_unlock(raw_rwl
 #define __raw_read_unlock(lock) \
 do {	unsigned long flags; \
 	local_irq_save(flags); \
-	__raw_read_unlock(lock); \
+	__read_unlock(lock); \
 	local_irq_restore(flags); \
 } while(0)
 
-extern __inline__ void __raw_write_lock(raw_rwlock_t *rw)
+static inline void __raw_write_lock(raw_rwlock_t *rw)
 {
 	register raw_rwlock_t *lp asm("g1");
 	lp = rw;
@@ -131,9 +131,28 @@ extern __inline__ void __raw_write_lock(
 	: "g2", "g4", "memory", "cc");
 }
 
+static inline int __raw_write_trylock(raw_rwlock_t *rw)
+{
+	unsigned int val;
+
+	__asm__ __volatile__("ldstub [%1 + 3], %0"
+			     : "=r" (val)
+			     : "r" (&rw->lock)
+			     : "memory");
+
+	if (val == 0) {
+		val = rw->lock & ~0xff;
+		if (val)
+			((volatile u8*)&rw->lock)[3] = 0;
+	}
+
+	return (val == 0);
+}
+
 #define __raw_write_unlock(rw)	do { (rw)->lock = 0; } while(0)
 
 #define __raw_spin_lock_flags(lock, flags) __raw_spin_lock(lock)
+#define __raw_read_trylock(lock) generic__raw_read_trylock(lock)
 
 #endif /* !(__ASSEMBLY__) */
 

--------------060208010505030102090802--
