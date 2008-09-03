From: akpm@linux-foundation.org
Date: Wed, 03 Sep 2008 21:54:44 +0000
Subject: [patch 2/2] rtc-m48t59: add support for M48T02 and M48T59 chips
Message-Id: <200809032154.m83Lsivb005968@imap1.linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Add support for two compatible RTC:
- M48T08 which does not have alarm part,
- M48T08 which does not have alarm part and has
  only 2KB of NVRAM

These types covers all Mostek's RTC used in Sun UltraSparc workstations.

Tested on Sun Ultra60 with M48T59 RTC.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Cc: Mark Zhan <rongkai.zhan@windriver.com>
Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>
Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/rtc/Kconfig        |    7 +++--
 drivers/rtc/rtc-m48t59.c   |   47 +++++++++++++++++++++++++++++------
 include/linux/rtc/m48t59.h |   45 ++++++++++++++++++---------------
 3 files changed, 69 insertions(+), 30 deletions(-)

diff -puN drivers/rtc/Kconfig~rtc-m48t59-add-support-for-m48t02-and-m48t59-chips-2nd-rev drivers/rtc/Kconfig
--- a/drivers/rtc/Kconfig~rtc-m48t59-add-support-for-m48t02-and-m48t59-chips-2nd-rev
+++ a/drivers/rtc/Kconfig
@@ -415,10 +415,13 @@ config RTC_DRV_M48T86
 	  will be called rtc-m48t86.
 
 config RTC_DRV_M48T59
-	tristate "ST M48T59"
+	tristate "ST M48T59/M48T08/M48T02"
 	help
 	  If you say Y here you will get support for the
-	  ST M48T59 RTC chip.
+	  ST M48T59 RTC chip and compatible ST M48T08 and M48T02.
+
+	  These chips are usually found in Sun SPARC and UltraSPARC
+	  workstations.
 
 	  This driver can also be built as a module, if so, the module
 	  will be called "rtc-m48t59".
diff -puN drivers/rtc/rtc-m48t59.c~rtc-m48t59-add-support-for-m48t02-and-m48t59-chips-2nd-rev drivers/rtc/rtc-m48t59.c
--- a/drivers/rtc/rtc-m48t59.c~rtc-m48t59-add-support-for-m48t02-and-m48t59-chips-2nd-rev
+++ a/drivers/rtc/rtc-m48t59.c
@@ -24,8 +24,9 @@
 #define NO_IRQ	(-1)
 #endif
 
-#define M48T59_READ(reg)	pdata->read_byte(dev, reg)
-#define M48T59_WRITE(val, reg)	pdata->write_byte(dev, reg, val)
+#define M48T59_READ(reg) (pdata->read_byte(dev, pdata->offset + reg))
+#define M48T59_WRITE(val, reg) \
+	(pdata->write_byte(dev, pdata->offset + reg, val))
 
 #define M48T59_SET_BITS(mask, reg)	\
 	M48T59_WRITE((M48T59_READ(reg) | (mask)), (reg))
@@ -309,6 +310,11 @@ static const struct rtc_class_ops m48t59
 	.proc		= m48t59_rtc_proc,
 };
 
+static const struct rtc_class_ops m48t02_rtc_ops = {
+	.read_time	= m48t59_rtc_read_time,
+	.set_time	= m48t59_rtc_set_time,
+};
+
 static ssize_t m48t59_nvram_read(struct kobject *kobj,
 				struct bin_attribute *bin_attr,
 				char *buf, loff_t pos, size_t size)
