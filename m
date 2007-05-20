From: David Miller <davem@davemloft.net>
Date: Sun, 20 May 2007 21:03:54 +0000
Subject: [PATCH]: Better serial console identification
Message-Id: <20070520.140354.92582888.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


If folks could test out the following and report any
regressions, especially on sparc32, I'd really appreciate
it.  I intend to push this to Linus and -stable after it
gets some exposure.

Bonus points for patches that fix the bugs you find :-)

From 8d8c99ec025445774ab663f13b7f9d537f8bf52e Mon Sep 17 00:00:00 2001
From: David S. Miller <davem@sunset.davemloft.net>
Date: Sun, 20 May 2007 13:29:10 -0700
Subject: [PATCH] [SPARC]: Fix serial console device detection.

The current scheme works on static interpretation of text names, which
is wrong.

The output-device setting, for example, must be resolved via an alias
or similar to a full path name to the console device.

Paths also contain an optional set of 'options', which starts with a
colon at the end of the path.  The option area is used to specify
which of two serial ports ('a' or 'b') the path refers to when a
device node drives multiple ports.  'a' is assumed if the option
specification is missing.

This was caught by the UltraSPARC-T1 simulator.  The 'output-device'
property was set to 'ttya' and we didn't pick upon the fact that this
is an OBP alias set to '/virtual-devices/console'.  Instead we saw it
as the first serial console device, instead of the hypervisor console.

The infrastructure is now there to take advantage of this to resolve
the console correctly even in multi-head situations in fbcon too.

Thanks to Greg Onufer for the bug report.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/process.c         |    8 ++-
 arch/sparc/kernel/prom.c            |  128 +++++++++++++++++++++++++++++++++++
 arch/sparc/kernel/setup.c           |   65 +-----------------
 arch/sparc/prom/console.c           |  116 -------------------------------
 arch/sparc/prom/misc.c              |    4 +-
 arch/sparc64/kernel/power.c         |    2 +-
 arch/sparc64/kernel/process.c       |    6 +-
 arch/sparc64/kernel/prom.c          |   56 +++++++++++++++
 arch/sparc64/kernel/setup.c         |   70 +-------------------
 arch/sparc64/kernel/sparc64_ksyms.c |    1 -
 arch/sparc64/prom/console.c         |   85 -----------------------
 arch/sparc64/prom/misc.c            |    4 +-
 arch/sparc64/prom/tree.c            |    8 ++
 drivers/serial/suncore.c            |  123 +++++++++++++---------------------
 drivers/serial/suncore.h            |    2 +
 drivers/serial/sunhv.c              |   13 +---
 drivers/serial/sunsab.c             |   22 ++-----
 drivers/serial/sunsu.c              |   23 +-----
 drivers/serial/sunzilog.c           |   24 ++-----
 drivers/video/aty/atyfb_base.c      |    4 -
 drivers/video/igafb.c               |    4 -
 include/asm-sparc/oplib.h           |   26 -------
 include/asm-sparc/prom.h            |    4 +
 include/asm-sparc64/oplib.h         |   28 +-------
 include/asm-sparc64/prom.h          |    4 +
 include/asm-sparc64/system.h        |    6 --
 26 files changed, 282 insertions(+), 554 deletions(-)

diff --git a/arch/sparc/kernel/process.c b/arch/sparc/kernel/process.c
index 8c37f8f..33f7a3d 100644
--- a/arch/sparc/kernel/process.c
+++ b/arch/sparc/kernel/process.c
@@ -39,6 +39,7 @@
 #include <asm/processor.h>
 #include <asm/psr.h>
 #include <asm/elf.h>
