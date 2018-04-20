From: Christoph Hellwig <hch@lst.de>
Date: Fri, 20 Apr 2018 08:03:04 +0000
Subject: [PATCH 13/22] nds32: use generic dma_noncoherent_ops
Message-Id: <20180420080313.18796-14-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180420080313.18796-1-hch@lst.de>
In-Reply-To: <20180420080313.18796-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org

Switch to the generic noncoherent direct mapping implementation.

This makes sure kmap_atomic_pfn is consistently used for access to
virtual addresses instead of either using the slower plain kmap
or blindly expecting page_address() to work.

This makes sure the cache_sync routines is called in the unmap_sg
case, to match the unmap_single and sync_{single,sg}_to_cpu cases.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/nds32/Kconfig                   |   3 +
 arch/nds32/include/asm/Kbuild        |   1 +
 arch/nds32/include/asm/dma-mapping.h |  14 ---
 arch/nds32/kernel/dma.c              | 182 ++++++---------------------
 4 files changed, 39 insertions(+), 161 deletions(-)
 delete mode 100644 arch/nds32/include/asm/dma-mapping.h

diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
index 249f38d3388f..67d0ac0a989c 100644
--- a/arch/nds32/Kconfig
+++ b/arch/nds32/Kconfig
@@ -5,10 +5,13 @@
 
 config NDS32
         def_bool y
+	select ARCH_HAS_SYNC_DMA_FOR_CPU
+	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_WANT_FRAME_POINTERS if FTRACE
 	select CLKSRC_MMIO
 	select CLONE_BACKWARDS
 	select COMMON_CLK
+	select DMA_NONCOHERENT_OPS
 	select GENERIC_ATOMIC64
 	select GENERIC_CPU_DEVICES
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/nds32/include/asm/Kbuild b/arch/nds32/include/asm/Kbuild
index 06bdf8167f5a..b3e951f805f8 100644
--- a/arch/nds32/include/asm/Kbuild
+++ b/arch/nds32/include/asm/Kbuild
@@ -13,6 +13,7 @@ generic-y += cputime.h
 generic-y += device.h
 generic-y += div64.h
 generic-y += dma.h
+generic-y += dma-mapping.h
 generic-y += emergency-restart.h
 generic-y += errno.h
 generic-y += exec.h
diff --git a/arch/nds32/include/asm/dma-mapping.h b/arch/nds32/include/asm/dma-mapping.h
deleted file mode 100644
index 2dd47d245c25..000000000000
--- a/arch/nds32/include/asm/dma-mapping.h
+++ /dev/null
@@ -1,14 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#ifndef ASMNDS32_DMA_MAPPING_H
-#define ASMNDS32_DMA_MAPPING_H
-
-extern struct dma_map_ops nds32_dma_ops;
-
-static inline struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
-{
-	return &nds32_dma_ops;
-}
-
-#endif
diff --git a/arch/nds32/kernel/dma.c b/arch/nds32/kernel/dma.c
index d291800fc621..688f1a03dee6 100644
--- a/arch/nds32/kernel/dma.c
+++ b/arch/nds32/kernel/dma.c
@@ -3,17 +3,14 @@
 
 #include <linux/types.h>
 #include <linux/mm.h>
-#include <linux/export.h>
 #include <linux/string.h>
-#include <linux/scatterlist.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-noncoherent.h>
 #include <linux/io.h>
 #include <linux/cache.h>
 #include <linux/highmem.h>
 #include <linux/slab.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
-#include <asm/dma-mapping.h>
 #include <asm/proc-fns.h>
 
 /*
@@ -22,11 +19,6 @@
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
@@ -124,10 +116,8 @@ static struct arch_vm_region *vm_region_find(struct arch_vm_region *head,
 	return c;
 }
 
-/* FIXME: attrs is not used. */
-static void *nds32_dma_alloc_coherent(struct device *dev, size_t size,
-				      dma_addr_t * handle, gfp_t gfp,
-				      unsigned long attrs)
+void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
+		gfp_t gfp, unsigned long attrs)
 {
 	struct page *page;
 	struct arch_vm_region *c;
@@ -232,8 +222,8 @@ static void *nds32_dma_alloc_coherent(struct device *dev, size_t size,
 	return NULL;
 }
 
-static void nds32_dma_free(struct device *dev, size_t size, void *cpu_addr,
-			   dma_addr_t handle, unsigned long attrs)
+void arch_dma_free(struct device *dev, size_t size, void *cpu_addr,
+		dma_addr_t handle, unsigned long attrs)
 {
 	struct arch_vm_region *c;
 	unsigned long flags, addr;
@@ -333,145 +323,43 @@ static int __init consistent_init(void)
 }
 
 core_initcall(consistent_init);
-static void consistent_sync(void *vaddr, size_t size, int direction, int master_type);
-static dma_addr_t nds32_dma_map_page(struct device *dev, struct page *page,
-				     unsigned long offset, size_t size,
-				     enum dma_data_direction dir,
-				     unsigned long attrs)
-{
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		consistent_sync((void *)(page_address(page) + offset), size, dir, FOR_DEVICE);
-	return page_to_phys(page) + offset;
-}
-
-static void nds32_dma_unmap_page(struct device *dev, dma_addr_t handle,
-				 size_t size, enum dma_data_direction dir,
-				 unsigned long attrs)
-{
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		consistent_sync(phys_to_virt(handle), size, dir, FOR_CPU);
-}
 
-/*
- * Make an area consistent for devices.
- */
-static void consistent_sync(void *vaddr, size_t size, int direction, int master_type)
+void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir)
 {
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
+	void *addr = kmap_atomic_pfn(PHYS_PFN(paddr));
+	unsigned long start = (unsigned long)addr;
+
+	switch (direction) {
+	case DMA_FROM_DEVICE:
+		break;
+	case DMA_TO_DEVICE:
+	case DMA_BIDIRECTIONAL:
+		cpu_dma_wb_range(start, start + size);
+		break;
+	default:
+		BUG();
 	}
-}
 
