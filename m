From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 23:40:11 +0000
Subject: Re: [RFC, SPARC64] use rtc mostek drivers instead of minirtc
Message-Id: <20080828.164011.157402102.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080823.234039.29618768.davem@davemloft.net>
In-Reply-To: <20080823.234039.29618768.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Date: Sun, 24 Aug 2008 08:44:34 +0200

> Before using the patch below, the rtc m48t59 driver need to be
> updated with two patches from the -mm tree:
> 
> rtc-m48t59-reduce-structure-m48t59_private.patch
> rtc-m48t59-add-support-for-m48t02-and-m48t59-chips-2nd-rev.patch

Actually these patches aren't needed, the first just removes an unused
structure member and the second adds support for chips that sparc64
systems don't even have :)

All Sparc64 systems have m48t59 chips, only older 32-bit sparcs have
m48t02 and m48t08.  BTW there is a typo in the changelog for that
second patch:

	Add support for two compatible RTC:
	- M48T08 which does not have alarm part,
	- M48T08 which does not have alarm part and has
	  only 2KB of NVRAM

At least one of those lines should say M48T02 :-)

Anyways, this means this code on the sparc64 side can be simplified
even further.

The following revised version of your patch should work.  In
particular we don't need a fixed static resource, we can just point
the platform device at the of_device resource object.  We also don't
need the silly mostek reg pointers, we can deduce this from the
resource the platform_device object has.

Actually, this mostek register access inteface is incomplete, the
mostek rtc driver ioremap()'s the resource for MEM resources but
doesn't provide the __iomem pointer to the register accessors because
the mostek driver private structure type is not available in the
header file, it's private to the RTC driver source.

But anyways, ioremap() does nothing but cast pointers on sparc64 so
this happens to work :-)

diff --git a/arch/sparc64/kernel/sparc64_ksyms.c b/arch/sparc64/kernel/sparc64_ksyms.c
index 3b2890c..b0a5bc4 100644
--- a/arch/sparc64/kernel/sparc64_ksyms.c
+++ b/arch/sparc64/kernel/sparc64_ksyms.c
@@ -36,7 +36,6 @@
 #include <asm/elf.h>
 #include <asm/head.h>
 #include <asm/smp.h>
-#include <asm/mostek.h>
 #include <asm/ptrace.h>
 #include <asm/uaccess.h>
 #include <asm/checksum.h>
@@ -153,8 +152,6 @@ EXPORT_SYMBOL(flush_dcache_page);
 EXPORT_SYMBOL(__flush_dcache_range);
 #endif
 
-EXPORT_SYMBOL(mostek_lock);
-EXPORT_SYMBOL(mstk48t02_regs);
 #ifdef CONFIG_SUN_AUXIO
 EXPORT_SYMBOL(auxio_set_led);
 EXPORT_SYMBOL(auxio_set_lte);
diff --git a/arch/sparc64/kernel/time.c b/arch/sparc64/kernel/time.c
index cc16fdc..92f54d0 100644
--- a/arch/sparc64/kernel/time.c
+++ b/arch/sparc64/kernel/time.c
@@ -30,13 +30,14 @@
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
-#include <asm/mostek.h>
 #include <asm/timer.h>
 #include <asm/irq.h>
 #include <asm/io.h>
@@ -47,20 +48,16 @@
 #include <asm/cpudata.h>
 #include <asm/uaccess.h>
 #include <asm/irq_regs.h>
+#include <asm/upa.h>
 
 #include "entry.h"
 
-DEFINE_SPINLOCK(mostek_lock);
 DEFINE_SPINLOCK(rtc_lock);
-void __iomem *mstk48t02_regs = NULL;
 #ifdef CONFIG_PCI
 unsigned long ds1287_regs = 0UL;
 static void __iomem *bq4802_regs;
 #endif
 
