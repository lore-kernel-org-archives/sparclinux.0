From: Petr Mladek <pmladek@suse.com>
Date: Thu, 27 Apr 2017 13:38:19 +0000
Subject: Re: [PATCH v5 1/4] printk/nmi: generic solution for safe printk in NMI
Message-Id: <20170427133819.GW3452@pathway.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-2-git-send-email-pmladek@suse.com>
 <20170419131341.76bc7634@gandalf.local.home>
 <20170420033112.GB542@jagdpanzerIV.localdomain>
 <20170420131154.GL3452@pathway.suse.cz>
 <20170421015724.GA586@jagdpanzerIV.localdomain>
 <20170421120627.GO3452@pathway.suse.cz>
 <20170424021747.GA630@jagdpanzerIV.localdomain>
In-Reply-To: <20170424021747.GA630@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon 2017-04-24 11:17:47, Sergey Senozhatsky wrote:
> On (04/21/17 14:06), Petr Mladek wrote:
> [..]
> > > I agree that this_cpu_read(printk_context) covers slightly more than
> > > logbuf_lock scope, so we may get positive this_cpu_read(printk_context)
> > > with unlocked logbuf_lock, but I don't tend to think that it's a big
> > > problem.
> > 
> > PRINTK_SAFE_CONTEXT is set also in call_console_drivers().
> > It might take rather long and logbuf_lock is availe. So, it is
> > noticeable source of false positives.
> 
> yes, agree.
> 
> probably we need additional printk_safe annotations for
> 		"logbuf_lock is locked from _this_ CPU"
> 
> false positives there can be very painful.
> 
> [..]
> > 	if (raw_spin_is_locked(&logbuf_lock))
> > 		this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);
> > 	else
> > 		this_cpu_or(printk_context, PRINTK_NMI_DEFERRED_CONTEXT_MASK);
> 
> well, if everyone is fine with logbuf_lock access from every CPU from every
> NMI then I won't object either. but may be it makes sense to reduce the
> possibility of false positives. Steven is loosing critically important logs,
> after all.
> 
> 
> by the way,
> does this `nmi_print_seq' bypass even fix anything for Steven?

I think that this is the most important question.

Steven, does the patch from
https://lkml.kernel.org/r/20170420131154.GL3452@pathway.suse.cz
help you to see the debug messages, please?


> it sort of
> can, in theory, but just in theory. so may be we need direct message flush
> from NMI handler (printk->console_unlock), which will be a really big problem.

I thought about it a lot and got scared where this might go.
We need to balance the usefulness and the complexity of the solution.

It took one year to discover this regression. Before it was
suggested to avoid calling printk() in NMI context at all.
Now, we are trying to fix printk() to handle MBs of messages
in NMI context.

If my proposed patch solves the problem for Steven, I would still
like to get similar solution in. It is not that complex and helps
to bypass the limited per-CPU buffer in most cases. I always thought
that 8kB might be not enough in some cases.

Note that my patch is very defensive. It uses the main log buffer
only when it is really safe. It has higher potential for unneeded
fallback but if it works for Steven (really existing usecase), ...

On the other hand, I would prefer to avoid any much more complex
solution until we have a real reports that they are needed.

Also we need to look for alternatives. There is a chance
to create crashdump and get the ftrace messages from it.
Also this might be scenario when we might need to suggest
the early_printk() patchset from Peter Zijlstra.


> logbuf might not be big enough for 4890096 messages (Steven's report
> mentions "Lost 4890096 message(s)!"). we are counting on the fact that
> in case of `nmi_print_seq' bypass some other CPU will call console_unlock()
> and print pending logbuf messages, but this is not guaranteed and the
> messages can be dropped even from logbuf.

Yup. I tested the patch here and I needed to increase the main log buffer
size to see all ftrace messages. Fortunately, it was possible to use a really
huge global buffer. But it is not realistic to use huge per-CPU ones.

Best Regards,
Petr
