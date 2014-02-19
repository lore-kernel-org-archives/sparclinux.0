From: Allen Pais <allen.pais@oracle.com>
Date: Wed, 19 Feb 2014 09:25:12 +0000
Subject: Re: [PATCH 3/4] sparc64: convert spinlock_t to raw_spinlock_t in mmu_context_t
Message-Id: <530475A8.3060602@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1388980510-10190-1-git-send-email-allen.pais@oracle.com> <1388980510-10190-4-git-send-email-allen.pais@oracle.com> <341392153219@web17g.yandex.ru> <52FB2751.2070101@oracle.com> <173231392194038@web29j.yandex.ru> <52FB5AEF.3040807@oracle.com> <341861392205386@web5h.yandex.ru> <52FB65AC.4000808@oracle.com> <268891392209126@web5h.yandex.ru> <53042ACA.6060907@oracle.com> <253731392797355@web6m.yandex.ru> <53046763.4070909@oracle.com> <259041392800232@web13m.yandex.ru>
In-Reply-To: <259041392800232@web13m.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kirill Tkhai <tkhai@yandex.ru>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "bigeasy@linutronix.de" <bigeasy@linutronix.de>

On Wednesday 19 February 2014 02:27 PM, Kirill Tkhai wrote:
> 
> 
> 19.02.2014, 12:12, "Allen Pais" <allen.pais@oracle.com>:
>>>>  diff --git a/arch/sparc/mm/tsb.c b/arch/sparc/mm/tsb.c
>>>>  index 9eb10b4..24dcd29 100644
>>>>  --- a/arch/sparc/mm/tsb.c
>>>>  +++ b/arch/sparc/mm/tsb.c
>>>>  @@ -6,6 +6,7 @@
>>>>   #include <linux/kernel.h>
>>>>   #include <linux/preempt.h>
>>>>   #include <linux/slab.h>
>>>>  +#include <linux/locallock.h>
>>>>   #include <asm/page.h>
>>>>   #include <asm/pgtable.h>
>>>>   #include <asm/mmu_context.h>
>>>>  @@ -14,6 +15,7 @@
>>>>   #include <asm/oplib.h>
>>>>
>>>>   extern struct tsb swapper_tsb[KERNEL_TSB_NENTRIES];
>>>>  +static DEFINE_LOCAL_IRQ_LOCK(tsb_lock);
>>>>
>>>>   static inline unsigned long tsb_hash(unsigned long vaddr, unsigned long hash_sh
>>>>   {
>>>>  @@ -71,9 +73,9 @@ static void __flush_tsb_one(struct tlb_batch *tb, unsigned lon
>>>>   void flush_tsb_user(struct tlb_batch *tb)
>>>>   {
>>>>          struct mm_struct *mm = tb->mm;
>>>>  -       unsigned long nentries, base, flags;
>>>>  +       unsigned long nentries, base;
>>>>
>>>>  -       raw_spin_lock_irqsave(&mm->context.lock, flags);
>>>>  +       local_lock(tsb_lock);
>>>>
>>>>          base = (unsigned long) mm->context.tsb_block[MM_TSB_BASE].tsb;
>>>>          nentries = mm->context.tsb_block[MM_TSB_BASE].tsb_nentries;
>>>>  @@ -90,7 +92,7 @@ void flush_tsb_user(struct tlb_batch *tb)
>>>>                  __flush_tsb_one(tb, HPAGE_SHIFT, base, nentries);
>>>>          }
>>>>   #endif
>>>>  -       raw_spin_unlock_irqrestore(&mm->context.lock, flags);
>>>>  +       local_unlock(tsb_lock);
>>>  It seems to be not good for me. Tsb setup is in tsb_grow() and it must
>>>  be synchronized with flushing. Flushing is also being made in flush_tsb_user_page()..
>>>
>>>  Which last stack stack has you received with tb->active, permanently set to zero?
>>
>> I agree with you point about flushing in flush_tbs_user_page too. Like i said, this is
>> a bit tricky to actually debug.
>>
>> Yes, tb->active was set to zero.
> 
> If tb->active is zero, flush_tsb_user() is never called, because of tlb_nr is permanently zero.
>
Sorry, my bad. tb->active was set to one when I ran the test with the above patch.

- Allen

