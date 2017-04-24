From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date: Mon, 24 Apr 2017 02:17:47 +0000
Subject: Re: [PATCH v5 1/4] printk/nmi: generic solution for safe printk in NMI
Message-Id: <20170424021747.GA630@jagdpanzerIV.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-2-git-send-email-pmladek@suse.com>
 <20170419131341.76bc7634@gandalf.local.home>
 <20170420033112.GB542@jagdpanzerIV.localdomain>
 <20170420131154.GL3452@pathway.suse.cz>
 <20170421015724.GA586@jagdpanzerIV.localdomain>
 <20170421120627.GO3452@pathway.suse.cz>
In-Reply-To: <20170421120627.GO3452@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On (04/21/17 14:06), Petr Mladek wrote:
[..]
> > I agree that this_cpu_read(printk_context) covers slightly more than
> > logbuf_lock scope, so we may get positive this_cpu_read(printk_context)
> > with unlocked logbuf_lock, but I don't tend to think that it's a big
> > problem.
> 
> PRINTK_SAFE_CONTEXT is set also in call_console_drivers().
> It might take rather long and logbuf_lock is availe. So, it is
> noticeable source of false positives.

yes, agree.

probably we need additional printk_safe annotations for
		"logbuf_lock is locked from _this_ CPU"

false positives there can be very painful.

[..]
> 	if (raw_spin_is_locked(&logbuf_lock))
> 		this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);
> 	else
> 		this_cpu_or(printk_context, PRINTK_NMI_DEFERRED_CONTEXT_MASK);

well, if everyone is fine with logbuf_lock access from every CPU from every
NMI then I won't object either. but may be it makes sense to reduce the
possibility of false positives. Steven is loosing critically important logs,
after all.


by the way,
does this `nmi_print_seq' bypass even fix anything for Steven? it sort of
can, in theory, but just in theory. so may be we need direct message flush
from NMI handler (printk->console_unlock), which will be a really big problem.

logbuf might not be big enough for 4890096 messages (Steven's report
mentions "Lost 4890096 message(s)!"). we are counting on the fact that
in case of `nmi_print_seq' bypass some other CPU will call console_unlock()
and print pending logbuf messages, but this is not guaranteed and the
messages can be dropped even from logbuf.

I don't know,
should we try to queue printk_deferred irq_work for all online CPUs from
vprintk_nmi() when it bypasses printk_safe_log_store()? in order to minimize
possibilities of logbuf overflow. printk_deferred() will queue work on
vprintk_nmi() CPU, sure, but we don't know how many messages we are going
to add to logbuf from NMI.


> > @@ -303,7 +303,10 @@ static int vprintk_nmi(const char *fmt, va_list args)
> >  {
> >         struct printk_safe_seq_buf *s = this_cpu_ptr(&nmi_print_seq);
> >  
> > -       return printk_safe_log_store(s, fmt, args);
> > +       if (this_cpu_read(printk_context) & PRINTK_SAFE_CONTEXT_MASK)
> > +               return printk_safe_log_store(s, fmt, args);
> > +
> > +       return vprintk_emit(0, LOGLEVEL_SCHED, NULL, 0, fmt, args);
> >  }
> 
> It looks simple but some things are missing. It will be used also
> outside panic/oops, so it should queue the irq_work to flush the console.

you are right. I thought about moving irq_work to vprintk_emit(), but
completely forgot about it. without that missing bit the proposed two-liner
is not complete.

	-ss
