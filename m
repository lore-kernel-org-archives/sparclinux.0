From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Fri, 25 Mar 2016 19:13:05 +0000
Subject: Re: [Patch V2 2/2] sparc64 changes
Message-Id: <56F58DC1.1080609@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1458772868-10255-3-git-send-email-dave.kleikamp@oracle.com>
In-Reply-To: <1458772868-10255-3-git-send-email-dave.kleikamp@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 03/25/2016 02:03 PM, David Miller wrote:
> From: Dave Kleikamp <dave.kleikamp@oracle.com>
> Date: Fri, 25 Mar 2016 13:22:30 -0500
> 
>> On 03/24/2016 02:22 PM, David Miller wrote:
>>> From: Dave Kleikamp <dave.kleikamp@oracle.com>
>>> Date: Wed, 23 Mar 2016 17:41:08 -0500
>>>
>>>> +	/* Check for a huge/THP page */
>>>> +	paddr = pmd_is_huge(pte, vaddr, verbose);
>>>> +	if (paddr)
>>>> +		goto out;
>>>  ...
>>>> +	paddr = pte_to_pa(pte);
>>>> +	paddr = paddr | (vaddr & ~PAGE_MASK);
>>>
>>> This handles transparent huge pages installed at the PMD level, but I don't
>>> see that it handles huge PTEs properly, which are encoded at the PTE level.
>>
>> I've been looking at the huge page code again and I'm not sure what I'm
>> missing. Isn't there still a huge PTE in the page table for every 8K
>> page with the proper physical address bits?
> 
> Yes there is a huge PTE encoded every 8K, but I'm wondering about the
> address masking et al. you are doing here...

I'm pretty sure it works. In set_huge_pte_at():

        for (i = 0; i < (1 << HUGETLB_PAGE_ORDER); i++) {
                set_pte_at(mm, addr, ptep, entry);
                ptep++;
                addr += PAGE_SIZE;
                pte_val(entry) += PAGE_SIZE;
        }

Each pte correctly addresses an 8K page. The crash code doesn't really
need to know it's part of a huge page.
