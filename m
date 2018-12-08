From: Christoph Hellwig <hch@lst.de>
Date: Sat, 08 Dec 2018 17:41:14 +0000
Subject: [PATCH 5/6] sparc: move the leon PCI memory space comment to <asm/leon.h>
Message-Id: <20181208174115.16237-6-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20181208174115.16237-1-hch@lst.de>
In-Reply-To: <20181208174115.16237-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>, Robin Murphy <robin.murphy@arm.com>, dri-devel@lists.freedesktop.org, "Matwey V. Kornilov" <matwey@sai.msu.ru>, openrisc@lists.librecores.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org, Ezequiel Garcia <ezequiel@collabora.com>, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org

It has nothing to do with the content of the pci.h header.

Suggested by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sparc/include/asm/leon.h   | 9 +++++++++
 arch/sparc/include/asm/pci_32.h | 9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
index c68bb5b76e3d..77ea406ff9df 100644
--- a/arch/sparc/include/asm/leon.h
+++ b/arch/sparc/include/asm/leon.h
@@ -255,4 +255,13 @@ extern int leon_ipi_irq;
 #define _pfn_valid(pfn)	 ((pfn < last_valid_pfn) && (pfn >= PFN(phys_base)))
 #define _SRMMU_PTE_PMASK_LEON 0xffffffff
 
+/*
+ * On LEON PCI Memory space is mapped 1:1 with physical address space.
+ *
+ * I/O space is located at low 64Kbytes in PCI I/O space. The I/O addresses
+ * are converted into CPU addresses to virtual addresses that are mapped with
+ * MMU to the PCI Host PCI I/O space window which are translated to the low
+ * 64Kbytes by the Host controller.
+ */
+
 #endif
diff --git a/arch/sparc/include/asm/pci_32.h b/arch/sparc/include/asm/pci_32.h
index cfc0ee9476c6..a475380ea108 100644
--- a/arch/sparc/include/asm/pci_32.h
+++ b/arch/sparc/include/asm/pci_32.h
@@ -23,15 +23,6 @@
 /* generic pci stuff */
 #include <asm-generic/pci.h>
 #else
-/*
- * On LEON PCI Memory space is mapped 1:1 with physical address space.
- *
- * I/O space is located at low 64Kbytes in PCI I/O space. The I/O addresses
- * are converted into CPU addresses to virtual addresses that are mapped with
- * MMU to the PCI Host PCI I/O space window which are translated to the low
- * 64Kbytes by the Host controller.
- */
-
 static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 {
 	return PCI_IRQ_NONE;
-- 
2.19.2
