From: Christian Guggenberger
Date: Sun, 01 Feb 2004 20:29:25 +0000
Subject: Oops with 2.6.2-rc3
Message-Id: <1075667365.2732.4.camel@bonnie79>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-+FNuYvKvP4UczLziVMuo"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-+FNuYvKvP4UczLziVMuo
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

on a UE2 running debian/unstable I get the attached oops with
linux-2.6.2-rc3 booted with silo-1.4.4 .

thanks.
Christian


--=-+FNuYvKvP4UczLziVMuo
Content-Disposition: attachment; filename=oops-rc3-ksymoops.txt
Content-Type: text/plain; name=oops-rc3-ksymoops.txt; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

ksymoops 2.4.9 on sparc64 2.6.2-rc3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.2-rc3/ (default)
     -m /boot/System.map-2.6.2-rc3 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Feb  1 20:51:50 eclipse kernel: Unable to handle kernel NULL pointer dereference
Feb  1 20:51:50 eclipse kernel: tsk->{mm,active_mm}->context = 00000000000006a4
Feb  1 20:51:50 eclipse kernel: tsk->{mm,active_mm}->pgd = fffff80045f54000
Feb  1 20:51:50 eclipse kernel:               \|/ ____ \|/
Feb  1 20:51:50 eclipse kernel:               "@'/ .. \`@"
Feb  1 20:51:50 eclipse kernel:               /_| \__/ |_\
Feb  1 20:51:50 eclipse kernel:                  \__U_/
Feb  1 20:51:50 eclipse kernel: events/1(8): Oops [#1]
Feb  1 20:51:51 eclipse kernel: TSTATE: 0000001980f09604 TPC: 000000000044f334 TNPC: 000000000044f338 Y: fffff800    Not tainted
Using defaults from ksymoops -t elf32-sparc -a sparc
Feb  1 20:51:51 eclipse kernel: g0: 006e6673345f7061 g1: 0000000000000000 g2: 00000000004671e0 g3: fffff800458a3b80
Feb  1 20:51:51 eclipse kernel: g4: fffff8004031cc60 g5: 0000000000000001 g6: fffff80040364000 g7: 0000000000000000
Feb  1 20:51:51 eclipse kernel: o0: 00000000000001aa o1: 0000000000000000 o2: 0000000000000001 o3: 000000000061bed8
Feb  1 20:51:51 eclipse kernel: o4: 000000000000000a o5: fffff800458a3b00 sp: fffff80040367401 ret_pc: 00000000004674f8
Feb  1 20:51:51 eclipse kernel: l0: 0000000000000001 l1: 0000000000000000 l2: 0000000000000000 l3: 0000000000000000
Feb  1 20:51:51 eclipse kernel: l4: 0000000000000000 l5: 0000000000000000 l6: 0000000000000000 l7: 0000000000000000
Feb  1 20:51:51 eclipse kernel: i0: fffff800458a3bc0 i1: 0000000000000003 i2: 0000000000000001 i3: 0000000000000000
Feb  1 20:51:51 eclipse kernel: i4: 0000000000000002 i5: 0000000000000000 i6: fffff800403674c1 i7: 000000000044f520


>>PC;  0044f334 <__wake_up_common+14/80>   <=====

>>g2; 004671e0 <wait_for_helper+0/a0>
>>o3; 0061bed8 <small_digits.0+0/28>
>>ret_pc; 004674f8 <queue_work+f8/120>
>>i7; 0044f520 <complete+40/a0>

Feb  1 20:51:51 eclipse kernel: Instruction DUMP: b0062008  80a04018  02600017 <e2584000> b3366000  b73ee000  90007fe8  e0007fe8  92100019 


Code;  0044f328 <__wake_up_common+8/80>
00000000 <_PC>:
Code;  0044f328 <__wake_up_common+8/80>
   0:   b0 06 20 08       add  %i0, 8, %i0
Code;  0044f32c <__wake_up_common+c/80>
   4:   80 a0 40 18       cmp  %g1, %i0
Code;  0044f330 <__wake_up_common+10/80>
   8:   02 60 00 17       unknown
Code;  0044f334 <__wake_up_common+14/80>
   c:   e2 58 40 00       unknown
Code;  0044f338 <__wake_up_common+18/80>
  10:   b3 36 60 00       srl  %i1, 0, %i1
Code;  0044f33c <__wake_up_common+1c/80>
  14:   b7 3e e0 00       sra  %i3, 0, %i3
Code;  0044f340 <__wake_up_common+20/80>
  18:   90 00 7f e8       add  %g1, -24, %o0
Code;  0044f344 <__wake_up_common+24/80>
  1c:   e0 00 7f e8       ld  [ %g1 + -24 ], %l0
Code;  0044f348 <__wake_up_common+28/80>
  20:   92 10 00 19       mov  %i1, %o1

Feb  1 20:51:51 eclipse kernel: TSTATE: 0000009980f09604 TPC: 000000000044c20c TNPC: 000000000044c210 Y: 00000000    Not tainted
Feb  1 20:51:51 eclipse kernel: g0: fffff80047a45e20 g1: 0000000077359400 g2: 000000020791e729 g3: 0008000000000000
Feb  1 20:51:51 eclipse kernel: g4: 0000000000650a80 g5: 0000000000000a4f g6: 000000000064ca80 g7: 0000000000000a4f
Feb  1 20:51:51 eclipse kernel: o0: 00000002079209e5 o1: 0000000000000001 o2: 0000000000000001 o3: fffff80040726fa0
Feb  1 20:51:51 eclipse kernel: o4: fffff80000c6f1a4 o5: 0000000000000002 sp: 000000000064fea1 ret_pc: 000000000041da10
Feb  1 20:51:51 eclipse kernel: l0: 0000008f7c68e5ad l1: 0000000000000096 l2: 00000000006ca018 l3: 0000000000000000
Feb  1 20:51:51 eclipse kernel: l4: 00000000006c40c0 l5: 0000000000000000 l6: 0000000000000000 l7: 00000000006df000
Feb  1 20:51:51 eclipse kernel: i0: fffff8004786cce0 i1: 0000000000000a4f i2: 0000000000416254 i3: 0000000000000000
Feb  1 20:51:51 eclipse kernel: i4: 00000000ffff0001 i5: 0000000000ffff00 i6: 000000000064ff61 i7: 000000000044eb1c


>>PC;  0044c20c <recalc_task_prio+2c/260>   <=====

>>g4; 00650a80 <init_task+0/600>
>>g6; 0064ca80 <init_thread_union+0/4000>
>>sp; 0064fea1 <init_thread_union+3421/4000>
>>ret_pc; 0041da10 <sched_clock+10/40>
>>l2; 006ca018 <__per_cpu_offset+0/10>
>>l4; 006c40c0 <per_cpu____cpu_data+0/40>
>>l7; 006df000 <obp_gettod.2+90/100>
>>i2; 00416254 <cpu_idle+34/c0>
>>i6; 0064ff61 <init_thread_union+34e1/4000>
>>i7; 0044eb1c <schedule+2dc/a60>


1 warning and 1 error issued.  Results may not be reliable.

--=-+FNuYvKvP4UczLziVMuo--


