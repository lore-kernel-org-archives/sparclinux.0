From: Meelis Roos <mroos@linux.ee>
Date: Tue, 23 Aug 2016 08:59:28 +0000
Subject: Cascading crash on ECC error
Message-Id: <alpine.LRH.2.20.1608231319140.14842@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

This happens on my trusty Ultra 5. The root cause seems to be a failing=20
DIMM. Where it gets interesting is how this failure is detected and how=20
it causes a full crash up to RED state exception.

What should actually happen when uncorrectable memory error happens? If=20
this happens from IRQ context, not process context, this should cause=20
kernel panic, right?

But why do we detect this error from IRQ context - is it just random or=20
do we get an error interrupt and therefore always detect this in IRQ=20
context, and always get kernel panic?

Second, why do we get to RED state exceptioin from here?

CPU[0]: Uncorrectable Error AFSR[180300000] AFAR[468980] UDBL[8c000] UDBH[5=
60] TT[a] TL>1[0]
CPU[0]: UDBH Syndrome[48] Memory Module "DIMM1"
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
swapper(0): UE [#1]
CPU: 0 PID: 0 Comm: swapper Tainted: G        W       4.7.0-rc6-dirty #45
task: 0000000000aacd08 ti: 0000000000a9c000 task.ti: 0000000000a9c000
TSTATE: 0000009980e01600 TPC: 0000000000468980 TNPC: 0000000000468990 Y: 00=
000000    Tainted: G        W     =20
TPC: <prepare_signal+0x180/0x260>
g0: 0000000000b20400 g1: 0000000000000000 g2: 0000000000000000 g3: 00000000=
00000000
g4: 0000000000aacd08 g5: 0000000000000000 g6: 0000000000a9c000 g7: 00000000=
00000000
o0: 0000000000000000 o1: 0000000000000000 o2: 0000000000000000 o3: 00000000=
00000000
o4: 0000000001833c00 o5: 0000000000af3800 sp: 0000000000a9eb11 ret_pc: 0000=
000000498f14
RPC: <lock_release+0xd4/0x520>
l0: 000000000000000e l1: 0000000001833c00 l2: 000000000000000e l3: 00000000=
00b1f000
l4: 0000000000aacd08 l5: 0000000000000018 l6: 0000000000000000 l7: 00000000=
00000000
i0: 000000000000000e i1: fffff8001f5e00c0 i2: 0000000000000000 i3: fffff800=
1e657580
i4: 000000000000000d i5: 0000000000b1e000 i6: 0000000000a9ebd1 i7: 00000000=
00468d2c
I7: <__send_signal.constprop.19+0x4c/0x400>
Call Trace:
 [0000000000468d2c] __send_signal.constprop.19+0x4c/0x400
 [000000000046a088] do_send_sig_info+0x28/0x60
 [000000000046a530] group_send_sig_info+0x150/0x180
 [000000000046a6d8] kill_pid_info+0xd8/0x180
 [00000000004b793c] it_real_fn+0x15c/0x180
 [00000000004b61a0] __hrtimer_run_queues.constprop.21+0x320/0x580
 [00000000004b6edc] hrtimer_interrupt+0x9c/0x1c0
 [000000000095eb88] timer_interrupt+0x68/0xa0
 [0000000000426b7c] sys_call_table+0x5dc/0x760
 [000000000042c454] arch_cpu_idle+0x34/0x80
 [000000000048f924] default_idle_call+0x44/0x60
 [000000000048fb7c] cpu_startup_entry+0x23c/0x320
 [0000000000955c00] rest_init+0x180/0x1a0
 [0000000000b30a20] start_kernel+0x40c/0x41c
 [0000000000b31f00] start_early_boot+0x248/0x258
 [0000000000955a60] tlb_fixup_done+0x4c/0x6c
Caller[0000000000468d2c]: __send_signal.constprop.19+0x4c/0x400
Caller[000000000046a088]: do_send_sig_info+0x28/0x60
Caller[000000000046a530]: group_send_sig_info+0x150/0x180
Caller[000000000046a6d8]: kill_pid_info+0xd8/0x180
Caller[00000000004b793c]: it_real_fn+0x15c/0x180
Caller[00000000004b61a0]: __hrtimer_run_queues.constprop.21+0x320/0x580
Caller[00000000004b6edc]: hrtimer_interrupt+0x9c/0x1c0
Caller[000000000095eb88]: timer_interrupt+0x68/0xa0
Caller[0000000000426b7c]: sys_call_table+0x5dc/0x760
Caller[000000000042c448]: arch_cpu_idle+0x28/0x80
Caller[000000000048f924]: default_idle_call+0x44/0x60
Caller[000000000048fb7c]: cpu_startup_entry+0x23c/0x320
Caller[0000000000955c00]: rest_init+0x180/0x1a0
Caller[0000000000b30a20]: start_kernel+0x40c/0x41c
Caller[0000000000b31f00]: start_early_boot+0x248/0x258
Caller[0000000000955a60]: tlb_fixup_done+0x4c/0x6c
Caller[0000000000000000]:           (null)
Instruction DUMP: 82102012  c45e6480  8530901c <8088a001> 1260002a  8210200=
1  c45e6488  8530901c  8088a001=20
Kernel panic - not syncing: Aiee, killing interrupt handler!
Press Stop-A (L1-A) to return to the boot prom
---[ end Kernel panic - not syncing: Aiee, killing interrupt handler!
Kernel unaligned access at TPC[494a30] validate_chain.isra.21+0x7b0/0x1740
Unable to handle kernel NULL pointer dereference in mna handler
 at virtual address 00000000000000da
current->{active_,}mm->context =3D 00000000000002b5
current->{active_,}mm->pgd =3D fffff8001e7f6000
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
swapper(0): Oops [#2]
CPU: 0 PID: 0 Comm: swapper Tainted: G      D W       4.7.0-rc6-dirty #45
task: 0000000000aacd08 ti: 0000000000a9c000 task.ti: 0000000000a9c000
TSTATE: 0000009980e01603 TPC: 0000000000494a30 TNPC: 0000000000494a34 Y: 00=
000000    Tainted: G      D W     =20
TPC: <validate_chain.isra.21+0x7b0/0x1740>
g0: 0000000000af8918 g1: 0000000000000000 g2: 00000000dead4ead g3: 00000000=
00000000
g4: 0000000000aacd08 g5: 0000000000000000 g6: 0000000000a9c000 g7: 2c93541a=
0dde210a
o0: fffff8001f178200 o1: 000000000000000c o2: 0000000000000001 o3: 00000000=
00000000
o4: 0000000000aaf368 o5: fffff8001f1782a0 sp: 0000000000a9e131 ret_pc: 0000=
0000004600d0
RPC: <irq_exit+0x10/0xc0>
l0: 0000000000b1f000 l1: 0000000000000046 l2: 0000000000000001 l3: 00000000=
0000000a
l4: 0000000000000001 l5: 0000000001827400 l6: 0000000000000000 l7: 00000000=
00000000
i0: 0000000000000000 i1: 0000000000a9c3f8 i2: 000000000042f628 i3: 00000000=
00000000
i4: 0000000000af3000 i5: 0000000000aacd08 i6: 0000000000a9e1e1 i7: 00000000=
0095ead0
I7: <handler_irq+0x90/0xe0>
Call Trace:
 [000000000095ead0] handler_irq+0x90/0xe0
 [0000000000426b4c] sys_call_table+0x5ac/0x760
 [000000000042fda4] __delay+0x24/0x60
 [000000000042fdec] udelay+0xc/0x20
 [000000000052ef60] panic+0x260/0x270
 [000000000045e48c] do_exit+0x6c/0xc40

RED State Exception

TL=0000.0000.0000.0005 TT=0000.0000.0000.0034
   TPC=0000.0000.0040.4a40 TnPC=0000.0000.0040.4a44 TSTATE=0000.0000.8000.1=
502
TL=0000.0000.0000.0004 TT=0000.0000.0000.01ff
   TPC=FFff.ffff.ffff.fffc TnPC=FFff.ffff.ffff.fffc TSTATE=0000.00ef.ff0f.f=
305
TL=0000.0000.0000.0003 TT=0000.0000.0000.0068
   TPC=0000.0000.f000.4e70 TnPC=0000.0000.f000.4e74 TSTATE=0000.0080.5804.1=
406
TL=0000.0000.0000.0002 TT=0000.0000.0000.0010
   TPC=0000.0000.0042.0c60 TnPC=0000.0000.0042.0c64 TSTATE=0000.0000.8000.1=
502
TL=0000.0000.0000.0001 TT=0000.0000.0000.0063
   TPC=0000.0000.0042.8f48 TnPC=0000.0000.0042.8f4c TSTATE=0000.0000.8000.1=
602


--=20
Meelis Roos (mroos@linux.ee)
