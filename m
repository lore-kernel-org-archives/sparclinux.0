From: Christian Guggenberger
Date: Mon, 02 Feb 2004 08:08:17 +0000
Subject: Re: Oops with 2.6.2-rc3
Message-Id: <1075709297.743.3.camel@bonnie79>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-nzA7toJtgHt6yBid0b59"
List-Id: <sparclinux.vger.kernel.org>
References: <1075667365.2732.4.camel@bonnie79>
In-Reply-To: <1075667365.2732.4.camel@bonnie79>
To: sparclinux@vger.kernel.org


--=-nzA7toJtgHt6yBid0b59
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2004-02-02 at 04:26, Ben Collins wrote:
> > Using defaults from ksymoops -t elf32-sparc -a sparc
> 
> You need to pass the right arguments to ksymoops. It defaults to
> sparc32. Use "-t elf64-sparc -a sparc:v9"

sorry. Right one attached.
Cheers.
Christian


--=-nzA7toJtgHt6yBid0b59
Content-Disposition: attachment; filename=rc3-ksymoops.txt
Content-Type: text/plain; name=rc3-ksymoops.txt; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

ksymoops 2.4.9 on sparc64 2.6.2-rc3.  Options used
     -V (specified)
     -K (specified)
     -l /proc/modules (specified)
     -o /lib/modules/2.6.2-rc3/ (specified)
     -m /boot/System.map-2.6.2-rc3 (specified)
     -t elf64-sparc -a sparc:v9

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Feb  2 03:15:01 rphlx1 kernel: Unable to handle kernel NULL pointer dereference
Feb  2 03:15:01 rphlx1 kernel: tsk->{mm,active_mm}->context = 00000000000006b1
Feb  2 03:15:01 rphlx1 kernel: tsk->{mm,active_mm}->pgd = fffff800462a2000
Feb  2 03:15:01 rphlx1 kernel:               \|/ ____ \|/
Feb  2 03:15:01 rphlx1 kernel:               "@'/ .. \`@"
Feb  2 03:15:01 rphlx1 kernel:               /_| \__/ |_\
Feb  2 03:15:01 rphlx1 kernel:                  \__U_/
Feb  2 03:15:01 rphlx1 kernel: events/1(8): Oops [#1]
Feb  2 03:15:01 rphlx1 kernel: TSTATE: 0000001980f09604 TPC: 000000000044f334 TNPC: 000000000044f338 Y: fffff800    Not tainted
Feb  2 03:15:01 rphlx1 kernel: g0: 006e6673345f7061 g1: 0000000000000000 g2: 00000000004671e0 g3: fffff80045f63b80
Feb  2 03:15:01 rphlx1 kernel: g4: fffff8004031cc60 g5: 0000000000000001 g6: fffff80040364000 g7: 0000000000000000
Feb  2 03:15:01 rphlx1 kernel: o0: 00000000000001b5 o1: 0000000000000000 o2: 0000000000000001 o3: 000000000061bed8
Feb  2 03:15:01 rphlx1 kernel: o4: 000000000000000a o5: fffff80045f63b00 sp: fffff80040367401 ret_pc: 00000000004674f8
Feb  2 03:15:01 rphlx1 kernel: l0: 0000000000000001 l1: 0000000000000000 l2: 0000000000000000 l3: 0000000000000000
Feb  2 03:15:01 rphlx1 kernel: l4: 0000000000000000 l5: 0000000000000000 l6: 0000000000000000 l7: 0000000000000000
Feb  2 03:15:01 rphlx1 kernel: i0: fffff80045f63bc0 i1: 0000000000000003 i2: 0000000000000001 i3: 0000000000000000
Feb  2 03:15:01 rphlx1 kernel: i4: 0000000000000002 i5: 0000000000000000 i6: fffff800403674c1 i7: 000000000044f520


>>TPC; 0044f334 <__wake_up_common+14/80>   <=====

>>g2; 004671e0 <wait_for_helper+0/a0>
>>o3; 0061bed8 <small_digits.0+0/28>
>>ret_pc; 004674f8 <queue_work+f8/120>
>>i7; 0044f520 <complete+40/a0>

Feb  2 03:15:01 rphlx1 kernel: Instruction DUMP: b0062008  80a04018  02600017 <e2584000> b3366000  b73ee000  90007fe8  e0007fe8  92100019 


Code;  000000000044f328 <__wake_up_common+8/80>
0000000000000000 <_TPC>:
Code;  000000000044f328 <__wake_up_common+8/80>
   0:   b0 06 20 08       add  %i0, 8, %i0
Code;  000000000044f32c <__wake_up_common+c/80>
   4:   80 a0 40 18       cmp  %g1, %i0
Code;  000000000044f330 <__wake_up_common+10/80>
   8:   02 60 00 17       be,pn   %xcc, 64 <_TPC+0x64>
Code;  000000000044f334 <__wake_up_common+14/80>
   c:   e2 58 40 00       ldx  [ %g1 ], %l1
Code;  000000000044f338 <__wake_up_common+18/80>
  10:   b3 36 60 00       srl  %i1, 0, %i1
Code;  000000000044f33c <__wake_up_common+1c/80>
  14:   b7 3e e0 00       sra  %i3, 0, %i3
Code;  000000000044f340 <__wake_up_common+20/80>
  18:   90 00 7f e8       add  %g1, -24, %o0
Code;  000000000044f344 <__wake_up_common+24/80>
  1c:   e0 00 7f e8       ld  [ %g1 + -24 ], %l0
Code;  000000000044f348 <__wake_up_common+28/80>
  20:   92 10 00 19       mov  %i1, %o1

Feb  2 03:15:01 rphlx1 kernel: TSTATE: 0000004480f09603 TPC: 000000000044eaa0 TNPC: 000000000044eaa4 Y: 00000000    Not tainted
Feb  2 03:15:01 rphlx1 kernel: g0: 000000000040f574 g1: 00000000000518ea g2: 0000000000000001 g3: 0000000000400400
Feb  2 03:15:01 rphlx1 kernel: g4: 0000000000650a80 g5: 00000000006ca018 g6: 000000000064ca80 g7: 0000000000000a31
Feb  2 03:15:01 rphlx1 kernel: o0: 000000039f7e486c o1: 000000000064ce80 o2: 0000000000416254 o3: 0000000000000000
Feb  2 03:15:01 rphlx1 kernel: o4: 00000000ffff0001 o5: 0000000000ffff00 sp: 000000000064ff61 ret_pc: 000000000044e8ac
Feb  2 03:15:01 rphlx1 kernel: l0: fffff80000c6e8b8 l1: fffff8004788c158 l2: fffff8004788c120 l3: 0000000000650a80
Feb  2 03:15:01 rphlx1 kernel: l4: 0000000000000000 l5: fffff80000c6df80 l6: 000000039f7e486c l7: 0000000000650dc0
Feb  2 03:15:01 rphlx1 kernel: i0: 0000000000000400 i1: 000000000064ca88 i2: 0000000000000104 i3: 0000000000000000
Feb  2 03:15:01 rphlx1 kernel: i4: 000000000002ec06 i5: 00000000011fb0fc i6: 0000000000650031 i7: 00000000004162a4


>>TPC; 000000000044eaa0 <schedule+260/a60>   <=====

>>g0; 000000000040f574 <rt_continue+20/a8>
>>g4; 0000000000650a80 <init_task+0/600>
>>g5; 00000000006ca018 <__per_cpu_offset+0/10>
>>g6; 000000000064ca80 <init_thread_union+0/4000>
>>o1; 000000000064ce80 <init_thread_union+400/4000>
>>o2; 0000000000416254 <cpu_idle+34/c0>
>>sp; 000000000064ff61 <init_thread_union+34e1/4000>
>>ret_pc; 000000000044e8ac <schedule+6c/a60>
>>l3; 0000000000650a80 <init_task+0/600>
>>l7; 0000000000650dc0 <init_task+340/600>
>>i1; 000000000064ca88 <init_thread_union+8/4000>
>>i6; 0000000000650031 <init_thread_union+35b1/4000>
>>i7; 00000000004162a4 <cpu_idle+84/c0>

Feb  2 04:05:42 rphlx1 kernel: Unable to handle kernel NULL pointer dereference
Feb  2 04:05:42 rphlx1 kernel: tsk->{mm,active_mm}->context = 00000000000006d3
Feb  2 04:05:42 rphlx1 kernel: tsk->{mm,active_mm}->pgd = fffff80045a88000
Feb  2 04:05:42 rphlx1 kernel:               \|/ ____ \|/
Feb  2 04:05:42 rphlx1 kernel:               "@'/ .. \`@"
Feb  2 04:05:42 rphlx1 kernel:               /_| \__/ |_\
Feb  2 04:05:42 rphlx1 kernel:                  \__U_/
Feb  2 04:05:42 rphlx1 kernel: events/0(7): Oops [#2]
Feb  2 04:05:42 rphlx1 kernel: TSTATE: 0000001980f09604 TPC: 000000000044f334 TNPC: 000000000044f338 Y: 00000000    Not tainted
Feb  2 04:05:42 rphlx1 kernel: g0: 00000000004088ac g1: 0000000000000000 g2: 00000000004671e0 g3: fffff800456dfb80
Feb  2 04:05:42 rphlx1 kernel: g4: fffff8004031d260 g5: 0000000000000001 g6: fffff80040368000 g7: 0000000000000000
Feb  2 04:05:42 rphlx1 kernel: o0: 00000000000001d1 o1: 0000000000000000 o2: 0000000000000001 o3: 000000000061bed8
Feb  2 04:05:42 rphlx1 kernel: o4: 000000000000000a o5: fffff800456dfb00 sp: fffff8004036b401 ret_pc: 00000000004674f8
Feb  2 04:05:42 rphlx1 kernel: l0: 0000000000000001 l1: 0000000000000000 l2: 0000000000000000 l3: 0000000000000000
Feb  2 04:05:42 rphlx1 kernel: l4: 0000000000000000 l5: 0000000000000000 l6: 0000000000000000 l7: 0000000000000000
Feb  2 04:05:42 rphlx1 kernel: i0: fffff800456dfbc0 i1: 0000000000000003 i2: 0000000000000001 i3: 0000000000000000
Feb  2 04:05:42 rphlx1 kernel: i4: 0000000000000002 i5: 0000000000000000 i6: fffff8004036b4c1 i7: 000000000044f520


>>TPC; 000000000044f334 <__wake_up_common+14/80>   <=====

>>g0; 00000000004088ac <tl0_irq5+c/40>
>>g2; 00000000004671e0 <wait_for_helper+0/a0>
>>o3; 000000000061bed8 <small_digits.0+0/28>
>>ret_pc; 00000000004674f8 <queue_work+f8/120>
>>i7; 000000000044f520 <complete+40/a0>

Feb  2 04:05:42 rphlx1 kernel: Instruction DUMP: b0062008  80a04018  02600017 <e2584000> b3366000  b73ee000  90007fe8  e0007fe8  92100019 


Code;  000000000044f328 <__wake_up_common+8/80>
0000000000000000 <_TPC>:
Code;  000000000044f328 <__wake_up_common+8/80>
   0:   b0 06 20 08       add  %i0, 8, %i0
Code;  000000000044f32c <__wake_up_common+c/80>
   4:   80 a0 40 18       cmp  %g1, %i0
Code;  000000000044f330 <__wake_up_common+10/80>
   8:   02 60 00 17       be,pn   %xcc, 64 <_TPC+0x64>
Code;  000000000044f334 <__wake_up_common+14/80>
   c:   e2 58 40 00       ldx  [ %g1 ], %l1
Code;  000000000044f338 <__wake_up_common+18/80>
  10:   b3 36 60 00       srl  %i1, 0, %i1
Code;  000000000044f33c <__wake_up_common+1c/80>
  14:   b7 3e e0 00       sra  %i3, 0, %i3
Code;  000000000044f340 <__wake_up_common+20/80>
  18:   90 00 7f e8       add  %g1, -24, %o0
Code;  000000000044f344 <__wake_up_common+24/80>
  1c:   e0 00 7f e8       ld  [ %g1 + -24 ], %l0
Code;  000000000044f348 <__wake_up_common+28/80>
  20:   92 10 00 19       mov  %i1, %o1

Feb  2 04:05:42 rphlx1 kernel: TSTATE: 0000004480f09602 TPC: 000000000044eaa0 TNPC: 000000000044eaa4 Y: 00000000    Not tainted
Feb  2 04:05:42 rphlx1 kernel: g0: 000000000040f6c0 g1: 0000000000045228 g2: 0000000000000001 g3: 0000000000400400
Feb  2 04:05:42 rphlx1 kernel: g4: fffff80047eec640 g5: 00000000006ca018 g6: fffff80040334000 g7: 00000000000008a4
Feb  2 04:05:42 rphlx1 kernel: o0: 00000003a3396327 o1: fffff80040334400 o2: 000000000041627c o3: 0000000000000000
Feb  2 04:05:42 rphlx1 kernel: o4: 00000000ffff0001 o5: 0000000000ffff00 sp: fffff800403375b1 ret_pc: 000000000044e8ac
Feb  2 04:05:42 rphlx1 kernel: l0: fffff80000c75fd8 l1: fffff8004788c158 l2: fffff8004788c120 l3: fffff80047eec640
Feb  2 04:05:42 rphlx1 kernel: l4: 0000000000000000 l5: fffff80000c75f80 l6: 00000003a3396327 l7: fffff80047eec980
Feb  2 04:05:42 rphlx1 kernel: i0: 0000000000000400 i1: fffff80040334008 i2: fffff80040554150 i3: fffff80045f48f28
Feb  2 04:05:42 rphlx1 kernel: i4: fffff80040554150 i5: 000000000175c225 i6: fffff80040337681 i7: 00000000004162a4


>>TPC; 000000000044eaa0 <schedule+260/a60>   <=====

>>g0; 000000000040f6c0 <kern_fpucheck+84/c4>
>>g5; 00000000006ca018 <__per_cpu_offset+0/10>
>>o2; 000000000041627c <cpu_idle+5c/c0>
>>ret_pc; 000000000044e8ac <schedule+6c/a60>
>>i7; 00000000004162a4 <cpu_idle+84/c0>


--=-nzA7toJtgHt6yBid0b59--


