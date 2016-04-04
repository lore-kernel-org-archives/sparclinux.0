From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date: Mon, 04 Apr 2016 04:56:30 +0000
Subject: Re: [PATCH v4 2/5] printk/nmi: use IRQ work only when ready
Message-Id: <20160404045629.GF6164@swordfish>
List-Id: <sparclinux.vger.kernel.org>
References: <1459353210-20260-1-git-send-email-pmladek@suse.com>
 <1459353210-20260-3-git-send-email-pmladek@suse.com>
In-Reply-To: <1459353210-20260-3-git-send-email-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello,

On (03/30/16 17:53), Petr Mladek wrote:
> NMIs could happen at any time.  This patch makes sure that the safe
> printk() in NMI will schedule IRQ work only when the related structs are
> initialized.
> 
> All pending messages are flushed when the IRQ work is being initialized.

so, does this patch 'fix' 0001 (in a way)? shouldn't it then be folded?
sorry if I'm missing something.

	-ss

>  DEFINE_PER_CPU(printk_func_t, printk_func) = vprintk_default;
> +static int printk_nmi_irq_ready;
>  
>  #define NMI_LOG_BUF_LEN (4096 - sizeof(atomic_t) - sizeof(struct irq_work))
>  
> @@ -84,8 +85,11 @@ again:
>  		goto again;
>  
>  	/* Get flushed in a more safe context. */
> -	if (add)
> +	if (add && printk_nmi_irq_ready) {
> +		/* Make sure that IRQ work is really initialized. */
> +		smp_rmb();
>  		irq_work_queue(&s->work);
> +	}
>  
>  	return add;
>  }
> @@ -195,6 +199,13 @@ void __init printk_nmi_init(void)
>  
>  		init_irq_work(&s->work, __printk_nmi_flush);
>  	}
> +
> +	/* Make sure that IRQ works are initialized before enabling. */
> +	smp_wmb();
> +	printk_nmi_irq_ready = 1;
> +
> +	/* Flush pending messages that did not have scheduled IRQ works. */
> +	printk_nmi_flush();
>  }
