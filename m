From: Christoph Hellwig <hch@lst.de>
Date: Fri, 15 Feb 2019 14:45:56 +0000
Subject: [PATCH 2/5] sparc64: refactor the ali DMA quirk
Message-Id: <20190215144559.8777-3-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20190215144559.8777-1-hch@lst.de>
In-Reply-To: <20190215144559.8777-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, sparclinux@vger.kernel.org, linux-parisc@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

Do the quirk first in the dma_supported routines, as we don't need
any of the other checks for it, and remove the duplicate mask checking
that is already done by the callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sparc/kernel/iommu.c     |  7 +++---
 arch/sparc/kernel/kernel.h    |  6 ++++-
 arch/sparc/kernel/pci.c       | 46 ++++++++++++-----------------------
 arch/sparc/kernel/pci_sun4v.c |  5 +++-
 4 files changed, 27 insertions(+), 37 deletions(-)

diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
index b1a09080e8da..0c253f1c852e 100644
--- a/arch/sparc/kernel/iommu.c
+++ b/arch/sparc/kernel/iommu.c
@@ -745,14 +745,13 @@ static int dma_4u_supported(struct device *dev, u64 device_mask)
 {
 	struct iommu *iommu = dev->archdata.iommu;
 
+	if (ali_sound_dma_hack(dev, device_mask))
+		return 1;
+
 	if (device_mask > DMA_BIT_MASK(32))
 		return 0;
 	if ((device_mask & iommu->dma_addr_mask) = iommu->dma_addr_mask)
 		return 1;
-#ifdef CONFIG_PCI
-	if (dev_is_pci(dev))
-		return pci64_dma_supported(to_pci_dev(dev), device_mask);
-#endif
 	return 0;
 }
 
diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index ddffd368e057..f6f498ba3198 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -45,7 +45,11 @@ void __irq_entry smp_receive_signal_client(int irq, struct pt_regs *regs);
 void __irq_entry smp_kgdb_capture_client(int irq, struct pt_regs *regs);
 
 /* pci.c */
-int pci64_dma_supported(struct pci_dev *pdev, u64 device_mask);
+#ifdef CONFIG_PCI
+int ali_sound_dma_hack(struct device *dev, u64 device_mask);
+#else
+#define ali_sound_dma_hack(dev, mask)	(0)
+#endif
 
 /* signal32.c */
 void do_sigreturn32(struct pt_regs *regs);
diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index bcfec6a85d23..5ed43828e078 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -956,51 +956,35 @@ void arch_teardown_msi_irq(unsigned int irq)
 }
 #endif /* !(CONFIG_PCI_MSI) */
 
-static void ali_sound_dma_hack(struct pci_dev *pdev, int set_bit)
+/* ALI sound chips generate 31-bits of DMA, a special register
+ * determines what bit 31 is emitted as.
+ */
+int ali_sound_dma_hack(struct device *dev, u64 device_mask)
 {
+	struct iommu *iommu = dev->archdata.iommu;
 	struct pci_dev *ali_isa_bridge;
 	u8 val;
 
-	/* ALI sound chips generate 31-bits of DMA, a special register
-	 * determines what bit 31 is emitted as.
-	 */
+	if (!dev_is_pci(dev))
+		return 0;
+
+	if (to_pci_dev(dev)->vendor != PCI_VENDOR_ID_AL ||
+	    to_pci_dev(dev)->device != PCI_DEVICE_ID_AL_M5451 ||
+	    device_mask != 0x7fffffff)
+		return 0;
+
 	ali_isa_bridge = pci_get_device(PCI_VENDOR_ID_AL,
 					 PCI_DEVICE_ID_AL_M1533,
 					 NULL);
 
 	pci_read_config_byte(ali_isa_bridge, 0x7e, &val);
-	if (set_bit)
+	if (iommu->dma_addr_mask & 0x80000000)
 		val |= 0x01;
 	else
 		val &= ~0x01;
 	pci_write_config_byte(ali_isa_bridge, 0x7e, val);
 	pci_dev_put(ali_isa_bridge);
-}
-
-int pci64_dma_supported(struct pci_dev *pdev, u64 device_mask)
-{
-	u64 dma_addr_mask;
-
-	if (pdev = NULL) {
-		dma_addr_mask = 0xffffffff;
-	} else {
-		struct iommu *iommu = pdev->dev.archdata.iommu;
-
-		dma_addr_mask = iommu->dma_addr_mask;
-
-		if (pdev->vendor = PCI_VENDOR_ID_AL &&
-		    pdev->device = PCI_DEVICE_ID_AL_M5451 &&
-		    device_mask = 0x7fffffff) {
-			ali_sound_dma_hack(pdev,
-					   (dma_addr_mask & 0x80000000) != 0);
-			return 1;
-		}
-	}
-
-	if (device_mask >= (1UL << 32UL))
-		return 0;
-
-	return (device_mask & dma_addr_mask) = dma_addr_mask;
+	return 1;
 }
 
 void pci_resource_to_user(const struct pci_dev *pdev, int bar,
diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index fa0e42b4cbfb..d30eb22b6e11 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -676,6 +676,9 @@ static int dma_4v_supported(struct device *dev, u64 device_mask)
 	struct iommu *iommu = dev->archdata.iommu;
 	u64 dma_addr_mask = iommu->dma_addr_mask;
 
+	if (ali_sound_dma_hack(dev, device_mask))
+		return 1;
+
 	if (device_mask > DMA_BIT_MASK(32)) {
 		if (iommu->atu)
 			dma_addr_mask = iommu->atu->dma_addr_mask;
@@ -685,7 +688,7 @@ static int dma_4v_supported(struct device *dev, u64 device_mask)
 
 	if ((device_mask & dma_addr_mask) = dma_addr_mask)
 		return 1;
-	return pci64_dma_supported(to_pci_dev(dev), device_mask);
+	return 0;
 }
 
 static const struct dma_map_ops sun4v_dma_ops = {
-- 
2.20.1
