From: William Lee Irwin III <wli@holomorphy.com>
Date: Wed, 28 Jul 2004 22:06:03 +0000
Subject: Re: SMP support in 2.6.x kernel for sparc32
Message-Id: <20040728220603.GZ2334@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <001301c474db$af707860$3c01a8c0@cascade>
In-Reply-To: <001301c474db$af707860$3c01a8c0@cascade>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Jul 28, 2004 at 09:47:14PM +0200, Tom Weustink wrote:
> I got this e-mail address from people in #gentoo-sparc over at freenode.net.
> My SparcStation 10 dual CPU machine is having problems running a kernel
> higher then vesion 2.4.23.
> The higher versions don't load, or lock up the machine after a while without
> a log the check on why.
> So, I would like to try out the 2.6.x versions but gentoo has no stable
> support for SMP sparc32.
> I was told I should talk to you since you have some patches (unstable I was
> told) that might do the trick in getting 2.6.x on SMP sparc32 machines.
> Is it possible you can give me your patches to me to try them out?
> Hope to hear back from you.
> With kind regards,
> freshy98

Odd that 2.4.x worked. Anyway, the patch I was sent, against an
uncertain kernel version sometime around 2.6.4, is as follows.
This appears to need debugging.

I expect that this patch will not qualify as stable, esp. given that
there's a follow-on patch that is designed to debug various lockups
said to occur with it.


-- wli

At some point in the past, Keith M Wesolowski wrote:
> Next, the smp32 patch.  Applied to ~2.6.4 or so.  Needs work.  This is
> the actual working version to use.  The next one I'll send is a
> debugging one with weird stuff for supersparc-ii only in it, trying to
> debug xcalls and lockups.

=== arch/sparc/kernel/entry.S 1.22 vs edited ==--- 1.22/arch/sparc/kernel/entry.S	Sun Mar 21 22:02:59 2004
+++ edited/arch/sparc/kernel/entry.S	Sun Mar 21 22:04:27 2004
@@ -350,7 +350,7 @@
 	 * for cross calls.  That has a separate entry point below.
 	 */
 maybe_smp4m_msg:
-	GET_PROCESSOR_MID(o3)
+	GET_PROCESSOR4M_ID(o3)
 	set	sun4m_interrupts, %l5
 	ld	[%l5], %o5
 	sethi	%hi(0x60000000), %o4
@@ -359,6 +359,7 @@
 	andcc	%o1, %o4, %g0
 	be,a	smp4m_ticker
 	 cmp	%l7, 14
+#if 0 /* NO */
 	sethi	%hi(0x40000000), %o2
 	add	%o5, %o3, %o5
 	andcc	%o1, %o2, %g0
@@ -383,6 +384,7 @@
 2:
 	call	smp_stop_cpu_irq
 	 nop
+#endif
 	RESTORE_ALL
 
 	.align	4
@@ -390,7 +392,7 @@
 linux_trap_ipi15_sun4m:
 	SAVE_ALL
 	sethi	%hi(0x80000000), %o2
-	GET_PROCESSOR_MID(o0)
+	GET_PROCESSOR4M_ID(o0)
 	set	sun4m_interrupts, %l5
 	ld	[%l5], %o5
 	sll	%o0, 12, %o0
=== arch/sparc/kernel/init_task.c 1.9 vs edited ==--- 1.9/arch/sparc/kernel/init_task.c	Tue Oct  7 19:53:41 2003
+++ edited/arch/sparc/kernel/init_task.c	Sun Mar 21 22:04:28 2004
@@ -21,5 +21,7 @@
  * If this is not aligned on a 8k boundry, then you should change code
  * in etrap.S which assumes it.
  */
-__asm__(".section \".text\",#alloc\n");
-union thread_union init_thread_union = { INIT_THREAD_INFO(init_task) };
+union thread_union init_thread_union
+	__attribute__((section (".text")))
+	__attribute__((aligned (THREAD_SIZE)))
+	= { INIT_THREAD_INFO(init_task) };
=== arch/sparc/kernel/irq.c 1.28 vs edited ==--- 1.28/arch/sparc/kernel/irq.c	Sun Feb 22 14:34:53 2004
+++ edited/arch/sparc/kernel/irq.c	Sun Mar 21 22:04:28 2004
@@ -188,7 +188,7 @@
 		for (j = 0; j < NR_CPUS; j++) {
 			if (cpu_online(j))
 				seq_printf(p, "%10u ",
-				    kstat_cpu(cpu_logical_map(j)).irqs[i]);
+				    kstat_cpu(j).irqs[i]);
 		}
 #endif
 		seq_printf(p, " %c %s",
@@ -289,7 +289,7 @@
 void synchronize_irq(unsigned int irq)
 {
 	printk("synchronize_irq says: implement me!\n");
-	BUG();
+//	BUG();
 }
 #endif /* SMP */
 
=== arch/sparc/kernel/setup.c 1.27 vs edited ==--- 1.27/arch/sparc/kernel/setup.c	Sun Mar 14 16:45:25 2004
+++ edited/arch/sparc/kernel/setup.c	Sun Mar 21 22:04:28 2004
@@ -265,6 +265,8 @@
 	*cmdline_p = prom_getbootargs();
 	strcpy(saved_command_line, *cmdline_p);
 
+	prom_printf("command line copied\n");
+
 	/* Set sparc_cpu_model */
 	sparc_cpu_model = sun_unknown;
 	if(!strcmp(&cputypval,"sun4 ")) { sparc_cpu_model=sun4; }
@@ -306,6 +308,8 @@
 		break;
 	};
 
