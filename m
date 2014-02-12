From: Kirill Tkhai <tkhai@yandex.ru>
Date: Wed, 12 Feb 2014 11:43:06 +0000
Subject: Re: [PATCH 3/4] sparc64: convert spinlock_t to raw_spinlock_t in mmu_context_t
Message-Id: <341861392205386@web5h.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
References: <1388980510-10190-1-git-send-email-allen.pais@oracle.com> <1388980510-10190-4-git-send-email-allen.pais@oracle.com> <341392153219@web17g.yandex.ru> <52FB2751.2070101@oracle.com> <173231392194038@web29j.yandex.ru> <52FB5AEF.3040807@oracle.com>
In-Reply-To: <52FB5AEF.3040807@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Allen Pais <allen.pais@oracle.com>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "bigeasy@linutronix.de" <bigeasy@linutronix.de>

12.02.2014, 15:29, "Allen Pais" <allen.pais@oracle.com>:
>>>>> =9A=9A=9A[ 1487.027884] I7: <rt_mutex_setprio+0x3c/0x2c0>
>>>>> =9A=9A=9A[ 1487.027885] Call Trace:
>>>>> =9A=9A=9A[ 1487.027887] =9A[00000000004967dc] rt_mutex_setprio+0x3c/0=
x2c0
>>>>> =9A=9A=9A[ 1487.027892] =9A[00000000004afe20] task_blocks_on_rt_mutex=
+0x180/0x200
>>>>> =9A=9A=9A[ 1487.027895] =9A[0000000000819114] rt_spin_lock_slowlock+0=
x94/0x300
>>>>> =9A=9A=9A[ 1487.027897] =9A[0000000000817ebc] __schedule+0x39c/0x53c
>>>>> =9A=9A=9A[ 1487.027899] =9A[00000000008185fc] schedule+0x1c/0xc0
>>>>> =9A=9A=9A[ 1487.027908] =9A[000000000048fff4] smpboot_thread_fn+0x154=
/0x2e0
>>>>> =9A=9A=9A[ 1487.027913] =9A[000000000048753c] kthread+0x7c/0xa0
>>>>> =9A=9A=9A[ 1487.027920] =9A[00000000004060c4] ret_from_syscall+0x1c/0=
x2c
>>>>> =9A=9A=9A[ 1487.027922] =9A[0000000000000000] =9A=9A=9A=9A=9A=9A=9A=
=9A=9A=9A(null)
>>> =9A=9ANow, consistently I've been getting sun4v_data_access_exception.
>>> =9A=9AHere's the trace:
>>> =9A=9A[ 4673.360121] sun4v_data_access_exception: ADDR[0000080000000000=
] CTX[0000] TYPE[0004], going.
>> =9AI've never dived at sparc's tlb before, but it seems now I'm understa=
nding.
>>
>> =9Aarch_enter_lazy_mmu_mode() makes possible delayed tlb flushing. In !R=
T kernel
>> =9Ayou collect flush requests before you really flush all of them.
>>
>> =9AIn RT you collect them too, but you are able to be preempted in any m=
oment.
>> =9ASo, you may switch to other process with unflushed tlb, which is very=
 bad.
>>
>> =9ATry to not to set tb->active =3D 1; in arch_enter_lazy_mmu_mode(). Se=
t it to zero.
>> =9AWe will look if this robust fix helps.
>
> Kirill, Well the change works. So far the machine is up and no stall or c=
rashes
> with Hackbench. I'll run it for longer period and check.

Ok, good.

But I don't know is this the best fix. May we have to implement another opt=
imization
for RT.

For example, collect only batches which does not require smp call function.=
 Or the
main goal of lazy tlb was to prevent smp calls?! It's good to discover this=
..

The other serious thing is to know does __set_pte_at() execute in preemptio=
n disable
context on !RT kernel. Because the place is interesting.

If yes, we have to do the same for RT. If not, then no.

Kirill

>
> Thanks,
>
> Allen
>
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =9Ahttp://vger.kernel.org/majordomo-info.html
