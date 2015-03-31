From: David Miller <davem@davemloft.net>
Date: Tue, 31 Mar 2015 23:38:39 +0000
Subject: Re: sparc: deadlock using perf with sched tracepoints and user callstacks
Message-Id: <20150331.193839.125785353129600639.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <551AFA5A.1000908@oracle.com>
In-Reply-To: <551AFA5A.1000908@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Ahern <david.ahern@oracle.com>
Date: Tue, 31 Mar 2015 13:49:46 -0600

> The scheduler tracepoints can be hit with the run queue lock
> taken. Per the above while walking the userspace callchains page
> faults can cause paths where __schedule gets called again. The
> deadlock happens because it wants the runqueue lock again.
> 
> For PowerPC (b59a1bfcc2406ea75346977ad016cfe909a762ac) the solution
> was to disable pagefaults while walking userspace stacks. That does
> not work for sparc; rather that change results in process terminating
> due to a SIGBUS:

What is different in the PowerPC fault path vs. the Sparc one that
causes the SIGBUS for sparc where the PowerPC does not see it?

I don't understand where the SIGBUS comes from.  In a pagefault
disable section on sparc, in_atomic() should be true, thus we'll call
do_kernel_fault(), fall through to the TSTATE_PRIV code path and
simply run the exception handler.
