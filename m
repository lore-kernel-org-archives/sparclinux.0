From: Christoph Hellwig <hch@lst.de>
Date: Tue, 22 May 2018 12:04:29 +0000
Subject: [PATCH 24/25] parisc: always use flush_kernel_dcache_range for DMA cache maintainance
Message-Id: <20180522120430.28709-25-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180522120430.28709-1-hch@lst.de>
In-Reply-To: <20180522120430.28709-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org

Current the S/G list based DMA ops use flush_kernel_vmap_range which
contains a few UP optimizations, while the rest of the DMA operations
uses flush_kernel_dcache_range.  The single vs sg operations are supposed
to have the same effect, so they should use the same routines.  Use
the more conservation version for now, but if people more familiar with
parisc think the vmap version is generally fine for DMA we should switch
all interfaces over to it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/parisc/kernel/pci-dma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/parisc/kernel/pci-dma.c b/arch/parisc/kernel/pci-dma.c
index 52304cb290f9..4d7506336918 100644
--- a/arch/parisc/kernel/pci-dma.c
+++ b/arch/parisc/kernel/pci-dma.c
@@ -550,7 +550,7 @@ static void pa11_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
 	/* once we do combining we'll need to use phys_to_virt(sg_dma_address(sglist)) */
 
 	for_each_sg(sglist, sg, nents, i)
-		flush_kernel_vmap_range(sg_virt(sg), sg->length);
+		flush_kernel_dcache_range(sg_virt(sg), sg->length);
 }
 
 static void pa11_dma_sync_single_for_cpu(struct device *dev,
@@ -581,7 +581,7 @@ static void pa11_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sgl
 	/* once we do combining we'll need to use phys_to_virt(sg_dma_address(sglist)) */
 
 	for_each_sg(sglist, sg, nents, i)
-		flush_kernel_vmap_range(sg_virt(sg), sg->length);
+		flush_kernel_dcache_range(sg_virt(sg), sg->length);
 }
 
 static void pa11_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sglist, int nents, enum dma_data_direction direction)
@@ -592,7 +592,7 @@ static void pa11_dma_sync_sg_for_device(struct device *dev, struct scatterlist *
 	/* once we do combining we'll need to use phys_to_virt(sg_dma_address(sglist)) */
 
 	for_each_sg(sglist, sg, nents, i)
-		flush_kernel_vmap_range(sg_virt(sg), sg->length);
+		flush_kernel_dcache_range(sg_virt(sg), sg->length);
 }
 
 static void pa11_dma_cache_sync(struct device *dev, void *vaddr, size_t size,
-- 
2.17.0

