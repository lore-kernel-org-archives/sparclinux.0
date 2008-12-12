From: Robert Reif <reif@earthlink.net>
Date: Fri, 12 Dec 2008 04:02:17 +0000
Subject: [PATCH] use sparc64 version of scatterlist.h
Message-Id: <4941E249.1060808@earthlink.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------000006070500080205020800"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------000006070500080205020800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Use sparc64 version of scatterlist.h.

There are three main differences:
    dma_addr_t replaces __u32
    dma_address replaces dvma_address
    dma_length replaces dvma_length

dma_addr_t is a u32 on sparc32.

Boot tested on sparc32.

Signed-off-by: Robert Reif <reif@earthlink.net>

--------------000006070500080205020800
Content-Type: text/plain;
 name="scatterlist.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="scatterlist.diff.txt"

 arch/sparc/include/asm/scatterlist.h    |   33 ++++++++++++++++++++++++------
 arch/sparc/include/asm/scatterlist_32.h |   26 ------------------------
 arch/sparc/include/asm/scatterlist_64.h |   27 -------------------------
 arch/sparc/kernel/ioport.c              |    4 +-
 arch/sparc/mm/io-unit.c                 |    8 +++---
 arch/sparc/mm/iommu.c                   |   16 +++++++-------
 arch/sparc/mm/sun4c.c                   |    6 ++--
 7 files changed, 43 insertions(+), 77 deletions(-)

diff --git a/arch/sparc/include/asm/scatterlist.h b/arch/sparc/include/asm/scatterlist.h
index ec21a45..e580f55 100644
--- a/arch/sparc/include/asm/scatterlist.h
+++ b/arch/sparc/include/asm/scatterlist.h
@@ -1,8 +1,27 @@
-#ifndef ___ASM_SPARC_SCATTERLIST_H
-#define ___ASM_SPARC_SCATTERLIST_H
-#if defined(__sparc__) && defined(__arch64__)
-#include <asm/scatterlist_64.h>
-#else
-#include <asm/scatterlist_32.h>
-#endif
+#ifndef _SPARC_SCATTERLIST_H
+#define _SPARC_SCATTERLIST_H
+
+#include <asm/page.h>
+#include <asm/types.h>
+
+struct scatterlist {
+#ifdef CONFIG_DEBUG_SG
+	unsigned long	sg_magic;
 #endif
+	unsigned long	page_link;
+	unsigned int	offset;
+
+	unsigned int	length;
+
+	dma_addr_t	dma_address;
+	__u32		dma_length;
+};
+
+#define sg_dma_address(sg)	((sg)->dma_address)
+#define sg_dma_len(sg)     	((sg)->dma_length)
+
+#define ISA_DMA_THRESHOLD	(~0UL)
+
+#define ARCH_HAS_SG_CHAIN
+
+#endif /* !(_SPARC_SCATTERLIST_H) */
diff --git a/arch/sparc/include/asm/scatterlist_32.h b/arch/sparc/include/asm/scatterlist_32.h
deleted file mode 100644
index c82609c..0000000
--- a/arch/sparc/include/asm/scatterlist_32.h
+++ /dev/null
@@ -1,26 +0,0 @@
-#ifndef _SPARC_SCATTERLIST_H
-#define _SPARC_SCATTERLIST_H
-
-#include <linux/types.h>
-
-struct scatterlist {
-#ifdef CONFIG_DEBUG_SG
-	unsigned long sg_magic;
-#endif
-	unsigned long page_link;
-	unsigned int offset;
-
-	unsigned int length;
-
-	__u32 dvma_address; /* A place to hang host-specific addresses at. */
-	__u32 dvma_length;
-};
-
-#define sg_dma_address(sg) ((sg)->dvma_address)
-#define sg_dma_len(sg)     ((sg)->dvma_length)
-
-#define ISA_DMA_THRESHOLD (~0UL)
-
-#define ARCH_HAS_SG_CHAIN
-
-#endif /* !(_SPARC_SCATTERLIST_H) */
diff --git a/arch/sparc/include/asm/scatterlist_64.h b/arch/sparc/include/asm/scatterlist_64.h
deleted file mode 100644
index 81bd058..0000000
--- a/arch/sparc/include/asm/scatterlist_64.h
+++ /dev/null
@@ -1,27 +0,0 @@
-#ifndef _SPARC64_SCATTERLIST_H
-#define _SPARC64_SCATTERLIST_H
-
-#include <asm/page.h>
-#include <asm/types.h>
-
-struct scatterlist {
-#ifdef CONFIG_DEBUG_SG
-	unsigned long	sg_magic;
-#endif
-	unsigned long	page_link;
-	unsigned int	offset;
-
-	unsigned int	length;
-
-	dma_addr_t	dma_address;
-	__u32		dma_length;
-};
-
-#define sg_dma_address(sg)	((sg)->dma_address)
-#define sg_dma_len(sg)     	((sg)->dma_length)
-
-#define ISA_DMA_THRESHOLD	(~0UL)
-
-#define ARCH_HAS_SG_CHAIN
-
-#endif /* !(_SPARC64_SCATTERLIST_H) */
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 4f025b3..7ce14f0 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -552,8 +552,8 @@ int pci_map_sg(struct pci_dev *hwdev, struct scatterlist *sgl, int nents,
 	/* IIep is write-through, not flushing. */
 	for_each_sg(sgl, sg, nents, n) {
 		BUG_ON(page_address(sg_page(sg)) == NULL);
-		sg->dvma_address = virt_to_phys(sg_virt(sg));
-		sg->dvma_length = sg->length;
+		sg->dma_address = virt_to_phys(sg_virt(sg));
+		sg->dma_length = sg->length;
 	}
 	return nents;
 }
