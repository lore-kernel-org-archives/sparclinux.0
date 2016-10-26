From: Babu Moger <babu.moger@oracle.com>
Date: Wed, 26 Oct 2016 16:02:20 +0000
Subject: [RFC PATCH 1/4] watchdog: Remove hardlockup handler references
Message-Id: <1477497743-15357-2-git-send-email-babu.moger@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1477497743-15357-1-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1477497743-15357-1-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mingo@kernel.org, akpm@linux-foundation.org, ak@linux.intel.com, jkosina@suse.cz, baiyaowei@cmss.chinamobile.com, dzickus@redhat.com, atomlin@redhat.com, uobergfe@redhat.com, tj@kernel.org, hidehiro.kawai.ez@hitachi.com, johunt@akamai.com, davem@davemloft.net, sparclinux@vger.kernel.org
Cc: bp@suse.de, bywxiaobai@163.com, cmetcalf@mellanox.com, keescook@chromium.org, ebiederm@xmission.com, huawei.libin@huawei.com, ralf@linux-mips.org, dvyukov@google.com, linux-kernel@vger.kernel.org, sam@ravnborg.org, babu.moger@oracle.com

Separate hardlockup code from watchdog.c. It is mostly straight forward.
Remove everything inside CONFIG_HARDLOCKUP_DETECTORS. This code will go
to file watchdog_hld.c. 

We also define weak handlers watchdog_nmi_enable and watchdog_nmi_disable.

Signed-off-by: Babu Moger <babu.moger@oracle.com>
---
 kernel/watchdog.c |  251 ++---------------------------------------------------
 1 files changed, 7 insertions(+), 244 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 9acb29f..a88e179 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -24,7 +24,6 @@
 
 #include <asm/irq_regs.h>
 #include <linux/kvm_para.h>
-#include <linux/perf_event.h>
 #include <linux/kthread.h>
 
 /*
@@ -100,50 +99,8 @@
 static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts);
 static DEFINE_PER_CPU(unsigned long, soft_lockup_hrtimer_cnt);
 static DEFINE_PER_CPU(struct task_struct *, softlockup_task_ptr_saved);
-#ifdef CONFIG_HARDLOCKUP_DETECTOR
-static DEFINE_PER_CPU(bool, hard_watchdog_warn);
-static DEFINE_PER_CPU(bool, watchdog_nmi_touch);
-static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts_saved);
-static DEFINE_PER_CPU(struct perf_event *, watchdog_ev);
-#endif
 static unsigned long soft_lockup_nmi_warn;
 
-/* boot commands */
-/*
- * Should we panic when a soft-lockup or hard-lockup occurs:
- */
-#ifdef CONFIG_HARDLOCKUP_DETECTOR
-unsigned int __read_mostly hardlockup_panic -			CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE;
-static unsigned long hardlockup_allcpu_dumped;
-/*
- * We may not want to enable hard lockup detection by default in all cases,
- * for example when running the kernel as a guest on a hypervisor. In these
- * cases this function can be called to disable hard lockup detection. This
- * function should only be executed once by the boot processor before the
- * kernel command line parameters are parsed, because otherwise it is not
- * possible to override this in hardlockup_panic_setup().
- */
-void hardlockup_detector_disable(void)
-{
-	watchdog_enabled &= ~NMI_WATCHDOG_ENABLED;
-}
-
-static int __init hardlockup_panic_setup(char *str)
-{
-	if (!strncmp(str, "panic", 5))
-		hardlockup_panic = 1;
-	else if (!strncmp(str, "nopanic", 7))
-		hardlockup_panic = 0;
-	else if (!strncmp(str, "0", 1))
-		watchdog_enabled &= ~NMI_WATCHDOG_ENABLED;
-	else if (!strncmp(str, "1", 1))
-		watchdog_enabled |= NMI_WATCHDOG_ENABLED;
-	return 1;
-}
-__setup("nmi_watchdog=", hardlockup_panic_setup);
-#endif
-
 unsigned int __read_mostly softlockup_panic  			CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE;
 
@@ -264,43 +221,12 @@ void touch_all_softlockup_watchdogs(void)
 	wq_watchdog_touch(-1);
 }
 
