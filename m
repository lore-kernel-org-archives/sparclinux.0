From: David Miller <davem@davemloft.net>
Date: Wed, 16 Aug 2017 04:30:12 +0000
Subject: Re: [sparc64] kernel OOPS with gcc 7.1 / 7.2
Message-Id: <20170815.213012.1915139092516231059.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqw4Qomu0n2k0hC4to-wp9GW8FR_k290sD6HmTXbgmBa0A@mail.gmail.com>
In-Reply-To: <CADxRZqw4Qomu0n2k0hC4to-wp9GW8FR_k290sD6HmTXbgmBa0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Anatoly Pugachev <matorola@gmail.com>
Date: Tue, 15 Aug 2017 21:50:45 +0300

> Together with Dmitry (ldv) , we've discovered that running test suite
> from strace produces kernel OOPS, when kernel is compiled with gcc 7.1
> or with gcc 7.2 , but not with gcc 6 :

Please try this patch:

diff --git a/arch/sparc/lib/multi3.S b/arch/sparc/lib/multi3.S
index d6b6c97..703127a 100644
--- a/arch/sparc/lib/multi3.S
+++ b/arch/sparc/lib/multi3.S
@@ -5,26 +5,26 @@
 	.align	4
 ENTRY(__multi3) /* %o0 = u, %o1 = v */
 	mov	%o1, %g1
-	srl	%o3, 0, %g4
-	mulx	%g4, %g1, %o1
+	srl	%o3, 0, %o4
+	mulx	%o4, %g1, %o1
 	srlx	%g1, 0x20, %g3
-	mulx	%g3, %g4, %g5
-	sllx	%g5, 0x20, %o5
-	srl	%g1, 0, %g4
+	mulx	%g3, %o4, %g7
+	sllx	%g7, 0x20, %o5
+	srl	%g1, 0, %o4
 	sub	%o1, %o5, %o5
 	srlx	%o5, 0x20, %o5
-	addcc	%g5, %o5, %g5
+	addcc	%g7, %o5, %g7
 	srlx	%o3, 0x20, %o5
-	mulx	%g4, %o5, %g4
+	mulx	%o4, %o5, %o4
 	mulx	%g3, %o5, %o5
 	sethi	%hi(0x80000000), %g3
-	addcc	%g5, %g4, %g5
-	srlx	%g5, 0x20, %g5
+	addcc	%g7, %o4, %g7
+	srlx	%g7, 0x20, %g7
 	add	%g3, %g3, %g3
 	movcc	%xcc, %g0, %g3
-	addcc	%o5, %g5, %o5
-	sllx	%g4, 0x20, %g4
-	add	%o1, %g4, %o1
+	addcc	%o5, %g7, %o5
+	sllx	%o4, 0x20, %o4
+	add	%o1, %o4, %o1
 	add	%o5, %g3, %g2
 	mulx	%g1, %o2, %g1
 	add	%g1, %g2, %g1
