From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Sun, 18 Apr 2010 15:31:24 +0000
Subject: Re: [PATCH 7/7] sparc64: Add function graph tracer support.
Message-Id: <20100418153121.GA5174@nowhere>
List-Id: <sparclinux.vger.kernel.org>
References: <20100412.234300.212396783.davem@davemloft.net>
In-Reply-To: <20100412.234300.212396783.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Apr 17, 2010 at 02:38:37PM -0700, David Miller wrote:
> From: Frederic Weisbecker <fweisbec@gmail.com>
> Date: Sat, 17 Apr 2010 23:34:15 +0200
> 
> > I haven't started the watchdog nor perf, I guess NMI don't trigger
> > in other cases, right?
> 
> They do, for the NMI watchdog, every few seconds.
> 
> > For now, the only reentrancy I could find was irqs that interrupt
> > the tracing path. Which means no good clue there. That said I
> > have only logged recursivity on trace entry path, not yet
> > on return.
> > 
> > I'm disabling the protections on entry, just to narrow down
> > the recursivity place, in case it only happens on return.
> 
> No need to do so much work, when you hit this case simply
> disable tracing and dump_stack().  That way you'll see it
> clearly.


In fact it's quite hard to dump, because most of them I get
are irrelevant (irqs that do reentering the tracing path).
And after some time, dumps end up crashing.

All I could do is narrowing down the source, everything
happens well with this patch:


diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 9aed1a5..cfcb863 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -287,7 +287,9 @@ void trace_graph_return(struct ftrace_graph_ret *trace)
 		__trace_graph_return(tr, trace, flags, pc);
 	}
 	atomic_dec(&data->disabled);
+	pause_graph_tracing();
 	local_irq_restore(flags);
+	unpause_graph_tracing();
 }
 
 void set_graph_array(struct trace_array *tr)


That reminds me badly the problems with NMIs, and I saw
an NMI path in one of the dumps, so I guess you were
right after all as it looks like more an NMIs related problem
rather than a recursion.

I thought if I won't enable the watchdog I wouldn't have NMIs
but I have some in /proc/interrupts

