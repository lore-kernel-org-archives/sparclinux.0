From: Petr Mladek <pmladek@suse.com>
Date: Wed, 20 Apr 2016 13:49:14 +0000
Subject: Re: [PATCH v4 1/5] printk/nmi: generic solution for safe printk in NMI
Message-Id: <20160420134914.GK6862@pathway.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <1459353210-20260-1-git-send-email-pmladek@suse.com>
 <1459353210-20260-2-git-send-email-pmladek@suse.com>
 <20160404044928.GD6164@swordfish>
 <20160404093819.GH1023@pathway.suse.cz>
In-Reply-To: <20160404093819.GH1023@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon 2016-04-04 11:38:19, Petr Mladek wrote:
> On Mon 2016-04-04 13:49:28, Sergey Senozhatsky wrote:
> > Hello,
> > 
> > On (03/30/16 17:53), Petr Mladek wrote:
> > > +/*
> > > + * Flush data from the associated per_CPU buffer. The function
> > > + * can be called either via IRQ work or independently.
> > > + */
> > > +static void __printk_nmi_flush(struct irq_work *work)
> > > +{
> > > +	static raw_spinlock_t read_lock > > > +		__RAW_SPIN_LOCK_INITIALIZER(read_lock);
> > > +	struct nmi_seq_buf *s = container_of(work, struct nmi_seq_buf, work);
> > > +	unsigned long flags;
> > > +	size_t len, size;
> > > +	int i, last_i;
> > > +
> > > +	/*
> > > +	 * The lock has two functions. First, one reader has to flush all
> > > +	 * available message to make the lockless synchronization with
> > > +	 * writers easier. Second, we do not want to mix messages from
> > > +	 * different CPUs. This is especially important when printing
> > > +	 * a backtrace.
> > > +	 */
> > > +	raw_spin_lock_irqsave(&read_lock, flags);
> > > +
> > 
> > hm... so here we have
> > 	for (; i < size; i++)
> > 		printk()
> > 
> > under the spinlock. the thing is that one of printk() can end up
> > in console_unlock()->call_console_drivers() loop, iterating there
> > long enough to spinlock lockup other CPUs that might want to flush
> > NMI buffers (if any), assuming that there are enough printk() (or
> > may be a slow serial console) happening concurrently on other CPUs
> > to keep the current ->read_lock busy. async printk can help here,
> > but user can request sync version of printk.
> 
> I think that printk() is called on many other locations under
> a spinlock and they all are waiting for the async printk.
>
> > how about using deferred printk for nmi flush?
> > print_nmi_seq_line()->printk_deferred() ?

I thought more about it. printk_nmi_flush() is primary called
via irq work. If we use deferred printk() here we will just delay
the console stuff to another irq work.

If we use async printk from your patch set, it will unnecessary
create another irq work and delay the waking of the printk kthread.

If anyone forces sync printk, it will not help much. We will still
call console from the IRQ context and the potential flood of messages
still might cause a soft lookup.

Finally, as I already said. This is not different from any other
printk() call under a spinlock.

After all, I am going to use the normal printk() when flushing
the NMI buffers.

The only exception will be when this is called on panic in NMI
context. In this case, printk_deferred() will do exactly what
we need.

Best Regards,
Petr
