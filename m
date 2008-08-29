From: David Miller <davem@davemloft.net>
Date: Fri, 29 Aug 2008 06:09:37 +0000
Subject: [PATCH 8/12]: sparc64: Use generic BQ4802 RTC driver.
Message-Id: <20080828.230937.103604198.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc64: Use generic BQ4802 RTC driver.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc64/Kconfig       |    1 +
 arch/sparc64/kernel/time.c |  201 +++-----------------------------------------
 2 files changed, 12 insertions(+), 190 deletions(-)

diff --git a/arch/sparc64/Kconfig b/arch/sparc64/Kconfig
index e0d783b..a4ec899 100644
--- a/arch/sparc64/Kconfig
+++ b/arch/sparc64/Kconfig
@@ -22,6 +22,7 @@ config SPARC64
 	select RTC_CLASS
 	select RTC_DRV_M48T59
 	select RTC_DRV_CMOS
+	select RTC_DRV_BQ4802
 
 config GENERIC_TIME
 	bool
diff --git a/arch/sparc64/kernel/time.c b/arch/sparc64/kernel/time.c
index abdeead..5e199a0 100644
--- a/arch/sparc64/kernel/time.c
+++ b/arch/sparc64/kernel/time.c
@@ -52,9 +52,6 @@
 #include "entry.h"
 
 DEFINE_SPINLOCK(rtc_lock);
-static void __iomem *bq4802_regs;
-
-static int set_rtc_mmss(unsigned long);
 
 #define TICK_PRIV_BIT	(1UL << 63)
 #define TICKCMP_IRQ_BIT	(1UL << 63)
@@ -403,50 +400,7 @@ int update_persistent_clock(struct timespec now)
 	if (rtc)
 		return rtc_set_mmss(rtc, now.tv_sec);
 
-	return set_rtc_mmss(now.tv_sec);
-}
-
-/* Probe for the real time clock chip. */
-static void __init set_system_time(void)
-{
-	unsigned int year, mon, day, hour, min, sec;
-	void __iomem *bregs = bq4802_regs;
-	unsigned char val = readb(bregs + 0x0e);
-	unsigned int century;
-
-	if (!bregs) {
-		prom_printf("Something wrong, clock regs not mapped yet.\n");
-		prom_halt();
-	}		
-
-	/* BQ4802 RTC chip. */
-
-	writeb(val | 0x08, bregs + 0x0e);
-
-	sec  = readb(bregs + 0x00);
-	min  = readb(bregs + 0x02);
-	hour = readb(bregs + 0x04);
-	day  = readb(bregs + 0x06);
-	mon  = readb(bregs + 0x09);
-	year = readb(bregs + 0x0a);
-	century = readb(bregs + 0x0f);
-
-	writeb(val, bregs + 0x0e);
-
-	BCD_TO_BIN(sec);
-	BCD_TO_BIN(min);
-	BCD_TO_BIN(hour);
-	BCD_TO_BIN(day);
-	BCD_TO_BIN(mon);
-	BCD_TO_BIN(year);
-	BCD_TO_BIN(century);
-
-	year += (century * 100);
-
-	xtime.tv_sec = mktime(year, mon, day, hour, min, sec);
-	xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
-	set_normalized_timespec(&wall_to_monotonic,
- 	                        -xtime.tv_sec, -xtime.tv_nsec);
+	return -1;
 }
 
 /* davem suggests we keep this within the 4M locked kernel image */
@@ -575,24 +529,20 @@ static struct of_platform_driver rtc_driver = {
 	},
 };
 
+static struct platform_device rtc_bq4802_device = {
+	.name		= "rtc-bq4802",
+	.id		= -1,
+	.num_resources	= 1,
+};
+
 static int __devinit bq4802_probe(struct of_device *op, const struct of_device_id *match)
 {
-	struct device_node *dp = op->node;
-	unsigned long flags;
-
-	bq4802_regs = of_ioremap(&op->resource[0], 0, resource_size(&op->resource[0]), "bq4802");
-	if (!bq4802_regs)
-		return -ENOMEM;
-
-	printk(KERN_INFO "%s: Clock regs at %p\n", dp->full_name, bq4802_regs);
 
-	local_irq_save(flags);
-
-	set_system_time();
-	
-	local_irq_restore(flags);
+	printk(KERN_INFO "%s: BQ4802 regs at 0x%lx\n",
+	       op->node->full_name, op->resource[0].start);
 
-	return 0;
+	rtc_bq4802_device.resource = &op->resource[0];
+	return platform_device_register(&rtc_bq4802_device);
 }
 
 static struct of_device_id bq4802_match[] = {
@@ -984,56 +934,6 @@ unsigned long long sched_clock(void)
 		>> SPARC64_NSEC_PER_CYC_SHIFT;
 }
 
