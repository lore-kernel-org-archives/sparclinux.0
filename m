From: Christoph Hellwig <hch@lst.de>
Date: Tue, 22 May 2018 12:04:13 +0000
Subject: [PATCH 08/25] nds32: consolidate DMA cache maintainance routines
Message-Id: <20180522120430.28709-9-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180522120430.28709-1-hch@lst.de>
In-Reply-To: <20180522120430.28709-1-hch-jcswGhMUV9g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org, Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, Vincent Chen <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org, openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org, Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org, linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org

Make sure all other DMA methods call nds32_dma_sync_single_for_{device,cpu}
to perform cache maintaince, and remove the consisteny_sync helper that
implemented both with entirely separate code based off an argument.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/nds32/kernel/dma.c | 140 +++++++++++++++++-----------------------
 1 file changed, 61 insertions(+), 79 deletions(-)

diff --git a/arch/nds32/kernel/dma.c b/arch/nds32/kernel/dma.c
index e1bf7206e015..4e6fb4ffd3f7 100644
--- a/arch/nds32/kernel/dma.c
+++ b/arch/nds32/kernel/dma.c
@@ -22,11 +22,6 @@
 static pte_t *consistent_pte;
 static DEFINE_RAW_SPINLOCK(consistent_lock);
 
-enum master_type {
-	FOR_CPU = 0,
-	FOR_DEVICE = 1,
-};
-
 /*
  * VM region handling support.
  *
@@ -333,15 +328,53 @@ static int __init consistent_init(void)
 }
 
 core_initcall(consistent_init);
-static void consistent_sync(void *vaddr, size_t size, int direction, int master_type);
+
+static void
+nds32_dma_sync_single_for_device(struct device *dev, dma_addr_t handle,
+				 size_t size, enum dma_data_direction dir)
+{
+	unsigned long start = (unsigned long)phys_to_virt(handle);
+
+	switch (dir) {
+	case DMA_FROM_DEVICE:
+		break;
+	case DMA_TO_DEVICE:
+	case DMA_BIDIRECTIONAL:
+		cpu_dma_wb_range(start, start + size);
+		break;
+	default:
+		BUG();
+	}
+}
+
+static void
+nds32_dma_sync_single_for_cpu(struct device *dev, dma_addr_t handle,
+			      size_t size, enum dma_data_direction dir)
+{
+	unsigned long start = (unsigned long)phys_to_virt(handle);
+
+	switch (dir) {
+	case DMA_TO_DEVICE:
+		break;
+	case DMA_FROM_DEVICE:
+	case DMA_BIDIRECTIONAL:
+		cpu_dma_inval_range(start, start + size);
+		break;
+	default:
+		BUG();
+	}
+}
+
 static dma_addr_t nds32_dma_map_page(struct device *dev, struct page *page,
 				     unsigned long offset, size_t size,
 				     enum dma_data_direction dir,
 				     unsigned long attrs)
 {
+	dma_addr_t dma_addr = page_to_phys(page) + offset;
+
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		consistent_sync((void *)(page_address(page) + offset), size, dir, FOR_DEVICE);
-	return page_to_phys(page) + offset;
+		nds32_dma_sync_single_for_device(dev, handle, size, dir);
+	return dma_addr;
 }
 
 static void nds32_dma_unmap_page(struct device *dev, dma_addr_t handle,
@@ -349,75 +382,19 @@ static void nds32_dma_unmap_page(struct device *dev, dma_addr_t handle,
 				 unsigned long attrs)
 {
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		consistent_sync(phys_to_virt(handle), size, dir, FOR_CPU);
+		nds32_dma_sync_single_for_cpu(dev, handle, size, dir);
 }
 
-/*
- * Make an area consistent for devices.
- */
-static void consistent_sync(void *vaddr, size_t size, int direction, int master_type)
-{
-	unsigned long start = (unsigned long)vaddr;
-	unsigned long end = start + size;
-
-	if (master_type = FOR_CPU) {
-		switch (direction) {
-		case DMA_TO_DEVICE:
-			break;
-		case DMA_FROM_DEVICE:
-		case DMA_BIDIRECTIONAL:
-			cpu_dma_inval_range(start, end);
-			break;
-		default:
-			BUG();
-		}
-	} else {
-		/* FOR_DEVICE */
-		switch (direction) {
-		case DMA_FROM_DEVICE:
-			break;
-		case DMA_TO_DEVICE:
-		case DMA_BIDIRECTIONAL:
-			cpu_dma_wb_range(start, end);
-			break;
-		default:
-			BUG();
-		}
-	}
-}
-
-static int nds32_dma_map_sg(struct device *dev, struct scatterlist *sg,
-			    int nents, enum dma_data_direction dir,
-			    unsigned long attrs)
+static void
+nds32_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
+			     int nents, enum dma_data_direction dir)
 {
 	int i;
 
 	for (i = 0; i < nents; i++, sg++) {
-		char *virt -		    page_address((struct page *)sg->page_link) + sg->offset;
-		consistent_sync(virt, sg->length, dir, FOR_CPU);
+		nds32_dma_sync_single_for_device(dev, sg_dma_address(sg),
+				sg->length, dir);
 	}
-	return nents;
-}
-
-static void nds32_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
-			       int nhwentries, enum dma_data_direction dir,
-			       unsigned long attrs)
-{
-}
-
-static void
-nds32_dma_sync_single_for_cpu(struct device *dev, dma_addr_t handle,
-			      size_t size, enum dma_data_direction dir)
-{
-	consistent_sync((void *)phys_to_virt(handle), size, dir, FOR_CPU);
-}
-
-static void
-nds32_dma_sync_single_for_device(struct device *dev, dma_addr_t handle,
-				 size_t size, enum dma_data_direction dir)
-{
-	consistent_sync((void *)phys_to_virt(handle), size, dir, FOR_DEVICE);
 }
 
 static void
@@ -427,23 +404,28 @@ nds32_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg, int nents,
 	int i;
 
 	for (i = 0; i < nents; i++, sg++) {
-		char *virt -		    page_address((struct page *)sg->page_link) + sg->offset;
-		consistent_sync(virt, sg->length, dir, FOR_CPU);
+		nds32_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
+				sg->length, dir);
 	}
 }
 
-static void
-nds32_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
-			     int nents, enum dma_data_direction dir)
+static int nds32_dma_map_sg(struct device *dev, struct scatterlist *sg,
+			    int nents, enum dma_data_direction dir,
+			    unsigned long attrs)
 {
 	int i;
 
 	for (i = 0; i < nents; i++, sg++) {
-		char *virt -		    page_address((struct page *)sg->page_link) + sg->offset;
-		consistent_sync(virt, sg->length, dir, FOR_DEVICE);
+		nds32_dma_sync_single_for_device(dev, sg_dma_address(sg),
+				sg->length, dir);
 	}
+	return nents;
+}
+
+static void nds32_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
+			       int nhwentries, enum dma_data_direction dir,
+			       unsigned long attrs)
+{
 }
 
 struct dma_map_ops nds32_dma_ops = {
-- 
2.17.0

