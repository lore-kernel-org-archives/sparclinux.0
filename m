From: David Miller <davem@davemloft.net>
Date: Thu, 19 Aug 2010 00:41:54 +0000
Subject: Re: [PATCH] sparc64: simple microoptimizations for atomic functions
Message-Id: <20100818.174154.258123903.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.1008181402450.9287@hs20-bc2-1.build.redhat.com>
In-Reply-To: <Pine.LNX.4.64.1008181402450.9287@hs20-bc2-1.build.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Wed, 18 Aug 2010 17:16:28 -0700 (PDT)

> From: Mikulas Patocka <mpatocka@redhat.com>
> Date: Wed, 18 Aug 2010 19:44:05 -0400 (EDT)
>=20
>> They are not:
>> 0000000000000000 <atomic_add>:
>> 0000000000000028 <atomic_sub>:
>> 0000000000000050 <atomic_add_ret>:
>> 000000000000007c <atomic_sub_ret>:
>> 00000000000000a8 <atomic64_add>:
>> 00000000000000d0 <atomic64_sub>:
>> 00000000000000f8 <atomic64_add_ret>:
>> 0000000000000124 <atomic64_sub_ret>:
>>=20
>> (on UP compile without backoff). That dummy backoff code produces jump=20
>> forward and backward.
>=20
> That's a bug, it should be just an empty macro expansion.

Ok, something like this:

sparc64: Make lock backoff really a NOP on UP builds.

As noticed by Mikulas Patocka, the backoff macros don't
completely nop out for UP builds, we still get a
branch always and a delay slot nop.

Fix this by making the branch to the backoff spin loop
selective, then we can nop out the spin loop completely.

Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/arch/sparc/include/asm/backoff.h b/arch/sparc/include/asm/back=
off.h
index fa1fdf6..db3af0d 100644
--- a/arch/sparc/include/asm/backoff.h
+++ b/arch/sparc/include/asm/backoff.h
@@ -8,6 +8,9 @@
 #define BACKOFF_SETUP(reg)	\
 	mov	1, reg
=20
+#define BACKOFF_LABEL(spin_label, continue_label) \
+	spin_label
+
 #define BACKOFF_SPIN(reg, tmp, label)	\
 	mov	reg, tmp; \
 88:	brnz,pt	tmp, 88b; \
@@ -22,9 +25,11 @@
 #else
=20
 #define BACKOFF_SETUP(reg)
-#define BACKOFF_SPIN(reg, tmp, label) \
-	ba,pt	%xcc, label; \
-	 nop;
+
+#define BACKOFF_LABEL(spin_label, continue_label) \
+	continue_label
+
+#define BACKOFF_SPIN(reg, tmp, label)
=20
 #endif
=20
diff --git a/arch/sparc/lib/atomic_64.S b/arch/sparc/lib/atomic_64.S
index 0268210..5da1665 100644
--- a/arch/sparc/lib/atomic_64.S
+++ b/arch/sparc/lib/atomic_64.S
@@ -21,7 +21,7 @@ atomic_add: /* %o0 =3D increment, %o1 =3D atomic_ptr */
 	add	%g1, %o0, %g7
 	cas	[%o1], %g1, %g7
 	cmp	%g1, %g7
-	bne,pn	%icc, 2f
+	bne,pn	%icc, BACKOFF_LABEL(2f, 1b)
 	 nop
 	retl
 	 nop
@@ -36,7 +36,7 @@ atomic_sub: /* %o0 =3D decrement, %o1 =3D atomic_ptr */
 	sub	%g1, %o0, %g7
 	cas	[%o1], %g1, %g7
 	cmp	%g1, %g7
-	bne,pn	%icc, 2f
+	bne,pn	%icc, BACKOFF_LABEL(2f, 1b)
 	 nop
 	retl
 	 nop
@@ -51,7 +51,7 @@ atomic_add_ret: /* %o0 =3D increment, %o1 =3D atomic_ptr =
*/
 	add	%g1, %o0, %g7
 	cas	[%o1], %g1, %g7
 	cmp	%g1, %g7
-	bne,pn	%icc, 2f
+	bne,pn	%icc, BACKOFF_LABEL(2f, 1b)
 	 add	%g7, %o0, %g7
 	sra	%g7, 0, %o0
 	retl
@@ -67,7 +67,7 @@ atomic_sub_ret: /* %o0 =3D decrement, %o1 =3D atomic_ptr =
*/
 	sub	%g1, %o0, %g7
 	cas	[%o1], %g1, %g7
 	cmp	%g1, %g7
-	bne,pn	%icc, 2f
+	bne,pn	%icc, BACKOFF_LABEL(2f, 1b)
 	 sub	%g7, %o0, %g7
 	sra	%g7, 0, %o0
 	retl
