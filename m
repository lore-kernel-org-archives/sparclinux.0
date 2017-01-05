From: Larry Bassel <larry.bassel@oracle.com>
Date: Thu, 05 Jan 2017 00:06:26 +0000
Subject: [PATCH v3] sparc64: shut down to OBP correctly
Message-Id: <1483574786-109088-1-git-send-email-larry.bassel@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The command "shutdown -h -H now" should shut the system down to the
OBP, however the machine was being powered off in the LDOM case.

In the LDOM case, the "reboot-command" variable must be set to
the string "noop" and then ldom_reboot() must be called.
This will make the OBP ignore the setting of "auto-boot?" after it
completes the reset. This causes the system to stop at the ok prompt.

Signed-off-by: Larry Bassel <larry.bassel@oracle.com>
---
 arch/sparc/include/asm/ldc.h |    2 +-
 arch/sparc/kernel/ds.c       |    6 +++---
 arch/sparc/prom/misc_64.c    |   12 ++++++++++--
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/include/asm/ldc.h b/arch/sparc/include/asm/ldc.h
index 6e9004a..a96a849 100644
--- a/arch/sparc/include/asm/ldc.h
+++ b/arch/sparc/include/asm/ldc.h
@@ -5,7 +5,7 @@
 
 extern int ldom_domaining_enabled;
 void ldom_set_var(const char *var, const char *value);
-void ldom_reboot(const char *boot_command);
+extern void ldom_reboot(const char *boot_command, bool prepend_boot);
 void ldom_power_off(void);
 
 /* The event handler will be evoked when link state changes
diff --git a/arch/sparc/kernel/ds.c b/arch/sparc/kernel/ds.c
index f87a55d..723167a 100644
--- a/arch/sparc/kernel/ds.c
+++ b/arch/sparc/kernel/ds.c
@@ -841,7 +841,7 @@ void ldom_set_var(const char *var, const char *value)
 static char full_boot_str[256] __attribute__((aligned(32)));
 static int reboot_data_supported;
 
-void ldom_reboot(const char *boot_command)
+void ldom_reboot(const char *boot_command, bool prepend_boot)
 {
 	/* Don't bother with any of this if the boot_command
 	 * is empty.
@@ -849,8 +849,8 @@ void ldom_reboot(const char *boot_command)
 	if (boot_command && strlen(boot_command)) {
 		unsigned long len;
 
-		snprintf(full_boot_str, sizeof(full_boot_str), "boot %s",
-			 boot_command);
+		snprintf(full_boot_str, sizeof(full_boot_str), "%s%s",
+			 prepend_boot ? "boot " : "", boot_command);
 		len = strlen(full_boot_str);
 
 		if (reboot_data_supported) {
diff --git a/arch/sparc/prom/misc_64.c b/arch/sparc/prom/misc_64.c
index 53a696d..ffdfc97 100644
--- a/arch/sparc/prom/misc_64.c
+++ b/arch/sparc/prom/misc_64.c
@@ -54,7 +54,7 @@ void prom_reboot(const char *bcommand)
 
 #ifdef CONFIG_SUN_LDOMS
 	if (ldom_domaining_enabled)
-		ldom_reboot(bcommand);
+		ldom_reboot(bcommand, true);
 #endif
 	args[0] = (unsigned long) "boot";
 	args[1] = 1;
@@ -116,8 +116,16 @@ void notrace prom_halt(void)
 	unsigned long args[3];
 
 #ifdef CONFIG_SUN_LDOMS
+    /*
+     * By storing a no-op command
+     * in the 'reboot-command' variable we cause OBP
+     * to ignore the setting of 'auto-boot?' after
+     * it completes the reset.  This causes the system
+     * to stop at the ok prompt.
+     */
+
 	if (ldom_domaining_enabled)
-		ldom_power_off();
+		ldom_reboot("noop", false);
 #endif
 again:
 	args[0] = (unsigned long) "exit";
-- 
1.7.1

