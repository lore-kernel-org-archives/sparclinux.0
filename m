From: David Miller <davem@davemloft.net>
Date: Sat, 12 May 2012 03:38:38 +0000
Subject: [PATCH] sparc: Convert some assembler over to linakge.h's ENTRY/ENDPROC
Message-Id: <20120511.233838.2278295689559437915.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org



Use those, instead of doing it all by hand.

Signed-off-by: David S. Miller <davem@davemloft.net>
---

I've slowly tried to convert these things over to the saner
annotations, I kept it to the simplest cases.

I purposely avoided things like the software integer multiply
and divide because we may be removing those soon.

 arch/sparc/lib/ashldi3.S              |    7 +++--
 arch/sparc/lib/ashrdi3.S              |    7 +++--
 arch/sparc/lib/atomic_64.S            |   49 +++++++++++------------------=
---
 arch/sparc/lib/bitops.S               |   37 +++++++++---------------
 arch/sparc/lib/blockops.S             |   10 +++----
 arch/sparc/lib/bzero.S                |   20 ++++++-------
 arch/sparc/lib/ipcsum.S               |    9 +++---
 arch/sparc/lib/lshrdi3.S              |    5 ++--
 arch/sparc/lib/memmove.S              |    9 +++---
 arch/sparc/lib/strlen_user_64.S       |    8 ++++--
 arch/sparc/lib/strncmp_32.S           |    7 +++--
 arch/sparc/lib/strncmp_64.S           |    8 ++----
 arch/sparc/lib/strncpy_from_user_32.S |    6 ++--
 arch/sparc/lib/strncpy_from_user_64.S |    8 ++----
 arch/sparc/lib/xor.S                  |   50 +++++++++++------------------=
----
 15 files changed, 97 insertions(+), 143 deletions(-)

diff --git a/arch/sparc/lib/ashldi3.S b/arch/sparc/lib/ashldi3.S
index 17912e6..86f60de 100644
--- a/arch/sparc/lib/ashldi3.S
+++ b/arch/sparc/lib/ashldi3.S
@@ -5,10 +5,10 @@
  * Copyright (C) 1999 David S. Miller (davem@redhat.com)
  */
=20
+#include <linux/linkage.h>
+
 	.text
-	.align	4
-	.globl	__ashldi3
-__ashldi3:
+ENTRY(__ashldi3)
 	cmp	%o2, 0
 	be	9f
 	 mov	0x20, %g2
@@ -32,3 +32,4 @@ __ashldi3:
 9:
 	retl
 	 nop
+ENDPROC(__ashldi3)
diff --git a/arch/sparc/lib/ashrdi3.S b/arch/sparc/lib/ashrdi3.S
index 85398fd6..6eb8ba2 100644
--- a/arch/sparc/lib/ashrdi3.S
+++ b/arch/sparc/lib/ashrdi3.S
@@ -5,10 +5,10 @@
  * Copyright (C) 1995 David S. Miller (davem@caip.rutgers.edu)
  */
=20
+#include <linux/linkage.h>
+
 	.text
-	.align	4
-	.globl __ashrdi3
-__ashrdi3:
+ENTRY(__ashrdi3)
 	tst	%o2
 	be	3f
 	 or	%g0, 32, %g2
@@ -34,3 +34,4 @@ __ashrdi3:
 3:
 	jmpl	%o7 + 8, %g0
 	 nop
+ENDPROC(__ashrdi3)
diff --git a/arch/sparc/lib/atomic_64.S b/arch/sparc/lib/atomic_64.S
index 59186e0..4d502da 100644
--- a/arch/sparc/lib/atomic_64.S
+++ b/arch/sparc/lib/atomic_64.S
@@ -3,6 +3,7 @@
  * Copyright (C) 1999, 2007 David S. Miller (davem@davemloft.net)
  */
=20
+#include <linux/linkage.h>
 #include <asm/asi.h>
 #include <asm/backoff.h>
=20
@@ -13,9 +14,7 @@
 	 * memory barriers, and a second which returns
 	 * a value and does the barriers.
 	 */
