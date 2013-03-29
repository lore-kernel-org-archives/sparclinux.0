From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Fri, 29 Mar 2013 13:44:43 +0000
Subject: [PATCH] sparc/srmmu: clear trailing edge of bitmap properly
Message-Id: <1364564684-15469-1-git-send-email-akinobu.mita@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

srmmu_nocache_bitmap is cleared by bit_map_init().  But bit_map_init()
attempts to clear by memset(), so it can't clear the trailing edge of
bitmap properly on big-endian architecture if the number of bits is not
a multiple of BITS_PER_LONG.

Actually, the number of bits in srmmu_nocache_bitmap is not always
a multiple of BITS_PER_LONG.  It is calculated as below:

        bitmap_bits = srmmu_nocache_size >> SRMMU_NOCACHE_BITMAP_SHIFT;

srmmu_nocache_size is decided proportionally by the amount of system RAM
and it is rounded to a multiple of PAGE_SIZE.  SRMMU_NOCACHE_BITMAP_SHIFT
is defined as (PAGE_SHIFT - 4).  So it can only be said that bitmap_bits
is a multiple of 16.

This fixes the problem by using bitmap_clear() instead of memset()
in bit_map_init() and this also uses BITS_TO_LONGS() to calculate correct
size at bitmap allocation time.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---

This patch is a combination of the patches I sent:
"sparc: clear bitmap correctly in bit_map_init()" and
"sparc/srmmu: use BITS_TO_LONGS() to calculate bitmap size", but
the patch description is rewritten.

 arch/sparc/lib/bitext.c | 6 +-----
 arch/sparc/mm/srmmu.c   | 4 +++-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/lib/bitext.c b/arch/sparc/lib/bitext.c
index d516fda..04d8bad 100644
--- a/arch/sparc/lib/bitext.c
+++ b/arch/sparc/lib/bitext.c
@@ -111,11 +111,7 @@ void bit_map_clear(struct bit_map *t, int offset, int len)
 
 void bit_map_init(struct bit_map *t, unsigned long *map, int size)
 {
-
-	if ((size & 07) != 0)
-		BUG();
-	memset(map, 0, size>>3);
-
+	bitmap_zero(map, size);
 	memset(t, 0, sizeof *t);
 	spin_lock_init(&t->lock);
 	t->map = map;
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index c38bb72..036c279 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -280,7 +280,9 @@ static void __init srmmu_nocache_init(void)
 		SRMMU_NOCACHE_ALIGN_MAX, 0UL);
 	memset(srmmu_nocache_pool, 0, srmmu_nocache_size);
 
-	srmmu_nocache_bitmap = __alloc_bootmem(bitmap_bits >> 3, SMP_CACHE_BYTES, 0UL);
+	srmmu_nocache_bitmap +		__alloc_bootmem(BITS_TO_LONGS(bitmap_bits) * sizeof(long),
+				SMP_CACHE_BYTES, 0UL);
 	bit_map_init(&srmmu_nocache_map, srmmu_nocache_bitmap, bitmap_bits);
 
 	srmmu_swapper_pg_dir = __srmmu_get_nocache(SRMMU_PGD_TABLE_SIZE, SRMMU_PGD_TABLE_SIZE);
-- 
1.8.1.4

