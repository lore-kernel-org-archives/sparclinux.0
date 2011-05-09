From: Tkhai Kirill <tkhai@yandex.ru>
Date: Mon, 09 May 2011 08:49:24 +0000
Subject: Re: [PATCH]SPARC32: Fixed unaligned memory copying in function __csum_partial_copy_sparc_generic
Message-Id: <549071304930964@web114.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
References: <1304845558.9492.14.camel@big>
In-Reply-To: <1304845558.9492.14.camel@big>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>Your patch is corrupted, it has chopped up long lines.

>Please fix this up, and send a test patch email to yourself.

It's strange... I had did it at least twice before I sent the first message. And it's possible for mine diff to apply patch from http://spinics.net/lists/sparclinux mail list without any warnings.

Ok, I'm sending patch from another mail program:

--- linux-2.6.38.5/arch/sparc/lib/checksum_32.S.orig	2011-05-06 22:54:25.000000000 +0400
+++ linux-2.6.38.5/arch/sparc/lib/checksum_32.S	2011-05-08 11:43:35.000000000 +0400
@@ -289,10 +289,16 @@ cc_end_cruft:
 
 	/* Also, handle the alignment code out of band. */
 cc_dword_align:
-	cmp	%g1, 6
-	bl,a	ccte
+	cmp	%g1, 16
+	bge,a	1f
+	 srl	%g1, 1, %o3
+2:	cmp	%o3, 0
+	be,a	ccte
 	 andcc	%g1, 0xf, %o3
-	andcc	%o0, 0x1, %g0
+	andcc	%o3, %o0, %g0	! Check %o0 only (%o1 has the same last 2 bits)
+	be,a	2b
+	 srl	%o3, 1, %o3
+1:	andcc	%o0, 0x1, %g0
 	bne	ccslow
 	 andcc	%o0, 0x2, %g0
 	be	1f
