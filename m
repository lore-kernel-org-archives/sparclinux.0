From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 21 Dec 2004 11:42:34 +0000
Subject: [sparc32] [4/4] rtc warnings and link errors
Message-Id: <20041221114234.GO771@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The RTC code is throwing off warnings and link errors. This patch
fixes them up.

Index: sparc32-2.6.10-rc3/drivers/char/rtc.c
=================================--- sparc32-2.6.10-rc3.orig/drivers/char/rtc.c	2004-10-07 04:01:30.000000000 -0700
+++ sparc32-2.6.10-rc3/drivers/char/rtc.c	2004-12-21 03:27:52.060875306 -0800
@@ -878,7 +878,7 @@
 	&rtc_fops
 };
 
-#ifdef RTC_IRQ
+#if defined(RTC_IRQ) && !defined(__sparc__)
 static irqreturn_t (*rtc_int_handler_ptr)(int irq, void *dev_id, struct pt_regs *regs);
 #endif
 
Index: sparc32-2.6.10-rc3/drivers/sbus/char/rtc.c
=================================--- sparc32-2.6.10-rc3.orig/drivers/sbus/char/rtc.c	2004-10-07 04:01:41.000000000 -0700
+++ sparc32-2.6.10-rc3/drivers/sbus/char/rtc.c	2004-12-21 03:29:32.959536378 -0800
@@ -20,6 +20,7 @@
 #include <linux/poll.h>
 #include <linux/init.h>
 #include <linux/smp_lock.h>
+#include <asm/io.h>
 #include <asm/mostek.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -30,7 +31,7 @@
 /* Retrieve the current date and time from the real time clock. */
 static void get_rtc_time(struct rtc_time *t)
 {
-	unsigned long regs = mstk48t02_regs;
+	void * __iomem regs = mstk48t02_regs;
 	u8 tmp;
 
 	spin_lock_irq(&mostek_lock);
@@ -57,7 +58,7 @@
 /* Set the current date and time inthe real time clock. */
 void set_rtc_time(struct rtc_time *t)
 {
-	unsigned long regs = mstk48t02_regs;
+	void * __iomem regs = mstk48t02_regs;
 	u8 tmp;
 
 	spin_lock_irq(&mostek_lock);
