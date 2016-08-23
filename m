From: Meelis Roos <mroos@linux.ee>
Date: Tue, 23 Aug 2016 09:46:34 +0000
Subject: Re: Netra T1-105 reboot hang (prtfconf/openprom module related?)
Message-Id: <alpine.LRH.2.20.1608231412360.16483@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> > I have a Netra T1-105 (OBP is latest that was released, 3.10.27 ME) with 
> > Linux (debian unstable snapshot from July 2015) running latest devel 
> > kernels and I have not seen it rebooting without hang yet (4.1, 4.2, 
> > 4.3-rc5 tested so far).
> [...]
> > Probably related: running prtfconf puts the system into a soft lockup - 
> > answers to ping but no ssh any more. openprom module is built into the 
> > kernel. On hang, I get the same kind of backtrace from watchdog but from 
> > different offset in misc_open:
> 
> I retested it with 4.6-rc6-... and it has been fine with two lastest 
> post-4.5 kernels (both reboot and prtconf -pv). So something has fixed 
> it.

In 4.7 era it is spontaneously broken again, as is 4.8-rc3 that I just 
tested. This is seen as NMI watchdog timeouts like this.

[ 4240.937607] NMI watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [systemd:1]
[ 4241.031510] Modules linked in: pata_cmd64x libata qla1280 flash openprom autofs4
[ 4241.128822] CPU: 0 PID: 1 Comm: systemd Not tainted 4.8.0-rc3-00013-gef0e1ea #2
[ 4241.224904] task: fffff80037080000 task.stack: fffff8003706c000
[ 4241.302783] TSTATE: 0000000011001604 TPC: 00000000006984fc TNPC: 0000000000698500 Y: 23c032be    Not tainted
[ 4241.432064] TPC: <misc_open+0x3c/0x180>
[ 4241.482460] g0: 0000000000000000 g1: 00000000100167a8 g2: fffff8003762b6e8 g3: fffff8003702ff50
[ 4241.596844] g4: fffff80037080000 g5: 0000000000000078 g6: fffff8003706c000 g7: 0000000000000001
[ 4241.711224] o0: 0000000000926670 o1: fffff8003706fa4c o2: fffff8003702ff00 o3: fffff80036813bf8
[ 4241.825707] o4: 0000000000000003 o5: fffff80036813bc8 sp: fffff8003706f0e1 ret_pc: 00000000006984d8
[ 4241.944769] RPC: <misc_open+0x18/0x180>
[ 4241.995191] l0: 0000000000926400 l1: 0000000000000000 l2: 0000000000526ee0 l3: 0000000000001000
[ 4242.109576] l4: 00000000ff835760 l5: 00000000ffffffff l6: 0000000000000000 l7: 0000000070139d38
[ 4242.224058] i0: fffff80037336740 i1: fffff80035bd6c40 i2: 0000000000926400 i3: 0000000000926688
[ 4242.338439] i4: 0000000000000082 i5: 0000000010016790 i6: fffff8003706f191 i7: 0000000000527668
[ 4242.452963] I7: <chrdev_open+0x88/0x140>
[ 4242.504500] Call Trace:
[ 4242.536635]  [0000000000527668] chrdev_open+0x88/0x140
[ 4242.604234]  [0000000000520208] do_dentry_open.isra.17+0x208/0x340
[ 4242.685551]  [000000000052f838] path_openat+0x158/0x1040
[ 4242.755419]  [0000000000531284] do_filp_open+0x44/0xc0
[ 4242.823006]  [0000000000521970] do_sys_open+0x130/0x220
[ 4242.891747]  [0000000000406054] linux_sparc_syscall32+0x34/0x60

-- 
Meelis Roos (mroos@linux.ee)
