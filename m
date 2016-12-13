From: Anatoly Pugachev <matorola@gmail.com>
Date: Tue, 13 Dec 2016 10:31:06 +0000
Subject: Re: git kernel (4.9.0-rc3) hard lockup on cpu
Message-Id: <CADxRZqyQv9fhu9f8uWkphn6jCSPutJL3MYnMuTgG2wvPutMfUQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqxOUEaPExMNC9E5sUe777CxOsFmzmHC8EcwtHJO2OC5hQ@mail.gmail.com>
In-Reply-To: <CADxRZqxOUEaPExMNC9E5sUe777CxOsFmzmHC8EcwtHJO2OC5hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

not a hard lockup, but soft one:

Message from syslogd@landau at Dec 13 01:31:08 ...
 kernel:[9977482.116040] NMI watchdog: BUG: soft lockup - CPU#0 stuck
for 23s! [rm:99074]
Dec 13 01:31:08 landau kernel: NMI watchdog: BUG: soft lockup - CPU#0
stuck for 23s! [rm:99074]
Dec 13 01:31:08 landau kernel: Modules linked in: tun xt_tcpudp
xt_multiport xt_conntrack iptable_filter iptable_nat nf_conntrack_ipv4
nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack n2_rng flash rng_core
camellia_sparc64 des_sparc64 des_generic aes_sparc64 md5_sparc64
sha512_sparc64 sha256_sparc64 sha1_sparc64 ip_tables x_tables autofs4
ext4 crc16 jbd2 fscrypto mbcache btrfs xor zlib_deflate raid6_pq
crc32c_sparc64 sunvnet sunvdc
Dec 13 01:31:08 landau kernel: irq event stamp: 8623998
Dec 13 01:31:08 landau kernel: hardirqs last  enabled at (8623997):
Dec 13 01:31:08 landau kernel: [<0000000000a7016c>]
_raw_spin_unlock_irqrestore+0x2c/0x80
Dec 13 01:31:08 landau kernel: hardirqs last disabled at (8623998):
Dec 13 01:31:08 landau kernel: [<0000000000426be8>] sys_call_table+0x648/0x820
Dec 13 01:31:08 landau kernel: softirqs last  enabled at (8306350):
Dec 13 01:31:08 landau kernel: [<0000000000a72ca0>] __do_softirq+0x220/0x5c0
Dec 13 01:31:08 landau kernel: softirqs last disabled at (8306305):
Dec 13 01:31:08 landau kernel: [<000000000042c1b4>]
do_softirq_own_stack+0x34/0x60
Dec 13 01:31:08 landau kernel: CPU: 0 PID: 99074 Comm: rm Not tainted
4.9.0-rc5+ #2
Dec 13 01:31:08 landau kernel: task: fff8000eead080e0 task.stack:
fff8000f0bdcc000
Dec 13 01:31:08 landau kernel: TSTATE: 0000000011001604 TPC:
0000000000a7017c TNPC: 0000000000a70180 Y: 00000021    Not tainted
Dec 13 01:31:08 landau kernel: TPC: <_raw_spin_unlock_irqrestore+0x3c/0x80>
Dec 13 01:31:08 landau kernel: g0: 00000fff00000000 g1:
0000000000000000 g2: 00000000014e46e8 g3: 0000000000000003
Dec 13 01:31:08 landau kernel: g4: fff8000eead080e0 g5:
fff800207c23a000 g6: fff8000f0bdcc000 g7: ca934ba76367fbad
Dec 13 01:31:08 landau kernel: o0: 0000000001ba7888 o1:
0000000000000003 o2: 00000000007cd758 o3: fff8000eead080e0
Dec 13 01:31:08 landau kernel: o4: 0000000000000004 o5:
fff8000eead08970 sp: fff8000f0bdcee81 ret_pc: 0000000000a7016c
Dec 13 01:31:08 landau kernel: RPC: <_raw_spin_unlock_irqrestore+0x2c/0x80>
Dec 13 01:31:08 landau kernel: l0: 0000000000000000 l1:
0000000000000000 l2: fff8000f0c931810 l3: 0000000000d00400
Dec 13 01:31:08 landau kernel: l4: 000000000000000e l5:
0000000000000001 l6: 0000000000000000 l7: 0000000000000008
Dec 13 01:31:08 landau kernel: i0: 0000000001ba7888 i1:
0000000000000000 i2: 0000000000c78800 i3: 0000000001b38648
Dec 13 01:31:08 landau kernel: i4: 0000000000000000 i5:
0000000001ba7888 i6: fff8000f0bdcef31 i7: 00000000007cd758
Dec 13 01:31:08 landau kernel: I7: <debug_object_activate+0xd8/0x240>
Dec 13 01:31:08 landau kernel: Call Trace:
Dec 13 01:31:08 landau kernel:  [00000000007cd758]
debug_object_activate+0xd8/0x240
Dec 13 01:31:08 landau kernel:  [00000000004f5700]
__call_rcu.constprop.61+0x20/0x6e0
Dec 13 01:31:08 landau kernel:  [00000000004f5e5c] call_rcu_sched+0x1c/0x40
Dec 13 01:31:08 landau kernel:  [0000000000653ea0] dentry_free+0x40/0xc0
Dec 13 01:31:08 landau kernel:  [0000000000654060] __dentry_kill+0x140/0x1c0
Dec 13 01:31:08 landau kernel:  [0000000000654cd4]
shrink_dentry_list+0x114/0x5a0
Dec 13 01:31:08 landau kernel:  [0000000000655220]
shrink_dcache_parent+0x20/0x80
Dec 13 01:31:08 landau kernel:  [00000000006494b8] vfs_rmdir+0xb8/0x160
Dec 13 01:31:08 landau kernel:  [000000000064b2b4] do_rmdir+0x1f4/0x220
Dec 13 01:31:08 landau kernel:  [000000000064bdf8] SyS_unlinkat+0x38/0x60
Dec 13 01:31:08 landau kernel:  [0000000000406234] linux_sparc_syscall+0x34/0x44
