From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Mon, 15 May 2017 18:24:00 +0000
Subject: Re: [v3 9/9] s390: teach platforms not to zero struct pages memory
Message-Id: <0669a945-4540-096e-799a-2d2b3c18abaa@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1494003796-748672-1-git-send-email-pasha.tatashin@oracle.com>
 <1494003796-748672-10-git-send-email-pasha.tatashin@oracle.com>
 <20170508113624.GA4876@osiris>
In-Reply-To: <20170508113624.GA4876@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, davem@davemloft.net

Hi Heiko,

Thank you for looking at this patch. I am worried to make the proposed 
change, because, as I understand in this case we allocate memory not for 
"struct page"s but for table that hold them. So, we will change the 
behavior from the current one, where this table is allocated zeroed, but 
now it won't be zeroed.

Pasha

> 
> If you add the hunk below then this is
> 
> Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
> index ffe9ba1aec8b..bf88a8b9c24d 100644
> --- a/arch/s390/mm/vmem.c
> +++ b/arch/s390/mm/vmem.c
> @@ -272,7 +272,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
>   		if (pte_none(*pt_dir)) {
>   			void *new_page;
>   
> -			new_page = vmemmap_alloc_block(PAGE_SIZE, node, true);
> +			new_page = vmemmap_alloc_block(PAGE_SIZE, node, VMEMMAP_ZERO);
>   			if (!new_page)
>   				goto out;
>   			pte_val(*pt_dir) = __pa(new_page) | pgt_prot;
> 
