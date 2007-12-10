From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Mon, 10 Dec 2007 13:44:52 +0000
Subject: [2.6.23.8] Random oops on U2E/smp
Message-Id: <475D42D4.5060902@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

	Hello,

	My U2E (without any hardware trouble, I have tested it with SUN vts) 
randomly oopses (an oops by week...). I use a debian/testing with 
2.6.23.8 official kernel.

fermat:[~] > uptime
  14:41:03 up 11 days,  3:25,  5 users,  load average: 1.24, 0.70, 0.35
fermat:[~] > uname -a
Linux fermat 2.6.23.8 #1 SMP PREEMPT Thu Nov 22 11:55:54 CET 2007 
sparc64 GNU/Linux
fermat:[~] >

	Of course, this kernel was built with gcc-4.1. Last Oops is :

Unable to handle kernel paging request in mna handler<1> at virtual 
address ed7d
ed77f05ef06e
current->{active_,}mm->context = 0000000000001c2c
current->{active_,}mm->pgd = fffff8001594e000
               \|/ ____ \|/
               "@'/ .. \`@"
               /_| \__/ |_\
                  \__U_/
latex(20078): Oops [#1]
TSTATE: 0000009b11009600 TPC: 00000000004ca738 TNPC: 00000000004ca73c Y: 
0000000
0    Not tainted
TPC: <__d_lookup+0x80/0x1a0>
g0: 000000000075bc00 g1: 00000000eecfeeb1 g2: ed7ded77f05ef06e g3: 
030e403ffd526
257
g4: fffff80071c87780 g5: fffff7ffff87e000 g6: fffff80003c04000 g7: 
000000000003f
fff
o0: 0000000000000001 o1: fffff8007d22fb00 o2: fffff80003c07880 o3: 
2f2f002f2f000
061
o4: 0000000000000000 o5: 0000000000000012 sp: fffff80003c07011 ret_pc: 
000000000
04ca724
RPC: <__d_lookup+0x6c/0x1a0>
l0: ed7ded77f05ef06e l1: fffff80078f976c8 l2: 000000007efa7450 l3: 
fffff80055b04
af8
l4: 000000000000000c l5: fffff8004a127037 l6: 00000000100cd400 l7: 
00000000f7e8d
000
i0: fffff80055b04af8 i1: fffff80003c07a40 i2: fffff8007d22fb00 i3: 
74666d0073006
e00
i4: 0000000074666d00 i5: 00000000000043c9 i6: fffff80003c070d1 i7: 
00000000004be
c30
I7: <do_lookup+0x18/0x200>
Caller[00000000004bec30]: do_lookup+0x18/0x200
Caller[00000000004c1370]: __link_path_walk+0xad8/0xfc0
Caller[00000000004c18b8]: link_path_walk+0x60/0x120
Caller[00000000004c1c0c]: do_path_lookup+0x94/0x260
Caller[00000000004c2768]: __user_walk_fd+0x30/0x60
Caller[00000000004b53ac]: sys_faccessat+0x54/0x160
Caller[00000000004062d4]: linux_sparc_syscall32+0x3c/0x40
Caller[00000000000a2810]: 0xa2818
Instruction DUMP: e05c0011  22c4000c  b0102000 <c45c0000> c7688000 
a2043fd8  c2
046040  80a48001  2240000d
note: latex[20078] exited with preempt_count 1
Unable to handle kernel paging request at virtual address 00000000f7fd2000
tsk->{mm,active_mm}->context = 0000000000001c2c
tsk->{mm,active_mm}->pgd = fffff8001594e000
               \|/ ____ \|/
               "@'/ .. \`@"
               /_| \__/ |_\
                  \__U_/
latex(20078): Oops [#2]
TSTATE: 0000000080009607 TPC: 000000000047cfc8 TNPC: 000000000047cfcc Y: 
0000000
0    Tainted: G      D
TPC: <compat_exit_robust_list+0x10/0x140>
g0: fffff80003c06901 g1: 00000000f7fd2930 g2: 0000000000000002 g3: 
fffff80003c04
000
g4: fffff80071c87780 g5: fffff7ffff87e000 g6: fffff80003c04000 g7: 
0000000000000
01f
o0: 0000000000000001 o1: fffff80003c072a8 o2: 0000000000000001 o3: 
0000000000000
000
o4: 0000000000797400 o5: 0000000000797400 sp: fffff80003c06951 ret_pc: 
000000000
065feb0
RPC: <_spin_unlock_irq+0x38/0x40>
l0: 00000000f7fd2930 l1: fffff80071c87780 l2: 000000000072e800 l3: 
000000000072e
800
l4: 0000000000000000 l5: fffff80007f90070 l6: 0000000000400400 l7: 
000000000072e
800
i0: fffff80071c87780 i1: fffff80007f902b0 i2: 0000000000004e6e i3: 
0000000000000
001
i4: 00000000004bec30 i5: 0000000000796ec0 i6: fffff80003c06a21 i7: 
0000000000460
d24
I7: <do_exit+0x84c/0x9e0>
Caller[0000000000460d24]: do_exit+0x84c/0x9e0
Caller[0000000000429a50]: die_if_kernel+0x178/0x2c0
Caller[00000000004351a0]: kernel_mna_trap_fault+0xe8/0x120
Caller[0000000000435498]: kernel_unaligned_trap+0x2c0/0x520
Caller[0000000000429620]: mem_address_unaligned+0x88/0xa0
Caller[0000000000405f60]: do_mna+0x44/0x4c
Caller[00000000004ca724]: __d_lookup+0x6c/0x1a0
Caller[00000000004bec30]: do_lookup+0x18/0x200
Caller[00000000004c1370]: __link_path_walk+0xad8/0xfc0
Caller[00000000004c18b8]: link_path_walk+0x60/0x120
Caller[00000000004c1c0c]: do_path_lookup+0x94/0x260
Caller[00000000004c2768]: __user_walk_fd+0x30/0x60
Caller[00000000004b53ac]: sys_faccessat+0x54/0x160
Caller[00000000004062d4]: linux_sparc_syscall32+0x3c/0x40
Caller[00000000000a2810]: 0xa2818
Instruction DUMP: 01000000  9de3bf30  e05e2460 <c4842000> 82100000 
80a06000  12
480043  86100002  82042004
Fixing recursive fault but reboot is needed!
BUG: scheduling while atomic: latex/0x00000002/20078
Call Trace:
  [0000000000460d7c] do_exit+0x8a4/0x9e0
  [0000000000429a50] die_if_kernel+0x178/0x2c0
  [0000000000449170] unhandled_fault+0x78/0xe0
  [000000000040796c] sparc64_realfault_common+0x18/0x20
  [000000000065feb0] _spin_unlock_irq+0x38/0x40
  [0000000000460d24] do_exit+0x84c/0x9e0
  [0000000000429a50] die_if_kernel+0x178/0x2c0
  [00000000004351a0] kernel_mna_trap_fault+0xe8/0x120
  [0000000000435498] kernel_unaligned_trap+0x2c0/0x520
  [0000000000429620] mem_address_unaligned+0x88/0xa0
  [0000000000405f60] do_mna+0x44/0x4c
  [00000000004ca724] __d_lookup+0x6c/0x1a0
  [00000000004bec30] do_lookup+0x18/0x200
  [00000000004c1370] __link_path_walk+0xad8/0xfc0
  [00000000004c18b8] link_path_walk+0x60/0x120
  [00000000004c1c0c] do_path_lookup+0x94/0x260
fermat:[~] >

	Any idea ? I have seen the same Oops with 2.6.23.1. U60 I use with the 
same configuration do not seem to have the same trouble.

	Regards,

	JKB
