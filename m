From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Date: Mon, 13 Oct 2008 20:51:14 +0000
Subject: Re: [PATCH] rtc-m48t59: fix setting of a year on m48t08 and m48t02
Message-Id: <20081013225114.400a972f.krzysztof.h1@poczta.fm>
List-Id: <sparclinux.vger.kernel.org>
References: <20080904185704.e5c9d1fc.krzysztof.h1@poczta.fm>
In-Reply-To: <20080904185704.e5c9d1fc.krzysztof.h1@poczta.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Alexander,

Please try the patch below if it fixes your problem. You need to set 
correct date (year) after the patched kernel is run.

It is tested on Ultra60 but not tested on sparc32.

Kind regards,
Krzysztof
----

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Shift the first year to 1968 for Sun SPARC machines.

Move this logic from platform specific files to rtc driver
as this fixes problems with correctly calculating a century
bit.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

diff -urp linux-ref/arch/sparc/kernel/time.c linux-new/arch/sparc/kernel/time.c
--- linux-ref/arch/sparc/kernel/time.c	2008-10-13 12:03:18.861547000 -0400
+++ linux-new/arch/sparc/kernel/time.c	2008-10-14 00:12:39.263787485 -0400
@@ -119,35 +119,16 @@ static unsigned char mostek_read_byte(st
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct m48t59_plat_data *pdata = pdev->dev.platform_data;
-	void __iomem *regs = pdata->ioaddr;
-	unsigned char val = readb(regs + ofs);
 
-	/* the year 0 is 1968 */
-	if (ofs = pdata->offset + M48T59_YEAR) {
-		val += 0x68;
-		if ((val & 0xf) > 9)
-			val += 6;
-	}
-	return val;
+	return readb(pdata->ioaddr + ofs);
 }
 
 static void mostek_write_byte(struct device *dev, u32 ofs, u8 val)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct m48t59_plat_data *pdata = pdev->dev.platform_data;
-	void __iomem *regs = pdata->ioaddr;
 
