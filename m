From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 23 Apr 2011 11:07:08 +0000
Subject: Re: [PATCH 2/3] sparc32,leon: operate on boot-cpu IRQ controller
Message-Id: <20110423110708.GB18446@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1303395625-6911-2-git-send-email-daniel@gaisler.com>
In-Reply-To: <1303395625-6911-2-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Apr 21, 2011 at 04:20:24PM +0200, Daniel Hellstrom wrote:
>  * proper initialization of boot_cpu_id (no hardcoding to 0)
>  * use boot_cpu_id index to address into the IRQ controller where
>    appropriate
> 
> Each CPU has a separate set of IRQ controller registers, this
> patch makes sure that the boot-cpu registers are used instead
> of CPU0's.
> 
> Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
> ---
>  arch/sparc/kernel/head_32.S     |   27 ++++++++++++---------------
>  arch/sparc/kernel/leon_kernel.c |   18 +++++++++---------
>  arch/sparc/kernel/leon_smp.c    |    1 -
>  3 files changed, 21 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/sparc/kernel/head_32.S b/arch/sparc/kernel/head_32.S
> index 520c615..5877857 100644
> --- a/arch/sparc/kernel/head_32.S
> +++ b/arch/sparc/kernel/head_32.S
> @@ -810,28 +810,25 @@ found_version:
>  got_prop:
>  #ifdef CONFIG_SPARC_LEON
>  	        /* no cpu-type check is needed, it is a SPARC-LEON */
> -#ifdef CONFIG_SMP
> -		ba leon_smp_init
> -		 nop
>  
> -		.global leon_smp_init
> -leon_smp_init:
> -		/* let boot_cpu_id default to 0 (master always 0) */
> +		sethi	%hi(boot_cpu_id), %g2	! boot-cpu index
>  
> -		rd     %asr17,%g1
> -		srl    %g1,28,%g1
> +#ifdef CONFIG_SMP
> +		ldub	[%g2 + %lo(boot_cpu_id)], %g1
> +		cmp	%g1, 0xff		! unset means first CPU
> +		bne	leon_smp_cpu_startup	! continue only with master
> +		 nop
> +#endif

It would be better to use a descriptive constant for 0xff here.
Which could then also e used where we init boot_cpu_id.

Also - I do not see that we need to put the four lines in an ifdef SMP block anymore,
as we always have boot_cpu_id available.

Other than that then t looks like a nice simplification.

	Sam