-static int set_rtc_mmss(unsigned long nowtime)
-{
-	int real_seconds, real_minutes, chip_minutes;
-	void __iomem *bregs = bq4802_regs;
-	unsigned long flags;
-	unsigned char val;
-	int retval = 0;
-
-	/* 
-	 * Not having a register set can lead to trouble.
-	 * Also starfire doesn't have a tod clock.
-	 */
-	if (!bregs)
-		return -1;
-
-	spin_lock_irqsave(&rtc_lock, flags);
-
-	val = readb(bregs + 0x0e);
-
-	/* BQ4802 RTC chip. */
-
-	writeb(val | 0x08, bregs + 0x0e);
-
-	chip_minutes = readb(bregs + 0x02);
-	BCD_TO_BIN(chip_minutes);
-	real_seconds = nowtime % 60;
-	real_minutes = nowtime / 60;
-	if (((abs(real_minutes - chip_minutes) + 15)/30) & 1)
-		real_minutes += 30;
-	real_minutes %= 60;
-
-	if (abs(real_minutes - chip_minutes) < 30) {
-		BIN_TO_BCD(real_seconds);
-		BIN_TO_BCD(real_minutes);
-		writeb(real_seconds, bregs + 0x00);
-		writeb(real_minutes, bregs + 0x02);
-	} else {
-		printk(KERN_WARNING
-		       "set_rtc_mmss: can't update from %d to %d\n",
-		       chip_minutes, real_minutes);
-		retval = -1;
-	}
-
-	writeb(val, bregs + 0x0e);
-
-	spin_unlock_irqrestore(&rtc_lock, flags);
-
-	return retval;
-}
-
 #define RTC_IS_OPEN		0x01	/* means /dev/rtc is in use	*/
 static unsigned char mini_rtc_status;	/* bitmapped status byte.	*/
 
@@ -1155,78 +1055,6 @@ static int hypervisor_set_rtc_time(struct rtc_time *time)
 	return hypervisor_set_time(seconds);
 }
 
-static void bq4802_get_rtc_time(struct rtc_time *time)
-{
-	unsigned char val = readb(bq4802_regs + 0x0e);
-	unsigned int century;
-
-	writeb(val | 0x08, bq4802_regs + 0x0e);
-
-	time->tm_sec = readb(bq4802_regs + 0x00);
-	time->tm_min = readb(bq4802_regs + 0x02);
-	time->tm_hour = readb(bq4802_regs + 0x04);
-	time->tm_mday = readb(bq4802_regs + 0x06);
-	time->tm_mon = readb(bq4802_regs + 0x09);
-	time->tm_year = readb(bq4802_regs + 0x0a);
-	time->tm_wday = readb(bq4802_regs + 0x08);
-	century = readb(bq4802_regs + 0x0f);
-
-	writeb(val, bq4802_regs + 0x0e);
-
-	BCD_TO_BIN(time->tm_sec);
-	BCD_TO_BIN(time->tm_min);
-	BCD_TO_BIN(time->tm_hour);
-	BCD_TO_BIN(time->tm_mday);
-	BCD_TO_BIN(time->tm_mon);
-	BCD_TO_BIN(time->tm_year);
-	BCD_TO_BIN(time->tm_wday);
-	BCD_TO_BIN(century);
-
-	time->tm_year += (century * 100);
-	time->tm_year -= 1900;
-
-	time->tm_mon--;
-}
-
-static int bq4802_set_rtc_time(struct rtc_time *time)
-{
-	unsigned char val = readb(bq4802_regs + 0x0e);
-	unsigned char sec, min, hrs, day, mon, yrs, century;
-	unsigned int year;
-
-	year = time->tm_year + 1900;
-	century = year / 100;
-	yrs = year % 100;
-
-	mon = time->tm_mon + 1;   /* tm_mon starts at zero */
-	day = time->tm_mday;
-	hrs = time->tm_hour;
-	min = time->tm_min;
-	sec = time->tm_sec;
-
-	BIN_TO_BCD(sec);
-	BIN_TO_BCD(min);
-	BIN_TO_BCD(hrs);
-	BIN_TO_BCD(day);
-	BIN_TO_BCD(mon);
-	BIN_TO_BCD(yrs);
-	BIN_TO_BCD(century);
-
-	writeb(val | 0x08, bq4802_regs + 0x0e);
-
-	writeb(sec, bq4802_regs + 0x00);
-	writeb(min, bq4802_regs + 0x02);
-	writeb(hrs, bq4802_regs + 0x04);
-	writeb(day, bq4802_regs + 0x06);
-	writeb(mon, bq4802_regs + 0x09);
-	writeb(yrs, bq4802_regs + 0x0a);
-	writeb(century, bq4802_regs + 0x0f);
-
-	writeb(val, bq4802_regs + 0x0e);
-
-	return 0;
-}
-
 struct mini_rtc_ops {
 	void (*get_rtc_time)(struct rtc_time *);
 	int (*set_rtc_time)(struct rtc_time *);
@@ -1242,11 +1070,6 @@ static struct mini_rtc_ops hypervisor_rtc_ops = {
 	.set_rtc_time = hypervisor_set_rtc_time,
 };
 
-static struct mini_rtc_ops bq4802_rtc_ops = {
-	.get_rtc_time = bq4802_get_rtc_time,
-	.set_rtc_time = bq4802_set_rtc_time,
-};
-
 static struct mini_rtc_ops *mini_rtc_ops;
 
 static inline void mini_get_rtc_time(struct rtc_time *time)
@@ -1373,8 +1196,6 @@ static int __init rtc_mini_init(void)
 		mini_rtc_ops = &hypervisor_rtc_ops;
 	else if (this_is_starfire)
 		mini_rtc_ops = &starfire_rtc_ops;
-	else if (bq4802_regs)
-		mini_rtc_ops = &bq4802_rtc_ops;
 	else
 		return -ENODEV;
 
-- 
1.5.6.5.GIT

