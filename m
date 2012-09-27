From: David Miller <davem@davemloft.net>
Date: Thu, 27 Sep 2012 08:12:10 +0000
Subject: [PATCH] sparc64: Fix return value of Niagara-2 memcpy.
Message-Id: <20120927.041210.2193850545094055315.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


It gets clobbered by the kernel's VISEntryHalf, so we have to save it
in a different register than the set clobbered by that macro.

The instance in glibc is OK and doesn't have this problem.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/lib/NG2memcpy.S |   46 ++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/sparc/lib/NG2memcpy.S b/arch/sparc/lib/NG2memcpy.S
index 03eadf6..2c20ad6 100644
--- a/arch/sparc/lib/NG2memcpy.S
+++ b/arch/sparc/lib/NG2memcpy.S
@@ -14,7 +14,7 @@
 #define FPRS_FEF  0x04
 #ifdef MEMCPY_DEBUG
 #define VISEntryHalf rd %fprs, %o5; wr %g0, FPRS_FEF, %fprs; \
-		     clr %g1; clr %g2; clr %g3; subcc %g0, %g0, %g0;
+		     clr %g1; clr %g2; clr %g3; clr %g5; subcc %g0, %g0, %g0;
 #define VISExitHalf and %o5, FPRS_FEF, %o5; wr %o5, 0x0, %fprs
 #else
 #define VISEntryHalf rd %fprs, %o5; wr %g0, FPRS_FEF, %fprs
@@ -182,13 +182,13 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	cmp		%g2, 0
 	tne		%xcc, 5
 	PREAMBLE
-	mov		%o0, GLOBAL_SPARE
+	mov		%o0, %o3
 	cmp		%o2, 0
 	be,pn		%XCC, 85f
-	 or		%o0, %o1, %o3
+	 or		%o0, %o1, GLOBAL_SPARE
 	cmp		%o2, 16
 	blu,a,pn	%XCC, 80f
-	 or		%o3, %o2, %o3
+	 or		GLOBAL_SPARE, %o2, GLOBAL_SPARE
 
 	/* 2 blocks (128 bytes) is the minimum we can do the block
 	 * copy with.  We need to ensure that we'll iterate at least
@@ -202,7 +202,7 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	 */
 	cmp		%o2, (4 * 64)
 	blu,pt		%XCC, 75f
-	 andcc		%o3, 0x7, %g0
+	 andcc		GLOBAL_SPARE, 0x7, %g0
 
 	/* %o0:	dst
 	 * %o1:	src
@@ -404,13 +404,13 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	 * over. If anything is left, we copy it one byte at a time.
 	 */
 	brz,pt		%o2, 85f
-	 sub		%o0, %o1, %o3
+	 sub		%o0, %o1, GLOBAL_SPARE
 	ba,a,pt		%XCC, 90f
 
 	.align		64
 75: /* 16 < len <= 64 */
 	bne,pn		%XCC, 75f
-	 sub		%o0, %o1, %o3
+	 sub		%o0, %o1, GLOBAL_SPARE
 
 72:
 	andn		%o2, 0xf, %o4
@@ -420,9 +420,9 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	add		%o1, 0x08, %o1
 	EX_LD(LOAD(ldx, %o1, %g1))
 	sub		%o1, 0x08, %o1
-	EX_ST(STORE(stx, %o5, %o1 + %o3))
+	EX_ST(STORE(stx, %o5, %o1 + GLOBAL_SPARE))
 	add		%o1, 0x8, %o1
-	EX_ST(STORE(stx, %g1, %o1 + %o3))
+	EX_ST(STORE(stx, %g1, %o1 + GLOBAL_SPARE))
 	bgu,pt		%XCC, 1b
 	 add		%o1, 0x8, %o1
 73:	andcc		%o2, 0x8, %g0
@@ -430,14 +430,14 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	 nop
 	sub		%o2, 0x8, %o2
 	EX_LD(LOAD(ldx, %o1, %o5))
