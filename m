From: Allen Pais <allen.pais@oracle.com>
Date: Wed, 12 Feb 2014 11:40:47 +0000
Subject: Re: [PATCH 3/4] sparc64: convert spinlock_t to raw_spinlock_t in mmu_context_t
Message-Id: <52FB5AEF.3040807@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1388980510-10190-1-git-send-email-allen.pais@oracle.com> <1388980510-10190-4-git-send-email-allen.pais@oracle.com> <341392153219@web17g.yandex.ru> <52FB2751.2070101@oracle.com> <173231392194038@web29j.yandex.ru>
In-Reply-To: <173231392194038@web29j.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kirill Tkhai <tkhai@yandex.ru>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "bigeasy@linutronix.de" <bigeasy@linutronix.de>

>>>>   [ 1487.027884] I7: <rt_mutex_setprio+0x3c/0x2c0>
>>>>   [ 1487.027885] Call Trace:
>>>>   [ 1487.027887]  [00000000004967dc] rt_mutex_setprio+0x3c/0x2c0
>>>>   [ 1487.027892]  [00000000004afe20] task_blocks_on_rt_mutex+0x180/0x200
>>>>   [ 1487.027895]  [0000000000819114] rt_spin_lock_slowlock+0x94/0x300
>>>>   [ 1487.027897]  [0000000000817ebc] __schedule+0x39c/0x53c
>>>>   [ 1487.027899]  [00000000008185fc] schedule+0x1c/0xc0
>>>>   [ 1487.027908]  [000000000048fff4] smpboot_thread_fn+0x154/0x2e0
>>>>   [ 1487.027913]  [000000000048753c] kthread+0x7c/0xa0
>>>>   [ 1487.027920]  [00000000004060c4] ret_from_syscall+0x1c/0x2c
>>>>   [ 1487.027922]  [0000000000000000]           (null)
>>  Now, consistently I've been getting sun4v_data_access_exception.
>>  Here's the trace:
>>  [ 4673.360121] sun4v_data_access_exception: ADDR[0000080000000000] CTX[0000] TYPE[0004], going.
> 
> I've never dived at sparc's tlb before, but it seems now I'm understanding.
> 
> arch_enter_lazy_mmu_mode() makes possible delayed tlb flushing. In !RT kernel
> you collect flush requests before you really flush all of them.
> 
> In RT you collect them too, but you are able to be preempted in any moment.
> So, you may switch to other process with unflushed tlb, which is very bad.
> 
> Try to not to set tb->active = 1; in arch_enter_lazy_mmu_mode(). Set it to zero.
> We will look if this robust fix helps.
> 

Kirill, Well the change works. So far the machine is up and no stall or crashes
with Hackbench. I'll run it for longer period and check.

Thanks,

Allen

 

