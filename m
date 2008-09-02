From: David Miller <davem@davemloft.net>
Date: Tue, 02 Sep 2008 07:52:24 +0000
Subject: [PATCH]: sparc64: Implement SSTATE purely using notifiers and
Message-Id: <20080902.005224.193688339.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc64: Implement SSTATE purely using notifiers and initcalls.

Don't clutter up the tree with sstate_blah() scattered all over the
place.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/bugs.h   |    7 ----
 arch/sparc/include/asm/sstate.h |   13 -------
 arch/sparc64/kernel/hvapi.c     |    3 --
 arch/sparc64/kernel/reboot.c    |    4 --
 arch/sparc64/kernel/sstate.c    |   67 ++++++++++++++++++++++++++-------------
 arch/sparc64/mm/init.c          |    3 --
 6 files changed, 45 insertions(+), 52 deletions(-)
 delete mode 100644 arch/sparc/include/asm/sstate.h

diff --git a/arch/sparc/include/asm/bugs.h b/arch/sparc/include/asm/bugs.h
index e179bc1..61d86bb 100644
--- a/arch/sparc/include/asm/bugs.h
+++ b/arch/sparc/include/asm/bugs.h
@@ -7,10 +7,6 @@
 #include <asm/cpudata.h>
 #endif
 
-#ifdef CONFIG_SPARC64
-#include <asm/sstate.h>
-#endif
-
 extern unsigned long loops_per_jiffy;
 
 static void __init check_bugs(void)
@@ -18,7 +14,4 @@ static void __init check_bugs(void)
 #if defined(CONFIG_SPARC32) && !defined(CONFIG_SMP)
 	cpu_data(0).udelay_val = loops_per_jiffy;
 #endif
-#ifdef CONFIG_SPARC64
-	sstate_running();
-#endif
 }
diff --git a/arch/sparc/include/asm/sstate.h b/arch/sparc/include/asm/sstate.h
deleted file mode 100644
index a7c35db..0000000
--- a/arch/sparc/include/asm/sstate.h
+++ /dev/null
@@ -1,13 +0,0 @@
-#ifndef _SPARC64_SSTATE_H
-#define _SPARC64_SSTATE_H
-
-extern void sstate_booting(void);
-extern void sstate_running(void);
-extern void sstate_halt(void);
-extern void sstate_poweroff(void);
-extern void sstate_panic(void);
-extern void sstate_reboot(void);
-
-extern void sun4v_sstate_init(void);
-
-#endif /* _SPARC64_SSTATE_H */
diff --git a/arch/sparc64/kernel/hvapi.c b/arch/sparc64/kernel/hvapi.c
index 691760b..1d272c3 100644
--- a/arch/sparc64/kernel/hvapi.c
+++ b/arch/sparc64/kernel/hvapi.c
@@ -9,7 +9,6 @@
 
 #include <asm/hypervisor.h>
 #include <asm/oplib.h>
-#include <asm/sstate.h>
 
 /* If the hypervisor indicates that the API setting
  * calls are unsupported, by returning HV_EBADTRAP or
@@ -184,8 +183,6 @@ void __init sun4v_hvapi_init(void)
 	if (sun4v_hvapi_register(group, major, &minor))
 		goto bad;
 
-	sun4v_sstate_init();
-
 	return;
 
 bad:
diff --git a/arch/sparc64/kernel/reboot.c b/arch/sparc64/kernel/reboot.c
index 04dd34c..11f2496 100644
--- a/arch/sparc64/kernel/reboot.c
+++ b/arch/sparc64/kernel/reboot.c
@@ -7,7 +7,6 @@
 #include <linux/module.h>
 #include <linux/pm.h>
 
-#include <asm/sstate.h>
 #include <asm/oplib.h>
 #include <asm/prom.h>
 
@@ -24,7 +23,6 @@ EXPORT_SYMBOL(pm_power_off);
 
 void machine_power_off(void)
 {
-	sstate_poweroff();
 	if (strcmp(of_console_device->type, "serial") || scons_pwroff)
 		prom_halt_power_off();
 
@@ -33,7 +31,6 @@ void machine_power_off(void)
 
 void machine_halt(void)
 {
-	sstate_halt();
 	prom_halt();
 	panic("Halt failed!");
 }
@@ -42,7 +39,6 @@ void machine_restart(char *cmd)
 {
 	char *p;
 
-	sstate_reboot();
 	p = strchr(reboot_command, '\n');
 	if (p)
 		*p = 0;
diff --git a/arch/sparc64/kernel/sstate.c b/arch/sparc64/kernel/sstate.c
index 5b6e75b..8cdbe59 100644
--- a/arch/sparc64/kernel/sstate.c
+++ b/arch/sparc64/kernel/sstate.c
@@ -1,14 +1,15 @@
 /* sstate.c: System soft state support.
  *
- * Copyright (C) 2007 David S. Miller <davem@davemloft.net>
+ * Copyright (C) 2007, 2008 David S. Miller <davem@davemloft.net>
  */
 
 #include <linux/kernel.h>
 #include <linux/notifier.h>