-	.globl	atomic_add
-	.type	atomic_add,#function
-atomic_add: /* %o0 =3D increment, %o1 =3D atomic_ptr */
+ENTRY(atomic_add) /* %o0 =3D increment, %o1 =3D atomic_ptr */
 	BACKOFF_SETUP(%o2)
 1:	lduw	[%o1], %g1
 	add	%g1, %o0, %g7
@@ -26,11 +25,9 @@ atomic_add: /* %o0 =3D increment, %o1 =3D atomic_ptr */
 	retl
 	 nop
 2:	BACKOFF_SPIN(%o2, %o3, 1b)
-	.size	atomic_add, .-atomic_add
+ENDPROC(atomic_add)
=20
-	.globl	atomic_sub
-	.type	atomic_sub,#function
-atomic_sub: /* %o0 =3D decrement, %o1 =3D atomic_ptr */
+ENTRY(atomic_sub) /* %o0 =3D decrement, %o1 =3D atomic_ptr */
 	BACKOFF_SETUP(%o2)
 1:	lduw	[%o1], %g1
 	sub	%g1, %o0, %g7
@@ -41,11 +38,9 @@ atomic_sub: /* %o0 =3D decrement, %o1 =3D atomic_ptr */
 	retl
 	 nop
 2:	BACKOFF_SPIN(%o2, %o3, 1b)
-	.size	atomic_sub, .-atomic_sub
+ENDPROC(atomic_sub)
=20
-	.globl	atomic_add_ret
-	.type	atomic_add_ret,#function
-atomic_add_ret: /* %o0 =3D increment, %o1 =3D atomic_ptr */
+ENTRY(atomic_add_ret) /* %o0 =3D increment, %o1 =3D atomic_ptr */
 	BACKOFF_SETUP(%o2)
 1:	lduw	[%o1], %g1
 	add	%g1, %o0, %g7
@@ -56,11 +51,9 @@ atomic_add_ret: /* %o0 =3D increment, %o1 =3D atomic_ptr=
 */
 	retl
 	 sra	%g1, 0, %o0
 2:	BACKOFF_SPIN(%o2, %o3, 1b)
-	.size	atomic_add_ret, .-atomic_add_ret
+ENDPROC(atomic_add_ret)
=20
-	.globl	atomic_sub_ret
-	.type	atomic_sub_ret,#function
-atomic_sub_ret: /* %o0 =3D decrement, %o1 =3D atomic_ptr */
+ENTRY(atomic_sub_ret) /* %o0 =3D decrement, %o1 =3D atomic_ptr */
 	BACKOFF_SETUP(%o2)
 1:	lduw	[%o1], %g1
 	sub	%g1, %o0, %g7
@@ -71,11 +64,9 @@ atomic_sub_ret: /* %o0 =3D decrement, %o1 =3D atomic_ptr=
 */
 	retl
 	 sra	%g1, 0, %o0
 2:	BACKOFF_SPIN(%o2, %o3, 1b)
-	.size	atomic_sub_ret, .-atomic_sub_ret
+ENDPROC(atomic_sub_ret)
=20
-	.globl	atomic64_add
-	.type	atomic64_add,#function
-atomic64_add: /* %o0 =3D increment, %o1 =3D atomic_ptr */
+ENTRY(atomic64_add) /* %o0 =3D increment, %o1 =3D atomic_ptr */
 	BACKOFF_SETUP(%o2)
 1:	ldx	[%o1], %g1
 	add	%g1, %o0, %g7
@@ -86,11 +77,9 @@ atomic64_add: /* %o0 =3D increment, %o1 =3D atomic_ptr */
 	retl
 	 nop
 2:	BACKOFF_SPIN(%o2, %o3, 1b)
-	.size	atomic64_add, .-atomic64_add
+ENDPROC(atomic64_add)
=20
-	.globl	atomic64_sub
-	.type	atomic64_sub,#function
-atomic64_sub: /* %o0 =3D decrement, %o1 =3D atomic_ptr */
+ENTRY(atomic64_sub) /* %o0 =3D decrement, %o1 =3D atomic_ptr */
 	BACKOFF_SETUP(%o2)
 1:	ldx	[%o1], %g1
 	sub	%g1, %o0, %g7
@@ -101,11 +90,9 @@ atomic64_sub: /* %o0 =3D decrement, %o1 =3D atomic_ptr =
*/
 	retl
 	 nop
 2:	BACKOFF_SPIN(%o2, %o3, 1b)
