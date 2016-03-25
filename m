From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Fri, 25 Mar 2016 18:22:30 +0000
Subject: Re: [Patch V2 2/2] sparc64 changes
Message-Id: <56F581E6.40300@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1458772868-10255-3-git-send-email-dave.kleikamp@oracle.com>
In-Reply-To: <1458772868-10255-3-git-send-email-dave.kleikamp@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 03/24/2016 02:22 PM, David Miller wrote:
> From: Dave Kleikamp <dave.kleikamp@oracle.com>
> Date: Wed, 23 Mar 2016 17:41:08 -0500
> 
>> +	/* Check for a huge/THP page */
>> +	paddr = pmd_is_huge(pte, vaddr, verbose);
>> +	if (paddr)
>> +		goto out;
>  ...
>> +	paddr = pte_to_pa(pte);
>> +	paddr = paddr | (vaddr & ~PAGE_MASK);
> 
> This handles transparent huge pages installed at the PMD level, but I don't
> see that it handles huge PTEs properly, which are encoded at the PTE level.

I've been looking at the huge page code again and I'm not sure what I'm
missing. Isn't there still a huge PTE in the page table for every 8K
page with the proper physical address bits?
