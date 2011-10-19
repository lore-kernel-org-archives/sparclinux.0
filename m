From: David Miller <davem@davemloft.net>
Date: Wed, 19 Oct 2011 22:44:25 +0000
Subject: [PATCH 3/3] sparc32: Correct the return value of memcpy.
Message-Id: <20111019.184425.145807140541223467.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Properly return the original destination buffer pointer.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/lib/memcpy.S |   22 +++++++---------------
 1 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/arch/sparc/lib/memcpy.S b/arch/sparc/lib/memcpy.S
index 90a5988..4d8c497 100644
--- a/arch/sparc/lib/memcpy.S
+++ b/arch/sparc/lib/memcpy.S
@@ -13,14 +13,6 @@
 	.align	4;		\
 x:
 
-
-/* In kernel these functions don't return a value.
- * One should use macros in asm/string.h for that purpose.
- * We return 0, so that bugs are more apparent.
- */
-#define SETUP_RETL
-#define RETL_INSN	clr	%o0
-
 /* Both these macros have to start with exactly the same insn */
 #define MOVE_BIGCHUNK(src, dst, offset, t0, t1, t2, t3, t4, t5, t6, t7) \
 	ldd	[%src + (offset) + 0x00], %t0; \
@@ -154,7 +146,7 @@ FUNC(__memmove)
 #endif
 FUNC(memmove)
 	cmp		%o0, %o1
-	SETUP_RETL
+	mov		%o0, %g7
 	bleu		9f
 	 sub		%o0, %o1, %o4
 
@@ -178,7 +170,7 @@ FUNC(memmove)
 	 sub		%o0, 1, %o0
 
 	retl
-	 RETL_INSN
+	 mov		%g7, %o0
 
 /* NOTE: This code is executed just for the cases,
          where %src (=%o1) & 3 is != 0.
@@ -212,7 +204,7 @@ FUNC(memmove)
 FUNC(memcpy)	/* %o0=dst %o1=src %o2=len */
 
 	sub		%o0, %o1, %o4
-	SETUP_RETL
+	mov		%o0, %g7
 9:
 	andcc		%o4, 3, %o5
 0:
@@ -308,7 +300,7 @@ FUNC(memcpy)	/* %o0=dst %o1=src %o2=len */
 	stb		%g2, [%o0]
 1:
 	retl
- 	 RETL_INSN
+	 mov		%g7, %o0
 
 82:	/* ldd_std */
 	MOVE_BIGALIGNCHUNK(o1, o0, 0x00, o2, o3, o4, o5, g2, g3, g4, g5)
@@ -373,7 +365,7 @@ FUNC(memcpy)	/* %o0=dst %o1=src %o2=len */
 	stb		%g2, [%o0]
 1:
 	retl
- 	 RETL_INSN
+	 mov		%g7, %o0
 
 86:	/* non_aligned */
 	cmp		%o2, 6
@@ -498,7 +490,7 @@ FUNC(memcpy)	/* %o0=dst %o1=src %o2=len */
 	stb		%g2, [%i0 + 4]
 1:
 	ret
-	 restore	%g0, %g0, %o0
+	 restore	%g7, %g0, %o0
 
 88:	/* short_end */
 
@@ -529,7 +521,7 @@ FUNC(memcpy)	/* %o0=dst %o1=src %o2=len */
 	stb		%g2, [%o0]
 1:
 	retl
- 	 RETL_INSN
+	 mov		%g7, %o0
 
 90:	/* short_aligned_end */
 	bne		88b
-- 
1.7.6.401.g6a319