-	.size	atomic64_sub, .-atomic64_sub
+ENDPROC(atomic64_sub)
=20
-	.globl	atomic64_add_ret
-	.type	atomic64_add_ret,#function
-atomic64_add_ret: /* %o0 =3D increment, %o1 =3D atomic_ptr */
+ENTRY(atomic64_add_ret) /* %o0 =3D increment, %o1 =3D atomic_ptr */
 	BACKOFF_SETUP(%o2)
 1:	ldx	[%o1], %g1
 	add	%g1, %o0, %g7
@@ -116,11 +103,9 @@ atomic64_add_ret: /* %o0 =3D increment, %o1 =3D atomic=
_ptr */
 	retl
 	 add	%g1, %o0, %o0
 2:	BACKOFF_SPIN(%o2, %o3, 1b)
-	.size	atomic64_add_ret, .-atomic64_add_ret
+ENDPROC(atomic64_add_ret)
=20
-	.globl	atomic64_sub_ret
-	.type	atomic64_sub_ret,#function
-atomic64_sub_ret: /* %o0 =3D decrement, %o1 =3D atomic_ptr */
+ENTRY(atomic64_sub_ret) /* %o0 =3D decrement, %o1 =3D atomic_ptr */
 	BACKOFF_SETUP(%o2)
 1:	ldx	[%o1], %g1
 	sub	%g1, %o0, %g7
@@ -131,4 +116,4 @@ atomic64_sub_ret: /* %o0 =3D decrement, %o1 =3D atomic_=
ptr */
 	retl
 	 sub	%g1, %o0, %o0
 2:	BACKOFF_SPIN(%o2, %o3, 1b)
-	.size	atomic64_sub_ret, .-atomic64_sub_ret
+ENDPROC(atomic64_sub_ret)
diff --git a/arch/sparc/lib/bitops.S b/arch/sparc/lib/bitops.S
index 3dc61d5..36f72cc 100644
--- a/arch/sparc/lib/bitops.S
+++ b/arch/sparc/lib/bitops.S
@@ -3,14 +3,13 @@
  * Copyright (C) 2000, 2007 David S. Miller (davem@davemloft.net)
  */
=20
+#include <linux/linkage.h>
 #include <asm/asi.h>
 #include <asm/backoff.h>
=20
 	.text
=20
-	.globl	test_and_set_bit
-	.type	test_and_set_bit,#function
-test_and_set_bit:	/* %o0=3Dnr, %o1=ADdr */
+ENTRY(test_and_set_bit)	/* %o0=3Dnr, %o1=ADdr */
 	BACKOFF_SETUP(%o3)
 	srlx	%o0, 6, %g1
 	mov	1, %o2
@@ -29,11 +28,9 @@ test_and_set_bit:	/* %o0=3Dnr, %o1=ADdr */
 	retl
 	 nop
 2:	BACKOFF_SPIN(%o3, %o4, 1b)
-	.size	test_and_set_bit, .-test_and_set_bit
+ENDPROC(test_and_set_bit)
=20
-	.globl	test_and_clear_bit
-	.type	test_and_clear_bit,#function
-test_and_clear_bit:	/* %o0=3Dnr, %o1=ADdr */
+ENTRY(test_and_clear_bit) /* %o0=3Dnr, %o1=ADdr */
 	BACKOFF_SETUP(%o3)
 	srlx	%o0, 6, %g1
 	mov	1, %o2
@@ -52,11 +49,9 @@ test_and_clear_bit:	/* %o0=3Dnr, %o1=ADdr */
 	retl
 	 nop
 2:	BACKOFF_SPIN(%o3, %o4, 1b)
-	.size	test_and_clear_bit, .-test_and_clear_bit
+ENDPROC(test_and_clear_bit)
=20
-	.globl	test_and_change_bit
-	.type	test_and_change_bit,#function
-test_and_change_bit:	/* %o0=3Dnr, %o1=ADdr */
+ENTRY(test_and_change_bit) /* %o0=3Dnr, %o1=ADdr */
 	BACKOFF_SETUP(%o3)
 	srlx	%o0, 6, %g1
 	mov	1, %o2
