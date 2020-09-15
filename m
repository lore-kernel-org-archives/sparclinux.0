From: Nicholas Piggin <npiggin@gmail.com>
Date: Tue, 15 Sep 2020 02:48:02 +0000
Subject: Re: [PATCH v2 1/4] mm: fix exec activate_mm vs TLB shootdown and lazy tlb switching race
Message-Id: <1600137586.nypnz3sbcl.astroid@bobo.none>
List-Id: <sparclinux.vger.kernel.org>
References: <20200914045219.3736466-1-npiggin@gmail.com>
        <20200914045219.3736466-2-npiggin@gmail.com>
        <20200914105617.GP1362448@hirez.programming.kicks-ass.net>
In-Reply-To: <20200914105617.GP1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: peterz@infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>, Dave Hansen <dave.hansen@intel.com>, "David S . Miller" <davem@davemloft.net>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, "linux-mm @ kvack . org" <linux-mm@kvack.org>, linuxppc-dev@lists.ozlabs.org, Andy Lutomirski <luto@amacapital.net>, sparclinux@vger.kernel.org

Excerpts from peterz@infradead.org's message of September 14, 2020 8:56 pm:
> On Mon, Sep 14, 2020 at 02:52:16PM +1000, Nicholas Piggin wrote:
>> Reading and modifying current->mm and current->active_mm and switching
>> mm should be done with irqs off, to prevent races seeing an intermediate
>> state.
>> 
>> This is similar to commit 38cf307c1f20 ("mm: fix kthread_use_mm() vs TLB
>> invalidate"). At exec-time when the new mm is activated, the old one
>> should usually be single-threaded and no longer used, unless something
>> else is holding an mm_users reference (which may be possible).
>> 
>> Absent other mm_users, there is also a race with preemption and lazy tlb
>> switching. Consider the kernel_execve case where the current thread is
>> using a lazy tlb active mm:
>> 
>>   call_usermodehelper()
>>     kernel_execve()
>>       old_mm = current->mm;
>>       active_mm = current->active_mm;
>>       *** preempt *** -------------------->  schedule()
>>                                                prev->active_mm = NULL;
>>                                                mmdrop(prev active_mm);
>>                                              ...
>>                       <--------------------  schedule()
>>       current->mm = mm;
>>       current->active_mm = mm;
>>       if (!old_mm)
>>           mmdrop(active_mm);
>> 
>> If we switch back to the kernel thread from a different mm, there is a
>> double free of the old active_mm, and a missing free of the new one.
>> 
>> Closing this race only requires interrupts to be disabled while ->mm
>> and ->active_mm are being switched, but the TLB problem requires also
>> holding interrupts off over activate_mm. Unfortunately not all archs
>> can do that yet, e.g., arm defers the switch if irqs are disabled and
>> expects finish_arch_post_lock_switch() to be called to complete the
>> flush; um takes a blocking lock in activate_mm().
>> 
>> So as a first step, disable interrupts across the mm/active_mm updates
>> to close the lazy tlb preempt race, and provide an arch option to
>> extend that to activate_mm which allows architectures doing IPI based
>> TLB shootdowns to close the second race.
>> 
>> This is a bit ugly, but in the interest of fixing the bug and backporting
>> before all architectures are converted this is a compromise.
>> 
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> I'm thinking we want this selected on x86 as well. Andy?

Thanks for the ack. The plan was to take it through the powerpc tree,
but if you'd want x86 to select it, maybe a topic branch? Although
Michael will be away during the next merge window so I don't want to
get too fancy. Would you mind doing it in a follow up merge after
powerpc, being that it's (I think) a small change?

I do think all archs should be selecting this, and we want to remove
the divergent code paths from here as soon as possible. I was planning
to send patches for the N+1 window at least for all the easy archs.
But the sooner the better really, we obviously want to share code
coverage with x86 :)

Thanks,
Nick
