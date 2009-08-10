From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Date: Mon, 10 Aug 2009 02:53:14 +0000
Subject: [PATCH 5/8] sparc: remove no-op dma_4v_sync_single_for_cpu and dma_4v_sync_sg_for_cpu
Message-Id: <1249872797-1314-6-git-send-email-fujita.tomonori@lab.ntt.co.jp>
List-Id: <sparclinux.vger.kernel.org>
References: <1249872797-1314-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <1249872797-1314-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mingo@elte.hu
Cc: davem@davemloft.net, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, tony.luck@intel.com, fenghua.yu@intel.com, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>

Now sparc uses include/asm-generic/dma-mapping-common.h. pci_sun4v.c
doesn't need to have no-op dma_4v_sync_single_for_cpu and
dma_4v_sync_sg_for_cpu (dma-mapping-common.h does nothing if
sync_{single|sg}_for_cpu hook is not defined). So we can remove them
safely.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Tested-by: Robert Reif <reif@earthlink.net>
Acked-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/pci_sun4v.c |   16 ----------------
 1 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index ee800f9..23c33ff 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -525,20 +525,6 @@ static void dma_4v_unmap_sg(struct device *dev, struct scatterlist *sglist,
 	spin_unlock_irqrestore(&iommu->lock, flags);
 }
 
-static void dma_4v_sync_single_for_cpu(struct device *dev,
-				       dma_addr_t bus_addr, size_t sz,
-				       enum dma_data_direction direction)
-{
-	/* Nothing to do... */
-}
-
-static void dma_4v_sync_sg_for_cpu(struct device *dev,
-				   struct scatterlist *sglist, int nelems,
-				   enum dma_data_direction direction)
-{
-	/* Nothing to do... */
-}
-
 static struct dma_map_ops sun4v_dma_ops = {
 	.alloc_coherent			= dma_4v_alloc_coherent,
 	.free_coherent			= dma_4v_free_coherent,
@@ -546,8 +532,6 @@ static struct dma_map_ops sun4v_dma_ops = {
 	.unmap_page			= dma_4v_unmap_page,
 	.map_sg				= dma_4v_map_sg,
 	.unmap_sg			= dma_4v_unmap_sg,
-	.sync_single_for_cpu		= dma_4v_sync_single_for_cpu,
-	.sync_sg_for_cpu		= dma_4v_sync_sg_for_cpu,
 };
 
 static void __devinit pci_sun4v_scan_bus(struct pci_pbm_info *pbm,
-- 
1.6.0.6