+	prom_printf("arch printed (%d)\n", sparc_cpu_model);
+
 #ifdef CONFIG_DUMMY_CONSOLE
 	conswitchp = &dummy_con;
 #elif defined(CONFIG_PROM_CONSOLE)
@@ -313,11 +317,16 @@
 #endif
 	boot_flags_init(*cmdline_p);
 
+	prom_printf("boot flags init\n");
+
 	idprom_init();
+	prom_printf("idprom done\n");
 	if (ARCH_SUN4C_SUN4)
 		sun4c_probe_vac();
 	load_mmu();
+	prom_printf("load mmu done\n");
 	(void) prom_probe_memory();
+	prom_printf("memory probe done\n");
 
 	phys_base = 0xffffffffUL;
 	highest_paddr = 0UL;
@@ -332,6 +341,8 @@
 			highest_paddr = top;
 	}
 
+	prom_printf("highest_paddr set\n");
+
 	if (!root_flags)
 		root_mountflags &= ~MS_RDONLY;
 	ROOT_DEV = old_decode_dev(root_dev);
@@ -343,16 +354,21 @@
 
 	prom_setsync(prom_sync_me);
 
+	prom_printf("sync set\n");
+
 	if((boot_flags&BOOTME_DEBUG) && (linux_dbvec!=0) && 
 	   ((*(short *)linux_dbvec) != -1)) {
 		printk("Booted under KADB. Syncing trap table.\n");
 		(*(linux_dbvec->teach_debugger))();
 	}
 
+	prom_printf("debug thing done\n");
+
 	init_mm.context = (unsigned long) NO_CONTEXT;
 	init_task.thread.kregs = &fake_swapper_regs;
 
 	paging_init();
+	prom_printf("paging_init done\n");
 }
 
 static int __init set_preferred_console(void)
=== arch/sparc/kernel/smp.c 1.16 vs edited ==--- 1.16/arch/sparc/kernel/smp.c	Tue Mar 16 02:14:48 2004
+++ edited/arch/sparc/kernel/smp.c	Sun Mar 21 22:04:29 2004
@@ -35,36 +35,19 @@
 #include <asm/tlbflush.h>
 #include <asm/cpudata.h>
 
-volatile int smp_processors_ready = 0;
-int smp_num_cpus = 1;
-int smp_threads_ready=0;
-volatile unsigned long cpu_callin_map[NR_CPUS] __initdata = {0,};
 unsigned char boot_cpu_id = 0;
 unsigned char boot_cpu_id4 = 0; /* boot_cpu_id << 2 */
-int smp_activated = 0;
-volatile int __cpu_number_map[NR_CPUS];
-volatile int __cpu_logical_map[NR_CPUS];
-cycles_t cacheflush_time = 0; /* XXX */
 
 cpumask_t cpu_online_map = CPU_MASK_NONE;
 cpumask_t phys_cpu_present_map = CPU_MASK_NONE;
-
-/* The only guaranteed locking primitive available on all Sparc
- * processors is 'ldstub [%reg + immediate], %dest_reg' which atomically
- * places the current byte at the effective address into dest_reg and
- * places 0xff there afterwards.  Pretty lame locking primitive
- * compared to the Alpha and the Intel no?  Most Sparcs have 'swap'
- * instruction which is much better...
- */
+cpumask_t smp_commenced_mask = CPU_MASK_NONE;
+cpumask_t cpu_callout_map = CPU_MASK_NONE;
 
 /* Used to make bitops atomic */
 unsigned char bitops_spinlock = 0;
 
 volatile unsigned long ipi_count;
 
