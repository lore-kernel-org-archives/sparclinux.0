From: David Miller <davem@davemloft.net>
Date: Tue, 22 May 2012 20:23:10 +0000
Subject: Re: [PATCH 2/5] sparc32: implement proper LEON support in head_32 (before highmem)
Message-Id: <20120522.162310.623781986131738923.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1337717443-11904-2-git-send-email-sam@ravnborg.org>
In-Reply-To: <1337717443-11904-2-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 22 May 2012 22:10:40 +0200

> Use PSR to check if the PCU is LEON and jump to
                          ^^^

"CPU" :-)

> +		/* Check if this is a LEON CPU */
> +		rd	%psr, %g3
> +		set	PSR_IMPL, %g2
> +		and	%g2, %g3, %g3
> +		srl	%g3, PSR_IMPL_SHIFT, %g3
> +		cmp	%g3, PSR_IMPL_LEON

I would code this like:

	rd	%psr, %g3
	srl	%g3, PSR_IMPL_SHIFT, %g3
	and	%g3, 0xf /* PST_IMPL_WHATEVER_MASK */, %g3
	cmp	%g3, PSR_IMPL_LEON


> +		/* Check for a viking (TI) module. */
> +		cmp	%g3, PSR_IMPL_TEXAS
> +		bne	srmmu_not_viking
>  		 nop

PSR_IMPL_TI is probably a better name fo this macro.

> @@ -313,6 +326,29 @@ srmmu_nviking:
>  		 nop					! wheee....
>  
>  
> +leon_remap:
> +		/* Sanity-check, is MMU enabled */
> +		lda	[%g0] ASI_LEON_MMUREGS, %g1
> +		andcc	%g1, 1, %g0
> +		be	halt_sun4_or_sun4c
> +		 nop

Checking that the MMU is disabled is correct, but branching
to the sun4c-not-supported error message is probably not. :-)

Otherwise looks OK.
