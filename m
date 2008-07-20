From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Date: Sun, 20 Jul 2008 18:51:00 +0000
Subject: Conversion of rtc code to rtc class devices
Message-Id: <20080720205100.7831ce9e.krzysztof.h1@poczta.fm>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

I tried to convert the rtc code for the sparc64 to the rtc class drivers.
I did a small step: I created a platform driver for mstk48t59 which is
supported by rtc-m48t59 driver. I tested it on U60 and it seems working:
The rtc0 device was created plus additional platform device which exposes
nvram content (sysfs platform and rtc class devices).

As the second step I disabled the mstk48t59 driver from the minirtc driver
by returning -ENODEV from the rtc_mini_init() for this chip. The system
booted and correctly set up the date (the rtc-m48t59) but the hwclock
stopped to work (no old /dev/rtc device available).

The patch is attached below. I am eager to convert more rtc devices to
the rtc class drivers (for sure pc-cmos and ds12887 drivers are available).

Helper functions for reading and writing byte look complicated because
the rtc in Sparc expects date to be moved by 68 years (the year 0 means
1968) but rtc drivers do not do any date conversions.

Is this good direction of changes? What can be broken by my patch?

Regards,
Krzysztof
PS. The patch does not disable the old minirtc driver so two rtc drivers
coexist as the rtc class drivers allows more than one rtc in the system.

diff -urp linux-2.6.26.orig/arch/sparc64/kernel/time.c linux-2.6.26/arch/sparc64/kernel/time.c
--- linux-2.6.26.orig/arch/sparc64/kernel/time.c	2008-07-20 20:35:42.888274015 +0200
+++ linux-2.6.26/arch/sparc64/kernel/time.c	2008-07-20 20:33:53.712262272 +0200
@@ -30,9 +30,11 @@
 #include <linux/percpu.h>
 #include <linux/miscdevice.h>
 #include <linux/rtc.h>
+#include <linux/rtc/m48t59.h>
 #include <linux/kernel_stat.h>
 #include <linux/clockchips.h>
 #include <linux/clocksource.h>
+#include <linux/platform_device.h>
 
 #include <asm/oplib.h>
 #include <asm/mostek.h>
@@ -408,6 +410,52 @@ int update_persistent_clock(struct times
 	return set_rtc_mmss(now.tv_sec);
 }
 
+static unsigned char mostek_read_byte(struct device *dev, u32 ofs)
+{
+	void __iomem *regs = mstk48t59_regs;
+	unsigned char val = mostek_read(regs + ofs);
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
+	void __iomem *regs = mstk48t59_regs;
+
+	if (ofs = M48T59_YEAR) {
+		val -= 0x68;
+		if ((val & 0xf) > 9)
+			val += 6;
+		if ((val & 0xf0) > 0x9A)
+			val += 0x60;
+	}
+	mostek_write(regs + ofs, val);
+}
+
+static struct m48t59_plat_data m48t59_ops = {
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
+		.platform_data = &m48t59_ops,
+	},
+};
+
 /* Kick start a stopped clock (procedure from the Sun NVRAM/hostid FAQ). */
 static void __init kick_start_clock(void)
 {
@@ -743,6 +791,9 @@ static int __devinit clock_probe(struct 
 	} else {
 		mstk48t59_regs = regs;
 		mstk48t02_regs = mstk48t59_regs + MOSTEK_48T59_48T02;
+		m48t59_rtc.resource[0] = op->resource[0];
+		if (platform_device_register(&m48t59_rtc) < 0)
+			printk(KERN_ERR "Registering RTC device failed\n");
 	}
 
 	printk(KERN_INFO "%s: Clock regs at %p\n", dp->full_name, regs);

----------------------------------------------------------------------
Galeria absurdow.
zobacz >>> http://link.interia.pl/f1e5e

