From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Sat, 06 Sep 2008 17:09:14 +0000
Subject: [PATCH] sparc64: fix wrong m48t59 RTC year
Message-Id: <20080906190914.53c9128d.krzysztof.h1@wp.pl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Correctly calculate offset to the year register for
Mostek RTC.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

This happened because the rtc-m48t59 patches
changed offset constants to new one calculated
as difference from the nvram size.

diff -urp linux-ref/arch/sparc64/kernel/time.c linux-mm/arch/sparc64/kernel/time.c
--- linux-ref/arch/sparc64/kernel/time.c	2008-09-05 23:38:20.000000000 +0200
+++ linux-mm/arch/sparc64/kernel/time.c	2008-09-06 19:02:28.459001489 +0200
@@ -500,6 +500,7 @@ static struct of_platform_driver bq4802_
 static unsigned char mostek_read_byte(struct device *dev, u32 ofs)
 {
 	struct platform_device *pdev = to_platform_device(dev);
+	struct m48t59_plat_data *pdata = pdev->dev.platform_data;
 	void __iomem *regs;
 	unsigned char val;
 
@@ -507,7 +508,7 @@ static unsigned char mostek_read_byte(st
 	val = readb(regs + ofs);
 
 	/* the year 0 is 1968 */
-	if (ofs = M48T59_YEAR) {
+	if (ofs = pdata->offset + M48T59_YEAR) {
 		val += 0x68;
 		if ((val & 0xf) > 9)
 			val += 6;
@@ -518,10 +519,11 @@ static unsigned char mostek_read_byte(st
 static void mostek_write_byte(struct device *dev, u32 ofs, u8 val)
 {
 	struct platform_device *pdev = to_platform_device(dev);
+	struct m48t59_plat_data *pdata = pdev->dev.platform_data;
 	void __iomem *regs;
 
 	regs = (void __iomem *) pdev->resource[0].start;
-	if (ofs = M48T59_YEAR) {
+	if (ofs = pdata->offset + M48T59_YEAR) {
 		if (val < 0x68)
 			val += 0x32;
 		else
