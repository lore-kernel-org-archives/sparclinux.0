From: David Miller <davem@davemloft.net>
Date: Sun, 29 May 2016 04:24:20 +0000
Subject: Re: [4.1.x -- 4.6.x and probably HEAD] Reproducible unprivileged panic/TLB BUG on sparc via a stack-
Message-Id: <20160528.212420.136855725029412782.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20160527.123731.2105286005500436503.davem@davemloft.net>
	<8760tz2n1j.fsf@esperi.org.uk>
	<20160527.155137.1489438133864702237.davem@davemloft.net>
In-Reply-To: <20160527.155137.1489438133864702237.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: nix@esperi.org.uk
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, fweimer@redhat.com

From: David Miller <davem@davemloft.net>
Date: Fri, 27 May 2016 15:51:37 -0700 (PDT)

> I'm trying to figure out the same thing myself.

Ok, mystery solved.

The basic problem is that we don't handle unaligned stacks on return to userspace
%100 properly.  We would also no handle a stack whose access would trigger a bus
error or similar.

A little background:

The window trap handlers are slightly clever, the trap table entries for them are
composed of two pieces of code.  First comes the code that actually performs
the window fill or spill trap handling, and then there are three instructions at
the end which are for exception processing.

The userland register window fill handler is:

#define FILL_1_GENERIC(ASI)				\
	add	%sp, STACK_BIAS + 0x00, %g1;		\
	ldxa	[%g1 + %g0] ASI, %l0;			\
	mov	0x08, %g2;				\
	mov	0x10, %g3;				\
	ldxa	[%g1 + %g2] ASI, %l1;			\
	mov	0x18, %g5;				\
	ldxa	[%g1 + %g3] ASI, %l2;			\
	ldxa	[%g1 + %g5] ASI, %l3;			\
	add	%g1, 0x20, %g1;				\
	ldxa	[%g1 + %g0] ASI, %l4;			\
	ldxa	[%g1 + %g2] ASI, %l5;			\
	ldxa	[%g1 + %g3] ASI, %l6;			\
	ldxa	[%g1 + %g5] ASI, %l7;			\
	add	%g1, 0x20, %g1;				\
	ldxa	[%g1 + %g0] ASI, %i0;			\
	ldxa	[%g1 + %g2] ASI, %i1;			\
	ldxa	[%g1 + %g3] ASI, %i2;			\
	ldxa	[%g1 + %g5] ASI, %i3;			\
	add	%g1, 0x20, %g1;				\
	ldxa	[%g1 + %g0] ASI, %i4;			\
	ldxa	[%g1 + %g2] ASI, %i5;			\
	ldxa	[%g1 + %g3] ASI, %i6;			\
	ldxa	[%g1 + %g5] ASI, %i7;			\
	restored;					\
	retry; nop; nop; nop; nop;			\
	b,a,pt	%xcc, fill_fixup_dax;			\
	b,a,pt	%xcc, fill_fixup_mna;			\
	b,a,pt	%xcc, fill_fixup;

And the way this works is that if any of those loads or stores
generate an exception, the exception handler can revector to one of
those final three branch instructions depending upon which kind of
exception the memory access took.

For example, for a regular fault, the code goes:

winfix_trampoline:
	rdpr	%tpc, %g3			! Prepare winfixup TNPC
	or	%g3, 0x7c, %g3			! Compute branch offset
	wrpr	%g3, %tnpc			! Write it into TNPC
	done					! Trap return

All window trap handlers are 0x80 aligned, so if we "or" 0x7c into the
trap time program counter, we'll get that final instruction in the
trap handler.

On return from trap, we have to pull the register window in but we do
this by hand instead of just executing a "restore" instruction for
several reasons.  The largest being that from Niagara and onward we
simply don't have enough levels in the trap stack to fully resolve all
possible exception cases of a window fault when we are already at
trap level 1 (which we enter to get ready to return from the original
trap).

This is executed inline via the FILL_*_RTRAP handlers.  rtrap_64.S's
code branches directly to these to do the window fill by hand if
necessary.  Now if you look at them, we'll see at the end:

	ba,a,pt	%xcc, user_rtt_fill_fixup;		\
	ba,a,pt	%xcc, user_rtt_fill_fixup;		\
	ba,a,pt	%xcc, user_rtt_fill_fixup;

oops all three cases are handled like a fault.

This doesn't work because each of these trap types (data access
exception, memory address unaligned, and faults) store their auxiliary
info in different registers to pass on to the C handler which does the
real work.

So in the case where the stack was unaligned, the unaligned trap
handler setup the arg registers one way, and then we branched to
the fault handler.

So the FAULT_TYPE_* value was basically garbage, and randomly would
generate the backtrace that you saw.

This is the fix I am testing right now:

==========
From d645a0376b0010cd60ae5651b3b84a56f5b0e5a4 Mon Sep 17 00:00:00 2001
From: "David S. Miller" <davem@davemloft.net>
Date: Sat, 28 May 2016 20:41:12 -0700
Subject: [PATCH 2/2] sparc64: Fix return from trap window fill crashes.

