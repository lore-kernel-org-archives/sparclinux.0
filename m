From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 05 Aug 2011 09:27:27 +0000
Subject: Re: [PATCH] sparc: Access kernel TSB using physical addressing
Message-Id: <20110805092727.GA15208@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110805.010032.779552426005653854.davem@davemloft.net>
In-Reply-To: <20110805.010032.779552426005653854.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi David.
  
> diff --git a/arch/sparc/kernel/vmlinux.lds.S b/arch/sparc/kernel/vmlinux.lds.S
> index 94a9548..0e16056 100644
> --- a/arch/sparc/kernel/vmlinux.lds.S
> +++ b/arch/sparc/kernel/vmlinux.lds.S
> @@ -107,6 +107,16 @@ SECTIONS
>  		*(.sun4v_2insn_patch)
>  		__sun4v_2insn_patch_end = .;
>  	}
> +	.swapper_tsb_phys_patch : {
> +		__swapper_tsb_phys_patch = .;
> +		*(.swapper_tsb_phys_patch)
> +		__swapper_tsb_phys_patch_end = .;
> +	}
> +	.swapper_4m_tsb_phys_patch : {
> +		__swapper_4m_tsb_phys_patch = .;
> +		*(.swapper_4m_tsb_phys_patch)
> +		__swapper_4m_tsb_phys_patch_end = .;
> +	}
>  	.popc_3insn_patch : {
>  		__popc_3insn_patch = .;
>  		*(.popc_3insn_patch)
> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index 3fd8e18..adfac23 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> @@ -1597,6 +1597,42 @@ static void __init tsb_phys_patch(void)
>  static struct hv_tsb_descr ktsb_descr[NUM_KTSB_DESCR];
>  extern struct tsb swapper_tsb[KERNEL_TSB_NENTRIES];
>  
> +static void patch_one_ktsb_phys(unsigned int *start, unsigned int *end, unsigned long pa)
> +{
> +	pa >>= KTSB_PHYS_SHIFT;
> +
> +	while (start < end) {
> +		unsigned int *ia = (unsigned int *)(unsigned long)*start;
> +
> +		ia[0] = (ia[0] & ~0x3fffff) | (pa >> 10);
> +		__asm__ __volatile__("flush	%0" : : "r" (ia));
> +
> +		ia[1] = (ia[1] & ~0x3ff) | (pa & 0x3ff);
> +		__asm__ __volatile__("flush	%0" : : "r" (ia + 1));
> +
> +		start++;
> +	}
> +}
> +
> +static void ktsb_phys_patch(void)
> +{
> +	extern unsigned int __swapper_tsb_phys_patch;
> +	extern unsigned int __swapper_tsb_phys_patch_end;
> +	extern unsigned int __swapper_4m_tsb_phys_patch;
> +	extern unsigned int __swapper_4m_tsb_phys_patch_end;


Having all the extern definitions from vmlinux.lds located in
arch/sparc/include/asm/sections.h would IMO be more obvious.

I did not try to review the actual patch, I only stumbled on this bit.

	Sam
