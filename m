From: David Miller <davem@davemloft.net>
Date: Thu, 14 May 2015 03:45:17 +0000
Subject: Re: [PATCH Resend] sparc64: Resolve conflict between sparc v9 and M7 on usage of bit 9 of TTE
Message-Id: <20150513.234517.834150584495147194.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1430173189-12135-1-git-send-email-khalid.aziz@oracle.com>
In-Reply-To: <1430173189-12135-1-git-send-email-khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khalid.aziz@oracle.com
Cc: bob.picco@oracle.com, akpm@linux-foundation.org, kirill.shutemov@linux.intel.com, sam@ravnborg.org, rickard_strandqvist@spectrumdigital.se, allen.pais@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Mon, 27 Apr 2015 16:19:49 -0600

> @@ -342,9 +356,15 @@ static inline pgprot_t pgprot_noncached(pgprot_t prot)
>  	"	andn		%0, %4, %0\n"
>  	"	or		%0, %5, %0\n"
>  	"	.previous\n"
> +	"	.section	.sun_m7_2insn_patch, \"ax\"\n"
> +	"	.word		661b\n"
> +	"	andn		%0, %6, %0\n"
> +	"	or		%0, %5, %0\n"
> +	"	.previous\n"
>  	: "=r" (val)
>  	: "0" (val), "i" (_PAGE_CP_4U | _PAGE_CV_4U), "i" (_PAGE_E_4U),
> -	             "i" (_PAGE_CP_4V | _PAGE_CV_4V), "i" (_PAGE_E_4V));
> +			"i" (_PAGE_CP_4V | _PAGE_CV_4V), "i" (_PAGE_E_4V),
> +			"i" (_PAGE_CP_4V));

Please don't change the indentation of the "i" arguments.

> @@ -2446,18 +2471,35 @@ static void __init sun4u_pgprot_init(void)
>  static void __init sun4v_pgprot_init(void)
>  {
>  	unsigned long page_none, page_shared, page_copy, page_readonly;
> -	unsigned long page_exec_bit;
> +	unsigned long page_exec_bit, page_cache4v_flag;
>  	int i;
 ...
> +	switch (sun4v_chip_type) {
> +	case SUN4V_CHIP_SPARC_M7:
> +		page_cache4v_flag = _PAGE_CP_4V;
> +		break;
> +	default:
> +		page_cache4v_flag = _PAGE_CACHE_4V;
> +		break;
> +	}

Ok you've computed what cacheability bits to use in page_cache4v_flag.

> -	kern_linear_pte_xor[0] |= (_PAGE_CP_4V | _PAGE_CV_4V |
> +	switch (sun4v_chip_type) {
> +	case SUN4V_CHIP_SPARC_M7:
> +		kern_linear_pte_xor[0] |= (_PAGE_CP_4V | _PAGE_P_4V |
> +				   _PAGE_W_4V);
> +		break;
> +	default:
> +		kern_linear_pte_xor[0] |= (_PAGE_CP_4V | _PAGE_CV_4V |
>  				   _PAGE_P_4V | _PAGE_W_4V);
> +		break;
> +	}
>  

Then needlessly compute this all over again, just use the
value you have already in page_cache4v_flag.

> @@ -2541,9 +2591,18 @@ static unsigned long kern_large_tte(unsigned long paddr)
>  	       _PAGE_CP_4U | _PAGE_CV_4U | _PAGE_P_4U |
>  	       _PAGE_EXEC_4U | _PAGE_L_4U | _PAGE_W_4U);
>  	if (tlb_type = hypervisor)
> -		val = (_PAGE_VALID | _PAGE_SZ4MB_4V |
> -		       _PAGE_CP_4V | _PAGE_CV_4V | _PAGE_P_4V |
> -		       _PAGE_EXEC_4V | _PAGE_W_4V);
> +		switch (sun4v_chip_type) {
> +		case SUN4V_CHIP_SPARC_M7:
> +			val = (_PAGE_VALID | _PAGE_SZ4MB_4V |
> +			       _PAGE_CP_4V | _PAGE_P_4V |
> +			       _PAGE_EXEC_4V | _PAGE_W_4V);
> +			break;
> +		default:
> +			val = (_PAGE_VALID | _PAGE_SZ4MB_4V |
> +			       _PAGE_CP_4V | _PAGE_CV_4V | _PAGE_P_4V |
> +			       _PAGE_EXEC_4V | _PAGE_W_4V);
> +			break;
> +		}

Although in another function, we seem to compute it here yet again.

Perhaps early on put this into a "static unsigned long
page_cache4v_flag" and just use that everywhere.

If you do it early enough in paging_init() you should be fine.
