From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 04 Aug 2017 18:06:24 +0000
Subject: [PATCH] sparc64: update comments in U3memcpy
Message-Id: <20170804180624.GA11525@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From 07e5777f2de5a121273a7b4b8a933223f3dd813a Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 4 Aug 2017 19:59:39 +0200
Subject: [PATCH] sparc64: update comments in U3memcpy

Update comments about the range the different
parts of the code copies, the original comments were wrong.

Introduce a few descriptive labels too.

No functional changes.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

No code fixes, so this is -next material.
And this is anyway code that is seldomly touched.

I had added the comments while trying to understand
the bug where the return value was wrong.
So let next reader benefits from these.

	Sam

 arch/sparc/lib/U3memcpy.S | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/arch/sparc/lib/U3memcpy.S b/arch/sparc/lib/U3memcpy.S
index 54f98706b03b..df9fab8d99b6 100644
--- a/arch/sparc/lib/U3memcpy.S
+++ b/arch/sparc/lib/U3memcpy.S
@@ -168,18 +168,25 @@ ENDPROC(U3_retl_o2_and_7_plus_GS_plus_8)
 FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	srlx		%o2, 31, %g2
 	cmp		%g2, 0
+
+	/* software trap 5 "Range Check" if dst >= 0x80000000 */
 	tne		%xcc, 5
 	PREAMBLE
 	mov		%o0, %o4
+
+	/* if len = 0 */
 	cmp		%o2, 0
-	be,pn		%XCC, 85f
+	be,pn		%XCC, end_return
 	 or		%o0, %o1, %o3
+
+	/* if len < 16 */
 	cmp		%o2, 16
-	blu,a,pn	%XCC, 80f
+	blu,a,pn	%XCC, less_than_16
 	 or		%o3, %o2, %o3
 
+	/* if len < 192 */
 	cmp		%o2, (3 * 64)
-	blu,pt		%XCC, 70f
+	blu,pt		%XCC, less_than_192
 	 andcc		%o3, 0x7, %g0
 
 	/* Clobbers o5/g1/g2/g3/g7/icc/xcc.  We must preserve
@@ -362,7 +369,7 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	cmp		%o2, 0
 	add		%o1, %g1, %o1
 	VISExitHalf
-	be,pn		%XCC, 85f
+	be,pn		%XCC, end_return
 	 sub		%o0, %o1, %o3
 
 	andcc		%g1, 0x7, %g0
@@ -392,14 +399,15 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	sub		%o2, 2, %o2
 
 1:	andcc		%o2, 0x1, %g0
-	be,pt		%icc, 85f
+	be,pt		%icc, end_return
 	 nop
 	EX_LD(LOAD(ldub, %o1, %o5), U3_retl_o2)
-	ba,pt		%xcc, 85f
+	ba,pt		%xcc, end_return
 	 EX_ST(STORE(stb, %o5, %o1 + %o3), U3_retl_o2)
 
 	.align		64
-70: /* 16 < len <= 64 */
+	/* 16 <= len < 192 */
+less_than_192:
 	bne,pn		%XCC, 75f
 	 sub		%o0, %o1, %o3
 
@@ -429,7 +437,7 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	EX_ST(STORE(stw, %o5, %o1 + %o3), U3_retl_o2_plus_4)
 	add		%o1, 0x4, %o1
 1:	cmp		%o2, 0
-	be,pt		%XCC, 85f
+	be,pt		%XCC, end_return
 	 nop
 	ba,pt		%xcc, 90f
 	 nop
@@ -475,13 +483,14 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 
 	srl		%g1, 3, %g1
 	andcc		%o2, 0x7, %o2
-	be,pn		%icc, 85f
+	be,pn		%icc, end_return
 	 add		%o1, %g1, %o1
 	ba,pt		%xcc, 90f
 	 sub		%o0, %o1, %o3
 
 	.align		64
-80: /* 0 < len <= 16 */
+	/* 0 < len < 16 */
+less_than_16:
 	andcc		%o3, 0x3, %g0
 	bne,pn		%XCC, 90f
 	 sub		%o0, %o1, %o3
@@ -493,7 +502,8 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	bgu,pt		%XCC, 1b
 	 add		%o1, 4, %o1
 
-85:	retl
+end_return:
+	retl
 	 mov		EX_RETVAL(%o4), %o0
 
 	.align		32
-- 
2.12.0

