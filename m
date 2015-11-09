From: Christoph Hellwig <hch@lst.de>
Date: Mon, 09 Nov 2015 18:17:19 +0000
Subject: [PATCH 14/16] tile: uninline dma_set_mask
Message-Id: <1447093041-21832-15-git-send-email-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1447093041-21832-1-git-send-email-hch@lst.de>
In-Reply-To: <1447093041-21832-1-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Steven Miao <realmz6@gmail.com>, Ley Foon Tan <lftan@altera.com>, David Howells <dhowells@redhat.com>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, Chris Metcalf <cmetcalf@ezchip.com>, linux-snps-arc@lists.infraded.org, linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com, linux-parisc@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org, sparclinux@vger.kernel.org, iommu@lists.linux-foundation.org

We'll soon merge <asm-generic/dma-mapping-common.h> into <linux/dma-mapping.h>
and the reference to dma_capable in the tile dma_set_mask would create a
circular dependency.  Fix this by moving the implementation out of line.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/tile/include/asm/dma-mapping.h | 29 +----------------------------
 arch/tile/kernel/pci-dma.c          | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/arch/tile/include/asm/dma-mapping.h b/arch/tile/include/asm/dma-mapping.h
index 96ac6cc..c342736 100644
--- a/arch/tile/include/asm/dma-mapping.h
+++ b/arch/tile/include/asm/dma-mapping.h
@@ -76,34 +76,7 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 
 #include <asm-generic/dma-mapping-common.h>
 
-static inline int
-dma_set_mask(struct device *dev, u64 mask)
-{
-	struct dma_map_ops *dma_ops = get_dma_ops(dev);
-
-	/*
-	 * For PCI devices with 64-bit DMA addressing capability, promote
-	 * the dma_ops to hybrid, with the consistent memory DMA space limited
-	 * to 32-bit. For 32-bit capable devices, limit the streaming DMA
-	 * address range to max_direct_dma_addr.
-	 */
-	if (dma_ops = gx_pci_dma_map_ops ||
-	    dma_ops = gx_hybrid_pci_dma_map_ops ||
-	    dma_ops = gx_legacy_pci_dma_map_ops) {
-		if (mask = DMA_BIT_MASK(64) &&
-		    dma_ops = gx_legacy_pci_dma_map_ops)
-			set_dma_ops(dev, gx_hybrid_pci_dma_map_ops);
-		else if (mask > dev->archdata.max_direct_dma_addr)
-			mask = dev->archdata.max_direct_dma_addr;
-	}
-
-	if (!dev->dma_mask || !dma_supported(dev, mask))
-		return -EIO;
-
-	*dev->dma_mask = mask;
-
-	return 0;
-}
+int dma_set_mask(struct device *dev, u64 mask);
 
 /*
  * dma_alloc_noncoherent() is #defined to return coherent memory,
diff --git a/arch/tile/kernel/pci-dma.c b/arch/tile/kernel/pci-dma.c
index 09b5870..b6bc054 100644
--- a/arch/tile/kernel/pci-dma.c
+++ b/arch/tile/kernel/pci-dma.c
@@ -583,6 +583,35 @@ struct dma_map_ops *gx_hybrid_pci_dma_map_ops;
 EXPORT_SYMBOL(gx_legacy_pci_dma_map_ops);
 EXPORT_SYMBOL(gx_hybrid_pci_dma_map_ops);
 
+int dma_set_mask(struct device *dev, u64 mask)
+{
+	struct dma_map_ops *dma_ops = get_dma_ops(dev);
+
+	/*
+	 * For PCI devices with 64-bit DMA addressing capability, promote
+	 * the dma_ops to hybrid, with the consistent memory DMA space limited
+	 * to 32-bit. For 32-bit capable devices, limit the streaming DMA
+	 * address range to max_direct_dma_addr.
+	 */
+	if (dma_ops = gx_pci_dma_map_ops ||
+	    dma_ops = gx_hybrid_pci_dma_map_ops ||
+	    dma_ops = gx_legacy_pci_dma_map_ops) {
+		if (mask = DMA_BIT_MASK(64) &&
+		    dma_ops = gx_legacy_pci_dma_map_ops)
+			set_dma_ops(dev, gx_hybrid_pci_dma_map_ops);
+		else if (mask > dev->archdata.max_direct_dma_addr)
+			mask = dev->archdata.max_direct_dma_addr;
+	}
+
+	if (!dev->dma_mask || !dma_supported(dev, mask))
+		return -EIO;
+
+	*dev->dma_mask = mask;
+
+	return 0;
+}
+EXPORT_SYMBOL(dma_set_mask);
+
 #ifdef CONFIG_ARCH_HAS_DMA_SET_COHERENT_MASK
 int dma_set_coherent_mask(struct device *dev, u64 mask)
 {
-- 
1.9.1