@@ -75,11 +70,9 @@ test_and_change_bit:	/* %o0=3Dnr, %o1=ADdr */
 	retl
 	 nop
 2:	BACKOFF_SPIN(%o3, %o4, 1b)
-	.size	test_and_change_bit, .-test_and_change_bit
+ENDPROC(test_and_change_bit)
=20
-	.globl	set_bit
-	.type	set_bit,#function
-set_bit:		/* %o0=3Dnr, %o1=ADdr */
+ENTRY(set_bit) /* %o0=3Dnr, %o1=ADdr */
 	BACKOFF_SETUP(%o3)
 	srlx	%o0, 6, %g1
 	mov	1, %o2
@@ -96,11 +89,9 @@ set_bit:		/* %o0=3Dnr, %o1=ADdr */
 	retl
 	 nop
 2:	BACKOFF_SPIN(%o3, %o4, 1b)
-	.size	set_bit, .-set_bit
+ENDPROC(set_bit)
=20
-	.globl	clear_bit
-	.type	clear_bit,#function
-clear_bit:		/* %o0=3Dnr, %o1=ADdr */
+ENTRY(clear_bit) /* %o0=3Dnr, %o1=ADdr */
 	BACKOFF_SETUP(%o3)
 	srlx	%o0, 6, %g1
 	mov	1, %o2
@@ -117,11 +108,9 @@ clear_bit:		/* %o0=3Dnr, %o1=ADdr */
 	retl
 	 nop
 2:	BACKOFF_SPIN(%o3, %o4, 1b)
-	.size	clear_bit, .-clear_bit
+ENDPROC(clear_bit)
=20
-	.globl	change_bit
-	.type	change_bit,#function
-change_bit:		/* %o0=3Dnr, %o1=ADdr */
+ENTRY(change_bit) /* %o0=3Dnr, %o1=ADdr */
 	BACKOFF_SETUP(%o3)
 	srlx	%o0, 6, %g1
 	mov	1, %o2
@@ -138,4 +127,4 @@ change_bit:		/* %o0=3Dnr, %o1=ADdr */
 	retl
 	 nop
 2:	BACKOFF_SPIN(%o3, %o4, 1b)
-	.size	change_bit, .-change_bit
+ENDPROC(change_bit)
diff --git a/arch/sparc/lib/blockops.S b/arch/sparc/lib/blockops.S
index 804be87..3c77101 100644
--- a/arch/sparc/lib/blockops.S
+++ b/arch/sparc/lib/blockops.S
@@ -4,6 +4,7 @@
  * Copyright (C) 1996 David S. Miller (davem@caip.rutgers.edu)
  */
=20
+#include <linux/linkage.h>
 #include <asm/page.h>
=20
 	/* Zero out 64 bytes of memory at (buf + offset).
@@ -44,10 +45,7 @@
 	 */
=20
 	.text
-	.align	4
-	.globl	bzero_1page, __copy_1page
-
-bzero_1page:
+ENTRY(bzero_1page)
 /* NOTE: If you change the number of insns of this routine, please check
  * arch/sparc/mm/hypersparc.S */
 	/* %o0 =3D buf */
@@ -65,8 +63,9 @@ bzero_1page:
=20
 	retl
 	 nop
+ENDPROC(bzero_1page)
=20
-__copy_1page:
+ENTRY(__copy_1page)
 /* NOTE: If you change the number of insns of this routine, please check
  * arch/sparc/mm/hypersparc.S */
 	/* %o0 =3D dst, %o1 =3D src */
@@ -87,3 +86,4 @@ __copy_1page:
=20
 	retl
 	 nop
+ENDPROC(__copy_1page)
diff --git a/arch/sparc/lib/bzero.S b/arch/sparc/lib/bzero.S
index 615f401..8c05811 100644
--- a/arch/sparc/lib/bzero.S
+++ b/arch/sparc/lib/bzero.S
@@ -4,11 +4,11 @@
  * Copyright (C) 2005 David S. Miller <davem@davemloft.net>
  */
=20
+#include <linux/linkage.h>
+
 	.text
=20
-	.globl	memset
-	.type	memset, #function
-memset:			/* %o0=3Dbuf, %o1=3Dpat, %o2=3Dlen */
+ENTRY(memset) /* %o0=3Dbuf, %o1=3Dpat, %o2=3Dlen */
 	and		%o1, 0xff, %o3
 	mov		%o2, %o1
 	sllx		%o3, 8, %g1
