From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 29 Jan 2011 08:08:19 +0000
Subject: [PATCH 3/8] sparc32,sun4c: irq file cleanup
Message-Id: <1296288504-15933-3-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

- drop filename in header
- drop unused includes
- add description of sun4c interrupts (from davem)
- add spaces after reserved words

This is partly based on a patch from: David Miller <davem@davemloft.net>

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/sun4c_irq.c |   81 ++++++++++++++++++++++-------------------
 1 files changed, 44 insertions(+), 37 deletions(-)

diff --git a/arch/sparc/kernel/sun4c_irq.c b/arch/sparc/kernel/sun4c_irq.c
index 892fb88..f543b45 100644
--- a/arch/sparc/kernel/sun4c_irq.c
+++ b/arch/sparc/kernel/sun4c_irq.c
@@ -1,5 +1,5 @@
-/*  sun4c_irq.c
- *  arch/sparc/kernel/sun4c_irq.c:
+/*
+ * sun4c irq support
  *
  *  djhr: Hacked out of irq.c into a CPU dependent version.
  *
@@ -9,31 +9,41 @@
  *  Copyright (C) 1996 Dave Redman (djhr@tadpole.co.uk)
  */
 
-#include <linux/errno.h>
-#include <linux/linkage.h>
-#include <linux/kernel_stat.h>
-#include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/ptrace.h>
-#include <linux/interrupt.h>
 #include <linux/init.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
-#include "irq.h"
 
-#include <asm/ptrace.h>
-#include <asm/processor.h>
-#include <asm/system.h>
-#include <asm/psr.h>
-#include <asm/vaddrs.h>
-#include <asm/timer.h>
-#include <asm/openprom.h>
 #include <asm/oplib.h>
-#include <asm/traps.h>
+#include <asm/timer.h>
 #include <asm/irq.h>
 #include <asm/io.h>
-#include <asm/idprom.h>
-#include <asm/machines.h>
+
+#include "irq.h"
+
+/* Sun4c interrupts are typically laid out as follows:
+ *
+ *  1 - Software interrupt, SBUS level 1
+ *  2 - SBUS level 2
+ *  3 - ESP SCSI, SBUS level 3
+ *  4 - Software interrupt
+ *  5 - Lance ethernet, SBUS level 4
+ *  6 - Software interrupt
+ *  7 - Graphics card, SBUS level 5
+ *  8 - SBUS level 6
+ *  9 - SBUS level 7
+ * 10 - Counter timer
+ * 11 - Floppy
+ * 12 - Zilog uart
+ * 13 - CS4231 audio
+ * 14 - Profiling timer
+ * 15 - NMI
+ *
+ * The interrupt enable bits in the interrupt mask register are
+ * really only used to enable/disable the timer interrupts, and
+ * for signalling software interrupts.  There is also a master
+ * interrupt enable bit in this register.
+ *
+ * Interrupts are enabled by setting the SUN4C_INT_* bits, they
+ * are disabled by clearing those bits.
+ */
 
 /*
  * Bit field defines for the interrupt registers on various
@@ -49,26 +59,21 @@
 #define SUN4C_INT_E4      0x04     /* Enable level 4 IRQ. */
 #define SUN4C_INT_E1      0x02     /* Enable level 1 IRQ. */
 
-/* Pointer to the interrupt enable byte
- *
- * Dave Redman (djhr@tadpole.co.uk)
- * What you may not be aware of is that entry.S requires this variable.
- *
- *  --- linux_trap_nmi_sun4c --
- *
- * so don't go making it static, like I tried. sigh.
+/*
+ * Pointer to the interrupt enable byte
+ * Used by entry.S
  */
-unsigned char __iomem *interrupt_enable = NULL;
+unsigned char __iomem *interrupt_enable;
 
 static void sun4c_disable_irq(unsigned int irq_nr)
 {
 	unsigned long flags;
 	unsigned char current_mask, new_mask;
-    
+
 	local_irq_save(flags);
 	irq_nr &= (NR_IRQS - 1);
 	current_mask = sbus_readb(interrupt_enable);
-	switch(irq_nr) {
+	switch (irq_nr) {
 	case 1:
 		new_mask = ((current_mask) & (~(SUN4C_INT_E1)));
 		break;
@@ -93,11 +98,11 @@ static void sun4c_enable_irq(unsigned int irq_nr)
 {
 	unsigned long flags;
 	unsigned char current_mask, new_mask;
-    
+
 	local_irq_save(flags);
 	irq_nr &= (NR_IRQS - 1);
 	current_mask = sbus_readb(interrupt_enable);
-	switch(irq_nr) {
+	switch (irq_nr) {
 	case 1:
 		new_mask = ((current_mask) | SUN4C_INT_E1);
 		break;
@@ -180,12 +185,14 @@ static void __init sun4c_init_timers(irq_handler_t counter_fn)
 		prom_printf("sun4c_init_timers: request_irq() fails with %d\n", err);
 		prom_halt();
 	}
-    
+
 	sun4c_disable_irq(irq[1].pri);
 }
 
 #ifdef CONFIG_SMP
-static void sun4c_nop(void) {}
+static void sun4c_nop(void)
+{
+}
 #endif
 
 void __init sun4c_init_IRQ(void)
-- 
1.6.0.6

