From: Wim Coekaerts <wim.coekaerts@oracle.com>
Date: Thu, 28 Jan 2016 01:54:07 +0000
Subject: [PATCH] Add sun4v_wdt watchdog driver
Message-Id: <1453946047-18003-2-git-send-email-wim.coekaerts@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1453946047-18003-1-git-send-email-wim.coekaerts@oracle.com>
In-Reply-To: <1453946047-18003-1-git-send-email-wim.coekaerts@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: wim@iguana.be, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, sparclinux@vger.kernel.org

This driver adds sparc hypervisor watchdog support. The default
timeout is 60 seconds and the range is between 1 and
31536000 seconds. Both watchdog-resolution and
watchdog-max-timeout MD properties settings are supported.

Signed-off-by: Wim Coekaerts <wim.coekaerts@oracle.com>
---
Change in v5:
  - After proper review of the hv watchdog api, the hv takes care of
	rounding to multiple of resolution internally so just check
	if it's <= 1 second.
  - Clean up _ping() and simplify _probe() value checking

Change in v4:
  - timeout in seconds
  - call the hv with support for microsecond resolution

Changes in v3:
  - Modify sun4v_mach_set_watchdog to allow for NULL and remove
	time_remaining
  - Cleanup includes
  - Consolidate _start and _ping into _ping since they were the same
  - Fix checkpatch warnings
  - Remove pr_info()s
  - Clean up return codes to be standard kernel return values
  - Consolidate _init and _probe into _init
	Don't use platform_device anymore because this is really
	just a driver that depends on a hv call. This now looks more
	like softdog.
  - Cleanly check for sun4v architecture and remove extra tests
  - Convert to ms timer support and honor resolution
	since most drivers use seconds I added _ms to make it clear
  - Clean up validation against the properties
  - Use sane values for MIN/MAX
---
 Documentation/watchdog/watchdog-parameters.txt |    4 +
 arch/sparc/kernel/hvcalls.S                    |    3 +-
 arch/sparc/kernel/sparc_ksyms_64.c             |    1 +
 drivers/watchdog/Kconfig                       |   11 ++
 drivers/watchdog/Makefile                      |    1 +
 drivers/watchdog/sun4v_wdt.c                   |  211 ++++++++++++++++++++++++
 6 files changed, 230 insertions(+), 1 deletions(-)
 create mode 100644 drivers/watchdog/sun4v_wdt.c

diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation/watchdog/watchdog-parameters.txt
index 9f9ec9f..4e4b6f1 100644
--- a/Documentation/watchdog/watchdog-parameters.txt
+++ b/Documentation/watchdog/watchdog-parameters.txt
@@ -400,3 +400,7 @@ wm8350_wdt:
 nowayout: Watchdog cannot be stopped once started
 	(default=kernel config parameter)
 -------------------------------------------------
