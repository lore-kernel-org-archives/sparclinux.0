From: David Miller <davem@davemloft.net>
Date: Wed, 03 Sep 2008 23:00:24 +0000
Subject: [PATCH 1/3]: sparc: Kill sbus mostek RTC driver.
Message-Id: <20080903.160024.72944198.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc: Kill sbus mostek RTC driver.

No longer used.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/sbus/char/Kconfig  |   10 --
 drivers/sbus/char/Makefile |    1 -
 drivers/sbus/char/rtc.c    |  275 --------------------------------------------
 3 files changed, 0 insertions(+), 286 deletions(-)
 delete mode 100644 drivers/sbus/char/rtc.c

diff --git a/drivers/sbus/char/Kconfig b/drivers/sbus/char/Kconfig
index 1d5d1b4..73cde85 100644
--- a/drivers/sbus/char/Kconfig
+++ b/drivers/sbus/char/Kconfig
@@ -13,16 +13,6 @@ config SUN_OPENPROMIO
 
 	  If unsure, say Y.
 
-config SUN_MOSTEK_RTC
-	tristate "Mostek real time clock support"
-	depends on SPARC32
-	help
-	  The Mostek RTC chip is used on all known Sun computers except
-	  some JavaStations. For a JavaStation you need to say Y both here
-	  and to "Enhanced Real Time Clock Support".
-
-	  Say Y here unless you are building a special purpose kernel.
-
 config OBP_FLASH
 	tristate "OBP Flash Device support"
 	depends on SPARC64
diff --git a/drivers/sbus/char/Makefile b/drivers/sbus/char/Makefile
index d83212e..78b6183 100644
--- a/drivers/sbus/char/Makefile
+++ b/drivers/sbus/char/Makefile
@@ -13,7 +13,6 @@ obj-$(CONFIG_ENVCTRL)			+= envctrl.o
 obj-$(CONFIG_DISPLAY7SEG)		+= display7seg.o
 obj-$(CONFIG_OBP_FLASH)			+= flash.o
 obj-$(CONFIG_SUN_OPENPROMIO)		+= openprom.o
-obj-$(CONFIG_SUN_MOSTEK_RTC)		+= rtc.o
 obj-$(CONFIG_TADPOLE_TS102_UCTRL)	+= uctrl.o
 obj-$(CONFIG_SUN_JSFLASH)		+= jsflash.o
 obj-$(CONFIG_BBC_I2C)			+= bbc.o
