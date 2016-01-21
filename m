From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 21 Jan 2016 16:34:49 +0000
Subject: Re: [PATCH] watchdog: add sun4v_wdt device support
Message-Id: <20160121163449.GA914@roeck-us.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1452640232-1165-1-git-send-email-wim.coekaerts@oracle.com>
In-Reply-To: <1452640232-1165-1-git-send-email-wim.coekaerts@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: wim.coekaerts@oracle.com
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org, sparclinux@vger.kernel.org

On Wed, Jan 20, 2016 at 12:30:44PM -0800, wim.coekaerts@oracle.com wrote:
> From: Wim Coekaerts <wim.coekaerts@oracle.com>
> 
> This adds a simple watchdog timer for the SPARC sunv4 architecture.
> Export the sun4v_mach_set_watchdog() hv call, and add the target.
> 

What is "the target" ?

> The driver is implemented using the new watchdog api framework.
> 
Not really new ...

> Signed-off-by: Wim Coekaerts <wim.coekaerts@oracle.com>
> ---
> 
Please version your patches and provide a changelog here.

>  Documentation/watchdog/watchdog-parameters.txt |    5 +
>  arch/sparc/kernel/sparc_ksyms_64.c             |    1 +
>  drivers/watchdog/Kconfig                       |    9 +
>  drivers/watchdog/Makefile                      |    1 +
>  drivers/watchdog/sun4v_wdt.c                   |  323 ++++++++++++++++++++++++
>  5 files changed, 339 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/watchdog/sun4v_wdt.c
> 
> diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation/watchdog/watchdog-parameters.txt
> index 9f9ec9f..de92c95 100644
> --- a/Documentation/watchdog/watchdog-parameters.txt
> +++ b/Documentation/watchdog/watchdog-parameters.txt
> @@ -400,3 +400,8 @@ wm8350_wdt:
>  nowayout: Watchdog cannot be stopped once started
>  	(default=kernel config parameter)
>  -------------------------------------------------
> +sun4v_wdt:
> +timeout: Watchdog timeout in seconds (1..31536000, default`)
> +nowayout: Watchdog cannot be stopped once started
> +-------------------------------------------------
> +

Blank line at end of file causes warning when applying the patch.

> diff --git a/arch/sparc/kernel/sparc_ksyms_64.c b/arch/sparc/kernel/sparc_ksyms_64.c
> index a92d5d2..9e034f2 100644
> --- a/arch/sparc/kernel/sparc_ksyms_64.c
> +++ b/arch/sparc/kernel/sparc_ksyms_64.c
> @@ -37,6 +37,7 @@ EXPORT_SYMBOL(sun4v_niagara_getperf);
>  EXPORT_SYMBOL(sun4v_niagara_setperf);
>  EXPORT_SYMBOL(sun4v_niagara2_getperf);
>  EXPORT_SYMBOL(sun4v_niagara2_setperf);
> +EXPORT_SYMBOL(sun4v_mach_set_watchdog);
>  
>  /* from hweight.S */
>  EXPORT_SYMBOL(__arch_hweight8);
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 1c427be..441925b 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1500,6 +1500,15 @@ config WATCHDOG_RIO
>  	  machines.  The watchdog timeout period is normally one minute but
>  	  can be changed with a boot-time parameter.
>  
> +config WATCHDOG_SUN4V
> +	tristate "sun4v Watchdog support"
> +	select WATCHDOG_CORE
> +	depends on SPARC64
> +	help
> +	  Say Y/M here to support the hypervisor watchdog capability provided
> +	  by Oracle VM for SPARC.  The watchdog timeout period is normally one
> +	  minute but can be changed with a boot-time parameter.
> +
Please add customary "This driver can also be built as a module. If so, the
module will be called ..."

>  # XTENSA Architecture
>  
>  # Xen Architecture
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 53d4827..9b8acb8 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -175,6 +175,7 @@ obj-$(CONFIG_SH_WDT) += shwdt.o
>  
>  obj-$(CONFIG_WATCHDOG_RIO)		+= riowd.o
>  obj-$(CONFIG_WATCHDOG_CP1XXX)		+= cpwd.o
> +obj-$(CONFIG_WATCHDOG_SUN4V)		+= sun4v_wdt.o
>  
>  # XTENSA Architecture
>  
> diff --git a/drivers/watchdog/sun4v_wdt.c b/drivers/watchdog/sun4v_wdt.c
> new file mode 100644
> index 0000000..8d4a62a
> --- /dev/null
> +++ b/drivers/watchdog/sun4v_wdt.c
> @@ -0,0 +1,323 @@
> +/*
> + *	sun4v watchdog timer
> + *	(c) Copyright 2016 Oracle Corporation
> + *
> + *	Implement a simple watchdog driver using the sun4v hypervisor
> + *	watchdog support. If time expires, the hypervisor stops or bounces
> + *	the guest domain.
> + *
> + *	sun4v_mach_set_watchdog() expects time in ms
> + *
Unusual location for an API definition.

> + *	This program is free software; you can redistribute it and/or
> + *	modify it under the terms of the GNU General Public License
> + *	as published by the Free Software Foundation; either version
> + *	2 of the License, or (at your option) any later version.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#define DRV_NAME	"sun4v_wdt"
> +#define DRV_VERSION	"0.1"
> +

I would suggest to drop the version number. It doesn't really provide
any value, and history suggests that no one will be updating it in
the future.

> +#include <linux/bug.h>

Is this needed ? I don't see where.

> +#include <linux/errno.h>
> +#include <linux/hrtimer.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/ktime.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/platform_device.h>
> +#include <linux/spinlock.h>
> +#include <linux/watchdog.h>
> +#include <asm/hypervisor.h>
> +#include <asm/mdesc.h>
> +
> +#define WATCHDOG_TIMEOUT 60		/* in seconds */
> +#define WDT_MAX_TIMEOUT	31536000	/* in seconds */
> +#define WDT_MIN_TIMEOUT 1		/* in seconds */
> +
> +static struct platform_device *platform_device;
> +
> +struct sun4v_wdt {
> +	spinlock_t	lock;
> +	__kernel_time_t	expires;
> +	struct watchdog_device	wdd;
> +};
> +
> +static unsigned int max_timeout = WDT_MAX_TIMEOUT;
> +static unsigned int timeout = WATCHDOG_TIMEOUT;
> +module_param(timeout, uint, S_IRUGO);
> +MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds "
> +	"(default=" __MODULE_STRING(WATCHDOG_TIMEOUT) ")");
> +

checkpatch warning.

> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, S_IRUGO);
> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
> +	"(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");

checkpatch warning.

> +
> +static int sun4v_wdt_start(struct watchdog_device *wdd)
> +{
> +	struct sun4v_wdt *wdt = watchdog_get_drvdata(wdd);
> +	unsigned long time_remaining;
> +	int err;
> +
> +	spin_lock(&wdt->lock);
> +
> +	wdt->expires = ktime_to_timespec(ktime_get()).tv_sec + wdd->timeout;
> +	err = sun4v_mach_set_watchdog(wdd->timeout * 1000, &time_remaining);
> +

time_remaining seems to be unused. Can it be dropped ?

> +	spin_unlock(&wdt->lock);
> +

Why is this extra locking (on top of the locking by the watchdog core)
needed ?

> +	pr_info("timer enabled\n");

Please no such noise. This is normal kernel operation.

> +	return err;
> +}
> +
> +static int sun4v_wdt_stop(struct watchdog_device *wdd)
> +{
> +	struct sun4v_wdt *wdt = watchdog_get_drvdata(wdd);
> +	unsigned long time_remaining;
> +	int err;
> +
> +	spin_lock(&wdt->lock);
> +
> +	err = sun4v_mach_set_watchdog(0, &time_remaining);
> +
Non-standard error code leaking to caller (just an example).

> +	spin_unlock(&wdt->lock);
> +
> +	pr_info("timer disabled\n");

Please drop thie message.

> +	return err;
> +}
> +
> +static int sun4v_wdt_ping(struct watchdog_device *wdd)
> +{
> +	struct sun4v_wdt *wdt = watchdog_get_drvdata(wdd);
> +	int err;
> +	unsigned long time_remaining;
> +
> +	spin_lock(&wdt->lock);
> +
> +	wdt->expires = ktime_to_timespec(ktime_get()).tv_sec + wdd->timeout;
> +	err = sun4v_mach_set_watchdog(wdd->timeout * 1000, &time_remaining);
> +
> +	spin_unlock(&wdt->lock);
> +
> +	return err;
> +}
> +

Am I missing something, or is the start function identical to the
stop function ? If so, why have both ?

> +static int sun4v_wdt_set_timeout(struct watchdog_device *wdd,
> +				 unsigned int timeout)
> +{
> +	wdd->timeout = timeout;
> +
> +	if (watchdog_active(wdd)) {
> +		(void) sun4v_wdt_stop(wdd);
> +		return sun4v_wdt_start(wdd);

Is it really necessary to stop the watchdog before updating the timer ?
Can't you just set the new timeout like in the ping function ?

Also, since the calling code executes ping, is this even necessary ?

> +	}
> +
> +	return 0;
> +}
> +
> +static unsigned int sun4v_wdt_get_timeleft(struct watchdog_device *wdd)
> +{
> +	struct sun4v_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	return wdt->expires - ktime_to_timespec(ktime_get()).tv_sec;
> +}

get_timeleft() is supposed to return the time left from a hardware register
(if available). If we wanted to implement a "soft" version of get_timeleft(),
it should be done in the watchdog core, not in individual drivers. Please drop
(and with it the 'expires' variable).

> +
> +static const struct watchdog_info sun4v_wdt_ident = {
> +	.options =	WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
> +	.identity =	"sun4v watchdog",
> +	.firmware_version = 0,
> +};
> +
> +static struct watchdog_ops sun4v_wdt_ops = {
> +	.owner =	THIS_MODULE,
> +	.start =	sun4v_wdt_start,
> +	.stop =		sun4v_wdt_stop,
> +	.ping =		sun4v_wdt_ping,
> +	.set_timeout =	sun4v_wdt_set_timeout,
> +	.get_timeleft =	sun4v_wdt_get_timeleft,
> +};
> +
> +static int sun4v_wdt_probe(struct platform_device *pdev)
> +{
> +	struct watchdog_device *wdd;
> +	struct sun4v_wdt *wdt;
> +	unsigned long time_remaining;
> +	int ret = 0;
> +
> +	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> +	if (!wdt)
> +		return -ENOMEM;
> +
> +	wdd = &wdt->wdd;
> +	wdd->info = &sun4v_wdt_ident;
> +	wdd->ops = &sun4v_wdt_ops;
> +	wdd->min_timeout = WDT_MIN_TIMEOUT;
> +	wdd->max_timeout = max_timeout;
> +	wdd->timeout = timeout;
> +	wdd->parent = &pdev->dev;
> +
> +	watchdog_set_drvdata(wdd, wdt);
> +
> +	spin_lock_init(&wdt->lock);
> +
> +	ret = sun4v_mach_set_watchdog(wdd->timeout, &time_remaining);
> +	(void) sun4v_mach_set_watchdog(0, &time_remaining);
 
Why first set (and enable) the watchdog just to disable it
immediately afterwards ? Just to check if it can be set ?
Is that really necessary ? Can't you just set it to 0 
(disable it) and bail out if that does not work ?

> +	if (ret != HV_EOK) {

Please convert non-standard error numbers to standard error numbers
in the low level functions. If you look closely into your code,
the non-standard error codes are leaking to the watchdog core and thus
to the user.

> +		pr_info("Error setting timer\n");

If this is an error, it should be an error message.

> +		ret = -ENODEV;

If it means the device does not exist, there should be no message.
We don't want noise for systems which don't support the watchdog but
are instantiated for some reason.

> +		goto out;
> +	}
> +
> +	watchdog_set_nowayout(wdd, nowayout);
> +
> +	ret = watchdog_register_device(wdd);
> +	if (ret) {
> +		pr_err("Failed to register watchdog device (%d)\n", ret);

Please use dev_info/dev_err where possible.

> +		goto out;
> +	}
> +
> +	platform_set_drvdata(pdev, wdt);
> +
> +	pr_info("initialized (timeout=%ds, nowayout=%d)\n",
> +		wdd->timeout, nowayout);
> +out:

This label, and any jump to it, is unnecessary. Instead of "goto out;",
just return the error immediately.

> +	return ret;
> +}
> +
> +static int sun4v_wdt_remove(struct platform_device *pdev)
> +{
> +	struct sun4v_wdt *wdt = platform_get_drvdata(pdev);
> +
> +	(void) sun4v_wdt_stop(&wdt->wdd);
> +
> +	watchdog_unregister_device(&wdt->wdd);
> +
> +	return 0;
> +}
> +
> +static void sun4v_wdt_shutdown(struct platform_device *pdev)
> +{
> +	struct sun4v_wdt *wdt = platform_get_drvdata(pdev);
> +
> +	(void) sun4v_wdt_stop(&wdt->wdd);

The (void) is unnecessary here.

> +}
> +
> +static int sun4v_wdt_suspend(struct platform_device *pdev, pm_message_t state)
> +{
> +	struct sun4v_wdt *wdt = platform_get_drvdata(pdev);
> +
> +	return sun4v_wdt_stop(&wdt->wdd);

Even if the watchdog isn't running ?

> +}
> +
> +static int sun4v_wdt_resume(struct platform_device *pdev)
> +{
> +	struct sun4v_wdt *wdt = platform_get_drvdata(pdev);
> +
> +	return sun4v_wdt_start(&wdt->wdd);

Even if the watchdog wasn't running before ?

> +}
> +
> +static struct platform_driver sun4v_wdt_driver = {
> +	.probe          = sun4v_wdt_probe,
> +	.remove         = sun4v_wdt_remove,
> +	.shutdown       = sun4v_wdt_shutdown,
> +	.suspend        = sun4v_wdt_suspend,
> +	.resume         = sun4v_wdt_resume,

Please use driver pm operations.

> +	.driver         = {
> +		.name   = DRV_NAME,
> +	},
> +};
> +
> +static int __init sun4v_wdt_init_module(void)
> +{
> +	int err;
> +	struct mdesc_handle *handle;
> +	u64 node;
> +	const u64 *value;
> +	u64 resolution;
> +
> +	/*
> +	 * There are 2 properties that can be set from the control
> +	 * domain for the watchdog.
> +	 * watchdog-resolution (in ms defaulting to 1000)
> +	 * watchdog-max-timeout (in ms)
> +	 * Right now, only support the default 1s (1000ms) resolution
> +	 * so just verify against the property, and make sure
> +	 * max timeout is taken into account, if set.
> +	 */
> +	handle = mdesc_grab();
> +	if (!handle)
> +		return -ENODEV;
> +
Is there some means to determine if this is a SUN4V system ?
The detections used (like this one, and the attempt to set the watchdog
in the probe function) seem to be a bit shaky.

> +	node = mdesc_node_by_name(handle, MDESC_NODE_NULL, "platform");
> +	if (node = MDESC_NODE_NULL) {
> +		pr_info("No platform node\n");

Is this an error, or does it just indicate that the watchdog is not supported
ion this platform ? If it is an error, use pr_err(). If it means the watchdog is
not supported, return without message.

> +		err = -ENODEV;
> +		goto out;
> +	}
> +
> +	value = mdesc_get_property(handle, node, "watchdog-resolution", NULL);
> +	if (value) {
> +		resolution = *value;
> +		pr_info("Platform watchdog-resolution [%llux]\n", *value);
> +
> +		if (resolution != 1000) {
> +			pr_crit("Only 1000ms is supported.\n");

Why is this critical ? Seems to be an implementation problem.

> +			err = -EINVAL;
> +			goto out;
> +		}

I don't entirely follow why this restriction is necessary. Why not just
support arbitrary resolutions, especially since you consider other
resolutions to be a critical problem ?

> +	}
> +
> +	value = mdesc_get_property(handle, node, "watchdog-max-timeout", NULL);
> +	if (value) {
> +		/* convert ms to seconds */
> +		max_timeout = *value / 1000;

This can overflow.

> +		pr_info("Platform watchdog-max-timeout [%ds]\n", max_timeout);
> +
> +		if (max_timeout < WDT_MIN_TIMEOUT) {
> +			max_timeout = WDT_MIN_TIMEOUT;
> +			pr_info("Setting max timeout to [%ds]\n", max_timeout);
> +		}

This is kind of odd. If the platform specifies a smaller maximum timeout
than the pre-defined minimum, and you can just override that value,
why care in the first place ?

Also, WDT_MIN_TIMEOUT is 1 (second), meaning you would set the maximum
timeout to 1 second, and the default timeout would end up being invalid.
Can you try to define more reasonable acceptable limits ?

> +
> +		if (max_timeout > WDT_MAX_TIMEOUT) {
> +			max_timeout = WDT_MAX_TIMEOUT;
> +			pr_info("Setting max timeout to [%ds]\n", max_timeout);

Is WDT_MAX_TIMEOUT an absolute or an arbitrary limit ?

> +		}
> +	}
> +
> +	pr_info("sun4v watchdog timer v%s\n", DRV_VERSION);
> +
Please drop this message. The message in the probe function is sufficient (and
may already be considered noise).

> +	err = platform_driver_register(&sun4v_wdt_driver);
> +	if (err)
> +		return err;

no mdesc_release here ?

> +
> +	platform_device = platform_device_register_simple(DRV_NAME,
> +								  -1, NULL, 0);

Odd alignment. Please run your patch through checkpatch --strict and make sure
that alignments are correct.

> +	if (IS_ERR(platform_device)) {
> +		err = PTR_ERR(platform_device);
> +		platform_driver_unregister(&sun4v_wdt_driver);
> +	}
> +
> +out:
> +	if (handle)
> +		mdesc_release(handle);

You never get here if handle = NULL.

> +
> +	return err;
> +}
> +
> +static void __exit sun4v_wdt_cleanup_module(void)
> +{
> +	platform_device_unregister(platform_device);
> +	platform_driver_unregister(&sun4v_wdt_driver);
> +	pr_info("module unloaded\n");

Please no such noise.

> +}
> +
> +module_init(sun4v_wdt_init_module);
> +module_exit(sun4v_wdt_cleanup_module);

Wonder if it would be better to move the initialization into the probe
function and use module_patform_driver(), or module_platform_driver_probe().
Any reason for not doing that ?

> +
> +MODULE_AUTHOR("Wim Coekaerts <wim.coekaerts@oracle.com>");
> +MODULE_DESCRIPTION("sun4v watchdog timer");
> +MODULE_VERSION(DRV_VERSION);
> +MODULE_LICENSE("GPL");

No MODULE_ALIAS ?

> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
