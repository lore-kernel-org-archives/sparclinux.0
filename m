From: David Miller <davem@davemloft.net>
Date: Fri, 15 Jan 2016 20:21:05 +0000
Subject: Re: [PATCH] watchdog: add sun4v_wdt device support
Message-Id: <20160115.152105.516356843917298668.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1452640232-1165-1-git-send-email-wim.coekaerts@oracle.com>
In-Reply-To: <1452640232-1165-1-git-send-email-wim.coekaerts@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: wim.coekaerts@oracle.com
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org, sparclinux@vger.kernel.org

From: wim.coekaerts@oracle.com
Date: Tue, 12 Jan 2016 15:10:32 -0800

> +static int sun4v_wdt_stop(void)
> +{
> +	int err;
> +	unsigned long time_remaining;
> +
> +	spin_lock(&wdt_lock);
> +
> +        err = sun4v_mach_set_watchdog(0, &time_remaining);

There's a lot of lines like this last one which use spaces, instead of TAB
characters.  Please fix this up during your conversion to the watchdog
subsystem.

> +	err = sun4v_wdt_start();
> +	if (err = -EBUSY) {
> +		err = sun4v_wdt_kick();
> +	}

Single line basic blocks do not get curly braces.

> +	hp = mdesc_grab();

I don't see any mdesc_put() to release the machine description.
