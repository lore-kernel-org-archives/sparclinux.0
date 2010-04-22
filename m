From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Thu, 22 Apr 2010 19:20:32 +0000
Subject: Re: [PATCH 2/2] sparc64: Fix stack dumping and tracing when
Message-Id: <20100422192029.GC5600@nowhere>
List-Id: <sparclinux.vger.kernel.org>
References: <20100421.032355.147982685.davem@davemloft.net>
In-Reply-To: <20100421.032355.147982685.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Apr 21, 2010 at 03:23:55AM -0700, David Miller wrote:
> 
> Like x86, when the function graph tracer is enabled, emit the ftrace
> stub as well as the program counter it will be transformed back into.
> 
> We duplicate a lot of similar stack walking logic in 3 or 4 spots, so
> eventually we should consolidate things like x86 does.



Yeah, in fact if we want a kind a arch agnostic graph stack walker,
we could make it an iterator.

(Modifying print_ftrace_graph_addr a bit)

static unsigned long
walk_ftrace_graph_stack(unsigned long addr,
			struct task_struct *task, int *idx)
{
	unsigned long ret_addr;
	int index = task->curr_ret_stack;

	if (addr != (unsigned long)return_to_handler)
		return -ENOENT;

	if (!task->ret_stack || index < *idx)
		return -ENOENT;

	index -= *idx;
	ret_addr = task->ret_stack[index].ret;

	(*idx)++;

	return ret_addr;
}

Hmm?

I can make it in tracing/core but I fear it won't be available
for the sparc tree until .35

