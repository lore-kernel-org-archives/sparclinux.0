From: Dennis Gilmore <dennis@ausil.us>
Date: Wed, 01 Nov 2006 20:49:37 +0000
Subject: T1000 CPU lockups
Message-Id: <200611011449.37829.dennis@ausil.us>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I have had  my T1000 lockup intermittently.  I'm running a vanilla 2.6.18 
kernel.   I get in the system logs for quite a few of the cpu's

Oct 31 20:58:19 daedalus kernel: BUG: soft lockup detected on CPU#21!
Oct 31 20:58:19 daedalus kernel: Call Trace:
Oct 31 20:58:20 daedalus kernel:  [00000000004319f4] 
smp_percpu_timer_interrupt+0xd4/0x144
Oct 31 20:58:20 daedalus kernel:  [00000000004109d4] tl0_irq14+0x1c/0x20
Oct 31 20:58:20 daedalus kernel:  [0000000000468f28] futex_lock_pi+0x130/0x7cc
Oct 31 20:58:20 daedalus kernel:  [000000000046a154] do_futex+0xb90/0xbbc
Oct 31 20:58:20 daedalus kernel:  [000000000046a6f4] 
compat_sys_futex+0x11c/0x130
Oct 31 20:58:20 daedalus kernel:  [0000000000406c94] 
linux_sparc_syscall32+0x3c/0x40
Oct 31 20:58:20 daedalus kernel:  [00000000701004b0] 0x701004b8

after these. while the system stays alive  I cant actually do anything 

-- 
Dennis Gilmore, RHCE
Proud Australian
