From: Pete Zaitcev <zaitcev@redhat.com>
Date: Mon, 09 Feb 2004 21:58:18 +0000
Subject: Re: RFC: [sparc32] Mask PIL in local_irq_xxx
Message-Id: <20040209135818.1b896426.zaitcev@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040208020239.GA24193@foobazco.org>
In-Reply-To: <20040208020239.GA24193@foobazco.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, 7 Feb 2004 18:02:39 -0800
Keith M Wesolowski <wesolows@foobazco.org> wrote:

> +#ifdef CONFIG_SMP
> +#define SMP_NOP2 "nop; nop;\n\t"
> +#define SMP_NOP3 "nop; nop; nop;\n\t"
> +#else
> +#define SMP_NOP2
> +#define SMP_NOP3
> +#endif /* SMP */

Nice touch.

> +/* XXX cli/sti -> local_irq_xxx here, check this works once SMP is fixed. */
>  void machine_halt(void)
>  {
> -	sti();
> +	local_irq_enable();
>  	mdelay(8);

You might want to consider if jailing would be appropriate. I seem to
remember that it cannot break through masked CPUs by design, but in
actuality our SMP IPI shouldn't either (which is what cli() is).

-- Pete
