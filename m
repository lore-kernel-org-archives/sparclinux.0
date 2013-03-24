From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Sun, 24 Mar 2013 08:55:05 +0000
Subject: [PATCH 2/3] sparc/iommu: use BITS_TO_LONGS() to calculate bitmap size
Message-Id: <1364115306-17716-2-git-send-email-akinobu.mita@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The size of bitmaps which is accessed by bitops must be a multiple of
the sizeof(long).  So it would be better to use BITS_TO_LONGS() to
calculate the bitmap size although IOMMU_NPTES is a multiple of
BITS_PER_LONG.

This also fixes typo in the comment for IOMMU_NPTES.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/mm/iommu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index 0f4f719..f9027fd 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -34,7 +34,7 @@
 #define IOMMU_RNGE	IOMMU_RNGE_256MB
 #define IOMMU_START	0xF0000000
 #define IOMMU_WINSIZE	(256*1024*1024U)
-#define IOMMU_NPTES	(IOMMU_WINSIZE/PAGE_SIZE)	/* 64K PTEs, 265KB */
+#define IOMMU_NPTES	(IOMMU_WINSIZE/PAGE_SIZE)	/* 64K PTEs, 256KB */
 #define IOMMU_ORDER	6				/* 4096 * (1<<6) */
 
 /* srmmu.c */
@@ -103,10 +103,11 @@ static void __init sbus_iommu_init(struct platform_device *op)
 	iommu->regs->base = __pa((unsigned long) iommu->page_table) >> 4;
 	iommu_invalidate(iommu->regs);
 
-	bitmap = kmalloc(IOMMU_NPTES>>3, GFP_KERNEL);
+	bitmap = kmalloc(BITS_TO_LONGS(IOMMU_NPTES) * sizeof(unsigned long),
+			GFP_KERNEL);
 	if (!bitmap) {
-		prom_printf("Unable to allocate iommu bitmap [%d]\n",
-			    (int)(IOMMU_NPTES>>3));
+		prom_printf("Unable to allocate iommu bitmap [%ld]\n",
+			BITS_TO_LONGS(IOMMU_NPTES) * sizeof(unsigned long));
 		prom_halt();
 	}
 	bit_map_init(&iommu->usemap, bitmap, IOMMU_NPTES);
-- 
1.8.1.4

