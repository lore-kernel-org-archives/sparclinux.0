From: Christoph Hellwig <hch@lst.de>
Date: Fri, 11 May 2018 07:59:36 +0000
Subject: [PATCH 11/20] nios2: use generic dma_noncoherent_ops
Message-Id: <20180511075945.16548-12-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180511075945.16548-1-hch@lst.de>
In-Reply-To: <20180511075945.16548-1-hch-jcswGhMUV9g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org, Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, Vincent Chen <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org, openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org, Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org, linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org

Switch to the generic noncoherent direct mapping implementation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/nios2/Kconfig                   |   3 +
 arch/nios2/include/asm/Kbuild        |   1 +
 arch/nios2/include/asm/dma-mapping.h |  20 ----
 arch/nios2/mm/dma-mapping.c          | 139 +++------------------------
 4 files changed, 17 insertions(+), 146 deletions(-)
 delete mode 100644 arch/nios2/include/asm/dma-mapping.h

diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index 3d4ec88f1db1..92035042cf62 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -1,6 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 config NIOS2
 	def_bool y
+	select ARCH_HAS_SYNC_DMA_FOR_CPU
+	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select DMA_NONCOHERENT_OPS
 	select TIMER_OF
 	select GENERIC_ATOMIC64
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/nios2/include/asm/Kbuild b/arch/nios2/include/asm/Kbuild
index d232da2cbb38..24f6ee1ee69b 100644
--- a/arch/nios2/include/asm/Kbuild
+++ b/arch/nios2/include/asm/Kbuild
@@ -8,6 +8,7 @@ generic-y += current.h
 generic-y += device.h
 generic-y += div64.h
 generic-y += dma.h
+generic-y += dma-mapping.h
 generic-y += emergency-restart.h
 generic-y += exec.h
 generic-y += extable.h
diff --git a/arch/nios2/include/asm/dma-mapping.h b/arch/nios2/include/asm/dma-mapping.h
deleted file mode 100644
index 6ceb92251da0..000000000000
--- a/arch/nios2/include/asm/dma-mapping.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- * Copyright (C) 2011 Tobias Klauser <tklauser@distanz.ch>
- * Copyright (C) 2009 Wind River Systems Inc
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License.  See the file COPYING in the main directory of this
- * archive for more details.
- */
-
-#ifndef _ASM_NIOS2_DMA_MAPPING_H
-#define _ASM_NIOS2_DMA_MAPPING_H
-
-extern const struct dma_map_ops nios2_dma_ops;
-
-static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
-{
-	return &nios2_dma_ops;
-}
-
-#endif /* _ASM_NIOS2_DMA_MAPPING_H */
diff --git a/arch/nios2/mm/dma-mapping.c b/arch/nios2/mm/dma-mapping.c
index 4be815519dd4..4af9e5b5ba1c 100644
--- a/arch/nios2/mm/dma-mapping.c
+++ b/arch/nios2/mm/dma-mapping.c
@@ -12,18 +12,18 @@
 
 #include <linux/types.h>
 #include <linux/mm.h>
-#include <linux/export.h>
 #include <linux/string.h>
-#include <linux/scatterlist.h>
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
 #include <linux/cache.h>
 #include <asm/cacheflush.h>
 
