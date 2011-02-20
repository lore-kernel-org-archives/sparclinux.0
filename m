From: Josip Rodin <joy@entuzijast.net>
Date: Sun, 20 Feb 2011 21:30:05 +0000
Subject: Re: [PATCH 5/5] sparc32: genirq support
Message-Id: <20110220213005.GA31886@entuzijast.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1298234400-22378-5-git-send-email-sam@ravnborg.org>
In-Reply-To: <1298234400-22378-5-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Feb 20, 2011 at 09:40:00PM +0100, Sam Ravnborg wrote:
> --- a/arch/sparc/kernel/pcic.c
> +++ b/arch/sparc/kernel/pcic.c

> -static void pcic_load_profile_irq(int cpu, unsigned int limit)
> +static unsigned int pcic_startup_irq(struct irq_data *data)
>  {
> -	printk("PCIC: unimplemented code: FILE=%s LINE=%d", __FILE__, __LINE__);
> +	irq_link(data->irq);
> +	pcic_unmask_irq(data);
> +	return 0;
>  }

> -static void pcic_enable_pil_irq(unsigned int pil)
> +
> +static void pcic_load_profile_irq(int cpu, unsigned int limit)
>  {
> -	writel(get_irqmask(pil), pcic0.pcic_regs+PCI_SYS_INT_TARGET_MASK_CLEAR);
> +	printk("PCIC: unimplemented code: FILE=%s LINE=%d", __FILE__, __LINE__);
>  }

So, continuing on my previous line of nitpicking :) you could also rearrange
these two a bit, so they don't clutter up the diff like this.

> --- a/arch/sparc/kernel/sun4d_irq.c
> +++ b/arch/sparc/kernel/sun4d_irq.c

> -int sun4d_request_irq(unsigned int irq,
> +static void sun4d_mask_irq(struct irq_data *data)

> -static void sun4d_disable_irq(unsigned int irq)
> +static void sun4d_unmask_irq(struct irq_data *data)

> -static void sun4d_enable_irq(unsigned int irq)
> +/* XXX Do we need shutdown too for sun4d? */
> +static unsigned int sun4d_startup_irq(struct irq_data *data)

Also possibly rearrange these two pairs, so that the
sun4d_mask_irq/sun4d_disable_irq and sun4d_unmask_irq/sun4d_enable_irq
diffs are shown, which would seem to be logical, if I read this right.

> --- a/arch/sparc/kernel/sun4m_irq.c
> +++ b/arch/sparc/kernel/sun4m_irq.c

> -static unsigned long sun4m_get_irqmask(unsigned int irq)
> +static void sun4m_mask_irq(struct irq_data *data)

> -static void sun4m_disable_irq(unsigned int irq_nr)
> +static void sun4m_unmask_irq(struct irq_data *data)

> -static void sun4m_enable_irq(unsigned int irq_nr)

Here too, you probably want us to see the diff
sun4m_disable_irq vs. sun4m_mask_irq, and then
sun4m_enable_irq vs. sun4m_unmask_irq, rather than this.

-- 
     2. That which causes joy or happiness.
