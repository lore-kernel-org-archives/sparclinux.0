From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Wed, 22 Sep 2010 19:04:23 +0000
Subject: Re: [GIT] Sparc
Message-Id: <20100922190423.GE19804@ZenIV.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20100922.111019.200357319.davem@davemloft.net>
 <20100922183200.GC19804@ZenIV.linux.org.uk>
 <AANLkTi=DWk2_=wMqcM1jgJEuNRj_ni2OkM3osYCUg57Y@mail.gmail.com>
 <20100922185328.GD19804@ZenIV.linux.org.uk>
In-Reply-To: <20100922185328.GD19804@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Miller <davem@davemloft.net>, akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Sep 22, 2010 at 07:53:28PM +0100, Al Viro wrote:

> Um, no.  You've *already* called get_signal_to_deliver().  There had been
> no SIGSEGV in sight.  You happily went on to set a sigframe for e.g.
> SIGHUP, but ran out of stack.  At that point you get force_sigsegv()
> from handle_signal().  _NOW_ you have a pending SIGSEGV; whether you'll
> be able to handle it (e.g. if your SIGSEGV handler is set to run on
> altstack) or not, you won't get to it until you call get_signal_to_deliver()
> again.  Which requires do_signal() to run.
> 
> Sure, it will be the first one to be picked, but we need to try and pick
> _something_ to get it.

PS: on something like x86 that'll happen before we return to userland,
since the glue on syscall exit does that:

int_signal:
        testl $_TIF_DO_NOTIFY_MASK,%edx
        jz 1f
        movq %rsp,%rdi          # &ptregs -> arg1
        xorl %esi,%esi          # oldset -> arg2
        call do_notify_resume
1:      movl $_TIF_WORK_MASK,%edi
int_restore_rest:
        RESTORE_REST
        DISABLE_INTERRUPTS(CLBR_NONE)
        TRACE_IRQS_OFF
        jmp int_with_check

and int_with_check leads back to int_signal if _TIF_SIGPENDING is still set.

That kind of looping happens on everything except sparc and that's exactly
the difference I'm talking about.  On sparc the sucker manages to escape
to userland with SIGSEGV still pending.  Try it and you'll see - simple
signal(SIGHUP, something) + munmap a little bit under your %sp +
raise(SIGHUP), then look at the resulting coredump...  On sparc you'll
get that SIGSEGV later; in fact, putting write(1, "ouch\n", 5); after
that raise() has a good chance of saying ouch before it dumps core.
