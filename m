From: Frans Pop <elendil@planet.nl>
Date: Sat, 15 Nov 2008 22:43:58 +0000
Subject: [2.6.26.4] Oops: Unable to handle kernel paging request at virtual address 00000000491f2000
Message-Id: <200811152343.58603.elendil@planet.nl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

During a test installation of Debian I got the following Oops at the point
where either the installer's internal webserver (implemented in shell using
netcat ;-) was started or where that server was contacted a bit later.
The oops did not repeat; the installation as a whole succeeded.

I know this is not a very current kernel, but this is what we're releasing
with. Well, the release will be using 2.6.26.7 actually.

Cheers,
FJP

Nov 15 21:51:18 main-menu[8071]: INFO: Menu item 'save-logs' selected
Nov 15 21:51:20 kernel: [ 2172.122285] Unable to handle kernel paging request at virtual address 00000000491f2000
Nov 15 21:51:20 kernel: [ 2172.122723] tsk->{mm,active_mm}->context = 000000000000103c
Nov 15 21:51:20 kernel: [ 2172.123000] tsk->{mm,active_mm}->pgd = fffff8003e28e000
Nov 15 21:51:20 kernel: [ 2172.123260]               \|/ ____ \|/
Nov 15 21:51:20 kernel: [ 2172.123272]               "@'/ .. \`@"
Nov 15 21:51:20 kernel: [ 2172.123282]               /_| \__/ |_\
Nov 15 21:51:20 kernel: [ 2172.123291]                  \__U_/
Nov 15 21:51:20 kernel: [ 2172.123311] cat(6180): Oops [#1]
Nov 15 21:51:20 kernel: [ 2172.123335] TSTATE: 0000008811009607 TPC: 00000000004579ac TNPC: 00000000004579b0 Y: 00000000    Not tainted
Nov 15 21:51:20 kernel: [ 2172.123379] TPC: <r_show+0x34/0x9c>
Nov 15 21:51:20 kernel: [ 2172.123398] g0: 00000000491f4458 g1: 000000000000ffff g2: ffffffffffffffff g3: 00000000491f2ba8
Nov 15 21:51:20 kernel: [ 2172.123425] g4: fffff800309c93e0 g5: 0000000000000010 g6: fffff8003b32c000 g7: 000000000073be58
Nov 15 21:51:20 kernel: [ 2172.123451] o0: fffff8003bba1a40 o1: 00000000006e7f30 o2: 0000000000000000 o3: 00000000006f22a8
Nov 15 21:51:20 kernel: [ 2172.123478] o4: 0000000000000008 o5: 000001ffc0000000 sp: fffff8003b32f2a1 ret_pc: 0000000000457a0c
Nov 15 21:51:20 kernel: [ 2172.123506] RPC: <r_show+0x94/0x9c>
Nov 15 21:51:20 kernel: [ 2172.123525] l0: fffff8003bba1a40 l1: fffff8003f0025c0 l2: 0000000000000000 l3: 0000000000000000
Nov 15 21:51:20 kernel: [ 2172.123550] l4: 0000000000000000 l5: 0000000000000000 l6: 0000000000000000 l7: 0000000000000000
Nov 15 21:51:20 kernel: [ 2172.123577] i0: fffff8003bba1a40 i1: 00000000491f2ba8 i2: fffff8003b32fc30 i3: 435f322e30000000
Nov 15 21:51:20 kernel: [ 2172.123603] i4: 435f322e30000000 i5: 000000000000ffff i6: fffff8003b32f381 i7: 00000000004c6098
Nov 15 21:51:20 kernel: [ 2172.123646] I7: <seq_read+0x1f4/0x318>
Nov 15 21:51:20 kernel: [ 2172.123662] Caller[00000000004c6098]: seq_read+0x1f4/0x318
Nov 15 21:51:20 kernel: [ 2172.123692] Caller[00000000004ea138]: proc_reg_read+0x4c/0x60
Nov 15 21:51:20 kernel: [ 2172.123722] Caller[00000000004ac040]: vfs_read+0x78/0x124
Nov 15 21:51:20 kernel: [ 2172.123754] Caller[00000000004ac328]: sys_read+0x34/0x60
Nov 15 21:51:20 kernel: [ 2172.123783] Caller[00000000004060d4]: linux_sparc_syscall32+0x3c/0x40
Nov 15 21:51:20 kernel: [ 2172.123825] Caller[0000000000015004]: 0x1500c
Nov 15 21:51:20 kernel: [ 2172.123849] Instruction DUMP: 94102000  80a08001  99673008 <c658e020> 80a0c007  22600007  c25e6010  9402a001  80a2a005 
