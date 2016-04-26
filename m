From: Petr Mladek <pmladek@suse.com>
Date: Tue, 26 Apr 2016 14:21:57 +0000
Subject: Re: [PATCH v5 4/4] printk/nmi: flush NMI messages on the system panic
Message-Id: <20160426142157.GK2749@pathway.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-5-git-send-email-pmladek@suse.com>
 <20160423034924.GA535@swordfish>
In-Reply-To: <20160423034924.GA535@swordfish>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sat 2016-04-23 12:49:24, Sergey Senozhatsky wrote:
> Hello Petr,
> 
> On (04/21/16 13:48), Petr Mladek wrote:
> >  extern void printk_nmi_flush(void);
> > +extern void printk_nmi_flush_on_panic(void);
> >  #else
> >  static inline void printk_nmi_flush(void) { }
> > +static inline void printk_nmi_flush_on_panic(void) { }
> [..]
> > +void printk_nmi_flush_on_panic(void)
> > +{
> > +	/*
> > +	 * Make sure that we could access the main ring buffer.
> > +	 * Do not risk a double release when more CPUs are up.
> > +	 */
> > +	if (in_nmi() && raw_spin_is_locked(&logbuf_lock)) {
> > +		if (num_online_cpus() > 1)
> > +			return;
> > +
> > +		debug_locks_off();
> > +		raw_spin_lock_init(&logbuf_lock);
> > +	}
> > +
> > +	printk_nmi_flush();
> > +}
> [..]
> > -static DEFINE_RAW_SPINLOCK(logbuf_lock);
> > +DEFINE_RAW_SPINLOCK(logbuf_lock);
> 
> just an idea,
> 
> how about doing it a bit differently?
> 
> 
> move printk_nmi_flush_on_panic() to printk.c, and place it next to
> printk_flush_on_panic() (so we will have two printk "flush-on-panic"
> functions sitting together). /* printk_nmi_flush() is in printk.h,
> so it's visible to printk anyway */
> 
> it also will let us keep logbuf_lock static, it's a bit too internal
> to printk to expose it, I think.
> 
> IOW, something like this?

It is rather cosmetic change. I 

> ---
> 
>  kernel/printk/internal.h |  2 --
>  kernel/printk/nmi.c      | 27 ---------------------------
>  kernel/printk/printk.c   | 29 ++++++++++++++++++++++++++++-
>  3 files changed, 28 insertions(+), 30 deletions(-)
> 
> diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
> index 7fd2838..341bedc 100644
> --- a/kernel/printk/internal.h
> +++ b/kernel/printk/internal.h
> @@ -22,8 +22,6 @@ int __printf(1, 0) vprintk_default(const char *fmt, va_list args);
>  
>  #ifdef CONFIG_PRINTK_NMI
>  
> -extern raw_spinlock_t logbuf_lock;

Well, it was exposed only in the internal.h header file. I consider
this rather a cosmetic change and do not have strong opinion about it. :-)

Anyway, thanks a lot for review.

Best Regards,
Petr