We must handle data access exception as well as memory address unaligned
exceptions from return from trap window fill faults, not just normal
TLB misses.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/ttable.h |  8 ++--
 arch/sparc/kernel/Makefile      |  1 +
 arch/sparc/kernel/rtrap_64.S    | 57 ++++--------------------
 arch/sparc/kernel/urtt_fill.S   | 98 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 112 insertions(+), 52 deletions(-)
 create mode 100644 arch/sparc/kernel/urtt_fill.S

diff --git a/arch/sparc/include/asm/ttable.h b/arch/sparc/include/asm/ttable.h
index 71b5a67..781b9f1 100644
--- a/arch/sparc/include/asm/ttable.h
+++ b/arch/sparc/include/asm/ttable.h
@@ -589,8 +589,8 @@ user_rtt_fill_64bit:					\
 	 restored;					\
 	nop; nop; nop; nop; nop; nop;			\
 	nop; nop; nop; nop; nop;			\
-	ba,a,pt	%xcc, user_rtt_fill_fixup;		\
-	ba,a,pt	%xcc, user_rtt_fill_fixup;		\
+	ba,a,pt	%xcc, user_rtt_fill_fixup_dax;		\
+	ba,a,pt	%xcc, user_rtt_fill_fixup_mna;		\
 	ba,a,pt	%xcc, user_rtt_fill_fixup;
 
 
@@ -652,8 +652,8 @@ user_rtt_fill_32bit:					\
 	 restored;					\
 	nop; nop; nop; nop; nop;			\
 	nop; nop; nop;					\
-	ba,a,pt	%xcc, user_rtt_fill_fixup;		\
-	ba,a,pt	%xcc, user_rtt_fill_fixup;		\
+	ba,a,pt	%xcc, user_rtt_fill_fixup_dax;		\
+	ba,a,pt	%xcc, user_rtt_fill_fixup_mna;		\
 	ba,a,pt	%xcc, user_rtt_fill_fixup;
 
 
diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index 7cf9c6e..fdb1332 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -21,6 +21,7 @@ CFLAGS_REMOVE_perf_event.o := -pg
 CFLAGS_REMOVE_pcr.o := -pg
 endif
 
+obj-$(CONFIG_SPARC64)   += urtt_fill.o
 obj-$(CONFIG_SPARC32)   += entry.o wof.o wuf.o
 obj-$(CONFIG_SPARC32)   += etrap_32.o
 obj-$(CONFIG_SPARC32)   += rtrap_32.o
diff --git a/arch/sparc/kernel/rtrap_64.S b/arch/sparc/kernel/rtrap_64.S
index d08bdaf..216948c 100644
--- a/arch/sparc/kernel/rtrap_64.S
+++ b/arch/sparc/kernel/rtrap_64.S
@@ -14,10 +14,6 @@
 #include <asm/visasm.h>
 #include <asm/processor.h>
 
-#define		RTRAP_PSTATE		(PSTATE_TSO|PSTATE_PEF|PSTATE_PRIV|PSTATE_IE)
-#define		RTRAP_PSTATE_IRQOFF	(PSTATE_TSO|PSTATE_PEF|PSTATE_PRIV)
-#define		RTRAP_PSTATE_AG_IRQOFF	(PSTATE_TSO|PSTATE_PEF|PSTATE_PRIV|PSTATE_AG)
-
 #ifdef CONFIG_CONTEXT_TRACKING
 # define SCHEDULE_USER schedule_user
 #else
@@ -242,52 +238,17 @@ rt_continue:	ldx			[%sp + PTREGS_OFF + PT_V9_G1], %g1
 		 wrpr			%g1, %cwp
 		ba,a,pt			%xcc, user_rtt_fill_64bit
 
-user_rtt_fill_fixup:
-		rdpr	%cwp, %g1
-		add	%g1, 1, %g1
-		wrpr	%g1, 0x0, %cwp
-
-		rdpr	%wstate, %g2
-		sll	%g2, 3, %g2
-		wrpr	%g2, 0x0, %wstate
-
-		/* We know %canrestore and %otherwin are both zero.  */
-
-		sethi	%hi(sparc64_kern_pri_context), %g2
-		ldx	[%g2 + %lo(sparc64_kern_pri_context)], %g2
-		mov	PRIMARY_CONTEXT, %g1
-
-661:		stxa	%g2, [%g1] ASI_DMMU
-		.section .sun4v_1insn_patch, "ax"
-		.word	661b
-		stxa	%g2, [%g1] ASI_MMU
-		.previous
-
-		sethi	%hi(KERNBASE), %g1
-		flush	%g1
+user_rtt_fill_fixup_dax:
+		ba,pt	%xcc, user_rtt_fill_fixup_common
+		 mov	1, %g3
 
