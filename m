From: Matthew Wilcox <willy@infradead.org>
Date: Fri, 24 Mar 2017 16:13:16 +0000
Subject: [PATCH v3 5/7] zram: Convert to using memset_l
Message-Id: <20170324161318.18718-6-willy@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20170324161318.18718-1-willy@infradead.org>
In-Reply-To: <20170324161318.18718-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, Minchan Kim <minchan@kernel.org>, Matthew Wilcox <mawilcox@microsoft.com>

From: Matthew Wilcox <mawilcox@microsoft.com>

zram was the motivation for creating memset_l().  Minchan Kim sees a 7%
performance improvement on x86 with 100MB of non-zero deduplicatable
data:

        perf stat -r 10 dd if=/dev/zram0 of=/dev/null

vanilla:        0.232050465 seconds time elapsed ( +-  0.51% )
memset_l:	0.217219387 seconds time elapsed ( +-  0.07% )

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
Tested-by: Minchan Kim <minchan@kernel.org>
---
 drivers/block/zram/zram_drv.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index e27d89a36c34..25dcad309695 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -157,20 +157,11 @@ static inline void update_used_max(struct zram *zram,
 	} while (old_max != cur_max);
 }
 
-static inline void zram_fill_page(char *ptr, unsigned long len,
+static inline void zram_fill_page(void *ptr, unsigned long len,
 					unsigned long value)
 {
-	int i;
-	unsigned long *page = (unsigned long *)ptr;
-
 	WARN_ON_ONCE(!IS_ALIGNED(len, sizeof(unsigned long)));
-
-	if (likely(value = 0)) {
-		memset(ptr, 0, len);
-	} else {
-		for (i = 0; i < len / sizeof(*page); i++)
-			page[i] = value;
-	}
+	memset_l(ptr, value, len / sizeof(unsigned long));
 }
 
 static bool page_same_filled(void *ptr, unsigned long *element)
@@ -193,7 +184,7 @@ static bool page_same_filled(void *ptr, unsigned long *element)
 static void handle_same_page(struct bio_vec *bvec, unsigned long element)
 {
 	struct page *page = bvec->bv_page;
-	void *user_mem;
+	char *user_mem;
 
 	user_mem = kmap_atomic(page);
 	zram_fill_page(user_mem + bvec->bv_offset, bvec->bv_len, element);
-- 
2.11.0

