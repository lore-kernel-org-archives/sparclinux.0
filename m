From: Babu Moger <babu.moger@oracle.com>
Date: Thu, 13 Oct 2016 20:38:02 +0000
Subject: [PATCH v2 2/2] sparc: Implement arch_watchdog_nmi_enable and arch_watchdog_nmi_disable
Message-Id: <1476391082-77928-3-git-send-email-babu.moger@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1476391082-77928-1-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1476391082-77928-1-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mingo@kernel.org, akpm@linux-foundation.org, ak@linux.intel.com, jkosina@suse.cz, baiyaowei@cmss.chinamobile.com, dzickus@redhat.com, atomlin@redhat.com, uobergfe@redhat.com, tj@kernel.org, hidehiro.kawai.ez@hitachi.com, johunt@akamai.com, davem@davemloft.net, sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, sam@ravnborg.org, babu.moger@oracle.com

Implement functions arch_watchdog_nmi_enable and arch_watchdog_nmi_disable
to enable/disable nmi watchdog. Sparc uses arch specific nmi watchdog
handler. Currently, we do not have a way to enable/disable nmi watchdog
dynamically. With these patches we can enable or disable arch
specific nmi watchdogs using proc or sysctl interface.

Example commands.
To enable: echo 1 >  /proc/sys/kernel/nmi_watchdog
To disable: echo 0 >  /proc/sys/kernel/nmi_watchdog

It can also achieved using the sysctl parameter kernel.nmi_watchdog

Signed-off-by: Babu Moger <babu.moger@oracle.com>
---
 arch/sparc/kernel/nmi.c |   41 ++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 40 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/kernel/nmi.c b/arch/sparc/kernel/nmi.c
index a9973bb..d7e2c01 100644
--- a/arch/sparc/kernel/nmi.c
+++ b/arch/sparc/kernel/nmi.c
@@ -42,7 +42,7 @@ static int panic_on_timeout;
  */
 atomic_t nmi_active = ATOMIC_INIT(0);		/* oprofile uses this */
 EXPORT_SYMBOL(nmi_active);
-
+static int nmi_init_done;
 static unsigned int nmi_hz = HZ;
 static DEFINE_PER_CPU(short, wd_enabled);
 static int endflag __initdata;
@@ -153,6 +153,8 @@ static void report_broken_nmi(int cpu, int *prev_nmi_count)
 
 void stop_nmi_watchdog(void *unused)
 {
+	if (!__this_cpu_read(wd_enabled))
+		return;
 	pcr_ops->write_pcr(0, pcr_ops->pcr_nmi_disable);
 	__this_cpu_write(wd_enabled, 0);
 	atomic_dec(&nmi_active);
@@ -207,6 +209,9 @@ error:
 
 void start_nmi_watchdog(void *unused)
 {
+	if (__this_cpu_read(wd_enabled))
+		return;
+
 	__this_cpu_write(wd_enabled, 1);
 	atomic_inc(&nmi_active);
 
@@ -259,6 +264,8 @@ int __init nmi_init(void)
 		}
 	}
 
+	nmi_init_done = 1;
+
 	return err;
 }
 
@@ -270,3 +277,35 @@ static int __init setup_nmi_watchdog(char *str)
 	return 0;
 }
 __setup("nmi_watchdog=", setup_nmi_watchdog);
+
+/*
+ * sparc specific NMI watchdog enable function.
+ * Enables watchdog if it is not enabled already.
+ */
+int arch_watchdog_nmi_enable(unsigned int cpu)
+{
+	if (atomic_read(&nmi_active) = -1) {
+		pr_info_once("NMI watchdog cannot be enabled\n");
+		return -1;
+	}
+
+	/*
+	 * watchdog thread could start even before nmi_init is called.
+	 * Just Return in that case. Let nmi_init finish the init
+	 * process first.
+	 */
+	if (!nmi_init_done)
+		return 0;
+
+	smp_call_function_single(cpu, start_nmi_watchdog, NULL, 1);
+
+	return 0;
+}
+/*
+ * sparc specific NMI watchdog disable function.
+ * Disables watchdog if it is not disabled already.
+ */
+void arch_watchdog_nmi_disable(unsigned int cpu)
+{
+	smp_call_function_single(cpu, stop_nmi_watchdog, NULL, 1);
+}
-- 
1.7.1

