From: Julian Calaby <julian.calaby@gmail.com>
Date: Wed, 13 Jan 2016 00:06:42 +0000
Subject: Re: [PATCH] watchdog: add sun4v_wdt device support
Message-Id: <CAGRGNgU=RHbdJoGriAL2aE1NuhdzQu5LFiktPsZTaCnBGEoDnw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1452640232-1165-1-git-send-email-wim.coekaerts@oracle.com>
In-Reply-To: <1452640232-1165-1-git-send-email-wim.coekaerts@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: wim.coekaerts@oracle.com
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>

Hi Wim,

On Wed, Jan 13, 2016 at 10:10 AM,  <wim.coekaerts@oracle.com> wrote:
> From: Wim Coekaerts <wim.coekaerts@oracle.com>
>
> This adds a simple watchdog timer for the SPARC sunv4 architecture.
> Export the sun4v_mach_set_watchdog() hv call, and add the target.
> The driver was based on the same model used by the Xen watchdog driver.
>
> This was tested on T2, T4, T5 and T7.
>
> Signed-off-by: Wim Coekaerts <wim.coekaerts@oracle.com>
> ---
>  arch/sparc/kernel/sparc_ksyms_64.c |    1 +
>  drivers/watchdog/Kconfig           |   10 +
>  drivers/watchdog/Makefile          |    1 +
>  drivers/watchdog/sun4v_wdt.c       |  421 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 433 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/watchdog/sun4v_wdt.c
>
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
> index 1c427be..08834e4 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1516,6 +1516,16 @@ config UML_WATCHDOG
>         tristate "UML watchdog"
>         depends on UML
>
> +# SPARC sun4v
> +
> +config WATCHDOG_SUN4V
> +       tristate "Sun4v Watchdog support"
> +       depends on SPARC64
> +       help
> +         Say Y here to support the hypervisor watchdog capability provided
> +         by the sun4v architecture.  The watchdog timeout period is normally one
> +         minute but can be changed with a boot-time parameter.
> +
>  #
>  # ISA-based Watchdog Cards
>  #
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 53d4827..9b8acb8 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -175,6 +175,7 @@ obj-$(CONFIG_SH_WDT) += shwdt.o
>
>  obj-$(CONFIG_WATCHDOG_RIO)             += riowd.o
>  obj-$(CONFIG_WATCHDOG_CP1XXX)          += cpwd.o
> +obj-$(CONFIG_WATCHDOG_SUN4V)           += sun4v_wdt.o
>
>  # XTENSA Architecture
>
> diff --git a/drivers/watchdog/sun4v_wdt.c b/drivers/watchdog/sun4v_wdt.c
> new file mode 100644
> index 0000000..1213a1f
> --- /dev/null
> +++ b/drivers/watchdog/sun4v_wdt.c
> @@ -0,0 +1,421 @@
> +/*
> + *     Sun4v Watchdog Driver
> + *     (c) Copyright 2015 Oracle Corporation
> + *
> + *     Heavily modified version of xen_wdt.c
> + *      (c) Copyright 2010 Novell, Inc.
> + *
> + *

Extra line?

> + *     This program is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License
> + *     as published by the Free Software Foundation; either version
> + *     2 of the License, or (at your option) any later version.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#define DRV_NAME       "sun4v_wdt"
> +#define DRV_VERSION    "0.01"
> +
> +#include <linux/bug.h>
> +#include <linux/errno.h>
> +#include <linux/fs.h>
> +#include <linux/hrtimer.h>
> +#include <linux/kernel.h>
> +#include <linux/ktime.h>
> +#include <linux/init.h>

Aren't these usually sorted alphabetically? If so, init.h should come
before kernel.h.

> +#include <linux/miscdevice.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/platform_device.h>
> +#include <linux/spinlock.h>
> +#include <linux/uaccess.h>
> +#include <linux/watchdog.h>
> +#include <asm/hypervisor.h>
> +#include <asm/mdesc.h>
> +
> +

Extra blank line? Have you run this through checkpatch.pl?

> +static struct platform_device *platform_device;
> +static DEFINE_SPINLOCK(wdt_lock);
> +static __kernel_time_t wdt_expires;
> +static unsigned long is_active;
> +static bool expect_release;
> +
> +unsigned long wdt_timeout = 0;
> +
> +#define WATCHDOG_TIMEOUT 60 /* in seconds */
> +static unsigned long timeout = WATCHDOG_TIMEOUT;
> +module_param(timeout, ulong, S_IRUGO);
> +MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds "
> +       "(default=" __MODULE_STRING(WATCHDOG_TIMEOUT) ")");
> +
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, S_IRUGO);
> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
> +       "(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +static inline __kernel_time_t set_timeout(void)
> +{
> +       /*
> +        * The hypervisor specifies WD timeout in milliseconds
> +        * Change it to seconds here and
> +        * to do it in one place rather than every call to
> +        * sun4v_mach_set_watchdog()
> +        * The hvcall expects milliseconds while the parameters
> +        * and the rest of the code expects seconds. wdt_timeout
> +        * is the variable that we pass to the hvcall.
> +        */
> +       wdt_timeout = timeout * 1000;
> +       return ktime_to_timespec(ktime_get()).tv_sec + timeout;
> +}

