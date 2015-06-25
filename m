From: David Miller <davem@davemloft.net>
Date: Thu, 25 Jun 2015 13:13:55 +0000
Subject: Re: [PATCH 0/4] sparc64: perf fixes for userspace stacks
Message-Id: <20150625.061355.1405226326474862734.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1434399346-21665-1-git-send-email-david.ahern@oracle.com>
In-Reply-To: <1434399346-21665-1-git-send-email-david.ahern@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Ahern <david.ahern@oracle.com>
Date: Mon, 15 Jun 2015 16:15:42 -0400

> Hi Dave:
> 
> Coming back to the perf userspace callchain problem. As a reminder there are
> a series of problems trying to use perf to collect callchains with scheduling
> tracepoints, e.g., perf sched record -g -- <cmd>.
> 
> The first patch disables pagefaults while walking the user stack. As discussed
> a couple of months ago this is the right fix, but I was puzzled as to why
> processes were terminating with sigbus (and sometimes sigsegv). I believe the
> root of this problem is bad addresses trying to walk the frames using frame
> pointers. The bad addresses lead to faults that get handled by do_sparc64_fault
> and it aborts the task though I am still puzzled as to why it gets past this
> check in do_sparc64_fault:
> 
>         if (in_atomic() || !mm)
>                 goto intr_or_no_mm;
> 
> pagefault_disable bumps the preempt_count which should make in_atomic return != 0
> (building kernels with preemption set to voluntar, CONFIG_PREEMPT_VOLUNTARY=y).
> 
> While this set does not fully solve the problem it does prevent a number of
> pain points with the current code, most notably able to lock up the system.

Series applied, thanks David.

We can be more strict with the stack alignment check, the window
save/restore won't work on anything not at least 8 byte aligned and
this is strictly defined in the ABIs.
