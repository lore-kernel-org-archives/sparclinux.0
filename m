From: Christoph Hellwig <hch@lst.de>
Date: Fri, 07 Dec 2018 14:10:48 +0000
Subject: [PATCH] sparc: merge 32-bit and 64-bit version of pci.h
Message-Id: <20181207141048.2723-1-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

There are enough common defintions that a single header seems nicer.

Also drop the pointless <linux/dma-mapping.h> include.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sparc/include/asm/pci.h    | 53 ++++++++++++++++++++++++++++++---
 arch/sparc/include/asm/pci_32.h | 41 -------------------------
 arch/sparc/include/asm/pci_64.h | 52 --------------------------------
 3 files changed, 49 insertions(+), 97 deletions(-)
 delete mode 100644 arch/sparc/include/asm/pci_32.h
 delete mode 100644 arch/sparc/include/asm/pci_64.h

diff --git a/arch/sparc/include/asm/pci.h b/arch/sparc/include/asm/pci.h
index cad79a6ce0e4..cfec79bb1831 100644
--- a/arch/sparc/include/asm/pci.h
+++ b/arch/sparc/include/asm/pci.h
@@ -1,9 +1,54 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef ___ASM_SPARC_PCI_H
 #define ___ASM_SPARC_PCI_H
-#if defined(__sparc__) && defined(__arch64__)
-#include <asm/pci_64.h>
+
+
+/* Can be used to override the logic in pci_scan_bus for skipping
+ * already-configured bus numbers - to be used for buggy BIOSes
+ * or architectures with incomplete PCI setup by the loader.
+ */
+#define pcibios_assign_all_busses()	0
+
+#define PCIBIOS_MIN_IO		0UL
+#define PCIBIOS_MIN_MEM		0UL
+
+#define PCI_IRQ_NONE		0xffffffff
+
+
+#ifdef CONFIG_SPARC64
+
+/* PCI IOMMU mapping bypass support. */
+
+/* PCI 64-bit addressing works for all slots on all controller
+ * types on sparc64.  However, it requires that the device
+ * can drive enough of the 64 bits.
+ */
+#define PCI64_REQUIRED_MASK	(~(u64)0)
+#define PCI64_ADDR_BASE		0xfffc000000000000UL
+
+/* Return the index of the PCI controller for device PDEV. */
+int pci_domain_nr(struct pci_bus *bus);
+static inline int pci_proc_domain(struct pci_bus *bus)
+{
+	return 1;
+}
+
+/* Platform support for /proc/bus/pci/X/Y mmap()s. */
+#define HAVE_PCI_MMAP
+#define arch_can_pci_mmap_io()	1
+#define HAVE_ARCH_PCI_GET_UNMAPPED_AREA
+#define get_pci_unmapped_area get_fb_unmapped_area
+
+#define HAVE_ARCH_PCI_RESOURCE_TO_USER
+#endif /* CONFIG_SPARC64 */
+
+#if defined(CONFIG_SPARC64) || defined(CONFIG_LEON_PCI)
+static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
+{
+	return PCI_IRQ_NONE;
+}
 #else
-#include <asm/pci_32.h>
-#endif
+#include <asm-generic/pci.h>
 #endif
+
+#endif /* ___ASM_SPARC_PCI_H */
diff --git a/arch/sparc/include/asm/pci_32.h b/arch/sparc/include/asm/pci_32.h
deleted file mode 100644
index cfc0ee9476c6..000000000000
--- a/arch/sparc/include/asm/pci_32.h
+++ /dev/null
@@ -1,41 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __SPARC_PCI_H
-#define __SPARC_PCI_H
-
-#ifdef __KERNEL__
-
-#include <linux/dma-mapping.h>
-
-/* Can be used to override the logic in pci_scan_bus for skipping
- * already-configured bus numbers - to be used for buggy BIOSes
- * or architectures with incomplete PCI setup by the loader.
- */
-#define pcibios_assign_all_busses()	0
-
-#define PCIBIOS_MIN_IO		0UL
-#define PCIBIOS_MIN_MEM		0UL
-
-#define PCI_IRQ_NONE		0xffffffff
-
-#endif /* __KERNEL__ */
-
-#ifndef CONFIG_LEON_PCI
-/* generic pci stuff */
-#include <asm-generic/pci.h>
-#else
-/*
- * On LEON PCI Memory space is mapped 1:1 with physical address space.
- *
- * I/O space is located at low 64Kbytes in PCI I/O space. The I/O addresses
- * are converted into CPU addresses to virtual addresses that are mapped with
- * MMU to the PCI Host PCI I/O space window which are translated to the low
- * 64Kbytes by the Host controller.
- */
-
-static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
-{
-	return PCI_IRQ_NONE;
-}
-#endif
-
-#endif /* __SPARC_PCI_H */
diff --git a/arch/sparc/include/asm/pci_64.h b/arch/sparc/include/asm/pci_64.h
deleted file mode 100644
index fac77813402c..000000000000
--- a/arch/sparc/include/asm/pci_64.h
+++ /dev/null
@@ -1,52 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __SPARC64_PCI_H
-#define __SPARC64_PCI_H
-
-#ifdef __KERNEL__
-
-#include <linux/dma-mapping.h>
-
-/* Can be used to override the logic in pci_scan_bus for skipping
- * already-configured bus numbers - to be used for buggy BIOSes
- * or architectures with incomplete PCI setup by the loader.
- */
-#define pcibios_assign_all_busses()	0
-
-#define PCIBIOS_MIN_IO		0UL
-#define PCIBIOS_MIN_MEM		0UL
-
-#define PCI_IRQ_NONE		0xffffffff
-
-/* PCI IOMMU mapping bypass support. */
-
-/* PCI 64-bit addressing works for all slots on all controller
- * types on sparc64.  However, it requires that the device
- * can drive enough of the 64 bits.
- */
-#define PCI64_REQUIRED_MASK	(~(u64)0)
-#define PCI64_ADDR_BASE		0xfffc000000000000UL
-
-/* Return the index of the PCI controller for device PDEV. */
-
-int pci_domain_nr(struct pci_bus *bus);
-static inline int pci_proc_domain(struct pci_bus *bus)
-{
-	return 1;
-}
-
-/* Platform support for /proc/bus/pci/X/Y mmap()s. */
-
-#define HAVE_PCI_MMAP
-#define arch_can_pci_mmap_io()	1
-#define HAVE_ARCH_PCI_GET_UNMAPPED_AREA
-#define get_pci_unmapped_area get_fb_unmapped_area
-
-static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
-{
-	return PCI_IRQ_NONE;
-}
-
-#define HAVE_ARCH_PCI_RESOURCE_TO_USER
-#endif /* __KERNEL__ */
-
-#endif /* __SPARC64_PCI_H */
-- 
2.19.1
