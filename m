From: Yijing Wang <wangyijing@huawei.com>
Date: Wed, 11 Dec 2013 06:00:26 +0000
Subject: [PATCH v3] sparc/PCI: Use dev_is_pci() to identify PCI devices
Message-Id: <1386741626-35744-1-git-send-email-wangyijing@huawei.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, sparclinux@vger.kernel.org, Yijing Wang <wangyijing@huawei.com>, Hanjun Guo <guohanjun@huawei.com>

Use dev_is_pci() instead of checking bus type directly.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---

v2->v3: Keep use dev->bus = &pci_bus_type in 
        arch/sparc/include/asm/dma-mapping.h, because we
		can't include <linux/pci.h> in this file, or it will
		cause lots of building errors, it's so strange. 
		This patch was built ok in my Cross Complier.

---
 arch/sparc/kernel/iommu.c  |    2 +-
 arch/sparc/kernel/ioport.c |    5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
index 070ed14..76663b0 100644
--- a/arch/sparc/kernel/iommu.c
+++ b/arch/sparc/kernel/iommu.c
@@ -854,7 +854,7 @@ int dma_supported(struct device *dev, u64 device_mask)
 		return 1;
 
 #ifdef CONFIG_PCI
-	if (dev->bus = &pci_bus_type)
+	if (dev_is_pci(dev))
 		return pci64_dma_supported(to_pci_dev(dev), device_mask);
 #endif
 
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 2096468..e7e215d 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -666,10 +666,9 @@ EXPORT_SYMBOL(dma_ops);
  */
 int dma_supported(struct device *dev, u64 mask)
 {
-#ifdef CONFIG_PCI
-	if (dev->bus = &pci_bus_type)
+	if (dev_is_pci(dev))
 		return 1;
-#endif
+
 	return 0;
 }
 EXPORT_SYMBOL(dma_supported);
-- 
1.7.1


