From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 27 Apr 2011 13:19:37 +0000
Subject: [PATCH 1/3] sparc32: implement SMP IPIs using the generic functions
Message-Id: <1303910379-32209-1-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The current sparc32 SMP IPI generation is implemented the
cross call function. The cross call function uses IRQ15 the
NMI, this is has the effect that IPIs will interrupt IRQ
critical areas and hang the system. Typically on/after
spin_lock_irqsave calls can be aborted.

The cross call functionality must still exist to flush
cache/TLBS.

This patch provides CPU models a custom way to implement
generation of IPIs on the generic code's request. The
typical approach is to generate an IRQ for each IPI case.

After this patch each sparc32 SMP CPU model needs to
implement IPIs in order to function properly.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/Kconfig                  |    3 +-
 arch/sparc/include/asm/cpudata_32.h |    5 +++
 arch/sparc/include/asm/smp_32.h     |   22 ++++++---------
 arch/sparc/kernel/irq_32.c          |   10 +++++++
 arch/sparc/kernel/smp_32.c          |   47 ++++++++++++++++++++++++++++++++++-
 5 files changed, 71 insertions(+), 16 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 59e0c72..ebc8938 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -28,7 +28,7 @@ config SPARC
 	select HAVE_GENERIC_HARDIRQS
 	select GENERIC_HARDIRQS_NO_DEPRECATED
 	select GENERIC_IRQ_SHOW
-
+	select USE_GENERIC_SMP_HELPERS if SMP
 
 config SPARC32
 	def_bool !64BIT
@@ -47,7 +47,6 @@ config SPARC64
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_SYSCALL_TRACEPOINTS
-	select USE_GENERIC_SMP_HELPERS if SMP
 	select RTC_DRV_CMOS
 	select RTC_DRV_BQ4802
 	select RTC_DRV_SUN4V
