From: David Miller <davem@davemloft.net>
Date: Sun, 20 Nov 2016 21:42:35 +0000
Subject: Re: [PATCH v2] sparc64: Multi-page size support
Message-Id: <20161120.164235.41564426914943042.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1476313187-105065-1-git-send-email-nitin.m.gupta@oracle.com>
In-Reply-To: <1476313187-105065-1-git-send-email-nitin.m.gupta@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: nitin.m.gupta@oracle.com
Cc: mike.kravetz@oracle.com, akpm@linux-foundation.org, julian.calaby@gmail.com, hughd@google.com, adam.buchbinder@gmail.com, minchan@kernel.org, kirill.shutemov@linux.intel.com, sfr@canb.auug.org.au, paul.gortmaker@windriver.com, chris.hyser@oracle.com, atish.patra@oracle.com, mhocko@suse.com, toshi.kani@hpe.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Wed, 12 Oct 2016 15:58:11 -0700

> @@ -117,26 +117,11 @@ tsb_miss_page_table_walk_sun4v_fastpath:
>  	/* Valid PTE is now in %g5.  */
>  
>  #if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
> -661:	sethi		%uhi(_PAGE_SZALL_4U), %g7
> +661:	sethi		%uhi(_PAGE_PMD_HUGE), %g7
>  	sllx		%g7, 32, %g7

This "661" label only exists for the sake of the code patching
reference, but if you are removing the code patching then this
label should thus be removed too.

> @@ -161,34 +270,51 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
>  		     pte_t *ptep, pte_t entry)
>  {
>  	pte_t orig;
> +	unsigned long size = huge_tte_to_size(entry);
> +	unsigned int i, nptes = size >> PMD_SHIFT;
> +	unsigned int hugepage_shift;

Please always order local variables from longest to shortest line.

>  pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
>  			      pte_t *ptep)
>  {
>  	pte_t entry;
> +	unsigned long size;
> +	unsigned int i, nptes, hugepage_shift;

Likewise.

> +#ifdef CONFIG_HUGETLB_PAGE
> +static int __init setup_hugepagesz(char *string)
> +{
> +	int rc = 0;
> +	unsigned long long hugepage_size;
> +	unsigned int hugepage_shift;
> +	unsigned short hv_pgsz_idx;
> +	unsigned int hv_pgsz_mask;

Likewise.

> +#if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
> +static void __flush_huge_tsb_one_entry(unsigned long tsb, unsigned long v,
> +				       unsigned long hash_shift,
> +				       unsigned long nentries,
> +				       unsigned int hugepage_shift)
> +{
> +	unsigned int i;
> +	unsigned int hpage_entries = 1 << (hugepage_shift - REAL_HPAGE_SHIFT);

Likewise.
