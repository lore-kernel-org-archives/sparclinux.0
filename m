From: David Miller <davem@davemloft.net>
Date: Tue, 13 Apr 2010 06:42:39 +0000
Subject: [PATCH 2/7] sparc64: Kill CONFIG_STACK_DEBUG code.
Message-Id: <20100412.234239.11258707.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


The generic stack tracer does this job just as well.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/Kconfig.debug |    5 +--
 arch/sparc/lib/mcount.S  |   74 ----------------------------------------------
 2 files changed, 1 insertions(+), 78 deletions(-)

diff --git a/arch/sparc/Kconfig.debug b/arch/sparc/Kconfig.debug
index 9d3c889..1b4a831 100644
--- a/arch/sparc/Kconfig.debug
+++ b/arch/sparc/Kconfig.debug
@@ -19,13 +19,10 @@ config DEBUG_DCFLUSH
 	bool "D-cache flush debugging"
 	depends on SPARC64 && DEBUG_KERNEL
 
-config STACK_DEBUG
-	bool "Stack Overflow Detection Support"
-
 config MCOUNT
 	bool
 	depends on SPARC64
-	depends on STACK_DEBUG || FUNCTION_TRACER
+	depends on FUNCTION_TRACER
 	default y
 
 config FRAME_POINTER
diff --git a/arch/sparc/lib/mcount.S b/arch/sparc/lib/mcount.S
index 7047997..73ed0f3 100644
--- a/arch/sparc/lib/mcount.S
+++ b/arch/sparc/lib/mcount.S
@@ -7,26 +7,11 @@
 
 #include <linux/linkage.h>
 
-#include <asm/ptrace.h>
-#include <asm/thread_info.h>
-
 /*
  * This is the main variant and is called by C code.  GCC's -pg option
  * automatically instruments every C function with a call to this.
  */
 
-#ifdef CONFIG_STACK_DEBUG
-
-#define OVSTACKSIZE	4096		/* lets hope this is enough */
-
-	.data
-	.align		8
-panicstring:
-	.asciz		"Stack overflow\n"
-	.align		8
-ovstack:
-	.skip		OVSTACKSIZE
-#endif
 	.text
 	.align		32
 	.globl		_mcount
@@ -35,65 +20,6 @@ ovstack:
 	.type		mcount,#function
 _mcount:
 mcount:
-#ifdef CONFIG_STACK_DEBUG
-	/*
-	 * Check whether %sp is dangerously low.
-	 */
-	ldub		[%g6 + TI_FPDEPTH], %g1
-	srl		%g1, 1, %g3
-	add		%g3, 1, %g3
-	sllx		%g3, 8, %g3			! each fpregs frame is 256b
-	add		%g3, 192, %g3
-	add		%g6, %g3, %g3			! where does task_struct+frame end?
-	sub		%g3, STACK_BIAS, %g3
-	cmp		%sp, %g3
-	bg,pt		%xcc, 1f
-	 nop
-	lduh		[%g6 + TI_CPU], %g1
-	sethi		%hi(hardirq_stack), %g3
-	or		%g3, %lo(hardirq_stack), %g3
-	sllx		%g1, 3, %g1
-	ldx		[%g3 + %g1], %g7
-	sub		%g7, STACK_BIAS, %g7
-	cmp		%sp, %g7
-	bleu,pt		%xcc, 2f
-	 sethi		%hi(THREAD_SIZE), %g3
-	add		%g7, %g3, %g7
-	cmp		%sp, %g7
-	blu,pn		%xcc, 1f
-2:	 sethi		%hi(softirq_stack), %g3
-	or		%g3, %lo(softirq_stack), %g3
-	ldx		[%g3 + %g1], %g7
-	sub		%g7, STACK_BIAS, %g7
-	cmp		%sp, %g7
-	bleu,pt		%xcc, 3f
-	 sethi		%hi(THREAD_SIZE), %g3
-	add		%g7, %g3, %g7
-	cmp		%sp, %g7
-	blu,pn		%xcc, 1f
-	 nop
-	/* If we are already on ovstack, don't hop onto it
-	 * again, we are already trying to output the stack overflow
-	 * message.
-	 */
-3:	sethi		%hi(ovstack), %g7		! cant move to panic stack fast enough
-	 or		%g7, %lo(ovstack), %g7
-	add		%g7, OVSTACKSIZE, %g3
-	sub		%g3, STACK_BIAS + 192, %g3
-	sub		%g7, STACK_BIAS, %g7
-	cmp		%sp, %g7
-	blu,pn		%xcc, 2f
-	 cmp		%sp, %g3
-	bleu,pn		%xcc, 1f
-	 nop
-2:	mov		%g3, %sp
-	sethi		%hi(panicstring), %g3
-	call		prom_printf
-	 or		%g3, %lo(panicstring), %o0
-	call		prom_halt
-	 nop
-1:
-#endif
 #ifdef CONFIG_FUNCTION_TRACER
 #ifdef CONFIG_DYNAMIC_FTRACE
 	/* Do nothing, the retl/nop below is all we need.  */
-- 
1.7.0.4

