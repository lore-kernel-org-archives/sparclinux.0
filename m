From: Babu Moger <babu.moger@oracle.com>
Date: Thu, 06 Oct 2016 22:16:42 +0000
Subject: [PATCH 1/2] watchdog: Introduce update_arch_nmi_watchdog
Message-Id: <1475792203-230942-2-git-send-email-babu.moger@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1475792203-230942-1-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1475792203-230942-1-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mingo@kernel.org, akpm@linux-foundation.org, ak@linux.intel.com, jkosina@suse.cz, baiyaowei@cmss.chinamobile.com, dzickus@redhat.com, atomlin@redhat.com, uobergfe@redhat.com, tj@kernel.org, hidehiro.kawai.ez@hitachi.com, johunt@akamai.com, davem@davemloft.net, sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, babu.moger@oracle.com

Currently we do not have a way to enable/disable arch specific
watchdog handlers if it was implemented by any of the architectures.

This patch introduces new function update_arch_nmi_watchdog
which can be used to enable/disable architecture specific NMI
watchdog handlers. Also exposes watchdog_enabled variable outside
so that arch specific nmi watchdogs can use it to implement
enalbe/disable behavour.

Signed-off-by: Babu Moger <babu.moger@oracle.com>
---
 include/linux/nmi.h |    1 +
 kernel/watchdog.c   |   16 +++++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 4630eea..01b4830 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -66,6 +66,7 @@ static inline bool trigger_allbutself_cpu_backtrace(void)
 
 #ifdef CONFIG_LOCKUP_DETECTOR
 u64 hw_nmi_get_sample_period(int watchdog_thresh);
+extern unsigned long watchdog_enabled;
 extern int nmi_watchdog_enabled;
 extern int soft_watchdog_enabled;
 extern int watchdog_user_enabled;
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 9acb29f..1ac2814 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -46,16 +46,21 @@
 
 static DEFINE_MUTEX(watchdog_proc_mutex);
 
-#ifdef CONFIG_HARDLOCKUP_DETECTOR
-static unsigned long __read_mostly watchdog_enabled = SOFT_WATCHDOG_ENABLED|NMI_WATCHDOG_ENABLED;
+#if defined(CONFIG_HARDLOCKUP_DETECTOR) || defined(CONFIG_HAVE_NMI_WATCHDOG)
+unsigned long __read_mostly watchdog_enabled = SOFT_WATCHDOG_ENABLED|NMI_WATCHDOG_ENABLED;
 #else
-static unsigned long __read_mostly watchdog_enabled = SOFT_WATCHDOG_ENABLED;
+unsigned long __read_mostly watchdog_enabled = SOFT_WATCHDOG_ENABLED;
 #endif
 int __read_mostly nmi_watchdog_enabled;
 int __read_mostly soft_watchdog_enabled;
 int __read_mostly watchdog_user_enabled;
 int __read_mostly watchdog_thresh = 10;
 
+/*
+ * Implemented by arch specific handlers if it defines CONFIG_HAVE_NMI_WATCHDOG
+ */
+void __weak update_arch_nmi_watchdog(void) {}
+
 #ifdef CONFIG_SMP
 int __read_mostly sysctl_softlockup_all_cpu_backtrace;
 int __read_mostly sysctl_hardlockup_all_cpu_backtrace;
@@ -842,6 +847,11 @@ static int proc_watchdog_update(void)
 	int err = 0;
 
 	/*
+	 * Enable/Disable arch specific nmi watchdogs if there is one
+	 */
+	update_arch_nmi_watchdog();
+
+	/*
 	 * Watchdog threads won't be started if they are already active.
 	 * The 'watchdog_running' variable in watchdog_*_all_cpus() takes
 	 * care of this. If those threads are already active, the sample
-- 
1.7.1

