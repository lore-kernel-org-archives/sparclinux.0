From: Bob Breuer <breuerr@mc.net>
Date: Sun, 13 Feb 2005 07:51:39 +0000
Subject: sparc32 SMP for 2.6
Message-Id: <420F070B.8010000@mc.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------050102010209020004070703"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------050102010209020004070703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I've been poking at the sparc32 SMP code and I have it to the point
where it will run a minimal userland.  It is still far from being
stable though.

For reference, I started with the SMP patch [0] that wli sent to
the list last July.  To go along with the attached SMP patch, it
needs the spinlock fix [1] from Art Haas, and the attached
DEBUGSPINLOCK patch from Tom Callaway.

Here's a list of problems I have seen with it so far:
- the scsi driver must be compiled in or it has problems.
- when I compiled with gcc 3.3.4, it drops back to the prom with
     a level 15 interrupt.
- from a serial console, init hangs
- /proc/interrupts shows 0 interrupts for the 2nd cpu
- sun4d still needs fixing

Testing with gcc 3.2.2 and 2 150 MHz HyperSPARCs, if I compile
in scsi and leave out all of the networking, I am able to pass
"init=/bin/bash" and get a shell everytime.

I am sure there are still areas of bitrot and neglect that remain,
so if anyone has any ideas, feel free to share them.

Bob

[0] http://marc.theaimsgroup.com/?l=linux-sparc&m=109105275025491
[1] http://marc.theaimsgroup.com/?l=linux-sparc&m=110806229008323

--------------050102010209020004070703
Content-Type: text/plain;
 name="linux-2.6.9-sparc-SMP-DEBUGSPINLOCK.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.9-sparc-SMP-DEBUGSPINLOCK.patch"

--- linux-2.6.9/arch/sparc/kernel/sparc_ksyms.c.BAD	2004-12-21 23:40:02.347602755 -0500
+++ linux-2.6.9/arch/sparc/kernel/sparc_ksyms.c	2004-12-22 00:13:53.443829195 -0500
@@ -118,11 +118,12 @@ EXPORT_SYMBOL(kernel_thread);
 #ifdef CONFIG_SMP
 EXPORT_SYMBOL(_do_spin_lock);
 EXPORT_SYMBOL(_do_spin_unlock);
-EXPORT_SYMBOL(_spin_trylock);
+EXPORT_SYMBOL(_do_spin_trylock);
 EXPORT_SYMBOL(_do_read_lock);
 EXPORT_SYMBOL(_do_read_unlock);
 EXPORT_SYMBOL(_do_write_lock);
 EXPORT_SYMBOL(_do_write_unlock);
+EXPORT_SYMBOL(_do_write_trylock);
 #endif
 #else
 // XXX find what uses (or used) these.
--- linux-2.6.9/arch/sparc/lib/debuglocks.c.BAD	2004-12-21 23:38:17.182590267 -0500
+++ linux-2.6.9/arch/sparc/lib/debuglocks.c	2004-12-22 00:10:27.010211875 -0500
@@ -82,7 +82,7 @@ again:
 	lock->owner_pc = (cpu & 3) | (caller & ~3);
 }
 
-int _spin_trylock(spinlock_t *lock)
+int _do_spin_trylock(spinlock_t *lock)
 {
 	unsigned long val;
 	unsigned long caller;
@@ -199,4 +199,27 @@ void _do_write_unlock(rwlock_t *rw)
 	rw->lock = 0;
 }
 
+int _do_write_trylock (rwlock_t *rw, char *str)
+{
+	unsigned long caller;
+	unsigned long val;
+	int cpu = smp_processor_id();
+
+	STORE_CALLER(caller);
+
+	__asm__ __volatile__("ldstub [%1 + 3], %0" : "=r" (val) : "r" (&(rw->lock)));
+	if (val) {
+		barrier();
+		return 0;
+	}
+	if (rw->lock & ~0xff) {
+		*(((unsigned char *)&rw->lock)+3) = 0;
+		barrier();
+		return 0;
+	}
+	barrier();
+	rw->owner_pc = (cpu & 3) | (caller & ~3);
+	return 1;
+}
+
 #endif /* SMP */
