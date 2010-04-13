From: David Miller <davem@davemloft.net>
Date: Tue, 13 Apr 2010 06:42:36 +0000
Subject: [PATCH 1/7] sparc64: Add HAVE_FUNCTION_TRACE_MCOUNT_TEST and tidy
Message-Id: <20100412.234236.175903010.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Check function_trace_stop at ftrace_caller

Toss mcount_call and dummy call of ftrace_stub, unnecessary.

Document problems we'll have if the final kernel image link
ever turns on relaxation.

Properly size 'ftrace_call' so it looks right when inspecting
instructions under gdb et al.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/Kconfig      |    1 +
 arch/sparc/lib/mcount.S |   22 +++++++++++++++-------
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 6db5136..035304c 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -37,6 +37,7 @@ config SPARC64
 	def_bool 64BIT
 	select ARCH_SUPPORTS_MSI
 	select HAVE_FUNCTION_TRACER
+	select HAVE_FUNCTION_TRACE_MCOUNT_TEST
 	select HAVE_KRETPROBES
 	select HAVE_KPROBES
 	select HAVE_LMB
diff --git a/arch/sparc/lib/mcount.S b/arch/sparc/lib/mcount.S
index 24b8b12..7047997 100644
--- a/arch/sparc/lib/mcount.S
+++ b/arch/sparc/lib/mcount.S
@@ -96,13 +96,12 @@ mcount:
 #endif
 #ifdef CONFIG_FUNCTION_TRACER
 #ifdef CONFIG_DYNAMIC_FTRACE
-	mov		%o7, %o0
-	.globl		mcount_call
-mcount_call:
-	call		ftrace_stub
-	 mov		%o0, %o7
+	/* Do nothing, the retl/nop below is all we need.  */
 #else
-	sethi		%hi(ftrace_trace_function), %g1
+	sethi		%hi(function_trace_stop), %g1
+	lduw		[%g1 + %lo(function_trace_stop)], %g2
+	brnz,pn		%g2, 1f
+	 sethi		%hi(ftrace_trace_function), %g1
 	sethi		%hi(ftrace_stub), %g2
 	ldx		[%g1 + %lo(ftrace_trace_function)], %g1
 	or		%g2, %lo(ftrace_stub), %g2
@@ -131,14 +130,23 @@ ftrace_stub:
 	.globl		ftrace_caller
 	.type		ftrace_caller,#function
 ftrace_caller:
+	sethi		%hi(function_trace_stop), %g1
 	mov		%i7, %o1
-	mov		%o7, %o0
+	lduw		[%g1 + %lo(function_trace_stop)], %g2
+	brnz,pn		%g2, ftrace_stub
+	 mov		%o7, %o0
 	.globl		ftrace_call
 ftrace_call:
+	/* If the final kernel link ever turns on relaxation, we'll need
+	 * to do something about this tail call.  Otherwise the linker
+	 * will rewrite the call into a branch and nop out the move
+	 * instruction.
+	 */
 	call		ftrace_stub
 	 mov		%o0, %o7
 	retl
 	 nop
+	.size		ftrace_call,.-ftrace_call
 	.size		ftrace_caller,.-ftrace_caller
 #endif
 #endif
-- 
1.7.0.4