-volatile int smp_process_available=0;
-volatile int smp_commenced = 0;
-
 void __init smp_store_cpu_info(int id)
 {
 	int cpu_node;
@@ -82,6 +65,17 @@
 
 void __init smp_cpus_done(unsigned int max_cpus)
 {
+	unsigned long bogosum = 0;
+	int i;
+
+	for (i = 0; i < NR_CPUS; i++) {
+		if (cpu_online(i))
+			bogosum += cpu_data(i).udelay_val;
+	}
+	printk("Total of %ld processors activated "
+	       "(%lu.%02lu BogoMIPS).\n",
+	       (long) num_online_cpus(), bogosum/(500000/HZ),
+	       (bogosum/(5000/HZ))%100);
 }
 
 void cpu_panic(void)
@@ -92,17 +86,6 @@
 
 struct linux_prom_registers smp_penguin_ctable __initdata = { 0 };
 
-void __init smp_boot_cpus(void)
-{
-	extern void smp4m_boot_cpus(void);
-	extern void smp4d_boot_cpus(void);
-	
-	if (sparc_cpu_model = sun4m)
-		smp4m_boot_cpus();
-	else
-		smp4d_boot_cpus();
-}
-
 void smp_send_reschedule(int cpu)
 {
 	/* See sparc64 */
@@ -237,8 +220,34 @@
 	return 0;
 }
 
-void __init smp_prepare_cpus(unsigned int maxcpus)
-{
+/* XXX Yet another unimplemented feature in sparc32 */
+cycles_t cacheflush_time;
+unsigned long cache_decay_ticks = 1000; /* XXX Complete and utter bullshit */
+
+void __init smp_prepare_cpus(unsigned int max_cpus)
+{
+	int instance, mid;
+
+	instance = 0;
+	while (!cpu_find_by_instance(instance, NULL, &mid)) {
+		if (mid < max_cpus)
+			cpu_set(mid, phys_cpu_present_map);
+		instance++;
+	}
+
+	if (num_possible_cpus() > max_cpus) {
+		instance = 0;
+		while (!cpu_find_by_instance(instance, NULL, &mid)) {
+			if (mid != boot_cpu_id) {
+				cpu_clear(mid, phys_cpu_present_map);
+				if (num_possible_cpus() <= max_cpus)
+					break;
+			}
+			instance++;
+		}
+	}
+
+	smp_store_cpu_info(boot_cpu_id);
 }
 
 void __devinit smp_prepare_boot_cpu(void)
@@ -250,7 +259,16 @@
 
 int __devinit __cpu_up(unsigned int cpu)
 {
-	panic("smp doesn't work\n");
+	int ret = smp_boot_one_cpu(cpu);
+
+	if (!ret) {
+		cpu_set(cpu, smp_commenced_mask);
+		while (!cpu_isset(cpu, cpu_online_map))
+			mb();
+		if (!cpu_isset(cpu, cpu_online_map)) /* XXX - unreached? */
+			return -ENODEV;
+	}
+	return ret;
 }
 
 void smp_bogo(struct seq_file *m)
=== arch/sparc/kernel/sparc_ksyms.c 1.28 vs edited ==--- 1.28/arch/sparc/kernel/sparc_ksyms.c	Tue Mar 16 02:14:48 2004
+++ edited/arch/sparc/kernel/sparc_ksyms.c	Tue Mar 23 19:34:44 2004
@@ -158,10 +158,6 @@
 #ifdef CONFIG_SMP
 /* IRQ implementation. */
 EXPORT_SYMBOL(synchronize_irq);
-
-/* Misc SMP information */
-EXPORT_SYMBOL(__cpu_number_map);
-EXPORT_SYMBOL(__cpu_logical_map);
 #endif
 
 EXPORT_SYMBOL(__udelay);
@@ -183,7 +179,7 @@
 #ifndef CONFIG_SMP
 EXPORT_SYMBOL_NOVERS(BTFIXUP_CALL(___xchg32));
 #else
-EXPORT_SYMBOL_NOVERS(BTFIXUP_CALL(__smp_processor_id));
+EXPORT_SYMBOL_NOVERS(BTFIXUP_CALL(__hard_smp_processor_id));
 #endif
 EXPORT_SYMBOL_NOVERS(BTFIXUP_CALL(enable_irq));
 EXPORT_SYMBOL_NOVERS(BTFIXUP_CALL(disable_irq));
=== arch/sparc/kernel/sun4d_irq.c 1.19 vs edited ==--- 1.19/arch/sparc/kernel/sun4d_irq.c	Sun Mar 14 16:43:39 2004
+++ edited/arch/sparc/kernel/sun4d_irq.c	Sun Mar 21 22:04:29 2004
@@ -106,7 +106,7 @@
 		for (x = 0; x < NR_CPUS; x++) {
 			if (cpu_online(x))
 				seq_printf(p, "%10u ",
-				       kstat_cpu(cpu_logical_map(x)).irqs[i]);
+				       kstat_cpu(x).irqs[i]);
 		}
 #endif
 		seq_printf(p, "%c %s",
@@ -440,15 +440,11 @@
 	}
 #else
 	struct sbus_bus *sbus;
-	int cpuid = cpu_logical_map(1);
-
-	if (cpuid = -1)
-		cpuid = cpu_logical_map(0);
 	for_each_sbus(sbus) {
-		sbus_tid[sbus->board] = cpuid;
-		set_sbi_tid(sbus->devid, cpuid << 3);
+		sbus_tid[sbus->board] = boot_cpu_id;
+		set_sbi_tid(sbus->devid, boot_cpu_id << 3);
 	}
-	printk("All sbus IRQs directed to CPU%d\n", cpuid);
+	printk("All sbus IRQs directed to CPU%d\n", boot_cpu_id);
 #endif
 }
 #endif
