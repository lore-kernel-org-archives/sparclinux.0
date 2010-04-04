From: David Miller <davem@davemloft.net>
Date: Sun, 04 Apr 2010 06:59:22 +0000
Subject: [PATCH] sparc64: Implement perf_arch_fetch_caller_regs
Message-Id: <20100403.235922.169556601.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Frederic I'm posting this in case you want to play around
with this on your sparc64 box.  I pushed this to my sparc-2.6
tree and will push it out to Linus as well.

Paulus, I noticed while writing this that you don't seem to provide
some form of the processor status register on powerpc, which is
necessary to resolve user_mode() and perf_misc_flags() in these
code paths.

Maybe your status register, when zero, means !user_mode() and nops out
perf_misc_flags() as well, and that's how it all just works itself
out?

sparc64: Implement perf_arch_fetch_caller_regs

We provide regs->tstate, regs->tpc, regs->tnpc and
regs->u_regs[UREG_FP].

regs->tstate is necessary for:

	user_mode()		(via perf_exclude_event())

	perf_misc_flags()	(via perf_prepare_sample())

regs->tpc is necessary for:

	perf_instruction_pointer() (via perf_prepare_sample())

and regs->u_regs[UREG_FP] is necessary for:

	perf_callchain()	(via perf_prepare_sample())

The regs->tnpc value is provided just to be tidy.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/helpers.S |   75 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/helpers.S b/arch/sparc/kernel/helpers.S
index 314dd0c..92090cc 100644
--- a/arch/sparc/kernel/helpers.S
+++ b/arch/sparc/kernel/helpers.S
@@ -46,6 +46,81 @@ stack_trace_flush:
 	 nop
 	.size		stack_trace_flush,.-stack_trace_flush
 
+#ifdef CONFIG_PERF_EVENTS
+	.globl		perf_arch_fetch_caller_regs
+	.type		perf_arch_fetch_caller_regs,#function
+perf_arch_fetch_caller_regs:
+	/* We always read the %pstate into %o5 since we will use
+	 * that to construct a fake %tstate to store into the regs.
+	 */
+	rdpr		%pstate, %o5
+	brz,pn		%o2, 50f
+	 mov		%o2, %g7
+
+	/* Turn off interrupts while we walk around the register
+	 * window by hand.
+	 */
+	wrpr		%o5, PSTATE_IE, %pstate
+
+	/* The %canrestore tells us how many register windows are
+	 * still live in the chip above us, past that we have to
+	 * walk the frame as saved on the stack.   We stash away
+	 * the %cwp in %g1 so we can return back to the original
+	 * register window.
+	 */
+	rdpr		%cwp, %g1
+	rdpr		%canrestore, %g2
+	sub		%g1, 1, %g3
+
+	/* We have the skip count in %g7, if it hits zero then
+	 * %fp/%i7 are the registers we need.  Otherwise if our
+	 * %canrestore count maintained in %g2 hits zero we have
+	 * to start traversing the stack.
+	 */
+10:	brz,pn		%g2, 4f
+	 sub		%g2, 1, %g2
+	wrpr		%g3, %cwp
+	subcc		%g7, 1, %g7
+	bne,pt		%xcc, 10b
+	 sub		%g3, 1, %g3
+
+	/* We found the values we need in the cpu's register
+	 * windows.
+	 */
+	mov		%fp, %g3
+	ba,pt		%xcc, 3f
+	 mov		%i7, %g2
+
+50:	mov		%fp, %g3
+	ba,pt		%xcc, 2f
+	 mov		%i7, %g2
+
+	/* We hit the end of the valid register windows in the
+	 * cpu, start traversing the stack frame.
+	 */
+4:	mov		%fp, %g3
+
+20:	ldx		[%g3 + STACK_BIAS + RW_V9_I7], %g2
+	subcc		%g7, 1, %g7
+	bne,pn		%xcc, 20b
+	 ldx		[%g3 + STACK_BIAS + RW_V9_I6], %g3
+
+	/* Restore the current register window position and
+	 * re-enable interrupts.
+	 */
+3:	wrpr		%g1, %cwp
+	wrpr		%o5, %pstate
+
+2:	stx		%g3, [%o0 + PT_V9_FP]
+	sllx		%o5, 8, %o5
+	stx		%o5, [%o0 + PT_V9_TSTATE]
+	stx		%g2, [%o0 + PT_V9_TPC]
+	add		%g2, 4, %g2
+	retl
+	 stx		%g2, [%o0 + PT_V9_TNPC]
+	.size		perf_arch_fetch_caller_regs,.-perf_arch_fetch_caller_regs
+#endif /* CONFIG_PERF_EVENTS */
+
 #ifdef CONFIG_SMP
 	.globl		hard_smp_processor_id
 	.type		hard_smp_processor_id,#function
-- 
1.7.0.4

