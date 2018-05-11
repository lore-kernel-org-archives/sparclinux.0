From: Christoph Hellwig <hch@lst.de>
Date: Fri, 11 May 2018 07:59:38 +0000
Subject: [PATCH 13/20] sh: simplify get_arch_dma_ops
Message-Id: <20180511075945.16548-14-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180511075945.16548-1-hch@lst.de>
In-Reply-To: <20180511075945.16548-1-hch-jcswGhMUV9g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org, Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, Vincent Chen <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org, openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org, Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org, linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org

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
index 3e3a32fc676e..79a9edafa5b0 100644
--- a/arch/sh/kernel/dma-nommu.c
+++ b/arch/sh/kernel/dma-nommu.c
@@ -79,10 +79,4 @@ const struct dma_map_ops nommu_dma_ops = {
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
index 35ea3099a3b6..221832eec33b 100644
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

