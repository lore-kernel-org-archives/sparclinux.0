From: Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 02 Dec 2015 02:45:16 +0000
Subject: Re: [PATCH v2 1/5] printk/nmi: Generic solution for safe printk in NMI
Message-Id: <1449024316.11810.6.camel@ellerman.id.au>
List-Id: <sparclinux.vger.kernel.org>
References: <1448622572-16900-1-git-send-email-pmladek@suse.com>
 <1448622572-16900-2-git-send-email-pmladek@suse.com>
In-Reply-To: <1448622572-16900-2-git-send-email-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, 2015-11-27 at 12:09 +0100, Petr Mladek wrote:

> printk() takes some locks and could not be used a safe way in NMI
> context.
> 
> The chance of a deadlock is real especially when printing
> stacks from all CPUs. This particular problem has been addressed
> on x86 by the commit a9edc8809328 ("x86/nmi: Perform a safe NMI stack
> trace on all CPUs").

...

> diff --git a/kernel/printk/nmi.c b/kernel/printk/nmi.c
> new file mode 100644
> index 000000000000..3989e13a0021
> --- /dev/null
> +++ b/kernel/printk/nmi.c
> @@ -0,0 +1,200 @@

...

> +
> +struct nmi_seq_buf {
> +	atomic_t		len;	/* length of written data */
> +	struct irq_work		work;	/* IRQ work that flushes the buffer */
> +	unsigned char		buffer[PAGE_SIZE - sizeof(atomic_t) -
> +				       sizeof(struct irq_work)];
> +};
> +static DEFINE_PER_CPU(struct nmi_seq_buf, nmi_print_seq);


PAGE_SIZE isn't always 4K.

On typical powerpc systems this will give you 128K, and on some 512K, which is
probably not what we wanted.

The existing code just did:

#define NMI_BUF_SIZE           4096

So I think you should just go back to doing that.

cheers

