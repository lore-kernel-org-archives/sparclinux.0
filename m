From: Zhao Hongjiang <zhaohongjiang@huawei.com>
Date: Sun, 09 Jun 2013 08:57:58 +0000
Subject: [PATCH] sparc: kernel: using strlcpy() instead of strcpy()
Message-Id: <51B44396.9030209@huawei.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

'boot_command_line' and 'full_boot_str' has a fix length, 'cmdline_p' and
'boot_command' maybe larger than them. So use strlcpy() instead of strcpy() 
to avoid memory overflow.

Signed-off-by: Zhao Hongjiang <zhaohongjiang@huawei.com>
---
 arch/sparc/kernel/ds.c       |    3 ++-
 arch/sparc/kernel/setup_32.c |    2 +-
 arch/sparc/kernel/setup_64.c |    2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/ds.c b/arch/sparc/kernel/ds.c
index 75bb608..5ef48da 100644
--- a/arch/sparc/kernel/ds.c
+++ b/arch/sparc/kernel/ds.c
@@ -843,7 +843,8 @@ void ldom_reboot(const char *boot_command)
 		unsigned long len;
 
 		strcpy(full_boot_str, "boot ");
-		strcpy(full_boot_str + strlen("boot "), boot_command);
+		strlcpy(full_boot_str + strlen("boot "), boot_command,
+			sizeof(full_boot_str + strlen("boot ")));
 		len = strlen(full_boot_str);
 
 		if (reboot_data_supported) {
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index 38bf80a..1434526 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -304,7 +304,7 @@ void __init setup_arch(char **cmdline_p)
 
 	/* Initialize PROM console and command line. */
 	*cmdline_p = prom_getbootargs();
-	strcpy(boot_command_line, *cmdline_p);
+	strlcpy(boot_command_line, *cmdline_p, COMMAND_LINE_SIZE);
 	parse_early_param();
 
 	boot_flags_init(*cmdline_p);
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 88a127b..1378554 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -555,7 +555,7 @@ void __init setup_arch(char **cmdline_p)
 {
 	/* Initialize PROM console and command line. */
 	*cmdline_p = prom_getbootargs();
-	strcpy(boot_command_line, *cmdline_p);
+	strlcpy(boot_command_line, *cmdline_p, COMMAND_LINE_SIZE);
 	parse_early_param();
 
 	boot_flags_init(*cmdline_p);
-- 
1.7.1

