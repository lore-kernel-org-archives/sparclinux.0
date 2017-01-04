From: Tom Hromatka <tom.hromatka@oracle.com>
Date: Wed, 04 Jan 2017 22:28:04 +0000
Subject: [PATCH] sysrq: Reset the watchdog timers while displaying high-resolution timers
Message-Id: <1483568884-29109-1-git-send-email-tom.hromatka@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, john.stultz@linaro.org, sparclinux@vger.kernel.org, davem@davemloft.net

On systems with a large number of CPUs, running sysrq-<q> can cause
watchdog timeouts.  There are two slow sections of code in the sysrq-<q>
path in timer_list.c.

1. print_active_timers() - This function is called by print_cpu() and
   contains a slow goto loop.  On a machine with hundreds of CPUs, this
   loop took approximately 100ms for the first CPU in a NUMA node.
   (Subsequent CPUs in the same node ran much quicker.)  The total time
   to print all of the CPUs is ultimately long enough to trigger the
   soft lockup watchdog.

2. print_tickdevice() - This function outputs a large amount of textual
   information.  This function also took approximately 100ms per CPU.

Since sysrq-<q> is not a performance critical path, there should be no
harm in touching the nmi watchdog in both slow sections above.  Touching
it in just one location was insufficient on systems with hundreds of
CPUs as occasional timeouts were still observed during testing.

This issue was observed on an Oracle T7 machine with 128 CPUs, but I
anticipate it may affect other systems with similarly large numbers of
CPUs.

Signed-off-by: Tom Hromatka <tom.hromatka@oracle.com>
Reviewed-by: Rob Gardner <rob.gardner@oracle.com>
---
 kernel/time/timer_list.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
index afe6cd1..f8dd5e2 100644
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -16,6 +16,7 @@
 #include <linux/sched.h>
 #include <linux/seq_file.h>
 #include <linux/kallsyms.h>
+#include <linux/nmi.h>
 
 #include <linux/uaccess.h>
 
@@ -96,6 +97,9 @@ print_active_timers(struct seq_file *m, struct hrtimer_clock_base *base,
 
 next_one:
 	i = 0;
+
+	touch_nmi_watchdog();
+
 	raw_spin_lock_irqsave(&base->cpu_base->lock, flags);
 
 	curr = timerqueue_getnext(&base->active);
@@ -207,6 +211,8 @@ print_tickdevice(struct seq_file *m, struct tick_device *td, int cpu)
 {
 	struct clock_event_device *dev = td->evtdev;
 
+	touch_nmi_watchdog();
+
 	SEQ_printf(m, "Tick Device: mode:     %d\n", td->mode);
 	if (cpu < 0)
 		SEQ_printf(m, "Broadcast device\n");
-- 
2.7.4

