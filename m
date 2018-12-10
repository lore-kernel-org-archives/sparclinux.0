From: Steven Rostedt <rostedt@goodmis.org>
Date: Mon, 10 Dec 2018 19:30:11 +0000
Subject: [PATCH 4/6] sparc64: Use ftrace_graph_get_ret_stack() instead of curr_ret_stack
Message-Id: <20181210193335.140567461@goodmis.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20181210193007.655970639@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

[
  Folks, I'm working on rewriting the function graph tracer. In order to
  do so, some changes need to be done that affect architecture specific
  code. I'm only able to compile test these changes. I would like to
  have folks check out my repo and give them a test.

    git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
  ftrace/core

  Head SHA1: 51584396cff54aaf57ed0bd353767d71429f77b4
]

The structure of the ret_stack array on the task struct is going to
change, and accessing it directly via the curr_ret_stack index will no
longer give the ret_stack entry that holds the return address. To access
that, architectures must now use ftrace_graph_get_ret_stack() to get the
associated ret_stack that matches the saved return address.

Cc: sparclinux@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/sparc/kernel/perf_event.c | 8 +++++---
 arch/sparc/kernel/stacktrace.c | 8 +++++---
 arch/sparc/kernel/traps_64.c   | 7 ++++---
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index 47c871394ccb..6de7c684c29f 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -1767,9 +1767,11 @@ void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
 		perf_callchain_store(entry, pc);
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 		if ((pc + 8UL) = (unsigned long) &return_to_handler) {
-			int index = current->curr_ret_stack;
-			if (current->ret_stack && index >= graph) {
-				pc = current->ret_stack[index - graph].ret;
+			struct ftrace_ret_stack *ret_stack;
+			ret_stack = ftrace_graph_get_ret_stack(current,
+							       graph);
+			if (ret_stack) {
+				pc = ret_stack->ret;
 				perf_callchain_store(entry, pc);
 				graph++;
 			}
diff --git a/arch/sparc/kernel/stacktrace.c b/arch/sparc/kernel/stacktrace.c
index be4c14cccc05..dd654e651500 100644
--- a/arch/sparc/kernel/stacktrace.c
+++ b/arch/sparc/kernel/stacktrace.c
@@ -57,9 +57,11 @@ static void __save_stack_trace(struct thread_info *tp,
 			trace->entries[trace->nr_entries++] = pc;
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 			if ((pc + 8UL) = (unsigned long) &return_to_handler) {
-				int index = t->curr_ret_stack;
-				if (t->ret_stack && index >= graph) {
-					pc = t->ret_stack[index - graph].ret;
+				struct ftrace_ret_stack *ret_stack;
+				ret_stack = ftrace_graph_get_ret_stack(t,
+								       graph);
+				if (ret_stack) {
+					pc = ret_stack->ret;
 					if (trace->nr_entries <
 					    trace->max_entries)
 						trace->entries[trace->nr_entries++] = pc;
diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index aa624ed79db1..0cd02a64a451 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -2502,9 +2502,10 @@ void show_stack(struct task_struct *tsk, unsigned long *_ksp)
 		printk(" [%016lx] %pS\n", pc, (void *) pc);
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 		if ((pc + 8UL) = (unsigned long) &return_to_handler) {
-			int index = tsk->curr_ret_stack;
-			if (tsk->ret_stack && index >= graph) {
-				pc = tsk->ret_stack[index - graph].ret;
+			struct ftrace_ret_stack *ret_stack;
+			ret_stack = ftrace_graph_get_ret_stack(tsk, graph);
+			if (ret_stack) {
+				pc = ret_stack->ret;
 				printk(" [%016lx] %pS\n", pc, (void *) pc);
 				graph++;
 			}
-- 
2.19.1