=== arch/sparc/kernel/sun4d_smp.c 1.16 vs edited ==--- 1.16/arch/sparc/kernel/sun4d_smp.c	Tue Mar 16 02:14:48 2004
+++ edited/arch/sparc/kernel/sun4d_smp.c	Sun Mar 21 22:04:30 2004
@@ -38,6 +38,7 @@
 
 #define IRQ_CROSS_CALL		15
 
+#if 0
 extern ctxd_t *srmmu_ctx_table_phys;
 
 extern void calibrate_delay(void);
@@ -100,7 +101,7 @@
 	 * the SMP initialization the master will be just allowed
 	 * to call the scheduler code.
 	 */
-	init_idle();
+	//init_idle();
 
 	/* Get our local ticker going. */
 	smp_setup_percpu_timer();
@@ -509,3 +510,9 @@
 		ccall_info.processors_out[i] = 1;
 	}
 }
+#else
+void smp4d_cross_call_irq(void) {}
+void smp4d_percpu_timer_interrupt(struct pt_regs *regs) {}
+void sun4d_init_smp(void) {}
+void smp4d_callin(void) {}
+#endif
=== arch/sparc/kernel/sun4m_smp.c 1.14 vs edited ==--- 1.14/arch/sparc/kernel/sun4m_smp.c	Tue Mar 16 02:14:48 2004
+++ edited/arch/sparc/kernel/sun4m_smp.c	Sun Mar 21 22:04:30 2004
@@ -36,21 +36,17 @@
 #define IRQ_CROSS_CALL		15
 
 extern ctxd_t *srmmu_ctx_table_phys;
-
 extern void calibrate_delay(void);
 
-extern volatile int smp_processors_ready;
-extern unsigned long cpu_present_map;
-extern int smp_num_cpus;
-extern int smp_threads_ready;
-extern volatile unsigned long cpu_callin_map[NR_CPUS];
 extern unsigned char boot_cpu_id;
-extern int smp_activated;
-extern volatile int __cpu_number_map[NR_CPUS];
-extern volatile int __cpu_logical_map[NR_CPUS];
+
+extern cpumask_t cpu_online_map;
+extern cpumask_t phys_cpu_present_map;
+extern cpumask_t smp_commenced_mask;
+extern cpumask_t cpu_callout_map;
+
 extern volatile unsigned long ipi_count;
-extern volatile int smp_process_available;
-extern volatile int smp_commenced;
+
 extern int __smp4m_processor_id(void);
 
 /*#define SMP_DEBUG*/
@@ -69,6 +65,8 @@
 	return val;
 }
 
+static volatile unsigned long callin_flag = 0;
+
 static void smp_setup_percpu_timer(void);
 extern void cpu_probe(void);
 
@@ -79,7 +77,7 @@
 	local_flush_cache_all();
 	local_flush_tlb_all();
 
-	set_irq_udt(boot_cpu_id);
+	set_irq_udt(boot_cpu_id); /* XXX - really needed? */
 
 	/* Get our local ticker going. */
 	smp_setup_percpu_timer();
@@ -90,22 +88,13 @@
 	local_flush_cache_all();
 	local_flush_tlb_all();
 
-	/*
-	 * Unblock the master CPU _only_ when the scheduler state
-	 * of all secondary CPUs will be up-to-date, so after
-	 * the SMP initialization the master will be just allowed
-	 * to call the scheduler code.
-	 */
-	init_idle();
-
 	/* Allow master to continue. */
-	swap((unsigned long *)&cpu_callin_map[cpuid], 1);
+	swap(&callin_flag, 1);
 
+	/* XXX - Why so much flushing?  Just defensive or are there bugs?? */
 	local_flush_cache_all();
 	local_flush_tlb_all();
 	
-	cpu_probe();
-
 	/* Fix idle thread fields. */
 	__asm__ __volatile__("ld [%0], %%g6\n\t"
 			     : : "r" (&current_set[cpuid])
@@ -115,8 +104,10 @@
 	atomic_inc(&init_mm.mm_count);
 	current->active_mm = &init_mm;
 
-	while(!smp_commenced)
-		barrier();
+	while (!cpu_isset(cpuid, smp_commenced_mask))
+		mb();
+
+	cpu_set(cpuid, cpu_online_map);
 
 	local_flush_cache_all();
 	local_flush_tlb_all();
@@ -125,126 +116,74 @@
 }
 
 extern int cpu_idle(void *unused);
-extern void init_IRQ(void);
 extern void cpu_panic(void);
-extern int start_secondary(void *unused);
 
-/*
- *	Cycle through the processors asking the PROM to start each one.
- */
- 
 extern struct linux_prom_registers smp_penguin_ctable;
 extern unsigned long trapbase_cpu1[];
 extern unsigned long trapbase_cpu2[];
 extern unsigned long trapbase_cpu3[];
 
