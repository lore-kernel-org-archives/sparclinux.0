From: Rob Gardner <rob.gardner@oracle.com>
Date: Thu, 24 Dec 2015 17:39:05 +0000
Subject: Re: [PATCH 1/2] sparc64: Ensure perf can access user stacks
Message-Id: <567C2DB9.2070201@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1450844167-7327-1-git-send-email-rob.gardner@oracle.com>
In-Reply-To: <1450844167-7327-1-git-send-email-rob.gardner@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 12/24/2015 09:43 AM, David Miller wrote:
> From: Rob Gardner <rob.gardner@oracle.com>
> Date: Tue, 22 Dec 2015 21:16:06 -0700
>
>> When an interrupt (such as a perf counter interrupt) is delivered
>> while executing in user space, the trap entry code puts ASI_AIUS in
>> %asi so that copy_from_user() and copy_to_user() will access the
>> correct memory. But if a perf counter interrupt is delivered while the
>> cpu is already executing in kernel space, then the trap entry code
>> will put ASI_P in %asi, and this will prevent copy_from_user() from
>> reading any useful stack data in either of the perf_callchain_user_X
>> functions, and thus no user callgraph data will be collected for this
>> sample period. An additional problem is that a fault is guaranteed
>> to occur, and though it will be silently covered up, it wastes time
>> and could perturb state.
>>
>> In perf_callchain_user(), we ensure that %asi contains ASI_AIUS
>> because we know for a fact that the subsequent calls to
>> copy_from_user() are intended to read the user's stack.
>>
>> Signed-off-by: Rob Gardner <rob.gardner@oracle.com>
>> Signed-off-by: Dave Aldridge <david.j.aldridge@oracle.com>
> I applied this, but modified it slightly.
>
> We have shorthand helpers "get_fs()" and "set_fs()" for doing this
> kind of work, and as you can see in arch/sparc/kernel/process_64.c
> and elsewhere this is the canonical way to adjust the %asi value in
> these kinds of circumstances.
>
> Also, set_fs() updates the thread's current_ds value properly.  Notice
> that NGmemcpy.S uses the TI_CURRENT_DS value via the RESTORE_ASI()
> macro.  So if that's not set properly, the %asi restore won't be done
> properly.

Sorry I should have noted this in the log message, but we intentionally 
did not use get_fs() and set_fs() there because they are not safe to use 
in a "nested" interrupt context.  n.b. get_fs() is not guaranteed to 
report a value consistent with %asi while we're executing the perf 
interrupt handler, because it may have interrupted kernel code where 
%asi is inconsistent with the thread_info current_ds value. This is 
common, e.g. right in NGmemcpy.

Rob




