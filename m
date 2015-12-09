From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 09 Dec 2015 23:50:07 +0000
Subject: Re: [PATCH v3 1/4] printk/nmi: Generic solution for safe printk in NMI
Message-Id: <20151209155007.cab2f1afd7e76878a1733033@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1449667265-17525-1-git-send-email-pmladek@suse.com>
 <1449667265-17525-2-git-send-email-pmladek@suse.com>
In-Reply-To: <1449667265-17525-2-git-send-email-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed,  9 Dec 2015 14:21:02 +0100 Petr Mladek <pmladek@suse.com> wrote:

> printk() takes some locks and could not be used a safe way in NMI
> context.
> 
> The chance of a deadlock is real especially when printing
> stacks from all CPUs. This particular problem has been addressed
> on x86 by the commit a9edc8809328 ("x86/nmi: Perform a safe NMI stack
> trace on all CPUs").
> 
> This patch reuses most of the code and makes it generic. It is
> useful for all messages and architectures that support NMI.
> 
> The alternative printk_func is set when entering and is reseted when
> leaving NMI context. It queues IRQ work to copy the messages into
> the main ring buffer in a safe context.
> 
> __printk_nmi_flush() copies all available messages and reset
> the buffer. Then we could use a simple cmpxchg operations to
> get synchronized with writers. There is also used a spinlock
> to get synchronized with other flushers.
> 
> We do not longer use seq_buf because it depends on external lock.
> It would be hard to make all supported operations safe for
> a lockless use. It would be confusing and error prone to
> make only some operations safe.
> 
> The code is put into separate printk/nmi.c as suggested by
> Steven Rostedt. It needs a per-CPU buffer and is compiled only
> on architectures that call nmi_enter(). This is achieved by
> the new HAVE_NMI Kconfig flag.
> 
> One exception is arm where the deferred printing is used for
> printing backtraces even without NMI. For this purpose,
> we define NEED_PRINTK_NMI Kconfig flag. The alternative
> printk_func is explicitly set when IPI_CPU_BACKTRACE is
> handled.
> 
> The other exceptions are MN10300 and Xtensa architectures.
> We need to clean up NMI handling there first. Let's do it
> separately.
> 
> The patch is heavily based on the draft from Peter Zijlstra,
> see https://lkml.org/lkml/2015/6/10/327
> 

I guess this code is useful even on CONFIG_SMP=n: to avoid corruption
of the printk internal structures whcih the problematic locking
protects.

> ...
>
> +/*
> + * printk() could not take logbuf_lock in NMI context. Instead,
> + * it uses an alternative implementation that temporary stores
> + * the strings into a per-CPU buffer. The content of the buffer
> + * is later flushed into the main ring buffer via IRQ work.
> + *
> + * The alternative implementation is chosen transparently
> + * via @printk_func per-CPU variable.
> + *
> + * The implementation allows to flush the strings also from another CPU.
> + * There are situations when we want to make sure that all buffers
> + * were handled or when IRQs are blocked.
> + */
> +DEFINE_PER_CPU(printk_func_t, printk_func) = vprintk_default;
> +
> +#define NMI_LOG_BUF_LEN (4096 - sizeof(atomic_t) - sizeof(struct irq_work))
> +
> +struct nmi_seq_buf {
> +	atomic_t		len;	/* length of written data */
> +	struct irq_work		work;	/* IRQ work that flushes the buffer */
> +	unsigned char		buffer[NMI_LOG_BUF_LEN];

When this buffer overflows, which characters get lost?  Most recent or
least recent?

I'm not sure which is best, really.  For an oops trace you probably
want to preserve the least recent output: the stuff at the start of the
output.

> +};
>
> ...
>
> +static void __printk_nmi_flush(struct irq_work *work)
> +{
> +	static raw_spinlock_t read_lock > +		__RAW_SPIN_LOCK_INITIALIZER(read_lock);
> +	struct nmi_seq_buf *s = container_of(work, struct nmi_seq_buf, work);
> +	int len, size, i, last_i;
> +
> +	/*
> +	 * The lock has two functions. First, one reader has to flush all
> +	 * available message to make the lockless synchronization with
> +	 * writers easier. Second, we do not want to mix messages from
> +	 * different CPUs. This is especially important when printing
> +	 * a backtrace.
> +	 */
> +	raw_spin_lock(&read_lock);
> +
> +	i = 0;
> +more:
> +	len = atomic_read(&s->len);
> +
> +	/*
> +	 * This is just a paranoid check that nobody has manipulated
> +	 * the buffer an unexpected way. If we printed something then
> +	 * @len must only increase.
> +	 */
> +	WARN_ON(i && i >= len);

hm, dumping a big backtrace in this context seems a poor idea.  Oh
well, shouldn't happen.

> +	if (!len)
> +		goto out; /* Someone else has already flushed the buffer. */
> +
> +	/* Make sure that data has been written up to the @len */
> +	smp_rmb();
> +
> +	size = min_t(int, len, sizeof(s->buffer));

len and size should have type size_t.

> +	last_i = i;
> +
> +	/* Print line by line. */
> +	for (; i < size; i++) {
> +		if (s->buffer[i] = '\n') {
> +			print_nmi_seq_line(s, last_i, i);
> +			last_i = i + 1;
> +		}
> +	}
> +	/* Check if there was a partial line. */
> +	if (last_i < size) {
> +		print_nmi_seq_line(s, last_i, size - 1);
> +		pr_cont("\n");
> +	}
> +
> +	/*
> +	 * Check that nothing has got added in the meantime and truncate
> +	 * the buffer. Note that atomic_cmpxchg() is an implicit memory
> +	 * barrier that makes sure that the data were copied before
> +	 * updating s->len.
> +	 */
> +	if (atomic_cmpxchg(&s->len, len, 0) != len)
> +		goto more;
> +
> +out:
> +	raw_spin_unlock(&read_lock);
> +}
>
> ...
>
> --- /dev/null
> +++ b/kernel/printk/printk.h

I find it a bit irritating to have duplicated filenames.  We could
follow convention and call this "internal.h".

>
> ...
>

