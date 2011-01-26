From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 26 Jan 2011 16:38:31 +0000
Subject: [PATCH 2/2] SPARC32: Implemented SMP IPIs for LEON CPU
Message-Id: <1296059911-22861-2-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This patch implements SMP IPIs on LEON using software generated
IRQs to signal between CPUs.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/include/asm/leon.h   |    6 +++-
 arch/sparc/kernel/entry.S       |   16 ++++++++
 arch/sparc/kernel/leon_kernel.c |    5 +++
 arch/sparc/kernel/leon_smp.c    |   77 ++++++++++++++++++++++++++++++++++++++-
 arch/sparc/kernel/smp_32.c      |    9 +++++
 5 files changed, 110 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
index 8580d17..93833f1 100644
--- a/arch/sparc/include/asm/leon.h
+++ b/arch/sparc/include/asm/leon.h
@@ -239,7 +239,7 @@ static inline int sparc_leon3_cpuid(void)
 #endif /*!__ASSEMBLY__*/
 
 #ifdef CONFIG_SMP
-# define LEON3_IRQ_RESCHEDULE		13
+# define LEON3_IRQ_IPI			13
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
@@ -374,6 +377,7 @@ extern int __leon_processor_id(void);
 void leon_enable_irq_cpu(unsigned int irq_nr, unsigned int cpu);
 
 extern unsigned int real_irq_entry[], smpleon_ticker[];
+extern unsigned int smpleon_ipi[];
 extern unsigned int patchme_maybe_smp_msg[];
 extern unsigned long trapbase_cpu1[];
 extern unsigned long trapbase_cpu2[];
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
diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index ef5edbb..87812dd 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -245,6 +245,11 @@ void __init leon_init_timers(irq_handler_t counter_fn)
 		/* Adjust so that we jump directly to smpleon_ticker */
 		trap_table->inst_three += smpleon_ticker - real_irq_entry;
 
+		/* Adjust so that we jump directly to smpleon_ipi */
+		trap_table = &sparc_ttable[SP_TRAP_IRQ1 +
+						(LEON3_IRQ_IPI - 1)];
+		trap_table->inst_three += smpleon_ipi - real_irq_entry;
+
 		local_flush_cache_all();
 		local_irq_restore(flags);
 	}
diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
index e9df87f..bbb60b4 100644
--- a/arch/sparc/kernel/leon_smp.c
+++ b/arch/sparc/kernel/leon_smp.c
@@ -183,7 +183,7 @@ void __init leon_boot_cpus(void)
 
 	leon_enable_irq_cpu(LEON3_IRQ_CROSS_CALL, me);
 	leon_enable_irq_cpu(LEON3_IRQ_TICKER, me);
-	leon_enable_irq_cpu(LEON3_IRQ_RESCHEDULE, me);
+	leon_enable_irq_cpu(LEON3_IRQ_IPI, me);
 
 	leon_smp_setbroadcast(1 << LEON3_IRQ_TICKER);
 
@@ -234,7 +234,7 @@ int __cpuinit leon_boot_one_cpu(int i)
 	} else {
 		leon_enable_irq_cpu(LEON3_IRQ_CROSS_CALL, i);
 		leon_enable_irq_cpu(LEON3_IRQ_TICKER, i);
-		leon_enable_irq_cpu(LEON3_IRQ_RESCHEDULE, i);
+		leon_enable_irq_cpu(LEON3_IRQ_IPI, i);
 	}
 
 	local_flush_cache_all();
@@ -290,6 +290,79 @@ void leon_irq_rotate(int cpu)
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
+void leon_send_call_function_single_ipi(int cpu)
+{
+	struct leon_ipi_work *work = &per_cpu(leon_ipi_work, cpu);
+
+	/* Mark work */
+	work->single = 1;
+	mb();
+
+	/* Generate IRQ on the CPU */
+	set_cpu_int(cpu, LEON3_IRQ_IPI);
+}
+
+void leon_send_call_function_ipi_mask(const struct cpumask *mask)
+{
+	struct leon_ipi_work *work;
+	int i;
+
+	for_each_cpu(i, mask) {
+		/* Toggle work */
+		work = &per_cpu(leon_ipi_work, i);
+		work->msk = 1;
+		mb();
+
+		/* Generate IRQ on the CPU */
+		set_cpu_int(i, LEON3_IRQ_IPI);
+	}
+}
+
+void leon_send_resched(int cpu)
+{
+	struct leon_ipi_work *work = &per_cpu(leon_ipi_work, cpu);
+
+	/* Mark work... pointless really */
+	work->resched = 1;
+	mb();
+
+	/* Generate IRQ on the CPU */
+	set_cpu_int(cpu, LEON3_IRQ_IPI);
+}
+
+void leonsmp_ipi_interrupt(void)
+{
+	struct leon_ipi_work *work = &__get_cpu_var(leon_ipi_work);
+
+	if (work->single) {
+		work->single = 0;
+		mb();
+		generic_smp_call_function_single_interrupt();
+	}
+
+	if (work->msk) {
+		work->msk = 0;
+		mb();
+		generic_smp_call_function_interrupt();
+	}
+
+	if (work->resched) {
+		work->resched = 0;
+		mb();
+		/* do nothing, since it all was about calling re-schedule
+		 * routine called by interrupt return code.
+		 */
+	}
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

