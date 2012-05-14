From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 14 May 2012 15:07:45 +0000
Subject: [PATCH] sparc32: move smp ipi to method ops
Message-Id: <20120514150745.GA28682@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From c940e0c5f1491b5c8a24c97256eea78d20484875 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 14 May 2012 15:14:36 +0200
Subject: [PATCH] sparc32: move smp ipi to method ops

I ended up renaming set_cpu_int to send_ipi to
be consistent all way around.
send_ipi was moved to the *_smp.c files so
we could call the relevant method direct,
without any _ops indirection.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/obio.h   |   13 -----------
 arch/sparc/include/asm/smp_32.h |   45 +++++++++++++++++++++++++++-----------
 arch/sparc/kernel/irq.h         |    8 ++++--
 arch/sparc/kernel/leon_kernel.c |   19 ++-------------
 arch/sparc/kernel/leon_smp.c    |   27 ++++++++++++++++-------
 arch/sparc/kernel/smp_32.c      |    8 ++++--
 arch/sparc/kernel/sun4d_irq.c   |    8 -------
 arch/sparc/kernel/sun4d_smp.c   |   34 +++++++++++++++++++++-------
 arch/sparc/kernel/sun4m_irq.c   |   14 ------------
 arch/sparc/kernel/sun4m_smp.c   |   36 +++++++++++++++---------------
 10 files changed, 107 insertions(+), 105 deletions(-)

diff --git a/arch/sparc/include/asm/obio.h b/arch/sparc/include/asm/obio.h
index 4ade0c8..910c1d9 100644
--- a/arch/sparc/include/asm/obio.h
+++ b/arch/sparc/include/asm/obio.h
@@ -220,19 +220,6 @@ static inline void cc_set_igen(unsigned gen)
 			      "i" (ASI_M_MXCC));
 }
 
-/* +-------+-------------+-----------+------------------------------------+
- * | bcast |  devid      |   sid     |              levels mask           |
- * +-------+-------------+-----------+------------------------------------+
- *  31      30         23 22       15 14                                 0
- */
-#define IGEN_MESSAGE(bcast, devid, sid, levels) \
-	(((bcast) << 31) | ((devid) << 23) | ((sid) << 15) | (levels))
-            
-static inline void sun4d_send_ipi(int cpu, int level)
-{
-	cc_set_igen(IGEN_MESSAGE(0, cpu << 3, 6 + ((level >> 1) & 7), 1 << (level - 1)));
-}
-
 #endif /* !__ASSEMBLY__ */
 
 #endif /* !(_SPARC_OBIO_H) */
diff --git a/arch/sparc/include/asm/smp_32.h b/arch/sparc/include/asm/smp_32.h
index f5b325e..d596061 100644
--- a/arch/sparc/include/asm/smp_32.h
+++ b/arch/sparc/include/asm/smp_32.h
@@ -58,24 +58,43 @@ struct seq_file;
 void smp_bogo(struct seq_file *);
 void smp_info(struct seq_file *);
 
-BTFIXUPDEF_CALL(void, smp_cross_call, smpfunc_t, cpumask_t, unsigned long, unsigned long, unsigned long, unsigned long)
-BTFIXUPDEF_CALL(void, smp_ipi_resched, int);
-BTFIXUPDEF_CALL(void, smp_ipi_single, int);
-BTFIXUPDEF_CALL(void, smp_ipi_mask_one, int);
-
-#define smp_cross_call(func,mask,arg1,arg2,arg3,arg4) BTFIXUP_CALL(smp_cross_call)(func,mask,arg1,arg2,arg3,arg4)
+struct sparc32_ipi_ops {
+	void (*cross_call)(smpfunc_t func, cpumask_t mask, unsigned long arg1,
+			   unsigned long arg2, unsigned long arg3,
+			   unsigned long arg4);
+	void (*resched)(int cpu);
+	void (*single)(int cpu);
+	void (*mask_one)(int cpu);
+};
+extern const struct sparc32_ipi_ops *sparc32_ipi_ops;
+
+static inline void xc0(smpfunc_t func)
+{
+	sparc32_ipi_ops->cross_call(func, *cpu_online_mask, 0, 0, 0, 0);
+}
 
