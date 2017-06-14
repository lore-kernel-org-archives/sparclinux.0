From: David Miller <davem@davemloft.net>
Date: Wed, 14 Jun 2017 17:05:00 +0000
Subject: Re: [PATCH] sparc64: Exclude perf user callchain during critical sections
Message-Id: <20170614.130500.2030403658384422821.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1497416757-9894-1-git-send-email-rob.gardner@oracle.com>
In-Reply-To: <1497416757-9894-1-git-send-email-rob.gardner@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Rob Gardner <rob.gardner@oracle.com>
Date: Wed, 14 Jun 2017 10:47:08 -0600

> On 06/14/2017 10:25 AM, David Miller wrote:
>> From: Rob Gardner <rob.gardner@oracle.com>
>> Date: Tue, 13 Jun 2017 23:05:57 -0600
>>
>>> One particular critical section occurs in switch_mm:
>>>
>>>          spin_lock_irqsave(&mm->context.lock, flags);
>>>          ...
>>>          load_secondary_context(mm);
>>>          tsb_context_switch(mm);
>>>          ...
>>>          spin_unlock_irqrestore(&mm->context.lock, flags);
>>>
>>> If a perf interrupt arrives in between load_secondary_context() and
>>> tsb_context_switch(), then perf_callchain_user() could execute with
>>> the context ID of one process, but with an active tsb for a different
>>> process. When the user stack is accessed, it is very likely to
>>> incur a TLB miss, since the h/w context ID has been changed. The TLB
>>> will then be reloaded with a translation from the TSB for one process,
>>> but using a context ID for another process. This exposes memory from
>>> one process to another, and since it is a mapping for stack memory,
>>> this usually causes the new process to crash quickly.
>> Ahhh, good catch.
>>
>>> Some potential solutions are:
>>>
>>> 1) Make critical sections run at PIL_NMI instead of PIL_NORMAL_MAX.
>>> This would certainly eliminate the problem, but it would also prevent
>>> perf from having any visibility into code running in these critical
>>> sections, and it seems clear that PIL_NORMAL_MAX is used for just
>>> this reason.
>>>
>>> 2) Protect this particular critical section by masking all interrupts,
>>> either by setting %pil to PIL_NMI or by clearing pstate.ie around the
>>> calls to load_secondary_context() and tsb_context_switch(). This
>>> approach
>>> has a few drawbacks:
>>>
>>>   - It would only address this particular critical section, and would
>>>     have to be repeated in several other known places. There might be
>>>     other such critical sections that are not known.
>>>
>>>   - It has a performance cost which would be incurred at every context
>>>     switch, since it would require additional accesses to %pil or
>>>     %pstate.
>>>
>>>   - Turning off pstate.ie would require changing __tsb_context_switch(),
>>>     which expects to be called with pstate.ie on.
>>>
>>> 3) Avoid user space MMU activity entirely in perf_callchain_user() by
>>> implementing a new copy_from_user() function that accesses the user
>>> stack via physical addresses. This works, but requires quite a bit of
>>> new code to get it to perform reasonably, ie, caching of translations,
>>> etc.
>>>
>>> 4) Allow the perf interrupt to happen in existing critical sections as
>>> it does now, but have perf code detect that this is happening, and
>>> skip any user callchain processing. This approach was deemed best, as
>>> the change is extremely localized and covers both known and unknown
>>> instances of perf interrupting critical sections. Perf has interrupted
>>> a critical section when %pil = PIL_NORMAL_MAX at the time of the perf
>>> interrupt.
>>>
>>> Ordinarily, a function that has a pt_regs passed in can simply examine
>>> (reg->tstate & TSTATE_PIL) to extract the interrupt level that was in
>>> effect at the time of the perf interrupt.  However, when the perf
>>> interrupt occurs while executing in the kernel, the pt_regs pointer is
>>> replaced with task_pt_regs(current) in perf_callchain(), and so
>>> perf_callchain_user() does not have access to the state of the machine
>>> at the time of the perf interrupt. To work around this, we check
>>> (regs->tstate & TSTATE_PIL) in perf_event_nmi_handler() before calling
>>> in to the arch independent part of perf, and temporarily change the
>>> event attributes so that user callchain processing is avoided. Though
>>> a user stack sample is not collected, this loss is not statistically
>>> significant. Kernel call graph collection is not affected.
>> I tried to figure out how x86 handles this, and gave up after some
>> time :-)  Can you figure it out?
> 
> I could look.
> 
>>
>> PowerPC handles this by hard disabling IRQs from switch_mm until
>> switch_to completes.
>>
>> I think excluding all local_irq_disabled() paths from having stack
>> backtraces is not good.
> 
> Just to clarify, this does not exclude local_irq_disabled() paths from
> having stack backtraces. It only disables collection of *user* stack
> backtraces during these (very rare) times. Collection of *kernel*
> stack traces is not affected, so we still get the same visibility from
> perf for kernel call graphs. I do not believe we sacrifice anything
> here in terms of user stack collection since we'll only skip doing
> this when:
>  1) we're already executing in the kernel when the perf interrupt
>  arrives, and this is already (what should be) a rare event
>  2) and kernel is executing in a local_irq_disabled() path, also should
>  be very rare

I understood this from the beginning.

>>   I'd rather see PIL_MAX get set from switch_mm
>> until switch_to completes.
>>
>> Ok?
>>
> 
> In light of the above, what is your preference?

I still have the same position.

That lack of user backtrace is a loss of information.  And in order to
make it work we must have the case that the PGD/TSB/mmu-context/stack
all match up precisely.
