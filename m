From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 22 Aug 2017 07:45:46 +0000
Subject: Re: [PATCH resend] timers: Fix excessive granularity of new timers after a nohz idle
Message-Id: <alpine.DEB.2.20.1708220842490.1869@nanos>
List-Id: <sparclinux.vger.kernel.org>
References: <20170822015439.11263-1-npiggin@gmail.com>
In-Reply-To: <20170822015439.11263-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, 22 Aug 2017, Nicholas Piggin wrote:
> I would have preferred to get comments from the timer maintainers, but
> they've been busy or away for the past copule of weeks. Perhaps you
> would consider carrying it until then?

Yes, I was on vacation, but that patch never hit my LKML inbox ....

> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index 8f5d1bf18854..dd7be9fe6839 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -203,6 +203,7 @@ struct timer_base {
>  	bool			migration_enabled;
>  	bool			nohz_active;
>  	bool			is_idle;
> +	bool			was_idle; /* was it idle since last run/fwded */

Please do not use tail comments. They are a horrible habit and disturb the
reading flow. I'm not fond of that name either. Something like forward_clk
or a similar self explaining name would be appreciated.

>  	/*
> @@ -938,6 +945,13 @@ __mod_timer(struct timer_list *timer, unsigned long expires, bool pending_only)
>  	 * same array bucket then just return:
>  	 */
>  	if (timer_pending(timer)) {
> +		/*
> +		 * The downside of this optimization is that it can result in
> +		 * larger granularity than you would get from adding a new
> +		 * timer with this expiry. Would a timer flag for networking
> +		 * be appropriate, then we can try to keep expiry of general
> +		 * timers within ~1/8th of their interval?

This really depends on the timer usage type.

If you use it merily for TCP timeouts or similar things, then this does not
matter at all because then the timer is the safety net in case something
goes wrong. If you lose packets on the transport the larger granularity is
the least of your worries.

From earlier discussions with the networking folks these timeouts are the
reason for this optimization because you avoid the expensive
dequeue/requeue operation if the successful communication is fast.

If the timer has a short relative expiry and is used for sending packets or
similar purposes, then it usually sits in the first bucket and has no
granularity issues anyway. But from staring at trace data provided by
google and facebook these timer are not rearmed while pending, they fire,
do networking stuff and then get rearmed.

So I rather avoid that kind of misleading comment. The first sentence
surely can stay.

Other than that, nice detective work!

Thanks,

	tglx
