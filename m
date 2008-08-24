From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Sun, 24 Aug 2008 06:44:41 +0000
Subject: [RFC, SPARC64] use rtc mostek drivers instead of minirtc
Message-Id: <20080824084441.5ba2af93.krzysztof.h1@wp.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <20080823.234039.29618768.davem@davemloft.net>
In-Reply-To: <20080823.234039.29618768.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

I tried to use a rtc layer for sparc arch. 

The patch below removes rtc functions for the Mostek rtcs 
from the sparc specific files. The rtc is declared as platform device
and use a driver from the rtc layer.

The detection and kick start are left untouched. If there are
other things which can be fixed or improved please let me know.
There are two quirks in the patch:

1. The year is stored since 1968 on sparc so the read/write function
must convert this register value (this is ugly).

2. The minirtc driver returns ENODEV for mostek chips (so no
two want to access the chip).


I tested it on my U60 and the rtc works correctly after change.
The old /dev/rtc device does not work but the hwclock after
the /dev/rtc is linked to a new /dev/rtc0 (device created by
the rtc layer).

Before using the patch below, the rtc m48t59 driver need to be
updated with two patches from the -mm tree:

rtc-m48t59-reduce-structure-m48t59_private.patch
rtc-m48t59-add-support-for-m48t02-and-m48t59-chips-2nd-rev.patch


I would like to convert whole rtc handling to the rtc layer. However,
I have no hardware to test (only U60) so I need some help from sparc
people.

Regards,
Krzysztof

diff -urp linux-2.6/arch/sparc64/kernel/time.c linux-new/arch/sparc64/kernel/time.c
--- linux-2.6/arch/sparc64/kernel/time.c	2008-08-09 05:08:20.000000000 +0200
+++ linux-new/arch/sparc64/kernel/time.c	2008-08-19 21:19:47.000000000 +0200
@@ -30,10 +30,12 @@
 #include <linux/percpu.h>
 #include <linux/miscdevice.h>
 #include <linux/rtc.h>
+#include <linux/rtc/m48t59.h>
 #include <linux/kernel_stat.h>
 #include <linux/clockchips.h>
 #include <linux/clocksource.h>
 #include <linux/of_device.h>
+#include <linux/platform_device.h>
 
 #include <asm/oplib.h>
 #include <asm/mostek.h>
@@ -408,6 +410,59 @@ int update_persistent_clock(struct times
 	return set_rtc_mmss(now.tv_sec);
 }
 
+static unsigned char mostek_read_byte(struct device *dev, u32 ofs)
+{
+	void __iomem *regs = mstk48t08_regs;
+	unsigned char val = mostek_read(regs + ofs);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct m48t59_plat_data *pdata = pdev->dev.platform_data;
+
+	/* the year 0 is 1968 */
+	if (ofs = pdata->offset + M48T59_YEAR) {
+		val += 0x68;
+		if ((val & 0xf) > 9)
+			val += 6;
+	}
+	return val;
+}
+
+static void mostek_write_byte(struct device *dev, u32 ofs, u8 val)
+{
+	void __iomem *regs = mstk48t08_regs;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct m48t59_plat_data *pdata = pdev->dev.platform_data;
+
+	if (ofs = pdata->offset + M48T59_YEAR) {
+		if (val < 0x68)
+			val += 0x32;
+		else
+			val -= 0x68;
+		if ((val & 0xf) > 9)
+			val += 6;
+		if ((val & 0xf0) > 0x9A)
+			val += 0x60;
+	}
+	mostek_write(regs + ofs, val);
+}
+
+static struct m48t59_plat_data m48t59_data = {
+	.read_byte = mostek_read_byte,
+	.write_byte = mostek_write_byte,
+};
+
+/* resource is set at runtime */
+static struct resource mostek_resource;
+
+static struct platform_device m48t59_rtc = {
+	.name		= "rtc-m48t59",
+	.id		= 0,
+	.num_resources	= 1,
+	.resource 	= &mostek_resource,
+	.dev	= {
+		.platform_data = &m48t59_data,
+	},
+};
+
 /* Kick start a stopped clock (procedure from the Sun NVRAM/hostid FAQ). */
 static void __init kick_start_clock(void)
 {
@@ -510,37 +565,6 @@ static int __init has_low_battery(void)
 	return (data1 = data2);	/* Was the write blocked? */
 }
 
-static void __init mostek_set_system_time(void __iomem *mregs)
-{
-	unsigned int year, mon, day, hour, min, sec;
-	u8 tmp;
-
-	spin_lock_irq(&mostek_lock);
-
-	/* Traditional Mostek chip. */
-	tmp = mostek_read(mregs + MOSTEK_CREG);
-	tmp |= MSTK_CREG_READ;
-	mostek_write(mregs + MOSTEK_CREG, tmp);
-
-	sec = MSTK_REG_SEC(mregs);
-	min = MSTK_REG_MIN(mregs);
-	hour = MSTK_REG_HOUR(mregs);
-	day = MSTK_REG_DOM(mregs);
-	mon = MSTK_REG_MONTH(mregs);
-	year = MSTK_CVT_YEAR( MSTK_REG_YEAR(mregs) );
-
-	xtime.tv_sec = mktime(year, mon, day, hour, min, sec);
-	xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
-	set_normalized_timespec(&wall_to_monotonic,
- 	                        -xtime.tv_sec, -xtime.tv_nsec);
-
-	tmp = mostek_read(mregs + MOSTEK_CREG);
-	tmp &= ~MSTK_CREG_READ;
-	mostek_write(mregs + MOSTEK_CREG, tmp);
-
-	spin_unlock_irq(&mostek_lock);
-}
-
 /* Probe for the real time clock chip. */
 static void __init set_system_time(void)
 {
@@ -560,7 +584,6 @@ static void __init set_system_time(void)
 	}		
 
 	if (mregs) {
-		mostek_set_system_time(mregs);
 		return;
 	}
 
