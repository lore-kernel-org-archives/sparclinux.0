From: David Miller <davem@davemloft.net>
Date: Wed, 03 Sep 2008 22:52:56 +0000
Subject: Re: [PATCH 2/2] sparc32: use RTC subsystem
Message-Id: <20080903.155256.118978852.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080903183255.f7dc32d6.krzysztof.h1@wp.pl>
In-Reply-To: <20080903183255.f7dc32d6.krzysztof.h1@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Wed, 3 Sep 2008 18:32:55 +0200

> Use rtc subsystem for sparc32 architecture.
> Actually, only one driver is needed: m48t59
> as it supports the most common clocks on sparc32
> machines: m48t08 and m48t02.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

I wish you would have prepared this against sparc-next-2.6,
half of the patch rejected :-/  For example, everything
mentioning CONFIG_SUN4 has been deleted from the tree.

Anyways, I fixed it up and added proper code to set_rtc_mmss()
to call into the generic RTC layer, just as I did for sparc64.

I've pushed this into sparc-next-2.6, let's see what explodes :)

sparc32: use RTC subsystem

Use rtc subsystem for sparc32 architecture.
Actually, only one driver is needed: m48t59
as it supports the most common clocks on sparc32
machines: m48t08 and m48t02.

[ Add proper RTC layer calls to set_rtc_mmss() -DaveM ]

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/Kconfig              |    2 +
 arch/sparc/kernel/sparc_ksyms.c |    2 -
 arch/sparc/kernel/time.c        |  217 +++++++++++----------------------------
 3 files changed, 62 insertions(+), 159 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index a4c7fb7..97671da 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -75,6 +75,8 @@ config SPARC
 	select HAVE_ARCH_KGDB if !SMP
 	select HAVE_ARCH_TRACEHOOK
 	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select RTC_CLASS
+	select RTC_DRV_M48T59
 
 # Identify this as a Sparc32 build
 config SPARC32
diff --git a/arch/sparc/kernel/sparc_ksyms.c b/arch/sparc/kernel/sparc_ksyms.c
index 6007ac5..0ce002e 100644
--- a/arch/sparc/kernel/sparc_ksyms.c
+++ b/arch/sparc/kernel/sparc_ksyms.c
@@ -123,8 +123,6 @@ EXPORT_SYMBOL(phys_cpu_present_map);
 EXPORT_SYMBOL(__udelay);
 EXPORT_SYMBOL(__ndelay);
 EXPORT_SYMBOL(rtc_lock);
-EXPORT_SYMBOL(mostek_lock);
-EXPORT_SYMBOL(mstk48t02_regs);
 #ifdef CONFIG_SUN_AUXIO
 EXPORT_SYMBOL(set_auxio);
 EXPORT_SYMBOL(get_auxio);
diff --git a/arch/sparc/kernel/time.c b/arch/sparc/kernel/time.c
index f0a2874..698c450 100644
--- a/arch/sparc/kernel/time.c
+++ b/arch/sparc/kernel/time.c
@@ -23,6 +23,8 @@
 #include <linux/mm.h>
 #include <linux/interrupt.h>
 #include <linux/time.h>
+#include <linux/rtc.h>
+#include <linux/rtc/m48t59.h>
 #include <linux/timex.h>
 #include <linux/init.h>
 #include <linux/pci.h>
@@ -30,10 +32,10 @@
 #include <linux/profile.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/platform_device.h>
 
 #include <asm/oplib.h>
 #include <asm/timer.h>
-#include <asm/mostek.h>
 #include <asm/system.h>
 #include <asm/irq.h>
 #include <asm/io.h>
@@ -46,10 +48,6 @@
 #include "irq.h"
 
 DEFINE_SPINLOCK(rtc_lock);
-static enum sparc_clock_type sp_clock_typ;
-DEFINE_SPINLOCK(mostek_lock);
-void __iomem *mstk48t02_regs = NULL;
-static struct mostek48t08 __iomem *mstk48t08_regs = NULL;
 static int set_rtc_mmss(unsigned long);
 static int sbus_do_settimeofday(struct timespec *tv);
 
