From: Babu Moger <babu.moger@oracle.com>
Date: Wed, 26 Oct 2016 16:02:21 +0000
Subject: [RFC PATCH 2/4] watchdog: Move shared definitions to nmi.h
Message-Id: <1477497743-15357-3-git-send-email-babu.moger@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1477497743-15357-1-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1477497743-15357-1-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mingo@kernel.org, akpm@linux-foundation.org, ak@linux.intel.com, jkosina@suse.cz, baiyaowei@cmss.chinamobile.com, dzickus@redhat.com, atomlin@redhat.com, uobergfe@redhat.com, tj@kernel.org, hidehiro.kawai.ez@hitachi.com, johunt@akamai.com, davem@davemloft.net, sparclinux@vger.kernel.org
Cc: bp@suse.de, bywxiaobai@163.com, cmetcalf@mellanox.com, keescook@chromium.org, ebiederm@xmission.com, huawei.libin@huawei.com, ralf@linux-mips.org, dvyukov@google.com, linux-kernel@vger.kernel.org, sam@ravnborg.org, babu.moger@oracle.com

Move shared macros and definitions to nmi.h so that watchdog.c,
watchdog_hld.c or any other architecture specific handler can use
those definitions.

Signed-off-by: Babu Moger <babu.moger@oracle.com>
---
 include/linux/nmi.h |   19 +++++++++++++++++++
 kernel/watchdog.c   |   25 ++++---------------------
 2 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index a78c35c..0ea0a38 100644
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
@@ -91,6 +108,8 @@ static inline bool trigger_single_cpu_backtrace(int cpu)
 extern int soft_watchdog_enabled;
 extern int watchdog_user_enabled;
 extern int watchdog_thresh;
+extern unsigned long watchdog_enabled;
+extern DEFINE_PER_CPU(unsigned long, hrtimer_interrupts);
 extern unsigned long *watchdog_cpumask_bits;
 extern int sysctl_softlockup_all_cpu_backtrace;
 extern int sysctl_hardlockup_all_cpu_backtrace;
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index a88e179..4ea7752 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -26,29 +26,12 @@
 #include <linux/kvm_para.h>
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
@@ -96,7 +79,7 @@
 static DEFINE_PER_CPU(struct hrtimer, watchdog_hrtimer);
 static DEFINE_PER_CPU(bool, softlockup_touch_sync);
 static DEFINE_PER_CPU(bool, soft_watchdog_warn);
-static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts);
+DEFINE_PER_CPU(unsigned long, hrtimer_interrupts);
 static DEFINE_PER_CPU(unsigned long, soft_lockup_hrtimer_cnt);
 static DEFINE_PER_CPU(struct task_struct *, softlockup_task_ptr_saved);
 static unsigned long soft_lockup_nmi_warn;
-- 
1.7.1

