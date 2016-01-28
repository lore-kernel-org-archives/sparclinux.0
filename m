From: Julian Calaby <julian.calaby@gmail.com>
Date: Thu, 28 Jan 2016 22:50:48 +0000
Subject: Re: [PATCH v6] Add sun4v_wdt watchdog driver
Message-Id: <CAGRGNgWKzomgV2199r_Ym-DbGpeHz5dLwcWkC5-Lz+pftqBF9g@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1454017572-5235-1-git-send-email-wim.coekaerts@oracle.com>
In-Reply-To: <1454017572-5235-1-git-send-email-wim.coekaerts@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wim Coekaerts <wim.coekaerts@oracle.com>
Cc: wim@iguana.be, Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>

Hi Wim,

Sorry to keep iterating on this, but I noticed two small things you
could improve:

On Fri, Jan 29, 2016 at 8:46 AM, Wim Coekaerts <wim.coekaerts@oracle.com> wrote:
> This driver adds sparc hypervisor watchdog support. The default
> timeout is 60 seconds and the range is between 1 and
> 31536000 seconds. Both watchdog-resolution and
> watchdog-max-timeout MD properties settings are supported.
>
> Signed-off-by: Wim Coekaerts <wim.coekaerts@oracle.com>
> ---
> diff --git a/drivers/watchdog/sun4v_wdt.c b/drivers/watchdog/sun4v_wdt.c
> new file mode 100644
> index 0000000..a01aec1
> --- /dev/null
> +++ b/drivers/watchdog/sun4v_wdt.c
> @@ -0,0 +1,196 @@
> +/*
> + *     sun4v watchdog timer
> + *     (c) Copyright 2016 Oracle Corporation
> + *
> + *     Implement a simple watchdog driver using the built-in sun4v hypervisor
> + *     watchdog support. If time expires, the hypervisor stops or bounces
> + *     the guest domain.
> + *
> + *     This program is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License
> + *     as published by the Free Software Foundation; either version
> + *     2 of the License, or (at your option) any later version.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/watchdog.h>
> +#include <asm/hypervisor.h>
> +#include <asm/mdesc.h>
> +
> +#define WDT_TIMEOUT                    60
> +#define WDT_MAX_TIMEOUT                        31536000
> +#define WDT_MIN_TIMEOUT                        1
> +#define WDT_DEFAULT_RESOLUTION_MS      1000    /* 1 second */
> +
> +static unsigned int wdt_max_timeout = WDT_MAX_TIMEOUT;

You don't need a static variable for this as it's only used in sun4v_wdt_init().

