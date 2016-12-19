From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Mon, 19 Dec 2016 00:52:18 +0000
Subject: Re: [RFC PATCH 06/14] sparc64: general shared context tsb creation and support
Message-Id: <6f8647b9-76eb-1b02-ab68-40509b2163fe@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1481913337-9331-1-git-send-email-mike.kravetz@oracle.com>
 <1481913337-9331-7-git-send-email-mike.kravetz@oracle.com>
 <20161217075325.GD23567@ravnborg.org>
In-Reply-To: <20161217075325.GD23567@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Bob Picco <bob.picco@oracle.com>, Nitin Gupta <nitin.m.gupta@oracle.com>, Vijay Kumar <vijay.ac.kumar@oracle.com>, Julian Calaby <julian.calaby@gmail.com>, Adam Buchbinder <adam.buchbinder@gmail.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>

On 12/16/2016 11:53 PM, Sam Ravnborg wrote:
> Hi Mike
> 
>> --- a/arch/sparc/mm/hugetlbpage.c
>> +++ b/arch/sparc/mm/hugetlbpage.c
>> @@ -162,8 +162,14 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
>>  {
>>  	pte_t orig;
>>  
>> -	if (!pte_present(*ptep) && pte_present(entry))
>> -		mm->context.hugetlb_pte_count++;
>> +	if (!pte_present(*ptep) && pte_present(entry)) {
>> +#if defined(CONFIG_SHARED_MMU_CTX)
>> +		if (pte_val(entry) | _PAGE_SHR_CTX_4V)
>> +			mm->context.shared_hugetlb_pte_count++;
>> +		else
>> +#endif
>> +			mm->context.hugetlb_pte_count++;
>> +	}
> 
> This kind of conditional code it just too ugly to survive...
> Could a static inline be used to help you here?
> The compiler will inline it so there should not be any run-time cost

Yes, this can be cleaned up in that way.

> 
>>  
>>  	mm_rss -= saved_thp_pte_count * (HPAGE_SIZE / PAGE_SIZE);
>>  #endif
>> @@ -544,8 +576,10 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
>>  	 * us, so we need to zero out the TSB pointer or else tsb_grow()
>>  	 * will be confused and think there is an older TSB to free up.
>>  	 */
>> -	for (i = 0; i < MM_NUM_TSBS; i++)
>> +	for (i = 0; i < MM_NUM_TSBS; i++) {
>>  		mm->context.tsb_block[i].tsb = NULL;
>> +		mm->context.tsb_descr[i].tsb_base = 0UL;
>> +	}
> This change seems un-related to the rest?

Correct.  I was experimenting with some other ways of managing the tsb_descr
array that got dropped, but forgot to remove this.

-- 
Mike Kravetz

> 
> 	Sam
> 
