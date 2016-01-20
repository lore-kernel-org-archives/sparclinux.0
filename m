From: wim.coekaerts@oracle.com
Date: Wed, 20 Jan 2016 20:30:44 +0000
Subject: [PATCH] watchdog: add sun4v_wdt device support
Message-Id: <1453321844-27615-1-git-send-email-wim.coekaerts@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1452640232-1165-1-git-send-email-wim.coekaerts@oracle.com>
In-Reply-To: <1452640232-1165-1-git-send-email-wim.coekaerts@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: wim@iguana.be
Cc: linux-watchdog@vger.kernel.org, sparclinux@vger.kernel.org

From: Wim Coekaerts <wim.coekaerts@oracle.com>

This adds a simple watchdog timer for the SPARC sunv4 architecture.
Export the sun4v_mach_set_watchdog() hv call, and add the target.

The driver is implemented using the new watchdog api framework.

Signed-off-by: Wim Coekaerts <wim.coekaerts@oracle.com>
---
 Documentation/watchdog/watchdog-parameters.txt |    5 +
 arch/sparc/kernel/sparc_ksyms_64.c             |    1 +
 drivers/watchdog/Kconfig                       |    9 +
 drivers/watchdog/Makefile                      |    1 +
 drivers/watchdog/sun4v_wdt.c                   |  323 ++++++++++++++++++++++++
 5 files changed, 339 insertions(+), 0 deletions(-)
 create mode 100644 drivers/watchdog/sun4v_wdt.c

diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation/watchdog/watchdog-parameters.txt
index 9f9ec9f..de92c95 100644
--- a/Documentation/watchdog/watchdog-parameters.txt
+++ b/Documentation/watchdog/watchdog-parameters.txt
@@ -400,3 +400,8 @@ wm8350_wdt:
 nowayout: Watchdog cannot be stopped once started
 	(default=kernel config parameter)
 -------------------------------------------------
