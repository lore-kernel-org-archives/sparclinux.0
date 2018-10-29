From: Douglas Anderson <dianders@chromium.org>
Date: Mon, 29 Oct 2018 18:07:06 +0000
Subject: [PATCH 6/7] smp: Don't yell about IRQs disabled in kgdb_roundup_cpus()
Message-Id: <20181029180707.207546-7-dianders@chromium.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20181029180707.207546-1-dianders@chromium.org>
In-Reply-To: <20181029180707.207546-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

In kgdb_roundup_cpus() we've got code that looks like:
  local_irq_enable();
  smp_call_function(kgdb_call_nmi_hook, NULL, 0);
  local_irq_disable();

In certain cases when we drop into kgdb (like with sysrq-g on a serial
console) we'll get a big yell that looks like:

  sysrq: SysRq : DEBUG
  ------------[ cut here ]------------
  DEBUG_LOCKS_WARN_ON(current->hardirq_context)
  WARNING: CPU: 0 PID: 0 at .../kernel/locking/lockdep.c:2875 lockdep_hardirqs_on+0xf0/0x160
  CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.19.0 #27
  pstate: 604003c9 (nZCv DAIF +PAN -UAO)
  pc : lockdep_hardirqs_on+0xf0/0x160
  ...
  Call trace:
   lockdep_hardirqs_on+0xf0/0x160
   trace_hardirqs_on+0x188/0x1ac
   kgdb_roundup_cpus+0x14/0x3c
   kgdb_cpu_enter+0x53c/0x5cc
   kgdb_handle_exception+0x180/0x1d4
   kgdb_compiled_brk_fn+0x30/0x3c
   brk_handler+0x134/0x178
   do_debug_exception+0xfc/0x178
   el1_dbg+0x18/0x78
   kgdb_breakpoint+0x34/0x58
   sysrq_handle_dbg+0x54/0x5c
   __handle_sysrq+0x114/0x21c
   handle_sysrq+0x30/0x3c
   qcom_geni_serial_isr+0x2dc/0x30c
  ...
  ...
  irq event stamp: ...45
  hardirqs last  enabled at (...44): [...] __do_softirq+0xd8/0x4e4
  hardirqs last disabled at (...45): [...] el1_irq+0x74/0x130
  softirqs last  enabled at (...42): [...] _local_bh_enable+0x2c/0x34
  softirqs last disabled at (...43): [...] irq_exit+0xa8/0x100
  ---[ end trace adf21f830c46e638 ]---

Let's add kgdb to the list of reasons not to warn in
smp_call_function_many().  That will allow us (in a future patch) to
stop calling local_irq_enable() which will get rid of the original
splat.

NOTE: with this change comes the obvious question: will we start
deadlocking more often now when we drop into the debugger.  I can't
say that for sure one way or the other, but the fact that we do the
same logic for "oops_in_progress" makes me feel like it shouldn't
happen too often.  Also note that the old logic of turning on
interrupts temporarily wasn't exactly safe since (I presume) that
could have violated spin_lock_irqsave() semantics and ended up with a
deadlock of its own.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 kernel/smp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 163c451af42e..bb581e58c8dc 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -19,6 +19,7 @@
 #include <linux/sched.h>
 #include <linux/sched/idle.h>
 #include <linux/hypervisor.h>
+#include <linux/kgdb.h>
 
 #include "smpboot.h"
 
@@ -413,7 +414,8 @@ void smp_call_function_many(const struct cpumask *mask,
 	 * can't happen.
 	 */
 	WARN_ON_ONCE(cpu_online(this_cpu) && irqs_disabled()
-		     && !oops_in_progress && !early_boot_irqs_disabled);
+		     && !oops_in_progress && !early_boot_irqs_disabled
+		     && !in_dbg_master());
 
 	/* Try to fastpath.  So, what's a CPU they want? Ignoring this one. */
 	cpu = cpumask_first_and(mask, cpu_online_mask);
-- 
2.19.1.568.g152ad8e336-goog
