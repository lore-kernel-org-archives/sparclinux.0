From: "Art Haas" <ahaas@airmail.net>
Date: Mon, 02 Aug 2004 21:47:32 +0000
Subject: Re: Question about recent copy_user.S change - with patch
Message-Id: <20040802214732.GM7321@artsapartment.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040801192158.GB7321@artsapartment.org>
In-Reply-To: <20040801192158.GB7321@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Aug 02, 2004 at 02:14:40PM -0500, Tom 'spot' Callaway wrote:
> On Mon, 2004-08-02 at 13:09 -0500, Art Haas wrote:
> 
> > OK. As the memcpy.S file has similiar macros, is it not susceptible to
> > the same mis-expansion?
> 
> Presumably not, since I didn't need to patch it. :)
> 
> I doubt it would hurt to remain consistent.
>

Good. Here's a patch adding parens around the 'offset' argument. I also
removed all the trailing tabs so the '\' character doesn't wrap around.
The patch is not tested as my Sun box is temporarily not available.

Art Haas

=== arch/sparc/lib/memcpy.S 1.2 vs edited ==--- 1.2/arch/sparc/lib/memcpy.S	2004-02-20 01:55:22 -06:00
+++ edited/arch/sparc/lib/memcpy.S	2004-08-02 16:46:01 -05:00
@@ -42,124 +42,124 @@
 #endif
 
 /* Both these macros have to start with exactly the same insn */
-#define MOVE_BIGCHUNK(src, dst, offset, t0, t1, t2, t3, t4, t5, t6, t7) 				\
-	ldd	[%src + offset + 0x00], %t0; 								\
-	ldd	[%src + offset + 0x08], %t2; 								\
-	ldd	[%src + offset + 0x10], %t4; 								\
-	ldd	[%src + offset + 0x18], %t6; 								\
-	st	%t0, [%dst + offset + 0x00]; 								\
-	st	%t1, [%dst + offset + 0x04]; 								\
-	st	%t2, [%dst + offset + 0x08]; 								\
-	st	%t3, [%dst + offset + 0x0c]; 								\
-	st	%t4, [%dst + offset + 0x10]; 								\
-	st	%t5, [%dst + offset + 0x14]; 								\
-	st	%t6, [%dst + offset + 0x18]; 								\
-	st	%t7, [%dst + offset + 0x1c];
-
-#define MOVE_BIGALIGNCHUNK(src, dst, offset, t0, t1, t2, t3, t4, t5, t6, t7) 				\
-	ldd	[%src + offset + 0x00], %t0; 								\
-	ldd	[%src + offset + 0x08], %t2; 								\
-	ldd	[%src + offset + 0x10], %t4; 								\
-	ldd	[%src + offset + 0x18], %t6; 								\
-	std	%t0, [%dst + offset + 0x00]; 								\
-	std	%t2, [%dst + offset + 0x08]; 								\
-	std	%t4, [%dst + offset + 0x10]; 								\
-	std	%t6, [%dst + offset + 0x18];
-
-#define MOVE_LASTCHUNK(src, dst, offset, t0, t1, t2, t3) 						\
-	ldd	[%src - offset - 0x10], %t0; 								\
-	ldd	[%src - offset - 0x08], %t2; 								\
-	st	%t0, [%dst - offset - 0x10]; 								\
-	st	%t1, [%dst - offset - 0x0c]; 								\
-	st	%t2, [%dst - offset - 0x08]; 								\
-	st	%t3, [%dst - offset - 0x04];
-
-#define MOVE_LASTALIGNCHUNK(src, dst, offset, t0, t1, t2, t3) 						\
-	ldd	[%src - offset - 0x10], %t0; 								\
-	ldd	[%src - offset - 0x08], %t2; 								\
-	std	%t0, [%dst - offset - 0x10]; 								\
-	std	%t2, [%dst - offset - 0x08];
-
-#define MOVE_SHORTCHUNK(src, dst, offset, t0, t1) 							\
-	ldub	[%src - offset - 0x02], %t0; 								\
-	ldub	[%src - offset - 0x01], %t1; 								\
-	stb	%t0, [%dst - offset - 0x02]; 								\
-	stb	%t1, [%dst - offset - 0x01];
+#define MOVE_BIGCHUNK(src, dst, offset, t0, t1, t2, t3, t4, t5, t6, t7) \
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
+
+#define MOVE_BIGALIGNCHUNK(src, dst, offset, t0, t1, t2, t3, t4, t5, t6, t7) \
+	ldd	[%src + (offset) + 0x00], %t0; \
+	ldd	[%src + (offset) + 0x08], %t2; \
+	ldd	[%src + (offset) + 0x10], %t4; \
+	ldd	[%src + (offset) + 0x18], %t6; \
+	std	%t0, [%dst + (offset) + 0x00]; \
+	std	%t2, [%dst + (offset) + 0x08]; \
+	std	%t4, [%dst + (offset) + 0x10]; \
+	std	%t6, [%dst + (offset) + 0x18];
+
+#define MOVE_LASTCHUNK(src, dst, offset, t0, t1, t2, t3) \
+	ldd	[%src - (offset) - 0x10], %t0; \
+	ldd	[%src - (offset) - 0x08], %t2; \
+	st	%t0, [%dst - (offset) - 0x10]; \
+	st	%t1, [%dst - (offset) - 0x0c]; \
+	st	%t2, [%dst - (offset) - 0x08]; \
+	st	%t3, [%dst - (offset) - 0x04];
+
+#define MOVE_LASTALIGNCHUNK(src, dst, offset, t0, t1, t2, t3) \
+	ldd	[%src - (offset) - 0x10], %t0; \
+	ldd	[%src - (offset) - 0x08], %t2; \
+	std	%t0, [%dst - (offset) - 0x10]; \
+	std	%t2, [%dst - (offset) - 0x08];
+
+#define MOVE_SHORTCHUNK(src, dst, offset, t0, t1) \
+	ldub	[%src - (offset) - 0x02], %t0; \
+	ldub	[%src - (offset) - 0x01], %t1; \
+	stb	%t0, [%dst - (offset) - 0x02]; \
+	stb	%t1, [%dst - (offset) - 0x01];
 
 /* Both these macros have to start with exactly the same insn */