+#include <asm/prom.h>
 #include <asm/unistd.h>
 
 /* 
@@ -150,7 +151,7 @@ void machine_halt(void)
 	local_irq_enable();
 	mdelay(8);
 	local_irq_disable();
-	if (!serial_console && prom_palette)
+	if (prom_palette)
 		prom_palette (1);
 	prom_halt();
 	panic("Halt failed!");
@@ -166,7 +167,7 @@ void machine_restart(char * cmd)
 
 	p = strchr (reboot_command, '\n');
 	if (p) *p = 0;
-	if (!serial_console && prom_palette)
+	if (prom_palette)
 		prom_palette (1);
 	if (cmd)
 		prom_reboot(cmd);
@@ -179,7 +180,8 @@ void machine_restart(char * cmd)
 void machine_power_off(void)
 {
 #ifdef CONFIG_SUN_AUXIO
-	if (auxio_power_register && (!serial_console || scons_pwroff))
+	if (auxio_power_register &&
+	    (strcmp(of_console_device->type, "serial") || scons_pwroff))
 		*auxio_power_register |= AUXIO_POWER_OFF;
 #endif
 	machine_halt();
diff --git a/arch/sparc/kernel/prom.c b/arch/sparc/kernel/prom.c
index eed140b..227daca 100644
--- a/arch/sparc/kernel/prom.c
+++ b/arch/sparc/kernel/prom.c
@@ -566,6 +566,132 @@ static struct device_node * __init build_tree(struct device_node *parent, phandl
 	return dp;
 }
 
+struct device_node *of_console_device;
+EXPORT_SYMBOL(of_console_device);
+
+char *of_console_path;
+EXPORT_SYMBOL(of_console_path);
+
+char *of_console_options;
+EXPORT_SYMBOL(of_console_options);
+
+static void __init of_console_init(void)
+{
+	char *msg = "OF stdout device is: %s";
+	struct device_node *dp;
+	unsigned long flags;
+	const char *type;
+	phandle node;
+	int skip, fd;
+
+	of_console_path = prom_early_alloc(256);
+
+	switch (prom_vers) {
+	case PROM_V0:
+	case PROM_SUN4:
+		skip = 0;
+		switch (*romvec->pv_stdout) {
+		case PROMDEV_SCREEN:
+			type = "display";
+			break;
+
+		case PROMDEV_TTYB:
+			skip = 1;
+			/* FALLTHRU */
+
+		case PROMDEV_TTYA:
+			type = "serial";
+			break;
+
+		default:
+			prom_printf("Invalid PROM_V0 stdout value %u\n",
+				    *romvec->pv_stdout);
+			prom_halt();
+		}
+
+		for_each_node_by_type(dp, type) {
+			if (!skip--)
+				break;
+		}
+		if (!dp) {
+			prom_printf("Cannot find PROM_V0 console node.\n");
+			prom_halt();
+		}
+		of_console_device = dp;
+
+		strcpy(of_console_path, dp->full_name);
+		if (!strcmp(type, "serial")) {
+			strcat(of_console_path,
+			       (skip ? ":b" : ":a"));
+		}
+		break;
+
+	default:
+	case PROM_V2:
+	case PROM_V3:
+		fd = *romvec->pv_v2bootargs.fd_stdout;
+
+		spin_lock_irqsave(&prom_lock, flags);
+		node = (*romvec->pv_v2devops.v2_inst2pkg)(fd);
+		spin_unlock_irqrestore(&prom_lock, flags);
+
+		if (!node) {
+			prom_printf("Cannot resolve stdout node from "
+				    "instance %08x.\n", fd);
+			prom_halt();
+		}
+		dp = of_find_node_by_phandle(node);
+		type = of_get_property(dp, "device_type", NULL);
+
+		if (!type) {
+			prom_printf("Console stdout lacks "
+				    "device_type property.\n");
+			prom_halt();
+		}
+
+		if (strcmp(type, "display") && strcmp(type, "serial")) {
+			prom_printf("Console device_type is neither display "
+				    "nor serial.\n");
+			prom_halt();
+		}
+
+		of_console_device = dp;
+
+		if (prom_vers = PROM_V2) {
+			strcpy(of_console_path, dp->full_name);
+			switch (*romvec->pv_stdout) {
+			case PROMDEV_TTYA:
+				strcat(of_console_path, ":a");
+				break;
+			case PROMDEV_TTYB:
+				strcat(of_console_path, ":b");
+				break;
+			}
+		} else {
+			const char *path;
+
+			dp = of_find_node_by_path("/");
+			path = of_get_property(dp, "stdout-path", NULL);
+			if (!path) {
+				prom_printf("No stdout-path in root node.\n");
+				prom_halt();
+			}
+			strcpy(of_console_path, path);
+		}
+		break;
+	}
+
+	of_console_options = strrchr(of_console_path, ':');
+	if (of_console_options) {
+		of_console_options++;
+		if (*of_console_options = '\0')
+			of_console_options = NULL;
+	}
+
+	prom_printf(msg, of_console_path);
+	printk(msg, of_console_path);
+}
+
 void __init prom_build_devicetree(void)
 {
 	struct device_node **nextp;
@@ -578,6 +704,8 @@ void __init prom_build_devicetree(void)
 	allnodes->child = build_tree(allnodes,
 				     prom_getchild(allnodes->node),
 				     &nextp);
+	of_console_init();
+
 	printk("PROM: Built device tree with %u bytes of memory.\n",
 	       prom_early_allocated);
 }
diff --git a/arch/sparc/kernel/setup.c b/arch/sparc/kernel/setup.c
index 64c0ed9..f822838 100644
--- a/arch/sparc/kernel/setup.c
+++ b/arch/sparc/kernel/setup.c
@@ -146,31 +146,6 @@ static void __init process_switch(char c)
 	}
 }
 
-static void __init process_console(char *commands)
-{
-	serial_console = 0;
-	commands += 8;
-	/* Linux-style serial */
-	if (!strncmp(commands, "ttyS", 4))
-		serial_console = simple_strtoul(commands + 4, NULL, 10) + 1;
-	else if (!strncmp(commands, "tty", 3)) {
-		char c = *(commands + 3);
-		/* Solaris-style serial */
-		if (c = 'a' || c = 'b')
-			serial_console = c - 'a' + 1;
-		/* else Linux-style fbcon, not serial */
-	}
-#if defined(CONFIG_PROM_CONSOLE)
-	if (!strncmp(commands, "prom", 4)) {
-		char *p;
-
-		for (p = commands - 8; *p && *p != ' '; p++)
-			*p = ' ';
-		conswitchp = &prom_con;
-	}
-#endif
-}
-
 static void __init boot_flags_init(char *commands)
 {
 	while (*commands) {
@@ -187,9 +162,7 @@ static void __init boot_flags_init(char *commands)
 				process_switch(*commands++);
 			continue;
 		}
-		if (!strncmp(commands, "console=", 8)) {
-			process_console(commands);
-		} else if (!strncmp(commands, "mem=", 4)) {
+		if (!strncmp(commands, "mem=", 4)) {
 			/*
 			 * "mem=XXX[kKmM] overrides the PROM-reported
 			 * memory size.
@@ -341,41 +314,6 @@ void __init setup_arch(char **cmdline_p)
 	smp_setup_cpu_possible_map();
 }
 
-static int __init set_preferred_console(void)
-{
-	int idev, odev;
-
-	/* The user has requested a console so this is already set up. */
-	if (serial_console >= 0)
-		return -EBUSY;
-
-	idev = prom_query_input_device();
-	odev = prom_query_output_device();
-	if (idev = PROMDEV_IKBD && odev = PROMDEV_OSCREEN) {
-		serial_console = 0;
-	} else if (idev = PROMDEV_ITTYA && odev = PROMDEV_OTTYA) {
-		serial_console = 1;
-	} else if (idev = PROMDEV_ITTYB && odev = PROMDEV_OTTYB) {
-		serial_console = 2;
-	} else if (idev = PROMDEV_I_UNK && odev = PROMDEV_OTTYA) {
-		prom_printf("MrCoffee ttya\n");
-		serial_console = 1;
-	} else if (idev = PROMDEV_I_UNK && odev = PROMDEV_OSCREEN) {
-		serial_console = 0;
-		prom_printf("MrCoffee keyboard\n");
-	} else {
-		prom_printf("Confusing console (idev %d, odev %d)\n",
-		    idev, odev);
-		serial_console = 1;
-	}
-
-	if (serial_console)
-		return add_preferred_console("ttyS", serial_console - 1, NULL);
-
-	return -ENODEV;
-}
-console_initcall(set_preferred_console);
-
 extern char *sparc_cpu_type;
 extern char *sparc_fpu_type;
 
@@ -461,7 +399,6 @@ void sun_do_break(void)
 	prom_cmdline();
 }
 
-int serial_console = -1;
 int stop_a_enabled = 1;
 
 static int __init topology_init(void)
diff --git a/arch/sparc/prom/console.c b/arch/sparc/prom/console.c
index 4e6e41d..8d1cfb0 100644
--- a/arch/sparc/prom/console.c
+++ b/arch/sparc/prom/console.c
@@ -102,119 +102,3 @@ prom_putchar(char c)
 	while(prom_nbputchar(c) = -1) ;
 	return;
 }
