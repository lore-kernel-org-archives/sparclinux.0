From: Meelis Roos <mroos@linux.ee>
Date: Mon, 18 Aug 2014 11:37:50 +0000
Subject: 3.16.0-11383-gc9...: WARNING at exit_mmap
Message-Id: <alpine.SOC.1.00.1408181406520.2922@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun Ultra 2, I got this on reboot from 3.16.0-11383-gc9 (to boot into 
3.17-rc1 for test). I _think_ it was with hugetlb off (now I turned it 
on).

Was 3.16.0-11383 supposed to have the fix already or not?


I[info] Using makefile-style concurrent boot in runlevel 6.
[185605.115774] sed[18479]: segfault at 612e706c ip 0000000000019f94 
(rpc 00000000f7e39cc8) sp 00000000ffb13ac0 error 30001 in sed[10000+]
[185605.269032] ------------[ cut here ]------------
[185605.328134] WARNING: CPU: 1 PID: 18479 at mm/mmap.c:2766 
exit_mmap+0x140/0x160()
[.[185605.420630] Modules linked in: ipv6 flash sunhme loop sg sr_mod 
evdev cdrom
.[185605.509508] CPU: 1 PID: 18479 Comm: sed Not tainted 
3.16.0-11383-gc9d2642 #92
..[185605.599777] Call Trace:
][185605.634611]  [000000000045170c] warn_slowpath_common+0x4c/0x80
 [185605.709085]  [00000000004e3560] exit_mmap+0x140/0x160
St[185605.774257]  [000000000044fc0c] mmput.part.56+0xc/0xc0
o[185605.841453]  [000000000045251c] exit_mm+0x11c/0x180
p[185605.904353]  [0000000000453dfc] do_exit+0x23c/0x340
p[185605.967357]  [0000000000454028] do_group_exit+0x28/0xc0
in[185606.034398]  [000000000045da30] get_signal+0x1d0/0x3c0
g[185606.101342]  [0000000000440e84] do_signal32+0x4/0x200
 [185606.166230]  [000000000042d078] do_signal+0x338/0x520
de[185606.231292]  [000000000042da60] do_notify_resume+0x40/0x60
f[185606.302340]  [0000000000404b04] __handle_signal+0xc/0x2c
er[185606.370227] ---[ end trace 556ca9d82a279e2f ]---
red ex[185606.435617] BUG: Bad rss-counter state mm:ffffff006ca18e80 idx:1 val:1


3.17-rc1 seems stable so far with debian upgrade and looping git clone, 
with THP on and gcc 4.6.4. But that warning is never easily 
reproducible.

-- 
Meelis Roos (mroos@linux.ee)
