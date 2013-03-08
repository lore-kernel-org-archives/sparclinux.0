From: Magnus Lindholm <linmag7@gmail.com>
Date: Fri, 08 Mar 2013 22:42:00 +0000
Subject: kernel panic on linux-3.7.10 sun blade 2000
Message-Id: <7897ED8D-BA94-4741-B935-92BB753E1144@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

I'm trying to get the cpu/case fan-control working on my sun blade-2000. Running lm-sensors causes a kernel panic:

[  412.106242] ERROR(0): Cheetah error trap taken afsr[0010100000000000] afar[0000000000000020] TL1(0)
[  412.106257] ERROR(0): TPC[524514] TNPC[524518] O7[5244a8] TSTATE[4411001605]
[  412.106263] ERROR(0): TPC<vfs_write+0xd4/0x120>
[  412.106287] ERROR(0): M_SYND(0),  E_SYND(0), Privileged
[  412.106295] ERROR(0): Highest priority error (0000100000000000) "Unmapped error from system bus"
[  412.106303] ERROR(0): D-cache idx[0] tag[0000000000000000] utag[0000000000000000] stag[0000000000000000]
[  412.106310] ERROR(0): D-cache data0[0000000000000000] data1[0000000000000000] data2[0000000000000000] data3[0000000000000000]
[  412.106319] ERROR(0): I-cache idx[0] tag[0000000000000000] utag[0000000000000000] stag[0000000000000000] u[0000000000000000] l[0000000000000000]
[  412.106326] ERROR(0): I-cache INSN0[0000000000000000] INSN1[0000000000000000] INSN2[0000000000000000] INSN3[0000000000000000]
[  412.106333] ERROR(0): I-cache INSN4[0000000000000000] INSN5[0000000000000000] INSN6[0000000000000000] INSN7[0000000000000000]
[  412.106339] ERROR(0): E-cache idx[20] tag[00000007ec020100]
[  412.106346] ERROR(0): E-cache data0[0001151500000000] data1[000c66200001bb15] data2[00000000000c662c] data3[0003381500000000]
[  412.106379] Kernel panic - not syncing: Irrecoverable deferred error trap.
[  412.106379] 
[  412.106985] Call Trace:
[  412.107185]  [00000000004292d4] cheetah_deferred_handler+0x1f4/0x440
[  412.107651]  [0000000000405e50] c_deferred+0x18/0x24
[  412.108015]  [0000000000524514] vfs_write+0xd4/0x120
[  412.108380]  [0000000000524710] SyS_write+0x30/0x60
[  412.108741]  [0000000000406134] linux_sparc_syscall32+0x34/0x40
[  412.109173] Press Stop-A (L1-A) to return to the boot prom


The system is still up and running, however, probing the i2c again using "sensors-detect" I see this:

Mar  8 23:16:46 blade kernel: [ 7413.029730] BUG: NMI Watchdog detected LOCKUP on CPU1, ip 0045c0e0, registers:
Mar  8 23:16:46 blade kernel: [ 7413.031979] TSTATE: 0000004480e01600 TPC: 000000000045c0e0 TNPC: 000000000045c0e4 Y: 00000000    Not tainted
Mar  8 23:16:46 blade kernel: [ 7413.034509] TPC: <panic_smp_self_stop+0x0/0x20>
Mar  8 23:16:46 blade kernel: [ 7413.035761] g0: fffff801fa6f3221 g1: 0000000000a23800 g2: fffffffffffffff8 g3: 0000000010083344
Mar  8 23:16:46 blade kernel: [ 7413.038281] g4: fffff801f41a2d00 g5: fffff801fa764000 g6: fffff801fa6f0000 g7: 000007fd0804ad88
Mar  8 23:16:46 blade kernel: [ 7413.040925] o0: 0000000000000000 o1: 0000000000000000 o2: 000000000055ea80 o3: 0a09666f72656163
Mar  8 23:16:46 blade kernel: [ 7413.043637] o4: 6820246920283078 o5: 30302c2030783032 sp: fffff801fa6f3161 ret_pc: 000000000089c578
Mar  8 23:16:46 blade kernel: [ 7413.046441] RPC: <panic+0x34/0x224>
Mar  8 23:16:46 blade kernel: [ 7413.047790] l0: 0000000000968000 l1: 0000000000aa6130 l2: 0000000000000000 l3: 0000000000000000
Mar  8 23:16:46 blade kernel: [ 7413.050636] l4: fffff801f487b0b8 l5: 00000000000000b8 l6: fffff801f487b000 l7: 80000001e92216b0
Mar  8 23:16:46 blade kernel: [ 7413.053576] i0: 0000000000968c28 i1: 0000000000968000 i2: 00000000009685c0 i3: 000000000055ea80
Mar  8 23:16:46 blade kernel: [ 7413.056625] i4: 0000000000a299a0 i5: 0000000000a29998 i6: fffff801fa6f3221 i7: 00000000004292d4
Mar  8 23:16:46 blade kernel: [ 7413.059744] I7: <cheetah_deferred_handler+0x1f4/0x440>
Mar  8 23:16:46 blade kernel: [ 7413.061377] Call Trace:
Mar  8 23:16:46 blade kernel: [ 7413.062807]  [00000000004292d4] cheetah_deferred_handler+0x1f4/0x440
Mar  8 23:16:46 blade kernel: [ 7413.064496]  [0000000000405e50] c_deferred+0x18/0x24
Mar  8 23:16:46 blade kernel: [ 7413.066084]  [000000000055ea80] __fsnotify_parent+0x0/0xe0
Mar  8 23:16:46 blade kernel: [ 7413.067712]  [0000000000524710] SyS_write+0x30/0x60
Mar  8 23:16:46 blade kernel: [ 7413.069308]  [0000000000406134] linux_sparc_syscall32+0x34/0x40
Mar  8 23:16:46 blade kernel: [ 7413.070958] Call Trace:
Mar  8 23:16:46 blade kernel: [ 7413.072360]  [00000000004209f4] tl0_irq15+0x14/0x20
Mar  8 23:16:46 blade kernel: [ 7413.073873]  [000000000045c0e0] panic_smp_self_stop+0x0/0x20
Mar  8 23:16:46 blade kernel: [ 7413.075409]  [00000000004292d4] cheetah_deferred_handler+0x1f4/0x440
Mar  8 23:16:46 blade kernel: [ 7413.076982]  [0000000000405e50] c_deferred+0x18/0x24
Mar  8 23:16:46 blade kernel: [ 7413.078459]  [000000000055ea80] __fsnotify_parent+0x0/0xe0
Mar  8 23:16:46 blade kernel: [ 7413.079943]  [0000000000524710] SyS_write+0x30/0x60
Mar  8 23:16:46 blade kernel: [ 7413.081356]  [0000000000406134] linux_sparc_syscall32+0x34/0x40




Regards

Magnus 