--- linux-2.6.9/arch/sparc/Kconfig.BAD	2004-12-21 22:34:04.993212067 -0500
+++ linux-2.6.9/arch/sparc/Kconfig	2004-12-21 22:34:08.358700435 -0500
@@ -83,7 +83,6 @@ config HW_CONSOLE
 
 config SMP
 	bool "Symmetric multi-processing support (does not work on sun4/sun4c)"
-	depends on BROKEN
 	---help---
 	  This enables support for systems with more than one CPU. If you have
 	  a system with only one CPU, say N. If you have a system with more
--- linux-2.6.9/include/asm-sparc/spinlock.h.BAD	2004-12-21 23:21:12.779323235 -0500
+++ linux-2.6.9/include/asm-sparc/spinlock.h	2004-12-22 00:12:52.872037507 -0500
@@ -25,10 +25,10 @@ typedef struct _spinlock_debug spinlock_
 #define spin_unlock_wait(lp)	do { barrier(); } while(*(volatile unsigned char *)(&(lp)->lock))
 
 extern void _do_spin_lock(spinlock_t *lock, char *str);
-extern int _spin_trylock(spinlock_t *lock);
+extern int _do_spin_trylock(spinlock_t *lock);
 extern void _do_spin_unlock(spinlock_t *lock);
 
-#define _raw_spin_trylock(lp)	_spin_trylock(lp)
+#define _raw_spin_trylock(lp)	_do_spin_trylock(lp)
 #define _raw_spin_lock(lock)	_do_spin_lock(lock, "spin_lock")
 #define _raw_spin_unlock(lock)	_do_spin_unlock(lock)
 
@@ -48,6 +48,7 @@ extern void _do_read_lock(rwlock_t *rw, 
 extern void _do_read_unlock(rwlock_t *rw, char *str);
 extern void _do_write_lock(rwlock_t *rw, char *str);
 extern void _do_write_unlock(rwlock_t *rw);
+extern int _do_write_trylock(rwlock_t *rw, char *str);
 
 #define _raw_read_lock(lock)	\
 do {	unsigned long flags; \
@@ -77,6 +78,15 @@ do {	unsigned long flags; \
 	local_irq_restore(flags); \
 } while(0)
 
+#define _raw_write_trylock(lock) \
+({	unsigned long flags; \
+	int val; \
+	local_irq_save(flags); \
+	val = _do_write_trylock(lock, "write_trylock"); \
+	local_irq_restore(flags); \
+	val; \
+})
+
 #else /* !CONFIG_DEBUG_SPINLOCK */
 
 typedef unsigned char spinlock_t;

--------------050102010209020004070703
Content-Type: text/plain;
 name="linux-2.6.11-rc3-sparc32-smp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.11-rc3-sparc32-smp.patch"

--- linux-2.6.11-rc3-clean/include/asm-sparc/smp.h	2004-10-18 16:53:43.000000000 -0500
+++ linux-2.6.11-rc3/include/asm-sparc/smp.h	2005-02-12 12:12:19.000000000 -0600
@@ -81,16 +81,9 @@
 	return 0;
 }
 
-extern __volatile__ int __cpu_number_map[NR_CPUS];
-extern __volatile__ int __cpu_logical_map[NR_CPUS];
-
 extern __inline__ int cpu_logical_map(int cpu)
 {
-	return __cpu_logical_map[cpu];
-}
-extern __inline__ int cpu_number_map(int cpu)
-{
-	return __cpu_number_map[cpu];
+	return cpu;
 }
 
 extern __inline__ int hard_smp4m_processor_id(void)
--- linux-2.6.11-rc3-clean/include/asm-sparc/spinlock.h	2005-02-06 20:32:54.000000000 -0600
+++ linux-2.6.11-rc3/include/asm-sparc/spinlock.h	2005-02-12 23:06:56.000000000 -0600
@@ -101,7 +101,7 @@
 	barrier(); \
 } while(*((volatile unsigned char *)lock))
 
