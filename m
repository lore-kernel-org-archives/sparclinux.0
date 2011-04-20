From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 20 Apr 2011 21:11:04 +0000
Subject: [PATCH] sparc32: always register a PROM based early console
Message-Id: <20110420211104.GA11377@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From f6443589822110b80967c26ced29b5781bcec43f Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 20 Apr 2011 23:07:00 +0200
Subject: [PATCH] sparc32: always register a PROM based early console

Do not require user to add "-p" to boot arguments to see
early info printed to prom console.

This is similar to the sparc64 functionality - which was added with:
3c62a2d3477ff7725210db57aec3d2806fa10c20 ("[SPARC64]: Always register
a PROM based early console.")

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/devices.c  |    2 +-
 arch/sparc/kernel/prom_32.c  |    1 -
 arch/sparc/kernel/setup_32.c |   14 ++++++++------
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/kernel/devices.c b/arch/sparc/kernel/devices.c
index 12aff23..113c052 100644
--- a/arch/sparc/kernel/devices.c
+++ b/arch/sparc/kernel/devices.c
@@ -114,7 +114,7 @@ int cpu_get_hwmid(phandle prom_node)
 
 void __init device_scan(void)
 {
-	prom_printf("Booting Linux...\n");
+	printk(KERN_NOTICE "Booting Linux...\n");
 
 #ifndef CONFIG_SMP
 	{
diff --git a/arch/sparc/kernel/prom_32.c b/arch/sparc/kernel/prom_32.c
index 05fb253..5ce3d15 100644
--- a/arch/sparc/kernel/prom_32.c
+++ b/arch/sparc/kernel/prom_32.c
@@ -326,7 +326,6 @@ void __init of_console_init(void)
 			of_console_options = NULL;
 	}
 
-	prom_printf(msg, of_console_path);
 	printk(msg, of_console_path);
 }
 
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index 8f3031f..ef8a2ed 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -109,10 +109,10 @@ prom_console_write(struct console *con, const char *s, unsigned n)
 	prom_write(s, n);
 }
 
-static struct console prom_debug_console = {
-	.name =		"debug",
+static struct console prom_early_console = {
+	.name =		"earlyprom",
 	.write =	prom_console_write,
-	.flags =	CON_PRINTBUFFER,
+	.flags =	CON_PRINTBUFFER | CON_BOOT,
 	.index =	-1,
 };
 
@@ -133,8 +133,7 @@ static void __init process_switch(char c)
 		prom_halt();
 		break;
 	case 'p':
-		/* Use PROM debug console. */
-		register_console(&prom_debug_console);
+		/* Just ignore, this behavior is now the default.  */
 		break;
 	default:
 		printk("Unknown boot switch (-%c)\n", c);
@@ -215,6 +214,10 @@ void __init setup_arch(char **cmdline_p)
 	strcpy(boot_command_line, *cmdline_p);
 	parse_early_param();
 
+	boot_flags_init(*cmdline_p);
+
+	register_console(&prom_early_console);
+
 	/* Set sparc_cpu_model */
 	sparc_cpu_model = sun_unknown;
 	if (!strcmp(&cputypval[0], "sun4 "))
@@ -265,7 +268,6 @@ void __init setup_arch(char **cmdline_p)
 #ifdef CONFIG_DUMMY_CONSOLE
 	conswitchp = &dummy_con;
 #endif
-	boot_flags_init(*cmdline_p);
 
 	idprom_init();
 	if (ARCH_SUN4C)
-- 
1.6.0.6