-#define RMOVE_BIGCHUNK(src, dst, offset, t0, t1, t2, t3, t4, t5, t6, t7) 				\
-	ldd	[%src - offset - 0x20], %t0; 								\
-	ldd	[%src - offset - 0x18], %t2; 								\
-	ldd	[%src - offset - 0x10], %t4; 								\
-	ldd	[%src - offset - 0x08], %t6; 								\
-	st	%t0, [%dst - offset - 0x20]; 								\
-	st	%t1, [%dst - offset - 0x1c]; 								\
-	st	%t2, [%dst - offset - 0x18]; 								\
-	st	%t3, [%dst - offset - 0x14]; 								\
-	st	%t4, [%dst - offset - 0x10]; 								\
-	st	%t5, [%dst - offset - 0x0c]; 								\
-	st	%t6, [%dst - offset - 0x08]; 								\
-	st	%t7, [%dst - offset - 0x04];
-
-#define RMOVE_BIGALIGNCHUNK(src, dst, offset, t0, t1, t2, t3, t4, t5, t6, t7) 				\
-	ldd	[%src - offset - 0x20], %t0; 								\
-	ldd	[%src - offset - 0x18], %t2; 								\
-	ldd	[%src - offset - 0x10], %t4; 								\
-	ldd	[%src - offset - 0x08], %t6; 								\
-	std	%t0, [%dst - offset - 0x20]; 								\
-	std	%t2, [%dst - offset - 0x18]; 								\
-	std	%t4, [%dst - offset - 0x10]; 								\
-	std	%t6, [%dst - offset - 0x08];
-
-#define RMOVE_LASTCHUNK(src, dst, offset, t0, t1, t2, t3) 						\
-	ldd	[%src + offset + 0x00], %t0; 								\
-	ldd	[%src + offset + 0x08], %t2; 								\
-	st	%t0, [%dst + offset + 0x00]; 								\
-	st	%t1, [%dst + offset + 0x04]; 								\
-	st	%t2, [%dst + offset + 0x08]; 								\
-	st	%t3, [%dst + offset + 0x0c];
-
-#define RMOVE_SHORTCHUNK(src, dst, offset, t0, t1) 							\
-	ldub	[%src + offset + 0x00], %t0; 								\
-	ldub	[%src + offset + 0x01], %t1; 								\
-	stb	%t0, [%dst + offset + 0x00]; 								\
-	stb	%t1, [%dst + offset + 0x01];
-
-#define SMOVE_CHUNK(src, dst, offset, t0, t1, t2, t3, t4, t5, t6, prev, shil, shir, offset2) 		\
-	ldd	[%src + offset + 0x00], %t0; 								\
-	ldd	[%src + offset + 0x08], %t2; 								\
-	srl	%t0, shir, %t5; 									\
-	srl	%t1, shir, %t6; 									\
-	sll	%t0, shil, %t0; 									\
-	or	%t5, %prev, %t5; 									\
-	sll	%t1, shil, %prev; 									\
-	or	%t6, %t0, %t0; 										\
-	srl	%t2, shir, %t1; 									\
-	srl	%t3, shir, %t6; 									\
-	sll	%t2, shil, %t2; 									\
-	or	%t1, %prev, %t1; 									\
-	std	%t4, [%dst + offset + offset2 - 0x04]; 							\
-	std	%t0, [%dst + offset + offset2 + 0x04];							\
-	sll	%t3, shil, %prev; 									\
+#define RMOVE_BIGCHUNK(src, dst, offset, t0, t1, t2, t3, t4, t5, t6, t7) \
+	ldd	[%src - (offset) - 0x20], %t0; \
+	ldd	[%src - (offset) - 0x18], %t2; \
+	ldd	[%src - (offset) - 0x10], %t4; \
+	ldd	[%src - (offset) - 0x08], %t6; \
+	st	%t0, [%dst - (offset) - 0x20]; \
+	st	%t1, [%dst - (offset) - 0x1c]; \
+	st	%t2, [%dst - (offset) - 0x18]; \
+	st	%t3, [%dst - (offset) - 0x14]; \
+	st	%t4, [%dst - (offset) - 0x10]; \
+	st	%t5, [%dst - (offset) - 0x0c]; \
+	st	%t6, [%dst - (offset) - 0x08]; \
+	st	%t7, [%dst - (offset) - 0x04];
+
+#define RMOVE_BIGALIGNCHUNK(src, dst, offset, t0, t1, t2, t3, t4, t5, t6, t7) \
+	ldd	[%src - (offset) - 0x20], %t0; \
+	ldd	[%src - (offset) - 0x18], %t2; \
+	ldd	[%src - (offset) - 0x10], %t4; \
+	ldd	[%src - (offset) - 0x08], %t6; \
+	std	%t0, [%dst - (offset) - 0x20]; \
+	std	%t2, [%dst - (offset) - 0x18]; \
+	std	%t4, [%dst - (offset) - 0x10]; \
+	std	%t6, [%dst - (offset) - 0x08];
+
+#define RMOVE_LASTCHUNK(src, dst, offset, t0, t1, t2, t3) \
+	ldd	[%src + (offset) + 0x00], %t0; \
+	ldd	[%src + (offset) + 0x08], %t2; \
+	st	%t0, [%dst + (offset) + 0x00]; \
+	st	%t1, [%dst + (offset) + 0x04]; \
+	st	%t2, [%dst + (offset) + 0x08]; \
+	st	%t3, [%dst + (offset) + 0x0c];
+
+#define RMOVE_SHORTCHUNK(src, dst, offset, t0, t1) \
+	ldub	[%src + (offset) + 0x00], %t0; \
+	ldub	[%src + (offset) + 0x01], %t1; \
+	stb	%t0, [%dst + (offset) + 0x00]; \
+	stb	%t1, [%dst + (offset) + 0x01];
+
+#define SMOVE_CHUNK(src, dst, offset, t0, t1, t2, t3, t4, t5, t6, prev, shil, shir, offset2) \
+	ldd	[%src + (offset) + 0x00], %t0; \
+	ldd	[%src + (offset) + 0x08], %t2; \
+	srl	%t0, shir, %t5; \
+	srl	%t1, shir, %t6; \
+	sll	%t0, shil, %t0; \
+	or	%t5, %prev, %t5; \
+	sll	%t1, shil, %prev; \
+	or	%t6, %t0, %t0; \
+	srl	%t2, shir, %t1; \
+	srl	%t3, shir, %t6; \
+	sll	%t2, shil, %t2; \
+	or	%t1, %prev, %t1; \
+	std	%t4, [%dst + (offset) + (offset2) - 0x04]; \
+	std	%t0, [%dst + (offset) + (offset2) + 0x04]; \
+	sll	%t3, shil, %prev; \
 	or	%t6, %t2, %t4;
 
