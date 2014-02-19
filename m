From: Kirill Tkhai <tkhai@yandex.ru>
Date: Wed, 19 Feb 2014 08:09:15 +0000
Subject: Re: [PATCH 3/4] sparc64: convert spinlock_t to raw_spinlock_t in mmu_context_t
Message-Id: <253731392797355@web6m.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
References: <1388980510-10190-1-git-send-email-allen.pais@oracle.com> <1388980510-10190-4-git-send-email-allen.pais@oracle.com> <341392153219@web17g.yandex.ru> <52FB2751.2070101@oracle.com> <173231392194038@web29j.yandex.ru> <52FB5AEF.3040807@oracle.com> <341861392205386@web5h.yandex.ru> <52FB65AC.4000808@oracle.com> <268891392209126@web5h.yandex.ru> <53042ACA.6060907@oracle.com>
In-Reply-To: <53042ACA.6060907@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Allen Pais <allen.pais@oracle.com>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "bigeasy@linutronix.de" <bigeasy@linutronix.de>

19.02.2014, 07:54, "Allen Pais" <allen.pais@oracle.com>:
> Kirill,
>
>> =9A12.02.2014, 16:15, "Allen Pais" <allen.pais@oracle.com>:
>>> =9AOn Wednesday 12 February 2014 05:13 PM, Kirill Tkhai wrote:
>>>> =9A=9A12.02.2014, 15:29, "Allen Pais" <allen.pais@oracle.com>:
>>>>>>>>> =9A=9A=9A=9A=9A[ 1487.027884] I7: <rt_mutex_setprio+0x3c/0x2c0>
>>>>>>>>> =9A=9A=9A=9A=9A[ 1487.027885] Call Trace:
>>>>>>>>> =9A=9A=9A=9A=9A[ 1487.027887] =9A[00000000004967dc] rt_mutex_setp=
rio+0x3c/0x2c0
>>>>>>>>> =9A=9A=9A=9A=9A[ 1487.027892] =9A[00000000004afe20] task_blocks_o=
n_rt_mutex+0x180/0x200
>>>>>>>>> =9A=9A=9A=9A=9A[ 1487.027895] =9A[0000000000819114] rt_spin_lock_=
slowlock+0x94/0x300
>>>>>>>>> =9A=9A=9A=9A=9A[ 1487.027897] =9A[0000000000817ebc] __schedule+0x=
39c/0x53c
>>>>>>>>> =9A=9A=9A=9A=9A[ 1487.027899] =9A[00000000008185fc] schedule+0x1c=
/0xc0
>>>>>>>>> =9A=9A=9A=9A=9A[ 1487.027908] =9A[000000000048fff4] smpboot_threa=
d_fn+0x154/0x2e0
>>>>>>>>> =9A=9A=9A=9A=9A[ 1487.027913] =9A[000000000048753c] kthread+0x7c/=
0xa0
>>>>>>>>> =9A=9A=9A=9A=9A[ 1487.027920] =9A[00000000004060c4] ret_from_sysc=
all+0x1c/0x2c
>>>>>>>>> =9A=9A=9A=9A=9A[ 1487.027922] =9A[0000000000000000] =9A=9A=9A=9A=
=9A=9A=9A=9A=9A=9A(null)
>>> =9AI am not convinced that I've covered all tlb/smp code. Guess I'll ne=
ed to dig more.
>> =9A++all above. May we have to add one more crutch... Put preempt_disabl=
e() at begining of
>> =9A__set_pte_at() and enable at end...
>
> =9AI realized locking in tsb is very tricky. My attempts to try and get h=
ackbench run
> without causing a stall failed. So here's what I tried to fix it, am not =
sure if it's
> an appropriate fix, I would love to get comments. I have tested this fix =
for over 24 hours
> with hackbench and dd, the system did not stall :)
>
> diff --git a/arch/sparc/mm/tsb.c b/arch/sparc/mm/tsb.c
> index 9eb10b4..24dcd29 100644
> --- a/arch/sparc/mm/tsb.c
> +++ b/arch/sparc/mm/tsb.c
> @@ -6,6 +6,7 @@
> =9A#include <linux/kernel.h>
> =9A#include <linux/preempt.h>
> =9A#include <linux/slab.h>
> +#include <linux/locallock.h>
> =9A#include <asm/page.h>
> =9A#include <asm/pgtable.h>
> =9A#include <asm/mmu_context.h>
> @@ -14,6 +15,7 @@
> =9A#include <asm/oplib.h>
>
> =9Aextern struct tsb swapper_tsb[KERNEL_TSB_NENTRIES];
> +static DEFINE_LOCAL_IRQ_LOCK(tsb_lock);
>
> =9Astatic inline unsigned long tsb_hash(unsigned long vaddr, unsigned lon=
g hash_sh
> =9A{
> @@ -71,9 +73,9 @@ static void __flush_tsb_one(struct tlb_batch *tb, unsig=
ned lon
> =9Avoid flush_tsb_user(struct tlb_batch *tb)
> =9A{
> =9A=9A=9A=9A=9A=9A=9A=9Astruct mm_struct *mm =3D tb->mm;
> - =9A=9A=9A=9A=9A=9Aunsigned long nentries, base, flags;
> + =9A=9A=9A=9A=9A=9Aunsigned long nentries, base;
>
> - =9A=9A=9A=9A=9A=9Araw_spin_lock_irqsave(&mm->context.lock, flags);
> + =9A=9A=9A=9A=9A=9Alocal_lock(tsb_lock);
>
> =9A=9A=9A=9A=9A=9A=9A=9Abase =3D (unsigned long) mm->context.tsb_block[MM=
_TSB_BASE].tsb;
> =9A=9A=9A=9A=9A=9A=9A=9Anentries =3D mm->context.tsb_block[MM_TSB_BASE].t=
sb_nentries;
> @@ -90,7 +92,7 @@ void flush_tsb_user(struct tlb_batch *tb)
> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A__flush_tsb_one(tb, HPAGE=
_SHIFT, base, nentries);
> =9A=9A=9A=9A=9A=9A=9A=9A}
> =9A#endif
> - =9A=9A=9A=9A=9A=9Araw_spin_unlock_irqrestore(&mm->context.lock, flags);
> + =9A=9A=9A=9A=9A=9Alocal_unlock(tsb_lock);

It seems to be not good for me. Tsb setup is in tsb_grow() and it must
be synchronized with flushing. Flushing is also being made in flush_tsb_use=
r_page()..

Which last stack stack has you received with tb->active, permanently set to=
 zero?

> =9A}
>
> Thanks,
>
> - Allen
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =9Ahttp://vger.kernel.org/majordomo-info.html
