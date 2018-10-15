From: David Miller <davem@davemloft.net>
Date: Mon, 15 Oct 2018 03:25:46 +0000
Subject: [PATCH] sparc: Throttle perf events properly.
Message-Id: <20181014.202546.1813435703142958232.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Like x86 and arm, call perf_sample_event_took() in perf event
NMI interrupt handler.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/perf_event.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index a4cc26bd89a2..67b3e6b3ce5d 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -24,6 +24,7 @@
 #include <asm/cpudata.h>
 #include <linux/uaccess.h>
 #include <linux/atomic.h>
+#include <linux/sched/clock.h>
 #include <asm/nmi.h>
 #include <asm/pcr.h>
 #include <asm/cacheflush.h>
@@ -1612,6 +1613,8 @@ static int __kprobes perf_event_nmi_handler(struct notifier_block *self,
 	struct perf_sample_data data;
 	struct cpu_hw_events *cpuc;
 	struct pt_regs *regs;
+	u64 finish_clock;
+	u64 start_clock;
 	int i;
 
 	if (!atomic_read(&active_events))
@@ -1625,6 +1628,8 @@ static int __kprobes perf_event_nmi_handler(struct notifier_block *self,
 		return NOTIFY_DONE;
 	}
 
+	start_clock = sched_clock();
+
 	regs = args->regs;
 
 	cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -1663,6 +1668,10 @@ static int __kprobes perf_event_nmi_handler(struct notifier_block *self,
 			sparc_pmu_stop(event, 0);
 	}
 
+	finish_clock = sched_clock();
+
+	perf_sample_event_took(finish_clock - start_clock);
+
 	return NOTIFY_STOP;
 }
 
-- 
2.19.1