-#define SMOVE_ALIGNCHUNK(src, dst, offset, t0, t1, t2, t3, t4, t5, t6, prev, shil, shir, offset2) 	\
-	ldd	[%src + offset + 0x00], %t0; 								\
-	ldd	[%src + offset + 0x08], %t2; 								\
-	srl	%t0, shir, %t4; 									\
-	srl	%t1, shir, %t5; 									\
-	sll	%t0, shil, %t6; 									\
-	or	%t4, %prev, %t0; 									\
-	sll	%t1, shil, %prev; 									\
-	or	%t5, %t6, %t1; 										\
-	srl	%t2, shir, %t4; 									\
-	srl	%t3, shir, %t5; 									\
-	sll	%t2, shil, %t6; 									\
-	or	%t4, %prev, %t2; 									\
-	sll	%t3, shil, %prev; 									\
-	or	%t5, %t6, %t3;										\
-	std	%t0, [%dst + offset + offset2 + 0x00]; 							\
-	std	%t2, [%dst + offset + offset2 + 0x08];
+#define SMOVE_ALIGNCHUNK(src, dst, offset, t0, t1, t2, t3, t4, t5, t6, prev, shil, shir, offset2) \
+	ldd	[%src + (offset) + 0x00], %t0; \
+	ldd	[%src + (offset) + 0x08], %t2; \
+	srl	%t0, shir, %t4;	\
+	srl	%t1, shir, %t5;	\
+	sll	%t0, shil, %t6;	\
+	or	%t4, %prev, %t0; \
+	sll	%t1, shil, %prev; \
+	or	%t5, %t6, %t1; \
+	srl	%t2, shir, %t4;	\
+	srl	%t3, shir, %t5;	\
+	sll	%t2, shil, %t6; \
+	or	%t4, %prev, %t2; \
+	sll	%t3, shil, %prev; \
+	or	%t5, %t6, %t3; \
+	std	%t0, [%dst + (offset) + (offset2) + 0x00]; \
+	std	%t2, [%dst + (offset) + (offset2) + 0x08];
 
 	.text
 	.align	4

-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
