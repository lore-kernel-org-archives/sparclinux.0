From: Chris Torek <chris.torek@windriver.com>
Date: Sat, 14 Mar 2009 18:53:52 +0000
Subject: question on sparc64 switch_to macro
Message-Id: <200903141853.n2EIrqn13598@elf.torek.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

(Background: am attempting to debug a squirrely problem with kgdb
on SMP system, in which the kgdb "master" CPU -- whichever one
takes the kgdb trap -- works OK, but one or more "slaves", captured
by the kgdb "client capture" code, behaves extremely oddly when it
is resumed.  The problem is very timing-dependent and relatively
rare.)

In the switch_to code, we have (converting to "normal" asm for
readability and adding markers A and B):
	...
	mov	thread_info_reg, %g6
	ldub	[thread_info_reg + TI_CWP], %g1
A-->	wrpr	%g1, %cwp
	ldx	[%g6 + TI_KSP], %o6
	ldub	[%g6 + TI_WSTATE], %o5
	ldub	[%g6 + TI_NEW_CHILD], %o7
B-->	wrpr	%o5, 0x0, %wstate
	...

Aside from the fact that one could use %g6 for the first ldub :-)
(but not for the rest due to the %cwp change), here's what
I am wondering:

Suppose we get a trap anywhere between point A and point B (from
"right after A" to "right before B finishes", really).  We will
not get regular (software) interrupts because we have %pil set to
15 (blocking even the "NMI"), but we can still take traps.  But we
have a potentially inconsistent window state: %o6 is not yet correct
(up to the ldx anyway), and %wstate likewise.

Most traps do all their work in the trap globals (PSTATE_AG,
PSTATE_MG, %gl=1, or whatever this particular CPU uses) and then
simply "retry", so that part is OK.  Most of the remaining trap
cases are pretty fatal ("cpu is on fire" or whatever) so we might
not worry about them much either.

The kgdb slave capture trap, however, is quite different.  It
arrives in xcall_kgdb_capture (in "trap globals" as usual).  It
raises %pil to "high", uses etrap_irq to batten down the hatches,
and calls the C routine smp_kgdb_capture_client():

	... magic patchy code to switch to interrupt globals [snipped]
	rdpr	%pil, %g2
	wrpr	%g0, PIL_NORMAL_MAX, %pil
	sethi	%hi(109f), %g7
	ba,pt	%xcc, etrap_irq
109:	 or	%g7, %lo(109b), %g7
#ifdef CONFIG_TRACE_IRQFLAGS
	call	trace_hardirqs_off
	 nop
#endif
	call	smp_kgdb_capture_client
	 add	%sp, PTREGS_OFF, %o0

(I'll note that a one-instruction cleanup is possible here, we
could "rd %pc, %g7" in the delay slot, instead of using the 109:
label.  I think I saw one or two more cases like this scattered
about, if anyone wants to go bum a few instructions. :-) )

For normal interrupts, this is fine, because the switch_to code
has those blocked.  But shouldn't switch_to clear PSTATE_IE during
the "sensitive" code in the thread-switch?  Or, perhaps, the kgdb
"capture client" should run off a software interrupt.  (This presents
other possible problems.  You want the capture to be a "mostly
non-maskable" interrupt.  sparc-next now has the pseudo-NMI at
%pil=15, but the kernel I am working on is older.)

I would (and probably will as soon as I can decide on a "safe" code
path, ie, which %g registers can I use here...) test this, but I'm
not at all sure this is the problem we are seeing now, and whether
or not the change makes it go away, I'm not sure if fussing with
PSTATE_IE in switch_to() is a good or bad idea.  And in particular,
I believe %wstate is almost always the same from one thread to the
next, which makes the window *really* tiny, which means that this
is probably not causing the problem we have observed, so we would
leave it unchanged.  In which case, if it is actually a problem,
it will still be lurking.  So I figured I should enlist the minds
of other sparc gurus. :-)

(I also wonder whether, in the sparc-next tree, the kgdb capture
code shown above should be using PIL_NORMAL_MAX, which lets in
"nmi"s, or 15, to block them too.  15 seems more likely correct
to me.)

Chris

(PS: I have not thought nearly enough about this, but: in the
ultrasparc code I did in another lifetime, I did not bother fiddling
%cwp in the task-switch code, because we know the register windows
are empty both before and after, so %cwp does not really matter:
we are going to fault in all the "above" windows as usual, and in
that system, nothing ever let you peek at the %cwp value.  It may
be possible to do the same in the linux code.  In which case the
switch code has many more registers available to it, plus this
saves you one whole "wrpr" instruction. :-) Something for those
better-versed than I to consider, anyway.)
