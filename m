From: David Miller <davem@davemloft.net>
Date: Sat, 14 Mar 2009 20:55:58 +0000
Subject: Re: question on sparc64 switch_to macro
Message-Id: <20090314.135558.167131667.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200903141853.n2EIrqn13598@elf.torek.net>
In-Reply-To: <200903141853.n2EIrqn13598@elf.torek.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Chris Torek <chris.torek@windriver.com>
Date: Sat, 14 Mar 2009 12:53:52 -0600

> In the switch_to code, we have (converting to "normal" asm for
> readability and adding markers A and B):
> 	...
> 	mov	thread_info_reg, %g6
> 	ldub	[thread_info_reg + TI_CWP], %g1
> A-->	wrpr	%g1, %cwp
> 	ldx	[%g6 + TI_KSP], %o6
> 	ldub	[%g6 + TI_WSTATE], %o5
> 	ldub	[%g6 + TI_NEW_CHILD], %o7
> B-->	wrpr	%o5, 0x0, %wstate
> 	...
> 
> Aside from the fact that one could use %g6 for the first ldub :-)

Using %g6 wouldn't allow the ldub to issue in the same group as the
previous instruction, as that would create a dependency.  Not
using %g6 is therefore very deliberate here.

> Suppose we get a trap anywhere between point A and point B (from
> "right after A" to "right before B finishes", really).  We will
> not get regular (software) interrupts because we have %pil set to
> 15 (blocking even the "NMI"), but we can still take traps.  But we
> have a potentially inconsistent window state: %o6 is not yet correct
> (up to the ldx anyway), and %wstate likewise.

Nothing that cares about window state is supposed to trap here.
That is a very important invariant.

> The kgdb slave capture trap, however, is quite different.

Yes, this is broken and won't work, we can't allow cross-call
vectored interrupts to run C code otherwise we create problems
like the one you describe.

All of the other cross cpu interrupts reschedule the event
to a PIL based interrupt, and that's probably what we should
do here as well (see xcall_capture, for example).

> (I'll note that a one-instruction cleanup is possible here, we
> could "rd %pc, %g7" in the delay slot, instead of using the 109:
> label.  I think I saw one or two more cases like this scattered
> about, if anyone wants to go bum a few instructions. :-) )

"rd %pc, X" doesn't schedule very well at all, it flushes the pipeline
completely and cannot issue alongside other instructions.

> For normal interrupts, this is fine, because the switch_to code
> has those blocked.  But shouldn't switch_to clear PSTATE_IE during
> the "sensitive" code in the thread-switch?  Or, perhaps, the kgdb
> "capture client" should run off a software interrupt.  (This presents
> other possible problems.  You want the capture to be a "mostly
> non-maskable" interrupt.  sparc-next now has the pseudo-NMI at
> %pil=15, but the kernel I am working on is older.)

No, we don't want to turn off PSTATE_IE, that makes the profiling
NMI interrupt less useful.

I'm pretty sure using a software interrupt is the best solution.

> (I also wonder whether, in the sparc-next tree, the kgdb capture
> code shown above should be using PIL_NORMAL_MAX, which lets in
> "nmi"s, or 15, to block them too.  15 seems more likely correct
> to me.)

We use 15 explicitly to block out NMIs, I actually triggered
a crash when using PIL_NORMAL_MAX and it was because of the
%cwp et al. issues you have discovered here.

It's so easy to reschedule this kgdb capture thing into a software
interrupt, please code that up and give it a whirl.

Or, as usual, I'll do it :-/