Would it be more readable to just convert the time per-call (or wrap
the method) instead of this?

Also, the name "set_timeout" implies that it takes a parameter to me,
which makes this confusing.

> +
> +static int sun4v_wdt_start(void)
> +{
> +       __kernel_time_t expires;
> +       unsigned long time_remaining;
> +       int err;
> +
> +       spin_lock(&wdt_lock);
> +
> +       expires = set_timeout();

For example, here we're setting "expires" and then using wdt_timeout
instead which is somewhat confusing.

> +       err = sun4v_mach_set_watchdog(wdt_timeout, &time_remaining);

I also note that the time_remaining variable is never used.

Why not something like:

static inline int write_timeout()
{
    unsigned long time_remaining;
    return sun4v_mach_set_watchdog(timeout * 1000, &time_remaining);
}

then the previous two lines would be replaced with:

err = write_timeout();

> +
> +       spin_unlock(&wdt_lock);
> +
> +       pr_info("Watchdog timer enabled\n");
> +       return err;
> +}
> +
> +static int sun4v_wdt_stop(void)
> +{
> +       int err;
> +       unsigned long time_remaining;
> +
> +       spin_lock(&wdt_lock);
> +
> +        err = sun4v_mach_set_watchdog(0, &time_remaining);
> +
> +       spin_unlock(&wdt_lock);
> +
> +       pr_info("Watchdog timer disabled\n");
> +       return err;
> +}
> +
> +static int sun4v_wdt_kick(void)
> +{
> +       __kernel_time_t expires;
> +       int err;
> +       unsigned long time_remaining;
> +
> +       spin_lock(&wdt_lock);
> +
> +       expires = set_timeout();
> +        err = sun4v_mach_set_watchdog(wdt_timeout, &time_remaining);
> +       if (!err)
> +               wdt_expires = expires;

And this could be replaced with:

err = write_timeout();
if (!err)
    wdt_expires = ktime_to_timespec(ktime_get()).tv_sec + timeout;

> +
> +       spin_unlock(&wdt_lock);
> +
> +       return err;
> +}
> +
> +static int sun4v_wdt_open(struct inode *inode, struct file *file)
> +{
> +       int err;
> +
> +       /* /dev/watchdog can only be opened once */
> +       if (test_and_set_bit(0, &is_active))
> +               return -EBUSY;
> +
> +       /* prevent someone from rmmod'ing the module */
> +       if (nowayout)
> +               __module_get(THIS_MODULE);
> +
> +       err = sun4v_wdt_start();
> +       if (err = -EBUSY) {
> +               err = sun4v_wdt_kick();
> +       }
> +
> +       return err ?: nonseekable_open(inode, file);

I've nothing against the usage of ?:, but would it be cleaner to write:

if (err)
    return err;

return nonseekable_open(inode, file);

> +}
> +
> +static int sun4v_wdt_release(struct inode *inode, struct file *file)
> +{
> +       int err;
> +
> +       if (expect_release)
> +               err = sun4v_wdt_stop();
> +       else {
> +               pr_crit("Unexpected close, not stopping watchdog!\n");
> +               sun4v_wdt_kick();
> +       }
> +
> +       clear_bit(0, &is_active);
> +       expect_release = false;
> +
> +       return 0;
> +}
> +
> +static ssize_t sun4v_wdt_write(struct file *file, const char __user *data,
> +                            size_t len, loff_t *ppos)
> +{
> +       /* See if we got the magic character 'V' and reload the timer */
> +       if (len) {
> +               if (!nowayout) {
> +                       size_t i;
> +
> +                       /* in case it was set long ago */
> +                       expect_release = false;
> +
> +                       /* scan to see whether or not we got the magic
> +                          character */
> +                       for (i = 0; i != len; i++) {
> +                               char c;
> +                               if (get_user(c, data + i))
> +                                       return -EFAULT;
> +                               if (c = 'V')
> +                                       expect_release = true;
> +                       }
> +               }
> +
> +               /* someone wrote to us, we should reload the timer */
> +               sun4v_wdt_kick();
> +       }
> +       return len;
> +}
> +
> +static long sun4v_wdt_ioctl(struct file *file, unsigned int cmd,
> +                         unsigned long arg)
> +{
> +       int new_options, retval = -EINVAL;
> +       int new_timeout;
> +       int __user *argp = (void __user *)arg;
> +       static const struct watchdog_info ident = {
> +               .options =              WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
> +               .firmware_version =     0,
> +               .identity =             "SUN4V Watchdog",
> +       };
> +
> +       switch (cmd) {
> +       case WDIOC_GETSUPPORT:
> +               return copy_to_user(argp, &ident, sizeof(ident)) ? -EFAULT : 0;
> +
> +       case WDIOC_GETSTATUS:
> +       case WDIOC_GETBOOTSTATUS:
> +               return put_user(0, argp);
> +
> +       case WDIOC_SETOPTIONS:
> +               if (get_user(new_options, argp))
> +                       return -EFAULT;
> +
> +               if (new_options & WDIOS_DISABLECARD)
> +                       retval = sun4v_wdt_stop();
> +               if (new_options & WDIOS_ENABLECARD) {
> +                       retval = sun4v_wdt_start();
> +                       if (retval = -EBUSY)
> +                               retval = sun4v_wdt_kick();
> +               }
> +               return retval;
> +
> +       case WDIOC_KEEPALIVE:
> +               sun4v_wdt_kick();
> +               return 0;
> +
> +       case WDIOC_SETTIMEOUT:
> +               if (get_user(new_timeout, argp))
> +                       return -EFAULT;
> +               if (!new_timeout)
> +                       return -EINVAL;
> +               timeout = new_timeout;
> +               sun4v_wdt_kick();
> +               /* fall through */
> +       case WDIOC_GETTIMEOUT:
> +               return put_user(timeout, argp);
> +
> +       case WDIOC_GETTIMELEFT:
> +               retval = wdt_expires - ktime_to_timespec(ktime_get()).tv_sec;
> +               return put_user(retval, argp);
> +       }
> +
> +       return -ENOTTY;
> +}
> +
> +static const struct file_operations sun4v_wdt_fops = {
> +       .owner =                THIS_MODULE,
> +       .llseek =               no_llseek,
> +       .write =                sun4v_wdt_write,
> +       .unlocked_ioctl =       sun4v_wdt_ioctl,
> +       .open =                 sun4v_wdt_open,
> +       .release =              sun4v_wdt_release,
> +};
> +
> +static struct miscdevice sun4v_wdt_miscdev = {
> +       .minor =        WATCHDOG_MINOR,
> +       .name =         "watchdog",
> +       .fops =         &sun4v_wdt_fops,
> +};
> +
> +static int sun4v_wdt_probe(struct platform_device *dev)
> +{
> +       unsigned long wd_timeout = 0;
> +       unsigned long time_remaining;
> +       int ret;
> +
> +       ret = sun4v_mach_set_watchdog(wd_timeout, &time_remaining);

wd_timeout is 0 here and unused elsewhere in this function, so why not
write this as:

ret = sun4v_mach_set_watchdog(0, &time_remaining);

and get rid of the variable?

> +
> +       switch (ret) {
> +       case HV_EOK:
> +               if (!timeout) {
> +                       timeout = WATCHDOG_TIMEOUT;
> +                       pr_info("timeout value invalid, using %lu\n", timeout);
> +               }
> +
> +               ret = misc_register(&sun4v_wdt_miscdev);
> +               if (ret) {
> +                       pr_err("cannot register miscdev on minor=%d (%d)\n",
> +                              WATCHDOG_MINOR, ret);
> +                       break;
> +               }
> +
> +               pr_info("initialized (timeout=%lus, nowayout=%d)\n",
> +                       timeout, nowayout);
> +               break;
> +
> +       case -ENOSYS:
> +               pr_info("not supported\n");
> +               ret = -ENODEV;
> +               break;
> +
> +       default:
> +               pr_info("bogus return value %d\n", ret);

Does this also mean it's not supported? If so, should we be returning
-ENODEV here too?

> +               break;
> +       }
> +
> +       return ret;
> +}
> +
> +static int sun4v_wdt_remove(struct platform_device *dev)
> +{
> +       /* Stop the timer before we leave */

Is this comment really needed?

> +
> +       if (!nowayout)
> +               sun4v_wdt_stop();

Can this method even be called if nowayout is set as we've taken a
reference to the module above?

> +
> +       misc_deregister(&sun4v_wdt_miscdev);
> +
> +       return 0;
> +}
> +
> +static void sun4v_wdt_shutdown(struct platform_device *dev)
> +{
> +       sun4v_wdt_stop();
> +}
> +
> +static int sun4v_wdt_suspend(struct platform_device *dev, pm_message_t state)
> +{
> +       int ret = sun4v_wdt_stop();
> +       return ret;

Could this be written as:

return sun4v_wdt_stop();

> +}
> +
> +static int sun4v_wdt_resume(struct platform_device *dev)
> +{
> +       return sun4v_wdt_start();
> +}
> +
> +static struct platform_driver sun4v_wdt_driver = {
> +       .probe          = sun4v_wdt_probe,
> +       .remove         = sun4v_wdt_remove,
> +       .shutdown       = sun4v_wdt_shutdown,
> +       .suspend        = sun4v_wdt_suspend,
> +       .resume         = sun4v_wdt_resume,
> +       .driver         = {
> +               .name   = DRV_NAME,
> +       },
> +};
> +
> +static int __init sun4v_wdt_init_module(void)
> +{
> +       int err;
> +       struct mdesc_handle *hp;
> +       u64 pn;
> +       const u64 *v;

You could use more descriptive names here: "handle" instead of "hp",
"node" instead of "pn" and "value" instead of "v".

> +       u64 max_timeout = 0;
> +       u64 resolution;
> +
> +       /*
> +        * There are 2 properties that can be set from the control
> +        * domain for the watchdog.
> +        * watchdog-resolution (in ms defaulting to 1000)
> +        * watchdog-max-timeout (in ms)
> +        * Right now, only support the default 1s (1000ms) resolution
> +        * so just verify against the property, and make sure
> +        * max timeout is taken into account, if set.
> +        */
> +       hp = mdesc_grab();
> +       pn = mdesc_node_by_name(hp, MDESC_NODE_NULL, "platform");
> +
> +       if (pn = MDESC_NODE_NULL) {
> +               pr_info("No platform node \n");
> +               return -ENODEV;
> +       }
> +
> +       v = mdesc_get_property(hp, pn, "watchdog-resolution", NULL);
> +       if (v) {
> +               resolution = *v;
> +               pr_info("Platform watchdog-resolution [%llux]\n", *v);
> +               /* default resolution is 1000ms, should be fine */
> +               /* not supporting anything else right now */
> +               if (resolution != 1000) {
> +                       pr_crit("Only 1000ms is supported.\n");
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       v = mdesc_get_property(hp, pn, "watchdog-max-timeout", NULL);
> +       if (v) {
> +               max_timeout = *v;

max_timeout is only used in the function. Why not do the division here
instead of below?

I.e.

max_timeout = *v / 1000;

...

if (max_timeout < 1) {
    ...
}

if (timeout > max_timeout) {
    timeout = max_timeout;
    ...
    pr_info("Setting timeout to watchdog-max-timeout [%llu s]\n", max_timeout);
}

> +               pr_info("Platform watchdog-max-timeout [%llu ms]\n", *v);
> +               if (max_timeout < 1000) {
> +                       pr_crit("Timeout should be at least 1s(1000ms)\n");
> +                       return -EINVAL;
> +               }
> +       }

What happens if we cannot get a maximum timeout value? max_timeout
will be zero here, so the following if statement will set timeout to
0, which appears to be a magic value to disable the watchdog.

It looks like either:
1. We should use a default max_timeout value.
2. We should fail.

Continuing without doing either appears to break stuff.

> +
> +       /* have to convert timeout in seconds to timeout in milliseconds */
> +       if (timeout * 1000 > max_timeout) {
> +               /* and convert down to seconds again */
> +               timeout = max_timeout / 1000;
> +               pr_info("Timeout larger than watchdog-max-timeout\n");
> +               pr_info("Setting timeout to watchdog-max-timeout [%llu ms]\n", max_timeout);
> +       }
> +
> +       pr_info("Sun4v WatchDog Timer Driver v%s\n", DRV_VERSION);
> +
> +       err = platform_driver_register(&sun4v_wdt_driver);
> +       if (err)
> +               return err;
> +
> +       platform_device = platform_device_register_simple(DRV_NAME,
> +                                                                 -1, NULL, 0);
> +       if (IS_ERR(platform_device)) {
> +               err = PTR_ERR(platform_device);
> +               platform_driver_unregister(&sun4v_wdt_driver);
> +       }
> +
> +       return err;
> +}
> +
> +static void __exit sun4v_wdt_cleanup_module(void)
> +{
> +       platform_device_unregister(platform_device);
> +       platform_driver_unregister(&sun4v_wdt_driver);
> +       pr_info("module unloaded\n");
> +}
> +
> +module_init(sun4v_wdt_init_module);
> +module_exit(sun4v_wdt_cleanup_module);
> +
> +MODULE_AUTHOR("Wim Coekaerts <wim.coekaerts@oracle.com>");
> +MODULE_DESCRIPTION("Sun4v WatchDog Timer Driver");
> +MODULE_VERSION(DRV_VERSION);
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
