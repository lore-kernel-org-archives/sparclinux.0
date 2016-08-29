From: Chris Metcalf <cmetcalf@mellanox.com>
Date: Mon, 29 Aug 2016 16:12:46 +0000
Subject: [PATCH v9 1/4] nmi_backtrace: add more trigger_*_cpu_backtrace() methods
Message-Id: <1472487169-14923-2-git-send-email-cmetcalf@mellanox.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1472487169-14923-1-git-send-email-cmetcalf@mellanox.com>
In-Reply-To: <1472487169-14923-1-git-send-email-cmetcalf@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Currently you can only request a backtrace of either all cpus, or
all cpus but yourself.  It can also be helpful to request a remote
backtrace of a single cpu, and since we want that, the logical
extension is to support a cpumask as the underlying primitive.

This change modifies the existing lib/nmi_backtrace.c code to take
a cpumask as its basic primitive, and modifies the linux/nmi.h code
to use the new "cpumask" method instead.

The existing clients of nmi_backtrace (arm and x86) are converted
to using the new cpumask approach in this change.

The other users of the backtracing API (sparc64 and mips) are converted
to use the cpumask approach rather than the all/allbutself approach.
The mips code ignored the "include_self" boolean but with this change
it will now also dump a local backtrace if requested.

Signed-off-by: Chris Metcalf <cmetcalf@mellanox.com>
Reviewed-by: Aaron Tomlin <atomlin@redhat.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Daniel Thompson <daniel.thompson@linaro.org> [arm]
---
 arch/arm/include/asm/irq.h      |  5 +++--
 arch/arm/kernel/smp.c           |  4 ++--
 arch/mips/include/asm/irq.h     |  5 +++--
 arch/mips/kernel/process.c      | 11 +++++++++--
 arch/sparc/include/asm/irq_64.h |  5 +++--
 arch/sparc/kernel/process_64.c  | 10 +++++-----
 arch/x86/include/asm/irq.h      |  5 +++--
 arch/x86/kernel/apic/hw_nmi.c   | 18 +++++++++---------
 include/linux/nmi.h             | 31 ++++++++++++++++++++++++++-----
 lib/nmi_backtrace.c             | 17 +++++++++--------
 10 files changed, 72 insertions(+), 39 deletions(-)

diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
index 1bd9510de1b9..e53638c8ed8a 100644
--- a/arch/arm/include/asm/irq.h
+++ b/arch/arm/include/asm/irq.h
@@ -36,8 +36,9 @@ extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
 #endif
 
 #ifdef CONFIG_SMP
-extern void arch_trigger_all_cpu_backtrace(bool);
-#define arch_trigger_all_cpu_backtrace(x) arch_trigger_all_cpu_backtrace(x)
+extern void arch_trigger_cpumask_backtrace(const cpumask_t *mask,
+					   bool exclude_self);
+#define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
 #endif
 
 static inline int nr_legacy_irqs(void)
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 861521606c6d..2a367b2de0e1 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -760,7 +760,7 @@ static void raise_nmi(cpumask_t *mask)
 	smp_cross_call(mask, IPI_CPU_BACKTRACE);
 }
 
-void arch_trigger_all_cpu_backtrace(bool include_self)
+void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
 {
-	nmi_trigger_all_cpu_backtrace(include_self, raise_nmi);
+	nmi_trigger_cpumask_backtrace(mask, exclude_self, raise_nmi);
 }
diff --git a/arch/mips/include/asm/irq.h b/arch/mips/include/asm/irq.h
index 15e0fecbc300..6bf10e796553 100644
--- a/arch/mips/include/asm/irq.h
+++ b/arch/mips/include/asm/irq.h
@@ -51,7 +51,8 @@ extern int cp0_fdc_irq;
 
 extern int get_c0_fdc_int(void);
 
-void arch_trigger_all_cpu_backtrace(bool);
-#define arch_trigger_all_cpu_backtrace arch_trigger_all_cpu_backtrace
+void arch_trigger_cpumask_backtrace(const struct cpumask *mask,
+				    bool exclude_self);
+#define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
 
 #endif /* _ASM_IRQ_H */
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 7429ad09fbe3..fea1fa7726e3 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -569,9 +569,16 @@ static void arch_dump_stack(void *info)
 	dump_stack();
 }
 
-void arch_trigger_all_cpu_backtrace(bool include_self)
+void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
 {
-	smp_call_function(arch_dump_stack, NULL, 1);
+	long this_cpu = get_cpu();
+
+	if (cpumask_test_cpu(this_cpu, mask) && !exclude_self)
+		dump_stack();
+
+	smp_call_function_many(mask, arch_dump_stack, NULL, 1);
+
+	put_cpu();
 }
 
 int mips_get_process_fp_mode(struct task_struct *task)
