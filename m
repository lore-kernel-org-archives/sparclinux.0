From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Mon, 12 Jul 2004 22:29:04 +0000
Subject: [PATCH 2.6] Fix copy_user.S with gcc 3.3
Message-Id: <1089671344.20813.28.camel@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-s9VZ7CLueYDoiB276B3Z"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-s9VZ7CLueYDoiB276B3Z
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Jakub Jelinek helped me track down this fix, it gets sparc32 compiling
again with gcc 3.3.*.

~spot
---
Tom "spot" Callaway <tcallawa(a)redhat*com> LCA, RHCE 
Red Hat Sales Engineer || Aurora Linux Project Leader

"If you are going through hell, keep going."
- Sir Winston Churchill

--=-s9VZ7CLueYDoiB276B3Z
Content-Disposition: attachment; filename=linux-2.6.6-sparc-plusminusfix.patch
Content-Type: text/x-patch; name=linux-2.6.6-sparc-plusminusfix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.6/arch/sparc/lib/copy_user.S.jj	2004-05-09 22:32:37.000000000 -0400
+++ linux-2.6.6/arch/sparc/lib/copy_user.S	2004-05-18 22:07:54.142123000 -0400
@@ -64,52 +64,52 @@
 
 /* Both these macros have to start with exactly the same insn */
 #define MOVE_BIGCHUNK(src, dst, offset, t0, t1, t2, t3, t4, t5, t6, t7) \
-	ldd	[%src + offset + 0x00], %t0; \
-	ldd	[%src + offset + 0x08], %t2; \
-	ldd	[%src + offset + 0x10], %t4; \
-	ldd	[%src + offset + 0x18], %t6; \
-	st	%t0, [%dst + offset + 0x00]; \
-	st	%t1, [%dst + offset + 0x04]; \
-	st	%t2, [%dst + offset + 0x08]; \
-	st	%t3, [%dst + offset + 0x0c]; \
-	st	%t4, [%dst + offset + 0x10]; \
-	st	%t5, [%dst + offset + 0x14]; \
-	st	%t6, [%dst + offset + 0x18]; \
-	st	%t7, [%dst + offset + 0x1c];
+	ldd	[%src + (offset) + 0x00], %t0; \
+	ldd	[%src + (offset) + 0x08], %t2; \
+	ldd	[%src + (offset) + 0x10], %t4; \
+	ldd	[%src + (offset) + 0x18], %t6; \
+	st	%t0, [%dst + (offset) + 0x00]; \
+	st	%t1, [%dst + (offset) + 0x04]; \
+	st	%t2, [%dst + (offset) + 0x08]; \
+	st	%t3, [%dst + (offset) + 0x0c]; \
+	st	%t4, [%dst + (offset) + 0x10]; \
+	st	%t5, [%dst + (offset) + 0x14]; \
+	st	%t6, [%dst + (offset) + 0x18]; \
+	st	%t7, [%dst + (offset) + 0x1c];
 
 #define MOVE_BIGALIGNCHUNK(src, dst, offset, t0, t1, t2, t3, t4, t5, t6, t7) \
-	ldd	[%src + offset + 0x00], %t0; \
-	ldd	[%src + offset + 0x08], %t2; \
-	ldd	[%src + offset + 0x10], %t4; \
-	ldd	[%src + offset + 0x18], %t6; \
-	std	%t0, [%dst + offset + 0x00]; \
-	std	%t2, [%dst + offset + 0x08]; \
-	std	%t4, [%dst + offset + 0x10]; \
-	std	%t6, [%dst + offset + 0x18];
+	ldd	[%src + (offset) + 0x00], %t0; \
+	ldd	[%src + (offset) + 0x08], %t2; \
+	ldd	[%src + (offset) + 0x10], %t4; \
+	ldd	[%src + (offset) + 0x18], %t6; \
+	std	%t0, [%dst + (offset) + 0x00]; \
+	std	%t2, [%dst + (offset) + 0x08]; \
+	std	%t4, [%dst + (offset) + 0x10]; \
+	std	%t6, [%dst + (offset) + 0x18];
 
 #define MOVE_LASTCHUNK(src, dst, offset, t0, t1, t2, t3) \
-	ldd	[%src - offset - 0x10], %t0; \
-	ldd	[%src - offset - 0x08], %t2; \
-	st	%t0, [%dst - offset - 0x10]; \
-	st	%t1, [%dst - offset - 0x0c]; \
-	st	%t2, [%dst - offset - 0x08]; \
-	st	%t3, [%dst - offset - 0x04];
+	ldd	[%src - (offset) - 0x10], %t0; \
+	ldd	[%src - (offset) - 0x08], %t2; \
+	st	%t0, [%dst - (offset) - 0x10]; \
+	st	%t1, [%dst - (offset) - 0x0c]; \
+	st	%t2, [%dst - (offset) - 0x08]; \
+	st	%t3, [%dst - (offset) - 0x04];
 
 #define MOVE_HALFCHUNK(src, dst, offset, t0, t1, t2, t3) \
-	lduh	[%src + offset + 0x00], %t0; \
-	lduh	[%src + offset + 0x02], %t1; \
-	lduh	[%src + offset + 0x04], %t2; \
-	lduh	[%src + offset + 0x06], %t3; \
-	sth	%t0, [%dst + offset + 0x00]; \
-	sth	%t1, [%dst + offset + 0x02]; \
-	sth	%t2, [%dst + offset + 0x04]; \
-	sth	%t3, [%dst + offset + 0x06];
+	lduh	[%src + (offset) + 0x00], %t0; \
+	lduh	[%src + (offset) + 0x02], %t1; \
+	lduh	[%src + (offset) + 0x04], %t2; \
+	lduh	[%src + (offset) + 0x06], %t3; \
+	sth	%t0, [%dst + (offset) + 0x00]; \
+	sth	%t1, [%dst + (offset) + 0x02]; \
+	sth	%t2, [%dst + (offset) + 0x04]; \
+	sth	%t3, [%dst + (offset) + 0x06];
 
 #define MOVE_SHORTCHUNK(src, dst, offset, t0, t1) \
-	ldub	[%src - offset - 0x02], %t0; \
-	ldub	[%src - offset - 0x01], %t1; \
-	stb	%t0, [%dst - offset - 0x02]; \
-	stb	%t1, [%dst - offset - 0x01];
+	ldub	[%src - (offset) - 0x02], %t0; \
+	ldub	[%src - (offset) - 0x01], %t1; \
+	stb	%t0, [%dst - (offset) - 0x02]; \
+	stb	%t1, [%dst - (offset) - 0x01];
 
 	.text
 	.align	4

--=-s9VZ7CLueYDoiB276B3Z--

