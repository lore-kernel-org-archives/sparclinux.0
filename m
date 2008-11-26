From: David Miller <davem@davemloft.net>
Date: Wed, 26 Nov 2008 08:40:51 +0000
Subject: [PATCH 3/6]: sparc64: Make special trap return path for TRAP_NMI().
Message-Id: <20081126.004051.138998912.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc64: Make special trap return path for TRAP_NMI().

We don't want the rtrap path to try and run softirqs or
anything like that when returning from a PIL=15 NMI.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/ttable.h |    2 +-
 arch/sparc64/kernel/rtrap.S     |   14 +++++++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/ttable.h b/arch/sparc/include/asm/ttable.h
index bb2c077..48f2807 100644
--- a/arch/sparc/include/asm/ttable.h
+++ b/arch/sparc/include/asm/ttable.h
@@ -162,7 +162,7 @@
 	mov	level, %o0;				\
 	call	routine;				\
 	 add	%sp, PTREGS_OFF, %o1;			\
-	ba,a,pt	%xcc, rtrap_irq;
+	ba,a,pt	%xcc, rtrap_nmi;
 
 #define TRAP_IVEC TRAP_NOSAVE(do_ivec)
 
diff --git a/arch/sparc64/kernel/rtrap.S b/arch/sparc64/kernel/rtrap.S
index 6892cf5..fd3cee4 100644
--- a/arch/sparc64/kernel/rtrap.S
+++ b/arch/sparc64/kernel/rtrap.S
@@ -132,6 +132,18 @@ __handle_signal:
 		ba,pt			%xcc, __handle_signal_continue
 		 andn			%l1, %l4, %l1
 
+		/* When returning from a NMI (%pil=15) interrupt we want to
+		 * avoid running softirqs, doing IRQ tracing, preempting, etc.
+		 */
+		.globl			rtrap_nmi
+rtrap_nmi:	ldx			[%sp + PTREGS_OFF + PT_V9_TSTATE], %l1
+		sethi			%hi(0xf << 20), %l4
+		and			%l1, %l4, %l4
+		andn			%l1, %l4, %l1
+		srl			%l4, 20, %l4
+		ba,pt			%xcc, rtrap_no_irq_enable
+		 wrpr			%l4, %pil
+
 		.align			64
 		.globl			rtrap_irq, rtrap, irqsz_patchme, rtrap_xcall
 rtrap_irq:
@@ -161,8 +173,8 @@ rtrap_xcall:
 		call			trace_hardirqs_on
 		 nop
 		wrpr			%l4, %pil
-rtrap_no_irq_enable:
 #endif
+rtrap_no_irq_enable:
 		andcc			%l1, TSTATE_PRIV, %l3
 		bne,pn			%icc, to_kernel
 		 nop
-- 
1.5.6.5