-extern __inline__ void _raw_spin_lock(spinlock_t *lock)
+static inline void _raw_spin_lock(spinlock_t *lock)
 {
 	__asm__ __volatile__(
 	"\n1:\n\t"
@@ -121,7 +121,7 @@
 	: "g2", "memory", "cc");
 }
 
-extern __inline__ int _raw_spin_trylock(spinlock_t *lock)
+static inline int _raw_spin_trylock(spinlock_t *lock)
 {
 	unsigned int result;
 	__asm__ __volatile__("ldstub [%1], %0"
@@ -131,7 +131,7 @@
 	return (result == 0);
 }
 
-extern __inline__ void _raw_spin_unlock(spinlock_t *lock)
+static inline void _raw_spin_unlock(spinlock_t *lock)
 {
 	__asm__ __volatile__("stb %%g0, [%0]" : : "r" (lock) : "memory");
 }
@@ -174,7 +174,7 @@
  *
  * Unfortunately this scheme limits us to ~16,000,000 cpus.
  */
-extern __inline__ void _read_lock(rwlock_t *rw)
+static inline void __read_lock(rwlock_t *rw)
 {
 	register rwlock_t *lp asm("g1");
 	lp = rw;
@@ -190,11 +190,11 @@
 #define _raw_read_lock(lock) \
 do {	unsigned long flags; \
 	local_irq_save(flags); \
-	_read_lock(lock); \
+	__read_lock(lock); \
 	local_irq_restore(flags); \
 } while(0)
 
-extern __inline__ void _read_unlock(rwlock_t *rw)
+static inline void __read_unlock(rwlock_t *rw)
 {
 	register rwlock_t *lp asm("g1");
 	lp = rw;
@@ -210,11 +210,11 @@
 #define _raw_read_unlock(lock) \
 do {	unsigned long flags; \
 	local_irq_save(flags); \
-	_read_unlock(lock); \
+	__read_unlock(lock); \
 	local_irq_restore(flags); \
 } while(0)
 
-extern __inline__ void _raw_write_lock(rwlock_t *rw)
+static inline void _raw_write_lock(rwlock_t *rw)
 {
 	register rwlock_t *lp asm("g1");
 	lp = rw;
@@ -227,11 +227,33 @@
 	: "g2", "g4", "memory", "cc");
 }
 
+static inline int _raw_write_trylock(rwlock_t *rw)
+{
+	int val;
+	__asm__ __volatile__(
+	"ldstub	[%1 + 3], %0\n\t"
+	"orcc	%0, 0x0, %%g0\n\t"
+	"bne	1f\n\t"
+	" nop\n\t"
+	"ld	[%1], %0\n\t"
+	"andncc	%0, 0xff, %0\n\t"
+	"bne,a	1f\n\t"
+	" stb	%%g0, [%1 + 3]\n"
+	"1:"
+	: "=&r" (val)
+	: "r" (rw)
+	: "memory", "cc");
+
+	/* on success, val is zero and return true */
+	return (val == 0);
+}
+
 #define _raw_write_unlock(rw)	do { (rw)->lock = 0; } while(0)
 
 #endif /* CONFIG_DEBUG_SPINLOCK */
 
 #define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
+#define _raw_read_trylock(lock) generic_raw_read_trylock(lock)
 
 #endif /* !(__ASSEMBLY__) */
 
Only in linux-2.6.11-rc3/arch/sparc/boot: btfix.S
Only in linux-2.6.11-rc3/arch/sparc/boot: image
diff -X dontdiff -urp linux-2.6.11-rc3-clean/arch/sparc/kernel/irq.c linux-2.6.11-rc3/arch/sparc/kernel/irq.c
--- linux-2.6.11-rc3-clean/arch/sparc/kernel/irq.c	2005-02-06 20:30:54.000000000 -0600
+++ linux-2.6.11-rc3/arch/sparc/kernel/irq.c	2005-02-12 12:16:35.000000000 -0600
@@ -21,6 +21,7 @@
 #include <linux/signal.h>
 #include <linux/sched.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/slab.h>
 #include <linux/random.h>
 #include <linux/init.h>
@@ -154,8 +155,11 @@ void (*sparc_init_timers)(irqreturn_t (*
 struct irqaction static_irqaction[MAX_STATIC_ALLOC];
 int static_irq_count;
 
-struct irqaction *irq_action[NR_IRQS] = {
-	[0 ... (NR_IRQS-1)] = NULL
+struct {
+	struct irqaction *action;
+	int flags;
+} sparc_irq[NR_IRQS] = {
+	[0 ... (NR_IRQS-1)] = { NULL, 0 }
 };
 
 /* Used to protect the IRQ action lists */
@@ -177,7 +181,7 @@ int show_interrupts(struct seq_file *p, 
 	}
 	spin_lock_irqsave(&irq_action_lock, flags);
 	if (i < NR_IRQS) {
-	        action = *(i + irq_action);
+	        action = sparc_irq[i].action;
 		if (!action) 
 			goto out_unlock;
 		seq_printf(p, "%3d: ", i);
@@ -187,7 +191,7 @@ int show_interrupts(struct seq_file *p, 
 		for (j = 0; j < NR_CPUS; j++) {
 			if (cpu_online(j))
 				seq_printf(p, "%10u ",
-				    kstat_cpu(cpu_logical_map(j)).irqs[i]);
+				    kstat_cpu(j).irqs[i]);
 		}
 #endif
 		seq_printf(p, " %c %s",
@@ -226,7 +230,7 @@ void free_irq(unsigned int irq, void *de
 
 	spin_lock_irqsave(&irq_action_lock, flags);
 
-	action = *(cpu_irq + irq_action);
+	action = sparc_irq[cpu_irq].action;
 
 	if (!action->handler) {
 		printk("Trying to free free IRQ%d\n",irq);
@@ -259,7 +263,7 @@ void free_irq(unsigned int irq, void *de
 	if (action && tmp)
 		tmp->next = action->next;
 	else
-		*(cpu_irq + irq_action) = action->next;
+		sparc_irq[cpu_irq].action = action->next;
 
 	spin_unlock_irqrestore(&irq_action_lock, flags);
 
@@ -269,7 +273,7 @@ void free_irq(unsigned int irq, void *de
 
 	kfree(action);
 
-	if (!(*(cpu_irq + irq_action)))
+	if (!sparc_irq[cpu_irq].action)
 		disable_irq(irq);
 
 out_unlock:
@@ -288,8 +292,8 @@ EXPORT_SYMBOL(free_irq);
 #ifdef CONFIG_SMP
 void synchronize_irq(unsigned int irq)
 {
-	printk("synchronize_irq says: implement me!\n");
-	BUG();
+	while (sparc_irq[irq].flags & IRQ_INPROGRESS)
+		cpu_relax();
 }
 #endif /* SMP */
 
@@ -300,7 +304,7 @@ void unexpected_irq(int irq, void *dev_i
 	unsigned int cpu_irq;
 	
 	cpu_irq = irq & (NR_IRQS - 1);
-	action = *(cpu_irq + irq_action);
+	action = sparc_irq[cpu_irq].action;
 
         printk("IO device interrupt, irq = %d\n", irq);
         printk("PC = %08lx NPC = %08lx FP=%08lx\n", regs->pc, 
@@ -326,12 +330,13 @@ void handler_irq(int irq, struct pt_regs
 
 	irq_enter();
 	disable_pil_irq(irq);
+	sparc_irq[irq].flags |= IRQ_INPROGRESS;
 #ifdef CONFIG_SMP
 	/* Only rotate on lower priority IRQ's (scsi, ethernet, etc.). */
 	if(irq < 10)
 		smp4m_irq_rotate(cpu);
 #endif
-	action = *(irq + irq_action);
+	action = sparc_irq[irq].action;
 	kstat_cpu(cpu).irqs[irq]++;
 	do {
 		if (!action || !action->handler)
@@ -339,6 +344,7 @@ void handler_irq(int irq, struct pt_regs
 		action->handler(irq, action->dev_id, regs);
 		action = action->next;
 	} while (action);
+	sparc_irq[irq].flags &= ~IRQ_INPROGRESS;
 	enable_pil_irq(irq);
 	irq_exit();
 }
@@ -390,7 +396,7 @@ int request_fast_irq(unsigned int irq,
 
 	spin_lock_irqsave(&irq_action_lock, flags);
 
-	action = *(cpu_irq + irq_action);
+	action = sparc_irq[cpu_irq].action;
 	if(action) {
 		if(action->flags & SA_SHIRQ)
 			panic("Trying to register fast irq when already shared.\n");
@@ -453,7 +459,7 @@ int request_fast_irq(unsigned int irq,
 	action->dev_id = NULL;
 	action->next = NULL;
 
-	*(cpu_irq + irq_action) = action;
+	sparc_irq[cpu_irq].action = action;
 
 	enable_irq(irq);
 
@@ -491,7 +497,7 @@ int request_irq(unsigned int irq,
 	    
 	spin_lock_irqsave(&irq_action_lock, flags);
 
-	action = *(cpu_irq + irq_action);
+	action = sparc_irq[cpu_irq].action;
 	if (action) {
 		if ((action->flags & SA_SHIRQ) && (irqflags & SA_SHIRQ)) {
 			for (tmp = action; tmp->next; tmp = tmp->next);
@@ -536,7 +542,7 @@ int request_irq(unsigned int irq,
 	if (tmp)
 		tmp->next = action;
 	else
-		*(cpu_irq + irq_action) = action;
+		sparc_irq[cpu_irq].action = action;
 
 	enable_irq(irq);
 
diff -X dontdiff -urp linux-2.6.11-rc3-clean/arch/sparc/kernel/smp.c linux-2.6.11-rc3/arch/sparc/kernel/smp.c
--- linux-2.6.11-rc3-clean/arch/sparc/kernel/smp.c	2005-02-06 20:30:54.000000000 -0600
+++ linux-2.6.11-rc3/arch/sparc/kernel/smp.c	2005-02-12 23:17:07.000000000 -0600
@@ -48,6 +48,7 @@ unsigned long cache_decay_ticks = 100;
 
 cpumask_t cpu_online_map = CPU_MASK_NONE;
 cpumask_t phys_cpu_present_map = CPU_MASK_NONE;
+cpumask_t smp_commenced_mask = CPU_MASK_NONE;
 
 /* The only guaranteed locking primitive available on all Sparc
  * processors is 'ldstub [%reg + immediate], %dest_reg' which atomically
@@ -60,11 +61,6 @@ cpumask_t phys_cpu_present_map = CPU_MAS
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
@@ -82,6 +78,20 @@ void __init smp_store_cpu_info(int id)
 
 void __init smp_cpus_done(unsigned int max_cpus)
 {
+	extern void smp4m_smp_done(void);
+	unsigned long bogosum = 0;
+	int i;
+
+	for_each_online_cpu(i)
+		bogosum += cpu_data(i).udelay_val;
+
+	printk("Total of %d processors activated (%lu.%02lu BogoMIPS).\n",
+		num_online_cpus(),
+		bogosum/(500000/HZ),
+		(bogosum/(5000/HZ))%100);
+
+	BUG_ON(sparc_cpu_model != sun4m);
+	smp4m_smp_done();
 }
 
 void cpu_panic(void)
@@ -92,17 +102,6 @@ void cpu_panic(void)
 
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
@@ -256,20 +255,65 @@ int setup_profiling_timer(unsigned int m
 	return 0;
 }
 
-void __init smp_prepare_cpus(unsigned int maxcpus)
+void __init smp_prepare_cpus(unsigned int max_cpus)
 {
+	extern void smp4m_boot_cpus();
+	int i, mid, ncpus, extra;
+
+	BUG_ON(sparc_cpu_model != sun4m);
+	printk("Entering SMP Mode...\n");
+
+	local_irq_enable(); // is this needed ?
+
+	ncpus = 1;
+	extra = 0;
+	for (i=0; !cpu_find_by_instance(i, NULL, &mid); i++) {
+		if (mid == boot_cpu_id)
+			continue;
+		if (mid < NR_CPUS && ncpus++ < max_cpus)
+			cpu_set(mid, phys_cpu_present_map);
+		else
+			extra++;
+	}
+	if (max_cpus >= NR_CPUS && extra)
+		printk("Warning: NR_CPUS is too low to start all cpus\n");
+
+//	current_thread_info()->cpu = boot_cpu_id;
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
+	else if (cpuid != 0)
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
+	BUG_ON(sparc_cpu_model != sun4m);
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
diff -X dontdiff -urp linux-2.6.11-rc3-clean/arch/sparc/kernel/sparc_ksyms.c linux-2.6.11-rc3/arch/sparc/kernel/sparc_ksyms.c
--- linux-2.6.11-rc3-clean/arch/sparc/kernel/sparc_ksyms.c	2005-02-06 20:30:54.000000000 -0600
+++ linux-2.6.11-rc3/arch/sparc/kernel/sparc_ksyms.c	2005-02-12 22:52:05.000000000 -0600
@@ -90,6 +90,9 @@ extern void ___set_bit(void);
 extern void ___clear_bit(void);
 extern void ___change_bit(void);
 
+/* Per-CPU information table */
+EXPORT_PER_CPU_SYMBOL(__cpu_data);
+
 /* Alias functions whose names begin with "." and export the aliases.
  * The module references will be fixed up by module_frob_arch_sections.
  */
@@ -148,9 +151,9 @@ EXPORT_SYMBOL(___change_bit);
 /* IRQ implementation. */
 EXPORT_SYMBOL(synchronize_irq);
 
-/* Misc SMP information */
-EXPORT_SYMBOL(__cpu_number_map);
-EXPORT_SYMBOL(__cpu_logical_map);
+/* CPU online map and active count. */
+EXPORT_SYMBOL(cpu_online_map);
+EXPORT_SYMBOL(phys_cpu_present_map);
 #endif
 
 EXPORT_SYMBOL(__udelay);
diff -X dontdiff -urp linux-2.6.11-rc3-clean/arch/sparc/kernel/sun4d_irq.c linux-2.6.11-rc3/arch/sparc/kernel/sun4d_irq.c
--- linux-2.6.11-rc3-clean/arch/sparc/kernel/sun4d_irq.c	2005-02-06 20:30:54.000000000 -0600
+++ linux-2.6.11-rc3/arch/sparc/kernel/sun4d_irq.c	2005-02-12 12:12:19.000000000 -0600
@@ -14,6 +14,7 @@
 #include <linux/sched.h>
 #include <linux/ptrace.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/slab.h>
 #include <linux/random.h>
 #include <linux/init.h>
@@ -54,7 +55,8 @@ unsigned char cpu_leds[32];
 unsigned char sbus_tid[32];
 #endif
 
-extern struct irqaction *irq_action[];
+//extern struct irqaction *irq_action[];
+extern struct { struct irqaction *action; int flags; } sparc_irq[];
 extern spinlock_t irq_action_lock;
 
 struct sbus_action {
@@ -88,7 +90,7 @@ int show_sun4d_interrupts(struct seq_fil
 	if (i < NR_IRQS) {
 		sbusl = pil_to_sbus[i];
 		if (!sbusl) {
-	 		action = *(i + irq_action);
+	 		action = sparc_irq[i].action;
 			if (!action) 
 		        	goto out_unlock;
 		} else {
@@ -145,7 +147,7 @@ void sun4d_free_irq(unsigned int irq, vo
 
 	spin_lock_irqsave(&irq_action_lock, flags);
 	if (irq < 15)
-		actionp = irq + irq_action;
+		actionp = &(sparc_irq[irq].action);
 	else
 		actionp = &(sbus_actions[irq - (1 << 5)].action);
 	action = *actionp;
@@ -212,9 +214,10 @@ void sun4d_handler_irq(int irq, struct p
 	cc_set_iclr(1 << irq);
 	
 	irq_enter();
+	sparc_irq[irq].flags |= IRQ_INPROGRESS;
 	kstat_cpu(cpu).irqs[irq]++;
 	if (!sbusl) {
-		action = *(irq + irq_action);
+		action = sparc_irq[irq].action;
 		if (!action)
 			unexpected_irq(irq, NULL, regs);
 		do {
@@ -252,6 +255,7 @@ void sun4d_handler_irq(int irq, struct p
 					}
 			}
 	}
+	sparc_irq[irq].flags &= ~IRQ_INPROGRESS;
 	irq_exit();
 }
 
@@ -297,7 +301,7 @@ int sun4d_request_irq(unsigned int irq,
 	if (irq >= (1 << 5))
 		actionp = &(sbus_actions[irq - (1 << 5)].action);
 	else
-		actionp = irq + irq_action;
+		actionp = &(sparc_irq[irq].action);
 	action = *actionp;
 	
 	if (action) {
diff -X dontdiff -urp linux-2.6.11-rc3-clean/arch/sparc/kernel/sun4d_smp.c linux-2.6.11-rc3/arch/sparc/kernel/sun4d_smp.c
--- linux-2.6.11-rc3-clean/arch/sparc/kernel/sun4d_smp.c	2005-02-06 20:30:54.000000000 -0600
+++ linux-2.6.11-rc3/arch/sparc/kernel/sun4d_smp.c	2005-02-12 12:12:19.000000000 -0600
@@ -54,7 +54,9 @@ extern volatile int __cpu_number_map[NR_
 extern volatile int __cpu_logical_map[NR_CPUS];
 extern volatile unsigned long ipi_count;
 extern volatile int smp_process_available;
-extern volatile int smp_commenced;
+
+extern cpumask_t smp_commenced_mask;
+
 extern int __smp4d_processor_id(void);
 
 /* #define SMP_DEBUG */
@@ -137,7 +139,7 @@ void __init smp4d_callin(void)
 	
 	local_irq_enable();	/* We don't allow PIL 14 yet */
 	
-	while(!smp_commenced)
+	while (!cpu_isset(cpuid, smp_commenced_mask))
 		barrier();
 
 	spin_lock_irqsave(&sun4d_imsk_lock, flags);
diff -X dontdiff -urp linux-2.6.11-rc3-clean/arch/sparc/kernel/sun4m_smp.c linux-2.6.11-rc3/arch/sparc/kernel/sun4m_smp.c
--- linux-2.6.11-rc3-clean/arch/sparc/kernel/sun4m_smp.c	2005-02-06 20:30:54.000000000 -0600
+++ linux-2.6.11-rc3/arch/sparc/kernel/sun4m_smp.c	2005-02-12 23:24:40.000000000 -0600
@@ -40,16 +40,11 @@ extern ctxd_t *srmmu_ctx_table_phys;
 extern void calibrate_delay(void);
 
 extern volatile int smp_processors_ready;
-extern int smp_num_cpus;
-extern int smp_threads_ready;
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
@@ -78,8 +73,6 @@ void __init smp4m_callin(void)
 	local_flush_cache_all();
 	local_flush_tlb_all();
 
-	set_irq_udt(boot_cpu_id);
-
 	/* Get our local ticker going. */
 	smp_setup_percpu_timer();
 
@@ -96,7 +89,7 @@ void __init smp4m_callin(void)
 	 * to call the scheduler code.
 	 */
 	/* Allow master to continue. */
-	swap((unsigned long *)&cpu_callin_map[cpuid], 1);
+	swap(&cpu_callin_map[cpuid], 1);
 
 	local_flush_cache_all();
 	local_flush_tlb_all();
@@ -112,13 +105,12 @@ void __init smp4m_callin(void)
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
 }
 
 extern void init_IRQ(void);
@@ -135,45 +127,23 @@ extern unsigned long trapbase_cpu3[];
 
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
+
 			/* Cook up an idler for this guy. */
 			p = fork_idle(i);
-			cpucount++;
 			current_set[i] = p->thread_info;
 			/* See trampoline.S for details... */
 			entry += ((i-1) * 3);
@@ -190,7 +160,7 @@ void __init smp4m_boot_cpus(void)
 			/* whirrr, whirrr, whirrrrrrrrr... */
 			printk("Starting CPU %d at %p\n", i, entry);
 			local_flush_cache_all();
-			prom_startcpu(cpu_data(i).prom_node,
+			prom_startcpu(cpu_node,
 				      &smp_penguin_ctable, 0, (char *)entry);
 
 			/* wheee... it's going... */
@@ -199,40 +169,19 @@ void __init smp4m_boot_cpus(void)
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
+	if (!cpu_callin_map[i]) {
+		printk("Processor %d is stuck.\n", i);
+		return -ENODEV;
 	}
+	return 0;
+}
+
+void __init smp4m_smp_done(void)
+{
 	local_flush_cache_all();
-	if(cpucount == 0) {
-		printk("Error: only one Processor found.\n");
-		cpu_present_map = cpumask_of_cpu(smp_processor_id());
-	} else {
-		unsigned long bogosum = 0;
-		for(i = 0; i < NR_CPUS; i++) {
-			if (cpu_isset(i, cpu_present_map))
-				bogosum += cpu_data(i).udelay_val;
-		}
-		printk("Total of %d Processors activated (%lu.%02lu BogoMIPS).\n",
-		       cpucount + 1,
-		       bogosum/(500000/HZ),
-		       (bogosum/(5000/HZ))%100);
-		smp_activated = 1;
-		smp_num_cpus = cpucount + 1;
-	}
 
 	/* Free unneeded trap tables */
-	if (!cpu_isset(i, cpu_present_map)) {
+	if (!cpu_isset(1, cpu_present_map)) {
 		ClearPageReserved(virt_to_page(trapbase_cpu1));
 		set_page_count(virt_to_page(trapbase_cpu1), 1);
 		free_page((unsigned long)trapbase_cpu1);
@@ -292,7 +241,7 @@ void smp4m_message_pass(int target, int 
 
 	smp_cpu_in_msg[me]++;
 	if(target == MSG_ALL_BUT_SELF || target == MSG_ALL) {
-		mask = cpu_present_map;
+		mask = cpu_online_map;
 		if(target == MSG_ALL_BUT_SELF)
 			cpu_clear(me, mask);
 		for(i = 0; i < 4; i++) {
@@ -328,7 +277,7 @@ void smp4m_cross_call(smpfunc_t func, un
 		    unsigned long arg3, unsigned long arg4, unsigned long arg5)
 {
 	if(smp_processors_ready) {
-		register int ncpus = smp_num_cpus;
+		register int ncpus = NR_CPUS; //smp_num_cpus;
 		unsigned long flags;
 
 		spin_lock_irqsave(&cross_call_lock, flags);
@@ -343,7 +292,7 @@ void smp4m_cross_call(smpfunc_t func, un
 
 		/* Init receive/complete mapping, plus fire the IPI's off. */
 		{
-			cpumask_t mask = cpu_present_map;
+			cpumask_t mask = cpu_online_map;
 			register int i;
 
 			cpu_clear(smp_processor_id(), mask);
Only in linux-2.6.11-rc3/arch/sparc/kernel: vmlinux.lds
diff -X dontdiff -urp linux-2.6.11-rc3-clean/arch/sparc/mm/srmmu.c linux-2.6.11-rc3/arch/sparc/mm/srmmu.c
--- linux-2.6.11-rc3-clean/arch/sparc/mm/srmmu.c	2005-02-06 20:30:54.000000000 -0600
+++ linux-2.6.11-rc3/arch/sparc/mm/srmmu.c	2005-02-12 13:40:45.000000000 -0600
@@ -1417,6 +1417,7 @@ static void __init init_vac_layout(void)
 				max_size = vac_cache_size;
 			if(vac_line_size < min_line_size)
 				min_line_size = vac_line_size;
+			// FIXME: cpus not contiguous!!
 			cpu++;
 			if (cpu >= NR_CPUS || !cpu_online(cpu))
 				break;

--------------050102010209020004070703--
