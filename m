From: Allen Pais <allen.pais@oracle.com>
Date: Wed, 19 Feb 2014 03:54:15 +0000
Subject: Re: [PATCH 3/4] sparc64: convert spinlock_t to raw_spinlock_t in mmu_context_t
Message-Id: <53042ACA.6060907@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1388980510-10190-1-git-send-email-allen.pais@oracle.com> <1388980510-10190-4-git-send-email-allen.pais@oracle.com> <341392153219@web17g.yandex.ru> <52FB2751.2070101@oracle.com> <173231392194038@web29j.yandex.ru> <52FB5AEF.3040807@oracle.com> <341861392205386@web5h.yandex.ru> <52FB65AC.4000808@oracle.com> <268891392209126@web5h.yandex.ru>
In-Reply-To: <268891392209126@web5h.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kirill Tkhai <tkhai@yandex.ru>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "bigeasy@linutronix.de" <bigeasy@linutronix.de>

Kirill,
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


 I realized locking in tsb is very tricky. My attempts to try and get hackbench run
without causing a stall failed. So here's what I tried to fix it, am not sure if it's
an appropriate fix, I would love to get comments. I have tested this fix for over 24 hours
with hackbench and dd, the system did not stall :)

diff --git a/arch/sparc/mm/tsb.c b/arch/sparc/mm/tsb.c
index 9eb10b4..24dcd29 100644
--- a/arch/sparc/mm/tsb.c
+++ b/arch/sparc/mm/tsb.c
@@ -6,6 +6,7 @@
 #include <linux/kernel.h>
 #include <linux/preempt.h>
 #include <linux/slab.h>
+#include <linux/locallock.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/mmu_context.h>
@@ -14,6 +15,7 @@
 #include <asm/oplib.h>
 
 extern struct tsb swapper_tsb[KERNEL_TSB_NENTRIES];
+static DEFINE_LOCAL_IRQ_LOCK(tsb_lock);
 
 static inline unsigned long tsb_hash(unsigned long vaddr, unsigned long hash_sh
 {
@@ -71,9 +73,9 @@ static void __flush_tsb_one(struct tlb_batch *tb, unsigned lon
 void flush_tsb_user(struct tlb_batch *tb)
 {
        struct mm_struct *mm = tb->mm;
-       unsigned long nentries, base, flags;
+       unsigned long nentries, base;
 
-       raw_spin_lock_irqsave(&mm->context.lock, flags);
+       local_lock(tsb_lock);
 
        base = (unsigned long) mm->context.tsb_block[MM_TSB_BASE].tsb;
        nentries = mm->context.tsb_block[MM_TSB_BASE].tsb_nentries;
@@ -90,7 +92,7 @@ void flush_tsb_user(struct tlb_batch *tb)
                __flush_tsb_one(tb, HPAGE_SHIFT, base, nentries);
        }
 #endif
-       raw_spin_unlock_irqrestore(&mm->context.lock, flags);
+       local_unlock(tsb_lock);
 }


Thanks,

- Allen
