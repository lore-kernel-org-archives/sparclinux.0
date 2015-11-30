From: yalin wang <yalin.wang2010@gmail.com>
Date: Mon, 30 Nov 2015 16:42:04 +0000
Subject: Re: [PATCH v2 5/5] printk/nmi: Increase the size of the temporary buffer
Message-Id: <81211733-2484-40A9-9D4A-644AA27FBC73@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1448622572-16900-1-git-send-email-pmladek@suse.com>
 <1448622572-16900-6-git-send-email-pmladek@suse.com>
In-Reply-To: <1448622572-16900-6-git-send-email-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


> On Nov 27, 2015, at 19:09, Petr Mladek <pmladek@suse.com> wrote:
> 
> Testing has shown that the backtrace sometimes does not fit
> into the 4kB temporary buffer that is used in NMI context.
> 
> The warnings are gone when I double the temporary buffer size.
> 
> Note that this problem existed even in the x86-specific
> implementation that was added by the commit a9edc8809328
> ("x86/nmi: Perform a safe NMI stack trace on all CPUs").
> Nobody noticed it because it did not print any warnings.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
> kernel/printk/nmi.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/printk/nmi.c b/kernel/printk/nmi.c
> index 8af1e4016719..6111644d5f01 100644
> --- a/kernel/printk/nmi.c
> +++ b/kernel/printk/nmi.c
> @@ -42,7 +42,7 @@ atomic_t nmi_message_lost;
> struct nmi_seq_buf {
> 	atomic_t		len;	/* length of written data */
> 	struct irq_work		work;	/* IRQ work that flushes the buffer */
> -	unsigned char		buffer[PAGE_SIZE - sizeof(atomic_t) -
> +	unsigned char		buffer[2 * PAGE_SIZE - sizeof(atomic_t) -
> 				       sizeof(struct irq_work)];
> };
> 

why not define like this:

union {
struct {atomic_t		len;	
	struct irq_work		work;
}
unsigned char		buffer[PAGE_SIZE * 2] ;
}

we can make sure the union is 2 PAGE_SIZE .

Thanks

