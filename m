From: Anatoly Pugachev <matorola@gmail.com>
Date: Mon, 19 Feb 2018 15:32:59 +0000
Subject: [sparc64] git kernel (2.16.0-rc2) unaligned access TPC/OOPS in kmemleak_scan
Message-Id: <CADxRZqxPUMen4v1WOqp79Q761Jj86Dz92eU9arXkm1OfaaBxNw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello!

Using default (?) kernel option

CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE = 400

there's a kernel boot message:

[    0.339759] kmemleak: Early log buffer exceeded (24635), please
increase DEBUG_KMEMLEAK_EARLY_LOG_SIZE

increasing CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE to suggested size,
produces the following kernel TPC/OOPS for me, withing 1 minute after
machine boots:

$ zgrep DEBUG_KMEMLEAK /proc/config.gz
CONFIG_HAVE_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE$636
# CONFIG_DEBUG_KMEMLEAK_TEST is not set
# CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set

$ systemd-analyze
Startup finished in 7.670s (kernel) + 22.578s (userspace) = 30.249s
graphical.target reached after 22.474s in userspace


[  OK  ] Started Samba SMB Daemon.
[  OK  ] Reached target Multi-User System.
[  OK  ] Reached target Graphical Interface.
         Starting Update UTMP about System Runlevel Changes...
[  OK  ] Started Update UTMP about System Runlevel Changes.
[   31.691103] tun: Universal TUN/TAP device driver, 1.6

Debian GNU/Linux buster/sid ttip console

[   65.561601] log_unaligned: 9641 callbacks suppressed
[   65.561618] Kernel unaligned access at TPC[65a5d4] kmemleak_scan+0x2d4/0x820
[   65.561813] Unable to handle kernel NULL pointer dereference in mna handler
[   65.561819]  at virtual address 000000000000001a
[   65.561890] current->{active_,}mm->context = 0000000000000244
[   65.561927] current->{active_,}mm->pgd = fff800409f494000
[   65.561964]               \|/ ____ \|/
[   65.561964]               "@'/ .. \`@"
[   65.561964]               /_| \__/ |_\
[   65.561964]                  \__U_/
[   65.562046] kmemleak(197): Oops [#1]
[   65.562077] CPU: 8 PID: 197 Comm: kmemleak Not tainted 4.16.0-rc2 #633
[   65.562121] TSTATE: 0000009980001604 TPC: 000000000065a5d4 TNPC:
000000000065a5d8 Y: 00001243    Not tainted
[   65.562182] TPC: <kmemleak_scan+0x2d4/0x820>
[   65.562213] g0: 0000000000000000 g1: fffffffffffffffe g2:
0000000000000001 g3: fffffffffffffffe
[   65.562266] g4: fff80000fb4491c0 g5: fff80040bc040000 g6:
fff80040a1a24000 g7: 0000000000000200
[   65.562319] o0: 00060000486c0000 o1: 00060000023fe109 o2:
0000000000000000 o3: 0000000000c28c00
[   65.562375] o4: 0000000000c28c00 o5: 0000000000000000 sp:
fff80040a1a27481 ret_pc: 000000000065a5e8
[   65.562432] RPC: <kmemleak_scan+0x2e8/0x820>
[   65.562465] l0: 0000000000b4dac8 l1: 000000000205fca3 l2:
00000000007fffff l3: 0000000001844800
[   65.562519] l4: 0000000000be1800 l5: 0000000000000000 l6:
0000000000000000 l7: 0000000000000000
[   65.562574] i0: 00000000486c0000 i1: 0000000001847000 i2:
0000000000c28c00 i3: 0000000000bf9400
[   65.562628] i4: 0000000000c28dc0 i5: 0000000001018000 i6:
fff80040a1a27541 i7: 000000000065b10c
[   65.562688] I7: <kmemleak_scan_thread+0x8c/0x100>
[   65.562724] Call Trace:
[   65.562750]  [000000000065b10c] kmemleak_scan_thread+0x8c/0x100
[   65.562797]  [000000000048bbb4] kthread+0x114/0x140
[   65.562840]  [0000000000406084] ret_from_fork+0x1c/0x2c
[   65.562878]  [0000000000000000]           (null)
[   65.562912] Disabling lock debugging due to kernel taint
[   65.562936] Caller[000000000065b10c]: kmemleak_scan_thread+0x8c/0x100
[   65.562961] Caller[000000000048bbb4]: kthread+0x114/0x140
[   65.562984] Caller[0000000000406084]: ret_from_fork+0x1c/0x2c
[   65.563006] Caller[0000000000000000]:           (null)
[   65.563026] Instruction DUMP:
[   65.563030]  84086001
[   65.563046]  82007fff
[   65.563060]  87789401
[   65.563073] <c200e01c>
[   65.563088]  80a06000
[   65.563101]  2248000f
[   65.563114]  ba076001
[   65.563127]  94102000
[   65.563140]  7ffffe6e
[   65.563153]



Not sure how this affects system (except system boots almost 10
seconds slower than usually), since it works and no more OOPS are
generated.

PS: any value which is more than suggested  (tested kernel boot with
24636, 25000, 40000) produces TPC/OOPS. Any value which is less than
24635 (tested with 400, 12000,18000, 22000, 24000), does not produce
TPC/OOPS.
