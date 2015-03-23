From: David Miller <davem@davemloft.net>
Date: Mon, 23 Mar 2015 16:25:30 +0000
Subject: Re: 4.0.0-rc4: panic in free_block
Message-Id: <20150323.122530.812870422534676208.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <550F5852.5020405@oracle.com>
	<20150322.220024.1171832215344978787.davem@davemloft.net>
	<20150322.221906.1670737065885267482.davem@davemloft.net>
In-Reply-To: <20150322.221906.1670737065885267482.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: david.ahern@oracle.com
Cc: torvalds@linux-foundation.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpicco@meloft.net

From: David Miller <davem@davemloft.net>
Date: Sun, 22 Mar 2015 22:19:06 -0400 (EDT)

> I'll work on a fix.

Ok, here is what I committed.   David et al., let me know if you still
see the crashes with this applied.

Of course, I'll queue this up for -stable as well.

Thanks!

==========
[PATCH] sparc64: Fix several bugs in memmove().

Firstly, handle zero length calls properly.  Believe it or not there
are a few of these happening during early boot.

Next, we can't just drop to a memcpy() call in the forward copy case
where dst <= src.  The reason is that the cache initializing stores
used in the Niagara memcpy() implementations can end up clearing out
cache lines before we've sourced their original contents completely.

For example, considering NG4memcpy, the main unrolled loop begins like
this:

     load   src + 0x00
     load   src + 0x08
     load   src + 0x10
     load   src + 0x18
     load   src + 0x20
     store  dst + 0x00

Assume dst is 64 byte aligned and let's say that dst is src - 8 for
this memcpy() call.  That store at the end there is the one to the
first line in the cache line, thus clearing the whole line, which thus
clobbers "src + 0x28" before it even gets loaded.

To avoid this, just fall through to a simple copy only mildly
optimized for the case where src and dst are 8 byte aligned and the
length is a multiple of 8 as well.  We could get fancy and call
GENmemcpy() but this is good enough for how this thing is actually
used.

Reported-by: David Ahern <david.ahern@oracle.com>
Reported-by: Bob Picco <bpicco@meloft.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/lib/memmove.S | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/lib/memmove.S b/arch/sparc/lib/memmove.S
index b7f6334..857ad4f 100644
--- a/arch/sparc/lib/memmove.S
+++ b/arch/sparc/lib/memmove.S
@@ -8,9 +8,11 @@
 
 	.text
 ENTRY(memmove) /* o0=dst o1=src o2=len */
-	mov		%o0, %g1
+	brz,pn		%o2, 99f
+	 mov		%o0, %g1
+
 	cmp		%o0, %o1
-	bleu,pt		%xcc, memcpy
+	bleu,pt		%xcc, 2f
 	 add		%o1, %o2, %g7
 	cmp		%g7, %o0
 	bleu,pt		%xcc, memcpy
@@ -24,7 +26,34 @@ ENTRY(memmove) /* o0=dst o1=src o2=len */
 	stb		%g7, [%o0]
 	bne,pt		%icc, 1b
 	 sub		%o0, 1, %o0
-
+99:
 	retl
 	 mov		%g1, %o0
+
+	/* We can't just call memcpy for these memmove cases.  On some
+	 * chips the memcpy uses cache initializing stores and when dst
+	 * and src are close enough, those can clobber the source data
+	 * before we've loaded it in.
+	 */
+2:	or		%o0, %o1, %g7
+	or		%o2, %g7, %g7
+	andcc		%g7, 0x7, %g0
+	bne,pn		%xcc, 4f
+	 nop
+
+3:	ldx		[%o1], %g7
+	add		%o1, 8, %o1
+	subcc		%o2, 8, %o2
+	add		%o0, 8, %o0
+	bne,pt		%icc, 3b
+	 stx		%g7, [%o0 - 0x8]
+	ba,a,pt		%xcc, 99b
+
+4:	ldub		[%o1], %g7
+	add		%o1, 1, %o1
+	subcc		%o2, 1, %o2
+	add		%o0, 1, %o0
+	bne,pt		%icc, 4b
+	 stb		%g7, [%o0 - 0x1]
+	ba,a,pt		%xcc, 99b
 ENDPROC(memmove)
-- 
1.7.11.7

