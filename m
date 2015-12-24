From: David Miller <davem@davemloft.net>
Date: Thu, 24 Dec 2015 16:43:34 +0000
Subject: Re: [PATCH] sparc64: fix FP corruption in user copy functions
Message-Id: <20151224.114334.711621212133951275.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1450851889-8950-1-git-send-email-rob.gardner@oracle.com>
In-Reply-To: <1450851889-8950-1-git-send-email-rob.gardner@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Rob Gardner <rob.gardner@oracle.com>
Date: Tue, 22 Dec 2015 23:24:49 -0700

> Short story: Exception handlers used by some copy_to_user() and
> copy_from_user() functions do not diligently clean up floating point
> register usage, and this can result in a user process seeing invalid
> values in floating point registers. This sometimes makes the process
> fail.
> 
> Long story: Several cpu-specific (NG4, NG2, U1, U3) memcpy functions
> use floating point registers and VIS alignaddr/faligndata to
> accelerate data copying when source and dest addresses don't align
> well. Linux uses a lazy scheme for saving floating point registers; It
> is not done upon entering the kernel since it's a very expensive
> operation. Rather, it is done only when needed. If the kernel ends up
> not using FP regs during the course of some trap or system call, then
> it can return to user space without saving or restoring them.
> 
> The various memcpy functions begin their FP code with VISEntry (or a
> variation thereof), which saves the FP regs. They conclude their FP
> code with VISExit (or a variation) which essentially marks the FP regs
> "clean", ie, they contain no unsaved values. fprs.FPRS_FEF is turned
> off so that a lazy restore will be triggered when/if the user process
> accesses floating point regs again.
> 
> The bug is that the user copy variants of memcpy, copy_from_user() and
> copy_to_user(), employ an exception handling mechanism to detect faults
> when accessing user space addresses, and when this handler is invoked,
> an immediate return from the function is forced, and VISExit is not
> executed, thus leaving the fprs register in an indeterminate state,
> but often with fprs.FPRS_FEF set and one or more dirty bits. This
> results in a return to user space with invalid values in the FP regs,
> and since fprs.FPRS_FEF is on, no lazy restore occurs.
> 
> This bug affects copy_to_user() and copy_from_user() for NG4, NG2,
> U3, and U1. All are fixed by using a new exception handler for those
> loads and stores that are done during the time between VISEnter and
> VISExit.
> 
> n.b. In NG4memcpy, the problematic code can be triggered by a copy
> size greater than 128 bytes and an unaligned source address.  This bug
> is known to be the cause of random user process memory corruptions
> while perf is running with the callgraph option (ie, perf record -g).
> This occurs because perf uses copy_from_user() to read user stacks,
> and may fault when it follows a stack frame pointer off to an
> invalid page. Validation checks on the stack address just obscure
> the underlying problem.
> 
> Signed-off-by: Rob Gardner <rob.gardner@oracle.com>
> Signed-off-by: Dave Aldridge <david.j.aldridge@oracle.com>

Also applied, thanks a lot.
