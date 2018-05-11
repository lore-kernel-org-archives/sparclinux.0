From: Christoph Hellwig <hch@lst.de>
Date: Fri, 11 May 2018 07:59:28 +0000
Subject: [PATCH 03/20] arc: use generic dma_noncoherent_ops
Message-Id: <20180511075945.16548-4-hch@lst.de>
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
 arch/arc/Kconfig                   |   4 +
 arch/arc/include/asm/Kbuild        |   1 +
 arch/arc/include/asm/dma-mapping.h |  21 -----
 arch/arc/mm/dma.c                  | 141 +++--------------------------
 4 files changed, 19 insertions(+), 148 deletions(-)
 delete mode 100644 arch/arc/include/asm/dma-mapping.h

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 7498aca4b887..89d47eac18b2 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -9,11 +9,15 @@
 config ARC
 	def_bool y
 	select ARC_TIMERS
+	select ARCH_HAS_SYNC_DMA_FOR_CPU
+	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_HAS_SG_CHAIN
 	select ARCH_SUPPORTS_ATOMIC_RMW if ARC_HAS_LLSC
 	select BUILDTIME_EXTABLE_SORT
 	select CLONE_BACKWARDS
 	select COMMON_CLK
+	select DMA_NONCOHERENT_OPS
+	select DMA_NONCOHERENT_MMAP
 	select GENERIC_ATOMIC64 if !ISA_ARCV2 || !(ARC_HAS_LL64 && ARC_HAS_LLSC)
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_FIND_FIRST_BIT
diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild
index 4bd5d4369e05..bbdcb955e18f 100644
--- a/arch/arc/include/asm/Kbuild
+++ b/arch/arc/include/asm/Kbuild
@@ -2,6 +2,7 @@
 generic-y += bugs.h
 generic-y += device.h
 generic-y += div64.h
+generic-y += dma-mapping.h
 generic-y += emergency-restart.h
 generic-y += extable.h
 generic-y += fb.h
diff --git a/arch/arc/include/asm/dma-mapping.h b/arch/arc/include/asm/dma-mapping.h
deleted file mode 100644
index 7a16824bfe98..000000000000
--- a/arch/arc/include/asm/dma-mapping.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * DMA Mapping glue for ARC
- *
- * Copyright (C) 2004, 2007-2010, 2011-2012 Synopsys, Inc. (www.synopsys.com)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef ASM_ARC_DMA_MAPPING_H
-#define ASM_ARC_DMA_MAPPING_H
-
-extern const struct dma_map_ops arc_dma_ops;
-
-static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
-{
-	return &arc_dma_ops;
-}
-
-#endif
diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
index 1dcc404b5aec..e4cd485517b4 100644
--- a/arch/arc/mm/dma.c
+++ b/arch/arc/mm/dma.c
@@ -16,13 +16,12 @@
  * The default DMA address = Phy address which is 0x8000_0000 based.
  */
 
-#include <linux/dma-mapping.h>
+#include <linux/dma-noncoherent.h>
 #include <asm/cache.h>
 #include <asm/cacheflush.h>
 
