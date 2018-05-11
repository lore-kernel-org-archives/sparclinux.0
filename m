From: Christoph Hellwig <hch@lst.de>
Date: Fri, 11 May 2018 07:59:33 +0000
Subject: [PATCH 08/20] microblaze: use generic dma_noncoherent_ops
Message-Id: <20180511075945.16548-9-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180511075945.16548-1-hch@lst.de>
In-Reply-To: <20180511075945.16548-1-hch-jcswGhMUV9g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org, Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, Vincent Chen <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org, openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org, Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org, linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org

Switch to the generic noncoherent direct mapping implementation.

This removes the direction-based optimizations in
sync_{single,sg}_for_{cpu,device} which were marked untestested and
do not match the usually very well tested {un,}map_{single,sg}
implementations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/microblaze/Kconfig                   |   4 +
 arch/microblaze/include/asm/Kbuild        |   1 +
 arch/microblaze/include/asm/dma-mapping.h |  28 -----
 arch/microblaze/include/asm/pgtable.h     |   2 -
 arch/microblaze/kernel/dma.c              | 144 ++--------------------
 arch/microblaze/mm/consistent.c           |   9 +-
 6 files changed, 22 insertions(+), 166 deletions(-)
 delete mode 100644 arch/microblaze/include/asm/dma-mapping.h

diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index d14782100088..848e31a86ba5 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -1,6 +1,8 @@
 config MICROBLAZE
 	def_bool y
 	select ARCH_HAS_GCOV_PROFILE_ALL
+	select ARCH_HAS_SYNC_DMA_FOR_CPU
+	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
 	select ARCH_WANT_IPC_PARSE_VERSION
@@ -8,6 +10,8 @@ config MICROBLAZE
 	select TIMER_OF
 	select CLONE_BACKWARDS3
 	select COMMON_CLK
+	select DMA_NONCOHERENT_OPS
+	select DMA_NONCOHERENT_MMAP
 	select GENERIC_ATOMIC64
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CPU_DEVICES
diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
index 3c80a5a308ed..8d3e71f43a3e 100644
--- a/arch/microblaze/include/asm/Kbuild
+++ b/arch/microblaze/include/asm/Kbuild
@@ -4,6 +4,7 @@ generic-y += bug.h
 generic-y += bugs.h
 generic-y += device.h
 generic-y += div64.h
+generic-y += dma-mapping.h
 generic-y += emergency-restart.h
 generic-y += exec.h
 generic-y += extable.h
diff --git a/arch/microblaze/include/asm/dma-mapping.h b/arch/microblaze/include/asm/dma-mapping.h
deleted file mode 100644
index add50c1373bf..000000000000
--- a/arch/microblaze/include/asm/dma-mapping.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- * Implements the generic device dma API for microblaze and the pci
- *
- * Copyright (C) 2009-2010 Michal Simek <monstr@monstr.eu>
- * Copyright (C) 2009-2010 PetaLogix
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License. See the file COPYING in the main directory of this
- * archive for more details.
- *
- * This file is base on powerpc and x86 dma-mapping.h versions
- * Copyright (C) 2004 IBM
- */
-
-#ifndef _ASM_MICROBLAZE_DMA_MAPPING_H
-#define _ASM_MICROBLAZE_DMA_MAPPING_H
-
-/*
- * Available generic sets of operations
- */
-extern const struct dma_map_ops dma_nommu_ops;
-
-static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
-{
-	return &dma_nommu_ops;
-}
-
-#endif	/* _ASM_MICROBLAZE_DMA_MAPPING_H */
diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
index db8b1fa83452..8a2e654b709f 100644
--- a/arch/microblaze/include/asm/pgtable.h
+++ b/arch/microblaze/include/asm/pgtable.h
@@ -553,8 +553,6 @@ void __init *early_get_page(void);
 
 extern unsigned long ioremap_bot, ioremap_base;
 
-void *consistent_alloc(gfp_t gfp, size_t size, dma_addr_t *dma_handle);
-void consistent_free(size_t size, void *vaddr);
 void consistent_sync(void *vaddr, size_t size, int direction);
 void consistent_sync_page(struct page *page, unsigned long offset,
 	size_t size, int direction);
