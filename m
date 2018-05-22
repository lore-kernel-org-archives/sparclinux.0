From: Christoph Hellwig <hch@lst.de>
Date: Tue, 22 May 2018 12:04:09 +0000
Subject: [PATCH 04/25] m68k: use generic dma_noncoherent_ops
Message-Id: <20180522120430.28709-5-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180522120430.28709-1-hch@lst.de>
In-Reply-To: <20180522120430.28709-1-hch-jcswGhMUV9g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org, Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, Vincent Chen <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org, openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org, Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org, linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org

Switch to the generic noncoherent direct mapping implementation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/m68k/Kconfig                   |  2 +
 arch/m68k/include/asm/Kbuild        |  1 +
 arch/m68k/include/asm/dma-mapping.h | 12 -----
 arch/m68k/kernel/dma.c              | 68 ++++-------------------------
 4 files changed, 11 insertions(+), 72 deletions(-)
 delete mode 100644 arch/m68k/include/asm/dma-mapping.h

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 785612b576f7..3f61327da2d5 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -2,6 +2,7 @@
 config M68K
 	bool
 	default y
+	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if HAS_DMA
 	select ARCH_MIGHT_HAVE_PC_PARPORT if ISA
 	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
 	select HAVE_IDE
@@ -24,6 +25,7 @@ config M68K
 	select MODULES_USE_ELF_RELA
 	select OLD_SIGSUSPEND3
 	select OLD_SIGACTION
+	select DMA_NONCOHERENT_OPS if HAS_DMA
 
 config CPU_BIG_ENDIAN
 	def_bool y
diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
index 88a9d27df1ac..a853c00f1374 100644
--- a/arch/m68k/include/asm/Kbuild
+++ b/arch/m68k/include/asm/Kbuild
@@ -1,5 +1,6 @@
 generic-y += barrier.h
 generic-y += device.h
+generic-y += dma-mapping.h
 generic-y += emergency-restart.h
 generic-y += exec.h
 generic-y += extable.h
diff --git a/arch/m68k/include/asm/dma-mapping.h b/arch/m68k/include/asm/dma-mapping.h
deleted file mode 100644
index e3722ed04fbb..000000000000
--- a/arch/m68k/include/asm/dma-mapping.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _M68K_DMA_MAPPING_H
-#define _M68K_DMA_MAPPING_H
-
-extern const struct dma_map_ops m68k_dma_ops;
-
-static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
-{
-        return &m68k_dma_ops;
-}
-
-#endif  /* _M68K_DMA_MAPPING_H */
diff --git a/arch/m68k/kernel/dma.c b/arch/m68k/kernel/dma.c
index c01b9b8f97bf..3d561c577d35 100644
--- a/arch/m68k/kernel/dma.c
+++ b/arch/m68k/kernel/dma.c
@@ -6,7 +6,7 @@
 
 #undef DEBUG
 
-#include <linux/dma-mapping.h>
+#include <linux/dma-noncoherent.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/scatterlist.h>
@@ -18,7 +18,7 @@
 
 #if defined(CONFIG_MMU) && !defined(CONFIG_COLDFIRE)
 
-static void *m68k_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
+void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 		gfp_t flag, unsigned long attrs)
 {
 	struct page *page, **map;
@@ -61,7 +61,7 @@ static void *m68k_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 	return addr;
 }
 
-static void m68k_dma_free(struct device *dev, size_t size, void *addr,
+void arch_dma_free(struct device *dev, size_t size, void *addr,
 		dma_addr_t handle, unsigned long attrs)
 {
 	pr_debug("dma_free_coherent: %p, %x\n", addr, handle);
@@ -72,8 +72,8 @@ static void m68k_dma_free(struct device *dev, size_t size, void *addr,
 
 #include <asm/cacheflush.h>
 
-static void *m68k_dma_alloc(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
+void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
+		gfp_t gfp, unsigned long attrs)
 {
 	void *ret;
 
@@ -88,7 +88,7 @@ static void *m68k_dma_alloc(struct device *dev, size_t size,
 	return ret;
 }
 
-static void m68k_dma_free(struct device *dev, size_t size, void *vaddr,
+void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 		dma_addr_t dma_handle, unsigned long attrs)
 {
 	free_pages((unsigned long)vaddr, get_order(size));
@@ -96,8 +96,8 @@ static void m68k_dma_free(struct device *dev, size_t size, void *vaddr,
 
 #endif /* CONFIG_MMU && !CONFIG_COLDFIRE */
 
-static void m68k_dma_sync_single_for_device(struct device *dev,
-		dma_addr_t handle, size_t size, enum dma_data_direction dir)
+void arch_sync_dma_for_device(struct device *dev, phys_addr_t handle,
+		size_t size, enum dma_data_direction dir)
 {
 	switch (dir) {
 	case DMA_BIDIRECTIONAL:
@@ -113,55 +113,3 @@ static void m68k_dma_sync_single_for_device(struct device *dev,
 		break;
 	}
 }
-
-static void m68k_dma_sync_sg_for_device(struct device *dev,
-		struct scatterlist *sglist, int nents, enum dma_data_direction dir)
-{
-	int i;
-	struct scatterlist *sg;
-
-	for_each_sg(sglist, sg, nents, i) {
-		dma_sync_single_for_device(dev, sg->dma_address, sg->length,
-					   dir);
-	}
-}
-
-static dma_addr_t m68k_dma_map_page(struct device *dev, struct page *page,
-		unsigned long offset, size_t size, enum dma_data_direction dir,
-		unsigned long attrs)
-{
-	dma_addr_t handle = page_to_phys(page) + offset;
-
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		dma_sync_single_for_device(dev, handle, size, dir);
-
-	return handle;
-}
-
-static int m68k_dma_map_sg(struct device *dev, struct scatterlist *sglist,
-		int nents, enum dma_data_direction dir, unsigned long attrs)
-{
-	int i;
-	struct scatterlist *sg;
-
-	for_each_sg(sglist, sg, nents, i) {
-		sg->dma_address = sg_phys(sg);
-
-		if (attrs & DMA_ATTR_SKIP_CPU_SYNC)
-			continue;
-
-		dma_sync_single_for_device(dev, sg->dma_address, sg->length,
-					   dir);
-	}
-	return nents;
-}
-
-const struct dma_map_ops m68k_dma_ops = {
-	.alloc			= m68k_dma_alloc,
-	.free			= m68k_dma_free,
-	.map_page		= m68k_dma_map_page,
-	.map_sg			= m68k_dma_map_sg,
-	.sync_single_for_device	= m68k_dma_sync_single_for_device,
-	.sync_sg_for_device	= m68k_dma_sync_sg_for_device,
-};
-EXPORT_SYMBOL(m68k_dma_ops);
-- 
2.17.0

