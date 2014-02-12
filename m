From: Allen Pais <allen.pais@oracle.com>
Date: Wed, 12 Feb 2014 13:17:54 +0000
Subject: Re: [PATCH 3/4] sparc64: convert spinlock_t to raw_spinlock_t in mmu_context_t
Message-Id: <52FB71B2.20409@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1388980510-10190-1-git-send-email-allen.pais@oracle.com> <1388980510-10190-4-git-send-email-allen.pais@oracle.com> <341392153219@web17g.yandex.ru> <52FB2751.2070101@oracle.com> <173231392194038@web29j.yandex.ru> <52FB5AEF.3040807@oracle.com> <341861392205386@web5h.yandex.ru> <52FB65AC.4000808@oracle.com> <268891392209126@web5h.yandex.ru>
In-Reply-To: <268891392209126@web5h.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kirill Tkhai <tkhai@yandex.ru>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "bigeasy@linutronix.de" <bigeasy@linutronix.de>

On Wednesday 12 February 2014 06:15 PM, Kirill Tkhai wrote:
> 
> 
> 12.02.2014, 16:15, "Allen Pais" <allen.pais@oracle.com>:
>> On Wednesday 12 February 2014 05:13 PM, Kirill Tkhai wrote:
>>
>>>  12.02.2014, 15:29, "Allen Pais" <allen.pais@oracle.com>:
>>>>>>>>     [ 1487.027884] I7: <rt_mutex_setprio+0x3c/0x2c0>
>>>>>>>>     [ 1487.027885] Call Trace:
>>>>>>>>     [ 1487.027887]  [00000000004967dc] rt_mutex_setprio+0x3c/0x2c0
>>>>>>>>     [ 1487.027892]  [00000000004afe20] task_blocks_on_rt_mutex+0x180/0x200
>>>>>>>>     [ 1487.027895]  [0000000000819114] rt_spin_lock_slowlock+0x94/0x300
>>>>>>>>     [ 1487.027897]  [0000000000817ebc] __schedule+0x39c/0x53c
>>>>>>>>     [ 1487.027899]  [00000000008185fc] schedule+0x1c/0xc0
>>>>>>>>     [ 1487.027908]  [000000000048fff4] smpboot_thread_fn+0x154/0x2e0
>>>>>>>>     [ 1487.027913]  [000000000048753c] kthread+0x7c/0xa0
>>>>>>>>     [ 1487.027920]  [00000000004060c4] ret_from_syscall+0x1c/0x2c
>>>>>>>>     [ 1487.027922]  [0000000000000000]           (null)

>>
>> I am not convinced that I've covered all tlb/smp code. Guess I'll need to dig more.
> 
> ++all above. May we have to add one more crutch... Put preempt_disable() at begining of
> __set_pte_at() and enable at end...
> 
I'll look into it. Thanks again.

Allen

