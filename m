From: David Miller <davem@davemloft.net>
Date: Fri, 12 Sep 2008 21:47:58 +0000
Subject: [PATCH 3/16]: sysctl: Use CONFIG_SPARC instead of __sparc__ for
Message-Id: <20080912.144758.203498997.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sysctl: Use CONFIG_SPARC instead of __sparc__ for ifdef tests.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 kernel/sysctl.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index fe47133..eda6162 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -118,7 +118,7 @@ extern char modprobe_path[];
 extern int sg_big_buff;
 #endif
 
-#ifdef __sparc__
+#ifdef CONFIG_SPARC
 extern char reboot_command [];
 extern int stop_a_enabled;
 extern int scons_pwroff;
@@ -414,7 +414,7 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
 	},
-#ifdef __sparc__
+#ifdef CONFIG_SPARC
 	{
 		.ctl_name	= KERN_SPARC_REBOOT,
 		.procname	= "reboot-cmd",
-- 
1.5.6.5.GIT

