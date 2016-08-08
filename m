From: David Long <dave.long@linaro.org>
Date: Mon, 08 Aug 2016 14:29:05 +0000
Subject: Re: [PATCH v15 04/10] arm64: Kprobes with single stepping support
Message-Id: <57A89731.20709@linaro.org>
List-Id: <sparclinux.vger.kernel.org>
References: <578FA238.3050206@arm.com> <5790F960.5050007@linaro.org>
 <57910528.7070902@arm.com> <57911590.50305@linaro.org>
 <20160722101617.GA17821@e104818-lin.cambridge.arm.com>
 <57924104.1080202@linaro.org>
 <20160725171350.GE2423@e104818-lin.cambridge.arm.com>
 <57969234.1070201@linaro.org>
 <22b277ba-6812-a0dd-9e8e-c29bdb3aa672@linaro.org>
 <57993211.1040600@linaro.org>
 <20160728144053.GA26510@e104818-lin.cambridge.arm.com>
 <360d582b-5401-7126-ef40-bd78369c0a34@linaro.org>
 <57A2C8DF.7050401@linaro.org>
 <74b8c503-b6df-dcb1-c278-d49850fe3715@linaro.org>
In-Reply-To: <74b8c503-b6df-dcb1-c278-d49850fe3715@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 08/08/2016 07:13 AM, Daniel Thompson wrote:
> On 04/08/16 05:47, David Long wrote:
>> From b451caa1adaf1d03e08a44b5dad3fca31cebd97a Mon Sep 17 00:00:00 2001
>> From: "David A. Long" <dave.long@linaro.org>
>> Date: Thu, 4 Aug 2016 00:35:33 -0400
>> Subject: [PATCH] arm64: Remove stack duplicating code from jprobes
>>
>> Because the arm64 calling standard allows stacked function arguments
>> to be
>> anywhere in the stack frame, do not attempt to duplicate the stack
>> frame for
>> jprobes handler functions.
>>
>> Signed-off-by: David A. Long <dave.long@linaro.org>
>> ---
>>  Documentation/kprobes.txt          |  7 +++++++
>>  arch/arm64/include/asm/kprobes.h   |  2 --
>>  arch/arm64/kernel/probes/kprobes.c | 31 +++++--------------------------
>>  3 files changed, 12 insertions(+), 28 deletions(-)
>>
>> diff --git a/Documentation/kprobes.txt b/Documentation/kprobes.txt
>> index 1f9b3e2..bd01839 100644
>> --- a/Documentation/kprobes.txt
>> +++ b/Documentation/kprobes.txt
>> @@ -103,6 +103,13 @@ Note that the probed function's args may be
>> passed on the stack
>>  or in registers.  The jprobe will work in either case, so long as the
>>  handler's prototype matches that of the probed function.
>>
>> +Note that in some architectures (e.g.: arm64) the stack copy is not
>
> Could sparc64 be added to this list?
>
>    For the sparc folks who are new to the thread, we've previously
>    established that the sparc64 ABI passes large structures by
>    allocating them from the caller's stack frame and passing a pointer
>    to the stack frame (i.e. arguments may not be at top of the stack).
>    We also noticed that sparc code does not save/restore anything from
>    the stack.
>

I was reluctant to do that in the context of late changes to v4.8 for 
arm64 but now that any changes for this are going in as a new patch it 
would indeed be useful to get involvement from sparc maintainers.

>
>> +done, as the actual location of stacked parameters may be outside of
>> +a reasonable MAX_STACK_SIZE value and because that location cannot be
>> +determined by the jprobes code. In this case the jprobes user must be
>> +careful to make certain the calling signature of the function does
>> +not cause parameters to be passed on the stack.
>> +
>>  1.3 Return Probes
>>
>>  1.3.1 How Does a Return Probe Work?
>> diff --git a/arch/arm64/include/asm/kprobes.h
>> b/arch/arm64/include/asm/kprobes.h
>> index 61b4915..1737aec 100644
>> --- a/arch/arm64/include/asm/kprobes.h
>> +++ b/arch/arm64/include/asm/kprobes.h
>> @@ -22,7 +22,6 @@
>>
>>  #define __ARCH_WANT_KPROBES_INSN_SLOT
>>  #define MAX_INSN_SIZE            1
>> -#define MAX_STACK_SIZE            128
>>
>>  #define flush_insn_slot(p)        do { } while (0)
>>  #define kretprobe_blacklist_size    0
>> @@ -47,7 +46,6 @@ struct kprobe_ctlblk {
>>      struct prev_kprobe prev_kprobe;
>>      struct kprobe_step_ctx ss_ctx;
>>      struct pt_regs jprobe_saved_regs;
>> -    char jprobes_stack[MAX_STACK_SIZE];
>>  };
>>
>>  void arch_remove_kprobe(struct kprobe *);
>> diff --git a/arch/arm64/kernel/probes/kprobes.c
>> b/arch/arm64/kernel/probes/kprobes.c
>> index bf97685..c6b0f40 100644
>> --- a/arch/arm64/kernel/probes/kprobes.c
>> +++ b/arch/arm64/kernel/probes/kprobes.c
>> @@ -41,18 +41,6 @@ DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
>>  static void __kprobes
>>  post_kprobe_handler(struct kprobe_ctlblk *, struct pt_regs *);
>>
>> -static inline unsigned long min_stack_size(unsigned long addr)
>> -{
>> -    unsigned long size;
>> -
>> -    if (on_irq_stack(addr, raw_smp_processor_id()))
>> -        size = IRQ_STACK_PTR(raw_smp_processor_id()) - addr;
>> -    else
>> -        size = (unsigned long)current_thread_info() + THREAD_START_SP
>> - addr;
>> -
>> -    return min(size, FIELD_SIZEOF(struct kprobe_ctlblk, jprobes_stack));
>> -}
>> -
>>  static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
>>  {
>>      /* prepare insn slot */
>> @@ -489,20 +477,15 @@ int __kprobes setjmp_pre_handler(struct kprobe
>> *p, struct pt_regs *regs)
>>  {
>>      struct jprobe *jp = container_of(p, struct jprobe, kp);
>>      struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
>> -    long stack_ptr = kernel_stack_pointer(regs);
>>
>>      kcb->jprobe_saved_regs = *regs;
>>      /*
>> -     * As Linus pointed out, gcc assumes that the callee
>> -     * owns the argument space and could overwrite it, e.g.
>> -     * tailcall optimization. So, to be absolutely safe
>> -     * we also save and restore enough stack bytes to cover
>> -     * the argument area.
>> +     * Since we can't be sure where in the stack frame "stacked"
>> +     * pass-by-value arguments are stored we just don't try to
>> +     * duplicate any of the stack.
>  > ...
>>                                       Do not use jprobes on functions
>> that
>> +     * use more than 64 bytes (after padding each to an 8 byte boundary)
>> +     * of arguments, or pass individual arguments larger than 16 bytes.
>
> I like this wording. So much so that it really would be great to repeat
> this in the Documentation/. Could this be included in the list of
> architecture support/restrictions?
>

Are you thinking specifically of the "5. Kprobes Features and 
Limitations" section in Documentation/kprobes.txt?

>
> Daniel.
>

Thanks,
-dl

