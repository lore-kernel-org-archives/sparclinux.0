From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Sat, 17 Apr 2010 17:22:21 +0000
Subject: Re: [PATCH 7/7] sparc64: Add function graph tracer support.
Message-Id: <20100417172220.GB15037@nowhere>
List-Id: <sparclinux.vger.kernel.org>
References: <20100412.234300.212396783.davem@davemloft.net>
In-Reply-To: <20100412.234300.212396783.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Apr 17, 2010 at 06:59:25PM +0200, Frederic Weisbecker wrote:
> On Sat, Apr 17, 2010 at 12:51:09AM -0700, David Miller wrote:
> > From: David Miller <davem@davemloft.net>
> > Date: Fri, 16 Apr 2010 16:17:44 -0700 (PDT)
> > 
> > > From: Frederic Weisbecker <fweisbec@gmail.com>
> > > Date: Sat, 17 Apr 2010 01:14:12 +0200
> > > 
> > >> Hmm, just a random idea: do you think it could be due to stack overflows?
> > >> Because the function graph eats more stack by digging to function graph
> > >> handlers, ring buffer, etc...
> > >> 
> > >> It diggs further than what is supposed to happen without tracing.
> > > 
> > > I have mcount checking for stack-overflow by hand in assembler
> > > during these tests, it even knows about the irq stacks.
> > > 
> > > And those checks are not triggering.
> > 
> > Ugh...  hold on.
> > 
> > They're not triggering because I put the test assembler into mcount
> > and dynamic ftrace patches the call sites to bypass mcount altogether
> > :-)
> > 
> > Doing real tests now, and I bet you're right.
> > 
> > That's pretty insane though, as we use 16K stacks on sparc64 and
> > the gcc I'm using has the minimum stack frame decreased down to
> > 176 bytes (used to be 192).  I'd be interested to see what one
> > of these too-large backtraces look like.
> > 
> > Hmmm, will it be in the scheduler load balancing code? :-)
> 
> 
> May be yeah :)
> 
> This could be also a tracing recursion somewhere.
> One good way to know is to put pause_graph_tracing()
> and unpause_graph_tracing() in the very beginning and
> end of the tracing paths.
> 
> /me goes to try this.
> 


This looks like the true cause.

I tested the following patch and it fixes the issue after several
manual loops of:

	echo function_graph > current_tracer
	echo nop > current_tracer


Before it was triggering after two trials. Now it doesn't happen
after 10 iterations.

I'm going to hunt the culprit that causes this, we certainly need
a new __notrace somewhere.


diff --git a/arch/sparc/kernel/ftrace.c b/arch/sparc/kernel/ftrace.c
index 03ab022..3dc19b6 100644
--- a/arch/sparc/kernel/ftrace.c
+++ b/arch/sparc/kernel/ftrace.c
@@ -134,18 +134,24 @@ unsigned long prepare_ftrace_return(unsigned long parent,
        if (unlikely(atomic_read(&current->tracing_graph_pause)))
                return parent + 8UL;
 
+       pause_graph_tracing();
+
        if (ftrace_push_return_trace(parent, self_addr, &trace.depth,
-                                    frame_pointer) = -EBUSY)
+                                    frame_pointer) = -EBUSY) {
+               unpause_graph_tracing();
                return parent + 8UL;
+       }
 
        trace.func = self_addr;
 
        /* Only trace if the calling function expects to */
        if (!ftrace_graph_entry(&trace)) {
                current->curr_ret_stack--;
+               unpause_graph_tracing();
                return parent + 8UL;
        }
 
+       unpause_graph_tracing();
        return return_hooker;
 }
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 9aed1a5..251a46a 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -163,6 +163,8 @@ unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
        struct ftrace_graph_ret trace;
        unsigned long ret;
 
+       pause_graph_tracing();
+
        ftrace_pop_return_trace(&trace, &ret, frame_pointer);
        trace.rettime = trace_clock_local();
        ftrace_graph_return(&trace);
@@ -176,6 +178,8 @@ unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
                ret = (unsigned long)panic;
        }
 
+       unpause_graph_tracing();
+
        return ret;
 }