+#include <linux/reboot.h>
 #include <linux/init.h>
 
 #include <asm/hypervisor.h>
-#include <asm/sstate.h>
+#include <asm/spitfire.h>
 #include <asm/oplib.h>
 #include <asm/head.h>
 #include <asm/io.h>
@@ -50,31 +51,34 @@ static const char rebooting_msg[32] __attribute__((aligned(32)))  static const char panicing_msg[32] __attribute__((aligned(32)))  	"Linux panicing";
 
-void sstate_booting(void)
+static int sstate_reboot_call(struct notifier_block *np, unsigned long type, void *_unused)
 {
-	do_set_sstate(HV_SOFT_STATE_TRANSITION, booting_msg);
-}
+	const char *msg;
 
-void sstate_running(void)
-{
-	do_set_sstate(HV_SOFT_STATE_NORMAL, running_msg);
-}
+	switch (type) {
+	case SYS_DOWN:
+	default:
+		msg = rebooting_msg;
+		break;
 
-void sstate_halt(void)
-{
-	do_set_sstate(HV_SOFT_STATE_TRANSITION, halting_msg);
-}
+	case SYS_HALT:
+		msg = halting_msg;
+		break;
 
-void sstate_poweroff(void)
-{
-	do_set_sstate(HV_SOFT_STATE_TRANSITION, poweroff_msg);
-}
+	case SYS_POWER_OFF:
+		msg = poweroff_msg;
+		break;
+	}
 
-void sstate_reboot(void)
-{
-	do_set_sstate(HV_SOFT_STATE_TRANSITION, rebooting_msg);
+	do_set_sstate(HV_SOFT_STATE_TRANSITION, msg);
+
+	return NOTIFY_OK;
 }
 
+static struct notifier_block sstate_reboot_notifier = {
+	.notifier_call = sstate_reboot_call,
+};
+
 static int sstate_panic_event(struct notifier_block *n, unsigned long event, void *ptr)
 {
 	do_set_sstate(HV_SOFT_STATE_TRANSITION, panicing_msg);
@@ -87,18 +91,37 @@ static struct notifier_block sstate_panic_block = {
 	.priority	=	INT_MAX,
 };
 
-void __init sun4v_sstate_init(void)
+static int __init sstate_init(void)
 {
 	unsigned long major, minor;
 
+	if (tlb_type != hypervisor)
+		return 0;
+
 	major = 1;
 	minor = 0;
 	if (sun4v_hvapi_register(HV_GRP_SOFT_STATE, major, &minor))
-		return;
+		return 0;
 
 	hv_supports_soft_state = 1;
 
 	prom_sun4v_guest_soft_state();
+
+	do_set_sstate(HV_SOFT_STATE_TRANSITION, booting_msg);
+
 	atomic_notifier_chain_register(&panic_notifier_list,
 				       &sstate_panic_block);
+	register_reboot_notifier(&sstate_reboot_notifier);
+
+	return 0;
 }
+
+core_initcall(sstate_init);
+
+static int __init sstate_running(void)
+{
+	do_set_sstate(HV_SOFT_STATE_NORMAL, running_msg);
+	return 0;
+}
+
+late_initcall(sstate_running);
diff --git a/arch/sparc64/mm/init.c b/arch/sparc64/mm/init.c
index 54193f2..7c3c81f 100644
--- a/arch/sparc64/mm/init.c
+++ b/arch/sparc64/mm/init.c
@@ -46,7 +46,6 @@
 #include <asm/tsb.h>
 #include <asm/hypervisor.h>
 #include <asm/prom.h>
-#include <asm/sstate.h>
 #include <asm/mdesc.h>
 #include <asm/cpudata.h>
 #include <asm/irq.h>
@@ -1717,8 +1716,6 @@ void __init paging_init(void)
 	kern_base = (prom_boot_mapping_phys_low >> 22UL) << 22UL;
 	kern_size = (unsigned long)&_end - (unsigned long)KERNBASE;
 
-	sstate_booting();
-
 	/* Invalidate both kernel TSBs.  */
 	memset(swapper_tsb, 0x40, sizeof(swapper_tsb));
 #ifndef CONFIG_DEBUG_PAGEALLOC
-- 
1.5.6.5.GIT