-#ifdef CONFIG_HARDLOCKUP_DETECTOR
-void touch_nmi_watchdog(void)
-{
-	/*
-	 * Using __raw here because some code paths have
-	 * preemption enabled.  If preemption is enabled
-	 * then interrupts should be enabled too, in which
-	 * case we shouldn't have to worry about the watchdog
-	 * going off.
-	 */
-	raw_cpu_write(watchdog_nmi_touch, true);
-	touch_softlockup_watchdog();
-}
-EXPORT_SYMBOL(touch_nmi_watchdog);
-
-#endif
-
 void touch_softlockup_watchdog_sync(void)
 {
 	__this_cpu_write(softlockup_touch_sync, true);
 	__this_cpu_write(watchdog_touch_ts, 0);
 }
 
-#ifdef CONFIG_HARDLOCKUP_DETECTOR
-/* watchdog detector functions */
-static bool is_hardlockup(void)
-{
-	unsigned long hrint = __this_cpu_read(hrtimer_interrupts);
-
-	if (__this_cpu_read(hrtimer_interrupts_saved) = hrint)
-		return true;
-
-	__this_cpu_write(hrtimer_interrupts_saved, hrint);
-	return false;
-}
-#endif
-
 static int is_softlockup(unsigned long touch_ts)
 {
 	unsigned long now = get_timestamp();
@@ -313,78 +239,18 @@ static int is_softlockup(unsigned long touch_ts)
 	return 0;
 }
 
-#ifdef CONFIG_HARDLOCKUP_DETECTOR
-
-static struct perf_event_attr wd_hw_attr = {
-	.type		= PERF_TYPE_HARDWARE,
-	.config		= PERF_COUNT_HW_CPU_CYCLES,
-	.size		= sizeof(struct perf_event_attr),
-	.pinned		= 1,
-	.disabled	= 1,
-};
-
-/* Callback function for perf event subsystem */
-static void watchdog_overflow_callback(struct perf_event *event,
-		 struct perf_sample_data *data,
-		 struct pt_regs *regs)
-{
-	/* Ensure the watchdog never gets throttled */
-	event->hw.interrupts = 0;
-
-	if (__this_cpu_read(watchdog_nmi_touch) = true) {
-		__this_cpu_write(watchdog_nmi_touch, false);
-		return;
-	}
-
-	/* check for a hardlockup
-	 * This is done by making sure our timer interrupt
-	 * is incrementing.  The timer interrupt should have
-	 * fired multiple times before we overflow'd.  If it hasn't
-	 * then this is a good indication the cpu is stuck
-	 */
-	if (is_hardlockup()) {
-		int this_cpu = smp_processor_id();
-		struct pt_regs *regs = get_irq_regs();
-
-		/* only print hardlockups once */
-		if (__this_cpu_read(hard_watchdog_warn) = true)
-			return;
-
-		pr_emerg("Watchdog detected hard LOCKUP on cpu %d", this_cpu);
-		print_modules();
-		print_irqtrace_events(current);
-		if (regs)
-			show_regs(regs);
-		else
-			dump_stack();
-
-		/*
-		 * Perform all-CPU dump only once to avoid multiple hardlockups
-		 * generating interleaving traces
-		 */
-		if (sysctl_hardlockup_all_cpu_backtrace &&
-				!test_and_set_bit(0, &hardlockup_allcpu_dumped))
-			trigger_allbutself_cpu_backtrace();
-
-		if (hardlockup_panic)
-			nmi_panic(regs, "Hard LOCKUP");
-
-		__this_cpu_write(hard_watchdog_warn, true);
-		return;
-	}
-
-	__this_cpu_write(hard_watchdog_warn, false);
-	return;
-}
-#endif /* CONFIG_HARDLOCKUP_DETECTOR */
-
 static void watchdog_interrupt_count(void)
 {
 	__this_cpu_inc(hrtimer_interrupts);
 }
 
-static int watchdog_nmi_enable(unsigned int cpu);
-static void watchdog_nmi_disable(unsigned int cpu);
+int __weak watchdog_nmi_enable(unsigned int cpu)
+{
+	return 0;
+}
+void __weak watchdog_nmi_disable(unsigned int cpu)
+{
+}
 
 static int watchdog_enable_all_cpus(void);
 static void watchdog_disable_all_cpus(void);
