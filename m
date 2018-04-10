From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Tue, 10 Apr 2018 16:44:00 +0000
Subject: Re: [PATCH v2 2/2] mm: remove odd HAVE_PTE_SPECIAL
Message-Id: <1521dc0e-e9f8-d10f-e213-1b1552eb03fa@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1523373951-10981-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1523373951-10981-3-git-send-email-ldufour@linux.vnet.ibm.com>
 <3f20ac8b-20b8-f052-bc44-dcc0316354ca@arm.com>
In-Reply-To: <3f20ac8b-20b8-f052-bc44-dcc0316354ca@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org



On 10/04/2018 17:58, Robin Murphy wrote:
> On 10/04/18 16:25, Laurent Dufour wrote:
>> Remove the additional define HAVE_PTE_SPECIAL and rely directly on
>> CONFIG_ARCH_HAS_PTE_SPECIAL.
>>
>> There is no functional change introduced by this patch
>>
>> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
>> ---
>>   mm/memory.c | 23 ++++++++++-------------
>>   1 file changed, 10 insertions(+), 13 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 96910c625daa..53b6344a90d2 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -817,19 +817,13 @@ static void print_bad_pte(struct vm_area_struct *vma,
>> unsigned long addr,
>>    * PFNMAP mappings in order to support COWable mappings.
>>    *
>>    */
>> -#ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
>> -# define HAVE_PTE_SPECIAL 1
>> -#else
>> -# define HAVE_PTE_SPECIAL 0
>> -#endif
>>   struct page *_vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
>>                    pte_t pte, bool with_public_device)
>>   {
>>       unsigned long pfn = pte_pfn(pte);
>>   -    if (HAVE_PTE_SPECIAL) {
>> -        if (likely(!pte_special(pte)))
>> -            goto check_pfn;
>> +#ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
> 
> Nit: Couldn't you use IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) within the
> existing code structure to avoid having to add these #ifdefs?

I agree, that would be better. I didn't thought about this option..
Thanks for reporting this.