@@ -83,7 +83,7 @@ atomic64_add: /* %o0 =3D increment, %o1 =3D atomic_ptr */
 	add	%g1, %o0, %g7
 	casx	[%o1], %g1, %g7
 	cmp	%g1, %g7
-	bne,pn	%xcc, 2f
+	bne,pn	%xcc, BACKOFF_LABEL(2f, 1b)
 	 nop
 	retl
 	 nop
@@ -98,7 +98,7 @@ atomic64_sub: /* %o0 =3D decrement, %o1 =3D atomic_ptr */
 	sub	%g1, %o0, %g7
 	casx	[%o1], %g1, %g7
 	cmp	%g1, %g7
-	bne,pn	%xcc, 2f
+	bne,pn	%xcc, BACKOFF_LABEL(2f, 1b)
 	 nop
 	retl
 	 nop
@@ -113,7 +113,7 @@ atomic64_add_ret: /* %o0 =3D increment, %o1 =3D atomic_=
ptr */
 	add	%g1, %o0, %g7
 	casx	[%o1], %g1, %g7
 	cmp	%g1, %g7
-	bne,pn	%xcc, 2f
+	bne,pn	%xcc, BACKOFF_LABEL(2f, 1b)
 	 add	%g7, %o0, %g7
 	mov	%g7, %o0
 	retl
@@ -129,7 +129,7 @@ atomic64_sub_ret: /* %o0 =3D decrement, %o1 =3D atomic_=
ptr */
 	sub	%g1, %o0, %g7
 	casx	[%o1], %g1, %g7
 	cmp	%g1, %g7
-	bne,pn	%xcc, 2f
+	bne,pn	%xcc, BACKOFF_LABEL(2f, 1b)
 	 sub	%g7, %o0, %g7
 	mov	%g7, %o0
 	retl
diff --git a/arch/sparc/lib/bitops.S b/arch/sparc/lib/bitops.S
index 2b7228c..3dc61d5 100644
--- a/arch/sparc/lib/bitops.S
+++ b/arch/sparc/lib/bitops.S
@@ -22,7 +22,7 @@ test_and_set_bit:	/* %o0=3Dnr, %o1=ADdr */
 	or	%g7, %o2, %g1
 	casx	[%o1], %g7, %g1
 	cmp	%g7, %g1
-	bne,pn	%xcc, 2f
+	bne,pn	%xcc, BACKOFF_LABEL(2f, 1b)
 	 and	%g7, %o2, %g2
 	clr	%o0
 	movrne	%g2, 1, %o0
@@ -45,7 +45,7 @@ test_and_clear_bit:	/* %o0=3Dnr, %o1=ADdr */
 	andn	%g7, %o2, %g1
 	casx	[%o1], %g7, %g1
 	cmp	%g7, %g1
-	bne,pn	%xcc, 2f
+	bne,pn	%xcc, BACKOFF_LABEL(2f, 1b)
 	 and	%g7, %o2, %g2
 	clr	%o0
 	movrne	%g2, 1, %o0
@@ -68,7 +68,7 @@ test_and_change_bit:	/* %o0=3Dnr, %o1=ADdr */
 	xor	%g7, %o2, %g1
 	casx	[%o1], %g7, %g1
 	cmp	%g7, %g1
-	bne,pn	%xcc, 2f
+	bne,pn	%xcc, BACKOFF_LABEL(2f, 1b)
 	 and	%g7, %o2, %g2
 	clr	%o0
 	movrne	%g2, 1, %o0
@@ -91,7 +91,7 @@ set_bit:		/* %o0=3Dnr, %o1=ADdr */
 	or	%g7, %o2, %g1
 	casx	[%o1], %g7, %g1
 	cmp	%g7, %g1
-	bne,pn	%xcc, 2f
+	bne,pn	%xcc, BACKOFF_LABEL(2f, 1b)
 	 nop
 	retl
 	 nop
@@ -112,7 +112,7 @@ clear_bit:		/* %o0=3Dnr, %o1=ADdr */
 	andn	%g7, %o2, %g1
 	casx	[%o1], %g7, %g1
 	cmp	%g7, %g1
-	bne,pn	%xcc, 2f
+	bne,pn	%xcc, BACKOFF_LABEL(2f, 1b)
 	 nop
 	retl
 	 nop
@@ -133,7 +133,7 @@ change_bit:		/* %o0=3Dnr, %o1=ADdr */
 	xor	%g7, %o2, %g1
 	casx	[%o1], %g7, %g1
 	cmp	%g7, %g1
-	bne,pn	%xcc, 2f
+	bne,pn	%xcc, BACKOFF_LABEL(2f, 1b)
 	 nop
 	retl
 	 nop
