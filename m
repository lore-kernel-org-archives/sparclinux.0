From: David Woodhouse <dwmw2@infradead.org>
Date: Thu, 05 Jul 2007 01:26:44 +0000
Subject: [PATCH 2.6.22 REGRESSION] Fix slab redzone alignment
Message-Id: <1183598804.2740.17.camel@shinybook.infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <468A7D14.1050505@googlemail.com>
In-Reply-To: <468A7D14.1050505@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, reiserfs-devel@vger.kernel.org, "Vladimir V. Saveliev" <vs@namesys.com>, Randy Dunlap <randy.dunlap@oracle.com>, linux-ide@vger.kernel.org, David Chinner <dgc@sgi.com>, sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>, Mikael Pettersson <mikpe@it.uu.se>, Mark Fortescue <mark@mtfhpc.demon.co.uk>, William Lee Irwin III <wli@holomorphy.com>

Commit b46b8f19c9cd435ecac4d9d12b39d78c137ecd66 fixed a couple of bugs
by switching the redzone to 64 bits. Unfortunately, it neglected to
ensure that the _second_ redzone, after the slab object, is aligned
correctly. This caused illegal instruction faults on sparc32, which for
some reason not entirely clear to me are not trapped and fixed up.

Two things need to be done to fix this:
  - increase the object size, rounding up to alignof(long long) so
    that the second redzone can be aligned correctly.
  - If SLAB_STORE_USER is set but alignof(long long)=8, allow a
    full 64 bits of space for the user word at the end of the buffer,
    even though we may not _use_ the whole 64 bits.

This patch should be a no-op on any 64-bit architecture or any 32-bit
architecture where alignof(long long) = 4. Of the others, it's tested
on ppc32 by myself and a very similar patch was tested on sparc32 by
Mark Fortescue, who reported the new problem.

Also, fix the conditions for FORCED_DEBUG, which hadn't been adjusted to
the new sizes. Again noticed by Mark.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/mm/slab.c b/mm/slab.c
index a9c4472..b344e67 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -137,6 +137,7 @@
 
 /* Shouldn't this be in a header file somewhere? */
 #define	BYTES_PER_WORD		sizeof(void *)
+#define	REDZONE_ALIGN		max(BYTES_PER_WORD, __alignof__(unsigned long long))
 
 #ifndef cache_line_size
 #define cache_line_size()	L1_CACHE_BYTES
@@ -547,7 +548,7 @@ static unsigned long long *dbg_redzone2(struct kmem_cache *cachep, void *objp)
 	if (cachep->flags & SLAB_STORE_USER)
 		return (unsigned long long *)(objp + cachep->buffer_size -
 					      sizeof(unsigned long long) -
-					      BYTES_PER_WORD);
+					      REDZONE_ALIGN);
 	return (unsigned long long *) (objp + cachep->buffer_size -
 				       sizeof(unsigned long long));
 }
@@ -2178,7 +2179,8 @@ kmem_cache_create (const char *name, size_t size, size_t align,
 	 * above the next power of two: caches with object sizes just above a
 	 * power of two have a significant amount of internal fragmentation.
 	 */
-	if (size < 4096 || fls(size - 1) = fls(size-1 + 3 * BYTES_PER_WORD))
+	if (size < 4096 || fls(size - 1) = fls(size-1 + REDZONE_ALIGN +
+						2 * sizeof(unsigned long long)))
 		flags |= SLAB_RED_ZONE | SLAB_STORE_USER;
 	if (!(flags & SLAB_DESTROY_BY_RCU))
 		flags |= SLAB_POISON;
@@ -2219,12 +2221,20 @@ kmem_cache_create (const char *name, size_t size, size_t align,
 	}
 
 	/*
-	 * Redzoning and user store require word alignment. Note this will be
-	 * overridden by architecture or caller mandated alignment if either
-	 * is greater than BYTES_PER_WORD.
+	 * Redzoning and user store require word alignment or possibly larger.
+	 * Note this will be overridden by architecture or caller mandated
+	 * alignment if either is greater than BYTES_PER_WORD.
 	 */
-	if (flags & SLAB_RED_ZONE || flags & SLAB_STORE_USER)
-		ralign = __alignof__(unsigned long long);
+	if (flags & SLAB_STORE_USER)
+		ralign = BYTES_PER_WORD;
+
+	if (flags & SLAB_RED_ZONE) {
+		ralign = REDZONE_ALIGN;
+		/* If redzoning, ensure that the second redzone is suitably
+		 * aligned, by adjusting the object size accordingly. */
+		size += REDZONE_ALIGN - 1;
+		size &= ~(REDZONE_ALIGN - 1);
+	}
 
 	/* 2) arch mandated alignment */
 	if (ralign < ARCH_SLAB_MINALIGN) {
@@ -2261,9 +2271,13 @@ kmem_cache_create (const char *name, size_t size, size_t align,
 	}
 	if (flags & SLAB_STORE_USER) {
 		/* user store requires one word storage behind the end of
-		 * the real object.
+		 * the real object. But if the second red zone needs to be
+		 * aligned to 64 bits, we must allow that much space.
 		 */
-		size += BYTES_PER_WORD;
+		if (flags & SLAB_RED_ZONE)
+			size += REDZONE_ALIGN;
+		else
+			size += BYTES_PER_WORD;
 	}
 #if FORCED_DEBUG && defined(CONFIG_DEBUG_PAGEALLOC)
 	if (size >= malloc_sizes[INDEX_L3 + 1].cs_size


-- 
dwmw2