-void __init smp4m_boot_cpus(void)
+static int __devinit smp4m_boot_one_cpu(unsigned int cpu)
 {
-	int cpucount = 0;
-	int i, mid;
+	extern unsigned long sun4m_cpu_startup;
+	unsigned long entry = (unsigned long)(&sun4m_cpu_startup);
 
-	printk("Entering SMP Mode...\n");
+	struct task_struct *p;
+	int timeout, ret;
 
-	local_irq_enable();
-	cpu_present_map = 0;
+	/* XXX set_irq_udt(boot_cpu_id); */
+	/* XXX smp_setup_percpu_timer(); */
 
-	for (i = 0; !cpu_find_by_instance(i, NULL, &mid); i++)
-		cpu_present_map |= (1<<mid);
+	/* Let's be sure we're not going to jump off into space. */
+	if (cpu > 3)
+		panic("sun4m only takes 4 penguins, so who's this #%d?", cpu);
+	/* See trampoline.S for details... */
+	entry += (cpu - 1) * 3 * 4;
 
-	for(i=0; i < NR_CPUS; i++) {
-		__cpu_number_map[i] = -1;
-		__cpu_logical_map[i] = -1;
-	}
+	kernel_thread(NULL, NULL, CLONE_IDLETASK);
 
-	__cpu_number_map[boot_cpu_id] = 0;
-	__cpu_logical_map[0] = boot_cpu_id;
-	current_thread_info()->cpu = boot_cpu_id;
+	p = prev_task(&init_task);
 
-	smp_store_cpu_info(boot_cpu_id);
-	set_irq_udt(boot_cpu_id);
-	smp_setup_percpu_timer();
+	init_idle(p, cpu);
+
+	current_set[cpu] = p->thread_info;	/* XXX - per_cpu?  nasty asm */
+
+	unhash_process(p);
+
+	/*
+	 * Initialize the contexts table
+	 * Since the call to prom_startcpu() trashes the structure,
+	 * we need to re-initialize it for each cpu
+	 */
+	smp_penguin_ctable.which_io = 0;
+	smp_penguin_ctable.phys_addr = (unsigned int) srmmu_ctx_table_phys;
+	smp_penguin_ctable.reg_size = 0;
+
+	/* whirrr, whirrr, whirrrrrrrrr... */
+	printk("Starting CPU %d at 0x%08lx\n", cpu, entry);
 	local_flush_cache_all();
-	if(cpu_find_by_instance(1, NULL, NULL))
-		return;  /* Not an MP box. */
-	for(i = 0; i < NR_CPUS; i++) {
-		if(i = boot_cpu_id)
-			continue;
+	prom_startcpu(cpu_data(cpu).prom_node, &smp_penguin_ctable,
+		      0, (char *)entry);
 
-		if(cpu_present_map & (1 << i)) {
-			extern unsigned long sun4m_cpu_startup;
-			unsigned long *entry = &sun4m_cpu_startup;
-			struct task_struct *p;
-			int timeout;
-
-			/* Cook up an idler for this guy. */
-			kernel_thread(start_secondary, NULL, CLONE_IDLETASK);
-
-			cpucount++;
-
-			p = prev_task(&init_task);
-
-			init_idle(p, i);
-
-			current_set[i] = p->thread_info;
-
-			unhash_process(p);
-
-			/* See trampoline.S for details... */
-			entry += ((i-1) * 3);
-
-			/*
-			 * Initialize the contexts table
-			 * Since the call to prom_startcpu() trashes the structure,
-			 * we need to re-initialize it for each cpu
-			 */
-			smp_penguin_ctable.which_io = 0;
-			smp_penguin_ctable.phys_addr = (unsigned int) srmmu_ctx_table_phys;
-			smp_penguin_ctable.reg_size = 0;
-
-			/* whirrr, whirrr, whirrrrrrrrr... */
-			printk("Starting CPU %d at %p\n", i, entry);
-			local_flush_cache_all();
-			prom_startcpu(cpu_data(i).prom_node,
-				      &smp_penguin_ctable, 0, (char *)entry);
-
-			/* wheee... it's going... */
-			for(timeout = 0; timeout < 10000; timeout++) {
-				if(cpu_callin_map[i])
-					break;
-				udelay(200);
-			}
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
-			cpu_present_map &= ~(1 << i);
-			__cpu_number_map[i] = -1;
-		}
+	/* wheee... it's going... */
+	for (timeout = 0; timeout < 20000; timeout++) {
+		if(callin_flag)
+			break;
+		udelay(100);
 	}
-	local_flush_cache_all();
-	if(cpucount = 0) {
-		printk("Error: only one Processor found.\n");
-		cpu_present_map = (1 << smp_processor_id());
+	if (callin_flag) {
+		ret = 0;
 	} else {
-		unsigned long bogosum = 0;
-		for(i = 0; i < NR_CPUS; i++) {
-			if(cpu_present_map & (1 << i))
-				bogosum += cpu_data(i).udelay_val;
-		}
-		printk("Total of %d Processors activated (%lu.%02lu BogoMIPS).\n",
-		       cpucount + 1,
-		       bogosum/(500000/HZ),
-		       (bogosum/(5000/HZ))%100);
-		smp_activated = 1;
-		smp_num_cpus = cpucount + 1;
+		printk("Processor %d is stuck.\n", cpu);
+		cpu_clear(cpu, cpu_callout_map);
+		ret = -ENODEV;
 	}
+	local_flush_cache_all();
+
+	return ret;
+}
 
+#if 0
 	/* Free unneeded trap tables */
 	if (!(cpu_present_map & (1 << 1))) {
 		ClearPageReserved(virt_to_page(trapbase_cpu1));
@@ -267,10 +206,7 @@
 		totalram_pages++;
 		num_physpages++;
 	}
-
-	/* Ok, they are spinning and ready to go. */
-	smp_processors_ready = 1;
-}
+#endif
 
 /* At each hardware IRQ, we get this called to forward IRQ reception
  * to the next processor.  The caller must disable the IRQ level being
@@ -282,6 +218,7 @@
 {
 }
 
+#if 0
 /* Cross calls, in order to work efficiently and atomically do all
  * the message passing work themselves, only stopcpu and reschedule
  * messages come through here.
@@ -323,7 +260,7 @@
 	printk("Yeeee, trying to send SMP msg(%d) on cpu %d\n", msg, me);
 	panic("Bogon SMP message pass.");
 }
-
+#endif
 static struct smp_funcall {
 	smpfunc_t func;
 	unsigned long arg1;
@@ -331,77 +268,63 @@
 	unsigned long arg3;
 	unsigned long arg4;
 	unsigned long arg5;
-	unsigned long processors_in[NR_CPUS];  /* Set when ipi entered. */
-	unsigned long processors_out[NR_CPUS]; /* Set when ipi exited. */
+	cpumask_t processors_in;	/* Set when ipi entered. */
+	cpumask_t processors_out;	/* Set when ipi exited. */
 } ccall_info;
 
 static spinlock_t cross_call_lock = SPIN_LOCK_UNLOCKED;
 
 /* Cross calls must be serialized, at least currently. */
