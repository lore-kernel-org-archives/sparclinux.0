From: Daniel Hellstrom <daniel@gaisler.com>
Date: Mon, 02 May 2011 10:08:54 +0000
Subject: [PATCH 4/4 v2] sparc32,sun4d: Implemented SMP IPIs support for SUN4D machines
Message-Id: <1304330934-16638-4-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The sun4d does not seem to have a distingstion between soft and hard
IRQs. When generating IPIs the generated IRQ looks like a hard IRQ,
this patch adds a "IPI check" in the sun4d irq trap handler at a
predefined IRQ number (SUN4D_IPI_IRQ). Before generating an IPI
a per-cpu memory structure is modified for the "IPI check" to
successfully detect a IPI request to a specific processor, the check
clears the IPI work requested.

All three IPIs (resched, single and cpu-mask) use the same IRQ
number.

The IPI IRQ should preferrably be on a separate IRQ and definitly
not shared with IRQ handlers requesting IRQ with IRQF_SHARED.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/kernel/irq.h       |    6 +++
 arch/sparc/kernel/sun4d_irq.c |    9 +++++
 arch/sparc/kernel/sun4d_smp.c |   79 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 94 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/irq.h b/arch/sparc/kernel/irq.h
index a189c27..100b9c2 100644
--- a/arch/sparc/kernel/irq.h
+++ b/arch/sparc/kernel/irq.h
@@ -86,4 +86,10 @@ BTFIXUPDEF_CALL(void, set_irq_udt, int)
 #define set_cpu_int(cpu,level) BTFIXUP_CALL(set_cpu_int)(cpu,level)
 #define clear_cpu_int(cpu,level) BTFIXUP_CALL(clear_cpu_int)(cpu,level)
 #define set_irq_udt(cpu) BTFIXUP_CALL(set_irq_udt)(cpu)
+
+/* All SUN4D IPIs are sent on this IRQ, may be shared with hard IRQs */
+#define SUN4D_IPI_IRQ 14
+
+extern void sun4d_ipi_interrupt(void);
+
 #endif
diff --git a/arch/sparc/kernel/sun4d_irq.c b/arch/sparc/kernel/sun4d_irq.c
index b830914..a9ea60e 100644
--- a/arch/sparc/kernel/sun4d_irq.c
+++ b/arch/sparc/kernel/sun4d_irq.c
@@ -156,6 +156,15 @@ void sun4d_handler_irq(int pil, struct pt_regs *regs)
 
 	cc_set_iclr(1 << pil);
 
+#ifdef CONFIG_SMP
+	/*
+	 * Check IPI data structures after IRQ has been cleared. Hard and Soft
+	 * IRQ can happen at the same time, so both cases are always handled.
+	 */
+	if (pil = SUN4D_IPI_IRQ)
+		sun4d_ipi_interrupt();
+#endif
+
 	old_regs = set_irq_regs(regs);
 	irq_enter();
 	if (sbusl = 0) {
diff --git a/arch/sparc/kernel/sun4d_smp.c b/arch/sparc/kernel/sun4d_smp.c
index 475d50b..dcbabe2 100644
--- a/arch/sparc/kernel/sun4d_smp.c
+++ b/arch/sparc/kernel/sun4d_smp.c
@@ -32,6 +32,7 @@ static inline unsigned long sun4d_swap(volatile unsigned long *ptr, unsigned lon
 	return val;
 }
 
+static void smp4d_ipi_init(void);
 static void smp_setup_percpu_timer(void);
 
 static unsigned char cpu_leds[32];
@@ -120,6 +121,7 @@ void __cpuinit smp4d_callin(void)
  */
 void __init smp4d_boot_cpus(void)
 {
+	smp4d_ipi_init();
 	if (boot_cpu_id)
 		current_set[0] = NULL;
 	smp_setup_percpu_timer();
@@ -191,6 +193,80 @@ void __init smp4d_smp_done(void)
 	sun4d_distribute_irqs();
 }
 
+/* Memory structure giving interrupt handler information about IPI generated */
+struct sun4d_ipi_work {
+	int single;
+	int msk;
+	int resched;
+};
+
+static DEFINE_PER_CPU_SHARED_ALIGNED(struct sun4d_ipi_work, sun4d_ipi_work);
+
+/* Initialize IPIs on the SUN4D SMP machine */
+static void __init smp4d_ipi_init(void)
+{
+	int cpu;
+	struct sun4d_ipi_work *work;
+
+	printk(KERN_INFO "smp4d: setup IPI at IRQ %d\n", SUN4D_IPI_IRQ);
+
+	for_each_possible_cpu(cpu) {
+		work = &per_cpu(sun4d_ipi_work, cpu);
+		work->single = work->msk = work->resched = 0;
+	}
+}
+
+void sun4d_ipi_interrupt(void)
+{
+	struct sun4d_ipi_work *work = &__get_cpu_var(sun4d_ipi_work);
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
+static void smp4d_ipi_single(int cpu)
+{
+	struct sun4d_ipi_work *work = &per_cpu(sun4d_ipi_work, cpu);
+
+	/* Mark work */
+	work->single = 1;
+
+	/* Generate IRQ on the CPU */
+	sun4d_send_ipi(cpu, SUN4D_IPI_IRQ);
+}
+
+static void smp4d_ipi_mask_one(int cpu)
+{
+	struct sun4d_ipi_work *work = &per_cpu(sun4d_ipi_work, cpu);
+
+	/* Mark work */
+	work->msk = 1;
+
+	/* Generate IRQ on the CPU */
+	sun4d_send_ipi(cpu, SUN4D_IPI_IRQ);
+}
+
+static void smp4d_ipi_resched(int cpu)
+{
+	struct sun4d_ipi_work *work = &per_cpu(sun4d_ipi_work, cpu);
+
+	/* Mark work */
+	work->resched = 1;
+
+	/* Generate IRQ on the CPU (any IRQ will cause resched) */
+	sun4d_send_ipi(cpu, SUN4D_IPI_IRQ);
+}
+
 static struct smp_funcall {
 	smpfunc_t func;
 	unsigned long arg1;
@@ -356,6 +432,9 @@ void __init sun4d_init_smp(void)
 	BTFIXUPSET_BLACKBOX(load_current, smp4d_blackbox_current);
 	BTFIXUPSET_CALL(smp_cross_call, smp4d_cross_call, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(__hard_smp_processor_id, __smp4d_processor_id, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(smp_ipi_resched, smp4d_ipi_resched, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(smp_ipi_single, smp4d_ipi_single, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(smp_ipi_mask_one, smp4d_ipi_mask_one, BTFIXUPCALL_NORM);
 
 	for (i = 0; i < NR_CPUS; i++) {
 		ccall_info.processors_in[i] = 1;
-- 
1.5.4