@@ -19,9 +19,7 @@ memset:			/* %o0=3Dbuf, %o1=3Dpat, %o2=3Dlen */
 	ba,pt		%xcc, 1f
 	 or		%g1, %o2, %o2
=20
-	.globl	__bzero
-	.type	__bzero, #function
-__bzero:		/* %o0=3Dbuf, %o1=3Dlen */
+ENTRY(__bzero) /* %o0=3Dbuf, %o1=3Dlen */
 	clr		%o2
 1:	mov		%o0, %o3
 	brz,pn		%o1, __bzero_done
@@ -78,8 +76,8 @@ __bzero_tiny:
 __bzero_done:
 	retl
 	 mov		%o3, %o0
-	.size		__bzero, .-__bzero
-	.size		memset, .-memset
+ENDPROC(__bzero)
+ENDPROC(memset)
=20
 #define EX_ST(x,y)		\
 98:	x,y;			\
@@ -89,9 +87,7 @@ __bzero_done:
 	.text;			\
 	.align 4;
=20
-	.globl	__clear_user
-	.type	__clear_user, #function
-__clear_user:		/* %o0=3Dbuf, %o1=3Dlen */
+ENTRY(__clear_user) /* %o0=3Dbuf, %o1=3Dlen */
 	brz,pn		%o1, __clear_user_done
 	 cmp		%o1, 16
 	bl,pn		%icc, __clear_user_tiny
@@ -146,4 +142,4 @@ __clear_user_tiny:
 __clear_user_done:
 	retl
 	 clr		%o0
-	.size		__clear_user, .-__clear_user
+ENDPROC(__clear_user)
diff --git a/arch/sparc/lib/ipcsum.S b/arch/sparc/lib/ipcsum.S
index 58ca5b9..4742d59 100644
--- a/arch/sparc/lib/ipcsum.S
+++ b/arch/sparc/lib/ipcsum.S
@@ -1,8 +1,7 @@
+#include <linux/linkage.h>
+
 	.text
-	.align	32
-	.globl	ip_fast_csum
-	.type	ip_fast_csum,#function
-ip_fast_csum:	/* %o0 =3D iph, %o1 =3D ihl */
+ENTRY(ip_fast_csum) /* %o0 =3D iph, %o1 =3D ihl */
 	sub	%o1, 4, %g7
 	lduw	[%o0 + 0x00], %o2
 	lduw	[%o0 + 0x04], %g2
@@ -31,4 +30,4 @@ ip_fast_csum:	/* %o0 =3D iph, %o1 =3D ihl */
 	set	0xffff, %o1
 	retl
 	 and	%o2, %o1, %o0
-	.size	ip_fast_csum, .-ip_fast_csum
+ENDPROC(ip_fast_csum)
diff --git a/arch/sparc/lib/lshrdi3.S b/arch/sparc/lib/lshrdi3.S
index 47a1354..60ebc7c 100644
--- a/arch/sparc/lib/lshrdi3.S
+++ b/arch/sparc/lib/lshrdi3.S
@@ -1,6 +1,6 @@
+#include <linux/linkage.h>
=20
-	.globl	__lshrdi3
-__lshrdi3:
+ENTRY(__lshrdi3)
 	cmp	%o2, 0
 	be	3f
 	 mov	0x20, %g2
@@ -24,3 +24,4 @@ __lshrdi3:
 3:
 	retl=20
 	 nop=20
+ENDPROC(__lshrdi3)
diff --git a/arch/sparc/lib/memmove.S b/arch/sparc/lib/memmove.S
index 9739580..b7f6334 100644
--- a/arch/sparc/lib/memmove.S
+++ b/arch/sparc/lib/memmove.S
@@ -4,11 +4,10 @@
  * Copyright (C) 1996, 1997, 1998, 1999 Jakub Jelinek (jj@ultra.linux.cz)
  */
=20
+#include <linux/linkage.h>
+
 	.text
-	.align		32
-	.globl		memmove
-	.type		memmove,#function
-memmove:		/* o0=3Ddst o1=3Dsrc o2=3Dlen */
+ENTRY(memmove) /* o0=3Ddst o1=3Dsrc o2=3Dlen */
 	mov		%o0, %g1
 	cmp		%o0, %o1
 	bleu,pt		%xcc, memcpy