+sun4v_wdt:
+timeout_ms: Watchdog timeout in milliseconds 1..180000, default`000)
+nowayout: Watchdog cannot be stopped once started
+-------------------------------------------------
diff --git a/arch/sparc/kernel/hvcalls.S b/arch/sparc/kernel/hvcalls.S
index afbaba5..d127130 100644
--- a/arch/sparc/kernel/hvcalls.S
+++ b/arch/sparc/kernel/hvcalls.S
@@ -338,8 +338,9 @@ ENTRY(sun4v_mach_set_watchdog)
 	mov	%o1, %o4
 	mov	HV_FAST_MACH_SET_WATCHDOG, %o5
 	ta	HV_FAST_TRAP
+	brnz,a,pn %o4, 0f
 	stx	%o1, [%o4]
-	retl
+0:	retl
 	 nop
 ENDPROC(sun4v_mach_set_watchdog)
 
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
index 4f0e7be..30d38ae 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1565,6 +1565,17 @@ config WATCHDOG_RIO
 	  machines.  The watchdog timeout period is normally one minute but
 	  can be changed with a boot-time parameter.
 
+config WATCHDOG_SUN4V
+	tristate "Sun4v Watchdog support"
+	select WATCHDOG_CORE
+	depends on SPARC64
+	help
+	  Say Y here to support the hypervisor watchdog capability embedded
+	  in the SPARC sun4v architecture.
+
+	  To compile this driver as a module, choose M here. The module will
+	  be called sun4v_wdt.
+
 # XTENSA Architecture
 
 # Xen Architecture
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index f566753..f6a6a38 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -179,6 +179,7 @@ obj-$(CONFIG_SH_WDT) += shwdt.o
 
 obj-$(CONFIG_WATCHDOG_RIO)		+= riowd.o
 obj-$(CONFIG_WATCHDOG_CP1XXX)		+= cpwd.o
+obj-$(CONFIG_WATCHDOG_SUN4V)		+= sun4v_wdt.o
 
 # XTENSA Architecture
 
diff --git a/drivers/watchdog/sun4v_wdt.c b/drivers/watchdog/sun4v_wdt.c
new file mode 100644
index 0000000..42da024
--- /dev/null
+++ b/drivers/watchdog/sun4v_wdt.c
@@ -0,0 +1,211 @@
+/*
+ *	sun4v watchdog timer
+ *	(c) Copyright 2016 Oracle Corporation
+ *
+ *	Implement a simple watchdog driver using the built-in sun4v hypervisor
+ *	watchdog support. If time expires, the hypervisor stops or bounces
+ *	the guest domain.
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/watchdog.h>
+#include <asm/hypervisor.h>
+#include <asm/mdesc.h>
+
+#define WDT_TIMEOUT			60
+#define WDT_MAX_TIMEOUT			31536000
+#define WDT_MIN_TIMEOUT			1
+#define WDT_DEFAULT_RESOLUTION_MS	1000	/* 1 second */
+
+static unsigned int wdt_max_timeout = WDT_MAX_TIMEOUT;
+
+static unsigned int timeout = WDT_TIMEOUT;
+module_param(timeout, uint, S_IRUGO);
+MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds (default="
+	__MODULE_STRING(WDT_TIMEOUT) ")");
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, S_IRUGO);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
+	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+static int sun4v_wdt_stop(struct watchdog_device *wdd)
+{
+	sun4v_mach_set_watchdog(0, NULL);
+
+	return 0;
+}
+
+static int sun4v_wdt_ping(struct watchdog_device *wdd)
+{
+	int hverr;
+
+	/*
+	 * HV watchdog timer will round up the timeout
+	 * passed in to the nearest multiple of the
+	 * watchdog resolution in milliseconds.
+	 */
+	hverr = sun4v_mach_set_watchdog(wdd->timeout * 1000, NULL);
+	if (hverr = HV_EINVAL)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int sun4v_wdt_set_timeout(struct watchdog_device *wdd,
+				 unsigned int timeout)
+{
+	wdd->timeout = timeout;
+
+	return 0;
+}
+
+static const struct watchdog_info sun4v_wdt_ident = {
+	.options =	WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
+	.identity =	"sun4v hypervisor watchdog",
+	.firmware_version = 0,
+};
+
+static struct watchdog_ops sun4v_wdt_ops = {
+	.owner =	THIS_MODULE,
+	.start =	sun4v_wdt_ping,
+	.stop =		sun4v_wdt_stop,
+	.ping =		sun4v_wdt_ping,
+	.set_timeout =	sun4v_wdt_set_timeout,
+};
+
+static struct watchdog_device wdd = {
+	.info = &sun4v_wdt_ident,
+	.ops = &sun4v_wdt_ops,
+	.min_timeout = WDT_MIN_TIMEOUT,
+};
+
+static int hvapi_registered;
+
+static int __init sun4v_wdt_init(void)
+{
+	struct mdesc_handle *handle;
+	u64 node;
+	const u64 *value;
+	u64 wdt_max_property;
+	u64 wdt_resolution_property;
+	int ret = 0;
+	unsigned long major = 1, minor = 1;
+
+	/*
+	 * This is a safe way to validate if we are on the right
+	 * platform.
+	 */
+	if (sun4v_hvapi_register(HV_GRP_CORE, major, &minor) != 0)
+		return -ENODEV;
+	if (minor < 1) {
+		sun4v_hvapi_unregister(HV_GRP_CORE);
+		return -ENODEV;
+	}
+	hvapi_registered = 1;
+
+	/*
+	 * There are 2 properties that can be set from the control
+	 * domain for the watchdog.
+	 * watchdog-resolution
+	 * watchdog-max-timeout
+	 *
+	 * We can expect a handle to be returned otherwise something
+	 * serious is wrong. Correct to return -ENODEV here.
+	 */
+
+	handle = mdesc_grab();
+	if (!handle)
+		return -ENODEV;
+
+	node = mdesc_node_by_name(handle, MDESC_NODE_NULL, "platform");
+	if (node = MDESC_NODE_NULL) {
+		mdesc_release(handle);
+		sun4v_hvapi_unregister(HV_GRP_CORE);
+		return -ENODEV;
+	}
+
+	/* Allow for resolution up to 1s (default) */
+	value = mdesc_get_property(handle, node, "watchdog-resolution", NULL);
+	if (value) {
+		wdt_resolution_property = *value;
+		if (wdt_resolution_property = 0 ||
+		    wdt_resolution_property > WDT_DEFAULT_RESOLUTION_MS) {
+			mdesc_release(handle);
+			sun4v_hvapi_unregister(HV_GRP_CORE);
+			return -EINVAL;
+		}
+	}
+
+	value = mdesc_get_property(handle, node, "watchdog-max-timeout", NULL);
+	if (value) {
+		wdt_max_property = *value;
+		/*
+		 * If the property (in ms) is set to a value smaller than
+		 * WDT_MIN_TIMEOUT, return -EINVAL.
+		 */
+		if (wdt_max_property < (WDT_MIN_TIMEOUT * 1000)) {
+			mdesc_release(handle);
+			sun4v_hvapi_unregister(HV_GRP_CORE);
+			return -EINVAL;
+		}
+
+		/*
+		 * If the property is set to a value smaller than
+		 * WDT_MAX_TIMEOUT then set wdt_max_timeout to
+		 * the value of the property in seconds.
+		 */
+		if (wdt_max_property < (wdt_max_timeout * 1000))
+			wdt_max_timeout = wdt_max_property  / 1000;
+	}
+
+	mdesc_release(handle);
+
+	if (timeout < WDT_MIN_TIMEOUT)
+		timeout = WDT_MIN_TIMEOUT;
+	if (timeout > wdt_max_timeout)
+		timeout = wdt_max_timeout;
+
+	wdd.max_timeout = wdt_max_timeout;
+	wdd.timeout = timeout;
+
+	watchdog_set_nowayout(&wdd, nowayout);
+
+	ret = watchdog_register_device(&wdd);
+	if (ret) {
+		sun4v_hvapi_unregister(HV_GRP_CORE);
+		return ret;
+	}
+
+	pr_info("initialized (timeout=%dms, nowayout=%d)\n",
+		 wdd.timeout, nowayout);
+
+	return 0;
+}
+
+
+static void __exit sun4v_wdt_exit(void)
+{
+	if (hvapi_registered)
+		sun4v_hvapi_unregister(HV_GRP_CORE);
+	sun4v_wdt_stop(&wdd);
+	watchdog_unregister_device(&wdd);
+}
+
+module_init(sun4v_wdt_init);
+module_exit(sun4v_wdt_exit);
+
+MODULE_AUTHOR("Wim Coekaerts <wim.coekaerts@oracle.com>");
+MODULE_DESCRIPTION("sun4v watchdog driver");
+MODULE_LICENSE("GPL");
-- 
1.7.1

