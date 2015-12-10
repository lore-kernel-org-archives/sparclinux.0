From: Petr Mladek <pmladek@suse.com>
Date: Thu, 10 Dec 2015 15:26:06 +0000
Subject: Re: [PATCH v3 1/4] printk/nmi: Generic solution for safe printk in NMI
Message-Id: <20151210152606.GD2946@pathway.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <1449667265-17525-1-git-send-email-pmladek@suse.com>
 <1449667265-17525-2-git-send-email-pmladek@suse.com>
 <20151209155007.cab2f1afd7e76878a1733033@linux-foundation.org>
In-Reply-To: <20151209155007.cab2f1afd7e76878a1733033@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed 2015-12-09 15:50:07, Andrew Morton wrote:
> On Wed,  9 Dec 2015 14:21:02 +0100 Petr Mladek <pmladek@suse.com> wrote:
> 
> > printk() takes some locks and could not be used a safe way in NMI
> > context.
> > 
> > The chance of a deadlock is real especially when printing
> > stacks from all CPUs. This particular problem has been addressed
> > on x86 by the commit a9edc8809328 ("x86/nmi: Perform a safe NMI stack
> > trace on all CPUs").
> > 
> > This patch reuses most of the code and makes it generic. It is
> > useful for all messages and architectures that support NMI.
> > 
> > The patch is heavily based on the draft from Peter Zijlstra,
> > see https://lkml.org/lkml/2015/6/10/327
> > 
> 
> I guess this code is useful even on CONFIG_SMP=n: to avoid corruption
> of the printk internal structures whcih the problematic locking
> protects.

Yup and it is used even on CONFIG_SMP=n if I am not missing
something. At least, CONFIG_PRINTK_NMI stays enabled here.


> > +#define NMI_LOG_BUF_LEN (4096 - sizeof(atomic_t) - sizeof(struct irq_work))
> > +
> > +struct nmi_seq_buf {
> > +	atomic_t		len;	/* length of written data */
> > +	struct irq_work		work;	/* IRQ work that flushes the buffer */
> > +	unsigned char		buffer[NMI_LOG_BUF_LEN];
> 
> When this buffer overflows, which characters get lost?  Most recent or
> least recent?

The most recent messages are lost when the buffer overflows. The other
way would require to use a ring-buffer instead the seq_buf. We would need
a lock-less synchronization for both, begin and end, pointers. It
would add quite some complications.


> I'm not sure which is best, really.  For an oops trace you probably
> want to preserve the least recent output: the stuff at the start of the
> output.

I agree. Fortunately, this is easier and it works this way.


> > +static void __printk_nmi_flush(struct irq_work *work)
> > +{
> > +	static raw_spinlock_t read_lock > > +		__RAW_SPIN_LOCK_INITIALIZER(read_lock);
> > +	struct nmi_seq_buf *s = container_of(work, struct nmi_seq_buf, work);
> > +	int len, size, i, last_i;
> > +
> > +	/*
> > +	 * The lock has two functions. First, one reader has to flush all
> > +	 * available message to make the lockless synchronization with
> > +	 * writers easier. Second, we do not want to mix messages from
> > +	 * different CPUs. This is especially important when printing
> > +	 * a backtrace.
> > +	 */
> > +	raw_spin_lock(&read_lock);
> > +
> > +	i = 0;
> > +more:
> > +	len = atomic_read(&s->len);
> > +
> > +	/*
> > +	 * This is just a paranoid check that nobody has manipulated
> > +	 * the buffer an unexpected way. If we printed something then
> > +	 * @len must only increase.
> > +	 */
> > +	WARN_ON(i && i >= len);
> 
> hm, dumping a big backtrace in this context seems a poor idea.  Oh
> well, shouldn't happen.

I see and the backtrace probably would not help much because "len"
might be manipulated also from NMI context. I am going to change
this to:

	if (i && i >= len)
		pr_err("printk_nmi_flush: internal error: i=%d >		len=%d)\n", i, len);



> > +	if (!len)
> > +		goto out; /* Someone else has already flushed the buffer. */
> > +
> > +	/* Make sure that data has been written up to the @len */
> > +	smp_rmb();
> > +
> > +	size = min_t(int, len, sizeof(s->buffer));
> 
> len and size should have type size_t.

OK

> > --- /dev/null
> > +++ b/kernel/printk/printk.h
> 
> I find it a bit irritating to have duplicated filenames.  We could
> follow convention and call this "internal.h".

No problem. I am going to send an updated patchset soon.

Thanks a lot for review,
Petr
