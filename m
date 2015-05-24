From: David Miller <davem@davemloft.net>
Date: Sun, 24 May 2015 20:00:00 +0000
Subject: Re: [PATCH v2] sparc: Resolve conflict between sparc v9 and M7 on usage of bit 9 of TTE
Message-Id: <20150524.160000.1861676452576814254.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1431712095-9711-1-git-send-email-khalid.aziz@oracle.com>
In-Reply-To: <1431712095-9711-1-git-send-email-khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khalid.aziz@oracle.com
Cc: bob.picco@oracle.com, kirill.shutemov@linux.intel.com, akpm@linux-foundation.org, sam@ravnborg.org, rickard_strandqvist@spectrumdigital.se, allen.pais@oracle.com, iamjoonsoo.kim@lge.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Fri, 15 May 2015 11:48:15 -0600

> diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
> index c38d19f..606e3f9 100644
> --- a/arch/sparc/kernel/setup_64.c
> +++ b/arch/sparc/kernel/setup_64.c
> @@ -255,6 +255,30 @@ void sun4v_patch_2insn_range(struct sun4v_2insn_patch_entry *start,
>  	}
>  }
>  
> +void sun_m7_patch_2insn_range(struct sun4v_2insn_patch_entry *start,
> +			     struct sun4v_2insn_patch_entry *end)
> +{
> +	while (start < end) {
> +		unsigned long addr = start->addr;
> +
> +		*(unsigned int *) (addr +  0) = start->insns[0];
> +		/* We are updating an instruction. Make sure it is
> +		 * written out
> +		 */
> +		wmb();
> +		__asm__ __volatile__("flush	%0" : : "r" (addr +  0));
> +
> +		*(unsigned int *) (addr +  4) = start->insns[1];
> +		/* We are updating an instruction. Make sure it is
> +		 * written out
> +		 */
> +		wmb();
> +		__asm__ __volatile__("flush	%0" : : "r" (addr +  4));

There is no reason to say this in a comment, none of the other code
patching routines mention this, and it's even more excessive to say it
twice in quick succession basically in the same place.

Please just remove these comments, anyone reading this code knows we
are code patching and will realize that there are memory barrier
requirements.

Alternatively if you think it's worth mentioning, submit a separate
patch that adds the comment to all of the code patching routines for
consistency.

> @@ -267,6 +291,9 @@ static void __init sun4v_patch(void)
>  
>  	sun4v_patch_2insn_range(&__sun4v_2insn_patch,
>  				&__sun4v_2insn_patch_end);
> +	if (sun4v_chip_type = SUN4V_CHIP_SPARC_M7)
> +		sun_m7_patch_2insn_range(&__sun_m7_2insn_patch,
> +				&__sun_m7_2insn_patch_end);

When a function call spans multiple lines, the second and subsequent line
must start at exactly the first column after the openning parenthesis of
the first line.  You must use the appropriate number of TAB and SPACE
characters necessary to achieve this.

Look at how the sun4v_patch_2insn_range() call before the one you added is
indented.

> @@ -2312,8 +2345,7 @@ int __meminit vmemmap_populate(unsigned long vstart, unsigned long vend,
>  		    _PAGE_P_4U | _PAGE_W_4U);
>  	if (tlb_type = hypervisor)
>  		pte_base = (_PAGE_VALID | _PAGE_SZ4MB_4V |
> -			    _PAGE_CP_4V | _PAGE_CV_4V |
> -			    _PAGE_P_4V | _PAGE_W_4V);
> +			page_cache4v_flag | _PAGE_P_4V | _PAGE_W_4V);

The existing indentation of these lines after the first of the
pte_base assignment were correct, please do not change how it is
indented.

> @@ -2465,8 +2497,8 @@ static void __init sun4v_pgprot_init(void)
>  	kern_linear_pte_xor[0] = (_PAGE_VALID | _PAGE_SZ4MB_4V) ^
>  		PAGE_OFFSET;
>  #endif
> -	kern_linear_pte_xor[0] |= (_PAGE_CP_4V | _PAGE_CV_4V |
> -				   _PAGE_P_4V | _PAGE_W_4V);
> +	kern_linear_pte_xor[0] |= (page_cache4v_flag | _PAGE_P_4V |
> +				_PAGE_W_4V);

Likewise.
