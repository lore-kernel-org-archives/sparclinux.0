From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Fri, 14 Oct 2011 14:43:45 +0000
Subject: 3.0.4 kernel oops in i2c ?
Message-Id: <20111014144345.GB5070@lemon.iwr.uni-heidelberg.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

when starting 3.0.4 on a V880 a non fatal oops happens when loading
i2c stuff. Proably there is a problem with i2c on the machine,
as the rsc "env" cmd shows "E880_FSP: ERROR getting FP stats ---> 9"
errors. An old 2.6.26-2-sparc64-smp (Debian 2.6.26-26lenny2) kernel
produces no oops.

Any ideas ?

Thanks and greetings,
  Hermann

Oct 14 16:22:15 abacus kernel: i2c-0: Regs at 000007fc7e00002e, 8 devices, own a0, clock 10.
Oct 14 16:22:15 abacus kernel: bbc_i2c: probe of f00bbb00 failed with error -22
Oct 14 16:22:15 abacus kernel: i2c-0: Regs at 000007fc7e50002e, 3 devices, own a0, clock 10.
Oct 14 16:22:15 abacus kernel: Unable to handle kernel NULL pointer dereference
Oct 14 16:22:15 abacus kernel: tsk->{mm,active_mm}->context = 000000000000028b
Oct 14 16:22:15 abacus kernel: tsk->{mm,active_mm}->pgd = fffff8a0fb15c000
Oct 14 16:22:15 abacus kernel:               \|/ ____ \|/
Oct 14 16:22:15 abacus kernel:               "@'/ .. \`@"
Oct 14 16:22:15 abacus kernel:               /_| \__/ |_\
Oct 14 16:22:15 abacus kernel:                  \__U_/
Oct 14 16:22:15 abacus kernel: modprobe(886): Oops [#1]
Oct 14 16:22:15 abacus kernel: TSTATE: 0000004411001603 TPC: 00000000100fa864 TNPC: 00000000100fa868 Y: 00000000    Not tainted
Oct 14 16:22:15 abacus kernel: TPC: <bbc_envctrl_init+0xf0/0x32c [bbc]>
Oct 14 16:22:15 abacus kernel: g0: 000000000088b22c g1: 0000000000000000 g2: 00000000100fbae8 g3: fffff8a0fd9b8800
Oct 14 16:22:15 abacus kernel: g4: fffff8a0fd9080e0 g5: fffff8a002512000 g6: fffff8a0fb59c000 g7: 0000000000000000
Oct 14 16:22:15 abacus kernel: o0: fffff8a0fb429060 o1: 0000000000000000 o2: 0000000000000009 o3: 00000000007fa208
Oct 14 16:22:15 abacus kernel: o4: 0000000000000001 o5: 0000000000000000 sp: fffff8a0fb59ef91 ret_pc: 00000000100fa814
Oct 14 16:22:15 abacus kernel: RPC: <bbc_envctrl_init+0xa0/0x32c [bbc]>
Oct 14 16:22:15 abacus kernel: l0: fffff8a0fb4290a0 l1: 0000000000000001 l2: 0000000000000000 l3: fffff8a0fd9b8800
Oct 14 16:22:15 abacus kernel: l4: 0000000000000001 l5: 00000000100fbaf8 l6: 00000000100fbae8 l7: 0000000000000001
Oct 14 16:22:15 abacus kernel: i0: fffff8a0fd8296c0 i1: 0000000000890300 i2: 00000000000080d0 i3: 00000000100fb730
Oct 14 16:22:15 abacus kernel: i4: 00000000100fb73c i5: 0000000000000025 i6: fffff8a0fb59f061 i7: 00000000100fb41c
Oct 14 16:22:15 abacus kernel: I7: <bbc_i2c_probe+0x1a0/0x258 [bbc]>
Oct 14 16:22:15 abacus kernel: Call Trace:
Oct 14 16:22:15 abacus kernel:  [00000000100fb41c] bbc_i2c_probe+0x1a0/0x258 [bbc]
Oct 14 16:22:15 abacus kernel:  [00000000005ecc9c] platform_drv_probe+0xc/0x20
Oct 14 16:22:15 abacus kernel:  [00000000005ebc0c] driver_probe_device+0xa8/0x158
Oct 14 16:22:15 abacus kernel:  [00000000005ebd10] __driver_attach+0x54/0x80
Oct 14 16:22:15 abacus kernel:  [00000000005eb444] bus_for_each_dev+0x3c/0x84
Oct 14 16:22:15 abacus kernel:  [00000000005ead2c] bus_add_driver+0x9c/0x238
Oct 14 16:22:15 abacus kernel:  [00000000005ec124] driver_register+0xb8/0x168
Oct 14 16:22:15 abacus kernel:  [0000000000426b28] do_one_initcall+0x68/0x140
Oct 14 16:22:15 abacus kernel:  [0000000000484a84] SyS_init_module+0x68/0x1a4
Oct 14 16:22:15 abacus kernel:  [0000000000406154] linux_sparc_syscall32+0x34/0x40
Oct 14 16:22:15 abacus kernel: Disabling lock debugging due to kernel taint
Oct 14 16:22:15 abacus kernel: Caller[00000000100fb41c]: bbc_i2c_probe+0x1a0/0x258 [bbc]
Oct 14 16:22:15 abacus kernel: Caller[00000000005ecc9c]: platform_drv_probe+0xc/0x20
Oct 14 16:22:15 abacus kernel: Caller[00000000005ebc0c]: driver_probe_device+0xa8/0x158
Oct 14 16:22:15 abacus kernel: Caller[00000000005ebd10]: __driver_attach+0x54/0x80
Oct 14 16:22:15 abacus kernel: Caller[00000000005eb444]: bus_for_each_dev+0x3c/0x84
Oct 14 16:22:15 abacus kernel: Caller[00000000005ead2c]: bus_add_driver+0x9c/0x238
Oct 14 16:22:15 abacus kernel: Caller[00000000005ec124]: driver_register+0xb8/0x168
Oct 14 16:22:15 abacus kernel: Caller[0000000000426b28]: do_one_initcall+0x68/0x140
Oct 14 16:22:15 abacus kernel: Caller[0000000000484a84]: SyS_init_module+0x68/0x1a4
Oct 14 16:22:15 abacus kernel: Caller[0000000000406154]: linux_sparc_syscall32+0x34/0x40
Oct 14 16:22:15 abacus kernel: Caller[0000000000013ccc]: 0x13ccc
Oct 14 16:22:15 abacus kernel: Instruction DUMP: ec742018  c2758000  c25e2048 <e0706008> c2740000  c25fa7ef  c2742008  e0762048  7ffffeca 
Oct 14 16:22:16 abacus kernel: gem 0002:00:01.1: eth1: switching to forced 100bt
Oct 14 16:22:16 abacus kernel: NET: Registered protocol family 10
Oct 14 16:22:16 abacus kernel: sshd (1324): /proc/1324/oom_adj is deprecated, please use /proc/1324/oom_score_adj instead.
Oct 14 16:22:23 abacus kernel: gem 0002:00:01.1: eth1: switching to forced 10bt
Oct 14 16:22:44 abacus kernel: gem 0002:00:01.1: eth1: switching to forced 100bt

-- 
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres 
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
Email: Hermann.Lauer@iwr.uni-heidelberg.de
