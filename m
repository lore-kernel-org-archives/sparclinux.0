From: David Miller <davem@davemloft.net>
Date: Fri, 10 Oct 2014 19:50:10 +0000
Subject: Re: locking warning from p1275_cmd_direct
Message-Id: <20141010.155010.1784922883234008618.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.11.1410062206320.32206@adalberg.ut.ee>
In-Reply-To: <alpine.LRH.2.11.1410062206320.32206@adalberg.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Fri, 10 Oct 2014 17:11:23 +0300 (EEST)

>> 
>> > Now that My Ultra 5 is stable again, I noticed this new warning during 
>> > reboot:
>> 
>> Can you give this patch a try?
> 
> It fixes the warning and the computer still reboots fine - thank you for 
> quick response!

Thanks for testing, this is the final patch I committed.

[PATCH] sparc64: Fix lockdep warnings on reboot on Ultra-5

Inconsistently, the raw_* IRQ routines do not interact with and update
the irqflags tracing and lockdep state, whereas the raw_* spinlock
interfaces do.

This causes problems in p1275_cmd_direct() because we disable hardirqs
by hand using raw_local_irq_restore() and then do a raw_spin_lock()
which triggers a lockdep trace because the CPU's hw IRQ state doesn't
match IRQ tracing's internal software copy of that state.

The CPU's irqs are disabled, yet current->hardirqs_enabled is true.

==========
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
==========

Use local_* variables of the hw IRQ interfaces so that IRQ tracing sees
all of our changes.

Reported-by: Meelis Roos <mroos@linux.ee>
Tested-by: Meelis Roos <mroos@linux.ee>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/prom/p1275.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/prom/p1275.c b/arch/sparc/prom/p1275.c
index e58b817..b2340f0 100644
--- a/arch/sparc/prom/p1275.c
+++ b/arch/sparc/prom/p1275.c
@@ -9,6 +9,7 @@
 #include <linux/smp.h>
 #include <linux/string.h>
 #include <linux/spinlock.h>
+#include <linux/irqflags.h>
 
 #include <asm/openprom.h>
 #include <asm/oplib.h>
@@ -36,8 +37,8 @@ void p1275_cmd_direct(unsigned long *args)
 {
 	unsigned long flags;
 
-	raw_local_save_flags(flags);
-	raw_local_irq_restore((unsigned long)PIL_NMI);
+	local_save_flags(flags);
+	local_irq_restore((unsigned long)PIL_NMI);
 	raw_spin_lock(&prom_entry_lock);
 
 	prom_world(1);
@@ -45,7 +46,7 @@ void p1275_cmd_direct(unsigned long *args)
 	prom_world(0);
 
 	raw_spin_unlock(&prom_entry_lock);
-	raw_local_irq_restore(flags);
+	local_irq_restore(flags);
 }
 
 void prom_cif_init(void *cif_handler, void *cif_stack)
-- 
1.7.11.7