+/* XXX We completely disregard wait, see sparc64 and asm/smp.h.  FIXME */
 void smp4m_cross_call(smpfunc_t func, unsigned long arg1, unsigned long arg2,
 		    unsigned long arg3, unsigned long arg4, unsigned long arg5)
 {
-	if(smp_processors_ready) {
-		register int ncpus = smp_num_cpus;
-		unsigned long flags;
-
-		spin_lock_irqsave(&cross_call_lock, flags);
-
-		/* Init function glue. */
-		ccall_info.func = func;
-		ccall_info.arg1 = arg1;
-		ccall_info.arg2 = arg2;
-		ccall_info.arg3 = arg3;
-		ccall_info.arg4 = arg4;
-		ccall_info.arg5 = arg5;
-
-		/* Init receive/complete mapping, plus fire the IPI's off. */
-		{
-			register unsigned long mask;
-			register int i;
-
-			mask = (cpu_present_map & ~(1 << smp_processor_id()));
-			for(i = 0; i < ncpus; i++) {
-				if(mask & (1 << i)) {
-					ccall_info.processors_in[i] = 0;
-					ccall_info.processors_out[i] = 0;
-					set_cpu_int(i, IRQ_CROSS_CALL);
-				} else {
-					ccall_info.processors_in[i] = 1;
-					ccall_info.processors_out[i] = 1;
-				}
-			}
+	int i;
+	unsigned long flags;
+	cpumask_t mask = cpu_online_map;
+
+	cpu_clear(smp_processor_id(), mask);
+
+	spin_lock_irqsave(&cross_call_lock, flags);
+
+	/* Init function glue. */
+	ccall_info.func = func;
+	ccall_info.arg1 = arg1;
+	ccall_info.arg2 = arg2;
+	ccall_info.arg3 = arg3;
+	ccall_info.arg4 = arg4;
+	ccall_info.arg5 = arg5;
+
+	/* Init receive/complete mapping, plus fire the IPI's off. */
+	for(i = 0; i < NR_CPUS; i++) {
+		if(cpu_isset(i, mask)) {
+			cpu_set(i, ccall_info.processors_in);
+			cpu_set(i, ccall_info.processors_out);
+			set_cpu_int(i, IRQ_CROSS_CALL);
+		} else {
+			cpu_clear(i, ccall_info.processors_in);
+			cpu_clear(i, ccall_info.processors_out);
 		}
+	}
 
-		{
-			register int i;
+	while(!cpus_empty(ccall_info.processors_in))
+		barrier();
 
-			i = 0;
-			do {
-				while(!ccall_info.processors_in[i])
-					barrier();
-			} while(++i < ncpus);
-
-			i = 0;
-			do {
-				while(!ccall_info.processors_out[i])
-					barrier();
-			} while(++i < ncpus);
-		}
+	while(!cpus_empty(ccall_info.processors_out))
+		barrier();
 
-		spin_unlock_irqrestore(&cross_call_lock, flags);
-	}
+	spin_unlock_irqrestore(&cross_call_lock, flags);
 }
 
 /* Running cross calls. */
 void smp4m_cross_call_irq(void)
 {
-	int i = smp_processor_id();
+	int cpuid = smp_processor_id();
 
-	ccall_info.processors_in[i] = 1;
+	cpu_clear(cpuid, ccall_info.processors_in);
 	ccall_info.func(ccall_info.arg1, ccall_info.arg2, ccall_info.arg3,
 			ccall_info.arg4, ccall_info.arg5);
-	ccall_info.processors_out[i] = 1;
+	cpu_clear(cpuid, ccall_info.processors_out);
 }
 
 extern void sparc_do_profile(unsigned long pc, unsigned long o7);
@@ -461,9 +384,10 @@
 
 void __init sun4m_init_smp(void)
 {
-	BTFIXUPSET_BLACKBOX(smp_processor_id, smp4m_blackbox_id);
+	BTFIXUPSET_BLACKBOX(hard_smp_processor_id, smp4m_blackbox_id);
 	BTFIXUPSET_BLACKBOX(load_current, smp4m_blackbox_current);
 	BTFIXUPSET_CALL(smp_cross_call, smp4m_cross_call, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(smp_message_pass, smp4m_message_pass, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(__smp_processor_id, __smp4m_processor_id, BTFIXUPCALL_NORM);
+//	BTFIXUPSET_CALL(smp_message_pass, smp4m_message_pass, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(__hard_smp_processor_id, __smp4m_processor_id, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(smp_boot_one_cpu, smp4m_boot_one_cpu, BTFIXUPCALL_NORM);
 }
=== arch/sparc/prom/printf.c 1.3 vs edited ==--- 1.3/arch/sparc/prom/printf.c	Wed Feb 18 19:42:41 2004
+++ edited/arch/sparc/prom/printf.c	Tue Mar 23 19:33:34 2004
@@ -32,8 +32,12 @@
 	}
 }
 
+#if 0
 void
-prom_printf(char *fmt, ...)
+#else
+int
+#endif
+prom_printf(const char *fmt, ...)
 {
 	va_list args;
 	int i;
@@ -43,4 +47,7 @@
 	va_end(args);
 
 	prom_write(ppbuf, i);
+#if 1
+	return i;
+#endif
 }
=== include/asm-sparc/asmmacro.h 1.4 vs edited ==--- 1.4/include/asm-sparc/asmmacro.h	Tue Mar 16 02:14:48 2004
+++ edited/include/asm-sparc/asmmacro.h	Sun Mar 21 22:04:30 2004
@@ -20,14 +20,9 @@
 
 /* Blackbox */
 #define GET_PROCESSOR_ID(reg) \
-	sethi	%hi(___b_smp_processor_id), %reg; \
+	sethi	%hi(___b_hard_smp_processor_id), %reg; \
 	sethi	%hi(boot_cpu_id), %reg; \
 	ldub	[%reg + %lo(boot_cpu_id)], %reg;
-
-#define GET_PROCESSOR_MID(reg) \
-	rd	%tbr, %reg; \
-	srl	%reg, 12, %reg; \
-	and	%reg, 3, %reg;
 
 /* All trap entry points _must_ begin with this macro or else you
  * lose.  It makes sure the kernel has a proper window so that
=== include/asm-sparc/oplib.h 1.4 vs edited ==--- 1.4/include/asm-sparc/oplib.h	Sun Mar 14 16:43:40 2004
+++ edited/include/asm-sparc/oplib.h	Tue Mar 23 19:33:21 2004
@@ -154,7 +154,12 @@
 extern void prom_putchar(char character);
 
 /* Prom's internal routines, don't use in kernel/boot code. */
+#if 0
 extern void prom_printf(char *fmt, ...);
+#else
+extern int prom_printf(const char *fmt, ...);
+#endif
+
 extern void prom_write(const char *buf, unsigned int len);
 
 /* Query for input device type */
=== include/asm-sparc/smp.h 1.11 vs edited ==--- 1.11/include/asm-sparc/smp.h	Tue Mar 16 02:14:49 2004
+++ edited/include/asm-sparc/smp.h	Sun Mar 21 22:04:30 2004
@@ -51,12 +51,14 @@
 void smp_bogo(struct seq_file *);
 void smp_info(struct seq_file *);
 
+BTFIXUPDEF_CALL(int, smp_boot_one_cpu, unsigned int)
 BTFIXUPDEF_CALL(void, smp_cross_call, smpfunc_t, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)
 BTFIXUPDEF_CALL(void, smp_message_pass, int, int, unsigned long, int)
-BTFIXUPDEF_CALL(int, __smp_processor_id, void)
-BTFIXUPDEF_BLACKBOX(smp_processor_id)
+BTFIXUPDEF_CALL(int, __hard_smp_processor_id, void)
+BTFIXUPDEF_BLACKBOX(hard_smp_processor_id)
 BTFIXUPDEF_BLACKBOX(load_current)
 
+#define smp_boot_one_cpu(__cpu)	BTFIXUP_CALL(smp_boot_one_cpu)(__cpu)
 #define smp_cross_call(func,arg1,arg2,arg3,arg4,arg5) BTFIXUP_CALL(smp_cross_call)(func,arg1,arg2,arg3,arg4,arg5)
 #define smp_message_pass(target,msg,data,wait) BTFIXUP_CALL(smp_message_pass)(target,msg,data,wait)
 
@@ -129,7 +131,7 @@
 	   			     "=&r" (cpuid));
 	   See btfixup.h and btfixupprep.c to understand how a blackbox works.
 	 */
