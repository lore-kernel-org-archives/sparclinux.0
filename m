From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date: Mon, 04 Apr 2016 04:49:28 +0000
Subject: Re: [PATCH v4 1/5] printk/nmi: generic solution for safe printk in NMI
Message-Id: <20160404044928.GD6164@swordfish>
List-Id: <sparclinux.vger.kernel.org>
References: <1459353210-20260-1-git-send-email-pmladek@suse.com>
 <1459353210-20260-2-git-send-email-pmladek@suse.com>
In-Reply-To: <1459353210-20260-2-git-send-email-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello,

On (03/30/16 17:53), Petr Mladek wrote:
[..]
> @@ -67,10 +67,12 @@ extern void irq_exit(void);
>  		preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);	\
>  		rcu_nmi_enter();				\
>  		trace_hardirq_enter();				\
> +		printk_nmi_enter();				\
>  	} while (0)
>  
>  #define nmi_exit()						\
>  	do {							\
> +		printk_nmi_exit();				\
>  		trace_hardirq_exit();				\
>  		rcu_nmi_exit();					\
>  		BUG_ON(!in_nmi());				\

isn't it a bit too early to printk_nmi_exit()? rcu_nmi_exit() can
WARN_ON_ONCE() in 3 places.

the same goes for printk_nmi_enter(). rcu_nmi_enter() can WARN_ON_ONCE().

seems that in both cases we can endup having WARN_ON_ONCE() from nmi,
but with default printk function.


> +/*
> + * Flush data from the associated per_CPU buffer. The function
> + * can be called either via IRQ work or independently.
> + */
> +static void __printk_nmi_flush(struct irq_work *work)
> +{
> +	static raw_spinlock_t read_lock > +		__RAW_SPIN_LOCK_INITIALIZER(read_lock);
> +	struct nmi_seq_buf *s = container_of(work, struct nmi_seq_buf, work);
> +	unsigned long flags;
> +	size_t len, size;
> +	int i, last_i;
> +
> +	/*
> +	 * The lock has two functions. First, one reader has to flush all
> +	 * available message to make the lockless synchronization with
> +	 * writers easier. Second, we do not want to mix messages from
> +	 * different CPUs. This is especially important when printing
> +	 * a backtrace.
> +	 */
> +	raw_spin_lock_irqsave(&read_lock, flags);
> +

hm... so here we have
	for (; i < size; i++)
		printk()

under the spinlock. the thing is that one of printk() can end up
in console_unlock()->call_console_drivers() loop, iterating there
long enough to spinlock lockup other CPUs that might want to flush
NMI buffers (if any), assuming that there are enough printk() (or
may be a slow serial console) happening concurrently on other CPUs
to keep the current ->read_lock busy. async printk can help here,
but user can request sync version of printk.

how about using deferred printk for nmi flush?
print_nmi_seq_line()->printk_deferred() ?

	-ss

> +	i = 0;
> +more:
> +	len = atomic_read(&s->len);
> +
> +	/*
> +	 * This is just a paranoid check that nobody has manipulated
> +	 * the buffer an unexpected way. If we printed something then
> +	 * @len must only increase.
> +	 */
> +	if (i && i >= len)
> +		pr_err("printk_nmi_flush: internal error: i=%d >= len=%zu\n",
> +		       i, len);
> +
> +	if (!len)
> +		goto out; /* Someone else has already flushed the buffer. */
> +
> +	/* Make sure that data has been written up to the @len */
> +	smp_rmb();
> +
> +	size = min(len, sizeof(s->buffer));
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
> +	raw_spin_unlock_irqrestore(&read_lock, flags);
> +}
