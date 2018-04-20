From: Christoph Hellwig <hch@lst.de>
Date: Fri, 20 Apr 2018 08:03:07 +0000
Subject: [PATCH 16/22] sh: simplify get_arch_dma_ops
Message-Id: <20180420080313.18796-17-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180420080313.18796-1-hch@lst.de>
In-Reply-To: <20180420080313.18796-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org

Remove the indirection through the dma_ops variable, and just return
nommu_dma_ops directly from get_arch_dma_ops.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/include/asm/dma-mapping.h |  5 ++---
 arch/sh/kernel/dma-nommu.c        |  8 +-------
 arch/sh/mm/consistent.c           |  3 ---
 arch/sh/mm/init.c                 | 10 ----------
 4 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/arch/sh/include/asm/dma-mapping.h b/arch/sh/include/asm/dma-mapping.h
index 41167931e5d9..149e71f95be7 100644
--- a/arch/sh/include/asm/dma-mapping.h
+++ b/arch/sh/include/asm/dma-mapping.h
@@ -2,12 +2,11 @@
 #ifndef __ASM_SH_DMA_MAPPING_H
 #define __ASM_SH_DMA_MAPPING_H
 
-extern const struct dma_map_ops *dma_ops;
-extern void no_iommu_init(void);
+extern const struct dma_map_ops nommu_dma_ops;
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
-	return dma_ops;
+	return &nommu_dma_ops;
 }
 
 extern void *dma_generic_alloc_coherent(struct device *dev, size_t size,
diff --git a/arch/sh/kernel/dma-nommu.c b/arch/sh/kernel/dma-nommu.c
index 2077cfe73cc6..c0fff676e2e4 100644
--- a/arch/sh/kernel/dma-nommu.c
+++ b/arch/sh/kernel/dma-nommu.c
@@ -76,10 +76,4 @@ const struct dma_map_ops nommu_dma_ops = {
 	.sync_sg_for_device	= nommu_sync_sg_for_device,
 #endif
 };
-
-void __init no_iommu_init(void)
-{
-	if (dma_ops)
-		return;
-	dma_ops = &nommu_dma_ops;
-}
+EXPORT_SYMBOL(nommu_dma_ops);
diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
index a7bff3f29c2b..af2f28572119 100644
--- a/arch/sh/mm/consistent.c
+++ b/arch/sh/mm/consistent.c
@@ -20,9 +20,6 @@
 #include <asm/cacheflush.h>
 #include <asm/addrspace.h>
 
-const struct dma_map_ops *dma_ops;
-EXPORT_SYMBOL(dma_ops);
-
 void *dma_generic_alloc_coherent(struct device *dev, size_t size,
 				 dma_addr_t *dma_handle, gfp_t gfp,
 				 unsigned long attrs)
diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index ce0bbaa7e404..32e09f03e6bf 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -395,22 +395,12 @@ void __init paging_init(void)
 	free_area_init_nodes(max_zone_pfns);
 }
 
-/*
- * Early initialization for any I/O MMUs we might have.
- */
-static void __init iommu_init(void)
-{
-	no_iommu_init();
-}
-
 unsigned int mem_init_done = 0;
 
 void __init mem_init(void)
 {
 	pg_data_t *pgdat;
 
-	iommu_init();
-
 	high_memory = NULL;
 	for_each_online_pgdat(pgdat)
 		high_memory = max_t(void *, high_memory,
-- 
2.17.0

