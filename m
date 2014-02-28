From: Kirill Tkhai <tkhai@yandex.ru>
Date: Fri, 28 Feb 2014 14:51:23 +0000
Subject: Re: [PATCH 3/4] sparc64: convert spinlock_t to raw_spinlock_t in mmu_context_t
Message-Id: <39171393599083@web13h.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
References: <1388980510-10190-1-git-send-email-allen.pais@oracle.com> <1388980510-10190-4-git-send-email-allen.pais@oracle.com> <341392153219@web17g.yandex.ru> <52FB2751.2070101@oracle.com> <173231392194038@web29j.yandex.ru> <52FB5AEF.3040807@oracle.com> <341861392205386@web5h.yandex.ru> <52FB65AC.4000808@oracle.com> <268891392209126@web5h.yandex.ru> <53042ACA.6060907@oracle.com> <253731392797355@web6m.yandex.ru> <53046763.4070909@oracle.com> <259041392800232@web13m.yandex.ru> <530475A8.3060602@oracle.com> <359241392801938@web24j.yandex.ru> <530D9D1C.1060905@oracle.com>
In-Reply-To: <530D9D1C.1060905@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Allen Pais <allen.pais@oracle.com>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "bigeasy@linutronix.de" <bigeasy@linutronix.de>



26.02.2014, 11:52, "Allen Pais" <allen.pais@oracle.com>:
> Kirill,
>
>>>>>>> =9A=9A=9A=9A--- a/arch/sparc/mm/tsb.c
>>>>>>> =9A=9A=9A=9A+++ b/arch/sparc/mm/tsb.c
>>>>>>> =9A=9A=9A=9A@@ -6,6 +6,7 @@
>>>>>>> =9A=9A=9A=9A=9A#include <linux/kernel.h>
>>>>>>> =9A=9A=9A=9A=9A#include <linux/preempt.h>
>>>>>>> =9A=9A=9A=9A=9A#include <linux/slab.h>
>>>>>>> =9A=9A=9A=9A+#include <linux/locallock.h>
>>>>>>> =9A=9A=9A=9A=9A#include <asm/page.h>
>>>>>>> =9A=9A=9A=9A=9A#include <asm/pgtable.h>
>>>>>>> =9A=9A=9A=9A=9A#include <asm/mmu_context.h>
>>>>>>> =9A=9A=9A=9A@@ -14,6 +15,7 @@
>>>>>>> =9A=9A=9A=9A=9A#include <asm/oplib.h>
>>>>> =9A=9A=9AYes, tb->active was set to zero.
>>>> =9A=9A=9AIf tb->active is zero, flush_tsb_user() is never called, beca=
use of tlb_nr is permanently zero.
>>> =9A=9ASorry, my bad. tb->active was set to one when I ran the test with=
 the above patch.
