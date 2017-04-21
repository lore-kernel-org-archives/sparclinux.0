From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date: Fri, 21 Apr 2017 01:57:25 +0000
Subject: Re: [PATCH v5 1/4] printk/nmi: generic solution for safe printk in NMI
Message-Id: <20170421015724.GA586@jagdpanzerIV.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-2-git-send-email-pmladek@suse.com>
 <20170419131341.76bc7634@gandalf.local.home>
 <20170420033112.GB542@jagdpanzerIV.localdomain>
 <20170420131154.GL3452@pathway.suse.cz>
In-Reply-To: <20170420131154.GL3452@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello,

On (04/20/17 15:11), Petr Mladek wrote:
[..]
> Good analyze. I would summarize it that we need to be careful of:
> 
>   + logbug_lock
>   + PRINTK_SAFE_CONTEXT
>   + locks used by console drivers
> 
> The first two things are easy to check. Except that a check for logbuf_lock
> might produce false negatives. The last check is very hard.
> 
> > so at the moment what I can think of is something like
> > 
> >   -- check this_cpu_read(printk_context) in NMI prink
> > 
> > 	-- if we are NOT in printk_safe on this CPU, then do printk_deferred()
> > 	   and bypass `nmi_print_seq' buffer
> 
> I would add also a check for logbuf_lock.
> > 	-- if we are in printk_safe
> > 	  -- well... bad luck... have a bigger buffer.
> 
> Yup, we do the best effort while still trying to stay on the safe
> side.
> 
> I have cooked up a patch based on this. It uses printk_deferred()
> in NMI when it is safe. Note that console_flush_on_panic() will
> try to get them on the console when a kdump is not generated.
> I believe that it will help Steven.


OK. I need to look more at the patch. It does more than I'd expected/imagined.


[..]
>  void printk_nmi_enter(void)
>  {
> -	this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);
> +	/*
> +	 * The size of the extra per-CPU buffer is limited. Use it
> +	 * only when really needed.
> +	 */
> +	if (this_cpu_read(printk_context) & PRINTK_SAFE_CONTEXT_MASK ||
> +	    raw_spin_is_locked(&logbuf_lock)) {
> +		this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);
> +	} else {
> +		this_cpu_or(printk_context, PRINTK_NMI_DEFERRED_CONTEXT_MASK);
> +	}
>  }

well... the logbuf_lock can temporarily be locked from another CPU. I'd say
that spin_is_locked() has better chances for false positive than
this_cpu_read(printk_context). because this_cpu_read(printk_context) depends
only on this CPU state, while spin_is_locked() depends on all CPUs. and the
idea with this_cpu_read(printk_context) was that we check if the logbuf_lock
was locked from this particular CPU.

I agree that this_cpu_read(printk_context) covers slightly more than
logbuf_lock scope, so we may get positive this_cpu_read(printk_context)
with unlocked logbuf_lock, but I don't tend to think that it's a big
problem.


wouldn't something as simple as below do the trick?
// absolutely and completely untested //


diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 033e50a7d706..c7477654c5b1 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -303,7 +303,10 @@ static int vprintk_nmi(const char *fmt, va_list args)
 {
        struct printk_safe_seq_buf *s = this_cpu_ptr(&nmi_print_seq);
 
-       return printk_safe_log_store(s, fmt, args);
+       if (this_cpu_read(printk_context) & PRINTK_SAFE_CONTEXT_MASK)
+               return printk_safe_log_store(s, fmt, args);
+
+       return vprintk_emit(0, LOGLEVEL_SCHED, NULL, 0, fmt, args);
 }

	-ss
