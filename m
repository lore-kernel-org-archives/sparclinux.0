From: Vijay Kumar <vijay.ac.kumar@oracle.com>
Date: Sat, 08 Jul 2017 20:23:44 +0000
Subject: [PATCH 2/2] sparc64: Use cpu_poke to resume idle cpu
Message-Id: <1499545424-415240-3-git-send-email-vijay.ac.kumar@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1499545424-415240-1-git-send-email-vijay.ac.kumar@oracle.com>
In-Reply-To: <1499545424-415240-1-git-send-email-vijay.ac.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, sparclinux@vger.kernel.org
Cc: rob.gardner@oracle.com, anthony.yznaga@oracle.com, linux-kernel@vger.kernel.org

Use cpu_poke hypervisor call to resume idle cpu if supported.

Signed-off-by: Vijay Kumar <vijay.ac.kumar@oracle.com>
Reviewed-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 arch/sparc/include/asm/smp_64.h |    5 ++
 arch/sparc/kernel/hvapi.c       |    2 +-
 arch/sparc/kernel/process_64.c  |    7 +++-
 arch/sparc/kernel/setup_64.c    |    1 +
 arch/sparc/kernel/smp_64.c      |   80 +++++++++++++++++++++++++++++++++++++-
 5 files changed, 90 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/include/asm/smp_64.h b/arch/sparc/include/asm/smp_64.h
index ce2233f..a750892 100644
--- a/arch/sparc/include/asm/smp_64.h
+++ b/arch/sparc/include/asm/smp_64.h
@@ -33,6 +33,9 @@
 DECLARE_PER_CPU(cpumask_t, cpu_sibling_map);
 extern cpumask_t cpu_core_map[NR_CPUS];
 
+void smp_init_cpu_poke(void);
+void scheduler_poke(void);
+
 void arch_send_call_function_single_ipi(int cpu);
 void arch_send_call_function_ipi_mask(const struct cpumask *mask);
 
@@ -74,6 +77,8 @@
 #define smp_fetch_global_regs() do { } while (0)
 #define smp_fetch_global_pmu() do { } while (0)
 #define smp_fill_in_cpu_possible_map() do { } while (0)
+#define smp_init_cpu_poke() do { } while (0)
+#define scheduler_poke() do { } while (0)
 
 #endif /* !(CONFIG_SMP) */
 
diff --git a/arch/sparc/kernel/hvapi.c b/arch/sparc/kernel/hvapi.c
index 2677312..0b070d5 100644
--- a/arch/sparc/kernel/hvapi.c
+++ b/arch/sparc/kernel/hvapi.c
@@ -189,7 +189,7 @@ void __init sun4v_hvapi_init(void)
 
 	group = HV_GRP_CORE;
 	major = 1;
-	minor = 1;
+	minor = 6; /* CPU POKE */
 	if (sun4v_hvapi_register(group, major, &minor))
 		goto bad;
 
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index 1badc49..92448af 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -77,8 +77,13 @@ void arch_cpu_idle(void)
 			: "=&r" (pstate)
 			: "i" (PSTATE_IE));
 
-		if (!need_resched() && !cpu_is_offline(smp_processor_id()))
+		if (!need_resched() && !cpu_is_offline(smp_processor_id())) {
 			sun4v_cpu_yield();
+			/* If resumed by cpu_poke then we need to explicitly
+			 * call scheduler_ipi().
+			 */
+			scheduler_poke();
+		}
 
 		/* Re-enable interrupts. */
 		__asm__ __volatile__(
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 422b178..4ff9fd8 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -356,6 +356,7 @@ void __init start_early_boot(void)
 	check_if_starfire();
 	per_cpu_patch();
 	sun4v_patch();
+	smp_init_cpu_poke();
 
 	cpu = hard_smp_processor_id();
 	if (cpu >= NR_CPUS) {
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index fdf3104..9c3131b 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -74,6 +74,9 @@
 
 static cpumask_t smp_commenced_mask;
 
+static DEFINE_PER_CPU(bool, poke);
+static bool cpu_poke;
+
 void smp_info(struct seq_file *m)
 {
 	int i;
@@ -1394,15 +1397,86 @@ void __init smp_cpus_done(unsigned int max_cpus)
 {
 }
 
+static void send_cpu_ipi(int cpu)
+{
+	xcall_deliver((u64) &xcall_receive_signal,
+			0, 0, cpumask_of(cpu));
+}
+
+void scheduler_poke(void)
+{
+	if (!cpu_poke)
+		return;
+
+	if (!__this_cpu_read(poke))
+		return;
+
+	__this_cpu_write(poke, false);
+	set_softint(1 << PIL_SMP_RECEIVE_SIGNAL);
+}
+
+static unsigned long send_cpu_poke(int cpu)
+{
+	unsigned long hv_err;
+
+	per_cpu(poke, cpu) = true;
+	hv_err = sun4v_cpu_poke(cpu);
+	if (hv_err != HV_EOK) {
+		per_cpu(poke, cpu) = false;
+		pr_err_ratelimited("%s: sun4v_cpu_poke() fails err=%lu\n",
+				    __func__, hv_err);
+	}
+
+	return hv_err;
+}
+
 void smp_send_reschedule(int cpu)
 {
 	if (cpu = smp_processor_id()) {
 		WARN_ON_ONCE(preemptible());
 		set_softint(1 << PIL_SMP_RECEIVE_SIGNAL);
-	} else {
-		xcall_deliver((u64) &xcall_receive_signal,
-			      0, 0, cpumask_of(cpu));
+		return;
+	}
+
+	/* Use cpu poke to resume idle cpu if supported*/
+	if (cpu_poke && idle_cpu(cpu)) {
+		unsigned long ret;
+
+		ret = send_cpu_poke(cpu);
+		if (ret = HV_EOK)
+			return;
 	}
+
+	/* Use IPI in following cases:
+	 * - cpu poke not supported
+	 * - cpu not idle
+	 * - send_cpu_poke() returns with error.
+	 */
+	send_cpu_ipi(cpu);
+}
+
+void smp_init_cpu_poke(void)
+{
+	unsigned long major;
+	unsigned long minor;
+	int ret;
+
+	if (tlb_type != hypervisor)
+		return;
+
+	ret = sun4v_hvapi_get(HV_GRP_CORE, &major, &minor);
+	if (ret) {
+		pr_debug("HV_GRP_CORE is not registered\n");
+		return;
+	}
+
+	if (major = 1 && minor >= 6) {
+		/*cpu poke is registered. */
+		cpu_poke = true;
+		return;
+	}
+
+	pr_debug("CPU_POKE not supported\n");
 }
 
 void __irq_entry smp_receive_signal_client(int irq, struct pt_regs *regs)
-- 
1.7.1