diff --git a/arch/microblaze/kernel/dma.c b/arch/microblaze/kernel/dma.c
index 3145e7dc8ab1..71032cf64669 100644
--- a/arch/microblaze/kernel/dma.c
+++ b/arch/microblaze/kernel/dma.c
@@ -8,29 +8,15 @@
  */
 
 #include <linux/device.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-noncoherent.h>
 #include <linux/gfp.h>
 #include <linux/dma-debug.h>
 #include <linux/export.h>
 #include <linux/bug.h>
 #include <asm/cacheflush.h>
 
-static void *dma_nommu_alloc_coherent(struct device *dev, size_t size,
-				       dma_addr_t *dma_handle, gfp_t flag,
-				       unsigned long attrs)
-{
-	return consistent_alloc(flag, size, dma_handle);
-}
-
-static void dma_nommu_free_coherent(struct device *dev, size_t size,
-				     void *vaddr, dma_addr_t dma_handle,
-				     unsigned long attrs)
-{
-	consistent_free(size, vaddr);
-}
-
-static inline void __dma_sync(unsigned long paddr,
-			      size_t size, enum dma_data_direction direction)
+static void __dma_sync(struct device *dev, phys_addr_t paddr, size_t size,
+		enum dma_data_direction direction)
 {
 	switch (direction) {
 	case DMA_TO_DEVICE:
@@ -45,113 +31,21 @@ static inline void __dma_sync(unsigned long paddr,
 	}
 }
 
-static int dma_nommu_map_sg(struct device *dev, struct scatterlist *sgl,
-			     int nents, enum dma_data_direction direction,
-			     unsigned long attrs)
+void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir)
 {
-	struct scatterlist *sg;
-	int i;
-
-	/* FIXME this part of code is untested */
-	for_each_sg(sgl, sg, nents, i) {
-		sg->dma_address = sg_phys(sg);
-
-		if (attrs & DMA_ATTR_SKIP_CPU_SYNC)
-			continue;
-
-		__dma_sync(sg_phys(sg), sg->length, direction);
-	}
-
-	return nents;
-}
-
-static inline dma_addr_t dma_nommu_map_page(struct device *dev,
-					     struct page *page,
-					     unsigned long offset,
-					     size_t size,
-					     enum dma_data_direction direction,
-					     unsigned long attrs)
-{
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		__dma_sync(page_to_phys(page) + offset, size, direction);
-	return page_to_phys(page) + offset;
+	__dma_sync(dev, paddr, size, dir);
 }
 
-static inline void dma_nommu_unmap_page(struct device *dev,
-					 dma_addr_t dma_address,
-					 size_t size,
-					 enum dma_data_direction direction,
-					 unsigned long attrs)
+void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir)
 {
-/* There is not necessary to do cache cleanup
- *
- * phys_to_virt is here because in __dma_sync_page is __virt_to_phys and
- * dma_address is physical address
- */
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		__dma_sync(dma_address, size, direction);
+	__dma_sync(dev, paddr, size, dir);
 }
 
