From: Kirill Tkhai <tkhai@yandex.ru>
Date: Tue, 04 Mar 2014 20:44:05 +0000
Subject: Re: [PATCH 3/4] sparc64: convert spinlock_t to raw_spinlock_t in mmu_context_t
Message-Id: <53163B15.7060905@yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
References: <341392153219@web17g.yandex.ru>	<52FB2751.2070101@oracle.com>	<173231392194038@web29j.yandex.ru> <20140304.145523.176895354551282596.davem@davemloft.net>
In-Reply-To: <20140304.145523.176895354551282596.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: allen.pais@oracle.com, linux-rt-users@vger.kernel.org, sparclinux@vger.kernel.org, bigeasy@linutronix.de

On 04.03.2014 23:55, David Miller wrote:
> From: Kirill Tkhai <tkhai@yandex.ru>
> Date: Wed, 12 Feb 2014 12:33:58 +0400
> 
>> 12.02.2014, 11:48, "Allen Pais" <allen.pais@oracle.com>:
>>
>>>  On Wednesday 12 February 2014 02:43 AM, Kirill Tkhai wrote:
>>>>   06.01.2014, 07:56, "Allen Pais" <allen.pais@oracle.com>:
>>>>>   In the attempt of get PREEMPT_RT working on sparc64 using
>>>>>   linux-stable-rt version 3.10.22-rt19+, the kernel crash
>>>>>   with the following trace:
>>>>>
>>>>>   [ 1487.027884] I7: <rt_mutex_setprio+0x3c/0x2c0>
>>>>>   [ 1487.027885] Call Trace:
>>>>>   [ 1487.027887]  [00000000004967dc] rt_mutex_setprio+0x3c/0x2c0
>>>>>   [ 1487.027892]  [00000000004afe20] task_blocks_on_rt_mutex+0x180/0x200
>>>>>   [ 1487.027895]  [0000000000819114] rt_spin_lock_slowlock+0x94/0x300
>>>>>   [ 1487.027897]  [0000000000817ebc] __schedule+0x39c/0x53c
>>>>>   [ 1487.027899]  [00000000008185fc] schedule+0x1c/0xc0
>>>>>   [ 1487.027908]  [000000000048fff4] smpboot_thread_fn+0x154/0x2e0
>>>>>   [ 1487.027913]  [000000000048753c] kthread+0x7c/0xa0
>>>>>   [ 1487.027920]  [00000000004060c4] ret_from_syscall+0x1c/0x2c
>>>>>   [ 1487.027922]  [0000000000000000]           (null)
>>>  Now, consistently I've been getting sun4v_data_access_exception.
>>>  Here's the trace:
>>>  [ 4673.360121] sun4v_data_access_exception: ADDR[0000080000000000] CTX[0000] TYPE[0004], going.
>>
>> I've never dived at sparc's tlb before, but it seems now I'm understanding.
>>
>> arch_enter_lazy_mmu_mode() makes possible delayed tlb flushing. In !RT kernel
>> you collect flush requests before you really flush all of them.
>>
>> In RT you collect them too, but you are able to be preempted in any moment.
>> So, you may switch to other process with unflushed tlb, which is very bad.
>>
>> Try to not to set tb->active = 1; in arch_enter_lazy_mmu_mode(). Set it to zero.
>> We will look if this robust fix helps.
> 
> Sorry for coming into this discussion so late.
> 
> Indeed, the pending flushes are per-cpu and we must flush them out in the
> event of a preemption.
> 
> PowerPC does the same exact thing with arch_enter_lazy_mmu_mode(), in
> fact that's where I copied the logic from.  Does PowerPC not work with
> -rt? :-)
> 

It does not work, but we will :)
