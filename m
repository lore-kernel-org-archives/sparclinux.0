From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 02 Feb 2011 19:40:56 +0000
Subject: [PATCH 2/2 v2] sparc32,leon: Implemented SMP IPIs for LEON CPU
Message-Id: <1296675656-19165-2-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This patch implements SMP IPIs on LEON using software generated
IRQs to signal between CPUs.

The IPI IRQ number is set by using the ipi_num property in the
device tree, or defaults to 13. LEON SMP systems should reserve
IRQ 13 (and IRQ 15) to Linux in order for the defaults to work.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/include/asm/leon.h |    7 ++-
 arch/sparc/kernel/entry.S     |   16 +++++
 arch/sparc/kernel/leon_smp.c  |  122 ++++++++++++++++++++++++++++++++++++++++-
 arch/sparc/kernel/smp_32.c    |    9 +++
 4 files changed, 151 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
index 8580d17..fb60642 100644
--- a/arch/sparc/include/asm/leon.h
+++ b/arch/sparc/include/asm/leon.h
@@ -239,7 +239,7 @@ static inline int sparc_leon3_cpuid(void)
 #endif /*!__ASSEMBLY__*/
 
 #ifdef CONFIG_SMP
-# define LEON3_IRQ_RESCHEDULE		13
+# define LEON3_IRQ_IPI_DEFAULT		13
 # define LEON3_IRQ_TICKER		(leon_percpu_timer_dev[0].irq)
 # define LEON3_IRQ_CROSS_CALL		15
 #endif
@@ -366,6 +366,9 @@ extern void leon_smp_done(void);
 extern void leon_boot_cpus(void);
 extern int leon_boot_one_cpu(int i);
 void leon_init_smp(void);
+extern void leon_send_call_function_ipi_mask(const struct cpumask *mask);
+extern void leon_send_call_function_single_ipi(int cpu);
+extern void leon_send_resched(int cpu);
 extern void cpu_probe(void);
 extern void cpu_idle(void);
 extern void init_IRQ(void);
@@ -374,12 +377,14 @@ extern int __leon_processor_id(void);
 void leon_enable_irq_cpu(unsigned int irq_nr, unsigned int cpu);
 
 extern unsigned int real_irq_entry[], smpleon_ticker[];
+extern unsigned int smpleon_ipi[];
 extern unsigned int patchme_maybe_smp_msg[];
 extern unsigned long trapbase_cpu1[];
 extern unsigned long trapbase_cpu2[];
 extern unsigned long trapbase_cpu3[];
 extern unsigned int t_nmi[], linux_trap_ipi15_leon[];
 extern unsigned int linux_trap_ipi15_sun4m[];
+extern int leon_ipi_irq;
 
 #endif /* CONFIG_SMP */
 
diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index 1504df8..666344d 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -417,6 +417,22 @@ smpleon_ticker:
 	WRITE_PAUSE
 	RESTORE_ALL
 
+	.globl	smpleon_ipi
+	.extern leon_ipi_interrupt
+	/* SMP per-cpu IPI interrupts are handled specially. */
+smpleon_ipi:
+        SAVE_ALL
+	or	%l0, PSR_PIL, %g2
+	wr	%g2, 0x0, %psr
+	WRITE_PAUSE
+	wr	%g2, PSR_ET, %psr
+	WRITE_PAUSE
+	call	leonsmp_ipi_interrupt
+	 add	%sp, STACKFRAME_SZ, %o1 ! pt_regs
+	wr	%l0, PSR_ET, %psr
+	WRITE_PAUSE
+	RESTORE_ALL
+
 	.align	4
 	.globl	linux_trap_ipi15_leon
 linux_trap_ipi15_leon:
diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
index e9df87f..b19e9aa 100644
--- a/arch/sparc/kernel/leon_smp.c
+++ b/arch/sparc/kernel/leon_smp.c
@@ -29,6 +29,7 @@
 #include <asm/ptrace.h>
 #include <asm/atomic.h>
 #include <asm/irq_regs.h>
+#include <asm/traps.h>
 
 #include <asm/delay.h>
 #include <asm/irq.h>
@@ -51,6 +52,10 @@ extern volatile unsigned long cpu_callin_map[NR_CPUS];
 extern unsigned char boot_cpu_id;
 extern cpumask_t smp_commenced_mask;
 void __init leon_configure_cache_smp(void);
+void leon_ipi_init(void);
+
+/* IRQ number of LEON IPIs */
+int leon_ipi_irq = LEON3_IRQ_IPI_DEFAULT;
 
 static inline unsigned long do_swap(volatile unsigned long *ptr,
 				    unsigned long val)
@@ -177,13 +182,16 @@ void __init leon_boot_cpus(void)
 	int nrcpu = leon_smp_nrcpus();
 	int me = smp_processor_id();
 
+	/* Setup IPI */
+	leon_ipi_init();
+
 	printk(KERN_INFO "%d:(%d:%d) cpus mpirq at 0x%x\n", (unsigned int)me,
 	       (unsigned int)nrcpu, (unsigned int)NR_CPUS,
 	       (unsigned int)&(leon3_irqctrl_regs->mpstatus));
 
 	leon_enable_irq_cpu(LEON3_IRQ_CROSS_CALL, me);
 	leon_enable_irq_cpu(LEON3_IRQ_TICKER, me);
-	leon_enable_irq_cpu(LEON3_IRQ_RESCHEDULE, me);
+	leon_enable_irq_cpu(leon_ipi_irq, me);
 
 	leon_smp_setbroadcast(1 << LEON3_IRQ_TICKER);
 
