From: Joel Stanley <joel@jms.id.au>
Date: Wed, 01 Apr 2015 07:16:47 +0000
Subject: [PATCH v2 2/3] kernel/reboot.c: Add orderly_reboot for graceful reboot
Message-Id: <1427871888-27331-2-git-send-email-joel@jms.id.au>
List-Id: <sparclinux.vger.kernel.org>
References: <1427871888-27331-1-git-send-email-joel@jms.id.au>
In-Reply-To: <1427871888-27331-1-git-send-email-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Cc: rusty@rustcorp.com.au, fabf@skynet.be, jk@ozlabs.org, akpm@linux-foundation.org, davem@davemloft.net

The kernel has orderly_poweroff which allows the kernel to initiate a
graceful shutdown of userspace, by running /sbin/poweroff. This adds
orderly_reboot that will cause userspace to shut itself down by calling
/sbin/reboot.

This will be used for shutdown initiated by a system controller on
platforms that do not use ACPI.

orderly_reboot() should be used when the system wants to allow userspace
to gracefully shut itself down. For cases where the system may
imminently catch on fire, the existing emergency_restart() provides an
immediate reboot without involving userspace.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
V2:
 - remove unused return value from orderly_*
 - use correct command in orderly_poweroff
 - the reboot command will not have a proc knob to control it, so
   it can be made const and static

 include/linux/reboot.h |  3 ++-
 kernel/reboot.c        | 53 +++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index 48bf152..dc5e3bd 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -67,7 +67,8 @@ void ctrl_alt_del(void);
 #define POWEROFF_CMD_PATH_LEN	256
 extern char poweroff_cmd[POWEROFF_CMD_PATH_LEN];
 
-extern int orderly_poweroff(bool force);
+extern void orderly_poweroff(bool force);
+extern void orderly_reboot(void);
 
 /*
  * Emergency restart, callable from an interrupt handler.
diff --git a/kernel/reboot.c b/kernel/reboot.c
index a3a9e24..0ace9f6 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -306,8 +306,9 @@ void ctrl_alt_del(void)
 }
 
 char poweroff_cmd[POWEROFF_CMD_PATH_LEN] = "/sbin/poweroff";
+static const char reboot_cmd[] = "/sbin/reboot";
 
-static int __orderly_poweroff(bool force)
+static int run_cmd(const char *cmd)
 {
 	char **argv;
 	static char *envp[] = {
@@ -316,8 +317,7 @@ static int __orderly_poweroff(bool force)
 		NULL
 	};
 	int ret;
-
-	argv = argv_split(GFP_KERNEL, poweroff_cmd, NULL);
+	argv = argv_split(GFP_KERNEL, cmd, NULL);
 	if (argv) {
 		ret = call_usermodehelper(argv[0], argv, envp, UMH_WAIT_EXEC);
 		argv_free(argv);
@@ -325,8 +325,33 @@ static int __orderly_poweroff(bool force)
 		ret = -ENOMEM;
 	}
 
+	return ret;
+}
+
+static int __orderly_reboot(void)
+{
+	int ret;
+
+	ret = run_cmd(reboot_cmd);
+
+	if (ret) {
+		pr_warn("Failed to start orderly reboot: forcing the issue\n");
+		emergency_sync();
+		kernel_restart(NULL);
+	}
+
+	return ret;
+}
+
+static int __orderly_poweroff(bool force)
+{
+	int ret;
+
+	ret = run_cmd(poweroff_cmd);
+
 	if (ret && force) {
 		pr_warn("Failed to start orderly shutdown: forcing the issue\n");
+
 		/*
 		 * I guess this should try to kick off some daemon to sync and
 		 * poweroff asap.  Or not even bother syncing if we're doing an
@@ -355,15 +380,33 @@ static DECLARE_WORK(poweroff_work, poweroff_work_func);
  * This may be called from any context to trigger a system shutdown.
  * If the orderly shutdown fails, it will force an immediate shutdown.
  */
-int orderly_poweroff(bool force)
+void orderly_poweroff(bool force)
 {
 	if (force) /* do not override the pending "true" */
 		poweroff_force = true;
 	schedule_work(&poweroff_work);
-	return 0;
 }
 EXPORT_SYMBOL_GPL(orderly_poweroff);
 
+static void reboot_work_func(struct work_struct *work)
+{
+	__orderly_reboot();
+}
+
+static DECLARE_WORK(reboot_work, reboot_work_func);
+
+/**
+ * orderly_reboot - Trigger an orderly system reboot
+ *
+ * This may be called from any context to trigger a system reboot.
+ * If the orderly reboot fails, it will force an immediate reboot.
+ */
+void orderly_reboot(void)
+{
+	schedule_work(&reboot_work);
+}
+EXPORT_SYMBOL_GPL(orderly_reboot);
+
 static int __init reboot_setup(char *str)
 {
 	for (;;) {
-- 
2.1.4

