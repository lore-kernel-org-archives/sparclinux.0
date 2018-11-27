From: Mike Rapoport <rppt@linux.ibm.com>
Date: Tue, 27 Nov 2018 21:48:45 +0000
Subject: Re: [PATCH 4/5] openrisc: simplify pte_alloc_one_kernel()
Message-Id: <7843DE67-DCC3-48BF-873F-71D87B08EDA8@linux.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1543182277-8819-1-git-send-email-rppt@linux.ibm.com>
 <1543182277-8819-5-git-send-email-rppt@linux.ibm.com>
 <20181127211600.GB3235@lianli.shorne-pla.net>
In-Reply-To: <20181127211600.GB3235@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org



On November 27, 2018 11:16:00 PM GMT+02:00, Stafford Horne <shorne@gmail.com> wrote:
>On Sun, Nov 25, 2018 at 11:44:36PM +0200, Mike Rapoport wrote:
>> The pte_alloc_one_kernel() function allocates a page using
>> __get_free_page(GFP_KERNEL) when mm initialization is complete and
>> memblock_phys_alloc() on the earlier stages. The physical address of
>the
>> page allocated with memblock_phys_alloc() is converted to the virtual
>> address and in the both cases the allocated page is cleared using
>> clear_page().
>> 
>> The code is simplified by replacing __get_free_page() with
>> get_zeroed_page() and by replacing memblock_phys_alloc() with
>> memblock_alloc().
>
>Hello Mike,
>
>This looks fine to me.  How do you plan to get this merged?  Will you
>be taking
>care of the whole series or so you want me to queue this openrisc part?

I was thinking about merging via the -mm tree.
Andrew, would that be ok?

>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>
>Acked-by: Stafford Horne <shorne@gmail.com>

Thanks!

>> ---
>>  arch/openrisc/mm/ioremap.c | 11 ++++-------
>>  1 file changed, 4 insertions(+), 7 deletions(-)
>> 
>> diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
>> index c969752..cfef989 100644
>> --- a/arch/openrisc/mm/ioremap.c
>> +++ b/arch/openrisc/mm/ioremap.c
>> @@ -123,13 +123,10 @@ pte_t __ref *pte_alloc_one_kernel(struct
>mm_struct *mm,
>>  {
>>  	pte_t *pte;
>>  
>> -	if (likely(mem_init_done)) {
>> -		pte = (pte_t *) __get_free_page(GFP_KERNEL);
>> -	} else {
>> -		pte = (pte_t *) __va(memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE));
>> -	}
>> +	if (likely(mem_init_done))
>> +		pte = (pte_t *)get_zeroed_page(GFP_KERNEL);
>> +	else
>> +		pte = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
>>  
>> -	if (pte)
>> -		clear_page(pte);
>>  	return pte;
>>  }
>> -- 
>> 2.7.4
>> 

-- 
Sincerely yours,
Mike.
