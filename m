From: Meelis Roos <mroos@linux.ee>
Date: Thu, 09 Oct 2014 11:06:02 +0000
Subject: locking warning from p1275_cmd_direct
Message-Id: <alpine.LRH.2.11.1410062206320.32206@adalberg.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Now that My Ultra 5 is stable again, I noticed this new warning during 
reboot:

reboot: Restarting system
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at kernel/locking/lockdep.c:3536 check_flags+0x7c/0x240()
DEBUG_LOCKS_WARN_ON(current->hardirqs_enabled)
Modules linked in: openpromfs
CPU: 0 PID: 1 Comm: systemd-shutdow Tainted: G        W      3.17.0-dirty #145
Call Trace:
 [000000000045919c] warn_slowpath_common+0x5c/0xa0
 [0000000000459210] warn_slowpath_fmt+0x30/0x40
 [000000000048f41c] check_flags+0x7c/0x240
 [0000000000493280] lock_acquire+0x20/0x1c0
 [0000000000832b70] _raw_spin_lock+0x30/0x60
 [000000000068f2fc] p1275_cmd_direct+0x1c/0x60
 [000000000068ed28] prom_reboot+0x28/0x40
 [000000000043610c] machine_restart+0x4c/0x80
 [000000000047d2d4] kernel_restart+0x54/0x80
 [000000000047d618] SyS_reboot+0x138/0x200
 [00000000004060b4] linux_sparc_syscall32+0x34/0x60
---[ end trace 5c439fe81c05a100 ]---
possible reason: unannotated irqs-off.
irq event stamp: 2010267
hardirqs last  enabled at (2010267): [<000000000049a358>] vprintk_emit+0x4b8/0x580
hardirqs last disabled at (2010266): [<0000000000499f08>] vprintk_emit+0x68/0x580
softirqs last  enabled at (2010046): [<000000000045d278>] __do_softirq+0x378/0x4a0
softirqs last disabled at (2010039): [<000000000042bf08>] do_softirq_own_stack+0x28/0x40
Resetting ...

-- 
Meelis Roos (mroos@linux.ee)