@@ -735,14 +758,23 @@ static int __devinit clock_probe(struct 
 		bq4802_regs = regs;
 	} else
 #endif
-	if (model[5] = '0' && model[6] = '2') {
-		mstk48t02_regs = regs;
-	} else if(model[5] = '0' && model[6] = '8') {
-		mstk48t08_regs = regs;
-		mstk48t02_regs = mstk48t08_regs + MOSTEK_48T08_48T02;
-	} else {
-		mstk48t59_regs = regs;
-		mstk48t02_regs = mstk48t59_regs + MOSTEK_48T59_48T02;
+	{
+		m48t59_rtc.resource[0] = op->resource[0];
+		if (model[5] = '0' && model[6] = '2') {
+			mstk48t02_regs = regs;
+			mstk48t08_regs = regs;
+			m48t59_data.type = M48T59RTC_TYPE_M48T02;
+		} else if (model[5] = '0' && model[6] = '8') {
+			mstk48t08_regs = regs;
+			mstk48t02_regs = mstk48t08_regs + MOSTEK_48T08_48T02;
+			m48t59_data.type = M48T59RTC_TYPE_M48T08;
+		} else {
+			mstk48t08_regs = regs;
+			mstk48t02_regs = mstk48t59_regs + MOSTEK_48T59_48T02;
+			m48t59_data.type = M48T59RTC_TYPE_M48T59;
+		}
+		if (platform_device_register(&m48t59_rtc) < 0)
+			printk(KERN_ERR "Registering RTC device failed\n");
 	}
 
 	printk(KERN_INFO "%s: Clock regs at %p\n", dp->full_name, regs);
@@ -1480,74 +1512,6 @@ static int cmos_set_rtc_time(struct rtc_
 }
 #endif /* CONFIG_PCI */
 
-static void mostek_get_rtc_time(struct rtc_time *rtc_tm)
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
-	rtc_tm->tm_sec = MSTK_REG_SEC(regs);
-	rtc_tm->tm_min = MSTK_REG_MIN(regs);
-	rtc_tm->tm_hour = MSTK_REG_HOUR(regs);
-	rtc_tm->tm_mday = MSTK_REG_DOM(regs);
-	rtc_tm->tm_mon = MSTK_REG_MONTH(regs);
-	rtc_tm->tm_year = MSTK_CVT_YEAR( MSTK_REG_YEAR(regs) );
-	rtc_tm->tm_wday = MSTK_REG_DOW(regs);
-
-	tmp = mostek_read(regs + MOSTEK_CREG);
-	tmp &= ~MSTK_CREG_READ;
-	mostek_write(regs + MOSTEK_CREG, tmp);
-
-	spin_unlock_irq(&mostek_lock);
-
-	rtc_tm->tm_mon--;
-	rtc_tm->tm_wday--;
-	rtc_tm->tm_year -= 1900;
-}
-
-static int mostek_set_rtc_time(struct rtc_time *rtc_tm)
-{
-	unsigned char mon, day, hrs, min, sec, wday;
-	void __iomem *regs = mstk48t02_regs;
-	unsigned int yrs;
-	u8 tmp;
-
-	yrs = rtc_tm->tm_year + 1900;
-	mon = rtc_tm->tm_mon + 1;
-	day = rtc_tm->tm_mday;
-	wday = rtc_tm->tm_wday + 1;
-	hrs = rtc_tm->tm_hour;
-	min = rtc_tm->tm_min;
-	sec = rtc_tm->tm_sec;
-
-	spin_lock_irq(&mostek_lock);
-
-	tmp = mostek_read(regs + MOSTEK_CREG);
-	tmp |= MSTK_CREG_WRITE;
-	mostek_write(regs + MOSTEK_CREG, tmp);
-
-	MSTK_SET_REG_SEC(regs, sec);
-	MSTK_SET_REG_MIN(regs, min);
-	MSTK_SET_REG_HOUR(regs, hrs);
-	MSTK_SET_REG_DOW(regs, wday);
-	MSTK_SET_REG_DOM(regs, day);
-	MSTK_SET_REG_MONTH(regs, mon);
-	MSTK_SET_REG_YEAR(regs, yrs - MSTK_YEAR_ZERO);
-
-	tmp = mostek_read(regs + MOSTEK_CREG);
-	tmp &= ~MSTK_CREG_WRITE;
-	mostek_write(regs + MOSTEK_CREG, tmp);
-
-	spin_unlock_irq(&mostek_lock);
-
-	return 0;
-}
-
 struct mini_rtc_ops {
 	void (*get_rtc_time)(struct rtc_time *);
 	int (*set_rtc_time)(struct rtc_time *);
@@ -1575,11 +1539,6 @@ static struct mini_rtc_ops cmos_rtc_ops 
 };
 #endif /* CONFIG_PCI */
 
-static struct mini_rtc_ops mostek_rtc_ops = {
-	.get_rtc_time = mostek_get_rtc_time,
-	.set_rtc_time = mostek_set_rtc_time,
-};
-
 static struct mini_rtc_ops *mini_rtc_ops;
 
 static inline void mini_get_rtc_time(struct rtc_time *time)
@@ -1713,7 +1672,7 @@ static int __init rtc_mini_init(void)
 		mini_rtc_ops = &cmos_rtc_ops;
 #endif /* CONFIG_PCI */
 	else if (mstk48t02_regs)
-		mini_rtc_ops = &mostek_rtc_ops;
+		return -ENODEV;
 	else
 		return -ENODEV;
 
