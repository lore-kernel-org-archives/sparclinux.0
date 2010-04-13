From: David Miller <davem@davemloft.net>
Date: Tue, 13 Apr 2010 06:42:56 +0000
Subject: [PATCH 6/7] sparc64: Give a stack frame to the ftrace call sites.
Message-Id: <20100412.234256.168589035.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


It's the only way we'll be able to implement the function
graph tracer properly.

A positive is that we no longer have to worry about the
linker over-optimizing the tail call, since we don't
use a tail call any more.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/lib/mcount.S |   31 ++++++++++++++++---------------
 1 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/sparc/lib/mcount.S b/arch/sparc/lib/mcount.S
index 73ed0f3..153c80e 100644
--- a/arch/sparc/lib/mcount.S
+++ b/arch/sparc/lib/mcount.S
@@ -33,9 +33,13 @@ mcount:
 	or		%g2, %lo(ftrace_stub), %g2
 	cmp		%g1, %g2
 	be,pn		%icc, 1f
-	 mov		%i7, %o1
-	jmpl		%g1, %g0
-	 mov		%o7, %o0
+	 mov		%i7, %g2
+	save		%sp, -128, %sp
+	mov		%g2, %o1
+	jmpl		%g1, %o7
+	 mov		%i7, %o0
+	ret
+	 restore
 	/* not reached */
 1:
 #endif
@@ -57,21 +61,18 @@ ftrace_stub:
 	.type		ftrace_caller,#function
 ftrace_caller:
 	sethi		%hi(function_trace_stop), %g1
-	mov		%i7, %o1
-	lduw		[%g1 + %lo(function_trace_stop)], %g2
-	brnz,pn		%g2, ftrace_stub
-	 mov		%o7, %o0
+	mov		%i7, %g2
+	lduw		[%g1 + %lo(function_trace_stop)], %g3
+	brnz,pn		%g3, ftrace_stub
+	 nop
+	save		%sp, -128, %sp
+	mov		%g2, %o1
 	.globl		ftrace_call
 ftrace_call:
-	/* If the final kernel link ever turns on relaxation, we'll need
-	 * to do something about this tail call.  Otherwise the linker
-	 * will rewrite the call into a branch and nop out the move
-	 * instruction.
-	 */
 	call		ftrace_stub
-	 mov		%o0, %o7
-	retl
-	 nop
+	 mov		%i7, %o0
+	ret
+	 restore
 	.size		ftrace_call,.-ftrace_call
 	.size		ftrace_caller,.-ftrace_caller
 #endif
-- 
1.7.0.4