-
-/* Query for input device type */
-enum prom_input_device
-prom_query_input_device(void)
-{
-	unsigned long flags;
-	int st_p;
-	char propb[64];
-	char *p;
-	int propl;
-
-	switch(prom_vers) {
-	case PROM_V0:
-	case PROM_V2:
-	case PROM_SUN4:
-	default:
-		switch(*romvec->pv_stdin) {
-		case PROMDEV_KBD:	return PROMDEV_IKBD;
-		case PROMDEV_TTYA:	return PROMDEV_ITTYA;
-		case PROMDEV_TTYB:	return PROMDEV_ITTYB;
-		default:
-			return PROMDEV_I_UNK;
-		};
-	case PROM_V3:
-		spin_lock_irqsave(&prom_lock, flags);
-		st_p = (*romvec->pv_v2devops.v2_inst2pkg)(*romvec->pv_v2bootargs.fd_stdin);
-		restore_current();
-		spin_unlock_irqrestore(&prom_lock, flags);
-		if(prom_node_has_property(st_p, "keyboard"))
-			return PROMDEV_IKBD;
-		if (prom_getproperty(st_p, "name", propb, sizeof(propb)) != -1) {
-			if(strncmp(propb, "keyboard", sizeof("serial")) = 0)
-				return PROMDEV_IKBD;
-		}
-		if (prom_getproperty(st_p, "device_type", propb, sizeof(propb)) != -1) {
-		if(strncmp(propb, "serial", sizeof("serial")))
-			return PROMDEV_I_UNK;
-		}
-		propl = prom_getproperty(prom_root_node, "stdin-path", propb, sizeof(propb));
-		if(propl > 2) {
-			p = propb;
-			while(*p) p++; p -= 2;
-			if(p[0] = ':') {
-				if(p[1] = 'a')
-					return PROMDEV_ITTYA;
-				else if(p[1] = 'b')
-					return PROMDEV_ITTYB;
-			}
-		}
-		return PROMDEV_I_UNK;
-	}
-}
-
-/* Query for output device type */
-
-enum prom_output_device
-prom_query_output_device(void)
-{
-	unsigned long flags;
-	int st_p;
-	char propb[64];
-	char *p;
-	int propl;
-
-	switch(prom_vers) {
-	case PROM_V0:
-	case PROM_SUN4:
-		switch(*romvec->pv_stdin) {
-		case PROMDEV_SCREEN:	return PROMDEV_OSCREEN;
-		case PROMDEV_TTYA:	return PROMDEV_OTTYA;
-		case PROMDEV_TTYB:	return PROMDEV_OTTYB;
-		};
-		break;
-	case PROM_V2:
-	case PROM_V3:
-		spin_lock_irqsave(&prom_lock, flags);
-		st_p = (*romvec->pv_v2devops.v2_inst2pkg)(*romvec->pv_v2bootargs.fd_stdout);
-		restore_current();
-		spin_unlock_irqrestore(&prom_lock, flags);
-		propl = prom_getproperty(st_p, "device_type", propb, sizeof(propb));
-		if (propl = sizeof("display") &&
-			strncmp("display", propb, sizeof("display")) = 0)
-		{
-			return PROMDEV_OSCREEN;
-		}
-		if(prom_vers = PROM_V3) {
-			if(propl >= 0 &&
-			    strncmp("serial", propb, sizeof("serial")) != 0)
-				return PROMDEV_O_UNK;
-			propl = prom_getproperty(prom_root_node, "stdout-path",
-						 propb, sizeof(propb));
-			if(propl = CON_SIZE_JMC &&
-			    strncmp(propb, con_name_jmc, CON_SIZE_JMC) = 0)
-				return PROMDEV_OTTYA;
-			if(propl > 2) {
-				p = propb;
-				while(*p) p++; p-= 2;
-				if(p[0]=':') {
-					if(p[1] = 'a')
-						return PROMDEV_OTTYA;
-					else if(p[1] = 'b')
-						return PROMDEV_OTTYB;
-				}
-			}
-		} else {
-			switch(*romvec->pv_stdin) {
-			case PROMDEV_TTYA:	return PROMDEV_OTTYA;
-			case PROMDEV_TTYB:	return PROMDEV_OTTYB;
-			};
-		}
-		break;
-	default:
-		;
-	};
-	return PROMDEV_O_UNK;
-}
diff --git a/arch/sparc/prom/misc.c b/arch/sparc/prom/misc.c
index 1942c7c..37cff5f 100644
--- a/arch/sparc/prom/misc.c
+++ b/arch/sparc/prom/misc.c
@@ -58,7 +58,7 @@ prom_cmdline(void)
 	extern void install_linux_ticker(void);
 	unsigned long flags;
 
-	if(!serial_console && prom_palette)
+	if (prom_palette)
 		prom_palette (1);
 	spin_lock_irqsave(&prom_lock, flags);
 	install_obp_ticker();
@@ -69,7 +69,7 @@ prom_cmdline(void)
 #ifdef CONFIG_SUN_AUXIO
 	set_auxio(AUXIO_LED, 0);
 #endif
-	if(!serial_console && prom_palette)
+	if (prom_palette)
 		prom_palette (0);
 }
 
