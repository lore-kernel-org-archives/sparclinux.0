From: David Miller <davem@davemloft.net>
Date: Fri, 29 Aug 2008 06:09:43 +0000
Subject: [PATCH 9/12]: rtc: Add Sun4V hypervisor RTC driver.
Message-Id: <20080828.230943.37124120.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


rtc: Add Sun4V hypervisor RTC driver.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/rtc/Kconfig     |    7 ++
 drivers/rtc/Makefile    |    1 +
 drivers/rtc/rtc-sun4v.c |  163 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 171 insertions(+), 0 deletions(-)
 create mode 100644 drivers/rtc/rtc-sun4v.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 5d600ff..23403fa 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -592,4 +592,11 @@ config RTC_DRV_PPC
 	 the RTC. This exposes that functionality through the generic RTC
 	 class.
 
+config RTC_DRV_SUN4V
+	bool "SUN4V Hypervisor RTC"
+	depends on SPARC64
+	help
+	  If you say Y here you will get support for the Hypervisor
+	  based RTC on SUN4V systems.
+
 endif # RTC_CLASS
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index fed42c2..6850b04 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_RTC_DRV_M41T94)	+= rtc-m41t94.o
 obj-$(CONFIG_RTC_DRV_M48T59)	+= rtc-m48t59.o
 obj-$(CONFIG_RTC_DRV_M48T86)	+= rtc-m48t86.o
 obj-$(CONFIG_RTC_DRV_BQ4802)	+= rtc-bq4802.o
+obj-$(CONFIG_RTC_DRV_SUN4V)	+= rtc-sun4v.o
 obj-$(CONFIG_RTC_DRV_MAX6900)	+= rtc-max6900.o
 obj-$(CONFIG_RTC_DRV_MAX6902)	+= rtc-max6902.o
 obj-$(CONFIG_RTC_DRV_OMAP)	+= rtc-omap.o
diff --git a/drivers/rtc/rtc-sun4v.c b/drivers/rtc/rtc-sun4v.c
new file mode 100644
index 0000000..3877bd4
--- /dev/null
+++ b/drivers/rtc/rtc-sun4v.c
@@ -0,0 +1,163 @@
+/* rtc-sun4c.c: Hypervisor based RTC for SUN4V systems.
+ *
+ * Copyright (C) 2008 David S. Miller <davem@davemloft.net>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/time.h>
+#include <linux/rtc.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+
+#include <asm/hypervisor.h>
+
+MODULE_AUTHOR("David S. Miller <davem@davemloft.net>");
+MODULE_DESCRIPTION("SUN4V RTC driver");
+MODULE_LICENSE("GPL");
+
+struct sun4v_rtc {
+	struct rtc_device	*rtc;
+	spinlock_t		lock;
+};
+
+static unsigned long hypervisor_get_time(void)
+{
+	unsigned long ret, time;
+	int retries = 10000;
+
+retry:
+	ret = sun4v_tod_get(&time);
+	if (ret = HV_EOK)
+		return time;
+	if (ret = HV_EWOULDBLOCK) {
+		if (--retries > 0) {
+			udelay(100);
+			goto retry;
+		}
+		printk(KERN_WARNING "SUN4V: tod_get() timed out.\n");
+		return 0;
+	}
+	printk(KERN_WARNING "SUN4V: tod_get() not supported.\n");
+	return 0;
+}
+
+static int sun4v_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct sun4v_rtc *p = dev_get_drvdata(dev);
+	unsigned long flags, secs;
+
+	spin_lock_irqsave(&p->lock, flags);
+	secs = hypervisor_get_time();
+	spin_unlock_irqrestore(&p->lock, flags);
+
+	rtc_time_to_tm(secs, tm);
+
+	return 0;
+}
+
+static int hypervisor_set_time(unsigned long secs)
+{
+	unsigned long ret;
+	int retries = 10000;
+
+retry:
+	ret = sun4v_tod_set(secs);
+	if (ret = HV_EOK)
+		return 0;
+	if (ret = HV_EWOULDBLOCK) {
+		if (--retries > 0) {
+			udelay(100);
+			goto retry;
+		}
+		printk(KERN_WARNING "SUN4V: tod_set() timed out.\n");
+		return -EAGAIN;
+	}
+	printk(KERN_WARNING "SUN4V: tod_set() not supported.\n");
+	return -EOPNOTSUPP;
+}
+
+static int sun4v_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct sun4v_rtc *p = dev_get_drvdata(dev);
+	unsigned long flags, secs;
+	int err;
+
+	err = rtc_tm_to_time(tm, &secs);
+	if (err)
+		return err;
+
+	spin_lock_irqsave(&p->lock, flags);
+	err = hypervisor_set_time(secs);
+	spin_unlock_irqrestore(&p->lock, flags);
+
+	return err;
+}
+
+static const struct rtc_class_ops sun4v_rtc_ops = {
+	.read_time	= sun4v_read_time,
+	.set_time	= sun4v_set_time,
+};
+
+
+static int __devinit sun4v_rtc_probe(struct of_device *op,
+				     const struct of_device_id *match)
+{
+	struct sun4v_rtc *p = kzalloc(sizeof(*p), GFP_KERNEL);
+
+	if (!p)
+		return -ENOMEM;
+
+	spin_lock_init(&p->lock);
+
+	p->rtc = rtc_device_register("sun4v", &op->dev,
+				     &sun4v_rtc_ops, THIS_MODULE);
+	if (IS_ERR(p->rtc)) {
+		int err = PTR_ERR(p->rtc);
+		kfree(p);
+		return err;
+	}
+	dev_set_drvdata(&op->dev, p);
+	return 0;
+}
+
+static int __devexit sun4v_rtc_remove(struct of_device *op)
+{
+	struct sun4v_rtc *p = dev_get_drvdata(&op->dev);
+
+	rtc_device_unregister(p->rtc);
+	kfree(p);
+
+	return 0;
+}
+
+static struct of_device_id sun4v_rtc_match[] = {
+	{
+		.name = "rtc",
+		.compatible = "SUNW,sun4v-tod",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, sun4v_rtc_match);
+
+static struct of_platform_driver sun4v_rtc_driver = {
+	.name		= "rtc-sun4v",
+	.match_table	= sun4v_rtc_match,
+	.probe		= sun4v_rtc_probe,
+	.remove		= __devexit_p(sun4v_rtc_remove),
+};
+
+static int __init sun4v_rtc_init(void)
+{
+	return of_register_driver(&sun4v_rtc_driver, &of_bus_type);
+}
+
+static void __exit sun4v_rtc_exit(void)
+{
+	of_unregister_driver(&sun4v_rtc_driver);
+}
+
+module_init(sun4v_rtc_init);
+module_exit(sun4v_rtc_exit);
-- 
1.5.6.5.GIT

