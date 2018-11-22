From: Steven Rostedt <rostedt@goodmis.org>
Date: Thu, 22 Nov 2018 00:28:14 +0000
Subject: [for-next][PATCH 13/18] sparc/function_graph: Simplify with function_graph_entry()
Message-Id: <20181122003333.299708099@goodmis.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20181122002801.501220343@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, Masami Hiramatsu <mhiramat@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Andy Lutomirski <luto@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, stable@kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The function_graph_entry() function does the work of calling the function
graph hook function and the management of the shadow stack, simplifying the
work done in the architecture dependent prepare_ftrace_return().

Have sparc use the new code, and remove the shadow stack management as well as
having to set up the trace structure.

This is needed to prepare for a fix of a design bug on how the curr_ret_stack
is used.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Cc: stable@kernel.org
Fixes: 03274a3ffb449 ("tracing/fgraph: Adjust fgraph depth before calling trace return callback")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/sparc/kernel/ftrace.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/sparc/kernel/ftrace.c b/arch/sparc/kernel/ftrace.c
index 915dda4ae412..684b84ce397f 100644
--- a/arch/sparc/kernel/ftrace.c
+++ b/arch/sparc/kernel/ftrace.c
@@ -126,20 +126,11 @@ unsigned long prepare_ftrace_return(unsigned long parent,
 				    unsigned long frame_pointer)
 {
 	unsigned long return_hooker = (unsigned long) &return_to_handler;
-	struct ftrace_graph_ent trace;
 
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
 		return parent + 8UL;
 
-	trace.func = self_addr;
-	trace.depth = current->curr_ret_stack + 1;
-
-	/* Only trace if the calling function expects to */
-	if (!ftrace_graph_entry(&trace))
-		return parent + 8UL;
-
-	if (ftrace_push_return_trace(parent, self_addr, &trace.depth,
-				     frame_pointer, NULL) = -EBUSY)
+	if (function_graph_enter(parent, self_addr, frame_pointer, NULL))
 		return parent + 8UL;
 
 	return return_hooker;
-- 
2.19.1
