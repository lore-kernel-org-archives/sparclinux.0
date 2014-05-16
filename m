From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 16 May 2014 21:25:47 +0000
Subject: [PATCH 09/34] sparc64: remove cast from output constraints in math asm statements
Message-Id: <1400275572-17424-9-git-send-email-sam@ravnborg.org>
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
warnings in math_64.c.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/math-emu/sfp-util_64.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/math-emu/sfp-util_64.h b/arch/sparc/math-emu/sfp-util_64.h
index 425d3cf..51320a8 100644
--- a/arch/sparc/math-emu/sfp-util_64.h
+++ b/arch/sparc/math-emu/sfp-util_64.h
@@ -17,8 +17,8 @@
   	   "bcs,a,pn %%xcc, 1f\n\t"		\
   	   "add %0, 1, %0\n"			\
   	   "1:"					\
-	   : "=r" ((UDItype)(sh)),		\
-	     "=&r" ((UDItype)(sl))		\
+	   : "=r" (sh),				\
+	     "=&r" (sl)				\
 	   : "r" ((UDItype)(ah)),		\
 	     "r" ((UDItype)(bh)),		\
 	     "r" ((UDItype)(al)),		\
@@ -31,8 +31,8 @@
   	   "bcs,a,pn %%xcc, 1f\n\t"		\
   	   "sub %0, 1, %0\n"			\
   	   "1:"					\
-	   : "=r" ((UDItype)(sh)),		\
-	     "=&r" ((UDItype)(sl))		\
+	   : "=r" (sh),				\
+	     "=&r" (sl)				\
 	   : "r" ((UDItype)(ah)),		\
 	     "r" ((UDItype)(bh)),		\
 	     "r" ((UDItype)(al)),		\
@@ -64,8 +64,8 @@
 		   "sllx %3,32,%3\n\t"			\
 		   "add %1,%3,%1\n\t"			\
 		   "add %5,%2,%0"			\
-	   : "=r" ((UDItype)(wh)),			\
-	     "=&r" ((UDItype)(wl)),			\
+	   : "=r" (wh),					\
+	     "=&r" (wl),				\
 	     "=&r" (tmp1), "=&r" (tmp2), "=&r" (tmp3), "=&r" (tmp4) \
 	   : "r" ((UDItype)(u)),			\
 	     "r" ((UDItype)(v))				\
-- 
1.9.0