@@ -28,4 +27,4 @@ memmove:		/* o0=3Ddst o1=3Dsrc o2=3Dlen */
=20
 	retl
 	 mov		%g1, %o0
-	.size		memmove, .-memmove
+ENDPROC(memmove)
diff --git a/arch/sparc/lib/strlen_user_64.S b/arch/sparc/lib/strlen_user_6=
4.S
index 114ed11..c3df71f 100644
--- a/arch/sparc/lib/strlen_user_64.S
+++ b/arch/sparc/lib/strlen_user_64.S
@@ -8,16 +8,16 @@
  * Copyright (C) 1996,1997 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
  */
=20
+#include <linux/linkage.h>
 #include <asm/asi.h>
=20
 #define LO_MAGIC 0x01010101
 #define HI_MAGIC 0x80808080
=20
 	.align 4
-	.global __strlen_user, __strnlen_user
-__strlen_user:
+ENTRY(__strlen_user)
 	sethi	%hi(32768), %o1
-__strnlen_user:=09
+ENTRY(__strnlen_user)
 	mov	%o1, %g1
 	mov	%o0, %o1
 	andcc	%o0, 3, %g0
@@ -78,6 +78,8 @@ __strnlen_user:
 	 mov	2, %o0
 23:	retl
 	 mov	3, %o0
+ENDPROC(__strlen_user)
+ENDPROC(__strnlen_user)
=20
         .section .fixup,#alloc,#execinstr
         .align  4
diff --git a/arch/sparc/lib/strncmp_32.S b/arch/sparc/lib/strncmp_32.S
index 1476f57..c0d1b56 100644
--- a/arch/sparc/lib/strncmp_32.S
+++ b/arch/sparc/lib/strncmp_32.S
@@ -3,10 +3,10 @@
  *            generic strncmp routine.
  */
=20
+#include <linux/linkage.h>
+
 	.text
-	.align 4
-	.global strncmp
-strncmp:
+ENTRY(strncmp)
 	mov	%o0, %g3
 	mov	0, %o3
=20
@@ -115,3 +115,4 @@ strncmp:
 	and	%g2, 0xff, %o0
 	retl
 	 sub	%o3, %o0, %o0
+ENDPROC(strncmp)
diff --git a/arch/sparc/lib/strncmp_64.S b/arch/sparc/lib/strncmp_64.S
index 980e837..0656627 100644
--- a/arch/sparc/lib/strncmp_64.S
+++ b/arch/sparc/lib/strncmp_64.S
@@ -4,13 +4,11 @@
  * Copyright (C) 1997 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
  */
=20
+#include <linux/linkage.h>
 #include <asm/asi.h>
=20
 	.text
-	.align	32
-	.globl	strncmp
-	.type	strncmp,#function
-strncmp:
+ENTRY(strncmp)
 	brlez,pn %o2, 3f
 	 lduba	[%o0] (ASI_PNF), %o3
 1:
@@ -29,4 +27,4 @@ strncmp:
 3:
 	retl
 	 clr	%o0
-	.size	strncmp, .-strncmp
+ENDPROC(strncmp)
diff --git a/arch/sparc/lib/strncpy_from_user_32.S b/arch/sparc/lib/strncpy=
_from_user_32.S
index d771989..db0ed29 100644
--- a/arch/sparc/lib/strncpy_from_user_32.S
+++ b/arch/sparc/lib/strncpy_from_user_32.S
@@ -3,11 +3,11 @@
  *  Copyright(C) 1996 David S. Miller
  */
=20
+#include <linux/linkage.h>
 #include <asm/ptrace.h>
 #include <asm/errno.h>
=20
 	.text
-	.align	4
=20
 	/* Must return:
 	 *
@@ -16,8 +16,7 @@
 	 * bytes copied		if we hit a null byte
 	 */
=20
-	.globl	__strncpy_from_user
-__strncpy_from_user:
+ENTRY(__strncpy_from_user)
 	/* %o0=DEst, %o1=3Dsrc, %o2=3Dcount */
 	mov	%o2, %o3
 1:
@@ -35,6 +34,7 @@ __strncpy_from_user:
 	add	%o2, 1, %o0
 	retl
 	 sub	%o3, %o0, %o0
+ENDPROC(__strncpy_from_user)
=20
 	.section .fixup,#alloc,#execinstr
 	.align	4
diff --git a/arch/sparc/lib/strncpy_from_user_64.S b/arch/sparc/lib/strncpy=
_from_user_64.S
index 511c8f1..d1246b7 100644
--- a/arch/sparc/lib/strncpy_from_user_64.S
+++ b/arch/sparc/lib/strncpy_from_user_64.S
@@ -4,6 +4,7 @@
  *  Copyright (C) 1997, 1999 Jakub Jelinek (jj@ultra.linux.cz)
  */
=20
+#include <linux/linkage.h>
 #include <asm/asi.h>
 #include <asm/errno.h>
=20
@@ -12,7 +13,6 @@
 0:	.xword	0x0101010101010101
=20
 	.text
-	.align	32
=20
 	/* Must return:
 	 *
@@ -30,9 +30,7 @@
 	 * and average length is 18 or so.
 	 */
=20
-	.globl	__strncpy_from_user
-	.type	__strncpy_from_user,#function
-__strncpy_from_user:
+ENTRY(__strncpy_from_user)
 	/* %o0=DEst, %o1=3Dsrc, %o2=3Dcount */
 	andcc	%o1, 7, %g0		! IEU1	Group
 	bne,pn	%icc, 30f		! CTI
@@ -123,7 +121,7 @@ __strncpy_from_user:
 	 mov	%o2, %o0
 2:	retl
 	 add	%o2, %o3, %o0
-	.size	__strncpy_from_user, .-__strncpy_from_user
+ENDPROC(__strncpy_from_user)
=20
 	.section __ex_table,"a"
 	.align	4
diff --git a/arch/sparc/lib/xor.S b/arch/sparc/lib/xor.S
index f44f58f..2c05641 100644
--- a/arch/sparc/lib/xor.S
+++ b/arch/sparc/lib/xor.S
@@ -8,6 +8,7 @@
  * Copyright (C) 2006 David S. Miller <davem@davemloft.net>
  */
=20
+#include <linux/linkage.h>
 #include <asm/visasm.h>
 #include <asm/asi.h>
 #include <asm/dcu.h>
@@ -19,12 +20,9 @@
  *	!(len & 127) && len >=3D 256
  */
 	.text
-	.align	32
=20
 	/* VIS versions. */
-	.globl	xor_vis_2
-	.type	xor_vis_2,#function
-xor_vis_2:
+ENTRY(xor_vis_2)
 	rd	%fprs, %o5
 	andcc	%o5, FPRS_FEF|FPRS_DU, %g0
 	be,pt	%icc, 0f
@@ -91,11 +89,9 @@ xor_vis_2:
 	wr	%g1, %g0, %asi
 	retl
 	  wr	%g0, 0, %fprs
-	.size	xor_vis_2, .-xor_vis_2
+ENDPROC(xor_vis_2)
=20
-	.globl	xor_vis_3
-	.type	xor_vis_3,#function
-xor_vis_3:
+ENTRY(xor_vis_3)
 	rd	%fprs, %o5
 	andcc	%o5, FPRS_FEF|FPRS_DU, %g0
 	be,pt	%icc, 0f
@@ -159,11 +155,9 @@ xor_vis_3:
 	wr	%g1, %g0, %asi
 	retl
 	 wr	%g0, 0, %fprs
-	.size	xor_vis_3, .-xor_vis_3
+ENDPROC(xor_vis_3)
=20
-	.globl	xor_vis_4
-	.type	xor_vis_4,#function
-xor_vis_4:
+ENTRY(xor_vis_4)
 	rd	%fprs, %o5
 	andcc	%o5, FPRS_FEF|FPRS_DU, %g0
 	be,pt	%icc, 0f
@@ -246,11 +240,9 @@ xor_vis_4:
 	wr	%g1, %g0, %asi
 	retl
 	 wr	%g0, 0, %fprs