diff --git a/drivers/sbus/char/rtc.c b/drivers/sbus/char/rtc.c
deleted file mode 100644
index b042991..0000000
--- a/drivers/sbus/char/rtc.c
+++ /dev/null
@@ -1,275 +0,0 @@
-/* $Id: rtc.c,v 1.28 2001/10/08 22:19:51 davem Exp $
- *
- * Linux/SPARC Real Time Clock Driver
- * Copyright (C) 1996 Thomas K. Dyas (tdyas@eden.rutgers.edu)
- *
- * This is a little driver that lets a user-level program access
- * the SPARC Mostek real time clock chip. It is no use unless you
- * use the modified clock utility.
- *
- * Get the modified clock utility from:
- *   ftp://vger.kernel.org/pub/linux/Sparc/userland/clock.c
- */
-
-#include <linux/module.h>
-#include <linux/smp_lock.h>
-#include <linux/types.h>
-#include <linux/errno.h>
-#include <linux/miscdevice.h>
-#include <linux/slab.h>
-#include <linux/fcntl.h>
-#include <linux/poll.h>
-#include <linux/init.h>
-#include <asm/io.h>
-#include <asm/mostek.h>
-#include <asm/system.h>
-#include <asm/uaccess.h>
-#include <asm/rtc.h>
-
-static int rtc_busy = 0;
-
-/* This is the structure layout used by drivers/char/rtc.c, we
- * support that driver's ioctls so that things are less messy in
- * userspace.
- */
-struct rtc_time_generic {
-	int tm_sec;
-	int tm_min;
-	int tm_hour;
-	int tm_mday;
-	int tm_mon;
-	int tm_year;
-	int tm_wday;
-	int tm_yday;
-	int tm_isdst;
-};
-#define RTC_AIE_ON	_IO('p', 0x01)	/* Alarm int. enable on		*/
-#define RTC_AIE_OFF	_IO('p', 0x02)	/* ... off			*/
-#define RTC_UIE_ON	_IO('p', 0x03)	/* Update int. enable on	*/
-#define RTC_UIE_OFF	_IO('p', 0x04)	/* ... off			*/
-#define RTC_PIE_ON	_IO('p', 0x05)	/* Periodic int. enable on	*/
-#define RTC_PIE_OFF	_IO('p', 0x06)	/* ... off			*/
-#define RTC_WIE_ON	_IO('p', 0x0f)  /* Watchdog int. enable on	*/
-#define RTC_WIE_OFF	_IO('p', 0x10)  /* ... off			*/
-#define RTC_RD_TIME	_IOR('p', 0x09, struct rtc_time_generic) /* Read RTC time   */
-#define RTC_SET_TIME	_IOW('p', 0x0a, struct rtc_time_generic) /* Set RTC time    */
-#define RTC_ALM_SET	_IOW('p', 0x07, struct rtc_time) /* Set alarm time  */
-#define RTC_ALM_READ	_IOR('p', 0x08, struct rtc_time) /* Read alarm time */
-#define RTC_IRQP_READ	_IOR('p', 0x0b, unsigned long)	 /* Read IRQ rate   */
-#define RTC_IRQP_SET	_IOW('p', 0x0c, unsigned long)	 /* Set IRQ rate    */
-#define RTC_EPOCH_READ	_IOR('p', 0x0d, unsigned long)	 /* Read epoch      */
-#define RTC_EPOCH_SET	_IOW('p', 0x0e, unsigned long)	 /* Set epoch       */
-#define RTC_WKALM_SET	_IOW('p', 0x0f, struct rtc_wkalrm)/* Set wakeup alarm*/
-#define RTC_WKALM_RD	_IOR('p', 0x10, struct rtc_wkalrm)/* Get wakeup alarm*/
-#define RTC_PLL_GET	_IOR('p', 0x11, struct rtc_pll_info)  /* Get PLL correction */
-#define RTC_PLL_SET	_IOW('p', 0x12, struct rtc_pll_info)  /* Set PLL correction */
-
-/* Retrieve the current date and time from the real time clock. */
-static void get_rtc_time(struct rtc_time *t)
-{
-	void __iomem *regs = mstk48t02_regs;
-	u8 tmp;
-
-	spin_lock_irq(&mostek_lock);
-
-	tmp = mostek_read(regs + MOSTEK_CREG);
-	tmp |= MSTK_CREG_READ;
-	mostek_write(regs + MOSTEK_CREG, tmp);
-
-	t->sec = MSTK_REG_SEC(regs);
-	t->min = MSTK_REG_MIN(regs);
-	t->hour = MSTK_REG_HOUR(regs);
-	t->dow = MSTK_REG_DOW(regs);
-	t->dom = MSTK_REG_DOM(regs);
-	t->month = MSTK_REG_MONTH(regs);
-	t->year = MSTK_CVT_YEAR( MSTK_REG_YEAR(regs) );
-
-	tmp = mostek_read(regs + MOSTEK_CREG);
-	tmp &= ~MSTK_CREG_READ;
-	mostek_write(regs + MOSTEK_CREG, tmp);
-
-	spin_unlock_irq(&mostek_lock);
-}
-
-/* Set the current date and time inthe real time clock. */
-void set_rtc_time(struct rtc_time *t)
-{
-	void __iomem *regs = mstk48t02_regs;
-	u8 tmp;
-
-	spin_lock_irq(&mostek_lock);
-
-	tmp = mostek_read(regs + MOSTEK_CREG);
-	tmp |= MSTK_CREG_WRITE;
-	mostek_write(regs + MOSTEK_CREG, tmp);
-
-	MSTK_SET_REG_SEC(regs,t->sec);
-	MSTK_SET_REG_MIN(regs,t->min);
-	MSTK_SET_REG_HOUR(regs,t->hour);
-	MSTK_SET_REG_DOW(regs,t->dow);
-	MSTK_SET_REG_DOM(regs,t->dom);
-	MSTK_SET_REG_MONTH(regs,t->month);
-	MSTK_SET_REG_YEAR(regs,t->year - MSTK_YEAR_ZERO);
-
-	tmp = mostek_read(regs + MOSTEK_CREG);
-	tmp &= ~MSTK_CREG_WRITE;
-	mostek_write(regs + MOSTEK_CREG, tmp);
-
-	spin_unlock_irq(&mostek_lock);
-}
-
-static int put_rtc_time_generic(void __user *argp, struct rtc_time *tm)
-{
-	struct rtc_time_generic __user *utm = argp;
-
-	if (__put_user(tm->sec, &utm->tm_sec) ||
-	    __put_user(tm->min, &utm->tm_min) ||
-	    __put_user(tm->hour, &utm->tm_hour) ||
-	    __put_user(tm->dom, &utm->tm_mday) ||
-	    __put_user(tm->month, &utm->tm_mon) ||
-	    __put_user(tm->year, &utm->tm_year) ||
-	    __put_user(tm->dow, &utm->tm_wday) ||
-	    __put_user(0, &utm->tm_yday) ||
-	    __put_user(0, &utm->tm_isdst))
-		return -EFAULT;
-
-	return 0;
-}
-
-static int get_rtc_time_generic(struct rtc_time *tm, void __user *argp)
-{
-	struct rtc_time_generic __user *utm = argp;
-
-	if (__get_user(tm->sec, &utm->tm_sec) ||
-	    __get_user(tm->min, &utm->tm_min) ||
-	    __get_user(tm->hour, &utm->tm_hour) ||
-	    __get_user(tm->dom, &utm->tm_mday) ||
-	    __get_user(tm->month, &utm->tm_mon) ||
-	    __get_user(tm->year, &utm->tm_year) ||
-	    __get_user(tm->dow, &utm->tm_wday))
-		return -EFAULT;
-
-	return 0;
-}
-
-static int rtc_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
-	unsigned long arg)
-{
-	struct rtc_time rtc_tm;
-	void __user *argp = (void __user *)arg;
-
-	switch (cmd) {
-	/* No interrupt support, return an error
-	 * compatible with drivers/char/rtc.c
-	 */
-	case RTC_AIE_OFF:
-	case RTC_AIE_ON:
-	case RTC_PIE_OFF:
-	case RTC_PIE_ON:
-	case RTC_UIE_OFF:
-	case RTC_UIE_ON:
-	case RTC_IRQP_READ:
-	case RTC_IRQP_SET:
-	case RTC_EPOCH_SET:
-	case RTC_EPOCH_READ:
-		return -EINVAL;
-
-	case RTCGET:
-	case RTC_RD_TIME:
-		memset(&rtc_tm, 0, sizeof(struct rtc_time));
-		get_rtc_time(&rtc_tm);
-
-		if (cmd = RTCGET) {
-			if (copy_to_user(argp, &rtc_tm,
-					 sizeof(struct rtc_time)))
-				return -EFAULT;
-		} else if (put_rtc_time_generic(argp, &rtc_tm))
-			return -EFAULT;
-
-		return 0;
-
-
-	case RTCSET:
-	case RTC_SET_TIME:
-		if (!capable(CAP_SYS_TIME))
-			return -EPERM;
-
-		if (cmd = RTCSET) {
-			if (copy_from_user(&rtc_tm, argp,
-					   sizeof(struct rtc_time)))
-				return -EFAULT;
-		} else if (get_rtc_time_generic(&rtc_tm, argp))
-			return -EFAULT;
-
-		set_rtc_time(&rtc_tm);
-
-		return 0;
-
-	default:
-		return -EINVAL;
-	}
-}
-
-static int rtc_open(struct inode *inode, struct file *file)
-{
-	int ret;
-
-	lock_kernel();
-	spin_lock_irq(&mostek_lock);
-	if (rtc_busy) {
-		ret = -EBUSY;
-	} else {
-		rtc_busy = 1;
-		ret = 0;
-	}
-	spin_unlock_irq(&mostek_lock);
-	unlock_kernel();
-
-	return ret;
-}
-
-static int rtc_release(struct inode *inode, struct file *file)
-{
-	rtc_busy = 0;
-
-	return 0;
-}
-
-static const struct file_operations rtc_fops = {
-	.owner =	THIS_MODULE,
-	.llseek =	no_llseek,
-	.ioctl =	rtc_ioctl,
-	.open =		rtc_open,
-	.release =	rtc_release,
-};
-
-static struct miscdevice rtc_dev = { RTC_MINOR, "rtc", &rtc_fops };
-
-static int __init rtc_sun_init(void)
-{
-	int error;
-
-	/* It is possible we are being driven by some other RTC chip
-	 * and thus another RTC driver is handling things.
-	 */
-	if (!mstk48t02_regs)
-		return -ENODEV;
-
-	error = misc_register(&rtc_dev);
-	if (error) {
-		printk(KERN_ERR "rtc: unable to get misc minor for Mostek\n");
-		return error;
-	}
-	printk("rtc_sun_init: Registered Mostek RTC driver.\n");
-
-	return 0;
-}
-
-static void __exit rtc_sun_cleanup(void)
-{
-	misc_deregister(&rtc_dev);
-}
-
-module_init(rtc_sun_init);
-module_exit(rtc_sun_cleanup);
-MODULE_LICENSE("GPL");
-- 
1.5.6.5.GIT