-static void __iomem *mstk48t08_regs;
-static void __iomem *mstk48t59_regs;
-
 static int set_rtc_mmss(unsigned long);
 
 #define TICK_PRIV_BIT	(1UL << 63)
@@ -408,144 +405,10 @@ int update_persistent_clock(struct timespec now)
 	return set_rtc_mmss(now.tv_sec);
 }
 
-/* Kick start a stopped clock (procedure from the Sun NVRAM/hostid FAQ). */
-static void __init kick_start_clock(void)
-{
-	void __iomem *regs = mstk48t02_regs;
-	u8 sec, tmp;
-	int i, count;
-
-	prom_printf("CLOCK: Clock was stopped. Kick start ");
-
-	spin_lock_irq(&mostek_lock);
-
-	/* Turn on the kick start bit to start the oscillator. */
-	tmp = mostek_read(regs + MOSTEK_CREG);
-	tmp |= MSTK_CREG_WRITE;
-	mostek_write(regs + MOSTEK_CREG, tmp);
-	tmp = mostek_read(regs + MOSTEK_SEC);
-	tmp &= ~MSTK_STOP;
-	mostek_write(regs + MOSTEK_SEC, tmp);
-	tmp = mostek_read(regs + MOSTEK_HOUR);
-	tmp |= MSTK_KICK_START;
-	mostek_write(regs + MOSTEK_HOUR, tmp);
-	tmp = mostek_read(regs + MOSTEK_CREG);
-	tmp &= ~MSTK_CREG_WRITE;
-	mostek_write(regs + MOSTEK_CREG, tmp);
-
-	spin_unlock_irq(&mostek_lock);
-
-	/* Delay to allow the clock oscillator to start. */
-	sec = MSTK_REG_SEC(regs);
-	for (i = 0; i < 3; i++) {
-		while (sec = MSTK_REG_SEC(regs))
-			for (count = 0; count < 100000; count++)
-				/* nothing */ ;
-		prom_printf(".");
-		sec = MSTK_REG_SEC(regs);
-	}
-	prom_printf("\n");
-
-	spin_lock_irq(&mostek_lock);
-
-	/* Turn off kick start and set a "valid" time and date. */
-	tmp = mostek_read(regs + MOSTEK_CREG);
-	tmp |= MSTK_CREG_WRITE;
-	mostek_write(regs + MOSTEK_CREG, tmp);
-	tmp = mostek_read(regs + MOSTEK_HOUR);
-	tmp &= ~MSTK_KICK_START;
-	mostek_write(regs + MOSTEK_HOUR, tmp);
-	MSTK_SET_REG_SEC(regs,0);
-	MSTK_SET_REG_MIN(regs,0);
-	MSTK_SET_REG_HOUR(regs,0);
-	MSTK_SET_REG_DOW(regs,5);
-	MSTK_SET_REG_DOM(regs,1);
-	MSTK_SET_REG_MONTH(regs,8);
-	MSTK_SET_REG_YEAR(regs,1996 - MSTK_YEAR_ZERO);
-	tmp = mostek_read(regs + MOSTEK_CREG);
-	tmp &= ~MSTK_CREG_WRITE;
-	mostek_write(regs + MOSTEK_CREG, tmp);
-
-	spin_unlock_irq(&mostek_lock);
-
-	/* Ensure the kick start bit is off. If it isn't, turn it off. */
-	while (mostek_read(regs + MOSTEK_HOUR) & MSTK_KICK_START) {
-		prom_printf("CLOCK: Kick start still on!\n");
-
-		spin_lock_irq(&mostek_lock);
-
-		tmp = mostek_read(regs + MOSTEK_CREG);
-		tmp |= MSTK_CREG_WRITE;
-		mostek_write(regs + MOSTEK_CREG, tmp);
-
-		tmp = mostek_read(regs + MOSTEK_HOUR);
-		tmp &= ~MSTK_KICK_START;
-		mostek_write(regs + MOSTEK_HOUR, tmp);
-
-		tmp = mostek_read(regs + MOSTEK_CREG);
-		tmp &= ~MSTK_CREG_WRITE;
-		mostek_write(regs + MOSTEK_CREG, tmp);
-
-		spin_unlock_irq(&mostek_lock);
-	}
-
-	prom_printf("CLOCK: Kick start procedure successful.\n");
-}
-
-/* Return nonzero if the clock chip battery is low. */
-static int __init has_low_battery(void)
-{
-	void __iomem *regs = mstk48t02_regs;
-	u8 data1, data2;
-
-	spin_lock_irq(&mostek_lock);
-
-	data1 = mostek_read(regs + MOSTEK_EEPROM);	/* Read some data. */
-	mostek_write(regs + MOSTEK_EEPROM, ~data1);	/* Write back the complement. */
-	data2 = mostek_read(regs + MOSTEK_EEPROM);	/* Read back the complement. */
-	mostek_write(regs + MOSTEK_EEPROM, data1);	/* Restore original value. */
-
-	spin_unlock_irq(&mostek_lock);
-
-	return (data1 = data2);	/* Was the write blocked? */
-}
-
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
 	unsigned int year, mon, day, hour, min, sec;
