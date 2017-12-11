From: Jan Engelhardt <jengelh@inai.de>
Date: Mon, 11 Dec 2017 01:14:31 +0000
Subject: n2_crypto gets a BUG() triggered on T5240
Message-Id: <nycvar.YFH.7.76.1712110214220.28416@n3.vanv.qr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



With the current Debian sid system (2-3 days old) running the 4.14.2,
loading the n2_crypto module causes a BUG() to get triggered. The
system is a T5240 and the problem is reliably repeatable in case I
should try some suggestions, patches, or if I need to provide more
information. On a T5120, loading n2_crypto does not lead to this
issue.

Trimmed dmesg, kept the lines which seem relevant.

[   43.346362] n2_crypto: Found NCP at /virtual-devices@100/ncp@6
[   43.346490] n2_crypto: Registered NCS HVAPI version 2.0
[   43.346754] kernel BUG at /build/linux-NKZVgH/linux-4.14.2/mm/slab.c:3009!
	3009:        BUG_ON(ac->avail > 0 || !n);
[   43.346875]               \|/ ____ \|/
                             "@'/ .. \`@"
                             /_| \__/ |_\
                                \__U_/
[   43.347127] systemd-udevd(1318): Kernel bad sw trap 5 [#1]
[   43.347249] CPU: 44 PID: 1318 Comm: systemd-udevd Not tainted 4.14.0-1-sparc64-smp #1 Debian 4.14.2-1
[   43.347382] task: ffff801fa89d2bc0 task.stack: ffff801fa5290000
[   43.347500] TSTATE: 0000004411e01601 TPC: 0000000000604328 TNPC: 000000000060432c Y: 00000000    Not tainted
[   43.347709] TPC: <cache_alloc_refill+0x788/0xb80>
[   43.347782] g0: 0000000000000000 g1: 0000000000000000 g2: 0000000000000007 g3: 000000000000000e
[   43.347907] g4: ffff801fa89d2bc0 g5: ffff801ffd850000 g6: ffff801fa5290000 g7: 000000000000000e
[   43.348032] o0: 0000000000b50c78 o1: 0000000000000bc1 o2: 0000000000000000 o3: 0000000000000000
[   43.348171] o4: 0000000000000032 o5: ffff801fff671c00 sp: ffff801fa5292901 ret_pc: 0000000000604320
[   43.348299] RPC: <cache_alloc_refill+0x780/0xb80>
[   43.348318] camellia_sparc64: sparc64 camellia opcodes not available.
[   43.348481] l0: ffff801fa0021bc0 l1: 0000000000000000 l2: 0000000000c96400 l3: ffff801fa9322038
[   43.348607] l4: 0000000000b9e300 l5: 000000000000000c l6: 00005fffff591100 l7: 0000000000000000
[   43.348745] i0: ffff801fa8a09800 i1: 00000000014080c0 i2: ffff801ffd850000 i3: 0000dfe001d41100
[   43.348870] i4: 0000000000000000 i5: 0000000000000011 i6: ffff801fa52929d1 i7: 0000000000604ac8
[   43.348998] I7: <kmem_cache_alloc+0x1a8/0x1e0>
[   43.349066] Call Trace:
[   43.349139]  [0000000000604ac8] kmem_cache_alloc+0x1a8/0x1e0
[   43.349305]  [0000000011343d80] spu_mdesc_scan+0x1e0/0x440 [n2_crypto]
[   43.349439]  [0000000011344af0] n2_mau_probe+0xd0/0x220 [n2_crypto]
[   43.349571]  [00000000008509f4] platform_drv_probe+0x34/0xc0
[   43.349695]  [000000000084e30c] driver_probe_device+0x28c/0x460
[   43.349831]  [000000000084e5a4] __driver_attach+0xc4/0x120
[   43.349834] crc32c_sparc64: sparc64 crc32c opcode not available.
[   43.350067]  [000000000084bc84] bus_for_each_dev+0x44/0xa0
[   43.350187]  [000000000084da5c] driver_attach+0x1c/0x40
[   43.350306]  [000000000084d348] bus_add_driver+0x168/0x2a0
[   43.350427]  [000000000084f2d4] driver_register+0x74/0x120
[   43.350547]  [0000000000850b88] __platform_register_drivers+0x68/0x140
[   43.350694]  [0000000011352014] n2_init+0x14/0x24 [n2_crypto]
[   43.350818]  [00000000004272d8] do_one_initcall+0x38/0x160
[   43.350942]  [0000000000502414] do_init_module+0x54/0x1c0
[   43.351063]  [00000000005013d0] load_module+0x2070/0x2720
[   43.351183]  [0000000000501d10] SyS_finit_module+0xf0/0x100
[   43.351297] Disabling lock debugging due to kernel taint
[   43.351417] Caller[0000000000604ac8]: kmem_cache_alloc+0x1a8/0x1e0
[   43.351550] Caller[0000000011343d80]: spu_mdesc_scan+0x1e0/0x440 [n2_crypto]
[   43.351621] Caller[0000000011344af0]: n2_mau_probe+0xd0/0x220 [n2_crypto]
[   43.351684] Caller[00000000008509f4]: platform_drv_probe+0x34/0xc0
[   43.351902] Caller[000000000084e30c]: driver_probe_device+0x28c/0x460
[   43.352042] Caller[000000000084e5a4]: __driver_attach+0xc4/0x120
[   43.352133] Caller[000000000084bc84]: bus_for_each_dev+0x44/0xa0
[   43.352190] Caller[000000000084da5c]: driver_attach+0x1c/0x40
[   43.352245] Caller[000000000084d348]: bus_add_driver+0x168/0x2a0
[   43.352463] Caller[000000000084f2d4]: driver_register+0x74/0x120
[   43.352637] Caller[0000000000850b88]: __platform_register_drivers+0x68/0x140
[   43.352709] Caller[0000000011352014]: n2_init+0x14/0x24 [n2_crypto]
[   43.352770] Caller[00000000004272d8]: do_one_initcall+0x38/0x160
[   43.352862] Caller[0000000000502414]: do_init_module+0x54/0x1c0
[   43.353148] Caller[00000000005013d0]: load_module+0x2070/0x2720
[   43.353207] Caller[0000000000501d10]: SyS_finit_module+0xf0/0x100
[   43.353274] Caller[0000000000406214]: linux_sparc_syscall+0x34/0x44
[   43.353339] Caller[ffff8001004c22b4]: 0xffff8001004c22b4
[   43.353421] Instruction DUMP:
[   43.353427]  92102bc1 
[   43.353562]  7ff88fb8 
[   43.353719]  90122078 
[   43.353754] <91d02005>
[   43.353788]  11002d43 
[   43.353823]  92102b9c 
[   43.353858]  7ff88fb3 
[   43.353893]  90122078 
[   43.353959]  91d02005 