-	__asm__ __volatile__("sethi %%hi(___b_smp_processor_id), %0\n\t"
+	__asm__ __volatile__("sethi %%hi(___b_hard_smp_processor_id), %0\n\t"
 			     "sethi %%hi(boot_cpu_id), %0\n\t"
 			     "ldub [%0 + %%lo(boot_cpu_id)], %0\n\t" :
 			     "=&r" (cpuid));
@@ -141,7 +143,7 @@
 	int cpuid;
 	
 	__asm__ __volatile__("mov %%o7, %%g1\n\t"
-			     "call ___f___smp_processor_id\n\t"
+			     "call ___f___hard_smp_processor_id\n\t"
 			     " nop\n\t"
 			     "mov %%g2, %0\n\t" : "=r"(cpuid) : : "g1", "g2");
 	return cpuid;
=== include/linux/kernel.h 1.47 vs edited ==--- 1.47/include/linux/kernel.h	Wed Mar 10 08:45:49 2004
+++ edited/include/linux/kernel.h	Tue Mar 23 19:33:06 2004
@@ -87,8 +87,13 @@
 extern int kernel_text_address(unsigned long addr);
 extern int session_of_pgrp(int pgrp);
 
+#if 0
 asmlinkage int printk(const char * fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
+#else
+extern int prom_printf(const char *fmt, ...);
+#define printk prom_printf
+#endif
 
 unsigned long int_sqrt(unsigned long);
 
=== init/main.c 1.127 vs edited ==--- 1.127/init/main.c	Tue Mar 16 02:10:35 2004
+++ edited/init/main.c	Tue Mar 23 19:48:24 2004
@@ -408,10 +408,15 @@
  * Interrupts are still disabled. Do necessary setups, then
  * enable them
  */
+ 	prom_printf("start_kernel\n");
 	lock_kernel();
+	prom_printf("kernel locked\n");
 	printk(linux_banner);
+	prom_printf("banner printed\n");
 	setup_arch(&command_line);
+	prom_printf("setup_arch done\n");
 	setup_per_cpu_areas();
+	prom_printf("percpu areas setup\n");
 
 	/*
 	 * Mark the boot cpu "online" so that it can call console drivers in
@@ -419,20 +424,34 @@
 	 */
 	smp_prepare_boot_cpu();
 
+	prom_printf("boot cpu set up\n");
+
 	build_all_zonelists();
+
+	prom_printf("zonelists built\n");
 	page_alloc_init();
+	prom_printf("page_alloc init done\n");
 	printk("Kernel command line: %s\n", saved_command_line);
 	parse_args("Booting kernel", command_line, __start___param,
 		   __stop___param - __start___param,
 		   &unknown_bootoption);
+	prom_printf("sorting extable...\n");
 	sort_main_extable();
+	prom_printf("going to do trap_init\n");
 	trap_init();
+	prom_printf("trap_init done\n");
 	rcu_init();
+	prom_printf("rcu_init done\n");
 	init_IRQ();
+	prom_printf("init_IRQ done\n");
 	pidhash_init();
+	prom_printf("pidhash init complete\n");
 	sched_init();
+	prom_printf("sched_init done\n");
 	softirq_init();
+	prom_printf("softirq init done\n");
 	time_init();
+	prom_printf("time init done\n");
 
 	/*
 	 * HACK ALERT! This is early. We're enabling the console before
@@ -440,6 +459,7 @@
 	 * this. But we do want output early, in case something goes wrong.
 	 */
 	console_init();
+	prom_printf("console init done\n");
 	if (panic_later)
 		panic(panic_later, panic_param);
 	profile_init();
=== kernel/printk.c 1.35 vs edited ==--- 1.35/kernel/printk.c	Mon Mar  8 16:57:46 2004
+++ edited/kernel/printk.c	Tue Mar 23 19:28:52 2004
@@ -467,6 +467,7 @@
 		logged_chars++;
 }
 
+#if 0
 /*
  * This is printk.  It can be called from any context.  We want it to work.
  * 
@@ -553,6 +554,7 @@
 	return printed_len;
 }
 EXPORT_SYMBOL(printk);
+#endif
 
 /**
  * acquire_console_sem - lock the console system for exclusive use.


-- 
Keith M Wesolowski