+sun4v_wdt:
+timeout: Watchdog timeout in seconds (1..31536000, default`)
+nowayout: Watchdog cannot be stopped once started
+-------------------------------------------------
+
diff --git a/arch/sparc/kernel/sparc_ksyms_64.c b/arch/sparc/kernel/sparc_ksyms_64.c
index a92d5d2..9e034f2 100644
--- a/arch/sparc/kernel/sparc_ksyms_64.c
+++ b/arch/sparc/kernel/sparc_ksyms_64.c
@@ -37,6 +37,7 @@ EXPORT_SYMBOL(sun4v_niagara_getperf);
 EXPORT_SYMBOL(sun4v_niagara_setperf);
 EXPORT_SYMBOL(sun4v_niagara2_getperf);
 EXPORT_SYMBOL(sun4v_niagara2_setperf);
+EXPORT_SYMBOL(sun4v_mach_set_watchdog);
 
 /* from hweight.S */
 EXPORT_SYMBOL(__arch_hweight8);
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 1c427be..441925b 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1500,6 +1500,15 @@ config WATCHDOG_RIO
 	  machines.  The watchdog timeout period is normally one minute but
 	  can be changed with a boot-time parameter.
 
+config WATCHDOG_SUN4V
+	tristate "sun4v Watchdog support"
+	select WATCHDOG_CORE
+	depends on SPARC64
+	help
+	  Say Y/M here to support the hypervisor watchdog capability provided
+	  by Oracle VM for SPARC.  The watchdog timeout period is normally one
+	  minute but can be changed with a boot-time parameter.
+
 # XTENSA Architecture
 
 # Xen Architecture
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 53d4827..9b8acb8 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -175,6 +175,7 @@ obj-$(CONFIG_SH_WDT) += shwdt.o
 
 obj-$(CONFIG_WATCHDOG_RIO)		+= riowd.o
 obj-$(CONFIG_WATCHDOG_CP1XXX)		+= cpwd.o
+obj-$(CONFIG_WATCHDOG_SUN4V)		+= sun4v_wdt.o
 
 # XTENSA Architecture
 
diff --git a/drivers/watchdog/sun4v_wdt.c b/drivers/watchdog/sun4v_wdt.c
new file mode 100644
index 0000000..8d4a62a
--- /dev/null
+++ b/drivers/watchdog/sun4v_wdt.c
@@ -0,0 +1,323 @@
+/*
+ *	sun4v watchdog timer
+ *	(c) Copyright 2016 Oracle Corporation
+ *
+ *	Implement a simple watchdog driver using the sun4v hypervisor
+ *	watchdog support. If time expires, the hypervisor stops or bounces
+ *	the guest domain.
+ *
+ *	sun4v_mach_set_watchdog() expects time in ms
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#define DRV_NAME	"sun4v_wdt"
+#define DRV_VERSION	"0.1"
+
+#include <linux/bug.h>
+#include <linux/errno.h>
+#include <linux/hrtimer.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/ktime.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+#include <linux/watchdog.h>
+#include <asm/hypervisor.h>
+#include <asm/mdesc.h>
+
+#define WATCHDOG_TIMEOUT 60		/* in seconds */
+#define WDT_MAX_TIMEOUT	31536000	/* in seconds */
+#define WDT_MIN_TIMEOUT 1		/* in seconds */
+
+static struct platform_device *platform_device;
+
+struct sun4v_wdt {
+	spinlock_t	lock;
+	__kernel_time_t	expires;
+	struct watchdog_device	wdd;
+};
+
+static unsigned int max_timeout = WDT_MAX_TIMEOUT;
+static unsigned int timeout = WATCHDOG_TIMEOUT;
+module_param(timeout, uint, S_IRUGO);
+MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds "
+	"(default=" __MODULE_STRING(WATCHDOG_TIMEOUT) ")");
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, S_IRUGO);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
+	"(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+static int sun4v_wdt_start(struct watchdog_device *wdd)
+{
+	struct sun4v_wdt *wdt = watchdog_get_drvdata(wdd);
+	unsigned long time_remaining;
+	int err;
+
+	spin_lock(&wdt->lock);
+
+	wdt->expires = ktime_to_timespec(ktime_get()).tv_sec + wdd->timeout;
+	err = sun4v_mach_set_watchdog(wdd->timeout * 1000, &time_remaining);
+
+	spin_unlock(&wdt->lock);
+
+	pr_info("timer enabled\n");
+	return err;
+}
+
+static int sun4v_wdt_stop(struct watchdog_device *wdd)
+{
+	struct sun4v_wdt *wdt = watchdog_get_drvdata(wdd);
+	unsigned long time_remaining;
+	int err;
+
+	spin_lock(&wdt->lock);
+
+	err = sun4v_mach_set_watchdog(0, &time_remaining);
+
+	spin_unlock(&wdt->lock);
+
+	pr_info("timer disabled\n");
+	return err;
+}
+
+static int sun4v_wdt_ping(struct watchdog_device *wdd)
+{
+	struct sun4v_wdt *wdt = watchdog_get_drvdata(wdd);
+	int err;
+	unsigned long time_remaining;
+
+	spin_lock(&wdt->lock);
+
+	wdt->expires = ktime_to_timespec(ktime_get()).tv_sec + wdd->timeout;
+	err = sun4v_mach_set_watchdog(wdd->timeout * 1000, &time_remaining);
+
+	spin_unlock(&wdt->lock);
+
+	return err;
+}
+
+static int sun4v_wdt_set_timeout(struct watchdog_device *wdd,
+				 unsigned int timeout)
+{
+	wdd->timeout = timeout;
+
+	if (watchdog_active(wdd)) {
+		(void) sun4v_wdt_stop(wdd);
+		return sun4v_wdt_start(wdd);
+	}
+
+	return 0;
+}
+
+static unsigned int sun4v_wdt_get_timeleft(struct watchdog_device *wdd)
+{
+	struct sun4v_wdt *wdt = watchdog_get_drvdata(wdd);
+
+	return wdt->expires - ktime_to_timespec(ktime_get()).tv_sec;
+}
+
+static const struct watchdog_info sun4v_wdt_ident = {
+	.options =	WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
+	.identity =	"sun4v watchdog",
+	.firmware_version = 0,
+};
+
+static struct watchdog_ops sun4v_wdt_ops = {
+	.owner =	THIS_MODULE,
+	.start =	sun4v_wdt_start,
+	.stop =		sun4v_wdt_stop,
+	.ping =		sun4v_wdt_ping,
+	.set_timeout =	sun4v_wdt_set_timeout,
+	.get_timeleft =	sun4v_wdt_get_timeleft,
+};
+
+static int sun4v_wdt_probe(struct platform_device *pdev)
+{
+	struct watchdog_device *wdd;
+	struct sun4v_wdt *wdt;
+	unsigned long time_remaining;
+	int ret = 0;
+
+	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
+	if (!wdt)
+		return -ENOMEM;
+
+	wdd = &wdt->wdd;
+	wdd->info = &sun4v_wdt_ident;
+	wdd->ops = &sun4v_wdt_ops;
+	wdd->min_timeout = WDT_MIN_TIMEOUT;
+	wdd->max_timeout = max_timeout;
+	wdd->timeout = timeout;
+	wdd->parent = &pdev->dev;
+
+	watchdog_set_drvdata(wdd, wdt);
+
+	spin_lock_init(&wdt->lock);
+
+	ret = sun4v_mach_set_watchdog(wdd->timeout, &time_remaining);
+	(void) sun4v_mach_set_watchdog(0, &time_remaining);
+	if (ret != HV_EOK) {
+		pr_info("Error setting timer\n");
+		ret = -ENODEV;
+		goto out;
+	}
+
+	watchdog_set_nowayout(wdd, nowayout);
+
+	ret = watchdog_register_device(wdd);
+	if (ret) {
+		pr_err("Failed to register watchdog device (%d)\n", ret);
+		goto out;
+	}
+
+	platform_set_drvdata(pdev, wdt);
+
+	pr_info("initialized (timeout=%ds, nowayout=%d)\n",
+		wdd->timeout, nowayout);
+out:
+	return ret;
+}
+
+static int sun4v_wdt_remove(struct platform_device *pdev)
+{
+	struct sun4v_wdt *wdt = platform_get_drvdata(pdev);
+
+	(void) sun4v_wdt_stop(&wdt->wdd);
+
+	watchdog_unregister_device(&wdt->wdd);
+
+	return 0;
+}
+
+static void sun4v_wdt_shutdown(struct platform_device *pdev)
+{
+	struct sun4v_wdt *wdt = platform_get_drvdata(pdev);
+
+	(void) sun4v_wdt_stop(&wdt->wdd);
+}
+
+static int sun4v_wdt_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct sun4v_wdt *wdt = platform_get_drvdata(pdev);
+
+	return sun4v_wdt_stop(&wdt->wdd);
+}
+
+static int sun4v_wdt_resume(struct platform_device *pdev)
+{
+	struct sun4v_wdt *wdt = platform_get_drvdata(pdev);
+
+	return sun4v_wdt_start(&wdt->wdd);
+}
+
+static struct platform_driver sun4v_wdt_driver = {
+	.probe          = sun4v_wdt_probe,
+	.remove         = sun4v_wdt_remove,
+	.shutdown       = sun4v_wdt_shutdown,
+	.suspend        = sun4v_wdt_suspend,
+	.resume         = sun4v_wdt_resume,
+	.driver         = {
+		.name   = DRV_NAME,
+	},
+};
+
+static int __init sun4v_wdt_init_module(void)
+{
+	int err;
+	struct mdesc_handle *handle;
+	u64 node;
+	const u64 *value;
+	u64 resolution;
+
+	/*
+	 * There are 2 properties that can be set from the control
+	 * domain for the watchdog.
+	 * watchdog-resolution (in ms defaulting to 1000)
+	 * watchdog-max-timeout (in ms)
+	 * Right now, only support the default 1s (1000ms) resolution
+	 * so just verify against the property, and make sure
+	 * max timeout is taken into account, if set.
+	 */
+	handle = mdesc_grab();
+	if (!handle)
+		return -ENODEV;
+
+	node = mdesc_node_by_name(handle, MDESC_NODE_NULL, "platform");
+	if (node = MDESC_NODE_NULL) {
+		pr_info("No platform node\n");
+		err = -ENODEV;
+		goto out;
+	}
+
+	value = mdesc_get_property(handle, node, "watchdog-resolution", NULL);
+	if (value) {
+		resolution = *value;
+		pr_info("Platform watchdog-resolution [%llux]\n", *value);
+
+		if (resolution != 1000) {
+			pr_crit("Only 1000ms is supported.\n");
+			err = -EINVAL;
+			goto out;
+		}
+	}
+
+	value = mdesc_get_property(handle, node, "watchdog-max-timeout", NULL);
+	if (value) {
+		/* convert ms to seconds */
+		max_timeout = *value / 1000;
+		pr_info("Platform watchdog-max-timeout [%ds]\n", max_timeout);
+
+		if (max_timeout < WDT_MIN_TIMEOUT) {
+			max_timeout = WDT_MIN_TIMEOUT;
+			pr_info("Setting max timeout to [%ds]\n", max_timeout);
+		}
+
+		if (max_timeout > WDT_MAX_TIMEOUT) {
+			max_timeout = WDT_MAX_TIMEOUT;
+			pr_info("Setting max timeout to [%ds]\n", max_timeout);
+		}
+	}
+
+	pr_info("sun4v watchdog timer v%s\n", DRV_VERSION);
+
+	err = platform_driver_register(&sun4v_wdt_driver);
+	if (err)
+		return err;
+
+	platform_device = platform_device_register_simple(DRV_NAME,
+								  -1, NULL, 0);
+	if (IS_ERR(platform_device)) {
+		err = PTR_ERR(platform_device);
+		platform_driver_unregister(&sun4v_wdt_driver);
+	}
+
+out:
+	if (handle)
+		mdesc_release(handle);
+
+	return err;
+}
+
+static void __exit sun4v_wdt_cleanup_module(void)
+{
+	platform_device_unregister(platform_device);
+	platform_driver_unregister(&sun4v_wdt_driver);
+	pr_info("module unloaded\n");
+}
+
+module_init(sun4v_wdt_init_module);
+module_exit(sun4v_wdt_cleanup_module);
+
+MODULE_AUTHOR("Wim Coekaerts <wim.coekaerts@oracle.com>");
+MODULE_DESCRIPTION("sun4v watchdog timer");
+MODULE_VERSION(DRV_VERSION);
+MODULE_LICENSE("GPL");
-- 
1.7.1

