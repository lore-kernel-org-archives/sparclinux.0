From: David Miller <davem@davemloft.net>
Date: Mon, 19 Apr 2010 07:56:13 +0000
Subject: Re: [PATCH 7/7] sparc64: Add function graph tracer support.
Message-Id: <20100419.005613.246523231.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100412.234300.212396783.davem@davemloft.net>
In-Reply-To: <20100412.234300.212396783.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Sun, 18 Apr 2010 17:31:24 +0200

> All I could do is narrowing down the source, everything
> happens well with this patch:
> 
> 
> diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
> index 9aed1a5..cfcb863 100644
> --- a/kernel/trace/trace_functions_graph.c
> +++ b/kernel/trace/trace_functions_graph.c
> @@ -287,7 +287,9 @@ void trace_graph_return(struct ftrace_graph_ret *trace)
>  		__trace_graph_return(tr, trace, flags, pc);
>  	}
>  	atomic_dec(&data->disabled);
> +	pause_graph_tracing();
>  	local_irq_restore(flags);
> +	unpause_graph_tracing();
>  }
>  
>  void set_graph_array(struct trace_array *tr)

So I was tooling around, doing some disassembly and seeing what these
local_irq_*() paths look like...

From one perspective, I can't see how we can justify not using the
raw_*() variants in these critical tracer paths.  With lockdep or the
irqsoff tracer enabled, we can call various code paths that will
recurse into the tracer, especially if the debugging checks trigger.

And at this point we've decremented the ->disabled counter, so we will
absolutely not be able to detect tracer recursion triggered by this
local_irq_restore().

In fact, if we enter an error state wrt. trace_hardirqs_{on,off}() we
will likely just trigger the error check there all over again when we
re-enter the tracer and call local_irq_restore() once more.

And this would explain the crazy recursion we get.

Another idea is to decrement the ->disabled counter after the
local_irq_restore().  Yes, we might lose IRQ handler traces which
occur between the local_irq_restore() and the counter decrment, but we
would also be completely immune to recursion problems.

This was a great lead Frederic, it probably explains the bulk of our
problems.  Thanks for narrowing it down like this!
