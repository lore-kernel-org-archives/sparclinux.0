Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F32EB64D7
	for <sparclinux@archiver.kernel.org>; Fri, 16 Jun 2023 15:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346014AbjFPPe4 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 16 Jun 2023 11:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346034AbjFPPex (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 16 Jun 2023 11:34:53 -0400
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [95.217.213.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93E22944
        for <sparclinux@vger.kernel.org>; Fri, 16 Jun 2023 08:34:51 -0700 (PDT)
Received: from [213.219.167.32] (helo=deadeye)
        by maynard with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1qABTO-0003Kf-2l
        for sparclinux@vger.kernel.org; Fri, 16 Jun 2023 17:34:50 +0200
Received: from ben by deadeye with local (Exim 4.96)
        (envelope-from <ben@decadent.org.uk>)
        id 1qABTN-006VW9-1o
        for sparclinux@vger.kernel.org;
        Fri, 16 Jun 2023 17:34:49 +0200
Date:   Fri, 16 Jun 2023 17:34:49 +0200
From:   Ben Hutchings <ben@decadent.org.uk>
To:     sparclinux@vger.kernel.org
Subject: [PATCH] sparc: Fix invalid .section syntax
Message-ID: <ZIyBGdriWti6AsvH@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WDyAZS9pgpLGIJQY"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 213.219.167.32
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org


--WDyAZS9pgpLGIJQY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Ben Hutchings <benh@debian.org>

gas supports several different forms for .section for ELF targets,
including:
    .section NAME [, "FLAGS"[, @TYPE[,FLAG_SPECIFIC_ARGUMENTS]]]
and:
    .section "NAME"[, #FLAGS...]

In several places we use a mix of these two forms:
    .section NAME, #FLAGS...

A current development snapshot of binutils (2.40.50.20230611) treats
this mixed syntax as an error.

Change to consistently use:
    .section NAME, "FLAGS"
as is used elsewhere in the kernel.

Also change the one correct use of:
    .section "NAME", #FLAGS
to be consistent with the rest of the kernel.

Signed-off-by: Ben Hutchings <benh@debian.org>
---
These changes are compile-tested only.

Ben.

 arch/sparc/include/asm/futex_64.h   |  4 ++--
 arch/sparc/include/asm/uaccess_32.h |  8 ++++----
 arch/sparc/include/asm/uaccess_64.h |  8 ++++----
 arch/sparc/kernel/ftrace.c          |  2 +-
 arch/sparc/kernel/head_64.S         |  2 +-
 arch/sparc/kernel/una_asm_32.S      |  4 ++--
 arch/sparc/lib/copy_user.S          | 24 ++++++++++--------------
 arch/sparc/lib/memset.S             |  2 +-
 drivers/char/adi.c                  |  4 ++--
 9 files changed, 27 insertions(+), 31 deletions(-)

diff --git a/arch/sparc/include/asm/futex_64.h b/arch/sparc/include/asm/fut=
ex_64.h
index 72de967318d7..2fbbb8ae8076 100644
--- a/arch/sparc/include/asm/futex_64.h
+++ b/arch/sparc/include/asm/futex_64.h
@@ -15,7 +15,7 @@
 	"	bne,pn	%%icc, 1b\n"			\
 	"	 mov	0, %0\n"			\
 	"3:\n"						\
-	"	.section .fixup,#alloc,#execinstr\n"	\
+	"	.section .fixup,\"ax\"\n"		\
 	"	.align	4\n"				\
 	"4:	sethi	%%hi(3b), %0\n"			\
 	"	jmpl	%0 + %%lo(3b), %%g0\n"		\
@@ -73,7 +73,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uadd=
r,
 	__asm__ __volatile__(
 	"\n1:	casa	[%4] %%asi, %3, %1\n"
 	"2:\n"
-	"	.section .fixup,#alloc,#execinstr\n"
+	"	.section .fixup,\"ax\"\n"
 	"	.align	4\n"
 	"3:	sethi	%%hi(2b), %0\n"
 	"	jmpl	%0 + %%lo(2b), %%g0\n"
diff --git a/arch/sparc/include/asm/uaccess_32.h b/arch/sparc/include/asm/u=
access_32.h
index 9fd6c53644b6..641d04000b99 100644
--- a/arch/sparc/include/asm/uaccess_32.h
+++ b/arch/sparc/include/asm/uaccess_32.h
@@ -92,13 +92,13 @@ __asm__ __volatile__(							\
 	"1:\t"	"st"#size " %1, %2\n\t"					\
 		"clr	%0\n"						\
 	"2:\n\n\t"							\
-		".section .fixup,#alloc,#execinstr\n\t"			\
+		".section .fixup,\"ax\"\n\t"				\
 		".align	4\n"						\
 	"3:\n\t"							\
 		"b	2b\n\t"						\
 		" mov	%3, %0\n\t"					\
 		".previous\n\n\t"					\
-		".section __ex_table,#alloc\n\t"			\
+		".section __ex_table,\"a\"\n\t"				\
 		".align	4\n\t"						\
 		".word	1b, 3b\n\t"					\
 		".previous\n\n\t"					\
@@ -160,14 +160,14 @@ __asm__ __volatile__(							\
 	"1:\t"	"ld"#size " %2, %1\n\t"					\
 		"clr	%0\n"						\
 	"2:\n\n\t"							\
-		".section .fixup,#alloc,#execinstr\n\t"			\
+		".section .fixup,\"ax\"\n\t"				\
 		".align	4\n"						\
 	"3:\n\t"							\
 		"clr	%1\n\t"						\
 		"b	2b\n\t"						\
 		" mov	%3, %0\n\n\t"					\
 		".previous\n\t"						\
-		".section __ex_table,#alloc\n\t"			\
+		".section __ex_table,\"a\"\n\t"				\
 		".align	4\n\t"						\
 		".word	1b, 3b\n\n\t"					\
 		".previous\n\t"						\
diff --git a/arch/sparc/include/asm/uaccess_64.h b/arch/sparc/include/asm/u=
access_64.h
index b825a5dd0210..cb1a9dae6304 100644
--- a/arch/sparc/include/asm/uaccess_64.h
+++ b/arch/sparc/include/asm/uaccess_64.h
@@ -96,7 +96,7 @@ __asm__ __volatile__(							\
 	"1:\t"	"st"#size " %1, [%2]\n\t"				\
 		"clr	%0\n"						\
 	"2:\n\n\t"							\
-		".section .fixup,#alloc,#execinstr\n\t"			\
+		".section .fixup,\"ax\"\n\t"				\
 		".align	4\n"						\
 	"3:\n\t"							\
 		"sethi	%%hi(2b), %0\n\t"				\
@@ -128,7 +128,7 @@ __asm__ __volatile__(							\
 	"1:\t"	"st"#size "a %1, [%2] %%asi\n\t"			\
 		"clr	%0\n"						\
 	"2:\n\n\t"							\
-		".section .fixup,#alloc,#execinstr\n\t"			\
+		".section .fixup,\"ax\"\n\t"				\
 		".align	4\n"						\
 	"3:\n\t"							\
 		"sethi	%%hi(2b), %0\n\t"				\
@@ -169,7 +169,7 @@ __asm__ __volatile__(							\
 	"1:\t"	"ld"#size " [%2], %1\n\t"				\
 		"clr	%0\n"						\
 	"2:\n\n\t"							\
-		".section .fixup,#alloc,#execinstr\n\t"			\
+		".section .fixup,\"ax\"\n\t"				\
 		".align	4\n"						\
 	"3:\n\t"							\
 		"sethi	%%hi(2b), %0\n\t"				\
@@ -207,7 +207,7 @@ __asm__ __volatile__(							\
 	"1:\t"	"ld"#size "a [%2] %%asi, %1\n\t"			\
 		"clr	%0\n"						\
 	"2:\n\n\t"							\
-		".section .fixup,#alloc,#execinstr\n\t"			\
+		".section .fixup,\"ax\"\n\t"				\
 		".align	4\n"						\
 	"3:\n\t"							\
 		"sethi	%%hi(2b), %0\n\t"				\
diff --git a/arch/sparc/kernel/ftrace.c b/arch/sparc/kernel/ftrace.c
index eaead3da8e03..f25b13513dc0 100644
--- a/arch/sparc/kernel/ftrace.c
+++ b/arch/sparc/kernel/ftrace.c
@@ -33,7 +33,7 @@ static int ftrace_modify_code(unsigned long ip, u32 old, =
u32 new)
 	"	flush	%[ip]\n"
 	"	mov	0, %[faulted]\n"
 	"2:\n"
-	"	.section .fixup,#alloc,#execinstr\n"
+	"	.section .fixup,\"ax\"\n"
 	"	.align	4\n"
 	"3:	sethi	%%hi(2b), %[faulted]\n"
 	"	jmpl	%[faulted] + %%lo(2b), %%g0\n"
diff --git a/arch/sparc/kernel/head_64.S b/arch/sparc/kernel/head_64.S
index 72a5bdc833ea..a15834ca2198 100644
--- a/arch/sparc/kernel/head_64.S
+++ b/arch/sparc/kernel/head_64.S
@@ -950,7 +950,7 @@ EXPORT_SYMBOL(sun4v_chip_type)
 prom_tba:	.xword	0
 tlb_type:	.word	0	/* Must NOT end up in BSS */
 EXPORT_SYMBOL(tlb_type)
-	.section	".fixup",#alloc,#execinstr
+	.section	.fixup,"ax"
=20
 ENTRY(__retl_efault)
 	retl
diff --git a/arch/sparc/kernel/una_asm_32.S b/arch/sparc/kernel/una_asm_32.S
index f8bf839289fb..030b6f2c3da9 100644
--- a/arch/sparc/kernel/una_asm_32.S
+++ b/arch/sparc/kernel/una_asm_32.S
@@ -58,7 +58,7 @@
 0:	retl
 	 mov	0, %o0
=20
-	.section __ex_table,#alloc
+	.section __ex_table,"a"
 	.word	4b, retl_efault
 	.word	5b, retl_efault
 	.word	6b, retl_efault
@@ -137,7 +137,7 @@
 0:	retl
 	 mov	0, %o0
=20
-	.section __ex_table,#alloc
+	.section __ex_table,"a"
 	.word	4b, retl_efault
 	.word	5b, retl_efault
 	.word	6b, retl_efault
diff --git a/arch/sparc/lib/copy_user.S b/arch/sparc/lib/copy_user.S
index 954572c78539..54160b10ab31 100644
--- a/arch/sparc/lib/copy_user.S
+++ b/arch/sparc/lib/copy_user.S
@@ -18,19 +18,15 @@
 #include <asm/thread_info.h>
 #include <asm/export.h>
=20
-/* Work around cpp -rob */
-#define ALLOC #alloc
-#define EXECINSTR #execinstr
-
 #define EX_ENTRY(l1, l2)			\
-	.section __ex_table,ALLOC;		\
+	.section __ex_table,"a";		\
 	.align	4;				\
 	.word	l1, l2;				\
 	.text;
=20
 #define EX(x,y,a,b) 				\
 98: 	x,y;					\
-	.section .fixup,ALLOC,EXECINSTR;	\
+	.section .fixup,"ax";			\
 	.align	4;				\
 99:	retl;					\
 	 a, b, %o0;				\
@@ -38,7 +34,7 @@
=20
 #define EX2(x,y,c,d,e,a,b) 			\
 98: 	x,y;					\
-	.section .fixup,ALLOC,EXECINSTR;	\
+	.section .fixup,"ax";			\
 	.align	4;				\
 99:	c, d, e;				\
 	retl;					\
@@ -51,14 +47,14 @@
=20
 #define LD(insn, src, offset, reg, label)	\
 98:	insn [%src + (offset)], %reg;		\
-	.section .fixup,ALLOC,EXECINSTR;	\
+	.section .fixup,"ax";			\
 99:	ba	label;				\
 	 mov	offset, %g5;			\
 	EX_ENTRY(98b, 99b)
=20
 #define ST(insn, dst, offset, reg, label)	\
 98:	insn %reg, [%dst + (offset)];		\
-	.section .fixup,ALLOC,EXECINSTR;	\
+	.section .fixup,"ax";			\
 99:	ba	label;				\
 	 mov	offset, %g5;			\
 	EX_ENTRY(98b, 99b)
@@ -90,7 +86,7 @@
 	ST(std, dst, offset + 0x10, t4, bigchunk_fault)	\
 	ST(std, dst, offset + 0x18, t6, bigchunk_fault)
=20
-	.section .fixup,#alloc,#execinstr
+	.section .fixup,"ax"
 bigchunk_fault:
 	sub	%g7, %g5, %o0
 	and	%g1, 127, %g1
@@ -106,7 +102,7 @@
 	ST(st, dst, -(offset + 0x08), t2, lastchunk_fault)	\
 	ST(st, dst, -(offset + 0x04), t3, lastchunk_fault)
=20
-	.section .fixup,#alloc,#execinstr
+	.section .fixup,"ax"
 lastchunk_fault:
 	and	%g1, 15, %g1
 	retl
@@ -130,7 +126,7 @@
 	ST(stb, dst, -(offset + 0x02), t0, halfchunk_fault)	\
 	ST(stb, dst, -(offset + 0x01), t1, halfchunk_fault)
=20
-	.section .fixup,#alloc,#execinstr
+	.section .fixup,"ax"
 halfchunk_fault:
 	and	%o2, 15, %o2
 	sub	%o3, %g5, %o3
@@ -144,7 +140,7 @@
 	ST(stb, dst, -(offset + 0x02), t0, last_shortchunk_fault)	\
 	ST(stb, dst, -(offset + 0x01), t1, last_shortchunk_fault)
=20
-	.section .fixup,#alloc,#execinstr
+	.section .fixup,"ax"
 last_shortchunk_fault:
 	and	%o2, 1, %o2
 	retl
@@ -384,7 +380,7 @@ __copy_user:	/* %o0=3Ddst %o1=3Dsrc %o2=3Dlen */
 	b	copy_user_last7
 	 mov	%o2, %g1
=20
-	.section .fixup,#alloc,#execinstr
+	.section .fixup,"ax"
 	.align	4
 97:
 	retl
diff --git a/arch/sparc/lib/memset.S b/arch/sparc/lib/memset.S
index eaff68213fdf..caca7c068ca7 100644
--- a/arch/sparc/lib/memset.S
+++ b/arch/sparc/lib/memset.S
@@ -186,7 +186,7 @@
 	retl
 	 clr	%o0
=20
-	.section .fixup,#alloc,#execinstr
+	.section .fixup,"ax"
 	.align	4
 30:
 	and	%o1, 0x7f, %o1
diff --git a/drivers/char/adi.c b/drivers/char/adi.c
index 751d7cc0da1b..7508df9f299c 100644
--- a/drivers/char/adi.c
+++ b/drivers/char/adi.c
@@ -29,7 +29,7 @@ static int read_mcd_tag(unsigned long addr)
 		"1:	ldxa [%[addr]] %[asi], %[ver]\n"
 		"	mov 0, %[err]\n"
 		"2:\n"
-		"	.section .fixup,#alloc,#execinstr\n"
+		"	.section .fixup,\"ax\"\n"
 		"	.align 4\n"
 		"3:	sethi %%hi(2b), %%g1\n"
 		"	jmpl  %%g1 + %%lo(2b), %%g0\n"
@@ -106,7 +106,7 @@ static int set_mcd_tag(unsigned long addr, u8 ver)
 		"1:	stxa %[ver], [%[addr]] %[asi]\n"
 		"	mov 0, %[err]\n"
 		"2:\n"
-		"	.section .fixup,#alloc,#execinstr\n"
+		"	.section .fixup,\"ax\"\n"
 		"	.align 4\n"
 		"3:	sethi %%hi(2b), %%g1\n"
 		"	jmpl %%g1 + %%lo(2b), %%g0\n"

--WDyAZS9pgpLGIJQY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmSMgRAACgkQ57/I7JWG
EQmRJxAAxTqNoxomRMQv3h8b/0cGQ9V0Czt2uTn8q1rwp3sX1gBvKURXJEfUZkVt
AJCuAPOXbGTrjQxHRtfbDuwxXEDQyMuGIDQVYVp8NQ9vORu7zuAdWsxW6ReEuh19
rs8gj1IpsycUMMtBBeBc+GpAhBVzTLVPrEyNgHyPBEUcXDgvnh1NYSXFRQN84/wx
TLX1wicRyICK/UYnDAlignNIyeTXNpdGbL/d6XzwKPSb/30YEKvJLxdo4UkG3sHB
Y2qdrw0wL19wcWup0v2j8A8bQ6z8QzgWNE7mOY6W7bEsCqNVjh684BTaD5CdWlZg
sQNvvx0oS9oCLyK0Sbn6P0cMu5308pgh+4am72VgaTRnKWEEXXCk+VZ5YpxJKEyZ
Y1Hb/wUDhSXR43POOh0xaZ8gU1ORJi6+SFkm5ZJ6D4nMF8Yvzz/MrhWORlfuWyRT
IOFTRLrcoGWSG6jmxsg6O/URLEy4vO9TooooGyJS05V9zIz3VumMzMCBE9EEglmV
xYfh9XI/jx/TBMUHQdkDY9dZAOtMx7mbZ/Z/lk8t0STyfFWU1Hu/GgqNzExSd2MU
JWIDcDCvP5BpgPaXLpkwnNln5VVZ9ZsSEGH6Dy8D1JruytM5U90L9zp1mxNmnuH5
ezJSBuFMwVNlw+uJOrPL7jYOi4j2ZBnnyQTrOpwGtZ/+J9hE+QI=
=Pnsz
-----END PGP SIGNATURE-----

--WDyAZS9pgpLGIJQY--
