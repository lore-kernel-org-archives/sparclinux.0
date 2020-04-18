From: Dmitry Safonov <dima@arista.com>
Date: Sat, 18 Apr 2020 20:19:28 +0000
Subject: [PATCHv3 34/50] sparc: Add show_stack_loglvl()
Message-Id: <20200418201944.482088-35-dima@arista.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200418201944.482088-1-dima@arista.com>
In-Reply-To: <20200418201944.482088-1-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Dmitry Safonov <0x7f454c46@gmail.com>, Dmitry Safonov <dima@arista.com>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Currently, the log-level of show_stack() depends on a platform
realization. It creates situations where the headers are printed with
lower log level or higher than the stacktrace (depending on
a platform or user).

Furthermore, it forces the logic decision from user to an architecture
side. In result, some users as sysrq/kdb/etc are doing tricks with
temporary rising console_loglevel while printing their messages.
And in result it not only may print unwanted messages from other CPUs,
but also omit printing at all in the unlucky case where the printk()
was deferred.

Introducing log-level parameter and KERN_UNSUPPRESSED [1] seems
an easier approach than introducing more printk buffers.
Also, it will consolidate printings with headers.

Introduce show_stack_loglvl(), that eventually will substitute
show_stack().

Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Acked-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/sparc/kernel/process_32.c | 17 ++++++++++++-----
 arch/sparc/kernel/traps_64.c   | 15 +++++++++++----
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index 26cca65e9246..0b07de5618e5 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -145,10 +145,12 @@ void show_regs(struct pt_regs *r)
 }
 
 /*
- * The show_stack is an external API which we do not use ourselves.
+ * The show_stack(), show_stack_loglvl() are external APIs which
+ * we do not use ourselves.
  * The oops is printed in die_if_kernel.
  */
-void show_stack(struct task_struct *tsk, unsigned long *_ksp)
+void show_stack_loglvl(struct task_struct *tsk, unsigned long *_ksp,
+		       const char *loglvl)
 {
 	unsigned long pc, fp;
 	unsigned long task_base;
@@ -170,11 +172,16 @@ void show_stack(struct task_struct *tsk, unsigned long *_ksp)
 			break;
 		rw = (struct reg_window32 *) fp;
 		pc = rw->ins[7];
-		printk("[%08lx : ", pc);
-		printk("%pS ] ", (void *) pc);
+		printk("%s[%08lx : ", loglvl, pc);
+		printk("%s%pS ] ", loglvl, (void *) pc);
 		fp = rw->ins[6];
 	} while (++count < 16);
-	printk("\n");
+	printk("%s\n", loglvl);
+}
+
+void show_stack(struct task_struct *task, unsigned long *sp)
+{
+	show_stack_loglvl(task, sp, KERN_DEFAULT);
 }
 
 /*
diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index 27778b65a965..8715bc93bd9d 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -18,6 +18,7 @@
 #include <linux/smp.h>
 #include <linux/mm.h>
 #include <linux/init.h>
+#include <linux/kallsyms.h>
 #include <linux/kdebug.h>
 #include <linux/ftrace.h>
 #include <linux/reboot.h>
@@ -2452,7 +2453,8 @@ static void user_instruction_dump(unsigned int __user *pc)
 	printk("\n");
 }
 
-void show_stack(struct task_struct *tsk, unsigned long *_ksp)
+void show_stack_loglvl(struct task_struct *tsk, unsigned long *_ksp,
+			 const char *loglvl)
 {
 	unsigned long fp, ksp;
 	struct thread_info *tp;
@@ -2476,7 +2478,7 @@ void show_stack(struct task_struct *tsk, unsigned long *_ksp)
 
 	fp = ksp + STACK_BIAS;
 
-	printk("Call Trace:\n");
+	printk("%sCall Trace:\n", loglvl);
 	do {
 		struct sparc_stackf *sf;
 		struct pt_regs *regs;
@@ -2497,14 +2499,14 @@ void show_stack(struct task_struct *tsk, unsigned long *_ksp)
 			fp = (unsigned long)sf->fp + STACK_BIAS;
 		}
 
-		printk(" [%016lx] %pS\n", pc, (void *) pc);
+		print_ip_sym(loglvl, pc);
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 		if ((pc + 8UL) = (unsigned long) &return_to_handler) {
 			struct ftrace_ret_stack *ret_stack;
 			ret_stack = ftrace_graph_get_ret_stack(tsk, graph);
 			if (ret_stack) {
 				pc = ret_stack->ret;
-				printk(" [%016lx] %pS\n", pc, (void *) pc);
+				print_ip_sym(loglvl, pc);
 				graph++;
 			}
 		}
@@ -2512,6 +2514,11 @@ void show_stack(struct task_struct *tsk, unsigned long *_ksp)
 	} while (++count < 16);
 }
 
+void show_stack(struct task_struct *tsk, unsigned long *_ksp)
+{
+	show_stack_loglvl(task, sp, KERN_DEFAULT);
+}
+
 static inline struct reg_window *kernel_stack_up(struct reg_window *rw)
 {
 	unsigned long fp = rw->ins[6];
-- 
2.26.0
