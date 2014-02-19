From: Kirill Tkhai <tkhai@yandex.ru>
Date: Wed, 19 Feb 2014 08:57:12 +0000
Subject: Re: [PATCH 3/4] sparc64: convert spinlock_t to raw_spinlock_t in mmu_context_t
Message-Id: <259041392800232@web13m.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
References: <1388980510-10190-1-git-send-email-allen.pais@oracle.com> <1388980510-10190-4-git-send-email-allen.pais@oracle.com> <341392153219@web17g.yandex.ru> <52FB2751.2070101@oracle.com> <173231392194038@web29j.yandex.ru> <52FB5AEF.3040807@oracle.com> <341861392205386@web5h.yandex.ru> <52FB65AC.4000808@oracle.com> <268891392209126@web5h.yandex.ru> <53042ACA.6060907@oracle.com> <253731392797355@web6m.yandex.ru> <53046763.4070909@oracle.com>
In-Reply-To: <53046763.4070909@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Allen Pais <allen.pais@oracle.com>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "bigeasy@linutronix.de" <bigeasy@linutronix.de>



19.02.2014, 12:12, "Allen Pais" <allen.pais@oracle.com>:
>>> =9Adiff --git a/arch/sparc/mm/tsb.c b/arch/sparc/mm/tsb.c
>>> =9Aindex 9eb10b4..24dcd29 100644
>>> =9A--- a/arch/sparc/mm/tsb.c
>>> =9A+++ b/arch/sparc/mm/tsb.c
>>> =9A@@ -6,6 +6,7 @@
>>> =9A=9A#include <linux/kernel.h>
>>> =9A=9A#include <linux/preempt.h>
>>> =9A=9A#include <linux/slab.h>
>>> =9A+#include <linux/locallock.h>
>>> =9A=9A#include <asm/page.h>
>>> =9A=9A#include <asm/pgtable.h>
>>> =9A=9A#include <asm/mmu_context.h>
>>> =9A@@ -14,6 +15,7 @@
>>> =9A=9A#include <asm/oplib.h>
>>>
>>> =9A=9Aextern struct tsb swapper_tsb[KERNEL_TSB_NENTRIES];
>>> =9A+static DEFINE_LOCAL_IRQ_LOCK(tsb_lock);
>>>
>>> =9A=9Astatic inline unsigned long tsb_hash(unsigned long vaddr, unsigne=
d long hash_sh
>>> =9A=9A{
>>> =9A@@ -71,9 +73,9 @@ static void __flush_tsb_one(struct tlb_batch *tb, =
unsigned lon
>>> =9A=9Avoid flush_tsb_user(struct tlb_batch *tb)
>>> =9A=9A{
>>> =9A=9A=9A=9A=9A=9A=9A=9A=9Astruct mm_struct *mm =3D tb->mm;
>>> =9A- =9A=9A=9A=9A=9A=9Aunsigned long nentries, base, flags;
>>> =9A+ =9A=9A=9A=9A=9A=9Aunsigned long nentries, base;
>>>
>>> =9A- =9A=9A=9A=9A=9A=9Araw_spin_lock_irqsave(&mm->context.lock, flags);
>>> =9A+ =9A=9A=9A=9A=9A=9Alocal_lock(tsb_lock);
>>>
>>> =9A=9A=9A=9A=9A=9A=9A=9A=9Abase =3D (unsigned long) mm->context.tsb_blo=
ck[MM_TSB_BASE].tsb;
>>> =9A=9A=9A=9A=9A=9A=9A=9A=9Anentries =3D mm->context.tsb_block[MM_TSB_BA=
SE].tsb_nentries;
>>> =9A@@ -90,7 +92,7 @@ void flush_tsb_user(struct tlb_batch *tb)
>>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A__flush_tsb_one(tb, =
HPAGE_SHIFT, base, nentries);
>>> =9A=9A=9A=9A=9A=9A=9A=9A=9A}
>>> =9A=9A#endif
>>> =9A- =9A=9A=9A=9A=9A=9Araw_spin_unlock_irqrestore(&mm->context.lock, fl=
ags);
>>> =9A+ =9A=9A=9A=9A=9A=9Alocal_unlock(tsb_lock);
>> =9AIt seems to be not good for me. Tsb setup is in tsb_grow() and it must
>> =9Abe synchronized with flushing. Flushing is also being made in flush_t=
sb_user_page()..
>>
>> =9AWhich last stack stack has you received with tb->active, permanently =
set to zero?
>
> I agree with you point about flushing in flush_tbs_user_page too. Like i =
said, this is
> a bit tricky to actually debug.
>
> Yes, tb->active was set to zero.

If tb->active is zero, flush_tsb_user() is never called, because of tlb_nr =
is permanently zero.

> - Allen
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =9Ahttp://vger.kernel.org/majordomo-info.html
