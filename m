From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 29 Apr 2019 09:45:58 +0000
Subject: [PATCH V4] cpufreq: Call transition notifier only once for each policy
Message-Id: <dffefa5bee3d0a751dcf2d12c1d4cd6f166c23af.1556529864.git.viresh.kumar@linaro.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rafael Wysocki <rjw@rjwysocki.net>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, kvm@vger.kernel.org

Currently the notifiers are called once for each CPU of the policy->cpus
cpumask. It would be more optimal if the notifier can be called only
once and all the relevant information be provided to it. Out of the 23
drivers that register for the transition notifiers today, only 4 of them
do per-cpu updates and the callback for the rest can be called only once
for the policy without any impact.

This would also avoid multiple function calls to the notifier callbacks
and reduce multiple iterations of notifier core's code (which does
locking as well).

This patch adds pointer to the cpufreq policy to the struct
cpufreq_freqs, so the notifier callback has all the information
available to it with a single call. The five drivers which perform
per-cpu updates are updated to use the cpufreq policy. The freqs->cpu
field is redundant now and is removed.

Acked-by: David S. Miller <davem@davemloft.net> (sparc)
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V3->V4:
- rebased over pm/linux-next
- tsc.c's diff has changed due to rafael's patch present in
  pm/linux-next.
- Minor update in commit-log.

 arch/arm/kernel/smp.c       | 24 +++++++++++++++---------
 arch/sparc/kernel/time_64.c | 28 ++++++++++++++++------------
 arch/x86/kernel/tsc.c       |  2 +-
 arch/x86/kvm/x86.c          | 31 ++++++++++++++++++++-----------
 drivers/cpufreq/cpufreq.c   | 19 ++++++++++---------
 include/linux/cpufreq.h     | 14 +++++++-------
 6 files changed, 69 insertions(+), 49 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index facd4240ca02..c6d37563610a 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -754,15 +754,20 @@ static int cpufreq_callback(struct notifier_block *nb,
 					unsigned long val, void *data)
 {
 	struct cpufreq_freqs *freq = data;
-	int cpu = freq->cpu;
+	struct cpumask *cpus = freq->policy->cpus;
+	int cpu, first = cpumask_first(cpus);
+	unsigned int lpj;
 
 	if (freq->flags & CPUFREQ_CONST_LOOPS)
 		return NOTIFY_OK;
 
-	if (!per_cpu(l_p_j_ref, cpu)) {
-		per_cpu(l_p_j_ref, cpu) -			per_cpu(cpu_data, cpu).loops_per_jiffy;
-		per_cpu(l_p_j_ref_freq, cpu) = freq->old;
+	if (!per_cpu(l_p_j_ref, first)) {
+		for_each_cpu(cpu, cpus) {
+			per_cpu(l_p_j_ref, cpu) +				per_cpu(cpu_data, cpu).loops_per_jiffy;
+			per_cpu(l_p_j_ref_freq, cpu) = freq->old;
+		}
+
 		if (!global_l_p_j_ref) {
 			global_l_p_j_ref = loops_per_jiffy;
 			global_l_p_j_ref_freq = freq->old;
@@ -774,10 +779,11 @@ static int cpufreq_callback(struct notifier_block *nb,
 		loops_per_jiffy = cpufreq_scale(global_l_p_j_ref,
 						global_l_p_j_ref_freq,
 						freq->new);
-		per_cpu(cpu_data, cpu).loops_per_jiffy -			cpufreq_scale(per_cpu(l_p_j_ref, cpu),
-					per_cpu(l_p_j_ref_freq, cpu),
-					freq->new);
+
+		lpj = cpufreq_scale(per_cpu(l_p_j_ref, first),
+				    per_cpu(l_p_j_ref_freq, first), freq->new);
+		for_each_cpu(cpu, cpus)
+			per_cpu(cpu_data, cpu).loops_per_jiffy = lpj;
 	}
 	return NOTIFY_OK;
 }
diff --git a/arch/sparc/kernel/time_64.c b/arch/sparc/kernel/time_64.c
index 3eb77943ce12..89fb05f90609 100644
--- a/arch/sparc/kernel/time_64.c
+++ b/arch/sparc/kernel/time_64.c
@@ -653,19 +653,23 @@ static int sparc64_cpufreq_notifier(struct notifier_block *nb, unsigned long val
 				    void *data)
 {
 	struct cpufreq_freqs *freq = data;
-	unsigned int cpu = freq->cpu;
-	struct freq_table *ft = &per_cpu(sparc64_freq_table, cpu);
+	unsigned int cpu;
+	struct freq_table *ft;
 
-	if (!ft->ref_freq) {
-		ft->ref_freq = freq->old;
-		ft->clock_tick_ref = cpu_data(cpu).clock_tick;
-	}
-	if ((val = CPUFREQ_PRECHANGE  && freq->old < freq->new) ||
-	    (val = CPUFREQ_POSTCHANGE && freq->old > freq->new)) {
-		cpu_data(cpu).clock_tick -			cpufreq_scale(ft->clock_tick_ref,
-				      ft->ref_freq,
-				      freq->new);
+	for_each_cpu(cpu, freq->policy->cpus) {
+		ft = &per_cpu(sparc64_freq_table, cpu);
+
+		if (!ft->ref_freq) {
+			ft->ref_freq = freq->old;
+			ft->clock_tick_ref = cpu_data(cpu).clock_tick;
+		}
+
+		if ((val = CPUFREQ_PRECHANGE  && freq->old < freq->new) ||
+		    (val = CPUFREQ_POSTCHANGE && freq->old > freq->new)) {
+			cpu_data(cpu).clock_tick +				cpufreq_scale(ft->clock_tick_ref, ft->ref_freq,
+					      freq->new);
+		}
 	}
 
 	return 0;
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index cc6df5c6d7b3..650fafa6a4d0 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -976,7 +976,7 @@ static int time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
 		if (!(freq->flags & CPUFREQ_CONST_LOOPS))
 			mark_tsc_unstable("cpufreq changes");
 
-		set_cyc2ns_scale(tsc_khz, freq->cpu, rdtsc());
+		set_cyc2ns_scale(tsc_khz, freq->policy->cpu, rdtsc());
 	}
 
 	return 0;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a0d1fc80ac5a..55efbc1b0a56 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6677,10 +6677,8 @@ static void kvm_hyperv_tsc_notifier(void)
 }
 #endif
 
-static int kvmclock_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
-				     void *data)
+static void __kvmclock_cpufreq_notifier(struct cpufreq_freqs *freq, int cpu)
 {
-	struct cpufreq_freqs *freq = data;
 	struct kvm *kvm;
 	struct kvm_vcpu *vcpu;
 	int i, send_ipi = 0;
@@ -6724,17 +6722,12 @@ static int kvmclock_cpufreq_notifier(struct notifier_block *nb, unsigned long va
 	 *
 	 */
 
-	if (val = CPUFREQ_PRECHANGE && freq->old > freq->new)
-		return 0;
-	if (val = CPUFREQ_POSTCHANGE && freq->old < freq->new)
-		return 0;
-
-	smp_call_function_single(freq->cpu, tsc_khz_changed, freq, 1);
+	smp_call_function_single(cpu, tsc_khz_changed, freq, 1);
 
 	spin_lock(&kvm_lock);
 	list_for_each_entry(kvm, &vm_list, vm_list) {
 		kvm_for_each_vcpu(i, vcpu, kvm) {
-			if (vcpu->cpu != freq->cpu)
+			if (vcpu->cpu != cpu)
 				continue;
 			kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
 			if (vcpu->cpu != smp_processor_id())
@@ -6756,8 +6749,24 @@ static int kvmclock_cpufreq_notifier(struct notifier_block *nb, unsigned long va
 		 * guest context is entered kvmclock will be updated,
 		 * so the guest will not see stale values.
 		 */
-		smp_call_function_single(freq->cpu, tsc_khz_changed, freq, 1);
+		smp_call_function_single(cpu, tsc_khz_changed, freq, 1);
 	}
+}
+
+static int kvmclock_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
+				     void *data)
+{
+	struct cpufreq_freqs *freq = data;
+	int cpu;
+
+	if (val = CPUFREQ_PRECHANGE && freq->old > freq->new)
+		return 0;
+	if (val = CPUFREQ_POSTCHANGE && freq->old < freq->new)
+		return 0;
+
+	for_each_cpu(cpu, freq->policy->cpus)
+		__kvmclock_cpufreq_notifier(freq, cpu);
+
 	return 0;
 }
 
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 92604afdeec4..3681ec8d19f2 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -340,11 +340,14 @@ static void cpufreq_notify_transition(struct cpufreq_policy *policy,
 				      struct cpufreq_freqs *freqs,
 				      unsigned int state)
 {
+	int cpu;
+
 	BUG_ON(irqs_disabled());
 
 	if (cpufreq_disabled())
 		return;
 
+	freqs->policy = policy;
 	freqs->flags = cpufreq_driver->flags;
 	pr_debug("notification %u of frequency transition to %u kHz\n",
 		 state, freqs->new);
@@ -364,10 +367,8 @@ static void cpufreq_notify_transition(struct cpufreq_policy *policy,
 			}
 		}
 
-		for_each_cpu(freqs->cpu, policy->cpus) {
-			srcu_notifier_call_chain(&cpufreq_transition_notifier_list,
-						 CPUFREQ_PRECHANGE, freqs);
-		}
+		srcu_notifier_call_chain(&cpufreq_transition_notifier_list,
+					 CPUFREQ_PRECHANGE, freqs);
 
 		adjust_jiffies(CPUFREQ_PRECHANGE, freqs);
 		break;
@@ -377,11 +378,11 @@ static void cpufreq_notify_transition(struct cpufreq_policy *policy,
 		pr_debug("FREQ: %u - CPUs: %*pbl\n", freqs->new,
 			 cpumask_pr_args(policy->cpus));
 
-		for_each_cpu(freqs->cpu, policy->cpus) {
-			trace_cpu_frequency(freqs->new, freqs->cpu);
-			srcu_notifier_call_chain(&cpufreq_transition_notifier_list,
-						 CPUFREQ_POSTCHANGE, freqs);
-		}
+		for_each_cpu(cpu, policy->cpus)
+			trace_cpu_frequency(freqs->new, cpu);
+
+		srcu_notifier_call_chain(&cpufreq_transition_notifier_list,
+					 CPUFREQ_POSTCHANGE, freqs);
 
 		cpufreq_stats_record_transition(policy, freqs->new);
 		policy->cur = freqs->new;
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 684caf067003..d01a74fbc4db 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -42,13 +42,6 @@ enum cpufreq_table_sorting {
 	CPUFREQ_TABLE_SORTED_DESCENDING
 };
 
-struct cpufreq_freqs {
-	unsigned int cpu;	/* cpu nr */
-	unsigned int old;
-	unsigned int new;
-	u8 flags;		/* flags of cpufreq_driver, see below. */
-};
-
 struct cpufreq_cpuinfo {
 	unsigned int		max_freq;
 	unsigned int		min_freq;
@@ -156,6 +149,13 @@ struct cpufreq_policy {
 	struct thermal_cooling_device *cdev;
 };
 
+struct cpufreq_freqs {
+	struct cpufreq_policy *policy;
+	unsigned int old;
+	unsigned int new;
+	u8 flags;		/* flags of cpufreq_driver, see below. */
+};
+
 /* Only for ACPI */
 #define CPUFREQ_SHARED_TYPE_NONE (0) /* None */
 #define CPUFREQ_SHARED_TYPE_HW	 (1) /* HW does needed coordination */
-- 
2.21.0.rc0.269.g1a574e7a288b
