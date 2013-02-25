From: Kirill Tkhai <tkhai@yandex.ru>
Date: Mon, 25 Feb 2013 13:05:18 +0000
Subject: Re:[PATCH]sparc32: Fix lost pte_present() state while mprotect() system call
Message-Id: <1180701361797518@web8g.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
References: <1123991361539147@web6h.yandex.ru>
In-Reply-To: <1123991361539147@web6h.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



> From: Kirill Tkhai <tkhai@yandex.ru>
> Date: Fri, 22 Feb 2013 17:19:07 +0400
> 
>> If pte is present before change_pte_range() works on it, the state will be
>> lost after it. pte_modify() zeroes every 0xff bit including SRMMU_ET_MASK
>> while it adds new protection. I receive the stack after this (on a slightly
>> modified kernel):
>>
>> So, add SRMMU_ET_MASK to SRMMU_CHG_MASK.
>>
>> Signed-off-by: Kirill V Tkhai <tkhai@yandex.ru>
> 
> ...
> 
>> -#define SRMMU_CHG_MASK (0xffffff00 | SRMMU_REF | SRMMU_DIRTY)
>> +#define SRMMU_CHG_MASK (0xffffff00 | SRMMU_REF | SRMMU_DIRTY | SRMMU_ET_MASK)
> 
> I don't think this is correct, the state is not lost, it must be
> contained fully in the pgprot_t protections we are changing to.
> 
> What if we are trying to change the protections from PAGE_COPY (which
> has the valid bit set) to PAGE_NONE (which lacks the valid bit)? That
> no longer works after your change, as we'll leave the valid bit set.
> 
> In fact, I think the bug you triggered is exactly this situation, and
> your patch therefore breaks PAGE_NONE completely.
> 
> Present and Valid are two seperate pieces of state, so the bug might
> really be that the SRMMU code tries to handle them as one. And your
> trace seems to confirm this, actually. PROT_NONE can be for a present
> page, but it must have the valid bit cleared.

Thanks for the explanation, David!

Should we account none pages in pte_present instead of above like this?

static inline int srmmu_pte_present(pte_t pte)
{ return ((pte_val(pte) & SRMMU_ET_MASK) = SRMMU_ET_PTE) ||
          ((pte_val(pte) & SRMMU_PAGE_NONE) = SRMMU_PAGE_NONE); }

 -- 