>
> =9A=9AThe CPU now does not stall, the change I did was remove debug lockd=
ep from the config.
> Now the system runs(cyclicttest/hackbench) producing two of the below men=
tioned crashes.
>
> 1. This is as the messages says, sleeping in atomic context. Am not sure =
who's holding the lock.
> [53990.477387] kernel BUG at kernel/rtmutex.c:738!
> [53990.477393] =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A\|/ ____ \|/
> [53990.477393] =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A"@'/ .. \`@"
> [53990.477393] =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A/_| \__/ |_\
> [53990.477393] =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A\__U_/
> [53990.477396] hackbench(11777): Kernel bad sw trap 5 [#2]
> [53990.477403] CPU: 35 PID: 11777 Comm: hackbench Tainted: G =9A=9A=9A=9A=
=9AD W =9A=9A=9A3.10.24-rt22+ #25
> [53990.477408] task: fffff80f931f9600 ti: fffff80f905ec000 task.ti: fffff=
80f905ec000
> [53990.477413] TSTATE: 0000004411e01600 TPC: 0000000000876ca4 TNPC: 00000=
00000876ca8 Y: 00000000 =9A=9A=9ATainted: G =9A=9A=9A=9A=9AD W
> [53990.477419] TPC: <rt_spin_lock_slowlock+0x304/0x340>
> [53990.477423] g0: 000000000000000e g1: 0000000000000000 g2: 000000000000=
0000 g3: 0000000000de1800
> [53990.477427] g4: fffff80f931f9600 g5: fffff80fd74a0000 g6: fffff80f905e=
c000 g7: 726e656c2f72746d
> [53990.477430] o0: 00000000009bcee8 o1: 00000000000002e2 o2: 000000000000=
0000 o3: 0000000000000001
> [53990.477434] o4: 0000000000000002 o5: 0000000000000000 sp: fffff80f905e=
e6f1 ret_pc: 0000000000876c9c
> [53990.477439] RPC: <rt_spin_lock_slowlock+0x2fc/0x340>
> [53990.477444] l0: fffff80f905eefb0 l1: fffff80f931f9600 l2: fffff80f931f=
9c50 l3: 0000000000a8d800
> [53990.477448] l4: 0000000000000000 l5: 0000000000de1400 l6: 0000000000de=
1440 l7: 0000000000000001
> [53990.477452] i0: fffff80f9026ae70 i1: 0000000000000293 i2: 000000000000=
0000 i3: 0000000000000000
> [53990.477456] i4: 0000000000000002 i5: 0000000000000001 i6: fffff80f905e=
e831 i7: 0000000000876ee0
> [53990.477462] I7: <rt_spin_lock+0x20/0x60>
> [53990.477464] Call Trace:
> [53990.477470] =9A[0000000000876ee0] rt_spin_lock+0x20/0x60
> [53990.477476] =9A[000000000052ee60] unmap_single_vma+0x200/0x6c0
> [53990.477482] =9A[000000000052f348] unmap_vmas+0x28/0x60
> [53990.477488] =9A[0000000000531868] exit_mmap+0x88/0x160
> [53990.477492] =9A[000000000045e0e8] mmput+0x48/0x100
> [53990.477496] =9A[0000000000466a3c] do_exit+0x1fc/0xa40
> [53990.477500] =9A[0000000000427f00] die_if_kernel+0x1a0/0x340
> [53990.477506] =9A[00000000004294a8] sun4v_data_access_exception+0x108/0x=
120
> [53990.477512] =9A[0000000000406c08] sun4v_dacc+0x28/0x34
> [53990.477517] =9A[0000000000407b64] tsb_flush+0x4/0x40
> [53990.477523] =9A[00000000004515a8] flush_tlb_pending+0x68/0xe0
> [53990.477528] =9A[0000000000451800] tlb_batch_add+0x1e0/0x200
> [53990.477534] =9A[000000000053cad8] ptep_clear_flush+0x38/0x60
> [53990.477539] =9A[000000000052b47c] do_wp_page+0x1dc/0x880
> [53990.477544] =9A[000000000052beac] handle_pte_fault+0x38c/0x7c0
> [53990.477548] =9A[000000000052cab8] handle_mm_fault+0xd8/0x160
>
> and
>
> 2. [53998.070198] BUG: NMI Watchdog detected LOCKUP on CPU35, ip 0042f608=
, registers:
> [53998.070206] CPU: 35 PID: 11694 Comm: hackbench Tainted: G =9A=9A=9A=9A=
=9AD W =9A=9A=9A3.10.24-rt22+ #25
> [53998.070211] task: fffff80f91c20000 ti: fffff80f8f40c000 task.ti: fffff=
80f8f40c000
> [53998.070216] TSTATE: 0000000011e01606 TPC: 000000000042f608 TNPC: 00000=
0000042f60c Y: 00000000 =9A=9A=9ATainted: G =9A=9A=9A=9A=9AD W
> [53998.070236] TPC: <stick_get_tick+0x8/0x20>
> [53998.070241] g0: 0000000000000000 g1: 000000000042f600 g2: 00000000076c=
64ec g3: 0000000007a9b280
> [53998.070246] g4: fffff80f91c20000 g5: fffff80fd74a0000 g6: fffff80f8f40=
c000 g7: 0000000000000000
> [53998.070251] o0: 0000000000000001 o1: fffff80f8f40c400 o2: 000000000042=
fa28 o3: 0000000000000000
> [53998.070255] o4: 000000000000004f o5: 0000000000000002 sp: fffff80f8f40=
ee01 ret_pc: 00000000004209f4
> [53998.070264] RPC: <tl0_irq15+0x14/0x20>
> [53998.070267] l0: 0000000000001000 l1: 0000000011001605 l2: 000000000042=
fa24 l3: 0000000000000400
> [53998.070270] l4: 000000000000000e l5: 0000000000000001 l6: 000000000000=
0000 l7: 0000000000000008
> [53998.070272] i0: 0000311023c1caaa i1: fffff80f8f40c400 i2: 000000000066=
f8b0 i3: 0000000000000000
> [53998.070275] i4: fffff80f8ab8e098 i5: fffff80f893f2a70 i6: fffff80f8f40=
eeb1 i7: 000000000042fa10
> [53998.070280] I7: <__delay+0x10/0x60>
> [53998.070282] Call Trace:
> [53998.070286] =9A[000000000042fa10] __delay+0x10/0x60
> [53998.070291] =9A[000000000066f8b8] do_raw_spin_lock+0xb8/0x120
> [53998.070300] =9A[0000000000877b08] _raw_spin_lock_irqsave+0x68/0xa0
> [53998.070306] =9A[0000000000452074] flush_tsb_user+0x14/0x120
> [53998.070309] =9A[00000000004515a8] flush_tlb_pending+0x68/0xe0
> [53998.070312] =9A[0000000000451800] tlb_batch_add+0x1e0/0x200
> [53998.070325] =9A[000000000053cad8] ptep_clear_flush+0x38/0x60
> [53998.070328] =9A[000000000052b47c] do_wp_page+0x1dc/0x880
> [53998.070331] =9A[000000000052beac] handle_pte_fault+0x38c/0x7c0
> [53998.070334] =9A[000000000052cab8] handle_mm_fault+0xd8/0x160
> [53998.070339] =9A[0000000000879724] do_sparc64_fault+0x404/0x700
> [53998.070342] =9A[0000000000407ae0] sparc64_realfault_common+0x10/0x20
>
> But strangely, during boot-up I have more crash messages.
> Here's what I see
>
> [ =9A520.570799] BUG: sleeping function called from invalid context at ke=
rnel/rtmu
> tex.c:659
> [ =9A520.570802] in_atomic(): 0, irqs_disabled(): 1, pid: 2140, name: mod=
probe
> [ =9A520.570803] INFO: lockdep is turned off.
> [ =9A520.570805] irq event stamp: 4502
> [ =9A520.570806] hardirqs last =9Aenabled at (4501): [<00000000004d68c4>]=
 rcu_note_c
> ontext_switch+0xa4/0x300
> [ =9A520.570815] hardirqs last disabled at (4502): [<0000000000877a30>] _=
raw_spin_
> lock_irq+0x10/0x80
> [ =9A520.570822] softirqs last =9Aenabled at (0): [<000000000045eb58>] co=
py_process+
> 0x418/0x1080
> [ =9A520.570828] softirqs last disabled at (0): [< =9A=9A=9A=9A=9A=9A=9A=
=9A=9A(null)>] =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A(nu
> ll)
> [ =9A520.570834] CPU: 18 PID: 2140 Comm: modprobe Tainted: G =9A=9A=9A=9A=
=9A=9A=9AW =9A=9A=9A3.10.24-r
> t22+ #25
> [ =9A520.570835] Call Trace:
> [ =9A520.570842] =9A[0000000000495f0c] __might_sleep+0xec/0x160
> [ =9A520.570846] =9A[0000000000876ed8] rt_spin_lock+0x18/0x60
> [ =9A520.570852] =9A[00000000006e0f78] sunhv_console_write_paged+0x1d8/0x=
200
> [ =9A520.570855] =9A[00000000004625e0] call_console_drivers.clone.2+0x120=
/0x1c0
> [ =9A520.570858] =9A[0000000000462a14] console_unlock+0x394/0x400
> [ =9A520.570861] =9A[0000000000463108] vprintk_emit+0x3a8/0x5a0
> [ =9A520.570863] =9A[0000000000874378] printk+0x38/0x4c
> [ =9A520.570874] =9A[000000001024e78c] _base_make_ioc_operational+0xeac/0=
x1440 [mpt2
> sas]
> [ =9A520.570882] =9A[0000000010253100] mpt2sas_base_attach+0x1720/0x1ae0 =
[mpt2sas]
> [ =9A520.570893] =9A[000000001025b4fc] _scsih_probe+0x4fc/0x700 [mpt2sas]
> [ =9A520.570900] =9A[0000000000686120] local_pci_probe+0x20/0x40
> [ =9A520.570903] =9A[000000000068680c] pci_device_probe+0xec/0x100
> [ =9A520.570907] =9A[00000000006ee574] driver_probe_device+0x74/0x220
> [ =9A520.570909] =9A[00000000006ee7a8] __driver_attach+0x88/0xa0
> [ =9A520.570913] =9A[00000000006eca0c] bus_for_each_dev+0x6c/0xa0
> [ =9A520.570916] =9A[00000000006ee39c] driver_attach+0x1c/0x40

This should be fixed like that's done for 8250
[patch drivers-serial-cleanup-locking-for-rt.patch]


> and this one
>
> [ =9A519.160755] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D> [ =9A5=
19.160756] [ INFO: inconsistent lock state ]
> [ =9A519.160760] 3.10.24-rt22+ #25 Not tainted
> [ =9A519.160761] ---------------------------------
> [ =9A519.160763] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
> [ =9A519.160766] irq/36-MSIQ/640 [HC0[0]:SC0[0]:HE1:SE1] takes:
> [ =9A519.160778] =9A(&irq_desc_lock_class){?.....}, at: [<00000000004d314=
c>] handle_
> simple_irq+0xc/0xe0
> [ =9A519.160779] {IN-HARDIRQ-W} state was registered at:
> [ =9A519.160785] =9A=9A[<00000000004ba7c0>] lock_acquire+0x60/0x100
> [ =9A519.160791] =9A=9A[<0000000000877930>] _raw_spin_lock+0x30/0x80
> [ =9A519.160795] =9A=9A[<00000000004d2e6c>] handle_fasteoi_irq+0xc/0x180
> [ =9A519.160800] =9A=9A[<00000000004cf118>] generic_handle_irq+0x38/0x60
> [ =9A519.160804] =9A=9A[<000000000087bf44>] handler_irq+0xc4/0x100
> [ =9A519.160808] =9A=9A[<0000000000426b2c>] valid_addr_bitmap_patch+0x74/=
0x288
> [ =9A519.160812] =9A=9A[<000000000042ced4>] arch_cpu_idle+0x54/0xe0
> [ =9A519.160817] =9A=9A[<00000000004a85bc>] cpu_startup_entry+0x19c/0x340
> [ =9A519.160822] =9A=9A[<0000000000870f18>] smp_callin+0x100/0x110
> [ =9A519.160825] =9A=9A[<0000000000870a78>] after_lock_tlb+0x1ac/0x1c4
> [ =9A519.160827] =9A=9A[< =9A=9A=9A=9A=9A=9A=9A=9A=9A(null)>] =9A=9A=9A=
=9A=9A=9A=9A=9A=9A=9A(null)
> [ =9A519.160829] irq event stamp: 19
> [ =9A519.160832] hardirqs last =9Aenabled at (19): [<0000000000877cc4>] _=
raw_spin_un
> lock_irq+0x24/0x60
> [ =9A519.160835] hardirqs last disabled at (18): [<0000000000877a30>] _ra=
w_spin_lo
> ck_irq+0x10/0x80
> [ =9A519.160841] softirqs last =9Aenabled at (0): [<000000000045eb58>] co=
py_process+
> 0x418/0x1080
> [ =9A519.160843] softirqs last disabled at (0): [< =9A=9A=9A=9A=9A=9A=9A=
=9A=9A(null)>] =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A(nu
> ll)
> [ =9A519.160844]
> [ =9A519.160844] other info that might help us debug this:
> [ =9A519.160844] =9APossible unsafe locking scenario:
> [ =9A519.160844]
> [ =9A519.160845] =9A=9A=9A=9A=9A=9A=9ACPU0
> [ =9A519.160845] =9A=9A=9A=9A=9A=9A=9A----
> [ =9A519.160847] =9A=9Alock(&irq_desc_lock_class);
> [ =9A519.160848] =9A=9A<Interrupt>
> [ =9A519.160850] =9A=9A=9A=9Alock(&irq_desc_lock_class);
> [ =9A519.160850]
> [ =9A519.160850] =9A*** DEADLOCK ***
> [ =9A519.160850]
> [ =9A519.160852] no locks held by irq/36-MSIQ/640.
> [ =9A519.160853]
> [ =9A519.160853] stack backtrace:
> [ =9A519.160855] CPU: 9 PID: 640 Comm: irq/36-MSIQ Not tainted 3.10.24-rt=
22+ #25
> [ =9A519.160856] Call Trace:
> [ =9A519.160860] =9A[00000000004b50b4] print_usage_bug+0x234/0x2e0
> [ =9A519.160862] =9A[00000000004b5728] mark_lock+0x5c8/0x800
> [ =9A519.160864] =9A[00000000004ba238] __lock_acquire+0x7b8/0xce0
> [ =9A519.160866] =9A[00000000004ba7c0] lock_acquire+0x60/0x100
> [ =9A519.160868] =9A[0000000000877930] _raw_spin_lock+0x30/0x80
> [ =9A519.160870] =9A[00000000004d314c] handle_simple_irq+0xc/0xe0
> [ =9A519.160872] =9A[00000000004cf118] generic_handle_irq+0x38/0x60
> [ =9A519.160877] =9A[0000000000447870] sparc64_msiq_interrupt+0x50/0x120
> [ =9A519.160880] =9A[00000000004d05fc] irq_forced_thread_fn+0x1c/0x80
> [ =9A519.160883] =9A[00000000004d019c] irq_thread+0xdc/0x140
> [ =9A519.160888] =9A[0000000000489560] kthread+0x80/0xa0
> [ =9A519.160893] =9A[0000000000406104] ret_from_syscall+0x1c/0x2c
> [ =9A519.160894] =9A[0000000000000000] =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A(nul=
l)
> [ =9A519.160897] ------------[ cut here ]------------
>
> what do you think?
>
> - Allen