-static inline void xc0(smpfunc_t func) { smp_cross_call(func, *cpu_online_mask, 0, 0, 0, 0); }
 static inline void xc1(smpfunc_t func, unsigned long arg1)
-{ smp_cross_call(func, *cpu_online_mask, arg1, 0, 0, 0); }
+{
+	sparc32_ipi_ops->cross_call(func, *cpu_online_mask, arg1, 0, 0, 0);
+}
 static inline void xc2(smpfunc_t func, unsigned long arg1, unsigned long arg2)
-{ smp_cross_call(func, *cpu_online_mask, arg1, arg2, 0, 0); }
+{
+	sparc32_ipi_ops->cross_call(func, *cpu_online_mask, arg1, arg2, 0, 0);
+}
+
 static inline void xc3(smpfunc_t func, unsigned long arg1, unsigned long arg2,
-			   unsigned long arg3)
-{ smp_cross_call(func, *cpu_online_mask, arg1, arg2, arg3, 0); }
+		       unsigned long arg3)
+{
+	sparc32_ipi_ops->cross_call(func, *cpu_online_mask,
+				    arg1, arg2, arg3, 0);
+}
+
 static inline void xc4(smpfunc_t func, unsigned long arg1, unsigned long arg2,
-			   unsigned long arg3, unsigned long arg4)
-{ smp_cross_call(func, *cpu_online_mask, arg1, arg2, arg3, arg4); }
+		       unsigned long arg3, unsigned long arg4)
+{
+	sparc32_ipi_ops->cross_call(func, *cpu_online_mask,
+				    arg1, arg2, arg3, arg4);
+}
 
 extern void arch_send_call_function_single_ipi(int cpu);
 extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
diff --git a/arch/sparc/kernel/irq.h b/arch/sparc/kernel/irq.h
index e2b5d5c..e40ca6c 100644
--- a/arch/sparc/kernel/irq.h
+++ b/arch/sparc/kernel/irq.h
@@ -10,6 +10,9 @@ struct irq_bucket {
         unsigned int pil;
 };
 
+#define SUN4M_HARD_INT(x)       (0x000000001 << (x))
+#define SUN4M_SOFT_INT(x)       (0x000010000 << (x))
+
 #define SUN4D_MAX_BOARD 10
 #define SUN4D_MAX_IRQ ((SUN4D_MAX_BOARD + 2) << 5)
 
@@ -96,10 +99,9 @@ static inline void load_profile_irq(int cpu, int limit)
 	BTFIXUP_CALL(load_profile_irq)(cpu, limit);
 }
 
-#ifdef CONFIG_SMP
-BTFIXUPDEF_CALL(void, set_cpu_int, int, int)
+unsigned long leon_get_irqmask(unsigned int irq);
 
-#define set_cpu_int(cpu,level) BTFIXUP_CALL(set_cpu_int)(cpu,level)
+#ifdef CONFIG_SMP
 
 /* All SUN4D IPIs are sent on this IRQ, may be shared with hard IRQs */
 #define SUN4D_IPI_IRQ 13
diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index aeb411c..1770b3c 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -86,7 +86,7 @@ void leon_eirq_setup(unsigned int eirq)
 	sparc_leon_eirq = eirq;
 }
 
-static inline unsigned long get_irqmask(unsigned int irq)
+unsigned long leon_get_irqmask(unsigned int irq)
 {
 	unsigned long mask;
 
@@ -212,7 +212,7 @@ unsigned int leon_build_device_irq(unsigned int real_irq,
 	unsigned long mask;
 
 	irq = 0;
-	mask = get_irqmask(real_irq);
+	mask = leon_get_irqmask(real_irq);
 	if (mask = 0)
 		goto out;
 
@@ -497,14 +497,6 @@ void __init leon_node_init(struct device_node *dp, struct device_node ***nextp)
 }
 
 #ifdef CONFIG_SMP
-
-void leon_set_cpu_int(int cpu, int level)
-{
-	unsigned long mask;
-	mask = get_irqmask(level);
-	LEON3_BYPASS_STORE_PA(&leon3_irqctrl_regs->force[cpu], mask);
-}
-
 void leon_clear_profile_irq(int cpu)
 {
 }
@@ -512,7 +504,7 @@ void leon_clear_profile_irq(int cpu)
 void leon_enable_irq_cpu(unsigned int irq_nr, unsigned int cpu)
 {
 	unsigned long mask, flags, *addr;
-	mask = get_irqmask(irq_nr);
+	mask = leon_get_irqmask(irq_nr);
 	spin_lock_irqsave(&leon_irq_lock, flags);
 	addr = (unsigned long *)LEON_IMASK(cpu);
 	LEON3_BYPASS_STORE_PA(addr, (LEON3_BYPASS_LOAD_PA(addr) | mask));
@@ -531,11 +523,6 @@ void __init leon_init_IRQ(void)
 			BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(load_profile_irq, leon_load_profile_irq,
 			BTFIXUPCALL_NOP);
-
-#ifdef CONFIG_SMP
-	BTFIXUPSET_CALL(set_cpu_int, leon_set_cpu_int, BTFIXUPCALL_NORM);
-#endif
-
 }
 
 void __init leon_init(void)
diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
index faff792..29325ba 100644
--- a/arch/sparc/kernel/leon_smp.c
+++ b/arch/sparc/kernel/leon_smp.c
@@ -346,6 +346,13 @@ static void __init leon_ipi_init(void)
 	}
 }
 