-	.size	xor_vis_4, .-xor_vis_4
+ENDPROC(xor_vis_4)
=20
-	.globl	xor_vis_5
-	.type	xor_vis_5,#function
-xor_vis_5:
+ENTRY(xor_vis_5)
 	save	%sp, -192, %sp
 	rd	%fprs, %o5
 	andcc	%o5, FPRS_FEF|FPRS_DU, %g0
@@ -354,12 +346,10 @@ xor_vis_5:
 	wr	%g0, 0, %fprs
 	ret
 	 restore
-	.size	xor_vis_5, .-xor_vis_5
+ENDPROC(xor_vis_5)
=20
 	/* Niagara versions. */
-	.globl		xor_niagara_2
-	.type		xor_niagara_2,#function
-xor_niagara_2:		/* %o0=3Dbytes, %o1=DEst, %o2=3Dsrc */
+ENTRY(xor_niagara_2) /* %o0=3Dbytes, %o1=DEst, %o2=3Dsrc */
 	save		%sp, -192, %sp
 	prefetch	[%i1], #n_writes
 	prefetch	[%i2], #one_read
@@ -402,11 +392,9 @@ xor_niagara_2:		/* %o0=3Dbytes, %o1=DEst, %o2=3Dsrc */
 	wr		%g7, 0x0, %asi
 	ret
 	 restore
-	.size		xor_niagara_2, .-xor_niagara_2
+ENDPROC(xor_niagara_2)
=20
-	.globl		xor_niagara_3
-	.type		xor_niagara_3,#function
-xor_niagara_3:		/* %o0=3Dbytes, %o1=DEst, %o2=3Dsrc1, %o3=3Dsrc2 */
+ENTRY(xor_niagara_3) /* %o0=3Dbytes, %o1=DEst, %o2=3Dsrc1, %o3=3Dsrc2 */
 	save		%sp, -192, %sp
 	prefetch	[%i1], #n_writes
 	prefetch	[%i2], #one_read
@@ -465,11 +453,9 @@ xor_niagara_3:		/* %o0=3Dbytes, %o1=DEst, %o2=3Dsrc1, =
%o3=3Dsrc2 */
 	wr		%g7, 0x0, %asi
 	ret
 	 restore
-	.size		xor_niagara_3, .-xor_niagara_3
+ENDPROC(xor_niagara_3)
=20
-	.globl		xor_niagara_4
-	.type		xor_niagara_4,#function
-xor_niagara_4:		/* %o0=3Dbytes, %o1=DEst, %o2=3Dsrc1, %o3=3Dsrc2, %o4=3Dsr=
c3 */
+ENTRY(xor_niagara_4) /* %o0=3Dbytes, %o1=DEst, %o2=3Dsrc1, %o3=3Dsrc2, %o4=
=3Dsrc3 */
 	save		%sp, -192, %sp
 	prefetch	[%i1], #n_writes
 	prefetch	[%i2], #one_read
@@ -549,11 +535,9 @@ xor_niagara_4:		/* %o0=3Dbytes, %o1=DEst, %o2=3Dsrc1, =
%o3=3Dsrc2, %o4=3Dsrc3 */
 	wr		%g7, 0x0, %asi
 	ret
 	 restore
-	.size		xor_niagara_4, .-xor_niagara_4
+ENDPROC(xor_niagara_4)
=20
-	.globl		xor_niagara_5
-	.type		xor_niagara_5,#function
-xor_niagara_5:		/* %o0=3Dbytes, %o1=DEst, %o2=3Dsrc1, %o3=3Dsrc2, %o4=3Dsr=
c3, %o5=3Dsrc4 */
+ENTRY(xor_niagara_5) /* %o0=3Dbytes, %o1=DEst, %o2=3Dsrc1, %o3=3Dsrc2, %o4=
=3Dsrc3, %o5=3Dsrc4 */
 	save		%sp, -192, %sp
 	prefetch	[%i1], #n_writes
 	prefetch	[%i2], #one_read
@@ -649,4 +633,4 @@ xor_niagara_5:		/* %o0=3Dbytes, %o1=DEst, %o2=3Dsrc1, %=
o3=3Dsrc2, %o4=3Dsrc3, %o5=3Dsrc4 *
 	wr		%g7, 0x0, %asi
 	ret
 	 restore
-	.size		xor_niagara_5, .-xor_niagara_5
+ENDPROC(xor_niagara_5)
--=20
1.7.10