-	if (ofs = pdata->offset + M48T59_YEAR) {
-		if (val < 0x68)
-			val += 0x32;
-		else
-			val -= 0x68;
-		if ((val & 0xf) > 9)
-			val += 6;
-		if ((val & 0xf0) > 0x9A)
-			val += 0x60;
-	}
-	writeb(val, regs + ofs);
+	writeb(val, pdata->ioaddr + ofs);
 }
 
 static struct m48t59_plat_data m48t59_data = {
diff -urp linux-ref/arch/sparc64/kernel/time.c linux-new/arch/sparc64/kernel/time.c
--- linux-ref/arch/sparc64/kernel/time.c	2008-10-13 12:03:18.993543000 -0400
+++ linux-new/arch/sparc64/kernel/time.c	2008-10-14 00:13:29.991786912 -0400
@@ -503,39 +503,16 @@ static struct of_platform_driver bq4802_
 static unsigned char mostek_read_byte(struct device *dev, u32 ofs)
 {
 	struct platform_device *pdev = to_platform_device(dev);
-	struct m48t59_plat_data *pdata = pdev->dev.platform_data;
-	void __iomem *regs;
-	unsigned char val;
-
-	regs = (void __iomem *) pdev->resource[0].start;
-	val = readb(regs + ofs);
-
-	/* the year 0 is 1968 */
-	if (ofs = pdata->offset + M48T59_YEAR) {
-		val += 0x68;
-		if ((val & 0xf) > 9)
-			val += 6;
-	}
-	return val;
+	void __iomem *regs = (void __iomem *) pdev->resource[0].start;
+
+	return readb(regs + ofs);
 }
 
 static void mostek_write_byte(struct device *dev, u32 ofs, u8 val)
 {
 	struct platform_device *pdev = to_platform_device(dev);
-	struct m48t59_plat_data *pdata = pdev->dev.platform_data;
-	void __iomem *regs;
+	void __iomem *regs = (void __iomem *) pdev->resource[0].start;
 
-	regs = (void __iomem *) pdev->resource[0].start;
-	if (ofs = pdata->offset + M48T59_YEAR) {
-		if (val < 0x68)
-			val += 0x32;
-		else
-			val -= 0x68;
-		if ((val & 0xf) > 9)
-			val += 6;
-		if ((val & 0xf0) > 0x9A)
-			val += 0x60;
-	}
 	writeb(val, regs + ofs);
 }
 
diff -urp linux-ref/drivers/rtc/rtc-m48t59.c linux-new/drivers/rtc/rtc-m48t59.c
--- linux-ref/drivers/rtc/rtc-m48t59.c	2008-10-13 12:03:34.261538000 -0400
+++ linux-new/drivers/rtc/rtc-m48t59.c	2008-10-14 00:15:15.947787512 -0400
@@ -87,6 +87,10 @@ static int m48t59_rtc_read_time(struct d
 		dev_dbg(dev, "Century bit is enabled\n");
 		tm->tm_year += 100;	/* one century */
 	}
+#if defined(CONFIG_SPARC) || defined(CONFIG_SPARC64)
+	/* Sun SPARC machines count years since 1968 */
+	tm->tm_year += 68;
+#endif
 
 	tm->tm_wday	= BCD2BIN(val & 0x07);
 	tm->tm_hour	= BCD2BIN(M48T59_READ(M48T59_HOUR) & 0x3F);
@@ -110,11 +114,20 @@ static int m48t59_rtc_set_time(struct de
 	struct m48t59_private *m48t59 = platform_get_drvdata(pdev);
 	unsigned long flags;
 	u8 val = 0;
+	int year = tm->tm_year;
+
+#if defined(CONFIG_SPARC) || defined(CONFIG_SPARC64)
+	/* Sun SPARC machines count years since 1968 */
+	year -= 68;
+#endif
 
 	dev_dbg(dev, "RTC set time %04d-%02d-%02d %02d/%02d/%02d\n",
-		tm->tm_year + 1900, tm->tm_mon, tm->tm_mday,
+		year + 1900, tm->tm_mon, tm->tm_mday,
 		tm->tm_hour, tm->tm_min, tm->tm_sec);
 
+	if (year < 0)
+		return -EINVAL;
+
 	spin_lock_irqsave(&m48t59->lock, flags);
 	/* Issue the WRITE command */
 	M48T59_SET_BITS(M48T59_CNTL_WRITE, M48T59_CNTL);
@@ -125,7 +138,7 @@ static int m48t59_rtc_set_time(struct de
 	M48T59_WRITE((BIN2BCD(tm->tm_mday) & 0x3F), M48T59_MDAY);
 	/* tm_mon is 0-11 */
 	M48T59_WRITE((BIN2BCD(tm->tm_mon + 1) & 0x1F), M48T59_MONTH);
-	M48T59_WRITE(BIN2BCD(tm->tm_year % 100), M48T59_YEAR);
+	M48T59_WRITE(BIN2BCD(year % 100), M48T59_YEAR);
 
 	if (pdata->type = M48T59RTC_TYPE_M48T59 && (tm->tm_year / 100))
 		val = (M48T59_WDAY_CEB | M48T59_WDAY_CB);
@@ -159,6 +172,10 @@ static int m48t59_rtc_readalarm(struct d
 	M48T59_SET_BITS(M48T59_CNTL_READ, M48T59_CNTL);
 
 	tm->tm_year = BCD2BIN(M48T59_READ(M48T59_YEAR));
+#if defined(CONFIG_SPARC) || defined(CONFIG_SPARC64)
+	/* Sun SPARC machines count years since 1968 */
+	tm->tm_year += 68;
+#endif
 	/* tm_mon is 0-11 */
 	tm->tm_mon = BCD2BIN(M48T59_READ(M48T59_MONTH)) - 1;
 
@@ -192,11 +209,20 @@ static int m48t59_rtc_setalarm(struct de
 	struct rtc_time *tm = &alrm->time;
 	u8 mday, hour, min, sec;
 	unsigned long flags;
+	int year = tm->tm_year;
+
+#if defined(CONFIG_SPARC) || defined(CONFIG_SPARC64)
+	/* Sun SPARC machines count years since 1968 */
+	year -= 68;
+#endif
 
 	/* If no irq, we don't support ALARM */
 	if (m48t59->irq = NO_IRQ)
 		return -EIO;
 
+	if (year < 0)
+		return -EINVAL;
+
 	/*
 	 * 0xff means "always match"
 	 */
@@ -228,7 +254,7 @@ static int m48t59_rtc_setalarm(struct de
 	spin_unlock_irqrestore(&m48t59->lock, flags);
 
 	dev_dbg(dev, "RTC set alarm time %04d-%02d-%02d %02d/%02d/%02d\n",
-		tm->tm_year + 1900, tm->tm_mon, tm->tm_mday,
+		year + 1900, tm->tm_mon, tm->tm_mday,
 		tm->tm_hour, tm->tm_min, tm->tm_sec);
 	return 0;
 }

----------------------------------------------------------------------
Doladuj w promocji telefon! 
Sprawdz >>  http://link.interia.pl/f1f45 

