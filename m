From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 21 Dec 2004 04:20:37 +0000
Subject: [1/3] fix HyperSPARC DVMA
Message-Id: <20041221042037.GY771@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

DVMA is having aliasing problems. Bob originally sent in the following
description:

At some point in the past, Bob Breuer wrote:
> Here's the preliminary patch.  This time around, both the hme
> and esp drivers are working for me.  This replaces my previous
> patch and is against the vanilla 2.6.9 kernel.  I've tried to
> reduce the amount of unnecessary cache flushing, therefore this
> will need some testing on non-hypersparc cpus also.  It needs
> some cleanup yet, and will be rediffed against a later kernel.
> I'm looking for comments and feedback.

This patch represents one of those subsequent rediffings.

Signed-off-by: Bob Breuer <breuerr@mc.net>
Acked-by: William Irwin <wli@holomorphy.com>

Index: sparc32-2.6.10-rc3/include/asm-sparc/bitext.h
=================================--- sparc32-2.6.10-rc3.orig/include/asm-sparc/bitext.h	2004-06-15 22:19:43.000000000 -0700
+++ sparc32-2.6.10-rc3/include/asm-sparc/bitext.h	2004-12-20 19:22:33.983495914 -0800
@@ -17,6 +17,7 @@
 	int last_off;
 	int last_size;
 	int first_free;
+	int num_colors;
 };
 
 extern int bit_map_string_get(struct bit_map *t, int len, int align);
Index: sparc32-2.6.10-rc3/arch/sparc/lib/bitext.c
=================================--- sparc32-2.6.10-rc3.orig/arch/sparc/lib/bitext.c	2004-12-16 06:19:27.000000000 -0800
+++ sparc32-2.6.10-rc3/arch/sparc/lib/bitext.c	2004-12-20 19:22:33.986495458 -0800
@@ -29,10 +29,17 @@
 	int offset, count;	/* siamese twins */
 	int off_new;
 	int align1;
-	int i;
+	int i, color;
 
-	if (align = 0)
-		align = 1;
+	if (t->num_colors) {
+		/* align is overloaded to be the page color */
+		color = align;
+		align = t->num_colors;
+	} else {
+		color = 0;
+		if (align = 0)
+			align = 1;
+	}
 	align1 = align - 1;
 	if ((align & align1) != 0)
 		BUG();
@@ -40,6 +47,7 @@
 		BUG();
 	if (len <= 0 || len > t->size)
 		BUG();
+	color &= align1;
 
 	spin_lock(&t->lock);
 	if (len < t->last_size)
@@ -49,7 +57,7 @@
 	count = 0;
 	for (;;) {
 		off_new = find_next_zero_bit(t->map, t->size, offset);
-		off_new = (off_new + align1) & ~align1;
+		off_new = ((off_new + align1) & ~align1) + color;
 		count += off_new - offset;
 		offset = off_new;
 		if (offset >= t->size)
@@ -121,6 +129,4 @@
 	spin_lock_init(&t->lock);
 	t->map = map;
 	t->size = size;
-	t->last_size = 0;
-	t->first_free = 0;
 }
Index: sparc32-2.6.10-rc3/arch/sparc/mm/iommu.c
=================================--- sparc32-2.6.10-rc3.orig/arch/sparc/mm/iommu.c	2004-12-16 06:19:27.000000000 -0800
+++ sparc32-2.6.10-rc3/arch/sparc/mm/iommu.c	2004-12-20 19:22:33.991494698 -0800
@@ -119,6 +119,13 @@
 		prom_halt();
 	}
 	bit_map_init(&iommu->usemap, bitmap, IOMMU_NPTES);
+	/* To be coherent on HyperSparc, the page color of DVMA
+	 * and physical addresses must match.
+	 */
+	if (srmmu_modtype = HyperSparc)
+		iommu->usemap.num_colors = vac_cache_size >> PAGE_SHIFT;
+	else
+		iommu->usemap.num_colors = 1;
 
 	printk("IOMMU: impl %d vers %d table 0x%p[%d B] map [%d b]\n",
 	    impl, vers, iommu->page_table,
@@ -128,7 +135,9 @@
 }
 
 /* This begs to be btfixup-ed by srmmu. */
-static void iommu_viking_flush_iotlb(iopte_t *iopte, unsigned int niopte)
+/* Flush the iotlb entries to ram. */
+/* This could be better if we didn't have to flush whole pages. */
+static void iommu_flush_iotlb(iopte_t *iopte, unsigned int niopte)
 {
 	unsigned long start;
 	unsigned long end;
@@ -145,6 +154,11 @@
 			viking_flush_page(start);
 			start += PAGE_SIZE;
 		}
+	} else {
+		while(start < end) {
+			__flush_page_to_ram(start);
+			start += PAGE_SIZE;
+		}
 	}
 }
 
@@ -156,7 +170,8 @@
 	unsigned int busa, busa0;
 	int i;
 
-	ioptex = bit_map_string_get(&iommu->usemap, npages, 1);
+	/* page color = pfn of page */
+	ioptex = bit_map_string_get(&iommu->usemap, npages, page_to_pfn(page));
 	if (ioptex < 0)
 		panic("iommu out");
 	busa0 = iommu->start + (ioptex << PAGE_SHIFT);
@@ -172,8 +187,7 @@
 		page++;
 	}
 
-	iommu_viking_flush_iotlb(iopte0, npages);
-	flush_cache_all(); // hack to fix dma errors with hypersparc
+	iommu_flush_iotlb(iopte0, npages);
 
 	return busa0;
 }
@@ -328,7 +342,9 @@
 	if ((addr & ~PAGE_MASK) != 0) BUG();
 	if ((len & ~PAGE_MASK) != 0) BUG();
 
-	ioptex = bit_map_string_get(&iommu->usemap, len >> PAGE_SHIFT, 1);
+	/* page color = physical address */
+	ioptex = bit_map_string_get(&iommu->usemap, len >> PAGE_SHIFT,
+		addr >> PAGE_SHIFT);
 	if (ioptex < 0)
 		panic("iommu out");
 
@@ -372,7 +388,7 @@
 	 *        to handle the latter case as well.
 	 */
 	flush_cache_all();
-	iommu_viking_flush_iotlb(first, len >> PAGE_SHIFT);
+	iommu_flush_iotlb(first, len >> PAGE_SHIFT);
 	flush_tlb_all();
 	iommu_invalidate(iommu->regs);
 