-		or	%g4, FAULT_CODE_WINFIXUP, %g4
-		stb	%g4, [%g6 + TI_FAULT_CODE]
-		stx	%g5, [%g6 + TI_FAULT_ADDR]
+user_rtt_fill_fixup_mna:
+		ba,pt	%xcc, user_rtt_fill_fixup_common
+		 mov	2, %g3
 
-		mov	%g6, %l1
-		wrpr	%g0, 0x0, %tl
-
-661:		nop
-		.section		.sun4v_1insn_patch, "ax"
-		.word			661b
-		SET_GL(0)
-		.previous
-
-		wrpr	%g0, RTRAP_PSTATE, %pstate
-
-		mov	%l1, %g6
-		ldx	[%g6 + TI_TASK], %g4
-		LOAD_PER_CPU_BASE(%g5, %g6, %g1, %g2, %g3)
-		call	do_sparc64_fault
-		 add	%sp, PTREGS_OFF, %o0
-		ba,pt	%xcc, rtrap
-		 nop
+user_rtt_fill_fixup:
+		ba,pt	%xcc, user_rtt_fill_fixup_common
+		 clr	%g3
 
 user_rtt_pre_restore:
 		add			%g1, 1, %g1
diff --git a/arch/sparc/kernel/urtt_fill.S b/arch/sparc/kernel/urtt_fill.S
new file mode 100644
index 0000000..5604a2b
--- /dev/null
+++ b/arch/sparc/kernel/urtt_fill.S
@@ -0,0 +1,98 @@
+#include <asm/thread_info.h>
+#include <asm/trap_block.h>
+#include <asm/spitfire.h>
+#include <asm/ptrace.h>
+#include <asm/head.h>
+
+		.text
+		.align	8
+		.globl	user_rtt_fill_fixup_common
+user_rtt_fill_fixup_common:
+		rdpr	%cwp, %g1
+		add	%g1, 1, %g1
+		wrpr	%g1, 0x0, %cwp
+
+		rdpr	%wstate, %g2
+		sll	%g2, 3, %g2
+		wrpr	%g2, 0x0, %wstate
+
+		/* We know %canrestore and %otherwin are both zero.  */
+
+		sethi	%hi(sparc64_kern_pri_context), %g2
+		ldx	[%g2 + %lo(sparc64_kern_pri_context)], %g2
+		mov	PRIMARY_CONTEXT, %g1
+
+661:		stxa	%g2, [%g1] ASI_DMMU
+		.section .sun4v_1insn_patch, "ax"
+		.word	661b
+		stxa	%g2, [%g1] ASI_MMU
+		.previous
+
+		sethi	%hi(KERNBASE), %g1
+		flush	%g1
+
+		mov	%g4, %l4
+		mov	%g5, %l5
+		brnz,pn	%g3, 1f
+		 mov	%g3, %l3
+
+		or	%g4, FAULT_CODE_WINFIXUP, %g4
+		stb	%g4, [%g6 + TI_FAULT_CODE]
+		stx	%g5, [%g6 + TI_FAULT_ADDR]
+1:
+		mov	%g6, %l1
+		wrpr	%g0, 0x0, %tl
+
+661:		nop
+		.section		.sun4v_1insn_patch, "ax"
+		.word			661b
+		SET_GL(0)
+		.previous
+
+		wrpr	%g0, RTRAP_PSTATE, %pstate
+
+		mov	%l1, %g6
+		ldx	[%g6 + TI_TASK], %g4
+		LOAD_PER_CPU_BASE(%g5, %g6, %g1, %g2, %g3)
+
+		brnz,pn	%l3, 1f
+		 nop
+
+		call	do_sparc64_fault
+		 add	%sp, PTREGS_OFF, %o0
+		ba,pt	%xcc, rtrap
+		 nop
+
+1:		cmp	%g3, 2
+		bne,pn	%xcc, 2f
+		 nop
+
+		sethi	%hi(tlb_type), %g1
+		lduw	[%g1 + %lo(tlb_type)], %g1
+		cmp	%g1, 3
+		bne,pt	%icc, 1f
+		 add	%sp, PTREGS_OFF, %o0
+		mov	%l4, %o2
+		call	sun4v_do_mna
+		 mov	%l5, %o1
+		ba,a,pt	%xcc, rtrap
+1:		mov	%l4, %o1
+		mov	%l5, %o2
+		call	mem_address_unaligned
+		 nop
+		ba,a,pt	%xcc, rtrap
+
+2:		sethi	%hi(tlb_type), %g1
+		mov	%l4, %o1
+		lduw	[%g1 + %lo(tlb_type)], %g1
+		mov	%l5, %o2
+		cmp	%g1, 3
+		bne,pt	%icc, 1f
+		 add	%sp, PTREGS_OFF, %o0
+		call	sun4v_data_access_exception
+		 nop
+		ba,a,pt	%xcc, rtrap
+
+1:		call	spitfire_data_access_exception
+		 nop
+		ba,a,pt	%xcc, rtrap
-- 
2.1.2.532.g19b5d50