diff --git a/arch/sparc64/kernel/power.c b/arch/sparc64/kernel/power.c
index 699b24b..d63c522 100644
--- a/arch/sparc64/kernel/power.c
+++ b/arch/sparc64/kernel/power.c
@@ -53,7 +53,7 @@ static void (*poweroff_method)(void) = machine_alt_power_off;
 
 void machine_power_off(void)
 {
-	if (!serial_console || scons_pwroff) {
+	if (strcmp(of_console_device->type, "serial") || scons_pwroff) {
 #ifdef CONFIG_PCI
 		if (power_reg) {
 			/* Both register bits seem to have the
diff --git a/arch/sparc64/kernel/process.c b/arch/sparc64/kernel/process.c
index 952762b..b921213 100644
--- a/arch/sparc64/kernel/process.c
+++ b/arch/sparc64/kernel/process.c
@@ -106,7 +106,7 @@ extern void (*prom_keyboard)(void);
 
 void machine_halt(void)
 {
-	if (!serial_console && prom_palette)
+	if (prom_palette)
 		prom_palette (1);
 	if (prom_keyboard)
 		prom_keyboard();
@@ -116,7 +116,7 @@ void machine_halt(void)
 
 void machine_alt_power_off(void)
 {
-	if (!serial_console && prom_palette)
+	if (prom_palette)
 		prom_palette(1);
 	if (prom_keyboard)
 		prom_keyboard();
@@ -130,7 +130,7 @@ void machine_restart(char * cmd)
 	
 	p = strchr (reboot_command, '\n');
 	if (p) *p = 0;
-	if (!serial_console && prom_palette)
+	if (prom_palette)
 		prom_palette (1);
 	if (prom_keyboard)
 		prom_keyboard();
diff --git a/arch/sparc64/kernel/prom.c b/arch/sparc64/kernel/prom.c
index 02830e4..48d1099 100644
--- a/arch/sparc64/kernel/prom.c
+++ b/arch/sparc64/kernel/prom.c
@@ -1665,6 +1665,60 @@ static struct device_node * __init build_tree(struct device_node *parent, phandl
 	return ret;
 }
 
+struct device_node *of_console_device;
+EXPORT_SYMBOL(of_console_device);
+
+char *of_console_path;
+EXPORT_SYMBOL(of_console_path);
+
+char *of_console_options;
+EXPORT_SYMBOL(of_console_options);
+
+static void __init of_console_init(void)
+{
+	char *msg = "OF stdout device is: %s\n";
+	struct device_node *dp;
+	const char *type;
+	phandle node;
+
+	of_console_path = prom_early_alloc(256);
+	if (prom_ihandle2path(prom_stdout, of_console_path, 256) < 0) {
+		prom_printf("Cannot obtain path of stdout.\n");
+		prom_halt();
+	}
+	of_console_options = strrchr(of_console_path, ':');
+	if (of_console_options) {
+		of_console_options++;
+		if (*of_console_options = '\0')
+			of_console_options = NULL;
+	}
+
+	node = prom_inst2pkg(prom_stdout);
+	if (!node) {
+		prom_printf("Cannot resolve stdout node from "
+			    "instance %08x.\n", prom_stdout);
+		prom_halt();
+	}
+
+	dp = of_find_node_by_phandle(node);
+	type = of_get_property(dp, "device_type", NULL);
+	if (!type) {
+		prom_printf("Console stdout lacks device_type property.\n");
+		prom_halt();
+	}
+
+	if (strcmp(type, "display") && strcmp(type, "serial")) {
+		prom_printf("Console device_type is neither display "
+			    "nor serial.\n");
+		prom_halt();
+	}
+
+	of_console_device = dp;
+
+	prom_printf(msg, of_console_path);
+	printk(msg, of_console_path);
+}
+
 void __init prom_build_devicetree(void)
 {
 	struct device_node **nextp;
@@ -1677,6 +1731,8 @@ void __init prom_build_devicetree(void)
 	allnodes->child = build_tree(allnodes,
 				     prom_getchild(allnodes->node),
 				     &nextp);
+	of_console_init();
+
 	printk("PROM: Built device tree with %u bytes of memory.\n",
 	       prom_early_allocated);
 }
diff --git a/arch/sparc64/kernel/setup.c b/arch/sparc64/kernel/setup.c
index dea9c3c..1e28bc5 100644
--- a/arch/sparc64/kernel/setup.c
+++ b/arch/sparc64/kernel/setup.c
@@ -127,33 +127,6 @@ static void __init process_switch(char c)
 	}
 }
 
-static void __init process_console(char *commands)
-{
-	serial_console = 0;
-	commands += 8;
-	/* Linux-style serial */
-	if (!strncmp(commands, "ttyS", 4))
-		serial_console = simple_strtoul(commands + 4, NULL, 10) + 1;
-	else if (!strncmp(commands, "tty", 3)) {
-		char c = *(commands + 3);
-		/* Solaris-style serial */
-		if (c = 'a' || c = 'b') {
-			serial_console = c - 'a' + 1;
-			prom_printf ("Using /dev/tty%c as console.\n", c);
-		}
-		/* else Linux-style fbcon, not serial */
-	}
-#if defined(CONFIG_PROM_CONSOLE)
-	if (!strncmp(commands, "prom", 4)) {
-		char *p;
-
-		for (p = commands - 8; *p && *p != ' '; p++)
-			*p = ' ';
-		conswitchp = &prom_con;
-	}
-#endif
-}
-
 static void __init boot_flags_init(char *commands)
 {
 	while (*commands) {
@@ -170,9 +143,7 @@ static void __init boot_flags_init(char *commands)
 				process_switch(*commands++);
 			continue;
 		}
-		if (!strncmp(commands, "console=", 8)) {
-			process_console(commands);
-		} else if (!strncmp(commands, "mem=", 4)) {
+		if (!strncmp(commands, "mem=", 4)) {
 			/*
 			 * "mem=XXX[kKmM]" overrides the PROM-reported
 			 * memory size.
@@ -374,44 +345,6 @@ void __init setup_arch(char **cmdline_p)
 	smp_setup_cpu_possible_map();
 }
 
-static int __init set_preferred_console(void)
-{
-	int idev, odev;
-
-	/* The user has requested a console so this is already set up. */
-	if (serial_console >= 0)
-		return -EBUSY;
-
-	idev = prom_query_input_device();
-	odev = prom_query_output_device();
-	if (idev = PROMDEV_IKBD && odev = PROMDEV_OSCREEN) {
-		serial_console = 0;
-	} else if (idev = PROMDEV_ITTYA && odev = PROMDEV_OTTYA) {
-		serial_console = 1;
-	} else if (idev = PROMDEV_ITTYB && odev = PROMDEV_OTTYB) {
-		serial_console = 2;
-	} else if (idev = PROMDEV_IRSC && odev = PROMDEV_ORSC) {
-		serial_console = 3;
-	} else if (idev = PROMDEV_IVCONS && odev = PROMDEV_OVCONS) {
-		/* sunhv_console_init() doesn't check the serial_console
-		 * value anyways...
-		 */
-		serial_console = 4;
-		return add_preferred_console("ttyHV", 0, NULL);
-	} else {
-		prom_printf("Inconsistent console: "
-			    "input %d, output %d\n",
-			    idev, odev);
-		prom_halt();
-	}
-
-	if (serial_console)
-		return add_preferred_console("ttyS", serial_console - 1, NULL);
-
-	return -ENODEV;
-}
-console_initcall(set_preferred_console);
-
 /* BUFFER is PAGE_SIZE bytes long. */
 
 extern char *sparc_cpu_type;
@@ -507,7 +440,6 @@ void sun_do_break(void)
 	prom_cmdline();
 }
 
-int serial_console = -1;
 int stop_a_enabled = 1;
 
 static int __init topology_init(void)
diff --git a/arch/sparc64/kernel/sparc64_ksyms.c b/arch/sparc64/kernel/sparc64_ksyms.c
index d00f51a..3455593 100644
--- a/arch/sparc64/kernel/sparc64_ksyms.c
+++ b/arch/sparc64/kernel/sparc64_ksyms.c
@@ -342,7 +342,6 @@ EXPORT_SYMBOL(VISenter);
 
 /* for input/keybdev */
 EXPORT_SYMBOL(sun_do_break);
-EXPORT_SYMBOL(serial_console);
 EXPORT_SYMBOL(stop_a_enabled);
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
diff --git a/arch/sparc64/prom/console.c b/arch/sparc64/prom/console.c
index 7c25c54..3fafa9a 100644
--- a/arch/sparc64/prom/console.c
+++ b/arch/sparc64/prom/console.c
@@ -73,88 +73,3 @@ prom_puts(const char *s, int len)
 			   P1275_INOUT(3,1),
 			   prom_stdout, s, P1275_SIZE(len));
 }
-
-/* Query for input device type */
-enum prom_input_device
-prom_query_input_device(void)
-{
-	int st_p;
-	char propb[64];
-
-	st_p = prom_inst2pkg(prom_stdin);
-	if(prom_node_has_property(st_p, "keyboard"))
-		return PROMDEV_IKBD;
-	prom_getproperty(st_p, "device_type", propb, sizeof(propb));
-	if(strncmp(propb, "serial", 6))
-		return PROMDEV_I_UNK;
-	/* FIXME: Is there any better way how to find out? */	
-	memset(propb, 0, sizeof(propb));
-	st_p = prom_finddevice ("/options");
-	prom_getproperty(st_p, "input-device", propb, sizeof(propb));
-
-	/*
-	 * If we get here with propb = 'keyboard', we are on ttya, as
-	 * the PROM defaulted to this due to 'no input device'.
-	 */
-	if (!strncmp(propb, "keyboard", 8))
-		return PROMDEV_ITTYA;
-
-	if (!strncmp (propb, "rsc", 3))
-		return PROMDEV_IRSC;
-
-	if (!strncmp (propb, "virtual-console", 3))
-		return PROMDEV_IVCONS;
-
-	if (strncmp (propb, "tty", 3) || !propb[3])
-		return PROMDEV_I_UNK;
-
-	switch (propb[3]) {
-		case 'a': return PROMDEV_ITTYA;
-		case 'b': return PROMDEV_ITTYB;
-		default: return PROMDEV_I_UNK;
-	}
-}
-
-/* Query for output device type */
-
-enum prom_output_device
-prom_query_output_device(void)
-{
-	int st_p;
-	char propb[64];
-	int propl;
-
-	st_p = prom_inst2pkg(prom_stdout);
-	propl = prom_getproperty(st_p, "device_type", propb, sizeof(propb));
-	if (propl >= 0 && propl = sizeof("display") &&
-	    strncmp("display", propb, sizeof("display")) = 0)
-		return PROMDEV_OSCREEN;
-	if(strncmp("serial", propb, 6))
-		return PROMDEV_O_UNK;
-	/* FIXME: Is there any better way how to find out? */	
-	memset(propb, 0, sizeof(propb));
-	st_p = prom_finddevice ("/options");
-	prom_getproperty(st_p, "output-device", propb, sizeof(propb));
-
-	/*
-	 * If we get here with propb = 'screen', we are on ttya, as
-	 * the PROM defaulted to this due to 'no input device'.
-	 */
-	if (!strncmp(propb, "screen", 6))
-		return PROMDEV_OTTYA;
-
-	if (!strncmp (propb, "rsc", 3))
-		return PROMDEV_ORSC;
-
-	if (!strncmp (propb, "virtual-console", 3))
-		return PROMDEV_OVCONS;
-
-	if (strncmp (propb, "tty", 3) || !propb[3])
-		return PROMDEV_O_UNK;
-
-	switch (propb[3]) {
-		case 'a': return PROMDEV_OTTYA;
-		case 'b': return PROMDEV_OTTYB;
-		default: return PROMDEV_O_UNK;
-	}
-}
diff --git a/arch/sparc64/prom/misc.c b/arch/sparc64/prom/misc.c
index 0b42137..77ee0cf 100644
--- a/arch/sparc64/prom/misc.c
+++ b/arch/sparc64/prom/misc.c
@@ -48,7 +48,7 @@ void prom_cmdline(void)
 
 	local_irq_save(flags);
 
-	if (!serial_console && prom_palette)
+	if (prom_palette)
 		prom_palette(1);
 
 #ifdef CONFIG_SMP
@@ -61,7 +61,7 @@ void prom_cmdline(void)
 	smp_release();
 #endif
 
-	if (!serial_console && prom_palette)
+	if (prom_palette)
 		prom_palette(0);
 
 	local_irq_restore(flags);
diff --git a/arch/sparc64/prom/tree.c b/arch/sparc64/prom/tree.c
index 500f05e..9c2d5de 100644
--- a/arch/sparc64/prom/tree.c
+++ b/arch/sparc64/prom/tree.c
@@ -295,3 +295,11 @@ prom_pathtoinode(const char *path)
 	if (node = -1) return 0;
 	return node;
 }
+
+int prom_ihandle2path(int handle, char *buffer, int bufsize)
+{
+	return p1275_cmd("instance-to-path", 
+			 P1275_ARG(1,P1275_ARG_OUT_BUF)|
+			 P1275_INOUT(3, 1), 
+			 handle, buffer, P1275_SIZE(bufsize));
+}
diff --git a/drivers/serial/suncore.c b/drivers/serial/suncore.c
index e35d9ab..d2ecf48 100644
--- a/drivers/serial/suncore.c
+++ b/drivers/serial/suncore.c
@@ -16,9 +16,10 @@
 #include <linux/tty.h>
 #include <linux/errno.h>
 #include <linux/string.h>
+#include <linux/serial_core.h>
 #include <linux/init.h>
 
-#include <asm/oplib.h>
+#include <asm/prom.h>
 
 #include "suncore.h"
 
@@ -26,92 +27,60 @@ int sunserial_current_minor = 64;
 
 EXPORT_SYMBOL(sunserial_current_minor);
 
-void
-sunserial_console_termios(struct console *con)
+int sunserial_console_match(struct console *con, struct device_node *dp,
+			    struct uart_driver *drv, int line)
 {
-	char mode[16], buf[16], *s;
-	char *mode_prop = "ttyX-mode";
-	char *cd_prop = "ttyX-ignore-cd";
-	char *dtr_prop = "ttyX-rts-dtr-off";
-	char *ssp_console_modes_prop = "ssp-console-modes";
-	int baud, bits, stop, cflag;
-	char parity;
-	int carrier = 0;
-	int rtsdtr = 1;
-	int topnd, nd;
-
-	if (!serial_console)
-		return;
-
-	switch (serial_console) {
-	case PROMDEV_OTTYA:
-		mode_prop[3] = 'a';
-		cd_prop[3] = 'a';
-		dtr_prop[3] = 'a';
-		break;
-
-	case PROMDEV_OTTYB:
-		mode_prop[3] = 'b';
-		cd_prop[3] = 'b';
-		dtr_prop[3] = 'b';
-		break;
-
-	case PROMDEV_ORSC:
-
-		nd = prom_pathtoinode("rsc");
-		if (!nd) {
-			strcpy(mode, "115200,8,n,1,-");
-			goto no_options;
-		}
+	int off;
 
-		if (!prom_node_has_property(nd, ssp_console_modes_prop)) {
-			strcpy(mode, "115200,8,n,1,-");
-			goto no_options;
-		}
+	if (!con || of_console_device != dp)
+		return 0;
 
-		memset(mode, 0, sizeof(mode));
-		prom_getstring(nd, ssp_console_modes_prop, mode, sizeof(mode));
-		goto no_options;
+	off = 0;
+	if (of_console_options &&
+	    *of_console_options = 'b')
+		off = 1;
 
-	default:
-		strcpy(mode, "9600,8,n,1,-");
-		goto no_options;
-	}
+	if ((line & 1) != off)
+		return 0;
 
-	topnd = prom_getchild(prom_root_node);
-	nd = prom_searchsiblings(topnd, "options");
-	if (!nd) {
-		strcpy(mode, "9600,8,n,1,-");
-		goto no_options;
-	}
-
-	if (!prom_node_has_property(nd, mode_prop)) {
-		strcpy(mode, "9600,8,n,1,-");
-		goto no_options;
-	}
+	con->index = line;
+	drv->cons = con;
+	add_preferred_console(con->name, line, NULL);
 
-	memset(mode, 0, sizeof(mode));
-	prom_getstring(nd, mode_prop, mode, sizeof(mode));
-
-	if (prom_node_has_property(nd, cd_prop)) {
-		memset(buf, 0, sizeof(buf));
-		prom_getstring(nd, cd_prop, buf, sizeof(buf));
-		if (!strcmp(buf, "false"))
-			carrier = 1;
-
-		/* XXX: this is unused below. */
-	}
+	return 1;
+}
+EXPORT_SYMBOL(sunserial_console_match);
 
-	if (prom_node_has_property(nd, dtr_prop)) {
-		memset(buf, 0, sizeof(buf));
-		prom_getstring(nd, dtr_prop, buf, sizeof(buf));
-		if (!strcmp(buf, "false"))
-			rtsdtr = 0;
+void
+sunserial_console_termios(struct console *con)
+{
+	struct device_node *dp;
+	const char *od, *mode, *s;
+	char *mode_prop = "ttyX-mode";
+	int baud, bits, stop, cflag;
+	char parity;
 
-		/* XXX: this is unused below. */
+	dp = of_find_node_by_path("/options");
+	od = of_get_property(dp, "output-device", NULL);
+	if (!strcmp(od, "rsc")) {
+		mode = of_get_property(of_console_device,
+				       "ssp-console-modes", NULL);
+		if (!mode)
+			mode = "115200,8,n,1,-";
+	} else {
+		char c;
+
+		c = 'a';
+		if (of_console_options)
+			c = *of_console_options;
+
+		mode_prop[3] = c;
+
+		mode = of_get_property(dp, mode_prop, NULL);
+		if (!mode)
+			mode = "9600,8,n,1,-";
 	}
 
-no_options:
 	cflag = CREAD | HUPCL | CLOCAL;
 
 	s = mode;
diff --git a/drivers/serial/suncore.h b/drivers/serial/suncore.h
index 513916a..829d7d6 100644
--- a/drivers/serial/suncore.h
+++ b/drivers/serial/suncore.h
@@ -24,6 +24,8 @@ extern int suncore_mouse_baud_detection(unsigned char, int);
 
 extern int sunserial_current_minor;
 
+extern int sunserial_console_match(struct console *, struct device_node *,
+				   struct uart_driver *, int);
 extern void sunserial_console_termios(struct console *);
 
 #endif /* !(_SERIAL_SUN_H) */
diff --git a/drivers/serial/sunhv.c b/drivers/serial/sunhv.c
index 96557e6..617c3e0 100644
--- a/drivers/serial/sunhv.c
+++ b/drivers/serial/sunhv.c
@@ -508,16 +508,6 @@ static struct console sunhv_console = {
 	.data	=	&sunhv_reg,
 };
 
-static inline struct console *SUNHV_CONSOLE(void)
-{
-	if (con_is_present())
-		return NULL;
-
-	sunhv_console.index = 0;
-
-	return &sunhv_console;
-}
-
 static int __devinit hv_probe(struct of_device *op, const struct of_device_id *match)
 {
 	struct uart_port *port;
@@ -570,7 +560,8 @@ static int __devinit hv_probe(struct of_device *op, const struct of_device_id *m
 	sunhv_reg.tty_driver->name_base = sunhv_reg.minor - 64;
 	sunserial_current_minor += 1;
 
-	sunhv_reg.cons = SUNHV_CONSOLE();
+	sunserial_console_match(&sunhv_console, op->node,
+				&sunhv_reg, port->line);
 
 	err = uart_add_one_port(&sunhv_reg, port);
 	if (err)
diff --git a/drivers/serial/sunsab.c b/drivers/serial/sunsab.c
index deb9ab4..4733496 100644
--- a/drivers/serial/sunsab.c
+++ b/drivers/serial/sunsab.c
@@ -959,22 +959,6 @@ static struct console sunsab_console = {
 
 static inline struct console *SUNSAB_CONSOLE(void)
 {
-	int i;
-
-	if (con_is_present())
-		return NULL;
-
-	for (i = 0; i < num_channels; i++) {
-		int this_minor = sunsab_reg.minor + i;
-
-		if ((this_minor - 64) = (serial_console - 1))
-			break;
-	}
-	if (i = num_channels)
-		return NULL;
-
-	sunsab_console.index = i;
-
 	return &sunsab_console;
 }
 #else
@@ -1071,7 +1055,12 @@ static int __devinit sab_probe(struct of_device *op, const struct of_device_id *
 		return err;
 	}
 
+	sunserial_console_match(SUNSAB_CONSOLE(), op->node,
+				&sunsab_reg, up[0].port.line);
 	uart_add_one_port(&sunsab_reg, &up[0].port);
+
+	sunserial_console_match(SUNSAB_CONSOLE(), op->node,
+				&sunsab_reg, up[1].port.line);
 	uart_add_one_port(&sunsab_reg, &up[1].port);
 
 	dev_set_drvdata(&op->dev, &up[0]);
@@ -1155,7 +1144,6 @@ static int __init sunsab_init(void)
 		}
 
 		sunsab_reg.tty_driver->name_base = sunsab_reg.minor - 64;
-		sunsab_reg.cons = SUNSAB_CONSOLE();
 		sunserial_current_minor += num_channels;
 	}
 
diff --git a/drivers/serial/sunsu.c b/drivers/serial/sunsu.c
index 2a63cdb..1902424 100644
--- a/drivers/serial/sunsu.c
+++ b/drivers/serial/sunsu.c
@@ -1357,28 +1357,12 @@ static struct console sunsu_console = {
  *	Register console.
  */
 
-static inline struct console *SUNSU_CONSOLE(int num_uart)
+static inline struct console *SUNSU_CONSOLE(void)
 {
-	int i;
-
-	if (con_is_present())
-		return NULL;
-
-	for (i = 0; i < num_uart; i++) {
-		int this_minor = sunsu_reg.minor + i;
-
-		if ((this_minor - 64) = (serial_console - 1))
-			break;
-	}
-	if (i = num_uart)
-		return NULL;
-
-	sunsu_console.index = i;
-
 	return &sunsu_console;
 }
 #else
-#define SUNSU_CONSOLE(num_uart)		(NULL)
+#define SUNSU_CONSOLE()			(NULL)
 #define sunsu_serial_console_init()	do { } while (0)
 #endif
 
@@ -1468,6 +1452,8 @@ static int __devinit su_probe(struct of_device *op, const struct of_device_id *m
 
 	up->port.ops = &sunsu_pops;
 
+	sunserial_console_match(SUNSU_CONSOLE(), dp,
+				&sunsu_reg, up->port.line);
 	err = uart_add_one_port(&sunsu_reg, &up->port);
 	if (err)
 		goto out_unmap;
@@ -1558,7 +1544,6 @@ static int __init sunsu_init(void)
 			return err;
 		sunsu_reg.tty_driver->name_base = sunsu_reg.minor - 64;
 		sunserial_current_minor += num_uart;
-		sunsu_reg.cons = SUNSU_CONSOLE(num_uart);
 	}
 
 	err = of_register_driver(&su_driver, &of_bus_type);
diff --git a/drivers/serial/sunzilog.c b/drivers/serial/sunzilog.c
index 15b6e1c..6d907c3 100644
--- a/drivers/serial/sunzilog.c
+++ b/drivers/serial/sunzilog.c
@@ -1215,23 +1215,6 @@ static struct console sunzilog_console_ops = {
 
 static inline struct console *SUNZILOG_CONSOLE(void)
 {
-	int i;
-
-	if (con_is_present())
-		return NULL;
-
-	for (i = 0; i < NUM_CHANNELS; i++) {
-		int this_minor = sunzilog_reg.minor + i;
-
-		if ((this_minor - 64) = (serial_console - 1))
-			break;
-	}
-	if (i = NUM_CHANNELS)
-		return NULL;
-
-	sunzilog_console_ops.index = i;
-	sunzilog_port_table[i].flags |= SUNZILOG_FLAG_IS_CONS;
-
 	return &sunzilog_console_ops;
 }
 
@@ -1417,12 +1400,18 @@ static int __devinit zs_probe(struct of_device *op, const struct of_device_id *m
 	sunzilog_init_hw(&up[1]);
 
 	if (!keyboard_mouse) {
+		if (sunserial_console_match(SUNZILOG_CONSOLE(), op->node,
+					    &sunzilog_reg, up[0].port.line))
+			up->flags |= SUNZILOG_FLAG_IS_CONS;
 		err = uart_add_one_port(&sunzilog_reg, &up[0].port);
 		if (err) {
 			of_iounmap(&op->resource[0],
 				   rp, sizeof(struct zilog_layout));
 			return err;
 		}
+		if (sunserial_console_match(SUNZILOG_CONSOLE(), op->node,
+					    &sunzilog_reg, up[1].port.line))
+			up->flags |= SUNZILOG_FLAG_IS_CONS;
 		err = uart_add_one_port(&sunzilog_reg, &up[1].port);
 		if (err) {
 			uart_remove_one_port(&sunzilog_reg, &up[0].port);
@@ -1520,7 +1509,6 @@ static int __init sunzilog_init(void)
 			goto out_free_tables;
 
 		sunzilog_reg.tty_driver->name_base = sunzilog_reg.minor - 64;
-		sunzilog_reg.cons = SUNZILOG_CONSOLE();
 
 		sunserial_current_minor += uart_count;
 	}
diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index 8d3455d..4b0cc29 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -2914,10 +2914,6 @@ static int __devinit atyfb_setup_sparc(struct pci_dev *pdev,
 	int node, len, i, j, ret;
 	u32 mem, chip_id;
 
-	/* Do not attach when we have a serial console. */
-	if (!con_is_present())
-		return -ENXIO;
-
 	/*
 	 * Map memory-mapped registers.
 	 */
diff --git a/drivers/video/igafb.c b/drivers/video/igafb.c
index eb1a481..b87ea21 100644
--- a/drivers/video/igafb.c
+++ b/drivers/video/igafb.c
@@ -379,10 +379,6 @@ int __init igafb_init(void)
 	if (fb_get_options("igafb", NULL))
 		return -ENODEV;
 
-        /* Do not attach when we have a serial console. */
-        if (!con_is_present())
-                return -ENXIO;
-
         pdev = pci_get_device(PCI_VENDOR_ID_INTERG,
                                PCI_DEVICE_ID_INTERG_1682, 0);
 	if (pdev = NULL) {
diff --git a/include/asm-sparc/oplib.h b/include/asm-sparc/oplib.h
index 91691e5..17ba82e 100644
--- a/include/asm-sparc/oplib.h
+++ b/include/asm-sparc/oplib.h
@@ -158,32 +158,6 @@ extern void prom_putchar(char character);
 extern void prom_printf(char *fmt, ...);
 extern void prom_write(const char *buf, unsigned int len);
 
-/* Query for input device type */
-
-enum prom_input_device {
-	PROMDEV_IKBD,			/* input from keyboard */
-	PROMDEV_ITTYA,			/* input from ttya */
-	PROMDEV_ITTYB,			/* input from ttyb */
-	PROMDEV_IRSC,			/* input from rsc */
-	PROMDEV_IVCONS,			/* input from virtual-console */
-	PROMDEV_I_UNK,
-};
-
-extern enum prom_input_device prom_query_input_device(void);
-
-/* Query for output device type */
-
-enum prom_output_device {
-	PROMDEV_OSCREEN,		/* to screen */
-	PROMDEV_OTTYA,			/* to ttya */
-	PROMDEV_OTTYB,			/* to ttyb */
-	PROMDEV_ORSC,			/* to rsc */
-	PROMDEV_OVCONS,			/* to virtual-console */
-	PROMDEV_O_UNK,
-};
-
-extern enum prom_output_device prom_query_output_device(void);
-
 /* Multiprocessor operations... */
 
 /* Start the CPU with the given device tree node, context table, and context
diff --git a/include/asm-sparc/prom.h b/include/asm-sparc/prom.h
index 9ea105e..86bd097 100644
--- a/include/asm-sparc/prom.h
+++ b/include/asm-sparc/prom.h
@@ -103,5 +103,9 @@ extern int of_n_size_cells(struct device_node *np);
 
 extern void prom_build_devicetree(void);
 
+extern struct device_node *of_console_device;
+extern char *of_console_path;
+extern char *of_console_options;
+
 #endif /* __KERNEL__ */
 #endif /* _SPARC_PROM_H */
diff --git a/include/asm-sparc64/oplib.h b/include/asm-sparc64/oplib.h
index 6a0da3b..cebd1ff 100644
--- a/include/asm-sparc64/oplib.h
+++ b/include/asm-sparc64/oplib.h
@@ -140,32 +140,6 @@ extern void prom_putchar(char character);
 extern void prom_printf(const char *fmt, ...);
 extern void prom_write(const char *buf, unsigned int len);
 
-/* Query for input device type */
-
-enum prom_input_device {
-	PROMDEV_IKBD,			/* input from keyboard */
-	PROMDEV_ITTYA,			/* input from ttya */
-	PROMDEV_ITTYB,			/* input from ttyb */
-	PROMDEV_IRSC,			/* input from rsc */
-	PROMDEV_IVCONS,			/* input from virtual-console */
-	PROMDEV_I_UNK,
-};
-
-extern enum prom_input_device prom_query_input_device(void);
-
-/* Query for output device type */
-
-enum prom_output_device {
-	PROMDEV_OSCREEN,		/* to screen */
-	PROMDEV_OTTYA,			/* to ttya */
-	PROMDEV_OTTYB,			/* to ttyb */
-	PROMDEV_ORSC,			/* to rsc */
-	PROMDEV_OVCONS,			/* to virtual-console */
-	PROMDEV_O_UNK,
-};
-
-extern enum prom_output_device prom_query_output_device(void);
-
 /* Multiprocessor operations... */
 #ifdef CONFIG_SMP
 /* Start the CPU with the given device tree node at the passed program
@@ -317,6 +291,8 @@ extern int prom_setprop(int node, const char *prop_name, char *prop_value,
 extern int prom_pathtoinode(const char *path);
 extern int prom_inst2pkg(int);
 
+extern int prom_ihandle2path(int handle, char *buffer, int bufsize);
+
 /* CPU probing helpers.  */
 struct device_node;
 int cpu_find_by_instance(int instance, struct device_node **dev_node, int *mid);
diff --git a/include/asm-sparc64/prom.h b/include/asm-sparc64/prom.h
index ddad5f9..06869e2 100644
--- a/include/asm-sparc64/prom.h
+++ b/include/asm-sparc64/prom.h
@@ -111,5 +111,9 @@ extern int of_n_size_cells(struct device_node *np);
 
 extern void prom_build_devicetree(void);
 
+extern struct device_node *of_console_device;
+extern char *of_console_path;
+extern char *of_console_options;
+
 #endif /* __KERNEL__ */
 #endif /* _SPARC64_PROM_H */
diff --git a/include/asm-sparc64/system.h b/include/asm-sparc64/system.h
index 8ba380e..f43ae80 100644
--- a/include/asm-sparc64/system.h
+++ b/include/asm-sparc64/system.h
@@ -115,14 +115,8 @@ do {	__asm__ __volatile__("ba,pt	%%xcc, 1f\n\t" \
 #ifndef __ASSEMBLY__
 
 extern void sun_do_break(void);
-extern int serial_console;
 extern int stop_a_enabled;
 
-static __inline__ int con_is_present(void)
-{
-	return serial_console ? 0 : 1;
-}
-
 extern void synchronize_user_stack(void);
 
 extern void __flushw_user(void);
-- 
1.5.2

