From: Wim Coekaerts <wim.coekaerts@oracle.com>
Date: Fri, 22 Jan 2016 19:06:50 +0000
Subject: Re: [PATCH] watchdog: add sun4v_wdt device support
Message-Id: <56A27DCA.9060307@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20160121163449.GA914@roeck-us.net>
In-Reply-To: <20160121163449.GA914@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org, sparclinux@vger.kernel.org

Thanks for your feedback, I think I am close ;) a few comments/questions

>> +	return err;
>> +}
>> +
>> +static int sun4v_wdt_ping(struct watchdog_device *wdd)
>> +{
>> +	struct sun4v_wdt *wdt = watchdog_get_drvdata(wdd);
>> +	int err;
>> +	unsigned long time_remaining;
>> +
>> +	spin_lock(&wdt->lock);
>> +
>> +	wdt->expires = ktime_to_timespec(ktime_get()).tv_sec + wdd->timeout;
>> +	err = sun4v_mach_set_watchdog(wdd->timeout * 1000, &time_remaining);
>> +
>> +	spin_unlock(&wdt->lock);
>> +
>> +	return err;
>> +}
>> +
> Am I missing something, or is the start function identical to the
> stop function ? If so, why have both ?

fair - I am consolidating ping/start into ping
>
>> +static int sun4v_wdt_set_timeout(struct watchdog_device *wdd,
>> +				 unsigned int timeout)
>> +{
>> +	wdd->timeout = timeout;
>> +
>> +	if (watchdog_active(wdd)) {
>> +		(void) sun4v_wdt_stop(wdd);
>> +		return sun4v_wdt_start(wdd);
> Is it really necessary to stop the watchdog before updating the timer ?
> Can't you just set the new timeout like in the ping function ?
>
> Also, since the calling code executes ping, is this even necessary ?
Yeah my bad, I should have known this. No need to do this.
>
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static unsigned int sun4v_wdt_get_timeleft(struct watchdog_device *wdd)
>> +{
>> +	struct sun4v_wdt *wdt = watchdog_get_drvdata(wdd);
>> +
>> +	return wdt->expires - ktime_to_timespec(ktime_get()).tv_sec;
>> +}
> get_timeleft() is supposed to return the time left from a hardware register
> (if available). If we wanted to implement a "soft" version of get_timeleft(),
> it should be done in the watchdog core, not in individual drivers. Please drop
> (and with it the 'expires' variable).
Ok no problem, I do think it's useful even if the hardware doesn't 
support it.
To have an idea of how much time is left, I guess one could implement it
in the code using the watchdog but I think it's reasonable to provide 
support
in the driver or core. Would you implement a new op for this in core?

Anyway, I dropped it from my driver.
>
>> +
>> +static const struct watchdog_info sun4v_wdt_ident = {
>> +	.options =	WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
>> +	.identity =	"sun4v watchdog",
>> +	.firmware_version = 0,
>> +};
>> +
>> +static struct watchdog_ops sun4v_wdt_ops = {
>> +	.owner =	THIS_MODULE,
>> +	.start =	sun4v_wdt_start,
>> +	.stop =		sun4v_wdt_stop,
>> +	.ping =		sun4v_wdt_ping,
>> +	.set_timeout =	sun4v_wdt_set_timeout,
>> +	.get_timeleft =	sun4v_wdt_get_timeleft,
>> +};
>> +
>> +static int sun4v_wdt_probe(struct platform_device *pdev)
>> +{
>> +	struct watchdog_device *wdd;
>> +	struct sun4v_wdt *wdt;
>> +	unsigned long time_remaining;
>> +	int ret = 0;
>> +
>> +	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
>> +	if (!wdt)
>> +		return -ENOMEM;
>> +
>> +	wdd = &wdt->wdd;
>> +	wdd->info = &sun4v_wdt_ident;
>> +	wdd->ops = &sun4v_wdt_ops;
>> +	wdd->min_timeout = WDT_MIN_TIMEOUT;
>> +	wdd->max_timeout = max_timeout;
>> +	wdd->timeout = timeout;
>> +	wdd->parent = &pdev->dev;
>> +
>> +	watchdog_set_drvdata(wdd, wdt);
>> +
>> +	spin_lock_init(&wdt->lock);
>> +
>> +	ret = sun4v_mach_set_watchdog(wdd->timeout, &time_remaining);
>> +	(void) sun4v_mach_set_watchdog(0, &time_remaining);
>   
> Why first set (and enable) the watchdog just to disable it
> immediately afterwards ? Just to check if it can be set ?
> Is that really necessary ? Can't you just set it to 0
> (disable it) and bail out if that does not work ?

I thought about this a bit more and I removed it.
The point of it was that it tests if timeout is a valid value and if it
doesn't return HV_EOK the value is at a minimum wrong. Just a call
with 0 wouldn't help, which was why the 2 calls but in the end it's
really not the right place to do it.  So I just return EINVAL in ping
if it's wrong.
>
>> +	.driver         = {
>> +		.name   = DRV_NAME,
>> +	},
>> +};
>> +
>> +static int __init sun4v_wdt_init_module(void)
>> +{
>> +	int err;
>> +	struct mdesc_handle *handle;
>> +	u64 node;
>> +	const u64 *value;
>> +	u64 resolution;
>> +
>> +	/*
>> +	 * There are 2 properties that can be set from the control
>> +	 * domain for the watchdog.
>> +	 * watchdog-resolution (in ms defaulting to 1000)
>> +	 * watchdog-max-timeout (in ms)
>> +	 * Right now, only support the default 1s (1000ms) resolution
>> +	 * so just verify against the property, and make sure
>> +	 * max timeout is taken into account, if set.
>> +	 */
>> +	handle = mdesc_grab();
>> +	if (!handle)
>> +		return -ENODEV;
>> +
> Is there some means to determine if this is a SUN4V system ?
> The detections used (like this one, and the attempt to set the watchdog
> in the probe function) seem to be a bit shaky.
If this returns NULL, it's not a sun4v platform. This should be very
reliable. (unlike the watchdog one)
>
>> +	node = mdesc_node_by_name(handle, MDESC_NODE_NULL, "platform");
>> +	if (node = MDESC_NODE_NULL) {
>> +		pr_info("No platform node\n");
> Is this an error, or does it just indicate that the watchdog is not supported
> ion this platform ? If it is an error, use pr_err(). If it means the watchdog is
> not supported, return without message.
ok, it should have platform, I think it's fair to assume not supported 
here as well.
>
>> +		err = -ENODEV;
>> +		goto out;
>> +	}
>> +
>> +	value = mdesc_get_property(handle, node, "watchdog-resolution", NULL);
>> +	if (value) {
>> +		resolution = *value;
>> +		pr_info("Platform watchdog-resolution [%llux]\n", *value);
>> +
>> +		if (resolution != 1000) {
>> +			pr_crit("Only 1000ms is supported.\n");
> Why is this critical ? Seems to be an implementation problem.
yeah ok fine.
>
>> +		pr_info("Platform watchdog-max-timeout [%ds]\n", max_timeout);
>> +
>> +		if (max_timeout < WDT_MIN_TIMEOUT) {
>> +			max_timeout = WDT_MIN_TIMEOUT;
>> +			pr_info("Setting max timeout to [%ds]\n", max_timeout);
>> +		}
> This is kind of odd. If the platform specifies a smaller maximum timeout
> than the pre-defined minimum, and you can just override that value,
> why care in the first place ?
Well -

there's a real max (WDT_MAX_TIMEOUT) for the platform
but as an admin you can specify your own max_timeout as a property of the
specific domain and set it smaller.

So if I where to set max_timeout to 500, it would be .5 seconds and that 
would be
messy.  So this really just means, if I, as an admin, specify a max 
timeout that's
less than 1 second, then set it to 1 second. That doesn't seem wrong.

>
> Also, WDT_MIN_TIMEOUT is 1 (second), meaning you would set the maximum
> timeout to 1 second, and the default timeout would end up being invalid.
> Can you try to define more reasonable acceptable limits ?
ok I that is fair, will change.
>
>> +
>> +		if (max_timeout > WDT_MAX_TIMEOUT) {
>> +			max_timeout = WDT_MAX_TIMEOUT;
>> +			pr_info("Setting max timeout to [%ds]\n", max_timeout);
> Is WDT_MAX_TIMEOUT an absolute or an arbitrary limit ?
absolute - largest value the hv call accepts.
>
> +}
> +
> +module_init(sun4v_wdt_init_module);
> +module_exit(sun4v_wdt_cleanup_module);
> Wonder if it would be better to move the initialization into the probe
> function and use module_patform_driver(), or module_platform_driver_probe().
> Any reason for not doing that ?
yeah ok I moved everything to that and it's a lot smaller now.

Will clean up and submit a new version soon - I also cleaned up 
time_remaining by
just passing NULL and modify the hvcall itself in the next rev.

thanks again. sorry for some of the silly mistakes :)