> +static unsigned int timeout;
> +module_param(timeout, uint, 0);
> +MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds (default="
> +       __MODULE_STRING(WDT_TIMEOUT) ")");
> +
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, S_IRUGO);
> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
> +       __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +static int sun4v_wdt_stop(struct watchdog_device *wdd)
> +{
> +       sun4v_mach_set_watchdog(0, NULL);
> +
> +       return 0;
> +}
> +
> +static int sun4v_wdt_ping(struct watchdog_device *wdd)
> +{
> +       int hverr;
> +
> +       /*
> +        * HV watchdog timer will round up the timeout
> +        * passed in to the nearest multiple of the
> +        * watchdog resolution in milliseconds.
> +        */
> +       hverr = sun4v_mach_set_watchdog(wdd->timeout * 1000, NULL);
> +       if (hverr = HV_EINVAL)
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
> +static int sun4v_wdt_set_timeout(struct watchdog_device *wdd,
> +                                unsigned int timeout)
> +{
> +       wdd->timeout = timeout;
> +
> +       return 0;
> +}
> +
> +static const struct watchdog_info sun4v_wdt_ident = {
> +       .options =      WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
> +       .identity =     "sun4v hypervisor watchdog",
> +       .firmware_version = 0,
> +};
> +
> +static struct watchdog_ops sun4v_wdt_ops = {
> +       .owner =        THIS_MODULE,
> +       .start =        sun4v_wdt_ping,
> +       .stop =         sun4v_wdt_stop,
> +       .ping =         sun4v_wdt_ping,
> +       .set_timeout =  sun4v_wdt_set_timeout,
> +};
> +
> +static struct watchdog_device wdd = {
> +       .info = &sun4v_wdt_ident,
> +       .ops = &sun4v_wdt_ops,
> +       .min_timeout = WDT_MIN_TIMEOUT,
> +       .timeout = WDT_TIMEOUT,
> +};
> +
> +static int __init sun4v_wdt_init(void)
> +{
> +       struct mdesc_handle *handle;
> +       u64 node;
> +       const u64 *value;
> +       u64 wdt_max_property;
> +       u64 wdt_resolution_property;

You also don't need either of the wdt_*_property variables.

> +       int err = 0;
> +       unsigned long major = 1, minor = 1;
> +
> +       /*
> +        * There are 2 properties that can be set from the control
> +        * domain for the watchdog.
> +        * watchdog-resolution
> +        * watchdog-max-timeout
> +        *
> +        * We can expect a handle to be returned otherwise something
> +        * serious is wrong. Correct to return -ENODEV here.
> +        */
> +
> +       handle = mdesc_grab();
> +       if (!handle)
> +               return -ENODEV;
> +
> +       node = mdesc_node_by_name(handle, MDESC_NODE_NULL, "platform");
> +       err = -ENODEV;
> +       if (node = MDESC_NODE_NULL)
> +               goto out_release;
> +
> +       /*
> +        * This is a safe way to validate if we are on the right
> +        * platform.
> +        */
> +       if (sun4v_hvapi_register(HV_GRP_CORE, major, &minor))
> +               goto out_hv_unreg;
> +
> +       /* Allow for resolution up to 1s (default) */
> +       value = mdesc_get_property(handle, node, "watchdog-resolution", NULL);
> +       err = -EINVAL;
> +       if (value) {
> +               wdt_resolution_property = *value;
> +               if (wdt_resolution_property = 0 ||
> +                   wdt_resolution_property > WDT_DEFAULT_RESOLUTION_MS)

You could just use *value instead of wdt_resolution_property here.

> +                       goto out_hv_unreg;
> +       }
> +
> +       value = mdesc_get_property(handle, node, "watchdog-max-timeout", NULL);
> +       if (value) {
> +               wdt_max_property = *value;
> +               /*
> +                * If the property (in ms) is set to a value smaller than
> +                * WDT_MIN_TIMEOUT, return -EINVAL.
> +                */
> +               if (wdt_max_property < WDT_MIN_TIMEOUT * 1000)
> +                       goto out_hv_unreg;
> +
> +               /*
> +                * If the property is set to a value smaller than
> +                * WDT_MAX_TIMEOUT then set wdt_max_timeout to
> +                * the value of the property in seconds.
> +                */
> +               if (wdt_max_property < wdt_max_timeout * 1000)
> +                       wdt_max_timeout = wdt_max_property  / 1000;

Same in this block.

> +       }
> +
> +       wdd.max_timeout = wdt_max_timeout;
> +
> +       watchdog_init_timeout(&wdd, timeout, NULL);
> +
> +       watchdog_set_nowayout(&wdd, nowayout);
> +
> +       err = watchdog_register_device(&wdd);
> +       if (err)
> +               goto out_hv_unreg;
> +
> +       pr_info("initialized (timeout=%dms, nowayout=%d)\n",
> +                wdd.timeout, nowayout);
> +
> +       mdesc_release(handle);
> +
> +       return 0;
> +
> +out_hv_unreg:
> +       sun4v_hvapi_unregister(HV_GRP_CORE);
> +
> +out_release:
> +       mdesc_release(handle);
> +       return err;
> +}
> +
> +static void __exit sun4v_wdt_exit(void)
> +{
> +       sun4v_hvapi_unregister(HV_GRP_CORE);
> +       watchdog_unregister_device(&wdd);
> +}
> +
> +module_init(sun4v_wdt_init);
> +module_exit(sun4v_wdt_exit);
> +
> +MODULE_AUTHOR("Wim Coekaerts <wim.coekaerts@oracle.com>");
> +MODULE_DESCRIPTION("sun4v watchdog driver");
> +MODULE_LICENSE("GPL");
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
