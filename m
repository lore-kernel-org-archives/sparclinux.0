From: David Miller <davem@davemloft.net>
Date: Fri, 29 Aug 2008 06:09:31 +0000
Subject: [PATCH 6/12]: sparc64: Use generic CMOS driver.
Message-Id: <20080828.230931.215622420.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc64: Use generic CMOS driver.

Based largely upon a patch by Krzysztof Helt <krzysztof.h1@poczta.fm>

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/mc146818rtc_64.h |   10 +-
 arch/sparc64/Kconfig                    |    1 +
 arch/sparc64/kernel/time.c              |  372 ++++++++++---------------------
 3 files changed, 123 insertions(+), 260 deletions(-)

diff --git a/arch/sparc/include/asm/mc146818rtc_64.h b/arch/sparc/include/asm/mc146818rtc_64.h
index e9c0fcc..7238d17 100644
--- a/arch/sparc/include/asm/mc146818rtc_64.h
+++ b/arch/sparc/include/asm/mc146818rtc_64.h
@@ -7,12 +7,8 @@
 #include <asm/io.h>
 
 #ifndef RTC_PORT
-#ifdef CONFIG_PCI
-extern unsigned long ds1287_regs;
-#else
-#define ds1287_regs (0UL)
-#endif
-#define RTC_PORT(x)	(ds1287_regs + (x))
+extern unsigned long cmos_regs;
+#define RTC_PORT(x)	(cmos_regs + (x))
 #define RTC_ALWAYS_BCD	0
 #endif
 
@@ -29,6 +25,4 @@ outb_p((addr),RTC_PORT(0)); \
 outb_p((val),RTC_PORT(1)); \
 })
 
-#define RTC_IRQ 8
-
 #endif /* __ASM_SPARC64_MC146818RTC_H */
diff --git a/arch/sparc64/Kconfig b/arch/sparc64/Kconfig
index 0a4e342..e0d783b 100644
--- a/arch/sparc64/Kconfig
+++ b/arch/sparc64/Kconfig
@@ -21,6 +21,7 @@ config SPARC64
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select RTC_CLASS
 	select RTC_DRV_M48T59
+	select RTC_DRV_CMOS
 
 config GENERIC_TIME
 	bool
diff --git a/arch/sparc64/kernel/time.c b/arch/sparc64/kernel/time.c
index 9c2c3d8..abdeead 100644
--- a/arch/sparc64/kernel/time.c
+++ b/arch/sparc64/kernel/time.c
@@ -52,10 +52,7 @@
 #include "entry.h"
 
 DEFINE_SPINLOCK(rtc_lock);
-#ifdef CONFIG_PCI
-unsigned long ds1287_regs = 0UL;
 static void __iomem *bq4802_regs;
-#endif
 
 static int set_rtc_mmss(unsigned long);
 