-	void __iomem *mregs = mstk48t02_regs;
 #ifdef CONFIG_PCI
 	unsigned long dregs = ds1287_regs;
 	void __iomem *bregs = bq4802_regs;
@@ -554,16 +417,11 @@ static void __init set_system_time(void)
 	void __iomem *bregs = 0UL;
 #endif
 
-	if (!mregs && !dregs && !bregs) {
+	if (!dregs && !bregs) {
 		prom_printf("Something wrong, clock regs not mapped yet.\n");
 		prom_halt();
 	}		
 
-	if (mregs) {
-		mostek_set_system_time(mregs);
-		return;
-	}
-
 	if (bregs) {
 		unsigned char val = readb(bregs + 0x0e);
 		unsigned int century;
@@ -684,12 +542,9 @@ retry:
 	return -EOPNOTSUPP;
 }
 
-static int __init clock_model_matches(const char *model)
+static int __init rtc_model_matches(const char *model)
 {
-	if (strcmp(model, "mk48t02") &&
-	    strcmp(model, "mk48t08") &&
-	    strcmp(model, "mk48t59") &&
-	    strcmp(model, "m5819") &&
+	if (strcmp(model, "m5819") &&
 	    strcmp(model, "m5819p") &&
 	    strcmp(model, "m5823") &&
 	    strcmp(model, "ds1287") &&
@@ -699,7 +554,7 @@ static int __init clock_model_matches(const char *model)
 	return 1;
 }
 
-static int __devinit clock_probe(struct of_device *op, const struct of_device_id *match)
+static int __devinit rtc_probe(struct of_device *op, const struct of_device_id *match)
 {
 	struct device_node *dp = op->node;
 	const char *model = of_get_property(dp, "model", NULL);
@@ -710,7 +565,7 @@ static int __devinit clock_probe(struct of_device *op, const struct of_device_id
 	if (!model)
 		model = compat;
 
-	if (!model || !clock_model_matches(model))
+	if (!model || !rtc_model_matches(model))
 		return -ENODEV;
 
 	/* On an Enterprise system there can be multiple mostek clocks.
@@ -733,32 +588,12 @@ static int __devinit clock_probe(struct of_device *op, const struct of_device_id
 		ds1287_regs = (unsigned long) regs;
 	} else if (!strcmp(model, "bq4802")) {
 		bq4802_regs = regs;
-	} else
-#endif
-	if (model[5] = '0' && model[6] = '2') {
-		mstk48t02_regs = regs;
-	} else if(model[5] = '0' && model[6] = '8') {
-		mstk48t08_regs = regs;
-		mstk48t02_regs = mstk48t08_regs + MOSTEK_48T08_48T02;
-	} else {
-		mstk48t59_regs = regs;
-		mstk48t02_regs = mstk48t59_regs + MOSTEK_48T59_48T02;
 	}
-
+#endif
 	printk(KERN_INFO "%s: Clock regs at %p\n", dp->full_name, regs);
 
 	local_irq_save(flags);
 
-	if (mstk48t02_regs != NULL) {
-		/* Report a low battery voltage condition. */
-		if (has_low_battery())
-			prom_printf("NVRAM: Low battery voltage!\n");
-
-		/* Kick start the clock if it is completely stopped. */
-		if (mostek_read(mstk48t02_regs + MOSTEK_SEC) & MSTK_STOP)
-			kick_start_clock();
-	}
-
 	set_system_time();
 	
 	local_irq_restore(flags);
@@ -766,21 +601,90 @@ static int __devinit clock_probe(struct of_device *op, const struct of_device_id
 	return 0;
 }
 
-static struct of_device_id clock_match[] = {
+static struct of_device_id rtc_match[] = {
 	{
-		.name = "eeprom",
+		.name = "rtc",
+	},
+	{},
+};
+
+static struct of_platform_driver rtc_driver = {
+	.match_table	= rtc_match,
+	.probe		= rtc_probe,
+	.driver		= {
+		.name	= "rtc",
+	},
+};
+
+static unsigned char mostek_read_byte(struct device *dev, u32 ofs)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	void __iomem *regs;
+	unsigned char val;
+
+	regs = (void __iomem *) pdev->resource[0].start;
+	val = upa_readb(regs + ofs);
+
+	/* the year 0 is 1968 */
+	if (ofs = M48T59_YEAR) {
+		val += 0x68;
+		if ((val & 0xf) > 9)
+			val += 6;
+	}
+	return val;
+}
+
+static void mostek_write_byte(struct device *dev, u32 ofs, u8 val)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	void __iomem *regs;
+
+	regs = (void __iomem *) pdev->resource[0].start;
+	if (ofs = M48T59_YEAR) {
+		if (val < 0x68)
+			val += 0x32;
+		else
+			val -= 0x68;
+		if ((val & 0xf) > 9)
+			val += 6;
+		if ((val & 0xf0) > 0x9A)
+			val += 0x60;
+	}
+	upa_writeb(val, regs + ofs);
+}
+
+static struct m48t59_plat_data m48t59_data = {
+	.read_byte	= mostek_read_byte,
+	.write_byte	= mostek_write_byte,
+};
+
+static struct platform_device m48t59_rtc = {
+	.name		= "rtc-m48t59",
+	.id		= 0,
+	.num_resources	= 1,
+	.dev	= {
+		.platform_data = &m48t59_data,
 	},
+};
+
+static int __devinit mostek_probe(struct of_device *op, const struct of_device_id *match)
+{
+	m48t59_rtc.resource = &op->resource[0];
+	return platform_device_register(&m48t59_rtc);
+}
+
+static struct of_device_id mostek_match[] = {
 	{
-		.name = "rtc",
+		.name = "eeprom",
 	},
 	{},
 };
 
-static struct of_platform_driver clock_driver = {
-	.match_table	= clock_match,
-	.probe		= clock_probe,
+static struct of_platform_driver mostek_driver = {
+	.match_table	= mostek_match,
+	.probe		= mostek_probe,
 	.driver		= {
-		.name	= "clock",
+		.name	= "mostek",
 	},
 };
 
@@ -801,7 +705,10 @@ static int __init clock_init(void)
 		return 0;
 	}
 
-	return of_register_driver(&clock_driver, &of_platform_bus_type);
+	(void) of_register_driver(&rtc_driver, &of_platform_bus_type);
+	(void) of_register_driver(&mostek_driver, &of_platform_bus_type);
+
+	return 0;
 }
 
 /* Must be after subsys_initcall() so that busses are probed.  Must
@@ -1073,7 +980,6 @@ unsigned long long sched_clock(void)
 static int set_rtc_mmss(unsigned long nowtime)
 {
 	int real_seconds, real_minutes, chip_minutes;
-	void __iomem *mregs = mstk48t02_regs;
 #ifdef CONFIG_PCI
 	unsigned long dregs = ds1287_regs;
 	void __iomem *bregs = bq4802_regs;
@@ -1082,62 +988,15 @@ static int set_rtc_mmss(unsigned long nowtime)
 	void __iomem *bregs = 0UL;
 #endif
 	unsigned long flags;
-	u8 tmp;
 
 	/* 
 	 * Not having a register set can lead to trouble.
 	 * Also starfire doesn't have a tod clock.
 	 */
-	if (!mregs && !dregs && !bregs)
+	if (!dregs && !bregs)
 		return -1;
 
-	if (mregs) {
-		spin_lock_irqsave(&mostek_lock, flags);
-
-		/* Read the current RTC minutes. */
-		tmp = mostek_read(mregs + MOSTEK_CREG);
-		tmp |= MSTK_CREG_READ;
-		mostek_write(mregs + MOSTEK_CREG, tmp);
-
-		chip_minutes = MSTK_REG_MIN(mregs);
-
-		tmp = mostek_read(mregs + MOSTEK_CREG);
-		tmp &= ~MSTK_CREG_READ;
-		mostek_write(mregs + MOSTEK_CREG, tmp);
-
-		/*
-		 * since we're only adjusting minutes and seconds,
-		 * don't interfere with hour overflow. This avoids
-		 * messing with unknown time zones but requires your
-		 * RTC not to be off by more than 15 minutes
-		 */
-		real_seconds = nowtime % 60;
-		real_minutes = nowtime / 60;
-		if (((abs(real_minutes - chip_minutes) + 15)/30) & 1)
-			real_minutes += 30;	/* correct for half hour time zone */
-		real_minutes %= 60;
-
-		if (abs(real_minutes - chip_minutes) < 30) {
-			tmp = mostek_read(mregs + MOSTEK_CREG);
-			tmp |= MSTK_CREG_WRITE;
-			mostek_write(mregs + MOSTEK_CREG, tmp);
-
-			MSTK_SET_REG_SEC(mregs,real_seconds);
-			MSTK_SET_REG_MIN(mregs,real_minutes);
-
-			tmp = mostek_read(mregs + MOSTEK_CREG);
-			tmp &= ~MSTK_CREG_WRITE;
-			mostek_write(mregs + MOSTEK_CREG, tmp);
-
-			spin_unlock_irqrestore(&mostek_lock, flags);
-
-			return 0;
-		} else {
-			spin_unlock_irqrestore(&mostek_lock, flags);
-
-			return -1;
-		}
-	} else if (bregs) {
+	if (bregs) {
 		int retval = 0;
 		unsigned char val = readb(bregs + 0x0e);
 
@@ -1480,74 +1339,6 @@ static int cmos_set_rtc_time(struct rtc_time *rtc_tm)
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
@@ -1575,11 +1366,6 @@ static struct mini_rtc_ops cmos_rtc_ops = {
 };
 #endif /* CONFIG_PCI */
 
-static struct mini_rtc_ops mostek_rtc_ops = {
-	.get_rtc_time = mostek_get_rtc_time,
-	.set_rtc_time = mostek_set_rtc_time,
-};
-
 static struct mini_rtc_ops *mini_rtc_ops;
 
 static inline void mini_get_rtc_time(struct rtc_time *time)
@@ -1712,8 +1498,6 @@ static int __init rtc_mini_init(void)
 	else if (ds1287_regs)
 		mini_rtc_ops = &cmos_rtc_ops;
 #endif /* CONFIG_PCI */
-	else if (mstk48t02_regs)
-		mini_rtc_ops = &mostek_rtc_ops;
 	else
 		return -ENODEV;
 