diff --git a/arch/sparc/mm/io-unit.c b/arch/sparc/mm/io-unit.c
index daadf5f..005e758 100644
--- a/arch/sparc/mm/io-unit.c
+++ b/arch/sparc/mm/io-unit.c
@@ -156,8 +156,8 @@ static void iounit_get_scsi_sgl(struct device *dev, struct scatterlist *sg, int
 	spin_lock_irqsave(&iounit->lock, flags);
 	while (sz != 0) {
 		--sz;
-		sg->dvma_address = iounit_get_area(iounit, (unsigned long) sg_virt(sg), sg->length);
-		sg->dvma_length = sg->length;
+		sg->dma_address = iounit_get_area(iounit, (unsigned long) sg_virt(sg), sg->length);
+		sg->dma_length = sg->length;
 		sg = sg_next(sg);
 	}
 	spin_unlock_irqrestore(&iounit->lock, flags);
@@ -186,8 +186,8 @@ static void iounit_release_scsi_sgl(struct device *dev, struct scatterlist *sg,
 	spin_lock_irqsave(&iounit->lock, flags);
 	while (sz != 0) {
 		--sz;
-		len = ((sg->dvma_address & ~PAGE_MASK) + sg->length + (PAGE_SIZE-1)) >> PAGE_SHIFT;
-		vaddr = (sg->dvma_address - IOUNIT_DMA_BASE) >> PAGE_SHIFT;
+		len = ((sg->dma_address & ~PAGE_MASK) + sg->length + (PAGE_SIZE-1)) >> PAGE_SHIFT;
+		vaddr = (sg->dma_address - IOUNIT_DMA_BASE) >> PAGE_SHIFT;
 		IOD(("iounit_release %08lx-%08lx\n", (long)vaddr, (long)len+vaddr));
 		for (len += vaddr; vaddr < len; vaddr++)
 			clear_bit(vaddr, iounit->bmap);
diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index e7a499e..b2e6e73 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -245,8 +245,8 @@ static void iommu_get_scsi_sgl_noflush(struct device *dev, struct scatterlist *s
 	while (sz != 0) {
 		--sz;
 		n = (sg->length + sg->offset + PAGE_SIZE-1) >> PAGE_SHIFT;
-		sg->dvma_address = iommu_get_one(dev, sg_page(sg), n) + sg->offset;
-		sg->dvma_length = (__u32) sg->length;
+		sg->dma_address = iommu_get_one(dev, sg_page(sg), n) + sg->offset;
+		sg->dma_length = sg->length;
 		sg = sg_next(sg);
 	}
 }
@@ -259,8 +259,8 @@ static void iommu_get_scsi_sgl_gflush(struct device *dev, struct scatterlist *sg
 	while (sz != 0) {
 		--sz;
 		n = (sg->length + sg->offset + PAGE_SIZE-1) >> PAGE_SHIFT;
-		sg->dvma_address = iommu_get_one(dev, sg_page(sg), n) + sg->offset;
-		sg->dvma_length = (__u32) sg->length;
+		sg->dma_address = iommu_get_one(dev, sg_page(sg), n) + sg->offset;
+		sg->dma_length = sg->length;
 		sg = sg_next(sg);
 	}
 }
@@ -290,8 +290,8 @@ static void iommu_get_scsi_sgl_pflush(struct device *dev, struct scatterlist *sg
 			}
 		}
 
-		sg->dvma_address = iommu_get_one(dev, sg_page(sg), n) + sg->offset;
-		sg->dvma_length = (__u32) sg->length;
+		sg->dma_address = iommu_get_one(dev, sg_page(sg), n) + sg->offset;
+		sg->dma_length = sg->length;
 		sg = sg_next(sg);
 	}
 }
@@ -330,8 +330,8 @@ static void iommu_release_scsi_sgl(struct device *dev, struct scatterlist *sg, i
 		--sz;
 
 		n = (sg->length + sg->offset + PAGE_SIZE-1) >> PAGE_SHIFT;
-		iommu_release_one(dev, sg->dvma_address & PAGE_MASK, n);
-		sg->dvma_address = 0x21212121;
+		iommu_release_one(dev, sg->dma_address & PAGE_MASK, n);
+		sg->dma_address = 0x21212121;
 		sg = sg_next(sg);
 	}
 }
diff --git a/arch/sparc/mm/sun4c.c b/arch/sparc/mm/sun4c.c
index 6b0c490..ad0ce11 100644
--- a/arch/sparc/mm/sun4c.c
+++ b/arch/sparc/mm/sun4c.c
@@ -1122,8 +1122,8 @@ static void sun4c_get_scsi_sgl(struct device *dev, struct scatterlist *sg, int s
 {
 	while (sz != 0) {
 		--sz;
-		sg->dvma_address = (__u32)sun4c_lockarea(sg_virt(sg), sg->length);
-		sg->dvma_length = sg->length;
+		sg->dma_address = (__u32)sun4c_lockarea(sg_virt(sg), sg->length);
+		sg->dma_length = sg->length;
 		sg = sg_next(sg);
 	}
 }
@@ -1139,7 +1139,7 @@ static void sun4c_release_scsi_sgl(struct device *dev, struct scatterlist *sg, i
 {
 	while (sz != 0) {
 		--sz;
-		sun4c_unlockarea((char *)sg->dvma_address, sg->length);
+		sun4c_unlockarea((char *)sg->dma_address, sg->length);
 		sg = sg_next(sg);
 	}
 }

--------------000006070500080205020800--
