From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 16 May 2014 21:25:46 +0000
Subject: [PATCH 08/34] sparc32: remove cast from output constraints in math asm statements
Message-Id: <1400275572-17424-8-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The following asm statements generated a sparse warning:

        asm("addcc \n\t" : "=r" (((USItype)(r2)))

warning: asm output is not an lvalue

When asking on the sparse mailing list Linus replyed:

"
Those casts to (USItype) are all pointless to begin with (since the
values are of that type already!) and they mean that the expression
isn't something you can assign to (lvalue).
"

In the math emulation code drop all casts in the output
parts of the asm statements.

This fixes a lot of "warning: asm output is not an lvalue" sparse
warnings in math_32.c.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/sfp-machine_32.h | 28 ++++++++++++++--------------
 arch/sparc/math-emu/sfp-util_32.h       | 20 ++++++++++----------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/sparc/include/asm/sfp-machine_32.h b/arch/sparc/include/asm/sfp-machine_32.h
index 01d9c3b..838c9d5 100644
--- a/arch/sparc/include/asm/sfp-machine_32.h
+++ b/arch/sparc/include/asm/sfp-machine_32.h
@@ -79,9 +79,9 @@
   __asm__ ("addcc %r7,%8,%2\n\t"					\
 	   "addxcc %r5,%6,%1\n\t"					\
 	   "addx %r3,%4,%0\n"						\
-	   : "=r" ((USItype)(r2)),					\
-	     "=&r" ((USItype)(r1)),					\
-	     "=&r" ((USItype)(r0))					\
+	   : "=r" (r2),							\
+	     "=&r" (r1),						\
+	     "=&r" (r0)							\
 	   : "%rJ" ((USItype)(x2)),					\
 	     "rI" ((USItype)(y2)),					\
 	     "%rJ" ((USItype)(x1)),					\
@@ -94,9 +94,9 @@
   __asm__ ("subcc %r7,%8,%2\n\t"					\
 	    "subxcc %r5,%6,%1\n\t"					\
 	    "subx %r3,%4,%0\n"						\
-	   : "=r" ((USItype)(r2)),					\
-	     "=&r" ((USItype)(r1)),					\
-	     "=&r" ((USItype)(r0))					\
+	   : "=r" (r2),							\
+	     "=&r" (r1),						\
+	     "=&r" (r0)							\
 	   : "%rJ" ((USItype)(x2)),					\
 	     "rI" ((USItype)(y2)),					\
 	     "%rJ" ((USItype)(x1)),					\
@@ -115,8 +115,8 @@
 	    "addxcc %r6,%7,%0\n\t"					\
 	    "addxcc %r4,%5,%%g2\n\t"					\
 	    "addx %r2,%3,%%g1\n\t"					\
-	   : "=&r" ((USItype)(r1)),					\
-	     "=&r" ((USItype)(r0))					\
+	   : "=&r" (r1),						\
+	     "=&r" (r0)							\
 	   : "%rJ" ((USItype)(x3)),					\
 	     "rI" ((USItype)(y3)),					\
 	     "%rJ" ((USItype)(x2)),					\
@@ -140,8 +140,8 @@
 	    "subxcc %r6,%7,%0\n\t"					\
 	    "subxcc %r4,%5,%%g2\n\t"					\
 	    "subx %r2,%3,%%g1\n\t"					\
-	   : "=&r" ((USItype)(r1)),					\
-	     "=&r" ((USItype)(r0))					\
+	   : "=&r" (r1),						\
+	     "=&r" (r0)							\
 	   : "%rJ" ((USItype)(x3)),					\
 	     "rI" ((USItype)(y3)),					\
 	     "%rJ" ((USItype)(x2)),					\
@@ -164,10 +164,10 @@
 	   "addxcc %2,%%g0,%2\n\t"					\
 	   "addxcc %1,%%g0,%1\n\t"					\
 	   "addx %0,%%g0,%0\n\t"					\
-	   : "=&r" ((USItype)(x3)),					\
-	     "=&r" ((USItype)(x2)),					\
-	     "=&r" ((USItype)(x1)),					\
-	     "=&r" ((USItype)(x0))					\
+	   : "=&r" (x3),						\
+	     "=&r" (x2),						\
+	     "=&r" (x1),						\
+	     "=&r" (x0)							\
 	   : "rI" ((USItype)(i)),					\
 	     "0" ((USItype)(x3)),					\
 	     "1" ((USItype)(x2)),					\
diff --git a/arch/sparc/math-emu/sfp-util_32.h b/arch/sparc/math-emu/sfp-util_32.h
index d1b2aff..bb587d5 100644
--- a/arch/sparc/math-emu/sfp-util_32.h
+++ b/arch/sparc/math-emu/sfp-util_32.h
@@ -4,20 +4,20 @@
 #include <asm/byteorder.h>
 
 #define add_ssaaaa(sh, sl, ah, al, bh, bl) 				\
-  __asm__ ("addcc %r4,%5,%1\n\t"						\
+  __asm__ ("addcc %r4,%5,%1\n\t"					\
 	   "addx %r2,%3,%0\n"						\
-	   : "=r" ((USItype)(sh)),					\
-	     "=&r" ((USItype)(sl))					\
+	   : "=r" (sh),							\
+	     "=&r" (sl)							\
 	   : "%rJ" ((USItype)(ah)),					\
 	     "rI" ((USItype)(bh)),					\
 	     "%rJ" ((USItype)(al)),					\
 	     "rI" ((USItype)(bl))					\
 	   : "cc")
 #define sub_ddmmss(sh, sl, ah, al, bh, bl) 				\
-  __asm__ ("subcc %r4,%5,%1\n\t"						\
+  __asm__ ("subcc %r4,%5,%1\n\t"					\
 	   "subx %r2,%3,%0\n"						\
-	   : "=r" ((USItype)(sh)),					\
-	     "=&r" ((USItype)(sl))					\
+	   : "=r" (sh),							\
+	     "=&r" (sl)							\
 	   : "rJ" ((USItype)(ah)),					\
 	     "rI" ((USItype)(bh)),					\
 	     "rJ" ((USItype)(al)),					\
@@ -65,8 +65,8 @@
 	"mulscc	%%g1,0,%%g1\n\t" 					\
 	"add	%%g1,%%g2,%0\n\t" 					\
 	"rd	%%y,%1\n"						\
-	   : "=r" ((USItype)(w1)),					\
-	     "=r" ((USItype)(w0))					\
+	   : "=r" (w1),							\
+	     "=r" (w0)							\
 	   : "%rI" ((USItype)(u)),					\
 	     "r" ((USItype)(v))						\
 	   : "%g1", "%g2", "cc")
@@ -98,8 +98,8 @@
 	   "sub	%1,%2,%1\n\t"						\
 	   "3:	xnor	%0,0,%0\n\t"					\
 	   "! End of inline udiv_qrnnd\n"				\
-	   : "=&r" ((USItype)(q)),					\
-	     "=&r" ((USItype)(r))					\
+	   : "=&r" (q),							\
+	     "=&r" (r)							\
 	   : "r" ((USItype)(d)),					\
 	     "1" ((USItype)(n1)),					\
 	     "0" ((USItype)(n0)) : "%g1", "cc")
-- 
1.9.0