-static int nds32_dma_map_sg(struct device *dev, struct scatterlist *sg,
-			    int nents, enum dma_data_direction dir,
-			    unsigned long attrs)
-{
-	int i;
-
-	for (i = 0; i < nents; i++, sg++) {
-		void *virt;
-		unsigned long pfn;
-		struct page *page = sg_page(sg);
-
-		sg->dma_address = sg_phys(sg);
-		pfn = page_to_pfn(page) + sg->offset / PAGE_SIZE;
-		page = pfn_to_page(pfn);
-		if (PageHighMem(page)) {
-			virt = kmap_atomic(page);
-			consistent_sync(virt, sg->length, dir, FOR_CPU);
-			kunmap_atomic(virt);
-		} else {
-			if (sg->offset > PAGE_SIZE)
-				panic("sg->offset:%08x > PAGE_SIZE\n",
-				      sg->offset);
-			virt = page_address(page) + sg->offset;
-			consistent_sync(virt, sg->length, dir, FOR_CPU);
-		}
-	}
-	return nents;
-}
-
-static void nds32_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
-			       int nhwentries, enum dma_data_direction dir,
-			       unsigned long attrs)
-{
+	kunmap_atomic(addr);
 }
 
-static void
-nds32_dma_sync_single_for_cpu(struct device *dev, dma_addr_t handle,
-			      size_t size, enum dma_data_direction dir)
+void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir)
 {
-	consistent_sync((void *)phys_to_virt(handle), size, dir, FOR_CPU);
-}
-
-static void
-nds32_dma_sync_single_for_device(struct device *dev, dma_addr_t handle,
-				 size_t size, enum dma_data_direction dir)
-{
-	consistent_sync((void *)phys_to_virt(handle), size, dir, FOR_DEVICE);
-}
-
-static void
-nds32_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg, int nents,
-			  enum dma_data_direction dir)
-{
-	int i;
-
-	for (i = 0; i < nents; i++, sg++) {
-		char *virt -		    page_address((struct page *)sg->page_link) + sg->offset;
-		consistent_sync(virt, sg->length, dir, FOR_CPU);
+	void *addr = kmap_atomic_pfn(PHYS_PFN(paddr));
+	unsigned long start = (unsigned long)addr;
+
+	switch (direction) {
+	case DMA_TO_DEVICE:
+		break;
+	case DMA_FROM_DEVICE:
+	case DMA_BIDIRECTIONAL:
+		cpu_dma_inval_range(start, end);
+		break;
+	default:
+		BUG();
 	}
-}
-
-static void
-nds32_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
-			     int nents, enum dma_data_direction dir)
-{
-	int i;
 
-	for (i = 0; i < nents; i++, sg++) {
-		char *virt -		    page_address((struct page *)sg->page_link) + sg->offset;
-		consistent_sync(virt, sg->length, dir, FOR_DEVICE);
-	}
+	kunmap_atomic(addr);
 }
-
-struct dma_map_ops nds32_dma_ops = {
-	.alloc = nds32_dma_alloc_coherent,
-	.free = nds32_dma_free,
-	.map_page = nds32_dma_map_page,
-	.unmap_page = nds32_dma_unmap_page,
-	.map_sg = nds32_dma_map_sg,
-	.unmap_sg = nds32_dma_unmap_sg,
-	.sync_single_for_device = nds32_dma_sync_single_for_device,
-	.sync_single_for_cpu = nds32_dma_sync_single_for_cpu,
-	.sync_sg_for_cpu = nds32_dma_sync_sg_for_cpu,
-	.sync_sg_for_device = nds32_dma_sync_sg_for_device,
-};
-
-EXPORT_SYMBOL(nds32_dma_ops);
-- 
2.17.0