@@ -118,107 +116,55 @@ static irqreturn_t timer_interrupt(int dummy, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-/* Kick start a stopped clock (procedure from the Sun NVRAM/hostid FAQ). */
-static void __devinit kick_start_clock(void)
+static unsigned char mostek_read_byte(struct device *dev, u32 ofs)
 {
-	struct mostek48t02 *regs = (struct mostek48t02 *)mstk48t02_regs;
-	unsigned char sec;
-	int i, count;
-
-	prom_printf("CLOCK: Clock was stopped. Kick start ");
-
-	spin_lock_irq(&mostek_lock);
-
-	/* Turn on the kick start bit to start the oscillator. */
-	regs->creg |= MSTK_CREG_WRITE;
-	regs->sec &= ~MSTK_STOP;
-	regs->hour |= MSTK_KICK_START;
-	regs->creg &= ~MSTK_CREG_WRITE;
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
-		sec = regs->sec;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct m48t59_plat_data *pdata = pdev->dev.platform_data;
+	void __iomem *regs = pdata->ioaddr;
+	unsigned char val = readb(regs + ofs);
+
+	/* the year 0 is 1968 */
+	if (ofs = pdata->offset + M48T59_YEAR) {
+		val += 0x68;
+		if ((val & 0xf) > 9)
+			val += 6;
 	}
-	prom_printf("\n");
-
-	spin_lock_irq(&mostek_lock);
-
-	/* Turn off kick start and set a "valid" time and date. */
-	regs->creg |= MSTK_CREG_WRITE;
-	regs->hour &= ~MSTK_KICK_START;
-	MSTK_SET_REG_SEC(regs,0);
-	MSTK_SET_REG_MIN(regs,0);
-	MSTK_SET_REG_HOUR(regs,0);
-	MSTK_SET_REG_DOW(regs,5);
-	MSTK_SET_REG_DOM(regs,1);
-	MSTK_SET_REG_MONTH(regs,8);
-	MSTK_SET_REG_YEAR(regs,1996 - MSTK_YEAR_ZERO);
-	regs->creg &= ~MSTK_CREG_WRITE;
-
-	spin_unlock_irq(&mostek_lock);
-
-	/* Ensure the kick start bit is off. If it isn't, turn it off. */
-	while (regs->hour & MSTK_KICK_START) {
-		prom_printf("CLOCK: Kick start still on!\n");
-
-		spin_lock_irq(&mostek_lock);
-		regs->creg |= MSTK_CREG_WRITE;
-		regs->hour &= ~MSTK_KICK_START;
-		regs->creg &= ~MSTK_CREG_WRITE;
-		spin_unlock_irq(&mostek_lock);
-	}
-
-	prom_printf("CLOCK: Kick start procedure successful.\n");
+	return val;
 }
 
-/* Return nonzero if the clock chip battery is low. */
-static inline int has_low_battery(void)
+static void mostek_write_byte(struct device *dev, u32 ofs, u8 val)
 {
-	struct mostek48t02 *regs = (struct mostek48t02 *)mstk48t02_regs;
-	unsigned char data1, data2;
-
-	spin_lock_irq(&mostek_lock);
-	data1 = regs->eeprom[0];	/* Read some data. */
-	regs->eeprom[0] = ~data1;	/* Write back the complement. */
-	data2 = regs->eeprom[0];	/* Read back the complement. */
-	regs->eeprom[0] = data1;	/* Restore the original value. */
-	spin_unlock_irq(&mostek_lock);
-
-	return (data1 = data2);	/* Was the write blocked? */
+	struct platform_device *pdev = to_platform_device(dev);
+	struct m48t59_plat_data *pdata = pdev->dev.platform_data;
+	void __iomem *regs = pdata->ioaddr;
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
+	writeb(val, regs + ofs);
 }
 
-static void __devinit mostek_set_system_time(void)
-{
-	unsigned int year, mon, day, hour, min, sec;
-	struct mostek48t02 *mregs;
-
-	mregs = (struct mostek48t02 *)mstk48t02_regs;
-	if(!mregs) {
-		prom_printf("Something wrong, clock regs not mapped yet.\n");
-		prom_halt();
-	}		
-	spin_lock_irq(&mostek_lock);
-	mregs->creg |= MSTK_CREG_READ;
-	sec = MSTK_REG_SEC(mregs);
-	min = MSTK_REG_MIN(mregs);
-	hour = MSTK_REG_HOUR(mregs);
-	day = MSTK_REG_DOM(mregs);
-	mon = MSTK_REG_MONTH(mregs);
-	year = MSTK_CVT_YEAR( MSTK_REG_YEAR(mregs) );
-	xtime.tv_sec = mktime(year, mon, day, hour, min, sec);
-	xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
-        set_normalized_timespec(&wall_to_monotonic,
-                                -xtime.tv_sec, -xtime.tv_nsec);
-	mregs->creg &= ~MSTK_CREG_READ;
-	spin_unlock_irq(&mostek_lock);
-}
+static struct m48t59_plat_data m48t59_data = {
+	.read_byte = mostek_read_byte,
+	.write_byte = mostek_write_byte,
+};
+
+/* resource is set at runtime */
+static struct platform_device m48t59_rtc = {
+	.name		= "rtc-m48t59",
+	.id		= 0,
+	.num_resources	= 1,
+	.dev	= {
+		.platform_data = &m48t59_data,
+	},
+};
 
 static int __devinit clock_probe(struct of_device *op, const struct of_device_id *match)
 {
@@ -228,33 +174,21 @@ static int __devinit clock_probe(struct of_device *op, const struct of_device_id
 	if (!model)
 		return -ENODEV;
 
+	m48t59_rtc.resource = &op->resource[0];
 	if (!strcmp(model, "mk48t02")) {
-		sp_clock_typ = MSTK48T02;
-
 		/* Map the clock register io area read-only */
-		mstk48t02_regs = of_ioremap(&op->resource[0], 0,
-					    sizeof(struct mostek48t02),
-					    "mk48t02");
-		mstk48t08_regs = NULL;  /* To catch weirdness */
+		m48t59_data.ioaddr = of_ioremap(&op->resource[0], 0,
+						2048, "rtc-m48t59");
+		m48t59_data.type = M48T59RTC_TYPE_M48T02;
 	} else if (!strcmp(model, "mk48t08")) {
-		sp_clock_typ = MSTK48T08;
-		mstk48t08_regs = of_ioremap(&op->resource[0], 0,
-					    sizeof(struct mostek48t08),
-					    "mk48t08");
-
-		mstk48t02_regs = &mstk48t08_regs->regs;
+		m48t59_data.ioaddr = of_ioremap(&op->resource[0], 0,
+						8192, "rtc-m48t59");
+		m48t59_data.type = M48T59RTC_TYPE_M48T08;
 	} else
 		return -ENODEV;
 
-	/* Report a low battery voltage condition. */
-	if (has_low_battery())
-		printk(KERN_CRIT "NVRAM: Low battery voltage!\n");
-
-	/* Kick start the clock if it is completely stopped. */
-	if (mostek_read(mstk48t02_regs + MOSTEK_SEC) & MSTK_STOP)
-		kick_start_clock();
-
-	mostek_set_system_time();
+	if (platform_device_register(&m48t59_rtc) < 0)
+		printk(KERN_ERR "Registering RTC device failed\n");
 
 	return 0;
 }
@@ -270,7 +204,7 @@ static struct of_platform_driver clock_driver = {
 	.match_table	= clock_match,
 	.probe		= clock_probe,
 	.driver		= {
-		.name	= "clock",
+		.name	= "rtc",
 	},
 };
 
@@ -400,43 +334,12 @@ static int sbus_do_settimeofday(struct timespec *tv)
 	return 0;
 }
 
-/*
- * BUG: This routine does not handle hour overflow properly; it just
- *      sets the minutes. Usually you won't notice until after reboot!
- */
-static int set_rtc_mmss(unsigned long nowtime)
+static int set_rtc_mmss(unsigned long secs)
 {
-	int real_seconds, real_minutes, mostek_minutes;
-	struct mostek48t02 *regs = (struct mostek48t02 *)mstk48t02_regs;
-	unsigned long flags;
+	struct rtc_device *rtc = rtc_class_open("rtc0");
 
-	spin_lock_irqsave(&mostek_lock, flags);
-	/* Read the current RTC minutes. */
-	regs->creg |= MSTK_CREG_READ;
-	mostek_minutes = MSTK_REG_MIN(regs);
-	regs->creg &= ~MSTK_CREG_READ;
+	if (rtc)
+		return rtc_set_mmss(rtc, secs);
 
-	/*
-	 * since we're only adjusting minutes and seconds,
-	 * don't interfere with hour overflow. This avoids
-	 * messing with unknown time zones but requires your
-	 * RTC not to be off by more than 15 minutes
-	 */
-	real_seconds = nowtime % 60;
-	real_minutes = nowtime / 60;
-	if (((abs(real_minutes - mostek_minutes) + 15)/30) & 1)
-		real_minutes += 30;	/* correct for half hour time zone */
-	real_minutes %= 60;
-
-	if (abs(real_minutes - mostek_minutes) < 30) {
-		regs->creg |= MSTK_CREG_WRITE;
-		MSTK_SET_REG_SEC(regs,real_seconds);
-		MSTK_SET_REG_MIN(regs,real_minutes);
-		regs->creg &= ~MSTK_CREG_WRITE;
-		spin_unlock_irqrestore(&mostek_lock, flags);
-		return 0;
-	} else {
-		spin_unlock_irqrestore(&mostek_lock, flags);
-		return -1;
-	}
+	return -1;
 }
-- 
1.5.6.5.GIT