+static void leon_send_ipi(int cpu, int level)
+{
+	unsigned long mask;
+	mask = leon_get_irqmask(level);
+	LEON3_BYPASS_STORE_PA(&leon3_irqctrl_regs->force[cpu], mask);
+}
+
 static void leon_ipi_single(int cpu)
 {
 	struct leon_ipi_work *work = &per_cpu(leon_ipi_work, cpu);
@@ -354,7 +361,7 @@ static void leon_ipi_single(int cpu)
 	work->single = 1;
 
 	/* Generate IRQ on the CPU */
-	set_cpu_int(cpu, leon_ipi_irq);
+	leon_send_ipi(cpu, leon_ipi_irq);
 }
 
 static void leon_ipi_mask_one(int cpu)
@@ -365,7 +372,7 @@ static void leon_ipi_mask_one(int cpu)
 	work->msk = 1;
 
 	/* Generate IRQ on the CPU */
-	set_cpu_int(cpu, leon_ipi_irq);
+	leon_send_ipi(cpu, leon_ipi_irq);
 }
 
 static void leon_ipi_resched(int cpu)
@@ -376,7 +383,7 @@ static void leon_ipi_resched(int cpu)
 	work->resched = 1;
 
 	/* Generate IRQ on the CPU (any IRQ will cause resched) */
-	set_cpu_int(cpu, leon_ipi_irq);
+	leon_send_ipi(cpu, leon_ipi_irq);
 }
 
 void leonsmp_ipi_interrupt(void)
@@ -448,7 +455,7 @@ static void leon_cross_call(smpfunc_t func, cpumask_t mask, unsigned long arg1,
 				if (cpumask_test_cpu(i, &mask)) {
 					ccall_info.processors_in[i] = 0;
 					ccall_info.processors_out[i] = 0;
-					set_cpu_int(i, LEON3_IRQ_CROSS_CALL);
+					leon_send_ipi(i, LEON3_IRQ_CROSS_CALL);
 
 				}
 			}
@@ -491,15 +498,19 @@ void leon_cross_call_irq(void)
 	ccall_info.processors_out[i] = 1;
 }
 
