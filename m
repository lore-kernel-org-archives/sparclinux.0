From: Mikulas Patocka <mpatocka@redhat.com>
Date: Wed, 13 Aug 2008 01:21:31 +0000
Subject: [PATCH] fix crash with CONFIG_LOCKDEP and CONFIG_DEBUG_PAGEALLOC
Message-Id: <Pine.LNX.4.64.0808122112380.31704@hs20-bc2-1.build.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi

This patch fixes crash on boot when both CONFIG_LOCKDEP and 
CONFIG_DEBUG_PAGEALLOC are enabled.

The problem:
config_lockdep calls save_stack_trace extensively to collect stack traces 
at points where locks are taken. save_stack_trace stops reading when the 
frame pointer points out of current page --- unfortunatelly there is a 
small window when frame pointer can point just before the end of the page 
and save_stack_trace will read some data from the next page --- crashing 
if CONFIG_DEBUG_PAGEALLOC is enabled.

The patch fixes it to make sure that save_stack_trace won't read 
out-of-page data.

Furthermore, if the frame pointer of the last function is uninitialized, 
it can (theoretically) produce loop (pointing at some already processed 
entry) or unaligned access --- this patch adds a check that the frame 
address is increasing and aligned.

Mikulas

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 arch/sparc64/kernel/stacktrace.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

Index: linux-2.6.26-devel/arch/sparc64/kernel/stacktrace.c
=================================--- linux-2.6.26-devel.orig/arch/sparc64/kernel/stacktrace.c	2008-08-12 17:32:01.000000000 +0200
+++ linux-2.6.26-devel/arch/sparc64/kernel/stacktrace.c	2008-08-12 23:20:01.000000000 +0200
@@ -6,7 +6,7 @@
 
 void save_stack_trace(struct stack_trace *trace)
 {
-	unsigned long ksp, fp, thread_base;
+	unsigned long ksp, fp, new_fp, thread_base;
 	struct thread_info *tp = task_thread_info(current);
 
 	stack_trace_flush();
@@ -24,26 +24,31 @@ void save_stack_trace(struct stack_trace
 		unsigned long pc;
 
 		/* Bogus frame pointer? */
-		if (fp < (thread_base + sizeof(struct thread_info)) ||
-		    fp >= (thread_base + THREAD_SIZE))
+		if (fp & 15 ||
+		    fp < (thread_base + sizeof(struct thread_info)) ||
+		    fp > (thread_base + THREAD_SIZE - sizeof(struct sparc_stackf)))
 			break;
 
 		sf = (struct sparc_stackf *) fp;
 		regs = (struct pt_regs *) (sf + 1);
 
-		if ((regs->magic & ~0x1ff) = PT_REGS_MAGIC) {
+		if ((unsigned long)regs <= (thread_base + THREAD_SIZE - sizeof(struct pt_regs)) && (regs->magic & ~0x1ff) = PT_REGS_MAGIC) {
 			if (!(regs->tstate & TSTATE_PRIV))
 				break;
 			pc = regs->tpc;
-			fp = regs->u_regs[UREG_I6] + STACK_BIAS;
+			new_fp = regs->u_regs[UREG_I6] + STACK_BIAS;
 		} else {
 			pc = sf->callers_pc;
-			fp = (unsigned long)sf->fp + STACK_BIAS;
+			new_fp = (unsigned long)sf->fp + STACK_BIAS;
 		}
 
 		if (trace->skip > 0)
 			trace->skip--;
 		else
 			trace->entries[trace->nr_entries++] = pc;
+
+		if (new_fp <= fp)
+			break;
+		fp = new_fp;
 	} while (trace->nr_entries < trace->max_entries);
 }
