From: Meelis Roos <mroos@linux.ee>
Date: Thu, 05 Feb 2009 14:07:14 +0000
Subject: hang on panic, can not return to OBP
Message-Id: <Pine.SOC.4.64.0902051204550.17957@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,

I started to debug my latest problem with Quad HME. First there is a 
OF mapping problem, then on quad also a IRQ problem, these I did not 
touch. Then came prontk recursion problem that caused panic, this I did 
not touch yet. The panic told I cpuld return to PROM with Stop-A but I 
couldn't, and this was the problem I tried to solve.

First, why tell the user to press Stop-A or break at all? Is it because 
we can extract information from Break-T, Break-P etc? Otherwise the 
panic code could drop to prom itself?

I tried the following patch and that did not work - probably because of 
the same reason that Break did not work (interrupts off?). Seems the 
local_irq_enable() is not enough - but what could help here? Is 
prom_halt() the right thing? ... Kad a look of waht Stop-A does, tried 
also the second patch... but if it would have worked, Stop-A wouldb 
prpbaly also have.

This patch is of course not even close to merging, it's just a hack to 
try it out.

diff --git a/kernel/panic.c b/kernel/panic.c
index 2a2ff36..ffe6f2a 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -22,6 +22,9 @@
 #include <linux/random.h>
 #include <linux/kallsyms.h>
 #include <linux/dmi.h>
+#ifdef __sparc__
+#include <asm/oplib.h>
+#endif
 
 int panic_on_oops;
 static unsigned long tainted_mask;
@@ -120,13 +123,16 @@ NORET_TYPE void panic(const char * fmt, ...)
 		extern int stop_a_enabled;
 		/* Make sure the user can actually press Stop-A (L1-A) */
 		stop_a_enabled = 1;
-		printk(KERN_EMERG "Press Stop-A (L1-A) to return to the boot prom\n");
+		printk(KERN_EMERG "Returning to the boot prom\n");
 	}
 #endif
 #if defined(CONFIG_S390)
 	disabled_wait(caller);
 #endif
 	local_irq_enable();
+#ifdef __sparc__
+	prom_halt();
+#endif
 	for (i = 0;;) {
 		touch_softlockup_watchdog();
 		i += panic_blink(i);


And the other one:

diff --git a/kernel/panic.c b/kernel/panic.c
index 2a2ff36..df46a5c 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -22,6 +22,9 @@
 #include <linux/random.h>
 #include <linux/kallsyms.h>
 #include <linux/dmi.h>
+#ifdef __sparc__
+#include <asm/oplib.h>
+#endif
 
 int panic_on_oops;
 static unsigned long tainted_mask;
@@ -120,13 +123,19 @@ NORET_TYPE void panic(const char * fmt, ...)
 		extern int stop_a_enabled;
 		/* Make sure the user can actually press Stop-A (L1-A) */
 		stop_a_enabled = 1;
-		printk(KERN_EMERG "Press Stop-A (L1-A) to return to the boot prom\n");
+		printk(KERN_EMERG "Returning to the boot prom\n");
 	}
 #endif
 #if defined(CONFIG_S390)
 	disabled_wait(caller);
 #endif
 	local_irq_enable();
+#ifdef __sparc__
+	prom_printf("\n");
+	flush_user_windows();
+
+	prom_cmdline();
+#endif
 	for (i = 0;;) {
 		touch_softlockup_watchdog();
 		i += panic_blink(i);

-- 
Meelis Roos (mroos@linux.ee)