@@ -413,69 +410,38 @@ int update_persistent_clock(struct timespec now)
 static void __init set_system_time(void)
 {
 	unsigned int year, mon, day, hour, min, sec;
-#ifdef CONFIG_PCI
-	unsigned long dregs = ds1287_regs;
 	void __iomem *bregs = bq4802_regs;
-#else
-	unsigned long dregs = 0UL;
-	void __iomem *bregs = 0UL;
-#endif
+	unsigned char val = readb(bregs + 0x0e);
+	unsigned int century;
 
-	if (!dregs && !bregs) {
+	if (!bregs) {
 		prom_printf("Something wrong, clock regs not mapped yet.\n");
 		prom_halt();
 	}		
 
-	if (bregs) {
-		unsigned char val = readb(bregs + 0x0e);
-		unsigned int century;
+	/* BQ4802 RTC chip. */
 
-		/* BQ4802 RTC chip. */
+	writeb(val | 0x08, bregs + 0x0e);
 
-		writeb(val | 0x08, bregs + 0x0e);
+	sec  = readb(bregs + 0x00);
+	min  = readb(bregs + 0x02);
+	hour = readb(bregs + 0x04);
+	day  = readb(bregs + 0x06);
+	mon  = readb(bregs + 0x09);
+	year = readb(bregs + 0x0a);
+	century = readb(bregs + 0x0f);
 
-		sec  = readb(bregs + 0x00);
-		min  = readb(bregs + 0x02);
-		hour = readb(bregs + 0x04);
-		day  = readb(bregs + 0x06);
-		mon  = readb(bregs + 0x09);
-		year = readb(bregs + 0x0a);
-		century = readb(bregs + 0x0f);
+	writeb(val, bregs + 0x0e);
 
-		writeb(val, bregs + 0x0e);
-
-		BCD_TO_BIN(sec);
-		BCD_TO_BIN(min);
-		BCD_TO_BIN(hour);
-		BCD_TO_BIN(day);
-		BCD_TO_BIN(mon);
-		BCD_TO_BIN(year);
-		BCD_TO_BIN(century);
+	BCD_TO_BIN(sec);
+	BCD_TO_BIN(min);
+	BCD_TO_BIN(hour);
+	BCD_TO_BIN(day);
+	BCD_TO_BIN(mon);
+	BCD_TO_BIN(year);
+	BCD_TO_BIN(century);
 
-		year += (century * 100);
-	} else {
-		/* Dallas 12887 RTC chip. */
-
-		do {
-			sec  = CMOS_READ(RTC_SECONDS);
-			min  = CMOS_READ(RTC_MINUTES);
-			hour = CMOS_READ(RTC_HOURS);
-			day  = CMOS_READ(RTC_DAY_OF_MONTH);
-			mon  = CMOS_READ(RTC_MONTH);
-			year = CMOS_READ(RTC_YEAR);
-		} while (sec != CMOS_READ(RTC_SECONDS));
-
-		if (!(CMOS_READ(RTC_CONTROL) & RTC_DM_BINARY) || RTC_ALWAYS_BCD) {
-			BCD_TO_BIN(sec);
-			BCD_TO_BIN(min);
-			BCD_TO_BIN(hour);
-			BCD_TO_BIN(day);
-			BCD_TO_BIN(mon);
-			BCD_TO_BIN(year);
-		}
-		if ((year += 1900) < 1970)
-			year += 100;
-	}
+	year += (century * 100);
 
 	xtime.tv_sec = mktime(year, mon, day, hour, min, sec);
 	xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
@@ -546,48 +512,79 @@ retry:
 	return -EOPNOTSUPP;
 }
 
-static int __init rtc_model_matches(const char *model)
-{
-	if (strcmp(model, "m5819") &&
-	    strcmp(model, "m5819p") &&
-	    strcmp(model, "m5823") &&
-	    strcmp(model, "ds1287") &&
-	    strcmp(model, "bq4802"))
-		return 0;
+unsigned long cmos_regs;
+EXPORT_SYMBOL(cmos_regs);
 
-	return 1;
-}
+struct resource rtc_cmos_resource;
+
+static struct platform_device rtc_cmos_device = {
+	.name		= "rtc_cmos",
+	.id		= -1,
+	.resource	= &rtc_cmos_resource,
+	.num_resources	= 1,
+};
 
 static int __devinit rtc_probe(struct of_device *op, const struct of_device_id *match)
 {
-	struct device_node *dp = op->node;
-	const char *model = of_get_property(dp, "model", NULL);
-	const char *compat = of_get_property(dp, "compatible", NULL);
-	unsigned long size, flags;
-	void __iomem *regs;
+	struct resource *r;
 
-	if (!model)
-		model = compat;
+	printk(KERN_INFO "%s: RTC regs at 0x%lx\n",
+	       op->node->full_name, op->resource[0].start);
 
-	if (!model || !rtc_model_matches(model))
-		return -ENODEV;
+	/* The CMOS RTC driver only accepts IORESOURCE_IO, so cons
+	 * up a fake resource so that the probe works for all cases.
+	 * When the RTC is behind an ISA bus it will have IORESOURCE_IO
+	 * already, whereas when it's behind EBUS is will be IORESOURCE_MEM.
+	 */
+
+	r = &rtc_cmos_resource;
+	r->flags = IORESOURCE_IO;
+	r->name = op->resource[0].name;
+	r->start = op->resource[0].start;
+	r->end = op->resource[0].end;
+
+	cmos_regs = op->resource[0].start;
+	return platform_device_register(&rtc_cmos_device);
+}
+
+static struct of_device_id rtc_match[] = {
+	{
+		.name = "rtc",
+		.compatible = "m5819",
+	},
+	{
+		.name = "rtc",
+		.compatible = "isa-m5819p",
+	},
+	{
+		.name = "rtc",
+		.compatible = "isa-m5823p",
+	},
+	{
+		.name = "rtc",
+		.compatible = "ds1287",
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
 
-	size = (op->resource[0].end - op->resource[0].start) + 1;
-	regs = of_ioremap(&op->resource[0], 0, size, "clock");
-	if (!regs)
+static int __devinit bq4802_probe(struct of_device *op, const struct of_device_id *match)
+{
+	struct device_node *dp = op->node;
+	unsigned long flags;
+
+	bq4802_regs = of_ioremap(&op->resource[0], 0, resource_size(&op->resource[0]), "bq4802");
+	if (!bq4802_regs)
 		return -ENOMEM;
 
-#ifdef CONFIG_PCI
-	if (!strcmp(model, "ds1287") ||
-	    !strcmp(model, "m5819") ||
-	    !strcmp(model, "m5819p") ||
-	    !strcmp(model, "m5823")) {
-		ds1287_regs = (unsigned long) regs;
-	} else if (!strcmp(model, "bq4802")) {
-		bq4802_regs = regs;
-	}
-#endif
-	printk(KERN_INFO "%s: Clock regs at %p\n", dp->full_name, regs);
+	printk(KERN_INFO "%s: Clock regs at %p\n", dp->full_name, bq4802_regs);
 
 	local_irq_save(flags);
 
@@ -598,18 +595,18 @@ static int __devinit rtc_probe(struct of_device *op, const struct of_device_id *
 	return 0;
 }
 
-static struct of_device_id rtc_match[] = {
+static struct of_device_id bq4802_match[] = {
 	{
 		.name = "rtc",
+		.compatible = "bq4802",
 	},
-	{},
 };
 
-static struct of_platform_driver rtc_driver = {
-	.match_table	= rtc_match,
-	.probe		= rtc_probe,
+static struct of_platform_driver bq4802_driver = {
+	.match_table	= bq4802_match,
+	.probe		= bq4802_probe,
 	.driver		= {
-		.name	= "rtc",
+		.name	= "bq4802",
 	},
 };
 
@@ -716,6 +713,7 @@ static int __init clock_init(void)
 
 	(void) of_register_driver(&rtc_driver, &of_platform_bus_type);
 	(void) of_register_driver(&mostek_driver, &of_platform_bus_type);
+	(void) of_register_driver(&bq4802_driver, &of_platform_bus_type);
 
 	return 0;
 }
@@ -989,96 +987,51 @@ unsigned long long sched_clock(void)
 static int set_rtc_mmss(unsigned long nowtime)
 {
 	int real_seconds, real_minutes, chip_minutes;
-#ifdef CONFIG_PCI
-	unsigned long dregs = ds1287_regs;
 	void __iomem *bregs = bq4802_regs;
-#else
-	unsigned long dregs = 0UL;
-	void __iomem *bregs = 0UL;
-#endif
 	unsigned long flags;
+	unsigned char val;
+	int retval = 0;
 
 	/* 
 	 * Not having a register set can lead to trouble.
 	 * Also starfire doesn't have a tod clock.
 	 */
-	if (!dregs && !bregs)
+	if (!bregs)
 		return -1;
 
-	if (bregs) {
-		int retval = 0;
-		unsigned char val = readb(bregs + 0x0e);
+	spin_lock_irqsave(&rtc_lock, flags);
 
-		/* BQ4802 RTC chip. */
+	val = readb(bregs + 0x0e);
 
-		writeb(val | 0x08, bregs + 0x0e);
+	/* BQ4802 RTC chip. */
 
-		chip_minutes = readb(bregs + 0x02);
-		BCD_TO_BIN(chip_minutes);
-		real_seconds = nowtime % 60;
-		real_minutes = nowtime / 60;
-		if (((abs(real_minutes - chip_minutes) + 15)/30) & 1)
-			real_minutes += 30;
-		real_minutes %= 60;
+	writeb(val | 0x08, bregs + 0x0e);
 
-		if (abs(real_minutes - chip_minutes) < 30) {
-			BIN_TO_BCD(real_seconds);
-			BIN_TO_BCD(real_minutes);
-			writeb(real_seconds, bregs + 0x00);
-			writeb(real_minutes, bregs + 0x02);
-		} else {
-			printk(KERN_WARNING
-			       "set_rtc_mmss: can't update from %d to %d\n",
-			       chip_minutes, real_minutes);
-			retval = -1;
-		}
+	chip_minutes = readb(bregs + 0x02);
+	BCD_TO_BIN(chip_minutes);
+	real_seconds = nowtime % 60;
+	real_minutes = nowtime / 60;
+	if (((abs(real_minutes - chip_minutes) + 15)/30) & 1)
+		real_minutes += 30;
+	real_minutes %= 60;
 
-		writeb(val, bregs + 0x0e);
-
-		return retval;
+	if (abs(real_minutes - chip_minutes) < 30) {
+		BIN_TO_BCD(real_seconds);
+		BIN_TO_BCD(real_minutes);
+		writeb(real_seconds, bregs + 0x00);
+		writeb(real_minutes, bregs + 0x02);
 	} else {
-		int retval = 0;
-		unsigned char save_control, save_freq_select;
-
-		/* Stolen from arch/i386/kernel/time.c, see there for
-		 * credits and descriptive comments.
-		 */
-		spin_lock_irqsave(&rtc_lock, flags);
-		save_control = CMOS_READ(RTC_CONTROL); /* tell the clock it's being set */
-		CMOS_WRITE((save_control|RTC_SET), RTC_CONTROL);
-
-		save_freq_select = CMOS_READ(RTC_FREQ_SELECT); /* stop and reset prescaler */
-		CMOS_WRITE((save_freq_select|RTC_DIV_RESET2), RTC_FREQ_SELECT);
-
-		chip_minutes = CMOS_READ(RTC_MINUTES);
-		if (!(save_control & RTC_DM_BINARY) || RTC_ALWAYS_BCD)
-			BCD_TO_BIN(chip_minutes);
-		real_seconds = nowtime % 60;
-		real_minutes = nowtime / 60;
-		if (((abs(real_minutes - chip_minutes) + 15)/30) & 1)
-			real_minutes += 30;
-		real_minutes %= 60;
-
-		if (abs(real_minutes - chip_minutes) < 30) {
-			if (!(save_control & RTC_DM_BINARY) || RTC_ALWAYS_BCD) {
-				BIN_TO_BCD(real_seconds);
-				BIN_TO_BCD(real_minutes);
-			}
-			CMOS_WRITE(real_seconds,RTC_SECONDS);
-			CMOS_WRITE(real_minutes,RTC_MINUTES);
-		} else {
-			printk(KERN_WARNING
-			       "set_rtc_mmss: can't update from %d to %d\n",
-			       chip_minutes, real_minutes);
-			retval = -1;
-		}
+		printk(KERN_WARNING
+		       "set_rtc_mmss: can't update from %d to %d\n",
+		       chip_minutes, real_minutes);
+		retval = -1;
+	}
 
-		CMOS_WRITE(save_control, RTC_CONTROL);
-		CMOS_WRITE(save_freq_select, RTC_FREQ_SELECT);
-		spin_unlock_irqrestore(&rtc_lock, flags);
+	writeb(val, bregs + 0x0e);
 
-		return retval;
-	}
+	spin_unlock_irqrestore(&rtc_lock, flags);
+
+	return retval;
 }
 
 #define RTC_IS_OPEN		0x01	/* means /dev/rtc is in use	*/
@@ -1202,7 +1155,6 @@ static int hypervisor_set_rtc_time(struct rtc_time *time)
 	return hypervisor_set_time(seconds);
 }
 
-#ifdef CONFIG_PCI
 static void bq4802_get_rtc_time(struct rtc_time *time)
 {
 	unsigned char val = readb(bq4802_regs + 0x0e);
@@ -1275,79 +1227,6 @@ static int bq4802_set_rtc_time(struct rtc_time *time)
 	return 0;
 }
 
-static void cmos_get_rtc_time(struct rtc_time *rtc_tm)
-{
-	unsigned char ctrl;
-
-	rtc_tm->tm_sec = CMOS_READ(RTC_SECONDS);
-	rtc_tm->tm_min = CMOS_READ(RTC_MINUTES);
-	rtc_tm->tm_hour = CMOS_READ(RTC_HOURS);
-	rtc_tm->tm_mday = CMOS_READ(RTC_DAY_OF_MONTH);
-	rtc_tm->tm_mon = CMOS_READ(RTC_MONTH);
-	rtc_tm->tm_year = CMOS_READ(RTC_YEAR);
-	rtc_tm->tm_wday = CMOS_READ(RTC_DAY_OF_WEEK);
-
-	ctrl = CMOS_READ(RTC_CONTROL);
-	if (!(ctrl & RTC_DM_BINARY) || RTC_ALWAYS_BCD) {
-		BCD_TO_BIN(rtc_tm->tm_sec);
-		BCD_TO_BIN(rtc_tm->tm_min);
-		BCD_TO_BIN(rtc_tm->tm_hour);
-		BCD_TO_BIN(rtc_tm->tm_mday);
-		BCD_TO_BIN(rtc_tm->tm_mon);
-		BCD_TO_BIN(rtc_tm->tm_year);
-		BCD_TO_BIN(rtc_tm->tm_wday);
-	}
-
-	if (rtc_tm->tm_year <= 69)
-		rtc_tm->tm_year += 100;
-
-	rtc_tm->tm_mon--;
-}
-
-static int cmos_set_rtc_time(struct rtc_time *rtc_tm)
-{
-	unsigned char mon, day, hrs, min, sec;
-	unsigned char save_control, save_freq_select;
-	unsigned int yrs;
-
-	yrs = rtc_tm->tm_year;
-	mon = rtc_tm->tm_mon + 1;
-	day = rtc_tm->tm_mday;
-	hrs = rtc_tm->tm_hour;
-	min = rtc_tm->tm_min;
-	sec = rtc_tm->tm_sec;
-
-	if (yrs >= 100)
-		yrs -= 100;
-
-	if (!(CMOS_READ(RTC_CONTROL) & RTC_DM_BINARY) || RTC_ALWAYS_BCD) {
-		BIN_TO_BCD(sec);
-		BIN_TO_BCD(min);
-		BIN_TO_BCD(hrs);
-		BIN_TO_BCD(day);
-		BIN_TO_BCD(mon);
-		BIN_TO_BCD(yrs);
-	}
-
-	save_control = CMOS_READ(RTC_CONTROL);
-	CMOS_WRITE((save_control|RTC_SET), RTC_CONTROL);
-	save_freq_select = CMOS_READ(RTC_FREQ_SELECT);
-	CMOS_WRITE((save_freq_select|RTC_DIV_RESET2), RTC_FREQ_SELECT);
-
-	CMOS_WRITE(yrs, RTC_YEAR);
-	CMOS_WRITE(mon, RTC_MONTH);
-	CMOS_WRITE(day, RTC_DAY_OF_MONTH);
-	CMOS_WRITE(hrs, RTC_HOURS);
-	CMOS_WRITE(min, RTC_MINUTES);
-	CMOS_WRITE(sec, RTC_SECONDS);
-
-	CMOS_WRITE(save_control, RTC_CONTROL);
-	CMOS_WRITE(save_freq_select, RTC_FREQ_SELECT);
-
-	return 0;
-}
-#endif /* CONFIG_PCI */
-
 struct mini_rtc_ops {
 	void (*get_rtc_time)(struct rtc_time *);
 	int (*set_rtc_time)(struct rtc_time *);
@@ -1363,18 +1242,11 @@ static struct mini_rtc_ops hypervisor_rtc_ops = {
 	.set_rtc_time = hypervisor_set_rtc_time,
 };
 
-#ifdef CONFIG_PCI
 static struct mini_rtc_ops bq4802_rtc_ops = {
 	.get_rtc_time = bq4802_get_rtc_time,
 	.set_rtc_time = bq4802_set_rtc_time,
 };
 
-static struct mini_rtc_ops cmos_rtc_ops = {
-	.get_rtc_time = cmos_get_rtc_time,
-	.set_rtc_time = cmos_set_rtc_time,
-};
-#endif /* CONFIG_PCI */
-
 static struct mini_rtc_ops *mini_rtc_ops;
 
 static inline void mini_get_rtc_time(struct rtc_time *time)
@@ -1501,12 +1373,8 @@ static int __init rtc_mini_init(void)
 		mini_rtc_ops = &hypervisor_rtc_ops;
 	else if (this_is_starfire)
 		mini_rtc_ops = &starfire_rtc_ops;
-#ifdef CONFIG_PCI
 	else if (bq4802_regs)
 		mini_rtc_ops = &bq4802_rtc_ops;
-	else if (ds1287_regs)
-		mini_rtc_ops = &cmos_rtc_ops;
-#endif /* CONFIG_PCI */
 	else
 		return -ENODEV;
 
-- 
1.5.6.5.GIT

