From: Mikulas Patocka <mpatocka@redhat.com>
Date: Wed, 18 Aug 2010 18:03:37 +0000
Subject: [PATCH] sparc64: simple microoptimizations for atomic functions
Message-Id: <Pine.LNX.4.64.1008181402450.9287@hs20-bc2-1.build.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Simple microoptimizations for sparc64 atomic functions:
Save one instruction by using a delay slot.
Use %g1 instead of %g7, because %g1 is written earlier.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 arch/sparc/lib/atomic_64.S |   20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

Index: linux-2.6.35-preempt/arch/sparc/lib/atomic_64.S
=================================--- linux-2.6.35-preempt.orig/arch/sparc/lib/atomic_64.S	2010-08-18 15:10:47.000000000 +0200
+++ linux-2.6.35-preempt/arch/sparc/lib/atomic_64.S	2010-08-18 19:40:25.000000000 +0200
@@ -52,10 +52,9 @@ atomic_add_ret: /* %o0 = increment, %o1 
 	cas	[%o1], %g1, %g7
 	cmp	%g1, %g7
 	bne,pn	%icc, 2f
-	 add	%g7, %o0, %g7
-	sra	%g7, 0, %o0
+	 add	%g1, %o0, %g1
 	retl
-	 nop
+	 sra	%g1, 0, %o0
 2:	BACKOFF_SPIN(%o2, %o3, 1b)
 	.size	atomic_add_ret, .-atomic_add_ret
 
@@ -68,10 +67,9 @@ atomic_sub_ret: /* %o0 = decrement, %o1 
 	cas	[%o1], %g1, %g7
 	cmp	%g1, %g7
 	bne,pn	%icc, 2f
-	 sub	%g7, %o0, %g7
-	sra	%g7, 0, %o0
+	 sub	%g1, %o0, %g1
 	retl
-	 nop
+	 sra	%g1, 0, %o0
 2:	BACKOFF_SPIN(%o2, %o3, 1b)
 	.size	atomic_sub_ret, .-atomic_sub_ret
 
@@ -114,10 +112,9 @@ atomic64_add_ret: /* %o0 = increment, %o
 	casx	[%o1], %g1, %g7
 	cmp	%g1, %g7
 	bne,pn	%xcc, 2f
-	 add	%g7, %o0, %g7
-	mov	%g7, %o0
-	retl
 	 nop
+	retl
+	 add	%g1, %o0, %o0
 2:	BACKOFF_SPIN(%o2, %o3, 1b)
 	.size	atomic64_add_ret, .-atomic64_add_ret
 
@@ -130,9 +127,8 @@ atomic64_sub_ret: /* %o0 = decrement, %o
 	casx	[%o1], %g1, %g7
 	cmp	%g1, %g7
 	bne,pn	%xcc, 2f
-	 sub	%g7, %o0, %g7
-	mov	%g7, %o0
-	retl
 	 nop
+	retl
+	 sub	%g1, %o0, %o0
 2:	BACKOFF_SPIN(%o2, %o3, 1b)
 	.size	atomic64_sub_ret, .-atomic64_sub_ret

