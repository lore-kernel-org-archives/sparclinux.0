From: David Miller <davem@davemloft.net>
Date: Tue, 19 Jan 2010 08:26:45 +0000
Subject: [PATCH]: sparc64: Add perf callchain support.
Message-Id: <20100119.002645.70252139.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Pretty straightforward, and it should be easy to add accurate
walk through of signal stack frames in userspace.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/perf_event.c |  120 +++++++++++++++++++++++++++++++++++++++-
 1 files changed, 119 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index 198fb4e..2386ac6 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -1,6 +1,6 @@
 /* Performance event support for sparc64.
  *
- * Copyright (C) 2009 David S. Miller <davem@davemloft.net>
+ * Copyright (C) 2009, 2010 David S. Miller <davem@davemloft.net>
  *
  * This code is based almost entirely upon the x86 perf event
  * code, which is:
@@ -18,11 +18,15 @@
 #include <linux/kdebug.h>
 #include <linux/mutex.h>
 
+#include <asm/stacktrace.h>
 #include <asm/cpudata.h>
+#include <asm/uaccess.h>
 #include <asm/atomic.h>
 #include <asm/nmi.h>
 #include <asm/pcr.h>
 
+#include "kstack.h"
+
 /* Sparc64 chips have two performance counters, 32-bits each, with
  * overflow interrupts generated on transition from 0xffffffff to 0.
  * The counters are accessed in one go using a 64-bit register.
@@ -1062,3 +1066,117 @@ void __init init_hw_perf_events(void)
 
 	register_die_notifier(&perf_event_nmi_notifier);
 }
+
+static inline void callchain_store(struct perf_callchain_entry *entry, u64 ip)
+{
+	if (entry->nr < PERF_MAX_STACK_DEPTH)
+		entry->ip[entry->nr++] = ip;
+}
+
+static void perf_callchain_kernel(struct pt_regs *regs,
+				  struct perf_callchain_entry *entry)
+{
+	unsigned long ksp, fp;
+
+	callchain_store(entry, PERF_CONTEXT_KERNEL);
+	callchain_store(entry, regs->tpc);
+
+	ksp = regs->u_regs[UREG_I6];
+	fp = ksp + STACK_BIAS;
+	do {
+		struct sparc_stackf *sf;
+		struct pt_regs *regs;
+		unsigned long pc;
+
+		if (!kstack_valid(current_thread_info(), fp))
+			break;
+
+		sf = (struct sparc_stackf *) fp;
+		regs = (struct pt_regs *) (sf + 1);
+
+		if (kstack_is_trap_frame(current_thread_info(), regs)) {
+			if (user_mode(regs))
+				break;
+			pc = regs->tpc;
+			fp = regs->u_regs[UREG_I6] + STACK_BIAS;
+		} else {
+			pc = sf->callers_pc;
+			fp = (unsigned long)sf->fp + STACK_BIAS;
+		}
+		callchain_store(entry, pc);
+	} while (entry->nr < PERF_MAX_STACK_DEPTH);
+}
+
+static void perf_callchain_user_64(struct pt_regs *regs,
+				   struct perf_callchain_entry *entry)
+{
+	unsigned long ufp;
+
+	callchain_store(entry, PERF_CONTEXT_USER);
+	callchain_store(entry, regs->tpc);
+
+	ufp = regs->u_regs[UREG_I6] + STACK_BIAS;
+	do {
+		struct sparc_stackf *usf, sf;
+		unsigned long pc;
+
+		usf = (struct sparc_stackf *) ufp;
+		if (__copy_from_user_inatomic(&sf, usf, sizeof(sf)))
+			break;
+
+		pc = sf.callers_pc;
+		ufp = (unsigned long)sf.fp + STACK_BIAS;
+		callchain_store(entry, pc);
+	} while (entry->nr < PERF_MAX_STACK_DEPTH);
+}
+
+static void perf_callchain_user_32(struct pt_regs *regs,
+				   struct perf_callchain_entry *entry)
+{
+	unsigned long ufp;
+
+	callchain_store(entry, PERF_CONTEXT_USER);
+	callchain_store(entry, regs->tpc);
+
+	ufp = regs->u_regs[UREG_I6];
+	do {
+		struct sparc_stackf32 *usf, sf;
+		unsigned long pc;
+
+		usf = (struct sparc_stackf32 *) ufp;
+		if (__copy_from_user_inatomic(&sf, usf, sizeof(sf)))
+			break;
+
+		pc = sf.callers_pc;
+		ufp = (unsigned long)sf.fp;
+		callchain_store(entry, pc);
+	} while (entry->nr < PERF_MAX_STACK_DEPTH);
+}
+
+/* Like powerpc we can't get PMU interrupts within the PMU handler,
+ * so no need for seperate NMI and IRQ chains as on x86.
+ */
+static DEFINE_PER_CPU(struct perf_callchain_entry, callchain);
+
+struct perf_callchain_entry *perf_callchain(struct pt_regs *regs)
+{
+	struct perf_callchain_entry *entry = &__get_cpu_var(callchain);
+
+	entry->nr = 0;
+	if (!user_mode(regs)) {
+		stack_trace_flush();
+		perf_callchain_kernel(regs, entry);
+		if (current->mm)
+			regs = task_pt_regs(current);
+		else
+			regs = NULL;
+	}
+	if (regs) {
+		flushw_user();
+		if (test_thread_flag(TIF_32BIT))
+			perf_callchain_user_32(regs, entry);
+		else
+			perf_callchain_user_64(regs, entry);
+	}
+	return entry;
+}
-- 
1.6.5

