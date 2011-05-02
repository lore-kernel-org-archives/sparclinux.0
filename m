From: Daniel Hellstrom <daniel@gaisler.com>
Date: Mon, 02 May 2011 10:08:52 +0000
Subject: [PATCH 2/4 v2] sparc32,leon: Implemented SMP IPIs for LEON CPU
Message-Id: <1304330934-16638-2-git-send-email-daniel@gaisler.com>
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
 arch/sparc/include/asm/leon.h |    4 +-
 arch/sparc/kernel/entry.S     |   16 ++++++
 arch/sparc/kernel/leon_smp.c  |  109 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 126 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
index b921560..98eea86 100644
--- a/arch/sparc/include/asm/leon.h
+++ b/arch/sparc/include/asm/leon.h
@@ -215,7 +215,7 @@ static inline int sparc_leon3_cpuid(void)
 #endif /*!__ASSEMBLY__*/
 
 #ifdef CONFIG_SMP
-# define LEON3_IRQ_RESCHEDULE		13
+# define LEON3_IRQ_IPI_DEFAULT		13
 # define LEON3_IRQ_TICKER		(leon3_ticker_irq)
 # define LEON3_IRQ_CROSS_CALL		15
 #endif
@@ -355,9 +355,11 @@ void leon_enable_irq_cpu(unsigned int irq_nr, unsigned int cpu);
 extern irqreturn_t leon_percpu_timer_interrupt(int irq, void *unused);
 
 extern unsigned int real_irq_entry[];
+extern unsigned int smpleon_ipi[];
 extern unsigned int patchme_maybe_smp_msg[];
 extern unsigned int t_nmi[], linux_trap_ipi15_leon[];
 extern unsigned int linux_trap_ipi15_sun4m[];
+extern int leon_ipi_irq;
 
 #endif /* CONFIG_SMP */
 
diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index 4511c20..c5962d0 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -401,6 +401,22 @@ linux_trap_ipi15_sun4d:
 1:	b,a	1b
 
 #ifdef CONFIG_SPARC_LEON
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
index 826a505..473e0f7 100644
--- a/arch/sparc/kernel/leon_smp.c
+++ b/arch/sparc/kernel/leon_smp.c
@@ -14,6 +14,7 @@
 #include <linux/smp.h>
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
+#include <linux/of.h>
 #include <linux/init.h>
 #include <linux/spinlock.h>
 #include <linux/mm.h>
@@ -29,6 +30,7 @@
 #include <asm/ptrace.h>
 #include <asm/atomic.h>
 #include <asm/irq_regs.h>
+#include <asm/traps.h>
 
 #include <asm/delay.h>
 #include <asm/irq.h>
@@ -52,6 +54,10 @@ static int smp_processors_ready;
 extern volatile unsigned long cpu_callin_map[NR_CPUS];
 extern cpumask_t smp_commenced_mask;
 void __init leon_configure_cache_smp(void);
+static void leon_ipi_init(void);
+
+/* IRQ number of LEON IPIs */
+int leon_ipi_irq = LEON3_IRQ_IPI_DEFAULT;
 
 static inline unsigned long do_swap(volatile unsigned long *ptr,
 				    unsigned long val)
@@ -178,13 +184,16 @@ void __init leon_boot_cpus(void)
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
 
@@ -239,7 +248,7 @@ int __cpuinit leon_boot_one_cpu(int i)
 	} else {
 		leon_enable_irq_cpu(LEON3_IRQ_CROSS_CALL, i);
 		leon_enable_irq_cpu(LEON3_IRQ_TICKER, i);
-		leon_enable_irq_cpu(LEON3_IRQ_RESCHEDULE, i);
+		leon_enable_irq_cpu(leon_ipi_irq, i);
 	}
 
 	local_flush_cache_all();
@@ -295,6 +304,99 @@ void leon_irq_rotate(int cpu)
 {
 }
 
+struct leon_ipi_work {
+	int single;
+	int msk;
+	int resched;
+};
+
+static DEFINE_PER_CPU_SHARED_ALIGNED(struct leon_ipi_work, leon_ipi_work);
+
+/* Initialize IPIs on the LEON, in order to save IRQ resources only one IRQ
+ * is used for all three types of IPIs.
+ */
+static void __init leon_ipi_init(void)
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
+		work->single = work->msk = work->resched = 0;
+	}
+}
+
+static void leon_ipi_single(int cpu)
+{
+	struct leon_ipi_work *work = &per_cpu(leon_ipi_work, cpu);
+
+	/* Mark work */
+	work->single = 1;
+
+	/* Generate IRQ on the CPU */
+	set_cpu_int(cpu, leon_ipi_irq);
+}
+
+static void leon_ipi_mask_one(int cpu)
+{
+	struct leon_ipi_work *work = &per_cpu(leon_ipi_work, cpu);
+
+	/* Mark work */
+	work->msk = 1;
+
+	/* Generate IRQ on the CPU */
+	set_cpu_int(cpu, leon_ipi_irq);
+}
+
+static void leon_ipi_resched(int cpu)
+{
+	struct leon_ipi_work *work = &per_cpu(leon_ipi_work, cpu);
+
+	/* Mark work */
+	work->resched = 1;
+
+	/* Generate IRQ on the CPU (any IRQ will cause resched) */
+	set_cpu_int(cpu, leon_ipi_irq);
+}
+
+void leonsmp_ipi_interrupt(void)
+{
+	struct leon_ipi_work *work = &__get_cpu_var(leon_ipi_work);
+
+	if (work->single) {
+		work->single = 0;
+		smp_call_function_single_interrupt();
+	}
+	if (work->msk) {
+		work->msk = 0;
+		smp_call_function_interrupt();
+	}
+	if (work->resched) {
+		work->resched = 0;
+		smp_resched_interrupt();
+	}
+}
+
 static struct smp_funcall {
 	smpfunc_t func;
 	unsigned long arg1;
@@ -448,6 +550,9 @@ void __init leon_init_smp(void)
 	BTFIXUPSET_CALL(smp_cross_call, leon_cross_call, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(__hard_smp_processor_id, __leon_processor_id,
 			BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(smp_ipi_resched, leon_ipi_resched, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(smp_ipi_single, leon_ipi_single, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(smp_ipi_mask_one, leon_ipi_mask_one, BTFIXUPCALL_NORM);
 }
 
 #endif /* CONFIG_SPARC_LEON */
-- 
1.5.4