+static const struct sparc32_ipi_ops leon_ipi_ops = {
+	.cross_call = leon_cross_call,
+	.resched    = leon_ipi_resched,
+	.single     = leon_ipi_single,
+	.mask_one   = leon_ipi_mask_one,
+};
+
 void __init leon_init_smp(void)
 {
 	/* Patch ipi15 trap table */
 	t_nmi[1] = t_nmi[1] + (linux_trap_ipi15_leon - linux_trap_ipi15_sun4m);
 
-	BTFIXUPSET_CALL(smp_cross_call, leon_cross_call, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(smp_ipi_resched, leon_ipi_resched, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(smp_ipi_single, leon_ipi_single, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(smp_ipi_mask_one, leon_ipi_mask_one, BTFIXUPCALL_NORM);
+	sparc32_ipi_ops = &leon_ipi_ops;
 }
 
 #endif /* CONFIG_SPARC_LEON */
diff --git a/arch/sparc/kernel/smp_32.c b/arch/sparc/kernel/smp_32.c
index 8cd5c79..5771375 100644
--- a/arch/sparc/kernel/smp_32.c
+++ b/arch/sparc/kernel/smp_32.c
@@ -40,6 +40,8 @@ volatile unsigned long cpu_callin_map[NR_CPUS] __cpuinitdata = {0,};
 
 cpumask_t smp_commenced_mask = CPU_MASK_NONE;
 
+const struct sparc32_ipi_ops *sparc32_ipi_ops;
+
 /* The only guaranteed locking primitive available on all Sparc
  * processors is 'ldstub [%reg + immediate], %dest_reg' which atomically
  * places the current byte at the effective address into dest_reg and
@@ -124,7 +126,7 @@ void smp_send_reschedule(int cpu)
 	 * a single CPU. The trap handler needs only to do trap entry/return
 	 * to call schedule.
 	 */
-	BTFIXUP_CALL(smp_ipi_resched)(cpu);
+	sparc32_ipi_ops->resched(cpu);
 }
 
 void smp_send_stop(void)
@@ -134,7 +136,7 @@ void smp_send_stop(void)
 void arch_send_call_function_single_ipi(int cpu)
 {
 	/* trigger one IPI single call on one CPU */
-	BTFIXUP_CALL(smp_ipi_single)(cpu);
+	sparc32_ipi_ops->single(cpu);
 }
 
 void arch_send_call_function_ipi_mask(const struct cpumask *mask)
@@ -143,7 +145,7 @@ void arch_send_call_function_ipi_mask(const struct cpumask *mask)
 
 	/* trigger IPI mask call on each CPU */
 	for_each_cpu(cpu, mask)
-		BTFIXUP_CALL(smp_ipi_mask_one)(cpu);
+		sparc32_ipi_ops->mask_one(cpu);
 }
 
 void smp_resched_interrupt(void)
diff --git a/arch/sparc/kernel/sun4d_irq.c b/arch/sparc/kernel/sun4d_irq.c
index b2fdb3d..e8e4f14 100644
--- a/arch/sparc/kernel/sun4d_irq.c
+++ b/arch/sparc/kernel/sun4d_irq.c
@@ -244,11 +244,6 @@ struct irq_chip sun4d_irq = {
 };
 
 #ifdef CONFIG_SMP
-static void sun4d_set_cpu_int(int cpu, int level)
-{
-	sun4d_send_ipi(cpu, level);
-}
-
 /* Setup IRQ distribution scheme. */
 void __init sun4d_distribute_irqs(void)
 {
@@ -518,8 +513,5 @@ void __init sun4d_init_IRQ(void)
 	sparc_config.build_device_irq = sun4d_build_device_irq;
 	sparc_config.clock_rate       = SBUS_CLOCK_RATE;
 
-#ifdef CONFIG_SMP
-	BTFIXUPSET_CALL(set_cpu_int, sun4d_set_cpu_int, BTFIXUPCALL_NORM);
-#endif
 	/* Cannot enable interrupts until OBP ticker is disabled. */
 }
diff --git a/arch/sparc/kernel/sun4d_smp.c b/arch/sparc/kernel/sun4d_smp.c
index 38ca0aa..f9a1a33 100644
--- a/arch/sparc/kernel/sun4d_smp.c
+++ b/arch/sparc/kernel/sun4d_smp.c
@@ -235,7 +235,20 @@ void sun4d_ipi_interrupt(void)
 	}
 }
 
-static void smp4d_ipi_single(int cpu)
+/* +-------+-------------+-----------+------------------------------------+
+ * | bcast |  devid      |   sid     |              levels mask           |
+ * +-------+-------------+-----------+------------------------------------+
+ *  31      30         23 22       15 14                                 0
+ */
+#define IGEN_MESSAGE(bcast, devid, sid, levels) \
+	(((bcast) << 31) | ((devid) << 23) | ((sid) << 15) | (levels))
+
+static void sun4d_send_ipi(int cpu, int level)
+{
+	cc_set_igen(IGEN_MESSAGE(0, cpu << 3, 6 + ((level >> 1) & 7), 1 << (level - 1)));
+}
+
+static void sun4d_ipi_single(int cpu)
 {
 	struct sun4d_ipi_work *work = &per_cpu(sun4d_ipi_work, cpu);
 
@@ -246,7 +259,7 @@ static void smp4d_ipi_single(int cpu)
 	sun4d_send_ipi(cpu, SUN4D_IPI_IRQ);
 }
 
