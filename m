From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 19 Feb 2011 15:47:03 +0000
Subject: [PATCH 3/4] sparc32,sun4m: percpu and global register definitions moved to irq.h
Message-Id: <1298130424-6934-3-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

entry.S access percpu + global data defined in
sun4m_irq.c - so move the types to irq.h.
This makes sparse happy and allow us to utilize
asm-offsets later.

Also updated a few comments in the sun4m_irq.c file.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/irq.h       |   21 +++++++++++++++++++++
 arch/sparc/kernel/sun4m_irq.c |   30 +++++++++---------------------
 2 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/arch/sparc/kernel/irq.h b/arch/sparc/kernel/irq.h
index d8d2daa..2c2ce9b 100644
--- a/arch/sparc/kernel/irq.h
+++ b/arch/sparc/kernel/irq.h
@@ -2,6 +2,27 @@
 
 #include <asm/btfixup.h>
 
+/* sun4m specific type definitions */
+
+/* This maps direct to CPU specific interrupt registers */
+struct sun4m_irq_percpu {
+	u32	pending;
+	u32	clear;
+	u32	set;
+};
+
+/* This maps direct to global interrupt registers */
+struct sun4m_irq_global {
+	u32	pending;
+	u32	mask;
+	u32	mask_clear;
+	u32	mask_set;
+	u32	interrupt_target;
+};
+
+extern struct sun4m_irq_percpu __iomem *sun4m_irq_percpu[SUN4M_NCPUS];
+extern struct sun4m_irq_global __iomem *sun4m_irq_global;
+
 /*
  * Platform specific irq configuration
  * The individual platforms assign their platform
diff --git a/arch/sparc/kernel/sun4m_irq.c b/arch/sparc/kernel/sun4m_irq.c
index 1e13ce9..69df625 100644
--- a/arch/sparc/kernel/sun4m_irq.c
+++ b/arch/sparc/kernel/sun4m_irq.c
@@ -96,20 +96,6 @@
  */
 
 
-struct sun4m_irq_percpu {
-	u32		pending;
-	u32		clear;
-	u32		set;
-};
-
-struct sun4m_irq_global {
-	u32		pending;
-	u32		mask;
-	u32		mask_clear;
-	u32		mask_set;
-	u32		interrupt_target;
-};
-
 /* Code in entry.S needs to get at these register mappings.  */
 struct sun4m_irq_percpu __iomem *sun4m_irq_percpu[SUN4M_NCPUS];
 struct sun4m_irq_global __iomem *sun4m_irq_global;
@@ -155,8 +141,11 @@ struct sun4m_irq_global __iomem *sun4m_irq_global;
 #define	OBP_INT_LEVEL_SBUS	0x30
 #define	OBP_INT_LEVEL_VME	0x40
 
+#define SUN4M_TIMER_IRQ         (OBP_INT_LEVEL_ONBOARD | 10)
+#define SUM4M_PROFILE_IRQ       (OBP_INT_LEVEL_ONBOARD | 14)
+
 static unsigned long irq_mask[0x50] = {
-	/* SMP */
+	/* 0x00 - SMP */
 	0,  SUN4M_SOFT_INT(1),
 	SUN4M_SOFT_INT(2),  SUN4M_SOFT_INT(3),
 	SUN4M_SOFT_INT(4),  SUN4M_SOFT_INT(5),
@@ -165,7 +154,7 @@ static unsigned long irq_mask[0x50] = {
 	SUN4M_SOFT_INT(10), SUN4M_SOFT_INT(11),
 	SUN4M_SOFT_INT(12), SUN4M_SOFT_INT(13),
 	SUN4M_SOFT_INT(14), SUN4M_SOFT_INT(15),
-	/* soft */
+	/* 0x10 - soft */
 	0,  SUN4M_SOFT_INT(1),
 	SUN4M_SOFT_INT(2),  SUN4M_SOFT_INT(3),
 	SUN4M_SOFT_INT(4),  SUN4M_SOFT_INT(5),
@@ -174,19 +163,19 @@ static unsigned long irq_mask[0x50] = {
 	SUN4M_SOFT_INT(10), SUN4M_SOFT_INT(11),
 	SUN4M_SOFT_INT(12), SUN4M_SOFT_INT(13),
 	SUN4M_SOFT_INT(14), SUN4M_SOFT_INT(15),
-	/* onboard */
+	/* 0x20 - onboard */
 	0, 0, 0, 0,
 	SUN4M_INT_SCSI,  0, SUN4M_INT_ETHERNET, 0,
 	SUN4M_INT_VIDEO, SUN4M_INT_MODULE,
 	SUN4M_INT_REALTIME, SUN4M_INT_FLOPPY,
 	(SUN4M_INT_SERIAL | SUN4M_INT_KBDMS),
 	SUN4M_INT_AUDIO, 0, SUN4M_INT_MODULE_ERR,
-	/* sbus */
+	/* 0x30 - sbus */
 	0, 0, SUN4M_INT_SBUS(0), SUN4M_INT_SBUS(1),
 	0, SUN4M_INT_SBUS(2), 0, SUN4M_INT_SBUS(3),
 	0, SUN4M_INT_SBUS(4), 0, SUN4M_INT_SBUS(5),
 	0, SUN4M_INT_SBUS(6), 0, 0,
-	/* vme */
+	/* 0x40 - vme */
 	0, 0, SUN4M_INT_VME(0), SUN4M_INT_VME(1),
 	0, SUN4M_INT_VME(2), 0, SUN4M_INT_VME(3),
 	0, SUN4M_INT_VME(4), 0, SUN4M_INT_VME(5),
@@ -319,7 +308,6 @@ struct sun4m_timer_global {
 
 static struct sun4m_timer_global __iomem *timers_global;
 
-#define TIMER_IRQ	(OBP_INT_LEVEL_ONBOARD | 10)
 
 unsigned int lvl14_resolution = (((1000000/HZ) + 1) << 10);
 
@@ -396,7 +384,7 @@ static void __init sun4m_init_timers(irq_handler_t counter_fn)
 
 	master_l10_counter = &timers_global->l10_count;
 
-	err = request_irq(TIMER_IRQ, counter_fn,
+	err = request_irq(SUN4M_TIMER_IRQ, counter_fn,
 			  (IRQF_DISABLED | SA_STATIC_ALLOC), "timer", NULL);
 	if (err) {
 		printk(KERN_ERR "sun4m_init_timers: Register IRQ error %d.\n",
-- 
1.6.0.6

