From: David Miller <davem@davemloft.net>
Date: Tue, 20 Apr 2010 05:51:05 +0000
Subject: Re: [PATCH 7/7] sparc64: Add function graph tracer support.
Message-Id: <20100419.225105.71120452.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100412.234300.212396783.davem@davemloft.net>
In-Reply-To: <20100412.234300.212396783.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Frederic, I think I got it.

When CONFIG_TRACE_IRQFLAGS is enabled, we can recurse forever in IRQ
traps, and this is exacerbated by the slowness of tracing as it makes
it more likely we'll hit the small sequence of instructions where we
erroneously enable irqs in the trap return path.

I'm doing my stress tests right now, but if you want to try it out
in parallel, comment out the:

	wrpr	%l4, %pil

enclosed in CONFIG_TRACE_IRQFLAGS in arch/sparc/kernel/rtrap_64.S

The issue here is that we normally restore the trap time %pil further
in the trap return sequence, but this is much beyond the point where
we can still invoke C functions properly.  Which means that we can't
call trace_hardirqs_on() there.  So I was trying to do it early.

But this also means we restore the %pil before we hard disable all
interrupts by clearing PSTATE_IE in the %pstate register.  And this
is what creates the window of instructions where every IRQ return
can erroneously take another IRQ trap.

I have to think about why I might have done things this way to
make sure I fix this right.