-static inline void
-dma_nommu_sync_single_for_cpu(struct device *dev,
-			       dma_addr_t dma_handle, size_t size,
-			       enum dma_data_direction direction)
-{
-	/*
-	 * It's pointless to flush the cache as the memory segment
-	 * is given to the CPU
-	 */
-
-	if (direction = DMA_FROM_DEVICE)
-		__dma_sync(dma_handle, size, direction);
-}
-
-static inline void
-dma_nommu_sync_single_for_device(struct device *dev,
-				  dma_addr_t dma_handle, size_t size,
-				  enum dma_data_direction direction)
-{
-	/*
-	 * It's pointless to invalidate the cache if the device isn't
-	 * supposed to write to the relevant region
-	 */
-
-	if (direction = DMA_TO_DEVICE)
-		__dma_sync(dma_handle, size, direction);
-}
-
-static inline void
-dma_nommu_sync_sg_for_cpu(struct device *dev,
-			   struct scatterlist *sgl, int nents,
-			   enum dma_data_direction direction)
-{
-	struct scatterlist *sg;
-	int i;
-
-	/* FIXME this part of code is untested */
-	if (direction = DMA_FROM_DEVICE)
-		for_each_sg(sgl, sg, nents, i)
-			__dma_sync(sg->dma_address, sg->length, direction);
-}
-
-static inline void
-dma_nommu_sync_sg_for_device(struct device *dev,
-			      struct scatterlist *sgl, int nents,
-			      enum dma_data_direction direction)
-{
-	struct scatterlist *sg;
-	int i;
-
-	/* FIXME this part of code is untested */
-	if (direction = DMA_TO_DEVICE)
-		for_each_sg(sgl, sg, nents, i)
-			__dma_sync(sg->dma_address, sg->length, direction);
-}
-
-static
-int dma_nommu_mmap_coherent(struct device *dev, struct vm_area_struct *vma,
-			     void *cpu_addr, dma_addr_t handle, size_t size,
-			     unsigned long attrs)
+int arch_dma_mmap(struct device *dev, struct vm_area_struct *vma,
+		void *cpu_addr, dma_addr_t handle, size_t size,
+		unsigned long attrs)
 {
 #ifdef CONFIG_MMU
 	unsigned long user_count = vma_pages(vma);
@@ -170,17 +64,3 @@ int dma_nommu_mmap_coherent(struct device *dev, struct vm_area_struct *vma,
 	return -ENXIO;
 #endif
 }
-
-const struct dma_map_ops dma_nommu_ops = {
-	.alloc			= dma_nommu_alloc_coherent,
-	.free			= dma_nommu_free_coherent,
-	.mmap			= dma_nommu_mmap_coherent,
-	.map_sg			= dma_nommu_map_sg,
-	.map_page		= dma_nommu_map_page,
-	.unmap_page		= dma_nommu_unmap_page,
-	.sync_single_for_cpu	= dma_nommu_sync_single_for_cpu,
-	.sync_single_for_device	= dma_nommu_sync_single_for_device,
-	.sync_sg_for_cpu	= dma_nommu_sync_sg_for_cpu,
-	.sync_sg_for_device	= dma_nommu_sync_sg_for_device,
-};
-EXPORT_SYMBOL(dma_nommu_ops);
diff --git a/arch/microblaze/mm/consistent.c b/arch/microblaze/mm/consistent.c
index b06c3a7faf20..b9a9c8c3397b 100644
--- a/arch/microblaze/mm/consistent.c
+++ b/arch/microblaze/mm/consistent.c
@@ -33,6 +33,7 @@
 #include <linux/pci.h>
 #include <linux/interrupt.h>
 #include <linux/gfp.h>
+#include <linux/dma-noncoherent.h>
 
 #include <asm/pgalloc.h>
 #include <linux/io.h>
@@ -59,7 +60,8 @@
  * uncached region.  This will no doubt cause big problems if memory allocated
  * here is not also freed properly. -- JW
  */
-void *consistent_alloc(gfp_t gfp, size_t size, dma_addr_t *dma_handle)
+void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
+		gfp_t gfp, unsigned long attrs)
 {
 	unsigned long order, vaddr;
 	void *ret;
@@ -154,7 +156,6 @@ void *consistent_alloc(gfp_t gfp, size_t size, dma_addr_t *dma_handle)
 
 	return ret;
 }
-EXPORT_SYMBOL(consistent_alloc);
 
 #ifdef CONFIG_MMU
 static pte_t *consistent_virt_to_pte(void *vaddr)
@@ -178,7 +179,8 @@ unsigned long consistent_virt_to_pfn(void *vaddr)
 /*
  * free page(s) as defined by the above mapping.
  */
-void consistent_free(size_t size, void *vaddr)
+void arch_dma_free(struct device *dev, size_t size, void *vaddr,
+		dma_addr_t dma_addr, unsigned long attrs)
 {
 	struct page *page;
 
@@ -218,7 +220,6 @@ void consistent_free(size_t size, void *vaddr)
 	flush_tlb_all();
 #endif
 }
-EXPORT_SYMBOL(consistent_free);
 
 /*
  * make an area consistent.
-- 
2.17.0

