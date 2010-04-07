From: David Miller <davem@davemloft.net>
Date: Wed, 07 Apr 2010 10:28:32 +0000
Subject: Re: [PATCH 2/2] ftrace: Use local_irq_{save,restore}_nmi() in
Message-Id: <20100407.032832.150975074.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100406.164002.40105966.davem@davemloft.net>
In-Reply-To: <20100406.164002.40105966.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: a.p.zijlstra@chello.nl
Cc: mingo@elte.hu, acme@redhat.com, paulus@samba.org, efault@gmx.de, fweisbec@gmail.com, tglx@linutronix.de, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Tue, 06 Apr 2010 16:40:02 -0700 (PDT)

> 
> Signed-off-by: David S. Miller <davem@davemloft.net>

Peter, I found one more file that needs this annotation while
implementing function graph tracing support on sparc64.

Please add this to the original patch when you queue it up, thanks.

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index e6989d9..67fbdf1 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -220,7 +220,7 @@ int trace_graph_entry(struct ftrace_graph_ent *trace)
 	if (!(trace->depth || ftrace_graph_addr(trace->func)))
 		return 0;
 
-	local_irq_save(flags);
+	local_irq_save_nmi(flags);
 	cpu = raw_smp_processor_id();
 	data = tr->data[cpu];
 	disabled = atomic_inc_return(&data->disabled);
@@ -232,7 +232,7 @@ int trace_graph_entry(struct ftrace_graph_ent *trace)
 	}
 
 	atomic_dec(&data->disabled);
-	local_irq_restore(flags);
+	local_irq_restore_nmi(flags);
 
 	return ret;
 }
@@ -277,7 +277,7 @@ void trace_graph_return(struct ftrace_graph_ret *trace)
 	int cpu;
 	int pc;
 
-	local_irq_save(flags);
+	local_irq_save_nmi(flags);
 	cpu = raw_smp_processor_id();
 	data = tr->data[cpu];
 	disabled = atomic_inc_return(&data->disabled);
@@ -286,7 +286,7 @@ void trace_graph_return(struct ftrace_graph_ret *trace)
 		__trace_graph_return(tr, trace, flags, pc);
 	}
 	atomic_dec(&data->disabled);
-	local_irq_restore(flags);
+	local_irq_restore_nmi(flags);
 }
 
 void set_graph_array(struct trace_array *tr)
