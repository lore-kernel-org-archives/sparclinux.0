From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 28 Oct 2012 07:19:41 +0000
Subject: Re: [PATCH 2/2] sparc64: Use pause instruction when available.
Message-Id: <20121028071941.GA3865@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20121028.021353.459456106731235403.davem@davemloft.net>
In-Reply-To: <20121028.021353.459456106731235403.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Davem.

Small nitpicks only.

On Sun, Oct 28, 2012 at 02:13:53AM -0400, David Miller wrote:
> 
> In atomic backoff and cpu_relax(), use the pause instruction
> found on SPARC-T4 and later.
> 
> It makes the cpu strand unselectable for the given number of
> cycles, unless an intervening disrupting trap occurs.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
>  arch/sparc/include/asm/backoff.h      | 32 +++++++++++++++++++-------------
>  arch/sparc/include/asm/processor_64.h | 13 ++++++++++---
>  arch/sparc/kernel/entry.h             |  7 +++++++
>  arch/sparc/kernel/setup_64.c          | 21 +++++++++++++++++++++
>  arch/sparc/kernel/vmlinux.lds.S       |  5 +++++
>  5 files changed, 62 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/sparc/include/asm/backoff.h b/arch/sparc/include/asm/backoff.h
> index 64b077b..20f01df 100644
> --- a/arch/sparc/include/asm/backoff.h
> +++ b/arch/sparc/include/asm/backoff.h
> @@ -11,19 +11,25 @@
>  #define BACKOFF_LABEL(spin_label, continue_label) \
>  	spin_label
>  
> -#define BACKOFF_SPIN(reg, tmp, label)	\
> -	mov	reg, tmp; \
> -88:	rd	%ccr, %g0; \
> -	rd	%ccr, %g0; \
> -	rd	%ccr, %g0; \
> -	brnz,pt	tmp, 88b; \
> -	 sub	tmp, 1, tmp; \
> -	set	BACKOFF_LIMIT, tmp; \
> -	cmp	reg, tmp; \
> -	bg,pn	%xcc, label; \
> -	 nop; \
> -	ba,pt	%xcc, label; \
> -	 sllx	reg, 1, reg;

The use of a few spaces would help identify what is patched.

> +#define BACKOFF_SPIN(reg, tmp, label)		\
> +	mov		reg, tmp;		\
> +88:	rd		%ccr, %g0;		\
> +	rd		%ccr, %g0;		\
> +	rd		%ccr, %g0;		\
> +	.section	.pause_patch,"ax";	\
> +	.word		88b;			\
> +	sllx		tmp, 7, tmp;		\
> +	wr		tmp, 0, %asr27;		\
> +	clr		tmp;			\
> +	.previous;				\
> +	brnz,pt		tmp, 88b;		\
> +	 sub		tmp, 1, tmp;		\
> +	set		BACKOFF_LIMIT, tmp;	\
> +	cmp		reg, tmp;		\
> +	bg,pn		%xcc, label;		\
> +	 nop;					\
> +	ba,pt		%xcc, label;		\
> +	 sllx		reg, 1, reg;
>  
>  #else
>  

Again - a few empty lines would help see what is patched.
> +#define cpu_relax()	asm volatile("\n99:\n\t"			\
> +				     "rd	%%ccr, %%g0\n\t"	\
> +				     "rd	%%ccr, %%g0\n\t"	\
> +				     "rd	%%ccr, %%g0\n\t"	\
> +				     ".section	.pause_patch,\"ax\"\n\t"\
> +				     ".word	99b\n\t"		\
> +				     "wr	%%g0, 128, %%asr27\n\t"	\
> +				     "nop\n\t"				\
> +				     "nop\n\t"				\
> +				     ".previous"			\
>  				     ::: "memory")
>  
>  /* Prefetch support.  This is tuned for UltraSPARC-III and later.
> diff --git a/arch/sparc/kernel/entry.h b/arch/sparc/kernel/entry.h
> index 0c218e4..51742df 100644
> --- a/arch/sparc/kernel/entry.h
> +++ b/arch/sparc/kernel/entry.h
> @@ -59,6 +59,13 @@ struct popc_6insn_patch_entry {
>  extern struct popc_6insn_patch_entry __popc_6insn_patch,
>  	__popc_6insn_patch_end;
>  
> +struct pause_patch_entry {
> +	unsigned int	addr;
> +	unsigned int	insns[3];
> +};
> +extern struct pause_patch_entry __pause_patch,
> +	__pause_patch_end;
> +
>  extern void __init per_cpu_patch(void);
>  extern void sun4v_patch_1insn_range(struct sun4v_1insn_patch_entry *,
>  				    struct sun4v_1insn_patch_entry *);
> diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
> index 0800e71..b45cff4 100644
> --- a/arch/sparc/kernel/setup_64.c
> +++ b/arch/sparc/kernel/setup_64.c
> @@ -316,6 +316,25 @@ static void __init popc_patch(void)
>  	}
>  }
>  
> +static void __init pause_patch(void)
> +{
> +	struct pause_patch_entry *p;
> +
> +	p = &__pause_patch;
> +	while (p < &__pause_patch_end) {
> +		unsigned long i, addr = p->addr;
> +
> +		for (i = 0; i < 3; i++) {
> +			*(unsigned int *) (addr +  (i * 4)) = p->insns[i];
> +			wmb();
> +			__asm__ __volatile__("flush	%0"
> +					     : : "r" (addr +  (i * 4)));
> +		}
> +
> +		p++;
> +	}
> +}
> +
>  #ifdef CONFIG_SMP
>  void __init boot_cpu_id_too_large(int cpu)
>  {
> @@ -528,6 +547,8 @@ static void __init init_sparc64_elf_hwcap(void)
>  
>  	if (sparc64_elf_hwcap & AV_SPARC_POPC)
>  		popc_patch();
> +	if (sparc64_elf_hwcap & AV_SPARC_PAUSE)
> +		pause_patch();
>  }
>  
>  void __init setup_arch(char **cmdline_p)
> diff --git a/arch/sparc/kernel/vmlinux.lds.S b/arch/sparc/kernel/vmlinux.lds.S
> index 89c2c29..847f9f7 100644
> --- a/arch/sparc/kernel/vmlinux.lds.S
> +++ b/arch/sparc/kernel/vmlinux.lds.S
> @@ -132,6 +132,11 @@ SECTIONS
>  		*(.popc_6insn_patch)
>  		__popc_6insn_patch_end = .;
>  	}
> +	.pause_patch : {
> +		__pause_patch = .;
> +		*(.pause_patch)
> +		__pause_patch_end = .;
> +	}
>  	PERCPU_SECTION(SMP_CACHE_BYTES)
>  

For most other patch sections it is obvious from the name
how many instructions are patched.
It could bd made obvious here too by renaming the
section to:

    .pause_3insn_patch

	Sam
