From: Meelis Roos <mroos@linux.ee>
Date: Fri, 10 Mar 2017 17:42:25 +0000
Subject: 4.10 sparc64 regression: BUG: soft lockup - CPU#0 stuck for 23s! [khugepaged:153]
Message-Id: <alpine.LRH.2.20.1703101935240.21677@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I am seeing the following soft lockup on multiple Ultrasparc II era 
sparc machines - Ultra 2, Netra X1, Blade 100 at least. 4.9 was fine. 
Will attempt to bisect some time.

The lockups are detected routinely (every 2-3 files when compiling new 
kernel) but the machine keeps running.

CC added because of NMI changes - no idea if it is related.

I have THP enabled and always on in most machines' kernel config.

[503216.376072] NMI watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [khugepaged:153]
[503216.470787] Modules linked in: ipv6 loop snd_sun_cs4231 snd_pcm snd_timer sr_mod sg evdev cdrom snd soundcore sunhme parport_sunbpp parport flash
[503216.636654] CPU: 0 PID: 153 Comm: khugepaged Tainted: G             L  4.10.0-11624-g0710f3f #162
[503216.747322] task: fffff8006c57e180 task.stack: fffff8006c5e0000
[503216.822501] TSTATE: 0000004480001607 TPC: 00000000007dfa68 TNPC: 00000000007dfa6c Y: 01ceecf2    Tainted: G             L 
[503216.959282] TPC: <_raw_spin_unlock_irqrestore+0x8/0x20>
[503217.026217] g0: 00000000007dfa68 g1: 0000400000000000 g2: 0000000000008000 g3: 000000006c014000
[503217.134716] g4: fffff8006c57e180 g5: fffff8006eef8000 g6: fffff8006c5e0000 g7: 0000000000000016
[503217.243359] o0: fffff8006cd2d6c0 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000
[503217.351857] o4: 000000007143c000 o5: fffff8006cd2d400 sp: fffff8006c5e3191 ret_pc: 0000000000442efc
[503217.464434] RPC: <tlb_batch_add_one+0x5c/0x100>
[503217.522754] l0: fffff8006eef8000 l1: 0000000000000002 l2: 00000000009160c0 l3: 000000000000000e
[503217.631244] l4: 0000000000000001 l5: 0000000000000001 l6: fffff8006da38000 l7: 00000000000003ef
[503217.739733] i0: fffff8006cd2d400 i1: 000000007143c000 i2: 0000000000000000 i3: 0000000000000000
[503217.848185] i4: fffff8006f8006e0 i5: 00000000009086e0 i6: fffff8006c5e3241 i7: 0000000000443230
[503217.956690] I7: <set_pmd_at+0x130/0x1a0>
[503218.007747] Call Trace:
[503218.040947]  [0000000000443230] set_pmd_at+0x130/0x1a0
[503218.106503]  [00000000005060f4] pmdp_collapse_flush+0x14/0x40
[503218.179404]  [0000000000529f38] khugepaged_scan_pmd+0x3d8/0xac0
[503218.254370]  [000000000052acd0] khugepaged+0x6b0/0xa80
[503218.319827]  [0000000000470ef0] kthread+0xd0/0x120
[503218.381186]  [0000000000406044] ret_from_fork+0x1c/0x2c
[503218.447700]  [0000000000000000]           (null)


-- 
Meelis Roos (mroos@linux.ee)