diff --git a/arch/sparc/include/asm/irq_64.h b/arch/sparc/include/asm/irq_64.h
index 3f70f900e834..1d51a11fb261 100644
--- a/arch/sparc/include/asm/irq_64.h
+++ b/arch/sparc/include/asm/irq_64.h
@@ -86,8 +86,9 @@ static inline unsigned long get_softint(void)
 	return retval;
 }
 
-void arch_trigger_all_cpu_backtrace(bool);
-#define arch_trigger_all_cpu_backtrace arch_trigger_all_cpu_backtrace
+void arch_trigger_cpumask_backtrace(const struct cpumask *mask,
+				    bool exclude_self);
+#define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
 
 extern void *hardirq_stack[NR_CPUS];
 extern void *softirq_stack[NR_CPUS];
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index fa14402b33f9..47ff5588e521 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -239,7 +239,7 @@ static void __global_reg_poll(struct global_reg_snapshot *gp)
 	}
 }
 
-void arch_trigger_all_cpu_backtrace(bool include_self)
+void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
 {
 	struct thread_info *tp = current_thread_info();
 	struct pt_regs *regs = get_irq_regs();
@@ -255,15 +255,15 @@ void arch_trigger_all_cpu_backtrace(bool include_self)
 
 	memset(global_cpu_snapshot, 0, sizeof(global_cpu_snapshot));
 
-	if (include_self)
+	if (cpumask_test_cpu(this_cpu, mask) && !exclude_self)
 		__global_reg_self(tp, regs, this_cpu);
 
 	smp_fetch_global_regs();
 
-	for_each_online_cpu(cpu) {
+	for_each_cpu(cpu, mask) {
 		struct global_reg_snapshot *gp;
 
-		if (!include_self && cpu = this_cpu)
+		if (exclude_self && cpu = this_cpu)
 			continue;
 
 		gp = &global_cpu_snapshot[cpu].reg;
@@ -300,7 +300,7 @@ void arch_trigger_all_cpu_backtrace(bool include_self)
 
 static void sysrq_handle_globreg(int key)
 {
-	arch_trigger_all_cpu_backtrace(true);
+	trigger_all_cpu_backtrace();
 }
 
 static struct sysrq_key_op sparc_globalreg_op = {
diff --git a/arch/x86/include/asm/irq.h b/arch/x86/include/asm/irq.h
index e7de5c9a4fbd..16d3fa211962 100644
--- a/arch/x86/include/asm/irq.h
+++ b/arch/x86/include/asm/irq.h
@@ -50,8 +50,9 @@ extern int vector_used_by_percpu_irq(unsigned int vector);
 extern void init_ISA_irqs(void);
 
 #ifdef CONFIG_X86_LOCAL_APIC
-void arch_trigger_all_cpu_backtrace(bool);
-#define arch_trigger_all_cpu_backtrace arch_trigger_all_cpu_backtrace
+void arch_trigger_cpumask_backtrace(const struct cpumask *mask,
+				    bool exclude_self);
+#define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
 #endif
 
 #endif /* _ASM_X86_IRQ_H */
diff --git a/arch/x86/kernel/apic/hw_nmi.c b/arch/x86/kernel/apic/hw_nmi.c
index f29501e1a5c1..c73c9fb281e1 100644
--- a/arch/x86/kernel/apic/hw_nmi.c
+++ b/arch/x86/kernel/apic/hw_nmi.c
@@ -26,32 +26,32 @@ u64 hw_nmi_get_sample_period(int watchdog_thresh)
 }
 #endif
 
-#ifdef arch_trigger_all_cpu_backtrace
+#ifdef arch_trigger_cpumask_backtrace
 static void nmi_raise_cpu_backtrace(cpumask_t *mask)
 {
 	apic->send_IPI_mask(mask, NMI_VECTOR);
 }
 
-void arch_trigger_all_cpu_backtrace(bool include_self)
+void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
 {
-	nmi_trigger_all_cpu_backtrace(include_self, nmi_raise_cpu_backtrace);
+	nmi_trigger_cpumask_backtrace(mask, exclude_self,
+				      nmi_raise_cpu_backtrace);
 }
 
-static int
-arch_trigger_all_cpu_backtrace_handler(unsigned int cmd, struct pt_regs *regs)
+static int nmi_cpu_backtrace_handler(unsigned int cmd, struct pt_regs *regs)
 {
 	if (nmi_cpu_backtrace(regs))
 		return NMI_HANDLED;
 
 	return NMI_DONE;
 }
-NOKPROBE_SYMBOL(arch_trigger_all_cpu_backtrace_handler);
+NOKPROBE_SYMBOL(nmi_cpu_backtrace_handler);
 
-static int __init register_trigger_all_cpu_backtrace(void)
+static int __init register_nmi_cpu_backtrace_handler(void)
 {
-	register_nmi_handler(NMI_LOCAL, arch_trigger_all_cpu_backtrace_handler,
+	register_nmi_handler(NMI_LOCAL, nmi_cpu_backtrace_handler,
 				0, "arch_bt");
 	return 0;
 }
-early_initcall(register_trigger_all_cpu_backtrace);
+early_initcall(register_nmi_cpu_backtrace_handler);
 #endif
diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 4630eeae18e0..a78c35cff1ae 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -35,21 +35,34 @@ static inline void hardlockup_detector_disable(void) {}
  * base function. Return whether such support was available,
  * to allow calling code to fall back to some other mechanism:
  */
-#ifdef arch_trigger_all_cpu_backtrace
+#ifdef arch_trigger_cpumask_backtrace
 static inline bool trigger_all_cpu_backtrace(void)
 {
-	arch_trigger_all_cpu_backtrace(true);
-
+	arch_trigger_cpumask_backtrace(cpu_online_mask, false);
 	return true;
 }
+
 static inline bool trigger_allbutself_cpu_backtrace(void)
 {
-	arch_trigger_all_cpu_backtrace(false);
+	arch_trigger_cpumask_backtrace(cpu_online_mask, true);
+	return true;
+}
+
+static inline bool trigger_cpumask_backtrace(struct cpumask *mask)
+{
+	arch_trigger_cpumask_backtrace(mask, false);
+	return true;
+}
+
+static inline bool trigger_single_cpu_backtrace(int cpu)
+{
+	arch_trigger_cpumask_backtrace(cpumask_of(cpu), false);
 	return true;
 }
 
 /* generic implementation */
-void nmi_trigger_all_cpu_backtrace(bool include_self,
+void nmi_trigger_cpumask_backtrace(const cpumask_t *mask,
+				   bool exclude_self,
 				   void (*raise)(cpumask_t *mask));
 bool nmi_cpu_backtrace(struct pt_regs *regs);
 
@@ -62,6 +75,14 @@ static inline bool trigger_allbutself_cpu_backtrace(void)
 {
 	return false;
 }
+static inline bool trigger_cpumask_backtrace(struct cpumask *mask)
+{
+	return false;
+}
+static inline bool trigger_single_cpu_backtrace(int cpu)
+{
+	return false;
+}
 #endif
 
 #ifdef CONFIG_LOCKUP_DETECTOR
diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
index 26caf51cc238..df347e355267 100644
--- a/lib/nmi_backtrace.c
+++ b/lib/nmi_backtrace.c
@@ -17,20 +17,21 @@
 #include <linux/kprobes.h>
 #include <linux/nmi.h>
 
-#ifdef arch_trigger_all_cpu_backtrace
+#ifdef arch_trigger_cpumask_backtrace
 /* For reliability, we're prepared to waste bits here. */
 static DECLARE_BITMAP(backtrace_mask, NR_CPUS) __read_mostly;
 
-/* "in progress" flag of arch_trigger_all_cpu_backtrace */
+/* "in progress" flag of arch_trigger_cpumask_backtrace */
 static unsigned long backtrace_flag;
 
 /*
- * When raise() is called it will be is passed a pointer to the
+ * When raise() is called it will be passed a pointer to the
  * backtrace_mask. Architectures that call nmi_cpu_backtrace()
  * directly from their raise() functions may rely on the mask
  * they are passed being updated as a side effect of this call.
  */
-void nmi_trigger_all_cpu_backtrace(bool include_self,
+void nmi_trigger_cpumask_backtrace(const cpumask_t *mask,
+				   bool exclude_self,
 				   void (*raise)(cpumask_t *mask))
 {
 	int i, this_cpu = get_cpu();
@@ -44,13 +45,13 @@ void nmi_trigger_all_cpu_backtrace(bool include_self,
 		return;
 	}
 
-	cpumask_copy(to_cpumask(backtrace_mask), cpu_online_mask);
-	if (!include_self)
+	cpumask_copy(to_cpumask(backtrace_mask), mask);
+	if (exclude_self)
 		cpumask_clear_cpu(this_cpu, to_cpumask(backtrace_mask));
 
 	if (!cpumask_empty(to_cpumask(backtrace_mask))) {
-		pr_info("Sending NMI to %s CPUs:\n",
-			(include_self ? "all" : "other"));
+		pr_info("Sending NMI from CPU %d to CPUs %*pbl:\n",
+			this_cpu, nr_cpumask_bits, to_cpumask(backtrace_mask));
 		raise(to_cpumask(backtrace_mask));
 	}
 
-- 
2.7.2