-
-static void *arc_dma_alloc(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
+void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
+		gfp_t gfp, unsigned long attrs)
 {
 	unsigned long order = get_order(size);
 	struct page *page;
@@ -89,7 +88,7 @@ static void *arc_dma_alloc(struct device *dev, size_t size,
 	return kvaddr;
 }
 
-static void arc_dma_free(struct device *dev, size_t size, void *vaddr,
+void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 		dma_addr_t dma_handle, unsigned long attrs)
 {
 	phys_addr_t paddr = dma_handle;
@@ -105,9 +104,9 @@ static void arc_dma_free(struct device *dev, size_t size, void *vaddr,
 	__free_pages(page, get_order(size));
 }
 
-static int arc_dma_mmap(struct device *dev, struct vm_area_struct *vma,
-			void *cpu_addr, dma_addr_t dma_addr, size_t size,
-			unsigned long attrs)
+int arch_dma_mmap(struct device *dev, struct vm_area_struct *vma,
+		void *cpu_addr, dma_addr_t dma_addr, size_t size,
+		unsigned long attrs)
 {
 	unsigned long user_count = vma_pages(vma);
 	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
@@ -135,7 +134,7 @@ static int arc_dma_mmap(struct device *dev, struct vm_area_struct *vma,
  * CPU accesses page via normal paddr, thus needs to explicitly made
  * consistent before each use
  */
-static void _dma_cache_sync(phys_addr_t paddr, size_t size,
+static void _dma_cache_sync(struct device *dev, phys_addr_t paddr, size_t size,
 		enum dma_data_direction dir)
 {
 	switch (dir) {
@@ -153,126 +152,14 @@ static void _dma_cache_sync(phys_addr_t paddr, size_t size,
 	}
 }
 
-/*
- * arc_dma_map_page - map a portion of a page for streaming DMA
- *
- * Ensure that any data held in the cache is appropriately discarded
- * or written back.
- *
- * The device owns this memory once this call has completed.  The CPU
- * can regain ownership by calling dma_unmap_page().
- *
- * Note: while it takes struct page as arg, caller can "abuse" it to pass
- * a region larger than PAGE_SIZE, provided it is physically contiguous
- * and this still works correctly
- */
-static dma_addr_t arc_dma_map_page(struct device *dev, struct page *page,
-		unsigned long offset, size_t size, enum dma_data_direction dir,
-		unsigned long attrs)
-{
-	phys_addr_t paddr = page_to_phys(page) + offset;
-
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		_dma_cache_sync(paddr, size, dir);
-
-	return paddr;
-}
-
-/*
- * arc_dma_unmap_page - unmap a buffer previously mapped through dma_map_page()
- *
- * After this call, reads by the CPU to the buffer are guaranteed to see
- * whatever the device wrote there.
- *
- * Note: historically this routine was not implemented for ARC
- */
-static void arc_dma_unmap_page(struct device *dev, dma_addr_t handle,
-			       size_t size, enum dma_data_direction dir,
-			       unsigned long attrs)
-{
-	phys_addr_t paddr = handle;
-
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		_dma_cache_sync(paddr, size, dir);
-}
-
-static int arc_dma_map_sg(struct device *dev, struct scatterlist *sg,
-	   int nents, enum dma_data_direction dir, unsigned long attrs)
-{
-	struct scatterlist *s;
-	int i;
-
-	for_each_sg(sg, s, nents, i)
-		s->dma_address = dma_map_page(dev, sg_page(s), s->offset,
-					       s->length, dir);
-
-	return nents;
-}
-
-static void arc_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
-			     int nents, enum dma_data_direction dir,
-			     unsigned long attrs)
-{
-	struct scatterlist *s;
-	int i;
-
-	for_each_sg(sg, s, nents, i)
-		arc_dma_unmap_page(dev, sg_dma_address(s), sg_dma_len(s), dir,
-				   attrs);
-}
-
-static void arc_dma_sync_single_for_cpu(struct device *dev,
-		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
-{
-	_dma_cache_sync(dma_handle, size, DMA_FROM_DEVICE);
-}
-
-static void arc_dma_sync_single_for_device(struct device *dev,
-		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
+void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir)
 {
-	_dma_cache_sync(dma_handle, size, DMA_TO_DEVICE);
+	return _dma_cache_sync(dev, paddr, size, dir);
 }
 
-static void arc_dma_sync_sg_for_cpu(struct device *dev,
-		struct scatterlist *sglist, int nelems,
-		enum dma_data_direction dir)
+void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir)
 {
-	int i;
-	struct scatterlist *sg;
-
-	for_each_sg(sglist, sg, nelems, i)
-		_dma_cache_sync(sg_phys(sg), sg->length, dir);
+	return _dma_cache_sync(dev, paddr, size, dir);
 }
-
-static void arc_dma_sync_sg_for_device(struct device *dev,
-		struct scatterlist *sglist, int nelems,
-		enum dma_data_direction dir)
-{
-	int i;
-	struct scatterlist *sg;
-
-	for_each_sg(sglist, sg, nelems, i)
-		_dma_cache_sync(sg_phys(sg), sg->length, dir);
-}
-
-static int arc_dma_supported(struct device *dev, u64 dma_mask)
-{
-	/* Support 32 bit DMA mask exclusively */
-	return dma_mask = DMA_BIT_MASK(32);
-}
-
-const struct dma_map_ops arc_dma_ops = {
-	.alloc			= arc_dma_alloc,
-	.free			= arc_dma_free,
-	.mmap			= arc_dma_mmap,
-	.map_page		= arc_dma_map_page,
-	.unmap_page		= arc_dma_unmap_page,
-	.map_sg			= arc_dma_map_sg,
-	.unmap_sg		= arc_dma_unmap_sg,
-	.sync_single_for_device	= arc_dma_sync_single_for_device,
-	.sync_single_for_cpu	= arc_dma_sync_single_for_cpu,
-	.sync_sg_for_cpu	= arc_dma_sync_sg_for_cpu,
-	.sync_sg_for_device	= arc_dma_sync_sg_for_device,
-	.dma_supported		= arc_dma_supported,
-};
-EXPORT_SYMBOL(arc_dma_ops);
-- 
2.17.0

