From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Date: Wed, 17 May 2017 15:47:00 +0000
Subject: [PATCH] sparc/ftrace: Fix ftrace graph time measurement
Message-Id: <1495036020-30551-1-git-send-email-Liam.Howlett@Oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The ftrace function_graph time measurements of a given function is not
accurate according to those recorded by ftrace using the function
filters.  This change pulls the x86_64 fix from 'commit 722b3c746953
("ftrace/graph: Trace function entry before updating index")' into the
sparc specific prepare_ftrace_return which stops ftrace from
counting interrupted tasks in the time measurement.

Example measurements for select_task_rq_fair running "hackbench 100
process 1000":

              |  tracing/trace_stat/function0  |  function_graph
 Before patch |  2.802 us                      |  4.255 us
 After patch  |  2.749 us                      |  3.094 us

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/sparc/kernel/ftrace.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/kernel/ftrace.c b/arch/sparc/kernel/ftrace.c
index 6bcff69..cec54dc 100644
--- a/arch/sparc/kernel/ftrace.c
+++ b/arch/sparc/kernel/ftrace.c
@@ -130,17 +130,16 @@ unsigned long prepare_ftrace_return(unsigned long parent,
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
 		return parent + 8UL;
 
-	if (ftrace_push_return_trace(parent, self_addr, &trace.depth,
-				     frame_pointer, NULL) = -EBUSY)
-		return parent + 8UL;
-
 	trace.func = self_addr;
+	trace.depth = current->curr_ret_stack + 1;
 
 	/* Only trace if the calling function expects to */
-	if (!ftrace_graph_entry(&trace)) {
-		current->curr_ret_stack--;
+	if (!ftrace_graph_entry(&trace))
+		return parent + 8UL;
+
+	if (ftrace_push_return_trace(parent, self_addr, &trace.depth,
+				     frame_pointer, NULL) = -EBUSY)
 		return parent + 8UL;
-	}
 
 	return return_hooker;
 }
-- 
2.1.4

