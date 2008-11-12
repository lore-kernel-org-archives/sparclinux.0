From: Alexander Beregalov <a.beregalov@gmail.com>
Date: Wed, 12 Nov 2008 13:47:49 +0000
Subject: [PATCH] sparc64: add function save_stack_trace_tsk()
Message-Id: <20081112134749.GD12456@orion>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, sparclinux@vger.kernel.org, linux-next@vger.kernel.org, kenchen@google.com, mingo@elte.hu, adobriyan@gmail.com

Hi

Current -next does not build on sparc64:
  LD      .tmp_vmlinux1
  fs/built-in.o: In function `proc_pid_stack':
  /home/alexb/linux-2.6/fs/proc/base.c:360: undefined reference to
  `save_stack_trace_tsk'

---

  Add function save_stack_trace_tsk() on sparc64.


Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
---

 arch/sparc64/kernel/stacktrace.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/sparc64/kernel/stacktrace.c b/arch/sparc64/kernel/stacktrace.c
index 4e21d4a..a22eb8e 100644
--- a/arch/sparc64/kernel/stacktrace.c
+++ b/arch/sparc64/kernel/stacktrace.c
@@ -7,9 +7,9 @@
 
 #include "kstack.h"
 
-void save_stack_trace(struct stack_trace *trace)
+void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 {
-	struct thread_info *tp = task_thread_info(current);
+	struct thread_info *tp = task_thread_info(tsk);
 	unsigned long ksp, fp;
 
 	stack_trace_flush();
@@ -47,4 +47,10 @@ void save_stack_trace(struct stack_trace *trace)
 			trace->entries[trace->nr_entries++] = pc;
 	} while (trace->nr_entries < trace->max_entries);
 }
+EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
+
+inline void save_stack_trace(struct stack_trace *trace)
+{
+	save_stack_trace_tsk(current, trace);
+}
 EXPORT_SYMBOL_GPL(save_stack_trace);
