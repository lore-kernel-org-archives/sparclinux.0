From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 28 Oct 2012 07:13:32 +0000
Subject: Re: [PATCH 1/2] sparc64: Fix cpu strand yielding.
Message-Id: <20121028071332.GA3856@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20121028.021333.1563327700655419230.davem@davemloft.net>
In-Reply-To: <20121028.021333.1563327700655419230.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Davem.

Nitpick only.

On Sun, Oct 28, 2012 at 02:13:33AM -0400, David Miller wrote:
> 
> For atomic backoff, we just loop over an exponentially backed off
> counter.  This is extremely ineffective as it doesn't actually yield
> the cpu strand so that other competing strands can use the cpu core.
> 
> In cpus previous to SPARC-T4 we have to do this in a slightly hackish
> way, by doing an operation with no side effects that also happens to
> mark the strand as unavailable.
> 
> The mechanism we choose for this is three reads of the %ccr
> (condition-code) register into %g0 (the zero register).
> 
> SPARC-T4 has an explicit "pause" instruction, and we'll make use of
> that in a subsequent commit.
> 
> Yield strands also in cpu_relax().  We really should have done this a
> very long time ago.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
>  arch/sparc/include/asm/backoff.h      | 5 ++++-
>  arch/sparc/include/asm/processor_64.h | 5 ++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/sparc/include/asm/backoff.h b/arch/sparc/include/asm/backoff.h
> index db3af0d..64b077b 100644
> --- a/arch/sparc/include/asm/backoff.h
> +++ b/arch/sparc/include/asm/backoff.h
> @@ -13,7 +13,10 @@
>  

A small comment would be nice:

/* For atomic backoff, loop over an exponentially backed off
 * counter.
 */

>  #define BACKOFF_SPIN(reg, tmp, label)	\
>  	mov	reg, tmp; \
> -88:	brnz,pt	tmp, 88b; \
> +88:	rd	%ccr, %g0; \
> +	rd	%ccr, %g0; \
> +	rd	%ccr, %g0; \
> +	brnz,pt	tmp, 88b; \
>  	 sub	tmp, 1, tmp; \
>  	set	BACKOFF_LIMIT, tmp; \
>  	cmp	reg, tmp; \
> diff --git a/arch/sparc/include/asm/processor_64.h b/arch/sparc/include/asm/processor_64.h
> index 4e5a483..9865634 100644
> --- a/arch/sparc/include/asm/processor_64.h
> +++ b/arch/sparc/include/asm/processor_64.h
> @@ -196,7 +196,10 @@ extern unsigned long get_wchan(struct task_struct *task);
>  #define KSTK_EIP(tsk)  (task_pt_regs(tsk)->tpc)
>  #define KSTK_ESP(tsk)  (task_pt_regs(tsk)->u_regs[UREG_FP])
>  
> -#define cpu_relax()	barrier()
> +#define cpu_relax()	asm volatile("rd	%%ccr, %%g0\n\t" \
> +				     "rd	%%ccr, %%g0\n\t" \
> +				     "rd	%%ccr, %%g0" \
> +				     ::: "memory")

You could have cared to let the formatting match next patch so
we saw less changes in the follow-up patch.

	Sam
