From: Christoph Hellwig <hch@lst.de>
Date: Tue, 22 May 2018 12:04:20 +0000
Subject: [PATCH 15/25] openrisc: use generic dma_noncoherent_ops
Message-Id: <20180522120430.28709-16-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180522120430.28709-1-hch@lst.de>
In-Reply-To: <20180522120430.28709-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>, Vincent Chen <deanbo422@gmail.com>, linux-c6x-dev@linux-c6x.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, nios2-dev@lists.rocketboards.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Switch to the generic noncoherent direct mapping implementation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/openrisc/Kconfig                   |  2 +
 arch/openrisc/include/asm/Kbuild        |  1 +
 arch/openrisc/include/asm/dma-mapping.h | 35 -------------
 arch/openrisc/kernel/dma.c              | 65 ++++---------------------
 4 files changed, 12 insertions(+), 91 deletions(-)
 delete mode 100644 arch/openrisc/include/asm/dma-mapping.h

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 9ecad05bfc73..65e3c574c9d3 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -6,6 +6,8 @@
 
 config OPENRISC
 	def_bool y
+	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select DMA_NONCOHERENT_OPS
 	select OF
 	select OF_EARLY_FLATTREE
 	select IRQ_DOMAIN
diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index f05c722a21f8..e663a996b612 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -6,6 +6,7 @@ generic-y += current.h
 generic-y += device.h
 generic-y += div64.h
 generic-y += dma.h
+generic-y += dma-mapping.h
 generic-y += emergency-restart.h
 generic-y += exec.h
 generic-y += extable.h
diff --git a/arch/openrisc/include/asm/dma-mapping.h b/arch/openrisc/include/asm/dma-mapping.h
deleted file mode 100644
index e212a1f0b6d2..000000000000
--- a/arch/openrisc/include/asm/dma-mapping.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/*
- * OpenRISC Linux
- *
- * Linux architectural port borrowing liberally from similar works of
- * others.  All original copyrights apply as per the original source
- * declaration.
- *
- * OpenRISC implementation:
- * Copyright (C) 2010-2011 Jonas Bonn <jonas@southpole.se>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#ifndef __ASM_OPENRISC_DMA_MAPPING_H
-#define __ASM_OPENRISC_DMA_MAPPING_H
-
-/*
- * See Documentation/DMA-API-HOWTO.txt and
- * Documentation/DMA-API.txt for documentation.
- */
-
-#include <linux/dma-debug.h>
-#include <linux/dma-mapping.h>
-
-extern const struct dma_map_ops or1k_dma_map_ops;
-
-static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
-{
-	return &or1k_dma_map_ops;
-}
-
-#endif	/* __ASM_OPENRISC_DMA_MAPPING_H */
diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
index d6a0bf1fa713..159336adfa2f 100644
--- a/arch/openrisc/kernel/dma.c
+++ b/arch/openrisc/kernel/dma.c
@@ -19,9 +19,7 @@
  * the only thing implemented properly.  The rest need looking into...
  */
 
-#include <linux/dma-mapping.h>
-#include <linux/dma-debug.h>
-#include <linux/export.h>
+#include <linux/dma-noncoherent.h>
 
 #include <asm/cpuinfo.h>
 #include <asm/spr_defs.h>
@@ -80,10 +78,9 @@ page_clear_nocache(pte_t *pte, unsigned long addr,
  * is being ignored for now; uncached but write-combined memory is a
  * missing feature of the OR1K.
  */
-static void *
-or1k_dma_alloc(struct device *dev, size_t size,
-	       dma_addr_t *dma_handle, gfp_t gfp,
-	       unsigned long attrs)
+void *
+arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
+		gfp_t gfp, unsigned long attrs)
 {
 	unsigned long va;
 	void *page;
@@ -115,9 +112,9 @@ or1k_dma_alloc(struct device *dev, size_t size,
 	return (void *)va;
 }
 
-static void
-or1k_dma_free(struct device *dev, size_t size, void *vaddr,
-	      dma_addr_t dma_handle, unsigned long attrs)
+void
+arch_dma_free(struct device *dev, size_t size, void *vaddr,
+		dma_addr_t dma_handle, unsigned long attrs)
 {
 	unsigned long va = (unsigned long)vaddr;
 	struct mm_walk walk = {
@@ -133,13 +130,10 @@ or1k_dma_free(struct device *dev, size_t size, void *vaddr,
 	free_pages_exact(vaddr, size);
 }
 
-static void
-or1k_sync_single_for_device(struct device *dev,
-			    dma_addr_t dma_handle, size_t size,
-			    enum dma_data_direction dir)
+void arch_sync_dma_for_device(struct device *dev, phys_addr_t addr, size_t size,
+		enum dma_data_direction dir)
 {
 	unsigned long cl;
-	dma_addr_t addr = dma_handle;
 	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[smp_processor_id()];
 
 	switch (dir) {
@@ -163,45 +157,4 @@ or1k_sync_single_for_device(struct device *dev,
 		 */
 		break;
 	}
-
-}
-
-static dma_addr_t
-or1k_map_page(struct device *dev, struct page *page,
-	      unsigned long offset, size_t size,
-	      enum dma_data_direction dir,
-	      unsigned long attrs)
-{
-	unsigned long cl;
-	dma_addr_t addr = page_to_phys(page) + offset;
-	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[smp_processor_id()];
-
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		or1k_sync_single_for_device(dev, addr, size, dir);
-	return addr;
 }
-
-static int
-or1k_map_sg(struct device *dev, struct scatterlist *sg,
-	    int nents, enum dma_data_direction dir,
-	    unsigned long attrs)
-{
-	struct scatterlist *s;
-	int i;
-
-	for_each_sg(sg, s, nents, i) {
-		s->dma_address = or1k_map_page(dev, sg_page(s), s->offset,
-					       s->length, dir, 0);
-	}
-
-	return nents;
-}
-
-const struct dma_map_ops or1k_dma_map_ops = {
-	.alloc = or1k_dma_alloc,
-	.free = or1k_dma_free,
-	.map_page = or1k_map_page,
-	.map_sg = or1k_map_sg,
-	.sync_single_for_device = or1k_sync_single_for_device,
-};
-EXPORT_SYMBOL(or1k_dma_map_ops);
-- 
2.17.0

