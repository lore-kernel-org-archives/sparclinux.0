From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Tue, 28 Dec 2004 22:07:37 +0000
Subject: Sparc32 long long division patch
Message-Id: <41D1D929.8090004@wp.pl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------090604060906010004020304"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------090604060906010004020304
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello to everybody,

I discovered a bug in multiply/division trap code for sun4m CPUs. This
bug comes from not quite correct register declaration for inline
assembly.  According to GCC manual , it is not enough to declare a
variable (register) as output only if it is an input variable as well. A
special definitions "0" to "9" should match input variables and output
variables. Due to this, GCC produced incorrect assembly code for muldiv
trap function and division results were incorrect. The attached patch
fixes this. I attached also a small program to test this bug.

I discovered this bug in the 2.4.27 kernel compiled with cross-compiler
x86->sparc GCC 3.3.4. I tested also kernel 2.4.28  - it also has the
bug. To my surprise, the 2.4.26 kernel does not show this bug (C code is
the same as in 2.4.27 - it works by some accident). Also, the bug does
not appear if debug information is printed from inside the muldiv
function. My guess is that a new function for calculating instruction
address put some stress on register usage which forces GCC to allocate
registers differently since kernel 2.4.27.  I  got the same results
using Gentoo GCC 3.3.3 on Sparcstation  20 (native compilation), i.e.
2.4.26 works correctly, 2.4.27 and 2.4.28 does not.

I suppose the patch should be applied to 2.6 branch as well, as it
contains the same incorrect code.

Kind regards,
Krzysztof Helt



--------------090604060906010004020304
Content-Type: text/plain;
 name="muldiv.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="muldiv.patch"

--- linux-2.4.26/arch/sparc/kernel/muldiv.c	1998-01-13 00:15:43.000000000 +0100
+++ linux-2.4.27/arch/sparc/kernel/muldiv.c	2004-12-27 19:33:18.000000000 +0100
@@ -4,6 +4,9 @@
  *
  * Copyright (C) 1996 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
  * Copyright (C) 1996 David S. Miller (davem@caip.rutgers.edu)
+ *
+ * 2004-12-25	Krzysztof Helt (krzysztof.h1@wp.pl) 
+ *		- fixed registers constrains in inline assembly declarations
  */
 
 #include <linux/kernel.h>
@@ -125,7 +128,7 @@
 			"mov	%%o0, %0\n\t"
 			"mov	%%o1, %1\n\t"
 			: "=r" (rs1), "=r" (rs2)
-		        :
+		        : "0" (rs1), "1" (rs2)
 			: "o0", "o1", "o2", "o3", "o4", "o5", "o7", "cc");
 #ifdef DEBUG_MULDIV
 		printk ("0x%x%08x\n", rs2, rs1);
@@ -145,7 +148,7 @@
 			"mov	%%o0, %0\n\t"
 			"mov	%%o1, %1\n\t"
 			: "=r" (rs1), "=r" (rs2)
-			:
+		        : "0" (rs1), "1" (rs2)
 			: "o0", "o1", "o2", "o3", "o4", "o5", "o7", "cc");
 #ifdef DEBUG_MULDIV
 		printk ("0x%x%08x\n", rs2, rs1);
@@ -174,7 +177,7 @@
 			"mov	%%o1, %0\n\t"
 			"mov	%%o0, %1\n\t"
 			: "=r" (rs1), "=r" (rs2)
-			: "r" (regs->y)
+			: "r" (regs->y), "0" (rs1), "1" (rs2)
 			: "o0", "o1", "o2", "o3", "o4", "o5", "o7",
 			  "g1", "g2", "g3", "cc");
 #ifdef DEBUG_MULDIV
@@ -203,7 +206,7 @@
 			"mov	%%o1, %0\n\t"
 			"mov	%%o0, %1\n\t"
 			: "=r" (rs1), "=r" (rs2)
-			: "r" (regs->y)
+			: "r" (regs->y), "0" (rs1), "1" (rs2)
 			: "o0", "o1", "o2", "o3", "o4", "o5", "o7",
 			  "g1", "g2", "g3", "cc");
 #ifdef DEBUG_MULDIV


--------------090604060906010004020304
Content-Type: text/plain;
 name="test_udiv.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="test_udiv.c"

typedef unsigned long USItype;
#define udiv_qrnnd(__q, __r, __n1, __n0, __d) \
  __asm__ ("mov %2,%%y;nop;nop;nop;udiv %3,%4,%0;umul %0,%4,%1;sub %3,%1,%1"\
	   : "=&r" ((USItype) (__q)),					\
	     "=&r" ((USItype) (__r))					\
	   : "r" ((USItype) (__n1)),					\
	     "r" ((USItype) (__n0)),					\
	     "r" ((USItype) (__d)))

#include <stdio.h>

int main(void)
{
	unsigned long q,r,n1,n0,d;
	n1=17293963032249958407llu>>32;
	n0=17293963032249958407llu&0xffffffffl;
	d=268189695lu;
	printf("bit 53+ : %lx\n",n1&0xfff00000l);
	udiv_qrnnd(q,r,n1,n0,d);
	printf("q,r = %lu,%lu ( r<d = %d)\n",q,r,r<d);
	if ( r == 115020282ul ) {
		printf( "test PASSED\n" );
	} else {
		printf( "FAILED\n" );
	}
	return 0;
}



--------------090604060906010004020304--
