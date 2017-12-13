From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 13 Dec 2017 22:47:00 +0000
Subject: Re: [PATCH] sparc32,leon: Use CASA when available for atomic operations
Message-Id: <20171213224700.GA25963@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1513004290-3331-1-git-send-email-andreas@gaisler.com>
In-Reply-To: <1513004290-3331-1-git-send-email-andreas@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andreas Larsson <andreas@gaisler.com>
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, software@gaisler.com

Hi Andreas.

On Mon, Dec 11, 2017 at 03:58:10PM +0100, Andreas Larsson wrote:
> This probes for CASA support, that is commonly present in LEON
> processors, and when available, uses the CASA instruction for atomic
> operations rather than the spinlock based emulated atomic operations.
> 
> All CASA instructions are encoded using .word to be able to assemble
> for v8.

The patch mixes several things, so parts was not easy to follow.
It would have been much better if, based on the dynamic probing,
to replace relevant assembler parts with the relevant implementation.
So we avoid the check for sparc32_cas_capable in all the atomic_*
functions.

And the end result would most likely also be a more readable/simple
implementation.

And the end result could look like:
PATCH 1 - preparation
PATCH 2 - infrastructure
PATCH 3 - assembler version ready for patching
PATCH 4 - cas varaints - unused
PATCH 5 - detection and patching

Just to give you an idea.

You have most of the necessary bits in place already.
So most is code shuffelign and creating assembler versions
ready for patching.

You already have nice macros that avoids a lot of code duplication,
and this principle can be reused following the scheme outlined above.

An open question. There is a long-standing issue in glibc where
sparc32 does not support threading (IIRC). It had to do with
missing atomic support, which had to be emulated in the
kernel.
Will this patch move us closer to have that fixed?

	Sam


> diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
> index 358fe4e..d57dfe6 100644
> --- a/arch/sparc/kernel/entry.S
> +++ b/arch/sparc/kernel/entry.S
> @@ -439,6 +439,10 @@ bad_instruction:
>  	and	%l5, %l4, %l5
>  	cmp	%l5, %l7
>  	be	1f
> +	 sethi	%hi(leon_cas_check), %l4
> +	or	%l4, %lo(leon_cas_check), %l4
> +	cmp	%l1, %l4
> +	be	1f
>  	SAVE_ALL
Here a nop is missing in the delay slot after "be  1f"


>  
>  	wr	%l0, PSR_ET, %psr		! re-enable traps
> @@ -452,7 +456,7 @@ bad_instruction:
>  
>  	RESTORE_ALL
>  
> -1:	/* unimplemented flush - just skip */
> +1:	/* unimplemented flush or probed CASA - just skip */
>  	jmpl	%l2, %g0
>  	 rett	%l2 + 4
>  
> diff --git a/arch/sparc/kernel/head_32.S b/arch/sparc/kernel/head_32.S
> index e55f2c0..72a57af 100644
> --- a/arch/sparc/kernel/head_32.S
> +++ b/arch/sparc/kernel/head_32.S
> @@ -441,6 +441,14 @@ leon_init:
>  		/* Update boot_cpu_id only on boot cpu */
>  		stub	%g1, [%g2 + %lo(boot_cpu_id)]
>  
> +		/* Check if CASA is supported */
> +		set	sparc32_cas_capable, %g1
> +		mov	1, %g2
> +
> +		.global	leon_cas_check
> +leon_cas_check:
> +		.word	0xc5e04160 /* casa [%g1] 0xb, %g0, %g2 */
> +
>  		ba continue_boot
>  		 nop

I could not follow this code-snippet.
Maybe this is my ignorance of the casa instruction.
Will it store the value of %g2 (=1) in the address pointed
by %g1 (sparc32_cas_capable) if casa is enabled?
Maybe it is obvious for others, but it ws not for me.
So one or two comments more...

	Sam
