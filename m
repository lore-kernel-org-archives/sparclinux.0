From: Rob Gardner <rob.gardner@oracle.com>
Date: Fri, 14 Jul 2017 15:15:57 +0000
Subject: Re: [PATCH] sparc64: Prevent perf from running during super critical sections
Message-Id: <c7aa10e3-729f-8ec8-b6fa-9dc6823f3649@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1500004560-974885-1-git-send-email-rob.gardner@oracle.com>
In-Reply-To: <1500004560-974885-1-git-send-email-rob.gardner@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 07/14/2017 02:57 AM, Julian Calaby wrote:
>
>> diff --git a/arch/sparc/include/asm/mmu_context_64.h b/arch/sparc/include/asm/mmu_context_64.h
>> index 2cddcda..b7e0373 100644
>> --- a/arch/sparc/include/asm/mmu_context_64.h
>> +++ b/arch/sparc/include/asm/mmu_context_64.h
>> @@ -112,6 +112,7 @@ static inline void switch_mm(struct mm_struct *old_mm, struct mm_struct *mm, str
>>           * cpu0 to update it's TSB because at that point the cpu_vm_mask
>>           * only had cpu1 set in it.
>>           */
>> +       __asm__ __volatile__("wrpr %0, %%pil;" : : "i" (PIL_NMI));
> You're doing the same thing twice and it might be needed elsewhere, so
> should this be in a macro so it's not copy-pasted everywhere?
>
> Thanks,
>


Good idea, thanks. Revised patch on its way.

Rob