@@ -234,7 +242,7 @@ int __cpuinit leon_boot_one_cpu(int i)
 	} else {
 		leon_enable_irq_cpu(LEON3_IRQ_CROSS_CALL, i);
 		leon_enable_irq_cpu(LEON3_IRQ_TICKER, i);
-		leon_enable_irq_cpu(LEON3_IRQ_RESCHEDULE, i);
+		leon_enable_irq_cpu(leon_ipi_irq, i);
 	}
 
 	local_flush_cache_all();
@@ -290,6 +298,116 @@ void leon_irq_rotate(int cpu)
 {
 }
 
+struct leon_ipi_work {
+	int single;
+	int msk;
+	spinlock_t lock;
+};
+
+static DEFINE_PER_CPU_SHARED_ALIGNED(struct leon_ipi_work, leon_ipi_work);
+
+/* Initialize IPIs on the LEON */
+void __init leon_ipi_init(void)
+{
+	int cpu, len;
+	struct leon_ipi_work *work;
+	struct property *pp;
+	struct device_node *rootnp;
+	struct tt_entry *trap_table;
+	unsigned long flags;
+
+	/* Find IPI IRQ or stick with default value */
+	rootnp = of_find_node_by_path("/ambapp0");
+	if (rootnp) {
+		pp = of_find_property(rootnp, "ipi_num", &len);
+		if (pp && (*(int *)pp->value))
+			leon_ipi_irq = *(int *)pp->value;
+	}
+	printk(KERN_INFO "leon: SMP IPIs at IRQ %d\n", leon_ipi_irq);
+
+	/* Adjust so that we jump directly to smpleon_ipi */
+	local_irq_save(flags);
+	trap_table = &sparc_ttable[SP_TRAP_IRQ1 + (leon_ipi_irq - 1)];
+	trap_table->inst_three += smpleon_ipi - real_irq_entry;
+	local_flush_cache_all();
+	local_irq_restore(flags);
+
+	for_each_possible_cpu(cpu) {
+		work = &per_cpu(leon_ipi_work, cpu);
+		work->single = work->msk = 0;
+		spin_lock_init(&work->lock);
+	}
+}
+
+void leon_send_call_function_single_ipi(int cpu)
+{
+	struct leon_ipi_work *work = &per_cpu(leon_ipi_work, cpu);
+	unsigned long flags;
+
+	spin_lock_irqsave(&work->lock, flags);
+
+	/* Mark work */
+	work->single = 1;
+
+	/* Generate IRQ on the CPU */
+	set_cpu_int(cpu, leon_ipi_irq);
+
+	spin_unlock_irqrestore(&work->lock, flags);
+}
+
+void leon_send_call_function_ipi_mask(const struct cpumask *mask)
+{
+	struct leon_ipi_work *work;
+	int i;
+	unsigned long flags;
+
+	for_each_cpu(i, mask) {
+		work = &per_cpu(leon_ipi_work, i);
+
+		spin_lock_irqsave(&work->lock, flags);
+
+		/* Toggle work */
+		work->msk = 1;
+
+		/* Generate IRQ on the CPU */
+		set_cpu_int(i, leon_ipi_irq);
+
+		spin_unlock_irqrestore(&work->lock, flags);
+	}
+}
+
+void leon_send_resched(int cpu)
+{
+	/* Generate IRQ on the CPU (any IRQ will cause resched) */
+	set_cpu_int(cpu, leon_ipi_irq);
+}
+
+void leonsmp_ipi_interrupt(void)
+{
+	struct leon_ipi_work *work = &__get_cpu_var(leon_ipi_work);
+	int single, msk;
+
+	spin_lock(&work->lock);
+	if (work->single) {
+		single = 1;
+		work->single = 0;
+	}
+	if (work->msk) {
+		msk = 1;
+		work->msk = 0;
+	}
+	spin_unlock(&work->lock);
+
+	if (single)
+		generic_smp_call_function_single_interrupt();
+	if (msk)
+		generic_smp_call_function_interrupt();
+
+	/* RESCHED: do nothing, since it all was about calling re-schedule
+	 * routine called by interrupt return code.
+	 */
+}
+
 static struct smp_funcall {
 	smpfunc_t func;
 	unsigned long arg1;
diff --git a/arch/sparc/kernel/smp_32.c b/arch/sparc/kernel/smp_32.c
index a1bb3a8..bd9da00 100644
--- a/arch/sparc/kernel/smp_32.c
+++ b/arch/sparc/kernel/smp_32.c
@@ -131,6 +131,9 @@ void smp_send_reschedule(int cpu)
 	 * to call schedule.
 	 */
 	switch (sparc_cpu_model) {
+	case sparc_leon:
+		leon_send_resched(cpu);
+		break;
 	default:
 		BUG();
 	}
@@ -147,6 +150,9 @@ void arch_send_call_function_single_ipi(int cpu)
 	 * a single CPU
 	 */
 	switch (sparc_cpu_model) {
+	case sparc_leon:
+		leon_send_call_function_single_ipi(cpu);
+		break;
 	default:
 		BUG();
 	}
@@ -159,6 +165,9 @@ void arch_send_call_function_ipi_mask(const struct cpumask *mask)
 	 * a set of CPUs
 	 */
 	switch (sparc_cpu_model) {
+	case sparc_leon:
+		leon_send_call_function_ipi_mask(mask);
+		break;
 	default:
 		BUG();
 	}
-- 
1.5.4