-static inline void __dma_sync_for_device(void *vaddr, size_t size,
-			      enum dma_data_direction direction)
+void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir)
 {
-	switch (direction) {
+	void *vaddr = phys_to_virt(paddr);
+
+	switch (dir) {
 	case DMA_FROM_DEVICE:
 		invalidate_dcache_range((unsigned long)vaddr,
 			(unsigned long)(vaddr + size));
@@ -42,10 +42,12 @@ static inline void __dma_sync_for_device(void *vaddr, size_t size,
 	}
 }
 
-static inline void __dma_sync_for_cpu(void *vaddr, size_t size,
-			      enum dma_data_direction direction)
+void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir)
 {
-	switch (direction) {
+	void *vaddr = phys_to_virt(paddr);
+
+	switch (dir) {
 	case DMA_BIDIRECTIONAL:
 	case DMA_FROM_DEVICE:
 		invalidate_dcache_range((unsigned long)vaddr,
@@ -58,8 +60,8 @@ static inline void __dma_sync_for_cpu(void *vaddr, size_t size,
 	}
 }
 
-static void *nios2_dma_alloc(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
+void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
+		gfp_t gfp, unsigned long attrs)
 {
 	void *ret;
 
@@ -80,125 +82,10 @@ static void *nios2_dma_alloc(struct device *dev, size_t size,
 	return ret;
 }
 
-static void nios2_dma_free(struct device *dev, size_t size, void *vaddr,
+void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 		dma_addr_t dma_handle, unsigned long attrs)
 {
 	unsigned long addr = (unsigned long) CAC_ADDR((unsigned long) vaddr);
 
 	free_pages(addr, get_order(size));
 }
-
-static int nios2_dma_map_sg(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction direction,
-		unsigned long attrs)
-{
-	int i;
-
-	for_each_sg(sg, sg, nents, i) {
-		void *addr = sg_virt(sg);
-
-		if (!addr)
-			continue;
-
-		sg->dma_address = sg_phys(sg);
-
-		if (attrs & DMA_ATTR_SKIP_CPU_SYNC)
-			continue;
-
-		__dma_sync_for_device(addr, sg->length, direction);
-	}
-
-	return nents;
-}
-
-static dma_addr_t nios2_dma_map_page(struct device *dev, struct page *page,
-			unsigned long offset, size_t size,
-			enum dma_data_direction direction,
-			unsigned long attrs)
-{
-	void *addr = page_address(page) + offset;
-
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		__dma_sync_for_device(addr, size, direction);
-
-	return page_to_phys(page) + offset;
-}
-
-static void nios2_dma_unmap_page(struct device *dev, dma_addr_t dma_address,
-		size_t size, enum dma_data_direction direction,
-		unsigned long attrs)
-{
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		__dma_sync_for_cpu(phys_to_virt(dma_address), size, direction);
-}
-
-static void nios2_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
-		int nhwentries, enum dma_data_direction direction,
-		unsigned long attrs)
-{
-	void *addr;
-	int i;
-
-	if (direction = DMA_TO_DEVICE)
-		return;
-
-	if (attrs & DMA_ATTR_SKIP_CPU_SYNC)
-		return;
-
-	for_each_sg(sg, sg, nhwentries, i) {
-		addr = sg_virt(sg);
-		if (addr)
-			__dma_sync_for_cpu(addr, sg->length, direction);
-	}
-}
-
-static void nios2_dma_sync_single_for_cpu(struct device *dev,
-		dma_addr_t dma_handle, size_t size,
-		enum dma_data_direction direction)
-{
-	__dma_sync_for_cpu(phys_to_virt(dma_handle), size, direction);
-}
-
-static void nios2_dma_sync_single_for_device(struct device *dev,
-		dma_addr_t dma_handle, size_t size,
-		enum dma_data_direction direction)
-{
-	__dma_sync_for_device(phys_to_virt(dma_handle), size, direction);
-}
-
-static void nios2_dma_sync_sg_for_cpu(struct device *dev,
-		struct scatterlist *sg, int nelems,
-		enum dma_data_direction direction)
-{
-	int i;
-
-	/* Make sure that gcc doesn't leave the empty loop body.  */
-	for_each_sg(sg, sg, nelems, i)
-		__dma_sync_for_cpu(sg_virt(sg), sg->length, direction);
-}
-
-static void nios2_dma_sync_sg_for_device(struct device *dev,
-		struct scatterlist *sg, int nelems,
-		enum dma_data_direction direction)
-{
-	int i;
-
-	/* Make sure that gcc doesn't leave the empty loop body.  */
-	for_each_sg(sg, sg, nelems, i)
-		__dma_sync_for_device(sg_virt(sg), sg->length, direction);
-
-}
-
-const struct dma_map_ops nios2_dma_ops = {
-	.alloc			= nios2_dma_alloc,
-	.free			= nios2_dma_free,
-	.map_page		= nios2_dma_map_page,
-	.unmap_page		= nios2_dma_unmap_page,
-	.map_sg			= nios2_dma_map_sg,
-	.unmap_sg		= nios2_dma_unmap_sg,
-	.sync_single_for_device	= nios2_dma_sync_single_for_device,
-	.sync_single_for_cpu	= nios2_dma_sync_single_for_cpu,
-	.sync_sg_for_cpu	= nios2_dma_sync_sg_for_cpu,
-	.sync_sg_for_device	= nios2_dma_sync_sg_for_device,
-};
-EXPORT_SYMBOL(nios2_dma_ops);
-- 
2.17.0