-	EX_ST(STORE(stx, %o5, %o1 + %o3))
+	EX_ST(STORE(stx, %o5, %o1 + GLOBAL_SPARE))
 	add		%o1, 0x8, %o1
 1:	andcc		%o2, 0x4, %g0
 	be,pt		%XCC, 1f
 	 nop
 	sub		%o2, 0x4, %o2
 	EX_LD(LOAD(lduw, %o1, %o5))
-	EX_ST(STORE(stw, %o5, %o1 + %o3))
+	EX_ST(STORE(stw, %o5, %o1 + GLOBAL_SPARE))
 	add		%o1, 0x4, %o1
 1:	cmp		%o2, 0
 	be,pt		%XCC, 85f
@@ -454,11 +454,11 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 
 1:	subcc		%g1, 1, %g1
 	EX_LD(LOAD(ldub, %o1, %o5))
-	EX_ST(STORE(stb, %o5, %o1 + %o3))
+	EX_ST(STORE(stb, %o5, %o1 + GLOBAL_SPARE))
 	bgu,pt		%icc, 1b
 	 add		%o1, 1, %o1
 
-2:	add		%o1, %o3, %o0
+2:	add		%o1, GLOBAL_SPARE, %o0
 	andcc		%o1, 0x7, %g1
 	bne,pt		%icc, 8f
 	 sll		%g1, 3, %g1
@@ -468,16 +468,16 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	 nop
 	ba,a,pt		%xcc, 73b
 
-8:	mov		64, %o3
+8:	mov		64, GLOBAL_SPARE
 	andn		%o1, 0x7, %o1
 	EX_LD(LOAD(ldx, %o1, %g2))
-	sub		%o3, %g1, %o3
+	sub		GLOBAL_SPARE, %g1, GLOBAL_SPARE
 	andn		%o2, 0x7, %o4
 	sllx		%g2, %g1, %g2
 1:	add		%o1, 0x8, %o1
 	EX_LD(LOAD(ldx, %o1, %g3))
 	subcc		%o4, 0x8, %o4
-	srlx		%g3, %o3, %o5
+	srlx		%g3, GLOBAL_SPARE, %o5
 	or		%o5, %g2, %o5
 	EX_ST(STORE(stx, %o5, %o0))
 	add		%o0, 0x8, %o0
@@ -489,32 +489,32 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	be,pn		%icc, 85f
 	 add		%o1, %g1, %o1
 	ba,pt		%xcc, 90f
-	 sub		%o0, %o1, %o3
+	 sub		%o0, %o1, GLOBAL_SPARE
 
 	.align		64
 80: /* 0 < len <= 16 */
-	andcc		%o3, 0x3, %g0
+	andcc		GLOBAL_SPARE, 0x3, %g0
 	bne,pn		%XCC, 90f
-	 sub		%o0, %o1, %o3
+	 sub		%o0, %o1, GLOBAL_SPARE
 
 1:
 	subcc		%o2, 4, %o2
 	EX_LD(LOAD(lduw, %o1, %g1))
-	EX_ST(STORE(stw, %g1, %o1 + %o3))
+	EX_ST(STORE(stw, %g1, %o1 + GLOBAL_SPARE))
 	bgu,pt		%XCC, 1b
 	 add		%o1, 4, %o1
 
 85:	retl
-	 mov		EX_RETVAL(GLOBAL_SPARE), %o0
+	 mov		EX_RETVAL(%o3), %o0
 
 	.align		32
 90:
 	subcc		%o2, 1, %o2
 	EX_LD(LOAD(ldub, %o1, %g1))
-	EX_ST(STORE(stb, %g1, %o1 + %o3))
+	EX_ST(STORE(stb, %g1, %o1 + GLOBAL_SPARE))
 	bgu,pt		%XCC, 90b
 	 add		%o1, 1, %o1
 	retl
-	 mov		EX_RETVAL(GLOBAL_SPARE), %o0
+	 mov		EX_RETVAL(%o3), %o0
 
 	.size		FUNC_NAME, .-FUNC_NAME
-- 
1.7.10.4

