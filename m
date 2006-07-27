From: David Miller <davem@davemloft.net>
Date: Thu, 27 Jul 2006 23:51:25 +0000
Subject: Re: sparc64 fmulq emulation glitch?
Message-Id: <20060727.165125.74748151.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200606260902.12375.rene@exactcode.de>
In-Reply-To: <200606260902.12375.rene@exactcode.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Rene Rebe <rene@exactcode.de>
Date: Mon, 26 Jun 2006 09:02:12 +0200

> int main ()
> {
>         long double a = 2;
>         long double b = 1.0;
>         a *= b;
>         printf ("%Lf\n", a);
> }
> 
> built with: gcc -m64 -mhard-quad-float
> 
> yields: 4

Something is wrong with _FP_MUL_MEAT_2_wide_3mul, which tries to
optimize the 2-limb multiply into 3 multiplies instead of 4.  None of
the other platforms utilizing the soft-fp layer in the kernel try to
use the _3mul version either.

Correctness trumps performance, so we can just use the full 4 multiply
version to fix this bug.

Thanks for the report.

diff-tree 92f282988b4ce3967ee8399f7d1184ebfa04e48b (from 64821324ca49f24be1a66f2f432108f96a24e596)
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Thu Jul 27 16:49:21 2006 -0700

    [SPARC64]: Fix quad-float multiply emulation.
    
    Something is wrong with the 3-multiply (vs. 4-multiply) optimized
    version of _FP_MUL_MEAT_2_*(), so just use the slower version
    which actually computes correct values.
    
    Noticed by Rene Rebe
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/include/asm-sparc64/sfp-machine.h b/include/asm-sparc64/sfp-machine.h
index 5015bb8..89d4243 100644
--- a/include/asm-sparc64/sfp-machine.h
+++ b/include/asm-sparc64/sfp-machine.h
@@ -34,7 +34,7 @@
 #define _FP_MUL_MEAT_D(R,X,Y)					\
   _FP_MUL_MEAT_1_wide(_FP_WFRACBITS_D,R,X,Y,umul_ppmm)
 #define _FP_MUL_MEAT_Q(R,X,Y)					\
-  _FP_MUL_MEAT_2_wide_3mul(_FP_WFRACBITS_Q,R,X,Y,umul_ppmm)
+  _FP_MUL_MEAT_2_wide(_FP_WFRACBITS_Q,R,X,Y,umul_ppmm)
 
 #define _FP_DIV_MEAT_S(R,X,Y)	_FP_DIV_MEAT_1_imm(S,R,X,Y,_FP_DIV_HELP_imm)
 #define _FP_DIV_MEAT_D(R,X,Y)	_FP_DIV_MEAT_1_udiv_norm(D,R,X,Y)
