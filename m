From: David Miller <davem@davemloft.net>
Date: Wed, 21 Apr 2010 10:23:55 +0000
Subject: [PATCH 2/2] sparc64: Fix stack dumping and tracing when function
Message-Id: <20100421.032355.147982685.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Like x86, when the function graph tracer is enabled, emit the ftrace
stub as well as the program counter it will be transformed back into.

We duplicate a lot of similar stack walking logic in 3 or 4 spots, so
eventually we should consolidate things like x86 does.

Thanks to Frederic Weisbecker for pointing this out.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/perf_event.c |   14 ++++++++++++++
 arch/sparc/kernel/stacktrace.c |   23 ++++++++++++++++++++++-
 arch/sparc/kernel/traps_64.c   |   14 ++++++++++++++
 3 files changed, 50 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index e277193..34ce49f 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -14,6 +14,7 @@
 
 #include <linux/perf_event.h>
 #include <linux/kprobes.h>
+#include <linux/ftrace.h>
 #include <linux/kernel.h>
 #include <linux/kdebug.h>
 #include <linux/mutex.h>
@@ -1276,6 +1277,9 @@ static void perf_callchain_kernel(struct pt_regs *regs,
 				  struct perf_callchain_entry *entry)
 {
 	unsigned long ksp, fp;
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	int graph = 0;
+#endif
 
 	callchain_store(entry, PERF_CONTEXT_KERNEL);
 	callchain_store(entry, regs->tpc);
@@ -1303,6 +1307,16 @@ static void perf_callchain_kernel(struct pt_regs *regs,
 			fp = (unsigned long)sf->fp + STACK_BIAS;
 		}
 		callchain_store(entry, pc);
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+		if ((pc + 8UL) = (unsigned long) &return_to_handler) {
+			int index = current->curr_ret_stack;
+			if (current->ret_stack && index >= graph) {
+				pc = current->ret_stack[index - graph].ret;
+				callchain_store(entry, pc);
+				graph++;
+			}
+		}
+#endif
 	} while (entry->nr < PERF_MAX_STACK_DEPTH);
 }
 
diff --git a/arch/sparc/kernel/stacktrace.c b/arch/sparc/kernel/stacktrace.c
index acb12f6..3e08153 100644
--- a/arch/sparc/kernel/stacktrace.c
+++ b/arch/sparc/kernel/stacktrace.c
@@ -1,6 +1,7 @@
 #include <linux/sched.h>
 #include <linux/stacktrace.h>
 #include <linux/thread_info.h>
+#include <linux/ftrace.h>
 #include <linux/module.h>
 #include <asm/ptrace.h>
 #include <asm/stacktrace.h>
@@ -12,6 +13,10 @@ static void __save_stack_trace(struct thread_info *tp,
 			       bool skip_sched)
 {
 	unsigned long ksp, fp;
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	struct task_struct *t;
+	int graph = 0;
+#endif
 
 	if (tp = current_thread_info()) {
 		stack_trace_flush();
@@ -21,6 +26,9 @@ static void __save_stack_trace(struct thread_info *tp,
 	}
 
 	fp = ksp + STACK_BIAS;
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	t = tp->task;
+#endif
 	do {
 		struct sparc_stackf *sf;
 		struct pt_regs *regs;
@@ -44,8 +52,21 @@ static void __save_stack_trace(struct thread_info *tp,
 
 		if (trace->skip > 0)
 			trace->skip--;
-		else if (!skip_sched || !in_sched_functions(pc))
+		else if (!skip_sched || !in_sched_functions(pc)) {
 			trace->entries[trace->nr_entries++] = pc;
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+			if ((pc + 8UL) = (unsigned long) &return_to_handler) {
+				int index = t->curr_ret_stack;
+				if (t->ret_stack && index >= graph) {
+					pc = t->ret_stack[index - graph].ret;
+					if (trace->nr_entries <
+					    trace->max_entries)
+						trace->entries[trace->nr_entries++] = pc;
+					graph++;
+				}
+			}
+#endif
+		}
 	} while (trace->nr_entries < trace->max_entries);
 }
 
diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index 9da57f0..42ad2ba 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -17,6 +17,7 @@
 #include <linux/mm.h>
 #include <linux/init.h>
 #include <linux/kdebug.h>
+#include <linux/ftrace.h>
 #include <linux/gfp.h>
 
 #include <asm/smp.h>
@@ -2154,6 +2155,9 @@ void show_stack(struct task_struct *tsk, unsigned long *_ksp)
 	unsigned long fp, thread_base, ksp;
 	struct thread_info *tp;
 	int count = 0;
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	int graph = 0;
+#endif
 
 	ksp = (unsigned long) _ksp;
 	if (!tsk)
@@ -2193,6 +2197,16 @@ void show_stack(struct task_struct *tsk, unsigned long *_ksp)
 		}
 
 		printk(" [%016lx] %pS\n", pc, (void *) pc);
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+		if ((pc + 8UL) = (unsigned long) &return_to_handler) {
+			int index = tsk->curr_ret_stack;
+			if (tsk->ret_stack && index >= graph) {
+				pc = tsk->ret_stack[index - graph].ret;
+				printk(" [%016lx] %pS\n", pc, (void *) pc);
+				graph++;
+			}
+		}
+#endif
 	} while (++count < 16);
 }
 
-- 
1.7.0.4

