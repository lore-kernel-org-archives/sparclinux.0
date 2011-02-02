From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 02 Feb 2011 19:40:55 +0000
Subject: [PATCH 1/2 v2] sparc32: implement SMP IPIs using the generic functions
Message-Id: <1296675656-19165-1-git-send-email-daniel@gaisler.com>
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
 arch/sparc/Kconfig              |    2 +-
 arch/sparc/include/asm/smp_32.h |   15 ++-------------
 arch/sparc/kernel/smp_32.c      |   34 +++++++++++++++++++++++++++++++++-
 3 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index e48f471..cef291e 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -25,6 +25,7 @@ config SPARC
 	select HAVE_DMA_ATTRS
 	select HAVE_DMA_API_DEBUG
 	select HAVE_ARCH_JUMP_LABEL
+	select USE_GENERIC_SMP_HELPERS if SMP
 
 config SPARC32
 	def_bool !64BIT
@@ -43,7 +44,6 @@ config SPARC64
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_SYSCALL_TRACEPOINTS
-	select USE_GENERIC_SMP_HELPERS if SMP
 	select RTC_DRV_CMOS
 	select RTC_DRV_BQ4802
 	select RTC_DRV_SUN4V
diff --git a/arch/sparc/include/asm/smp_32.h b/arch/sparc/include/asm/smp_32.h
index d82d7f4..8390ef6 100644
--- a/arch/sparc/include/asm/smp_32.h
+++ b/arch/sparc/include/asm/smp_32.h
@@ -73,19 +73,8 @@ static inline void xc4(smpfunc_t func, unsigned long arg1, unsigned long arg2,
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
diff --git a/arch/sparc/kernel/smp_32.c b/arch/sparc/kernel/smp_32.c
index 91c10fb..a1bb3a8 100644
--- a/arch/sparc/kernel/smp_32.c
+++ b/arch/sparc/kernel/smp_32.c
@@ -125,13 +125,45 @@ struct linux_prom_registers smp_penguin_ctable __cpuinitdata = { 0 };
 
 void smp_send_reschedule(int cpu)
 {
-	/* See sparc64 */
+	/*
+	 * CPU model dependent way of implementing IPI generation targeting
+	 * a single CPU. The trap handler needs only to do trap entry/return
+	 * to call schedule.
+	 */
+	switch (sparc_cpu_model) {
+	default:
+		BUG();
+	}
 }
 
 void smp_send_stop(void)
 {
 }
 
+void arch_send_call_function_single_ipi(int cpu)
+{
+	/*
+	 * CPU model dependent way of implementing IPI generation targeting
+	 * a single CPU
+	 */
+	switch (sparc_cpu_model) {
+	default:
+		BUG();
+	}
+}
+
+void arch_send_call_function_ipi_mask(const struct cpumask *mask)
+{
+	/*
+	 * CPU model dependent way of implementing IPI generation targeting
+	 * a set of CPUs
+	 */
+	switch (sparc_cpu_model) {
+	default:
+		BUG();
+	}
+}
+
 void smp_flush_cache_all(void)
 {
 	xc0((smpfunc_t) BTFIXUP_CALL(local_flush_cache_all));
-- 
1.5.4

