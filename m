From: Babu Moger <babu.moger@oracle.com>
Date: Tue, 01 Nov 2016 21:13:44 +0000
Subject: [PATCH v2 1/3] watchdog: Move shared definitions to nmi.h
Message-Id: <1478034826-43888-2-git-send-email-babu.moger@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1478034826-43888-1-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1478034826-43888-1-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mingo@kernel.org, akpm@linux-foundation.org, ak@linux.intel.com, jkosina@suse.cz, baiyaowei@cmss.chinamobile.com, dzickus@redhat.com, atomlin@redhat.com, uobergfe@redhat.com, tj@kernel.org, hidehiro.kawai.ez@hitachi.com, johunt@akamai.com, davem@davemloft.net, sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, sam@ravnborg.org, babu.moger@oracle.com

Move shared macros and definitions to nmi.h so that watchdog.c,
new file watchdog_hld.c or any other architecture specific handler
can use those definitions.

Signed-off-by: Babu Moger <babu.moger@oracle.com>
---
 include/linux/nmi.h |   24 ++++++++++++++++++++++++
 kernel/watchdog.c   |   28 ++++------------------------
 2 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index a78c35c..aacca82 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -7,6 +7,23 @@
 #include <linux/sched.h>
 #include <asm/irq.h>
 
+/*
+ * The run state of the lockup detectors is controlled by the content of the
+ * 'watchdog_enabled' variable. Each lockup detector has its dedicated bit -
+ * bit 0 for the hard lockup detector and bit 1 for the soft lockup detector.
+ *
+ * 'watchdog_user_enabled', 'nmi_watchdog_enabled' and 'soft_watchdog_enabled'
+ * are variables that are only used as an 'interface' between the parameters
+ * in /proc/sys/kernel and the internal state bits in 'watchdog_enabled'. The
+ * 'watchdog_thresh' variable is handled differently because its value is not
+ * boolean, and the lockup detectors are 'suspended' while 'watchdog_thresh'
+ * is equal zero.
+ */
+#define NMI_WATCHDOG_ENABLED_BIT   0
+#define SOFT_WATCHDOG_ENABLED_BIT  1
+#define NMI_WATCHDOG_ENABLED      (1 << NMI_WATCHDOG_ENABLED_BIT)
+#define SOFT_WATCHDOG_ENABLED     (1 << SOFT_WATCHDOG_ENABLED_BIT)
+
 /**
  * touch_nmi_watchdog - restart NMI watchdog timeout.
  * 
@@ -91,9 +108,16 @@ static inline bool trigger_single_cpu_backtrace(int cpu)
 extern int soft_watchdog_enabled;
 extern int watchdog_user_enabled;
 extern int watchdog_thresh;
+extern unsigned long watchdog_enabled;
 extern unsigned long *watchdog_cpumask_bits;
+#ifdef CONFIG_SMP
 extern int sysctl_softlockup_all_cpu_backtrace;
 extern int sysctl_hardlockup_all_cpu_backtrace;
+#else
+#define sysctl_softlockup_all_cpu_backtrace 0
+#define sysctl_hardlockup_all_cpu_backtrace 0
+#endif
+extern bool is_hardlockup(void);
 struct ctl_table;
 extern int proc_watchdog(struct ctl_table *, int ,
 			 void __user *, size_t *, loff_t *);
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 9acb29f..0424301 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -27,29 +27,12 @@
 #include <linux/perf_event.h>
 #include <linux/kthread.h>
 
-/*
- * The run state of the lockup detectors is controlled by the content of the
- * 'watchdog_enabled' variable. Each lockup detector has its dedicated bit -
- * bit 0 for the hard lockup detector and bit 1 for the soft lockup detector.
- *
- * 'watchdog_user_enabled', 'nmi_watchdog_enabled' and 'soft_watchdog_enabled'
- * are variables that are only used as an 'interface' between the parameters
- * in /proc/sys/kernel and the internal state bits in 'watchdog_enabled'. The
- * 'watchdog_thresh' variable is handled differently because its value is not
- * boolean, and the lockup detectors are 'suspended' while 'watchdog_thresh'
- * is equal zero.
- */
-#define NMI_WATCHDOG_ENABLED_BIT   0
-#define SOFT_WATCHDOG_ENABLED_BIT  1
-#define NMI_WATCHDOG_ENABLED      (1 << NMI_WATCHDOG_ENABLED_BIT)
-#define SOFT_WATCHDOG_ENABLED     (1 << SOFT_WATCHDOG_ENABLED_BIT)
-
 static DEFINE_MUTEX(watchdog_proc_mutex);
 
-#ifdef CONFIG_HARDLOCKUP_DETECTOR
-static unsigned long __read_mostly watchdog_enabled = SOFT_WATCHDOG_ENABLED|NMI_WATCHDOG_ENABLED;
+#if defined(CONFIG_HAVE_NMI_WATCHDOG) || defined(CONFIG_HARDLOCKUP_DETECTOR)
+unsigned long __read_mostly watchdog_enabled = SOFT_WATCHDOG_ENABLED|NMI_WATCHDOG_ENABLED;
 #else
-static unsigned long __read_mostly watchdog_enabled = SOFT_WATCHDOG_ENABLED;
+unsigned long __read_mostly watchdog_enabled = SOFT_WATCHDOG_ENABLED;
 #endif
 int __read_mostly nmi_watchdog_enabled;
 int __read_mostly soft_watchdog_enabled;
@@ -59,9 +42,6 @@
 #ifdef CONFIG_SMP
 int __read_mostly sysctl_softlockup_all_cpu_backtrace;
 int __read_mostly sysctl_hardlockup_all_cpu_backtrace;
-#else
-#define sysctl_softlockup_all_cpu_backtrace 0
-#define sysctl_hardlockup_all_cpu_backtrace 0
 #endif
 static struct cpumask watchdog_cpumask __read_mostly;
 unsigned long *watchdog_cpumask_bits = cpumask_bits(&watchdog_cpumask);
@@ -289,7 +269,7 @@ void touch_softlockup_watchdog_sync(void)
 
 #ifdef CONFIG_HARDLOCKUP_DETECTOR
 /* watchdog detector functions */
-static bool is_hardlockup(void)
+bool is_hardlockup(void)
 {
 	unsigned long hrint = __this_cpu_read(hrtimer_interrupts);
 
-- 
1.7.1

