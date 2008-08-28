From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Date: Thu, 28 Aug 2008 21:22:51 +0000
Subject: [RFC] minirtc conversion to rtc layer (cmos rtc)
Message-Id: <20080828232251.e2c3ffed.krzysztof.h1@poczta.fm>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

The patch below is totally untested (I have no hardware)
conversion of rtc cmos type to use the rtc layer.

The rtc is pc cmos type if the model property equals one
of the following: ds1287, m5819, m5819p, m5823.

The driver requires selected rtc layer and the pc cmos rtc
driver. The /dev/rtc device does not work. One must link
the new /dev/rtc0 as the /dev/rtc.

This patch should not require any other patches.

Please test the patch. I don't know which sparc64 machines
have the pc cmos compatible clocks (U60 certainly not).

Regards,
Krzysztof

diff -urp linux-old/arch/sparc64/kernel/time.c linux-sparc/arch/sparc64/kernel/time.c
--- linux-old/arch/sparc64/kernel/time.c	2008-08-09 05:08:20.000000000 +0200
+++ linux-sparc/arch/sparc64/kernel/time.c	2008-08-28 23:10:06.899655565 +0200
@@ -34,6 +34,7 @@
 #include <linux/clockchips.h>
 #include <linux/clocksource.h>
 #include <linux/of_device.h>
+#include <linux/platform_device.h>
 
 #include <asm/oplib.h>
 #include <asm/mostek.h>
@@ -408,6 +409,17 @@ int update_persistent_clock(struct times
 	return set_rtc_mmss(now.tv_sec);
 }
 
+static struct resource ds1287_resource = {
+	.flags	= IORESOURCE_IO,
+};
+
+static struct platform_device ds1287_rtc = {
+	.name		= "rtc_cmos",
+	.id		= -1,
+	.resource	= &ds1287_resource,
+	.num_resources	= 1,
+};
+
 /* Kick start a stopped clock (procedure from the Sun NVRAM/hostid FAQ). */
 static void __init kick_start_clock(void)
 {
@@ -731,6 +743,12 @@ static int __devinit clock_probe(struct 
 	    !strcmp(model, "m5819p") ||
 	    !strcmp(model, "m5823")) {
 		ds1287_regs = (unsigned long) regs;
+		ds1287_rtc.resource[0].start = (unsigned long)regs;
+		ds1287_rtc.resource[0].end = (unsigned long)(regs + size - 1);
+
+		if (platform_device_register(&ds1287_rtc) < 0)
+			printk(KERN_ERR "Registering RTC device failed\n");
+
 	} else if (!strcmp(model, "bq4802")) {
 		bq4802_regs = regs;
 	} else
@@ -1406,78 +1424,6 @@ static int bq4802_set_rtc_time(struct rt
 
 	return 0;
 }
-
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
 #endif /* CONFIG_PCI */
 
 static void mostek_get_rtc_time(struct rtc_time *rtc_tm)
@@ -1568,11 +1514,6 @@ static struct mini_rtc_ops bq4802_rtc_op
 	.get_rtc_time = bq4802_get_rtc_time,
 	.set_rtc_time = bq4802_set_rtc_time,
 };
-
-static struct mini_rtc_ops cmos_rtc_ops = {
-	.get_rtc_time = cmos_get_rtc_time,
-	.set_rtc_time = cmos_set_rtc_time,
-};
 #endif /* CONFIG_PCI */
 
 static struct mini_rtc_ops mostek_rtc_ops = {
@@ -1710,7 +1651,7 @@ static int __init rtc_mini_init(void)
 	else if (bq4802_regs)
 		mini_rtc_ops = &bq4802_rtc_ops;
 	else if (ds1287_regs)
-		mini_rtc_ops = &cmos_rtc_ops;
+		return -ENODEV;
 #endif /* CONFIG_PCI */
 	else if (mstk48t02_regs)
 		mini_rtc_ops = &mostek_rtc_ops;

---------------------------------------------------------------
Nasilaja sie kradzieze.
Mieszkancy osiedli zaniepokojeni.
Prosimy o pomoc w tej sprawie >>> http://link.interia.pl/f1eef


