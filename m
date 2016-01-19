From: David Miller <davem@davemloft.net>
Date: Tue, 19 Jan 2016 19:39:53 +0000
Subject: Re: using ptrace to cancel a syscall on sparc
Message-Id: <20160119.143953.133998620717754795.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20151220054754.GZ11489@vapier.lan>
In-Reply-To: <20151220054754.GZ11489@vapier.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 18 Jan 2016 06:32:30 -0500

> looks like the bug is in arch/sparc/kernel/syscalls.S:linux_syscall_trace32
> (and linux_syscall_trace).  they don't reload the args from the pt_regs
> struct after calling syscall_trace_enter.  i put in a small hack:
> linux_syscall_trace32:
> 	call	syscall_trace_enter
> 	 add	%sp, PTREGS_OFF, %o0
> 	brnz,pn	%o0, 3f
> 	 mov	-ENOSYS, %o0
> +
> +	ldx	[%sp + PTREGS_OFF + PT_V9_G1], %g1
> +	cmp	%g1, NR_syscalls
> =	bgeu,pn	%xcc, 3f
> +	 mov	-ENOSYS, %o0
> +
> 	srl	%i0, 0, %o0
> 	srl	%i4, 0, %o4
> ...
> 
> it's enough for my use case (cancel the call), but it's not entirely correct.
> i think it needs to re-initialize %l7 with the final syscall pointer via the
> syscall table, and it needs to reload PT_V9_I{0..5}.  i have no idea which
> regs need stuffing though, especially in light of the %l7 optimization.  and
> i'm not familiar at all with the apparent parallelism via IEU0/IEU1 groups.
> so i won't bother with trying to write a full patch.  hopefully sparc guys
> will notice & post a fix ;).

Thanks Mike, indeed this code is problematic.

We definitely need to reload all of the syscall registers (%o0-%o5,
%g1), revalidate the range of the syscall number in %g1, and if that
passes recompute the syscall table entry.

I'll work on a complete fix, thanks a lot for reporting this!
