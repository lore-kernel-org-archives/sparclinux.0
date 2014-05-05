From: David Miller <davem@davemloft.net>
Date: Mon, 05 May 2014 20:20:04 +0000
Subject: [PATCH] slab: Fix off by one in object max number tests.
Message-Id: <20140505.162004.1797345518474659123.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: iamjoonsoo.kim@lge.com, sparclinux@vger.kernel.org, hannes@cmpxchg.org, cl@linux.com, penberg@kernel.org, torvalds@linux-foundation.org


If freelist_idx_t is a byte, SLAB_OBJ_MAX_NUM should be 255 not 256,
and likewise if freelist_idx_t is a short, then it should be 65535 not
65536.

Fixes: a41adfa ("slab: introduce byte sized index for the freelist of a slab")
Signed-off-by: David S. Miller <davem@davemloft.net>
---

This was leading to all kinds of random crashes on sparc64 where PAGE_SIZE
is 8192.  One problem shown was that if spinlock debugging was enabled,
we'd get deadlocks in copy_pte_range() or do_wp_page() with the same cpu
already holding a lock it shouldn't hold, or the lock belonging to a
completely unrelated process.

diff --git a/mm/slab.c b/mm/slab.c
index 388cb1a..37de3a7 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -166,7 +166,7 @@ typedef unsigned char freelist_idx_t;
 typedef unsigned short freelist_idx_t;
 #endif
 
-#define SLAB_OBJ_MAX_NUM (1 << sizeof(freelist_idx_t) * BITS_PER_BYTE)
+#define SLAB_OBJ_MAX_NUM ((1 << sizeof(freelist_idx_t) * BITS_PER_BYTE) - 1)
 
 /*
  * true if a page was allocated from pfmemalloc reserves for network-based