@@ -577,109 +443,6 @@ static void watchdog(unsigned int cpu)
 		watchdog_nmi_disable(cpu);
 }
 
-#ifdef CONFIG_HARDLOCKUP_DETECTOR
-/*
- * People like the simple clean cpu node info on boot.
- * Reduce the watchdog noise by only printing messages
- * that are different from what cpu0 displayed.
- */
-static unsigned long cpu0_err;
-
-static int watchdog_nmi_enable(unsigned int cpu)
-{
-	struct perf_event_attr *wd_attr;
-	struct perf_event *event = per_cpu(watchdog_ev, cpu);
-
-	/* nothing to do if the hard lockup detector is disabled */
-	if (!(watchdog_enabled & NMI_WATCHDOG_ENABLED))
-		goto out;
-
-	/* is it already setup and enabled? */
-	if (event && event->state > PERF_EVENT_STATE_OFF)
-		goto out;
-
-	/* it is setup but not enabled */
-	if (event != NULL)
-		goto out_enable;
-
-	wd_attr = &wd_hw_attr;
-	wd_attr->sample_period = hw_nmi_get_sample_period(watchdog_thresh);
-
-	/* Try to register using hardware perf events */
-	event = perf_event_create_kernel_counter(wd_attr, cpu, NULL, watchdog_overflow_callback, NULL);
-
-	/* save cpu0 error for future comparision */
-	if (cpu = 0 && IS_ERR(event))
-		cpu0_err = PTR_ERR(event);
-
-	if (!IS_ERR(event)) {
-		/* only print for cpu0 or different than cpu0 */
-		if (cpu = 0 || cpu0_err)
-			pr_info("enabled on all CPUs, permanently consumes one hw-PMU counter.\n");
-		goto out_save;
-	}
-
-	/*
-	 * Disable the hard lockup detector if _any_ CPU fails to set up
-	 * set up the hardware perf event. The watchdog() function checks
-	 * the NMI_WATCHDOG_ENABLED bit periodically.
-	 *
-	 * The barriers are for syncing up watchdog_enabled across all the
-	 * cpus, as clear_bit() does not use barriers.
-	 */
-	smp_mb__before_atomic();
-	clear_bit(NMI_WATCHDOG_ENABLED_BIT, &watchdog_enabled);
-	smp_mb__after_atomic();
-
-	/* skip displaying the same error again */
-	if (cpu > 0 && (PTR_ERR(event) = cpu0_err))
-		return PTR_ERR(event);
-
-	/* vary the KERN level based on the returned errno */
-	if (PTR_ERR(event) = -EOPNOTSUPP)
-		pr_info("disabled (cpu%i): not supported (no LAPIC?)\n", cpu);
-	else if (PTR_ERR(event) = -ENOENT)
-		pr_warn("disabled (cpu%i): hardware events not enabled\n",
-			 cpu);
-	else
-		pr_err("disabled (cpu%i): unable to create perf event: %ld\n",
-			cpu, PTR_ERR(event));
-
-	pr_info("Shutting down hard lockup detector on all cpus\n");
-
-	return PTR_ERR(event);
-
-	/* success path */
-out_save:
-	per_cpu(watchdog_ev, cpu) = event;
-out_enable:
-	perf_event_enable(per_cpu(watchdog_ev, cpu));
-out:
-	return 0;
-}
-
-static void watchdog_nmi_disable(unsigned int cpu)
-{
-	struct perf_event *event = per_cpu(watchdog_ev, cpu);
-
-	if (event) {
-		perf_event_disable(event);
-		per_cpu(watchdog_ev, cpu) = NULL;
-
-		/* should be in cleanup, but blocks oprofile */
-		perf_event_release_kernel(event);
-	}
-	if (cpu = 0) {
-		/* watchdog_nmi_enable() expects this to be zero initially. */
-		cpu0_err = 0;
-	}
-}
-
-#else
-static int watchdog_nmi_enable(unsigned int cpu) { return 0; }
-static void watchdog_nmi_disable(unsigned int cpu) { return; }
-#endif /* CONFIG_HARDLOCKUP_DETECTOR */
-
 static struct smp_hotplug_thread watchdog_threads = {
 	.store			= &softlockup_watchdog,
 	.thread_should_run	= watchdog_should_run,
-- 
1.7.1

