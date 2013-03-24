From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Sun, 24 Mar 2013 08:55:06 +0000
Subject: [PATCH 3/3] sparc/srmmu: use BITS_TO_LONGS() to calculate bitmap size
Message-Id: <1364115306-17716-3-git-send-email-akinobu.mita@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The size of bitmaps which is accessed by bitops must be a multiple of
the sizeof(long).  So it would be better to use BITS_TO_LONGS() to
calculate the bitmap size although it always be a multiple of the
sizeof(long)

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/mm/srmmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index c38bb72..f07a30a 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -280,7 +280,8 @@ static void __init srmmu_nocache_init(void)
 		SRMMU_NOCACHE_ALIGN_MAX, 0UL);
 	memset(srmmu_nocache_pool, 0, srmmu_nocache_size);
 
-	srmmu_nocache_bitmap = __alloc_bootmem(bitmap_bits >> 3, SMP_CACHE_BYTES, 0UL);
+	srmmu_nocache_bitmap = __alloc_bootmem(BITS_TO_LONGS(bitmap_bits) *
+				sizeof(unsigned long), SMP_CACHE_BYTES, 0UL);
 	bit_map_init(&srmmu_nocache_map, srmmu_nocache_bitmap, bitmap_bits);
 
 	srmmu_swapper_pg_dir = __srmmu_get_nocache(SRMMU_PGD_TABLE_SIZE, SRMMU_PGD_TABLE_SIZE);
-- 
1.8.1.4