diff --git a/arch/sparc/include/asm/cpudata_32.h b/arch/sparc/include/asm/cpudata_32.h
index 31d48a0..a4c5a93 100644
--- a/arch/sparc/include/asm/cpudata_32.h
+++ b/arch/sparc/include/asm/cpudata_32.h
@@ -16,6 +16,10 @@ typedef struct {
 	unsigned long clock_tick;
 	unsigned int multiplier;
 	unsigned int counter;
+#ifdef CONFIG_SMP
+	unsigned int irq_resched_count;
+	unsigned int irq_call_count;
+#endif
 	int prom_node;
 	int mid;
 	int next;
@@ -23,5 +27,6 @@ typedef struct {
 
 DECLARE_PER_CPU(cpuinfo_sparc, __cpu_data);
 #define cpu_data(__cpu) per_cpu(__cpu_data, (__cpu))
+#define local_cpu_data() __get_cpu_var(__cpu_data)
 
 #endif /* _SPARC_CPUDATA_H */
diff --git a/arch/sparc/include/asm/smp_32.h b/arch/sparc/include/asm/smp_32.h
index d82d7f4..d01a014 100644
--- a/arch/sparc/include/asm/smp_32.h
+++ b/arch/sparc/include/asm/smp_32.h
@@ -50,12 +50,19 @@ void smp_callin(void);
 void smp_boot_cpus(void);
 void smp_store_cpu_info(int);
 
+void smp_resched_interrupt(void);
+void smp_call_function_single_interrupt(void);
+void smp_call_function_interrupt(void);
+
 struct seq_file;
 void smp_bogo(struct seq_file *);
 void smp_info(struct seq_file *);
 
 BTFIXUPDEF_CALL(void, smp_cross_call, smpfunc_t, cpumask_t, unsigned long, unsigned long, unsigned long, unsigned long)
 BTFIXUPDEF_CALL(int, __hard_smp_processor_id, void)
+BTFIXUPDEF_CALL(void, smp_ipi_resched, int);
+BTFIXUPDEF_CALL(void, smp_ipi_single, int);
+BTFIXUPDEF_CALL(void, smp_ipi_mask_one, int);
 BTFIXUPDEF_BLACKBOX(hard_smp_processor_id)
 BTFIXUPDEF_BLACKBOX(load_current)
 
@@ -73,19 +80,8 @@ static inline void xc4(smpfunc_t func, unsigned long arg1, unsigned long arg2,
 			   unsigned long arg3, unsigned long arg4)
 { smp_cross_call(func, cpu_online_map, arg1, arg2, arg3, arg4); }
 
-static inline int smp_call_function(void (*func)(void *info), void *info, int wait)
-{
-	xc1((smpfunc_t)func, (unsigned long)info);
-	return 0;
-}
-
-static inline int smp_call_function_single(int cpuid, void (*func) (void *info),
-					   void *info, int wait)
-{
-	smp_cross_call((smpfunc_t)func, cpumask_of_cpu(cpuid),
-		       (unsigned long) info, 0, 0, 0);
-	return 0;
-}
+extern void arch_send_call_function_single_ipi(int cpu);
+extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
 
 static inline int cpu_logical_map(int cpu)
 {
diff --git a/arch/sparc/kernel/irq_32.c b/arch/sparc/kernel/irq_32.c
index 197e1ba..9b89d84 100644
--- a/arch/sparc/kernel/irq_32.c
+++ b/arch/sparc/kernel/irq_32.c
@@ -206,6 +206,16 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 {
 	int j;
 
+#ifdef CONFIG_SMP
+	seq_printf(p, "RES: ");
+	for_each_online_cpu(j)
+		seq_printf(p, "%10u ", cpu_data(j).irq_resched_count);
+	seq_printf(p, "     IPI rescheduling interrupts\n");
+	seq_printf(p, "CAL: ");
+	for_each_online_cpu(j)
+		seq_printf(p, "%10u ", cpu_data(j).irq_call_count);
+	seq_printf(p, "     IPI function call interrupts\n");
+#endif
 	seq_printf(p, "NMI: ");
 	for_each_online_cpu(j)
 		seq_printf(p, "%10u ", cpu_data(j).counter);
diff --git a/arch/sparc/kernel/smp_32.c b/arch/sparc/kernel/smp_32.c
index 4a1d5b7..2710602 100644
--- a/arch/sparc/kernel/smp_32.c
+++ b/arch/sparc/kernel/smp_32.c
@@ -123,13 +123,58 @@ struct linux_prom_registers smp_penguin_ctable __cpuinitdata = { 0 };
 
 void smp_send_reschedule(int cpu)
 {
-	/* See sparc64 */
+	/*
+	 * CPU model dependent way of implementing IPI generation targeting
+	 * a single CPU. The trap handler needs only to do trap entry/return
+	 * to call schedule.
+	 */
+	BTFIXUP_CALL(smp_ipi_resched)(cpu);
 }
 
 void smp_send_stop(void)
 {
 }
 
+void arch_send_call_function_single_ipi(int cpu)
+{
+	/* trigger one IPI single call on one CPU */
+	BTFIXUP_CALL(smp_ipi_single)(cpu);
+}
+
+void arch_send_call_function_ipi_mask(const struct cpumask *mask)
+{
+	int cpu;
+
+	/* trigger IPI mask call on each CPU */
+	for_each_cpu(cpu, mask)
+		BTFIXUP_CALL(smp_ipi_mask_one)(cpu);
+}
+
+void smp_resched_interrupt(void)
+{
+	local_cpu_data().irq_resched_count++;
+	/*
+	 * do nothing, since it all was about calling re-schedule
+	 * routine called by interrupt return code.
+	 */
+}
+
+void smp_call_function_single_interrupt(void)
+{
+	irq_enter();
+	generic_smp_call_function_single_interrupt();
+	local_cpu_data().irq_call_count++;
+	irq_exit();
+}
+
+void smp_call_function_interrupt(void)
+{
+	irq_enter();
+	generic_smp_call_function_interrupt();
+	local_cpu_data().irq_call_count++;
+	irq_exit();
+}
+
 void smp_flush_cache_all(void)
 {
 	xc0((smpfunc_t) BTFIXUP_CALL(local_flush_cache_all));
-- 
1.5.4

