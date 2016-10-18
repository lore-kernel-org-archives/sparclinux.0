From: Babu Moger <babu.moger@oracle.com>
Date: Tue, 18 Oct 2016 19:14:09 +0000
Subject: [PATCH v3 1/2] watchdog: Introduce arch_watchdog_nmi_enable and arch_watchdog_nmi_disable
Message-Id: <1476818050-117332-2-git-send-email-babu.moger@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1476818050-117332-1-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1476818050-117332-1-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mingo@kernel.org, akpm@linux-foundation.org, ak@linux.intel.com, jkosina@suse.cz, baiyaowei@cmss.chinamobile.com, dzickus@redhat.com, atomlin@redhat.com, uobergfe@redhat.com, tj@kernel.org, hidehiro.kawai.ez@hitachi.com, johunt@akamai.com, davem@davemloft.net, sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, sam@ravnborg.org, babu.moger@oracle.com

Currently we do not have a way to enable/disable arch specific
watchdog handlers if it was implemented by any of the architectures.

This patch introduces new functions arch_watchdog_nmi_enable and
arch_watchdog_nmi_disable which can be used to enable/disable architecture
specific NMI watchdog handlers. These functions are defined as weak as
architectures can override their definitions to enable/disable nmi
watchdog behaviour.

Signed-off-by: Babu Moger <babu.moger@oracle.com>
---
 kernel/watchdog.c |   69 +++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 46 insertions(+), 23 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 9acb29f..2d0765b 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -46,7 +46,7 @@
 
 static DEFINE_MUTEX(watchdog_proc_mutex);
 
-#ifdef CONFIG_HARDLOCKUP_DETECTOR
+#if defined(CONFIG_HARDLOCKUP_DETECTOR) || defined(CONFIG_HAVE_NMI_WATCHDOG)
 static unsigned long __read_mostly watchdog_enabled = SOFT_WATCHDOG_ENABLED|NMI_WATCHDOG_ENABLED;
 #else
 static unsigned long __read_mostly watchdog_enabled = SOFT_WATCHDOG_ENABLED;
@@ -585,15 +585,11 @@ static void watchdog(unsigned int cpu)
  */
 static unsigned long cpu0_err;
 
-static int watchdog_nmi_enable(unsigned int cpu)
+static int arch_watchdog_nmi_enable(unsigned int cpu)
 {
 	struct perf_event_attr *wd_attr;
 	struct perf_event *event = per_cpu(watchdog_ev, cpu);
 
-	/* nothing to do if the hard lockup detector is disabled */
-	if (!(watchdog_enabled & NMI_WATCHDOG_ENABLED))
-		goto out;
-
 	/* is it already setup and enabled? */
 	if (event && event->state > PERF_EVENT_STATE_OFF)
 		goto out;
@@ -619,18 +615,6 @@ static int watchdog_nmi_enable(unsigned int cpu)
 		goto out_save;
 	}
 
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
 	/* skip displaying the same error again */
 	if (cpu > 0 && (PTR_ERR(event) = cpu0_err))
 		return PTR_ERR(event);
@@ -645,8 +629,6 @@ static int watchdog_nmi_enable(unsigned int cpu)
 		pr_err("disabled (cpu%i): unable to create perf event: %ld\n",
 			cpu, PTR_ERR(event));
 
-	pr_info("Shutting down hard lockup detector on all cpus\n");
-
 	return PTR_ERR(event);
 
 	/* success path */
@@ -658,7 +640,7 @@ out:
 	return 0;
 }
 
-static void watchdog_nmi_disable(unsigned int cpu)
+static void arch_watchdog_nmi_disable(unsigned int cpu)
 {
 	struct perf_event *event = per_cpu(watchdog_ev, cpu);
 
@@ -676,8 +658,13 @@ static void watchdog_nmi_disable(unsigned int cpu)
 }
 
 #else
-static int watchdog_nmi_enable(unsigned int cpu) { return 0; }
-static void watchdog_nmi_disable(unsigned int cpu) { return; }
+/*
+ * These two functions are mostly architecture specific
+ * defining them as weak here.
+ */
+int __weak arch_watchdog_nmi_enable(unsigned int cpu) { return 0; }
+void __weak arch_watchdog_nmi_disable(unsigned int cpu) { return; }
+
 #endif /* CONFIG_HARDLOCKUP_DETECTOR */
 
 static struct smp_hotplug_thread watchdog_threads = {
@@ -781,6 +768,42 @@ void lockup_detector_resume(void)
 	put_online_cpus();
 }
 
+void watchdog_nmi_disable(unsigned int cpu)
+{
+	arch_watchdog_nmi_disable(cpu);
+}
+
+int watchdog_nmi_enable(unsigned int cpu)
+{
+	int err;
+
+	/* nothing to do if the hard lockup detector is disabled */
+	if (!(watchdog_enabled & NMI_WATCHDOG_ENABLED))
+		return 0;
+
+	err = arch_watchdog_nmi_enable(cpu);
+
+	if (err) {
+		/*
+		 * Disable the hard lockup detector if _any_ CPU fails to set up
+		 * set up the hardware perf event. The watchdog() function checks
+		 * the NMI_WATCHDOG_ENABLED bit periodically.
+		 *
+		 * The barriers are for syncing up watchdog_enabled across all the
+		 * cpus, as clear_bit() does not use barriers.
+		 */
+		smp_mb__before_atomic();
+		clear_bit(NMI_WATCHDOG_ENABLED_BIT, &watchdog_enabled);
+		smp_mb__after_atomic();
+
+		pr_info("Shutting down hard lockup detector on all cpus\n");
+
+		return err;
+	}
+
+	return 0;
+}
+
 static int update_watchdog_all_cpus(void)
 {
 	int ret;
-- 
1.7.1

