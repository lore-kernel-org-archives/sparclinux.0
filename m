From: Babu Moger <babu.moger@oracle.com>
Date: Thu, 06 Oct 2016 22:16:43 +0000
Subject: [PATCH 2/2] sparc: Implement update_arch_nmi_watchdog
Message-Id: <1475792203-230942-3-git-send-email-babu.moger@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1475792203-230942-1-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1475792203-230942-1-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mingo@kernel.org, akpm@linux-foundation.org, ak@linux.intel.com, jkosina@suse.cz, baiyaowei@cmss.chinamobile.com, dzickus@redhat.com, atomlin@redhat.com, uobergfe@redhat.com, tj@kernel.org, hidehiro.kawai.ez@hitachi.com, johunt@akamai.com, davem@davemloft.net, sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, babu.moger@oracle.com

Implement function update_arch_nmi_watchdog to enable/disable
nmi watchdog. Sparc uses arch specific nmi watchdog handler.
Currently, we do not have a way to enable/disable nmi watchdog
dynamically. With these patches we can enable or disable arch
specinf nmi watchdogs using proc or sysctl interface.

Example commands.
To enable: echo 1 >  /proc/sys/kernel/nmi_watchdog
To disable: echo 0 >  /proc/sys/kernel/nmi_watchdog

It can also achieved using the sysctl parameter kernel.nmi_watchdog

Signed-off-by: Babu Moger <babu.moger@oracle.com>
---
 arch/sparc/kernel/nmi.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/nmi.c b/arch/sparc/kernel/nmi.c
index a9973bb..27c4e18 100644
--- a/arch/sparc/kernel/nmi.c
+++ b/arch/sparc/kernel/nmi.c
@@ -153,6 +153,8 @@ static void report_broken_nmi(int cpu, int *prev_nmi_count)
 
 void stop_nmi_watchdog(void *unused)
 {
+	if (!__this_cpu_read(wd_enabled))
+		return;
 	pcr_ops->write_pcr(0, pcr_ops->pcr_nmi_disable);
 	__this_cpu_write(wd_enabled, 0);
 	atomic_dec(&nmi_active);
@@ -207,6 +209,8 @@ error:
 
 void start_nmi_watchdog(void *unused)
 {
+	if (__this_cpu_read(wd_enabled))
+		return;
 	__this_cpu_write(wd_enabled, 1);
 	atomic_inc(&nmi_active);
 
@@ -270,3 +274,25 @@ static int __init setup_nmi_watchdog(char *str)
 	return 0;
 }
 __setup("nmi_watchdog=", setup_nmi_watchdog);
+
+#ifdef CONFIG_LOCKUP_DETECTOR
+void update_arch_nmi_watchdog(void)
+{
+	if (atomic_read(&nmi_active) < 0) {
+		printk(KERN_WARNING
+		       "NMI watchdog cannot be enabled or disabled\n");
+		return;
+	}
+
+	/*
+	 * Check for bit 0. Bit 0 is dedicated for hard lockup detector or
+	 * arch specific nmi and bit 1 for the soft lockup detector. We
+	 * are interested only in bit 0 here.
+	 */
+	if (watchdog_enabled & 1)
+		on_each_cpu(start_nmi_watchdog, NULL, 1);
+	else
+		on_each_cpu(stop_nmi_watchdog, NULL, 1);
+
+}
+#endif
-- 
1.7.1

