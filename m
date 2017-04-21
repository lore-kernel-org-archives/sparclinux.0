From: Petr Mladek <pmladek@suse.com>
Date: Fri, 21 Apr 2017 12:06:27 +0000
Subject: Re: [PATCH v5 1/4] printk/nmi: generic solution for safe printk in NMI
Message-Id: <20170421120627.GO3452@pathway.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-2-git-send-email-pmladek@suse.com>
 <20170419131341.76bc7634@gandalf.local.home>
 <20170420033112.GB542@jagdpanzerIV.localdomain>
 <20170420131154.GL3452@pathway.suse.cz>
 <20170421015724.GA586@jagdpanzerIV.localdomain>
In-Reply-To: <20170421015724.GA586@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri 2017-04-21 10:57:25, Sergey Senozhatsky wrote:
> On (04/20/17 15:11), Petr Mladek wrote:
> [..]
> >  void printk_nmi_enter(void)
> >  {
> > -	this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);
> > +	/*
> > +	 * The size of the extra per-CPU buffer is limited. Use it
> > +	 * only when really needed.
> > +	 */
> > +	if (this_cpu_read(printk_context) & PRINTK_SAFE_CONTEXT_MASK ||
> > +	    raw_spin_is_locked(&logbuf_lock)) {
> > +		this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);
> > +	} else {
> > +		this_cpu_or(printk_context, PRINTK_NMI_DEFERRED_CONTEXT_MASK);
> > +	}
> >  }
> 
> well... the logbuf_lock can temporarily be locked from another CPU. I'd say
> that spin_is_locked() has better chances for false positive than
> this_cpu_read(printk_context). because this_cpu_read(printk_context) depends
> only on this CPU state, while spin_is_locked() depends on all CPUs. and the
> idea with this_cpu_read(printk_context) was that we check if the logbuf_lock
> was locked from this particular CPU.

I finally see the point. I confess that I did not think much about
this way yesterday because it looked too tricky (indirect) and possibly
error prone.

> I agree that this_cpu_read(printk_context) covers slightly more than
> logbuf_lock scope, so we may get positive this_cpu_read(printk_context)
> with unlocked logbuf_lock, but I don't tend to think that it's a big
> problem.

PRINTK_SAFE_CONTEXT is set also in call_console_drivers().
It might take rather long and logbuf_lock is availe. So, it is
noticeable source of false positives.

Hmm, my version actually checks both the lock and the context.
It is very deffensive to be always on the safe side.

We could get the best restults with both checks and by using "&&":

void printk_nmi_enter(void)
{
	/*
	 * The size of the extra per-CPU buffer is limited. Use it
	 * only when the lock for the main log buffer is not
	 * available.
	 *
	 * logbuf_lock might be taken on another CPU. But it must be
	 * in PRINTK_SAFE context. Reduce false positives by a check
	 * of the context.
	 */
	if (this_cpu_read(printk_context) & PRINTK_SAFE_CONTEXT_MASK ||
	    raw_spin_is_locked(&logbuf_lock)) {
		this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);
	} else {
		this_cpu_or(printk_context, PRINTK_NMI_DEFERRED_CONTEXT_MASK);
	}
}


But after all, I would prefer to keep it simple, strightforward,
and check only the logbuf_lock:

	if (raw_spin_is_locked(&logbuf_lock))
		this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);
	else
		this_cpu_or(printk_context, PRINTK_NMI_DEFERRED_CONTEXT_MASK);


> wouldn't something as simple as below do the trick?
> // absolutely and completely untested //
> 
> 
> diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
> index 033e50a7d706..c7477654c5b1 100644
> --- a/kernel/printk/printk_safe.c
> +++ b/kernel/printk/printk_safe.c
> @@ -303,7 +303,10 @@ static int vprintk_nmi(const char *fmt, va_list args)
>  {
>         struct printk_safe_seq_buf *s = this_cpu_ptr(&nmi_print_seq);
>  
> -       return printk_safe_log_store(s, fmt, args);
> +       if (this_cpu_read(printk_context) & PRINTK_SAFE_CONTEXT_MASK)
> +               return printk_safe_log_store(s, fmt, args);
> +
> +       return vprintk_emit(0, LOGLEVEL_SCHED, NULL, 0, fmt, args);
>  }

It looks simple but some things are missing. It will be used also
outside panic/oops, so it should queue the irq_work to flush the console.
Also the serialization of nmi_cpu_backtrace() backtrace calls is
needed.

All in all, we could get rid only of the extra
PRINTK_NMI_DEFERRED_CONTEXT_MASK with this approach. Other than
that it looks more tricky to me.

Sigh, I hate problems without the single best solution.

Best Regards,
Petr
