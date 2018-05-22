From: Christoph Hellwig <hch@lst.de>
Date: Tue, 22 May 2018 12:04:17 +0000
Subject: [PATCH 12/25] openrisc: remove the sync_single_for_cpu DMA operation
Message-Id: <20180522120430.28709-13-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180522120430.28709-1-hch@lst.de>
In-Reply-To: <20180522120430.28709-1-hch-jcswGhMUV9g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org, Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, Vincent Chen <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org, openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org, Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org, linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org

openrisc does all the required cache maintainance at dma map time, and none
at unmap time.  It thus has to implement sync_single_for_device to match
the map cace for buffer reuse, but there is no point in doing another
invalidation in the sync_single_cpu_case, which in terms of cache
maintainance is equivalent to the unmap case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/openrisc/kernel/dma.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
index ec7fd45704d2..47601274abf7 100644
--- a/arch/openrisc/kernel/dma.c
+++ b/arch/openrisc/kernel/dma.c
@@ -208,20 +208,6 @@ or1k_unmap_sg(struct device *dev, struct scatterlist *sg,
 	}
 }
 
-static void
-or1k_sync_single_for_cpu(struct device *dev,
-			 dma_addr_t dma_handle, size_t size,
-			 enum dma_data_direction dir)
-{
-	unsigned long cl;
-	dma_addr_t addr = dma_handle;
-	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[smp_processor_id()];
-
-	/* Invalidate the dcache for the requested range */
-	for (cl = addr; cl < addr + size; cl += cpuinfo->dcache_block_size)
-		mtspr(SPR_DCBIR, cl);
-}
-
 static void
 or1k_sync_single_for_device(struct device *dev,
 			    dma_addr_t dma_handle, size_t size,
@@ -243,7 +229,6 @@ const struct dma_map_ops or1k_dma_map_ops = {
 	.unmap_page = or1k_unmap_page,
 	.map_sg = or1k_map_sg,
 	.unmap_sg = or1k_unmap_sg,
-	.sync_single_for_cpu = or1k_sync_single_for_cpu,
 	.sync_single_for_device = or1k_sync_single_for_device,
 };
 EXPORT_SYMBOL(or1k_dma_map_ops);
-- 
2.17.0