@@ -320,7 +326,7 @@ static ssize_t m48t59_nvram_read(struct 
 	ssize_t cnt = 0;
 	unsigned long flags;
 
-	for (; size > 0 && pos < M48T59_NVRAM_SIZE; cnt++, size--) {
+	for (; size > 0 && pos < pdata->offset; cnt++, size--) {
 		spin_lock_irqsave(&m48t59->lock, flags);
 		*buf++ = M48T59_READ(cnt);
 		spin_unlock_irqrestore(&m48t59->lock, flags);
@@ -340,7 +346,7 @@ static ssize_t m48t59_nvram_write(struct
 	ssize_t cnt = 0;
 	unsigned long flags;
 
-	for (; size > 0 && pos < M48T59_NVRAM_SIZE; cnt++, size--) {
+	for (; size > 0 && pos < pdata->offset; cnt++, size--) {
 		spin_lock_irqsave(&m48t59->lock, flags);
 		M48T59_WRITE(*buf++, cnt);
 		spin_unlock_irqrestore(&m48t59->lock, flags);
@@ -357,7 +363,6 @@ static struct bin_attribute m48t59_nvram
 	},
 	.read = m48t59_nvram_read,
 	.write = m48t59_nvram_write,
-	.size = M48T59_NVRAM_SIZE,
 };
 
 static int __devinit m48t59_rtc_probe(struct platform_device *pdev)
@@ -366,6 +371,8 @@ static int __devinit m48t59_rtc_probe(st
 	struct m48t59_private *m48t59 = NULL;
 	struct resource *res;
 	int ret = -ENOMEM;
+	char *name;
+	const struct rtc_class_ops *ops;
 
 	/* This chip could be memory-mapped or I/O-mapped */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -390,6 +397,8 @@ static int __devinit m48t59_rtc_probe(st
 			/* Ensure we only kmalloc platform data once */
 			pdev->dev.platform_data = pdata;
 		}
+		if (!pdata->type)
+			pdata->type = M48T59RTC_TYPE_M48T59;
 
 		/* Try to use the generic memory read/write ops */
 		if (!pdata->write_byte)
@@ -419,14 +428,36 @@ static int __devinit m48t59_rtc_probe(st
 		if (ret)
 			goto out;
 	}
+	switch (pdata->type) {
+	case M48T59RTC_TYPE_M48T59:
+		name = "m48t59";
+		ops = &m48t59_rtc_ops;
+		pdata->offset = 0x1ff0;
+		break;
+	case M48T59RTC_TYPE_M48T02:
+		name = "m48t02";
+		ops = &m48t02_rtc_ops;
+		pdata->offset = 0x7f0;
+		break;
+	case M48T59RTC_TYPE_M48T08:
+		name = "m48t08";
+		ops = &m48t02_rtc_ops;
+		pdata->offset = 0x1ff0;
+		break;
+	default:
+		dev_err(&pdev->dev, "Unknown RTC type\n");
+		ret = -ENODEV;
+		goto out;
+	}
 
-	m48t59->rtc = rtc_device_register("m48t59", &pdev->dev,
-				&m48t59_rtc_ops, THIS_MODULE);
+	m48t59->rtc = rtc_device_register(name, &pdev->dev, ops, THIS_MODULE);
 	if (IS_ERR(m48t59->rtc)) {
 		ret = PTR_ERR(m48t59->rtc);
 		goto out;
 	}
 
+	m48t59_nvram_attr.size = pdata->offset;
+
 	ret = sysfs_create_bin_file(&pdev->dev.kobj, &m48t59_nvram_attr);
 	if (ret)
 		goto out;
@@ -489,5 +520,5 @@ module_init(m48t59_rtc_init);
 module_exit(m48t59_rtc_exit);
 
 MODULE_AUTHOR("Mark Zhan <rongkai.zhan@windriver.com>");
-MODULE_DESCRIPTION("M48T59 RTC driver");
+MODULE_DESCRIPTION("M48T59/M48T02/M48T08 RTC driver");
 MODULE_LICENSE("GPL");
diff -puN include/linux/rtc/m48t59.h~rtc-m48t59-add-support-for-m48t02-and-m48t59-chips-2nd-rev include/linux/rtc/m48t59.h
--- a/include/linux/rtc/m48t59.h~rtc-m48t59-add-support-for-m48t02-and-m48t59-chips-2nd-rev
+++ a/include/linux/rtc/m48t59.h
@@ -18,40 +18,45 @@
 /*
  * M48T59 Register Offset
  */
-#define M48T59_YEAR		0x1fff
-#define M48T59_MONTH		0x1ffe
-#define M48T59_MDAY		0x1ffd	/* Day of Month */
-#define M48T59_WDAY		0x1ffc	/* Day of Week */
+#define M48T59_YEAR		0xf
+#define M48T59_MONTH		0xe
+#define M48T59_MDAY		0xd	/* Day of Month */
+#define M48T59_WDAY		0xc	/* Day of Week */
 #define M48T59_WDAY_CB			0x20	/* Century Bit */
 #define M48T59_WDAY_CEB			0x10	/* Century Enable Bit */
-#define M48T59_HOUR		0x1ffb
-#define M48T59_MIN		0x1ffa
-#define M48T59_SEC		0x1ff9
-#define M48T59_CNTL		0x1ff8
+#define M48T59_HOUR		0xb
+#define M48T59_MIN		0xa
+#define M48T59_SEC		0x9
+#define M48T59_CNTL		0x8
 #define M48T59_CNTL_READ		0x40
 #define M48T59_CNTL_WRITE		0x80
-#define M48T59_WATCHDOG		0x1ff7
-#define M48T59_INTR		0x1ff6
+#define M48T59_WATCHDOG		0x7
+#define M48T59_INTR		0x6
 #define M48T59_INTR_AFE			0x80	/* Alarm Interrupt Enable */
 #define M48T59_INTR_ABE			0x20
-#define M48T59_ALARM_DATE	0x1ff5
-#define M48T59_ALARM_HOUR	0x1ff4
-#define M48T59_ALARM_MIN	0x1ff3
-#define M48T59_ALARM_SEC	0x1ff2
-#define M48T59_UNUSED		0x1ff1
-#define M48T59_FLAGS		0x1ff0
+#define M48T59_ALARM_DATE	0x5
+#define M48T59_ALARM_HOUR	0x4
+#define M48T59_ALARM_MIN	0x3
+#define M48T59_ALARM_SEC	0x2
+#define M48T59_UNUSED		0x1
+#define M48T59_FLAGS		0x0
 #define M48T59_FLAGS_WDT		0x80	/* watchdog timer expired */
 #define M48T59_FLAGS_AF			0x40	/* alarm */
 #define M48T59_FLAGS_BF			0x10	/* low battery */
 
-#define M48T59_NVRAM_SIZE	0x1ff0
+#define M48T59RTC_TYPE_M48T59	0 /* to keep compatibility */
+#define M48T59RTC_TYPE_M48T02	1
+#define M48T59RTC_TYPE_M48T08	2
 
 struct m48t59_plat_data {
-	/* The method to access M48T59 registers,
-	 * NOTE: The 'ofs' should be 0x00~0x1fff
-	 */
+	/* The method to access M48T59 registers */
 	void (*write_byte)(struct device *dev, u32 ofs, u8 val);
 	unsigned char (*read_byte)(struct device *dev, u32 ofs);
+
+	int type; /* RTC model */
+
+	/* offset to RTC registers, automatically set according to the type */
+	unsigned int offset;
 };
 
 #endif /* _LINUX_RTC_M48T59_H_ */
_
