From: Meelis Roos <mroos@linux.ee>
Date: Thu, 15 Oct 2015 16:02:14 +0000
Subject: Netra T1-105 reboot hang (prtfconf/openprom module related?)
Message-Id: <alpine.LRH.2.20.1510151843560.9909@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I have a Netra T1-105 (OBP is latest that was released, 3.10.27 ME) with 
Linux (debian unstable snapshot from July 2015) running latest devel 
kernels and I have not seen it rebooting without hang yet (4.1, 4.2, 
4.3-rc5 tested so far).

[  OK  ] Reached target Shutdown.
[  133.113329] NMI watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [systemd:1]
[  133.207178] Modules linked in: pata_cmd64x qla1280 libata flash autofs4
[  133.294191] CPU: 0 PID: 1 Comm: systemd Not tainted 4.3.0-rc5-00061-ged4bf24 #5
[  133.390274] task: fffff80037080000 ti: fffff8003706c000 task.ti: fffff8003706c000
[  133.488744] TSTATE: 0000000011001604 TPC: 0000000000672bec TNPC: 0000000000672bf0 Y: e3f8ab00    Not tainted
[  133.618117] TPC: <misc_open+0x4c/0x180>
[  133.668519] g0: 0000000000000000 g1: 0000000000000098 g2: fffff80037696428 g3: fffff800374055d0
[  133.782906] g4: fffff80037080000 g5: 0000000000000078 g6: fffff8003706c000 g7: 0000000000000001
[  133.897388] o0: 0000000000949818 o1: fffff8003706fa7c o2: fffff80037405580 o3: 0000000000000003
[  134.011871] o4: fffff80036813c80 o5: fffff80036813c88 sp: fffff8003706f111 ret_pc: 0000000000672bb8
[  134.130931] RPC: <misc_open+0x18/0x180>
[  134.181355] l0: 0000000000949800 l1: 0000000000000000 l2: 000000000050e8e0 l3: 0000000000001000
[  134.295740] l4: 00000000ffa83760 l5: 00000000ffffffff l6: 0000000000000000 l7: 0000000070139d38
[  134.410224] i0: fffff800373bf850 i1: fffff8003611a380 i2: 0000000000949800 i3: 0000000000949830
[  134.524706] i4: 0000000000000082 i5: 000000001000e770 i6: fffff8003706f1c1 i7: 000000000050f248
[  134.639248] I7: <chrdev_open+0x88/0x120>
[  134.690767] Call Trace:
[  134.722904]  [000000000050f248] chrdev_open+0x88/0x120
[  134.790498]  [000000000050909c] do_dentry_open.isra.17+0x1dc/0x340
[  134.871818]  [0000000000517d28] path_openat+0x3a8/0x1060
[  134.941684]  [0000000000519a84] do_filp_open+0x44/0xc0
[  135.009271]  [000000000050a3f0] do_sys_open+0x130/0x240
[  135.078015]  [0000000000406094] linux_sparc_syscall32+0x34/0x60

This is what I see on reboot (halt works fine and drops to OF prompt).

Probably related: running prtfconf puts the system into a soft lockup - 
answers to ping but no ssh any more. openprom module is built into the 
kernel. On hang, I get the same kind of backtrace from watchdog but from 
different offset in misc_open:

[  115.074318] NMI watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [prtconf:1518]
[  115.171649] Modules linked in: pata_cmd64x qla1280 libata flash autofs4
[  115.258664] CPU: 0 PID: 1518 Comm: prtconf Not tainted 4.3.0-rc5-00061-ged4bf24 #5
[  115.358178] task: fffff800372c91a0 ti: fffff800361a4000 task.ti: fffff800361a4000
[  115.456648] TSTATE: 0000000011001606 TPC: 0000000000672bdc TNPC: 0000000000672be0 Y: 0eb75db5    Not tainted
[  115.586021] TPC: <misc_open+0x3c/0x180>
[  115.636426] g0: 0000000000000000 g1: 000000001000e788 g2: fffff8003769a428 g3: fffff800374055d0
[  115.750811] g4: fffff800372c91a0 g5: 0000000000000018 g6: fffff800361a4000 g7: 0000000000000001
[  115.865294] o0: 0000000000949818 o1: fffff800361a7a7c o2: fffff80037405580 o3: 0000000000000003
[  115.979777] o4: fffff80036813c80 o5: fffff80036813c88 sp: fffff800361a7111 ret_pc: 0000000000672bb8
[  116.098837] RPC: <misc_open+0x18/0x180>
[  116.149261] l0: 0000000000949800 l1: 0000000000000000 l2: 000000000050e8e0 l3: 0000000000001000
[  116.263644] l4: 0000000000001818 l5: fffff80000001818 l6: 0000000000991400 l7: fffff80036121818
[  116.378165] i0: fffff800373bf3f0 i1: fffff80031bff960 i2: 0000000000949800 i3: 0000000000949830
[  116.492639] i4: 000000000000008b i5: 000000001000e770 i6: fffff800361a71c1 i7: 000000000050f248
[  116.607142] I7: <chrdev_open+0x88/0x120>
[  116.658674] Call Trace:
[  116.690810]  [000000000050f248] chrdev_open+0x88/0x120
[  116.758405]  [000000000050909c] do_dentry_open.isra.17+0x1dc/0x340
[  116.839722]  [0000000000517d28] path_openat+0x3a8/0x1060
[  116.909591]  [0000000000519a84] do_filp_open+0x44/0xc0
[  116.977177]  [000000000050a3f0] do_sys_open+0x130/0x240
[  117.045922]  [0000000000406094] linux_sparc_syscall32+0x34/0x60

Setting CONFIG_SUN_OPENPROMIO=M breaks prtconf as expected (Cannot open 
/dev/openprom) but does not cure the reboot problem.

How do I debug this further?

-- 
Meelis Roos (mroos@linux.ee)
