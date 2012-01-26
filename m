From: David Miller <davem@davemloft.net>
Date: Thu, 26 Jan 2012 22:32:08 +0000
Subject: [PATCH 2/2] lib: Fix 32-bit sparc udiv_qrnnd() definition in mpilib's longlong.h
Message-Id: <20120126.173208.1656711368996825513.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, dmitry.kasatkin@intel.com, linux-kernel@vger.kernel.org


This copy of longlong.h is extremely dated and results in compile
errors on sparc32 when MPILIB is enabled, copy over the more uptodate
implementation from arch/sparc/math/sfp-util_32.h

Reported-by: Al Viro <viro@ZenIV.linux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 lib/mpi/longlong.h |   44 +++++++++++++++++++++++++++++++++-----------
 1 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/lib/mpi/longlong.h b/lib/mpi/longlong.h
index b87487b..29f9862 100644
--- a/lib/mpi/longlong.h
+++ b/lib/mpi/longlong.h
@@ -1200,18 +1200,40 @@ do { \
 	"r" ((USItype)(v)) \
 	: "%g1", "%g2" __AND_CLOBBER_CC)
 #define UMUL_TIME 39		/* 39 instructions */
-#endif
-#ifndef udiv_qrnnd
-#ifndef LONGLONG_STANDALONE
+/* It's quite necessary to add this much assembler for the sparc.
+   The default udiv_qrnnd (in C) is more than 10 times slower!  */
 #define udiv_qrnnd(q, r, n1, n0, d) \
-do { USItype __r; \
-	(q) = __udiv_qrnnd(&__r, (n1), (n0), (d)); \
-	(r) = __r; \
-} while (0)
-	extern USItype __udiv_qrnnd();
-#define UDIV_TIME 140
-#endif /* LONGLONG_STANDALONE */
-#endif /* udiv_qrnnd */
+  __asm__ ("! Inlined udiv_qrnnd\n\t"					\
+	   "mov	32,%%g1\n\t"						\
+	   "subcc	%1,%2,%%g0\n\t"					\
+	   "1:	bcs	5f\n\t"						\
+	   "addxcc %0,%0,%0	! shift n1n0 and a q-bit in lsb\n\t"	\
+	   "sub	%1,%2,%1	! this kills msb of n\n\t"		\
+	   "addx	%1,%1,%1	! so this can't give carry\n\t"	\
+	   "subcc	%%g1,1,%%g1\n\t"				\
+	   "2:	bne	1b\n\t"						\
+	   "subcc	%1,%2,%%g0\n\t"					\
+	   "bcs	3f\n\t"							\
+	   "addxcc %0,%0,%0	! shift n1n0 and a q-bit in lsb\n\t"	\
+	   "b		3f\n\t"						\
+	   "sub	%1,%2,%1	! this kills msb of n\n\t"		\
+	   "4:	sub	%1,%2,%1\n\t"					\
+	   "5:	addxcc	%1,%1,%1\n\t"					\
+	   "bcc	2b\n\t"							\
+	   "subcc	%%g1,1,%%g1\n\t"				\
+	   "! Got carry from n.  Subtract next step to cancel this carry.\n\t" \
+	   "bne	4b\n\t"							\
+	   "addcc	%0,%0,%0	! shift n1n0 and a 0-bit in lsb\n\t" \
+	   "sub	%1,%2,%1\n\t"						\
+	   "3:	xnor	%0,0,%0\n\t"					\
+	   "! End of inline udiv_qrnnd\n"				\
+	   : "=&r" ((USItype)(q)),					\
+	     "=&r" ((USItype)(r))					\
+	   : "r" ((USItype)(d)),					\
+	     "1" ((USItype)(n1)),					\
+	     "0" ((USItype)(n0)) : "%g1", "cc")
+#define UDIV_TIME (3+7*32)      /* 7 instructions/iteration. 32 iterations.  */
+#endif
 #endif /* __sparc__ */
 
 /***************************************
-- 
1.7.6.401.g6a319

