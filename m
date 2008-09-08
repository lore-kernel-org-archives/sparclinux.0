From: David Miller <davem@davemloft.net>
Date: Mon, 08 Sep 2008 01:14:09 +0000
Subject: Re: rtc-m48t59 on an Ultra 5
Message-Id: <20080907.181409.151545374.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080906014432.GA21910@orion.carnet.hr>
In-Reply-To: <20080906014432.GA21910@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josip Rodin <joy@entuzijast.net>
Date: Sat, 6 Sep 2008 03:44:32 +0200

> Current sparc-next-2.6 on my Ultra 5 works fine, but the new RTC driver
> prints the following during boot:
> 
> rtc-m48t59 rtc-m48t59.0: rtc core: registered m48t59 as rtc0
> rtc-m48t59 rtc-m48t59.0: hctosys: invalid date/time
> 
> The system time is okay after boot, though.

It might be related to this bug fix I just added to the
sparc-next-2.6 tree:

sparc64: fix wrong m48t59 RTC year

Correctly calculate offset to the year register for
Mostek RTC.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc64/kernel/time.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/sparc64/kernel/time.c b/arch/sparc64/kernel/time.c
index 209e7d2..226a004 100644
--- a/arch/sparc64/kernel/time.c
+++ b/arch/sparc64/kernel/time.c
@@ -500,6 +500,7 @@ static struct of_platform_driver bq4802_driver = {
 static unsigned char mostek_read_byte(struct device *dev, u32 ofs)
 {
 	struct platform_device *pdev = to_platform_device(dev);
+	struct m48t59_plat_data *pdata = pdev->dev.platform_data;
 	void __iomem *regs;
 	unsigned char val;
 
@@ -507,7 +508,7 @@ static unsigned char mostek_read_byte(struct device *dev, u32 ofs)
 	val = readb(regs + ofs);
 
 	/* the year 0 is 1968 */
-	if (ofs = M48T59_YEAR) {
+	if (ofs = pdata->offset + M48T59_YEAR) {
 		val += 0x68;
 		if ((val & 0xf) > 9)
 			val += 6;
@@ -518,10 +519,11 @@ static unsigned char mostek_read_byte(struct device *dev, u32 ofs)
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
-- 
1.5.6.5.GIT

