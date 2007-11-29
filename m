From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Thu, 29 Nov 2007 09:51:42 +0000
Subject: [2.6.23.8] WARNING: at fs/buffer.c:696 __set_page_dirty()
Message-Id: <474E8BAE.6010608@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

	Hello,

	This morning, when I have try to launch a apt-get dist-upgrade on my 
U2E (2 GB, 2*Uii/300) running debian.testing (2.6.23.8), kernel returns:

Call Trace:
  [0000000000493d38] set_page_dirty+0x80/0xc0
  [0000000000494f84] set_page_dirty_balance+0xc/0x80
  [000000000049bddc] __do_fault+0x244/0x560
  [000000000049df24] handle_mm_fault+0x14c/0x9c0
  [0000000000449598] do_sparc64_fault+0x340/0x600
  [000000000040796c] sparc64_realfault_common+0x18/0x20
  [00000000f7aeafec] 0xf7aeaff4
spitfire_data_access_exception: SFSR[0000000000801009] 
SFAR[0000000000000000], g
oing.
               \|/ ____ \|/
               "@'/ .. \`@"
               /_| \__/ |_\
                  \__U_/
dpkg-preconfigu(1401): Dax [#1]
TSTATE: 0000000011009604 TPC: 00000000004ca738 TNPC: 00000000004ca73c Y: 
0000000
0    Not tainted
TPC: <__d_lookup+0x80/0x1a0>
g0: fffff8007c177038 g1: 0000000000020002 g2: 0002000000000000 g3: 
030e403ffc60f
628
g4: fffff80010d5a9a0 g5: fffff7ffff87e000 g6: fffff80036fd4000 g7: 
000000000003f
fff
o0: 0000000000000001 o1: 00000000006ef2f8 o2: fffff80036fd76f0 o3: 
0000000000000
000
o4: fffff80034adc410 o5: 0000000000000012 sp: fffff80036fd6ee1 ret_pc: 
000000000
04ca724
RPC: <__d_lookup+0x6c/0x1a0>
l0: 0002000000000000 l1: fffff80073e166c0 l2: 000000000ed603af l3: 
0000000000200
200
l4: 0000000000000009 l5: fffff800672b5014 l6: 000000000075bc00 l7: 
0000000000734
120
i0: fffff80073e2c510 i1: fffff80036fd7910 i2: 0000000000520f20 i3: 
fffffffffffff
af0
i4: fffff80036fd77c8 i5: 00000000000041ed i6: fffff80036fd6fa1 i7: 
00000000004be
c30
I7: <do_lookup+0x18/0x200>
Caller[00000000004bec30]: do_lookup+0x18/0x200
Caller[00000000004c1370]: __link_path_walk+0xad8/0xfc0
Caller[00000000004c18b8]: link_path_walk+0x60/0x120
Caller[00000000004c1c0c]: do_path_lookup+0x94/0x260
Caller[00000000004c2768]: __user_walk_fd+0x30/0x60
Caller[00000000004ba134]: vfs_stat_fd+0x1c/0x60
Caller[000000000043f1cc]: compat_sys_stat64+0x14/0x40
Caller[00000000004062d4]: linux_sparc_syscall32+0x3c/0x40
Caller[00000000f7ca63e8]: 0xf7ca63f0
Instruction DUMP: e05c0011  22c4000c  b0102000 <c45c0000> c7688000 
a2043fd8  c2
046040  80a48001  2240000d
note: dpkg-preconfigu[1401] exited with preempt_count 1
Unable to handle kernel paging request at virtual address 00000000f7bd2000
tsk->{mm,active_mm}->context = 000000000000116e
tsk->{mm,active_mm}->pgd = fffff8003ce5a000
               \|/ ____ \|/
               "@'/ .. \`@"
               /_| \__/ |_\
                  \__U_/
dpkg-preconfigu(1401): Oops [#2]
TSTATE: 0000000080009601 TPC: 000000000047cfc8 TNPC: 000000000047cfcc Y: 
0000000
0    Tainted: G      D
TPC: <compat_exit_robust_list+0x10/0x140>
g0: fffff80036fd4000 g1: 00000000f7bd2700 g2: 0000000000000002 g3: 
fffff80036fd4
000
g4: fffff80010d5a9a0 g5: fffff7ffff87e000 g6: fffff80036fd4000 g7: 
0000000000000
004
o0: 0000000000000001 o1: fffff80036fd7308 o2: 0000000000000001 o3: 
0000000000000
000
o4: 0000000000797400 o5: 0000000000797400 sp: fffff80036fd69b1 ret_pc: 
000000000
065feb0
RPC: <_spin_unlock_irq+0x38/0x40>
l0: 00000000f7bd2700 l1: fffff80010d5a9a0 l2: 00000000004281c0 l3: 
000000000072e
800
l4: 0000000000000000 l5: fffff8002b2f4c70 l6: 0000000000400400 l7: 
000000000072e
800
i0: fffff80010d5a9a0 i1: fffff8002b2f4eb0 i2: 0000000000000579 i3: 
0000000000000
001
i4: 00000000004bec30 i5: 0000000000796ec0 i6: fffff80036fd6a81 i7: 
0000000000460
d24
I7: <do_exit+0x84c/0x9e0>
Caller[0000000000460d24]: do_exit+0x84c/0x9e0
Caller[0000000000429a50]: die_if_kernel+0x178/0x2c0
Caller[000000000042a37c]: spitfire_data_access_exception+0xc4/0xe0
Caller[000000000040589c]: __spitfire_data_access_exception+0x3c/0x44
Caller[00000000004ca724]: __d_lookup+0x6c/0x1a0
Caller[00000000004bec30]: do_lookup+0x18/0x200
Caller[00000000004c1370]: __link_path_walk+0xad8/0xfc0
Caller[00000000004c18b8]: link_path_walk+0x60/0x120
Caller[00000000004c1c0c]: do_path_lookup+0x94/0x260
Caller[00000000004c2768]: __user_walk_fd+0x30/0x60
Caller[00000000004ba134]: vfs_stat_fd+0x1c/0x60
Caller[000000000043f1cc]: compat_sys_stat64+0x14/0x40
Caller[00000000004062d4]: linux_sparc_syscall32+0x3c/0x40
Caller[00000000f7ca63e8]: 0xf7ca63f0
Instruction DUMP: 01000000  9de3bf30  e05e2460 <c4842000> 82100000 
80a06000  12
480043  86100002  82042004
Fixing recursive fault but reboot is needed!
BUG: scheduling while atomic: dpkg-preconfigu/0x00000002/1401
Call Trace:
  [0000000000460d7c] do_exit+0x8a4/0x9e0
  [0000000000429a50] die_if_kernel+0x178/0x2c0
  [0000000000449170] unhandled_fault+0x78/0xe0
  [000000000040796c] sparc64_realfault_common+0x18/0x20
  [000000000065feb0] _spin_unlock_irq+0x38/0x40
  [0000000000460d24] do_exit+0x84c/0x9e0
  [0000000000429a50] die_if_kernel+0x178/0x2c0
  [000000000042a37c] spitfire_data_access_exception+0xc4/0xe0
  [000000000040589c] __spitfire_data_access_exception+0x3c/0x44
  [00000000004ca724] __d_lookup+0x6c/0x1a0
  [00000000004bec30] do_lookup+0x18/0x200
  [00000000004c1370] __link_path_walk+0xad8/0xfc0
  [00000000004c18b8] link_path_walk+0x60/0x120
  [00000000004c1c0c] do_path_lookup+0x94/0x260
  [00000000004c2768] __user_walk_fd+0x30/0x60
  [00000000004ba134] vfs_stat_fd+0x1c/0x60
Kernel unaligned access at TPC[4ca738] __d_lookup+0x80/0x1a0
Unable to handle kernel paging request in mna handler<1> at virtual 
address 009c
ff9000a2ff8c
current->{active_,}mm->context = 000000000000128c
current->{active_,}mm->pgd = fffff80027d9e000
               \|/ ____ \|/
               "@'/ .. \`@"
               /_| \__/ |_\
                  \__U_/
make(1603): Oops [#3]
TSTATE: 0000000811009600 TPC: 00000000004ca738 TNPC: 00000000004ca73c Y: 
0000000
0    Tainted: G      D
TPC: <__d_lookup+0x80/0x1a0>
g0: 0000000047475525 g1: 0000000000aeff84 g2: 009cff9000a2ff8c g3: 
030e403ffc189
372
g4: fffff8006b528de0 g5: fffff7ffff87e000 g6: fffff8002d500000 g7: 
000000000003f
fff
o0: 0000000000000001 o1: 00000000006ef2f8 o2: 0000000000000001 o3: 
fffff8002d503
8a0
o4: fffff80000028ac0 o5: 0000000000000012 sp: fffff8002d503011 ret_pc: 
000000000
04ca724
RPC: <__d_lookup+0x6c/0x1a0>
l0: 009cff9000a2ff8c l1: fffff80073e171b8 l2: 00000000f7ec70e5 l3: 
fffff800641e5
a28
l4: 000000000000002b l5: fffff8000a82c588 l6: 0000000000000000 l7: 
0000000000733
2e8
i0: fffff8007cee6e58 i1: fffff8002d503a40 i2: 0000000000000000 i3: 
0000000022cd7
5c4
i4: fffff8002d503be0 i5: b334e48901c98f32 i6: fffff8002d5030d1 i7: 
00000000004ca
87c
I7: <d_lookup+0x24/0x60>
Caller[00000000004ca87c]: d_lookup+0x24/0x60
Caller[00000000100ec244]: nfs_do_filldir+0xcc/0x500 [nfs]
Caller[00000000100eea14]: nfs_readdir+0x3fc/0x920 [nfs]
Caller[00000000004c4770]: vfs_readdir+0x78/0xa0
Caller[00000000004c47d0]: sys_getdents64+0x38/0xa0
Caller[00000000004062d4]: linux_sparc_syscall32+0x3c/0x40
Caller[000000000002d0e8]: 0x2d0f0
Instruction DUMP: e05c0011  22c4000c  b0102000 <c45c0000> c7688000 
a2043fd8  c2
046040  80a48001  2240000d
note: make[1603] exited with preempt_count 1
Unable to handle kernel paging request at virtual address 0000000070000000
tsk->{mm,active_mm}->context = 000000000000128c
tsk->{mm,active_mm}->pgd = fffff80027d9e000
               \|/ ____ \|/
               "@'/ .. \`@"
               /_| \__/ |_\
                  \__U_/
make(1603): Oops [#4]
TSTATE: 0000000080009607 TPC: 000000000047cfc8 TNPC: 000000000047cfcc Y: 
0000000
0    Tainted: G      D
TPC: <compat_exit_robust_list+0x10/0x140>
g0: 0000000000000000 g1: 0000000070001680 g2: 0000000000000002 g3: 
fffff8002d500
000
g4: fffff8006b528de0 g5: fffff7ffff87e000 g6: fffff8002d500000 g7: 
0000000000000
03a
o0: 0000000000000001 o1: fffff8002d5032a8 o2: 0000000000000001 o3: 
0000000000000
000
o4: 0000000000797400 o5: 0000000000797400 sp: fffff8002d502951 ret_pc: 
000000000
065feb0
RPC: <_spin_unlock_irq+0x38/0x40>
l0: 0000000070001680 l1: fffff8006b528de0 l2: 00000000004281c0 l3: 
000000000072e
800
l4: 0000000000000000 l5: fffff80010df1270 l6: 0000000000400400 l7: 
000000000072e
800
i0: fffff8006b528de0 i1: fffff80010df14b0 i2: 0000000000000643 i3: 
0000000000000
001
i4: 00000000004ca87c i5: 0000000000796ec0 i6: fffff8002d502a21 i7: 
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
Caller[00000000004ca87c]: d_lookup+0x24/0x60
Caller[00000000100ec244]: nfs_do_filldir+0xcc/0x500 [nfs]
Caller[00000000100eea14]: nfs_readdir+0x3fc/0x920 [nfs]
Caller[00000000004c4770]: vfs_readdir+0x78/0xa0
Caller[00000000004c47d0]: sys_getdents64+0x38/0xa0
Caller[00000000004062d4]: linux_sparc_syscall32+0x3c/0x40
Caller[000000000002d0e8]: 0x2d0f0
Instruction DUMP: 01000000  9de3bf30  e05e2460 <c4842000> 82100000 
80a06000  12
480043  86100002  82042004
Fixing recursive fault but reboot is needed!
BUG: scheduling while atomic: make/0x00000002/1603
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
  [00000000004ca87c] d_lookup+0x24/0x60
  [00000000100ec244] nfs_do_filldir+0xcc/0x500 [nfs]
  [00000000100eea14] nfs_readdir+0x3fc/0x920 [nfs]
  [00000000004c4770] vfs_readdir+0x78/0xa0
spitfire_data_access_exception: SFSR[0000000000801009] 
SFAR[0000000000000000], g
oing.
               \|/ ____ \|/
               "@'/ .. \`@"
               /_| \__/ |_\
                  \__U_/
dpkg-preconfigu(1641): Dax [#5]
TSTATE: 0000000011009604 TPC: 00000000004ca738 TNPC: 00000000004ca73c Y: 
0000000
0    Tainted: G      D
TPC: <__d_lookup+0x80/0x1a0>
g0: fffff8007c177020 g1: 0000000000020002 g2: 0002000000000000 g3: 
030e403ffc60f
628
g4: fffff80057c9e9a0 g5: fffff7ffff87e000 g6: fffff8004b3bc000 g7: 
000000000003f
fff
o0: 0000000000000001 o1: 00000000006ef2f8 o2: fffff8004b3bf6f0 o3: 
0000000000000
000
o4: fffff80034adc410 o5: 0000000000000012 sp: fffff8004b3beee1 ret_pc: 
000000000
04ca724
RPC: <__d_lookup+0x6c/0x1a0>
l0: 0002000000000000 l1: fffff80073e166c0 l2: 000000000ed603af l3: 
0000000000200
200
l4: 0000000000000009 l5: fffff8006f7a9014 l6: 000000000075bc00 l7: 
0000000000734
120
i0: fffff80073e2c510 i1: fffff8004b3bf910 i2: 0000000000520f20 i3: 
fffffffffffff
af0
i4: fffff8004b3bf7c8 i5: 00000000000041ed i6: fffff8004b3befa1 i7: 
00000000004be
c30
I7: <do_lookup+0x18/0x200>
Caller[00000000004bec30]: do_lookup+0x18/0x200
Caller[00000000004c1370]: __link_path_walk+0xad8/0xfc0
Caller[00000000004c18b8]: link_path_walk+0x60/0x120
Caller[00000000004c1c0c]: do_path_lookup+0x94/0x260
Caller[00000000004c2768]: __user_walk_fd+0x30/0x60
Caller[00000000004ba134]: vfs_stat_fd+0x1c/0x60
Caller[000000000043f1cc]: compat_sys_stat64+0x14/0x40
Caller[00000000004062d4]: linux_sparc_syscall32+0x3c/0x40
Caller[00000000f7bee3e8]: 0xf7bee3f0
Instruction DUMP: e05c0011  22c4000c  b0102000 <c45c0000> c7688000 
a2043fd8  c2
046040  80a48001  2240000d
note: dpkg-preconfigu[1641] exited with preempt_count 1
Unable to handle kernel paging request at virtual address 00000000f7b1a000
tsk->{mm,active_mm}->context = 00000000000012c9
tsk->{mm,active_mm}->pgd = fffff8005d904000
               \|/ ____ \|/
               "@'/ .. \`@"
               /_| \__/ |_\
                  \__U_/
dpkg-preconfigu(1641): Oops [#6]
TSTATE: 0000009980009601 TPC: 000000000047cfc8 TNPC: 000000000047cfcc Y: 
0000000
0    Tainted: G      D
TPC: <compat_exit_robust_list+0x10/0x140>
g0: 00000000006de0b0 g1: 00000000f7b1a700 g2: 0000000000000002 g3: 
fffff8004b3bc
000
g4: fffff80057c9e9a0 g5: fffff7ffff87e000 g6: fffff8004b3bc000 g7: 
0000000000000
003
o0: 0000000000000001 o1: fffff8004b3bf308 o2: 0000000000000001 o3: 
0000000000000
000
o4: 0000000000797400 o5: 0000000000797400 sp: fffff8004b3be9b1 ret_pc: 
000000000
065fe90
RPC: <_spin_unlock_irq+0x18/0x40>
l0: 00000000f7b1a700 l1: 0000000000797308 l2: 000000000072e800 l3: 
000000000072e
800
l4: 0000000000000000 l5: fffff80064eb7570 l6: 0000000000400400 l7: 
000000000072e
800
i0: fffff80057c9e9a0 i1: fffff80064eb77b0 i2: 0000000000000669 i3: 
0000000000000
001
i4: 00000000004bec30 i5: 0000000000796ec0 i6: fffff8004b3bea81 i7: 
0000000000460
d24
I7: <do_exit+0x84c/0x9e0>
Caller[0000000000460d24]: do_exit+0x84c/0x9e0
Caller[0000000000429a50]: die_if_kernel+0x178/0x2c0
Caller[000000000042a37c]: spitfire_data_access_exception+0xc4/0xe0
Caller[000000000040589c]: __spitfire_data_access_exception+0x3c/0x44
Caller[00000000004ca724]: __d_lookup+0x6c/0x1a0
Caller[00000000004bec30]: do_lookup+0x18/0x200
Caller[00000000004c1370]: __link_path_walk+0xad8/0xfc0
Caller[00000000004c18b8]: link_path_walk+0x60/0x120
Caller[00000000004c1c0c]: do_path_lookup+0x94/0x260
Caller[00000000004c2768]: __user_walk_fd+0x30/0x60
Caller[00000000004ba134]: vfs_stat_fd+0x1c/0x60
Caller[000000000043f1cc]: compat_sys_stat64+0x14/0x40
Caller[00000000004062d4]: linux_sparc_syscall32+0x3c/0x40
Caller[00000000f7bee3e8]: 0xf7bee3f0
Instruction DUMP: 01000000  9de3bf30  e05e2460 <c4842000> 82100000 
80a06000  12
480043  86100002  82042004
Fixing recursive fault but reboot is needed!
BUG: scheduling while atomic: dpkg-preconfigu/0x00000002/1641
Call Trace:
  [0000000000460d7c] do_exit+0x8a4/0x9e0
  [0000000000429a50] die_if_kernel+0x178/0x2c0
  [0000000000449170] unhandled_fault+0x78/0xe0
  [000000000040796c] sparc64_realfault_common+0x18/0x20
  [000000000065fe90] _spin_unlock_irq+0x18/0x40
  [0000000000460d24] do_exit+0x84c/0x9e0
  [0000000000429a50] die_if_kernel+0x178/0x2c0
  [000000000042a37c] spitfire_data_access_exception+0xc4/0xe0
  [000000000040589c] __spitfire_data_access_exception+0x3c/0x44
  [00000000004ca724] __d_lookup+0x6c/0x1a0
  [00000000004bec30] do_lookup+0x18/0x200
  [00000000004c1370] __link_path_walk+0xad8/0xfc0
  [00000000004c18b8] link_path_walk+0x60/0x120
  [00000000004c1c0c] do_path_lookup+0x94/0x260
  [00000000004c2768] __user_walk_fd+0x30/0x60
  [00000000004ba134] vfs_stat_fd+0x1c/0x60
spitfire_data_access_exception: SFSR[0000000000801009] 
SFAR[0000000000000000], g
oing.
               \|/ ____ \|/
               "@'/ .. \`@"
               /_| \__/ |_\
                  \__U_/
awstats.pl(1688): Dax [#7]
TSTATE: 0000000011009602 TPC: 00000000004ca738 TNPC: 00000000004ca73c Y: 
0000000
0    Tainted: G      D
TPC: <__d_lookup+0x80/0x1a0>
g0: fffff8007c177068 g1: 0000000000020002 g2: 0002000000000000 g3: 
030e403ffc60f
628
g4: fffff80057c9f2e0 g5: fffff7ffff87e000 g6: fffff80060100000 g7: 
000000000003f
fff
o0: 0000000000000001 o1: 00000000006ef2f8 o2: fffff800601036f0 o3: 
0000000000000
000
o4: fffff80034adc410 o5: 0000000000000012 sp: fffff80060102ee1 ret_pc: 
000000000
04ca724
RPC: <__d_lookup+0x6c/0x1a0>
l0: 0002000000000000 l1: fffff80073e166c0 l2: 000000000ed603af l3: 
0000000000200
200
l4: 0000000000000009 l5: fffff800672b3014 l6: 000000000075bc00 l7: 
0000000000734
120
i0: fffff80073e2c510 i1: fffff80060103910 i2: 0000000000520f20 i3: 
fffffffffffff
af0
i4: fffff800601037c8 i5: 00000000000041ed i6: fffff80060102fa1 i7: 
00000000004be
c30
I7: <do_lookup+0x18/0x200>
Caller[00000000004bec30]: do_lookup+0x18/0x200
Caller[00000000004c1370]: __link_path_walk+0xad8/0xfc0
Caller[00000000004c18b8]: link_path_walk+0x60/0x120
Caller[00000000004c1c0c]: do_path_lookup+0x94/0x260
Caller[00000000004c2768]: __user_walk_fd+0x30/0x60
Caller[00000000004ba134]: vfs_stat_fd+0x1c/0x60
Caller[000000000043f1cc]: compat_sys_stat64+0x14/0x40
Caller[00000000004062d4]: linux_sparc_syscall32+0x3c/0x40
Caller[00000000f7c663e8]: 0xf7c663f0
Instruction DUMP: e05c0011  22c4000c  b0102000 <c45c0000> c7688000 
a2043fd8  c2
046040  80a48001  2240000d
note: awstats.pl[1688] exited with preempt_count 1
Unable to handle kernel paging request at virtual address 00000000f7b92000
tsk->{mm,active_mm}->context = 000000000000130a
tsk->{mm,active_mm}->pgd = fffff8005df80000
               \|/ ____ \|/
               "@'/ .. \`@"
               /_| \__/ |_\
                  \__U_/
awstats.pl(1688): Oops [#8]
TSTATE: 0000000080009607 TPC: 000000000047cfc8 TNPC: 000000000047cfcc Y: 
0000000
0    Tainted: G      D
TPC: <compat_exit_robust_list+0x10/0x140>
g0: 0000000000797308 g1: 00000000f7b92700 g2: 0000000000000002 g3: 
fffff80060100
000
g4: fffff80057c9f2e0 g5: fffff7ffff87e000 g6: fffff80060100000 g7: 
0000000000000
003
o0: 0000000000000001 o1: fffff80060103308 o2: 0000000000000001 o3: 
0000000000000
000
o4: 0000000000797400 o5: 0000000000797400 sp: fffff800601029b1 ret_pc: 
000000000
065feb0
RPC: <_spin_unlock_irq+0x38/0x40>
l0: 00000000f7b92700 l1: fffff80057c9f2e0 l2: 000000000072e800 l3: 
000000000072e
800
l4: 0000000000000000 l5: fffff80064eb7270 l6: 0000000000400400 l7: 
000000000072e
800
i0: fffff80057c9f2e0 i1: fffff80064eb74b0 i2: 0000000000000698 i3: 
0000000000000
001
i4: 00000000004bec30 i5: 0000000000796ec0 i6: fffff80060102a81 i7: 
0000000000460
d24
I7: <do_exit+0x84c/0x9e0>
Caller[0000000000460d24]: do_exit+0x84c/0x9e0
Caller[0000000000429a50]: die_if_kernel+0x178/0x2c0
Caller[000000000042a37c]: spitfire_data_access_exception+0xc4/0xe0
Caller[000000000040589c]: __spitfire_data_access_exception+0x3c/0x44
Caller[00000000004ca724]: __d_lookup+0x6c/0x1a0
Caller[00000000004bec30]: do_lookup+0x18/0x200
Caller[00000000004c1370]: __link_path_walk+0xad8/0xfc0
Caller[00000000004c18b8]: link_path_walk+0x60/0x120
Caller[00000000004c1c0c]: do_path_lookup+0x94/0x260
Caller[00000000004c2768]: __user_walk_fd+0x30/0x60
Caller[00000000004ba134]: vfs_stat_fd+0x1c/0x60
Caller[000000000043f1cc]: compat_sys_stat64+0x14/0x40
Caller[00000000004062d4]: linux_sparc_syscall32+0x3c/0x40
Caller[00000000f7c663e8]: 0xf7c663f0
Instruction DUMP: 01000000  9de3bf30  e05e2460 <c4842000> 82100000 
80a06000  12
480043  86100002  82042004
Fixing recursive fault but reboot is needed!
BUG: scheduling while atomic: awstats.pl/0x00000002/1688
Call Trace:
  [0000000000460d7c] do_exit+0x8a4/0x9e0
  [0000000000429a50] die_if_kernel+0x178/0x2c0
  [0000000000449170] unhandled_fault+0x78/0xe0
  [000000000040796c] sparc64_realfault_common+0x18/0x20
  [000000000065feb0] _spin_unlock_irq+0x38/0x40
  [0000000000460d24] do_exit+0x84c/0x9e0
  [0000000000429a50] die_if_kernel+0x178/0x2c0
  [000000000042a37c] spitfire_data_access_exception+0xc4/0xe0
  [000000000040589c] __spitfire_data_access_exception+0x3c/0x44
  [00000000004ca724] __d_lookup+0x6c/0x1a0
  [00000000004bec30] do_lookup+0x18/0x200
  [00000000004c1370] __link_path_walk+0xad8/0xfc0
  [00000000004c18b8] link_path_walk+0x60/0x120
  [00000000004c1c0c] do_path_lookup+0x94/0x260
  [00000000004c2768] __user_walk_fd+0x30/0x60
  [00000000004ba134] vfs_stat_fd+0x1c/0x60

	Of course, kernel was built with:
Root fermat:[/proc] > dmesg |grep gcc
Linux version 2.6.23.8 (root@fermat) (gcc version 4.1.3 20071019 
(prerelease) (Debian 4.1.2-17)) #1 SMP PREEMPT Thu Nov 22 11:55:54 CET 2007

	My .config contains:
#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_DEFAULT_AS is not set
# CONFIG_DEFAULT_DEADLINE is not set
CONFIG_DEFAULT_CFQ=y
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="cfq"
CONFIG_SYSVIPC_COMPAT=y
CONFIG_GENERIC_HARDIRQS=y

	I don't have any message about bad memory, but I shall test workstation 
with SUNvts and diag-switch? flag.

	Regards,

	JKB
