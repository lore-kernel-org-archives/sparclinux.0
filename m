From: Daniel Hellstrom <daniel@gaisler.com>
Date: Fri, 25 Nov 2016 11:33:47 +0000
Subject: Re: [patch] sparc: leon: Fix a retry loop in leon_init_timers()
Message-Id: <eb1256e4-6377-6cf5-b4c5-9019ffe96f8a@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20161125112554.GG5938@mwanda>
In-Reply-To: <20161125112554.GG5938@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

It looks good.

Thanks!
/Daniel


On 2016-11-25 12:25, Dan Carpenter wrote:
> The original code causes a static checker warning because it has a
> continue inside a do { } while (0); loop.  In that context, a continue
> and a break are equivalent.  The intent was to go back to the start of
> the loop so the continue was a bug.
>
> I've added a retry label at the start and changed the continue to a goto
> retry.  Then I removed the do { } while (0) loop and pulled the code in
> one indent level.
>
> Fixes: 2791c1a43900 ("SPARC/LEON: added support for selecting Timer Core and Timer within core")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Not tested.
>
> diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
> index 33cd171..afcdd5e 100644
> --- a/arch/sparc/kernel/leon_kernel.c
> +++ b/arch/sparc/kernel/leon_kernel.c
> @@ -349,37 +349,37 @@ void __init leon_init_timers(void)
>   
>   	/* Find GPTIMER Timer Registers base address otherwise bail out. */
>   	nnp = rootnp;
> -	do {
> -		np = of_find_node_by_name(nnp, "GAISLER_GPTIMER");
> -		if (!np) {
> -			np = of_find_node_by_name(nnp, "01_011");
> -			if (!np)
> -				goto bad;
> -		}
>   
> -		ampopts = 0;
> -		pp = of_find_property(np, "ampopts", &len);
> -		if (pp) {
> -			ampopts = *(int *)pp->value;
> -			if (ampopts = 0) {
> -				/* Skip this instance, resource already
> -				 * allocated by other OS */
> -				nnp = np;
> -				continue;
> -			}
> +retry:
> +	np = of_find_node_by_name(nnp, "GAISLER_GPTIMER");
> +	if (!np) {
> +		np = of_find_node_by_name(nnp, "01_011");
> +		if (!np)
> +			goto bad;
> +	}
> +
> +	ampopts = 0;
> +	pp = of_find_property(np, "ampopts", &len);
> +	if (pp) {
> +		ampopts = *(int *)pp->value;
> +		if (ampopts = 0) {
> +			/* Skip this instance, resource already
> +			 * allocated by other OS */
> +			nnp = np;
> +			goto retry;
>   		}
> +	}
> +
> +	/* Select Timer-Instance on Timer Core. Default is zero */
> +	leon3_gptimer_idx = ampopts & 0x7;
>   
> -		/* Select Timer-Instance on Timer Core. Default is zero */
> -		leon3_gptimer_idx = ampopts & 0x7;
> -
> -		pp = of_find_property(np, "reg", &len);
> -		if (pp)
> -			leon3_gptimer_regs = *(struct leon3_gptimer_regs_map **)
> -						pp->value;
> -		pp = of_find_property(np, "interrupts", &len);
> -		if (pp)
> -			leon3_gptimer_irq = *(unsigned int *)pp->value;
> -	} while (0);
> +	pp = of_find_property(np, "reg", &len);
> +	if (pp)
> +		leon3_gptimer_regs = *(struct leon3_gptimer_regs_map **)
> +					pp->value;
> +	pp = of_find_property(np, "interrupts", &len);
> +	if (pp)
> +		leon3_gptimer_irq = *(unsigned int *)pp->value;
>   
>   	if (!(leon3_gptimer_regs && leon3_irqctrl_regs && leon3_gptimer_irq))
>   		goto bad;