-static void smp4d_ipi_mask_one(int cpu)
+static void sun4d_ipi_mask_one(int cpu)
 {
 	struct sun4d_ipi_work *work = &per_cpu(sun4d_ipi_work, cpu);
 
@@ -257,7 +270,7 @@ static void smp4d_ipi_mask_one(int cpu)
 	sun4d_send_ipi(cpu, SUN4D_IPI_IRQ);
 }
 
-static void smp4d_ipi_resched(int cpu)
+static void sun4d_ipi_resched(int cpu)
 {
 	struct sun4d_ipi_work *work = &per_cpu(sun4d_ipi_work, cpu);
 
@@ -282,7 +295,7 @@ static struct smp_funcall {
 static DEFINE_SPINLOCK(cross_call_lock);
 
 /* Cross calls must be serialized, at least currently. */
-static void smp4d_cross_call(smpfunc_t func, cpumask_t mask, unsigned long arg1,
+static void sun4d_cross_call(smpfunc_t func, cpumask_t mask, unsigned long arg1,
 			     unsigned long arg2, unsigned long arg3,
 			     unsigned long arg4)
 {
@@ -391,6 +404,13 @@ void smp4d_percpu_timer_interrupt(struct pt_regs *regs)
 	set_irq_regs(old_regs);
 }
 
+static const struct sparc32_ipi_ops sun4d_ipi_ops = {
+	.cross_call = sun4d_cross_call,
+	.resched    = sun4d_ipi_resched,
+	.single     = sun4d_ipi_single,
+	.mask_one   = sun4d_ipi_mask_one,
+};
+
 void __init sun4d_init_smp(void)
 {
 	int i;
@@ -398,11 +418,7 @@ void __init sun4d_init_smp(void)
 	/* Patch ipi15 trap table */
 	t_nmi[1] = t_nmi[1] + (linux_trap_ipi15_sun4d - linux_trap_ipi15_sun4m);
 
-	/* And set btfixup... */
-	BTFIXUPSET_CALL(smp_cross_call, smp4d_cross_call, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(smp_ipi_resched, smp4d_ipi_resched, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(smp_ipi_single, smp4d_ipi_single, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(smp_ipi_mask_one, smp4d_ipi_mask_one, BTFIXUPCALL_NORM);
+	sparc32_ipi_ops = &sun4d_ipi_ops;
 
 	for (i = 0; i < NR_CPUS; i++) {
 		ccall_info.processors_in[i] = 1;
diff --git a/arch/sparc/kernel/sun4m_irq.c b/arch/sparc/kernel/sun4m_irq.c
index 32d3a5c..eb2c277 100644
--- a/arch/sparc/kernel/sun4m_irq.c
+++ b/arch/sparc/kernel/sun4m_irq.c
@@ -112,9 +112,6 @@ struct sun4m_handler_data {
 #define SUN4M_INT_E14		0x00000080
 #define SUN4M_INT_E10		0x00080000
 
-#define SUN4M_HARD_INT(x)	(0x000000001 << (x))
-#define SUN4M_SOFT_INT(x)	(0x000010000 << (x))
-
 #define	SUN4M_INT_MASKALL	0x80000000	  /* mask all interrupts */
 #define	SUN4M_INT_MODULE_ERR	0x40000000	  /* module error */
 #define	SUN4M_INT_M2S_WRITE_ERR	0x20000000	  /* write buffer error */
@@ -282,13 +279,6 @@ out:
 	return irq;
 }
 
-#ifdef CONFIG_SMP
-static void sun4m_send_ipi(int cpu, int level)
-{
-	sbus_writel(SUN4M_SOFT_INT(level), &sun4m_irq_percpu[cpu]->set);
-}
-#endif
-
 struct sun4m_timer_percpu {
 	u32		l14_limit;
 	u32		l14_count;
@@ -479,9 +469,5 @@ void __init sun4m_init_IRQ(void)
 	sparc_config.build_device_irq = sun4m_build_device_irq;
 	sparc_config.clock_rate       = SBUS_CLOCK_RATE;
 
-#ifdef CONFIG_SMP
-	BTFIXUPSET_CALL(set_cpu_int, sun4m_send_ipi, BTFIXUPCALL_NORM);
-#endif
-
 	/* Cannot enable interrupts until OBP ticker is disabled. */
 }
diff --git a/arch/sparc/kernel/sun4m_smp.c b/arch/sparc/kernel/sun4m_smp.c
index ff74d33..ee21c43 100644
--- a/arch/sparc/kernel/sun4m_smp.c
+++ b/arch/sparc/kernel/sun4m_smp.c
@@ -34,8 +34,6 @@ swap_ulong(volatile unsigned long *ptr, unsigned long val)
 	return val;
 }
 
-static void smp4m_ipi_init(void);
-
 void __cpuinit smp4m_callin(void)
 {
 	int cpuid = hard_smp_processor_id();
@@ -88,7 +86,6 @@ void __cpuinit smp4m_callin(void)
  */
 void __init smp4m_boot_cpus(void)
 {
-	smp4m_ipi_init();
 	sun4m_unmask_profile_irq();
 	local_ops->cache_all();
 }
@@ -156,25 +153,24 @@ void __init smp4m_smp_done(void)
 	/* Ok, they are spinning and ready to go. */
 }
 
-
-/* Initialize IPIs on the SUN4M SMP machine */
-static void __init smp4m_ipi_init(void)
+static void sun4m_send_ipi(int cpu, int level)
 {
+	sbus_writel(SUN4M_SOFT_INT(level), &sun4m_irq_percpu[cpu]->set);
 }
 
-static void smp4m_ipi_resched(int cpu)
+static void sun4m_ipi_resched(int cpu)
 {
-	set_cpu_int(cpu, IRQ_IPI_RESCHED);
+	sun4m_send_ipi(cpu, IRQ_IPI_RESCHED);
 }
 
-static void smp4m_ipi_single(int cpu)
+static void sun4m_ipi_single(int cpu)
 {
-	set_cpu_int(cpu, IRQ_IPI_SINGLE);
+	sun4m_send_ipi(cpu, IRQ_IPI_SINGLE);
 }
 
-static void smp4m_ipi_mask_one(int cpu)
+static void sun4m_ipi_mask_one(int cpu)
 {
-	set_cpu_int(cpu, IRQ_IPI_MASK);
+	sun4m_send_ipi(cpu, IRQ_IPI_MASK);
 }
 
 static struct smp_funcall {
@@ -191,7 +187,7 @@ static struct smp_funcall {
 static DEFINE_SPINLOCK(cross_call_lock);
 
 /* Cross calls must be serialized, at least currently. */
-static void smp4m_cross_call(smpfunc_t func, cpumask_t mask, unsigned long arg1,
+static void sun4m_cross_call(smpfunc_t func, cpumask_t mask, unsigned long arg1,
 			     unsigned long arg2, unsigned long arg3,
 			     unsigned long arg4)
 {
@@ -218,7 +214,7 @@ static void smp4m_cross_call(smpfunc_t func, cpumask_t mask, unsigned long arg1,
 				if (cpumask_test_cpu(i, &mask)) {
 					ccall_info.processors_in[i] = 0;
 					ccall_info.processors_out[i] = 0;
-					set_cpu_int(i, IRQ_CROSS_CALL);
+					sun4m_send_ipi(i, IRQ_CROSS_CALL);
 				} else {
 					ccall_info.processors_in[i] = 1;
 					ccall_info.processors_out[i] = 1;
@@ -281,10 +277,14 @@ void smp4m_percpu_timer_interrupt(struct pt_regs *regs)
 	set_irq_regs(old_regs);
 }
 
+static const struct sparc32_ipi_ops sun4m_ipi_ops = {
+	.cross_call = sun4m_cross_call,
+	.resched    = sun4m_ipi_resched,
+	.single     = sun4m_ipi_single,
+	.mask_one   = sun4m_ipi_mask_one,
+};
+
 void __init sun4m_init_smp(void)
 {
-	BTFIXUPSET_CALL(smp_cross_call, smp4m_cross_call, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(smp_ipi_resched, smp4m_ipi_resched, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(smp_ipi_single, smp4m_ipi_single, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(smp_ipi_mask_one, smp4m_ipi_mask_one, BTFIXUPCALL_NORM);
+	sparc32_ipi_ops = &sun4m_ipi_ops;
 }
-- 
1.6.0.6

