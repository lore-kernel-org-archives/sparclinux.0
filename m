From: Meelis Roos <mroos@linux.ee>
Date: Fri, 29 Nov 2013 09:11:36 +0000
Subject: Lockdep warning on sparc64 statup
Message-Id: <alpine.SOC.1.00.1311291106330.5464@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I turned on lockdep to help me debug the RED state exception on reboot. 
On my dual CPU E3500, the RED state problem did not happen but lockdep 
found the following PROM call-related problem:

------------[ cut here ]------------
WARNING: CPU: 6 PID: 1 at kernel/locking/lockdep.c:3535 check_flags+0x7c/0x240()
DEBUG_LOCKS_WARN_ON(current->hardirqs_enabled)
Modules linked in:
CPU: 6 PID: 1 Comm: swapper/6 Not tainted 3.13.0-rc1-dirty #17
Call Trace:
 [00000000004585cc] warn_slowpath_common+0x4c/0x80
 [00000000004586ac] warn_slowpath_fmt+0x2c/0x40
 [0000000000498d9c] check_flags+0x7c/0x240
 [000000000049bf40] lock_acquire+0x20/0x80
 [000000000081e188] _raw_spin_lock+0x28/0x40
 [000000000061bd74] p1275_cmd_direct+0x14/0x60
 [000000000061bc0c] prom_startcpu+0x2c/0x40
 [000000000043e3bc] __cpu_up+0x5c/0x180
 [0000000000458830] _cpu_up.constprop.1+0xd0/0x160
 [0000000000458958] cpu_up+0x58/0x80
 [00000000009fe2b4] smp_init+0x74/0xbc
 [00000000009f49e4] kernel_init_freeable+0x7c/0x110
 [000000000080af24] kernel_init+0x4/0x120
 [00000000004060c4] ret_from_fork+0x1c/0x2c
 [0000000000000000]           (null)
---[ end trace e61cc8445001155f ]---
possible reason: unannotated irqs-off.
irq event stamp: 2051
hardirqs last  enabled at (2051): [<000000000081e9d8>] _raw_spin_unlock_irqrestore+0x38/0x60
hardirqs last disabled at (2050): [<000000000081e234>] _raw_spin_lock_irqsave+0x14/0x60
softirqs last  enabled at (398): [<000000000045d098>] __do_softirq+0x178/0x200
softirqs last disabled at (393): [<000000000042bb8c>] do_softirq_own_stack+0x2c/0x40

-- 
Meelis Roos (mroos@linux.ee)
