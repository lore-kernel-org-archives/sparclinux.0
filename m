From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:23:37 +0000
Subject: [PATCH 8/49]: sparc32: Implement more generic dma_*() interfaces.
Message-Id: <20080827.212337.50872603.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc32: Implement more generic dma_*() interfaces.

These dispatch to either PCI or SBUS routines based upon
the device bus type.

This will allow us to let SBUS drivers call these routines.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/dma-mapping_32.h |   59 ++++++++-
 arch/sparc/kernel/Makefile              |    2 +-
 arch/sparc/kernel/dma.c                 |  227 +++++++++++++++++++++++++++++++
 arch/sparc/kernel/dma.h                 |   14 ++
 arch/sparc/kernel/ioport.c              |    2 +
 5 files changed, 298 insertions(+), 6 deletions(-)
 create mode 100644 arch/sparc/kernel/dma.c
 create mode 100644 arch/sparc/kernel/dma.h

diff --git a/arch/sparc/include/asm/dma-mapping_32.h b/arch/sparc/include/asm/dma-mapping_32.h
index f3a641e..8a57ea0 100644
--- a/arch/sparc/include/asm/dma-mapping_32.h
+++ b/arch/sparc/include/asm/dma-mapping_32.h
@@ -1,11 +1,60 @@
 #ifndef _ASM_SPARC_DMA_MAPPING_H
 #define _ASM_SPARC_DMA_MAPPING_H
 
+#include <linux/types.h>
 
-#ifdef CONFIG_PCI
-#include <asm-generic/dma-mapping.h>
-#else
-#include <asm-generic/dma-mapping-broken.h>
-#endif /* PCI */
+struct device;
+struct scatterlist;
+struct page;
+
+#define DMA_ERROR_CODE	(~(dma_addr_t)0x0)
+
+extern int dma_supported(struct device *dev, u64 mask);
+extern int dma_set_mask(struct device *dev, u64 dma_mask);
+extern void *dma_alloc_coherent(struct device *dev, size_t size,
+				dma_addr_t *dma_handle, gfp_t flag);
+extern void dma_free_coherent(struct device *dev, size_t size,
+			      void *cpu_addr, dma_addr_t dma_handle);
+extern dma_addr_t dma_map_single(struct device *dev, void *cpu_addr,
+				 size_t size,
+				 enum dma_data_direction direction);
+extern void dma_unmap_single(struct device *dev, dma_addr_t dma_addr,
+			     size_t size,
+			     enum dma_data_direction direction);
+extern dma_addr_t dma_map_page(struct device *dev, struct page *page,
+			       unsigned long offset, size_t size,
+			       enum dma_data_direction direction);
+extern void dma_unmap_page(struct device *dev, dma_addr_t dma_address,
+			   size_t size, enum dma_data_direction direction);
+extern int dma_map_sg(struct device *dev, struct scatterlist *sg,
+		      int nents, enum dma_data_direction direction);
+extern void dma_unmap_sg(struct device *dev, struct scatterlist *sg,
+			 int nents, enum dma_data_direction direction);
+extern void dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle,
+				    size_t size,
+				    enum dma_data_direction direction);
+extern void dma_sync_single_for_device(struct device *dev,
+				       dma_addr_t dma_handle,
+				       size_t size,
+				       enum dma_data_direction direction);
+extern void dma_sync_single_range_for_cpu(struct device *dev,
+					  dma_addr_t dma_handle,
+					  unsigned long offset,
+					  size_t size,
+					  enum dma_data_direction direction);
+extern void dma_sync_single_range_for_device(struct device *dev,
+					     dma_addr_t dma_handle,
+					     unsigned long offset, size_t size,
+					     enum dma_data_direction direction);
+extern void dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
+				int nelems, enum dma_data_direction direction);
+extern void dma_sync_sg_for_device(struct device *dev,
+				   struct scatterlist *sg, int nelems,
+				   enum dma_data_direction direction);
+extern int dma_mapping_error(struct device *dev, dma_addr_t dma_addr);
+extern int dma_get_cache_alignment(void);
+
+#define dma_alloc_noncoherent	dma_alloc_coherent
+#define dma_free_noncoherent	dma_free_coherent
 
 #endif /* _ASM_SPARC_DMA_MAPPING_H */
diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index 6e03a2a..eaf7cf4 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -13,7 +13,7 @@ obj-y    := entry.o wof.o wuf.o etrap.o rtrap.o traps.o $(IRQ_OBJS) \
 	    time.o windows.o cpu.o devices.o \
 	    tadpole.o tick14.o ptrace.o \
 	    unaligned.o una_asm.o muldiv.o \
-	    prom.o of_device.o devres.o
+	    prom.o of_device.o devres.o dma.o
 
 devres-y = ../../../kernel/irq/devres.o
 
diff --git a/arch/sparc/kernel/dma.c b/arch/sparc/kernel/dma.c
new file mode 100644
index 0000000..ebc8403
--- /dev/null
+++ b/arch/sparc/kernel/dma.c
@@ -0,0 +1,227 @@
+/* dma.c: PCI and SBUS DMA accessors for 32-bit sparc.
+ *
+ * Copyright (C) 2008 David S. Miller <davem@davemloft.net>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/dma-mapping.h>
+#include <linux/scatterlist.h>
+#include <linux/mm.h>
+
+#ifdef CONFIG_PCI
+#include <linux/pci.h>
+#endif
+
+#include "dma.h"
+
+int dma_supported(struct device *dev, u64 mask)
+{
+#ifdef CONFIG_PCI
+	if (dev->bus = &pci_bus_type)
+		return pci_dma_supported(to_pci_dev(dev), mask);
+#endif
+	return 0;
+}
+EXPORT_SYMBOL(dma_supported);
+
+int dma_set_mask(struct device *dev, u64 dma_mask)
+{
+#ifdef CONFIG_PCI
+	if (dev->bus = &pci_bus_type)
+		return pci_set_dma_mask(to_pci_dev(dev), dma_mask);
+#endif
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(dma_set_mask);
+
+void *dma_alloc_coherent(struct device *dev, size_t size,
+			 dma_addr_t *dma_handle, gfp_t flag)
+{
+#ifdef CONFIG_PCI
+	if (dev->bus = &pci_bus_type)
+		return pci_alloc_consistent(to_pci_dev(dev), size, dma_handle);
+#endif
+	return sbus_alloc_consistent(dev, size, dma_handle);
+}
+EXPORT_SYMBOL(dma_alloc_coherent);
+
+void dma_free_coherent(struct device *dev, size_t size,
+		       void *cpu_addr, dma_addr_t dma_handle)
+{
+#ifdef CONFIG_PCI
+	if (dev->bus = &pci_bus_type) {
+		pci_free_consistent(to_pci_dev(dev), size,
+				    cpu_addr, dma_handle);
+		return;
+	}
+#endif
+	sbus_free_consistent(dev, size, cpu_addr, dma_handle);
+}
+EXPORT_SYMBOL(dma_free_coherent);
+
+dma_addr_t dma_map_single(struct device *dev, void *cpu_addr,
+			  size_t size, enum dma_data_direction direction)
+{
+#ifdef CONFIG_PCI
+	if (dev->bus = &pci_bus_type)
+		return pci_map_single(to_pci_dev(dev), cpu_addr,
+				      size, (int)direction);
+#endif
+	return sbus_map_single(dev, cpu_addr, size, (int)direction);
+}
+EXPORT_SYMBOL(dma_map_single);
+
+void dma_unmap_single(struct device *dev, dma_addr_t dma_addr,
+		      size_t size,
+		      enum dma_data_direction direction)
+{
+#ifdef CONFIG_PCI
+	if (dev->bus = &pci_bus_type) {
+		pci_unmap_single(to_pci_dev(dev), dma_addr,
+				 size, (int)direction);
+		return;
+	}
+#endif
+	sbus_unmap_single(dev, dma_addr, size, (int)direction);
+}
+EXPORT_SYMBOL(dma_unmap_single);
+
+dma_addr_t dma_map_page(struct device *dev, struct page *page,
+			unsigned long offset, size_t size,
+			enum dma_data_direction direction)
+{
+#ifdef CONFIG_PCI
+	if (dev->bus = &pci_bus_type)
+		return pci_map_page(to_pci_dev(dev), page, offset,
+				    size, (int)direction);
+#endif
+	return sbus_map_single(dev, page_address(page) + offset,
+			       size, (int)direction);
+}
+EXPORT_SYMBOL(dma_map_page);
+
+void dma_unmap_page(struct device *dev, dma_addr_t dma_address,
+		    size_t size, enum dma_data_direction direction)
+{
+#ifdef CONFIG_PCI
+	if (dev->bus = &pci_bus_type) {
+		pci_unmap_page(to_pci_dev(dev), dma_address,
+			       size, (int)direction);
+		return;
+	}
+#endif
+	sbus_unmap_single(dev, dma_address, size, (int)direction);
+}
+EXPORT_SYMBOL(dma_unmap_page);
+
+int dma_map_sg(struct device *dev, struct scatterlist *sg,
+			     int nents, enum dma_data_direction direction)
+{
+#ifdef CONFIG_PCI
+	if (dev->bus = &pci_bus_type)
+		return pci_map_sg(to_pci_dev(dev), sg, nents, (int)direction);
+#endif
+	return sbus_map_sg(dev, sg, nents, direction);
+}
+EXPORT_SYMBOL(dma_map_sg);
+
+void dma_unmap_sg(struct device *dev, struct scatterlist *sg,
+		  int nents, enum dma_data_direction direction)
+{
+#ifdef CONFIG_PCI
+	if (dev->bus = &pci_bus_type) {
+		pci_unmap_sg(to_pci_dev(dev), sg, nents, (int)direction);
+		return;
+	}
+#endif
+	sbus_unmap_sg(dev, sg, nents, (int)direction);
+}
+EXPORT_SYMBOL(dma_unmap_sg);
+
+void dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle,
+			     size_t size, enum dma_data_direction direction)
+{
+#ifdef CONFIG_PCI
+	if (dev->bus = &pci_bus_type) {
+		pci_dma_sync_single_for_cpu(to_pci_dev(dev), dma_handle,
+					    size, (int)direction);
+		return;
+	}
+#endif
+	sbus_dma_sync_single_for_cpu(dev, dma_handle, size, (int) direction);
+}
+EXPORT_SYMBOL(dma_sync_single_for_cpu);
+
+void dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle,
+				size_t size, enum dma_data_direction direction)
+{
+#ifdef CONFIG_PCI
+	if (dev->bus = &pci_bus_type) {
+		pci_dma_sync_single_for_device(to_pci_dev(dev), dma_handle,
+					       size, (int)direction);
+		return;
+	}
+#endif
+	sbus_dma_sync_single_for_device(dev, dma_handle, size, (int) direction);
+}
+EXPORT_SYMBOL(dma_sync_single_for_device);
+
+void dma_sync_single_range_for_cpu(struct device *dev,
+				   dma_addr_t dma_handle,
+				   unsigned long offset,
+				   size_t size,
+				   enum dma_data_direction direction)
+{
+	dma_sync_single_for_cpu(dev, dma_handle+offset, size, direction);
+}
+EXPORT_SYMBOL(dma_sync_single_range_for_cpu);
+
+void dma_sync_single_range_for_device(struct device *dev, dma_addr_t dma_handle,
+				      unsigned long offset, size_t size,
+				      enum dma_data_direction direction)
+{
+	dma_sync_single_for_device(dev, dma_handle+offset, size, direction);
+}
+EXPORT_SYMBOL(dma_sync_single_range_for_device);
+
+void dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
+			 int nelems, enum dma_data_direction direction)
+{
+#ifdef CONFIG_PCI
+	if (dev->bus = &pci_bus_type) {
+		pci_dma_sync_sg_for_cpu(to_pci_dev(dev), sg,
+					nelems, (int)direction);
+		return;
+	}
+#endif
+	BUG();
+}
+EXPORT_SYMBOL(dma_sync_sg_for_cpu);
+
+void dma_sync_sg_for_device(struct device *dev,
+			    struct scatterlist *sg, int nelems,
+			    enum dma_data_direction direction)
+{
+#ifdef CONFIG_PCI
+	if (dev->bus = &pci_bus_type) {
+		pci_dma_sync_sg_for_device(to_pci_dev(dev), sg,
+					   nelems, (int)direction);
+		return;
+	}
+#endif
+	BUG();
+}
+EXPORT_SYMBOL(dma_sync_sg_for_device);
+
+int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
+{
+	return (dma_addr = DMA_ERROR_CODE);
+}
+EXPORT_SYMBOL(dma_mapping_error);
+
+int dma_get_cache_alignment(void)
+{
+	return 32;
+}
+EXPORT_SYMBOL(dma_get_cache_alignment);
diff --git a/arch/sparc/kernel/dma.h b/arch/sparc/kernel/dma.h
new file mode 100644
index 0000000..f8d8951
--- /dev/null
+++ b/arch/sparc/kernel/dma.h
@@ -0,0 +1,14 @@
+void *sbus_alloc_consistent(struct device *dev, long len, u32 *dma_addrp);
+void sbus_free_consistent(struct device *dev, long n, void *p, u32 ba);
+dma_addr_t sbus_map_single(struct device *dev, void *va,
+			   size_t len, int direction);
+void sbus_unmap_single(struct device *dev, dma_addr_t ba,
+		       size_t n, int direction);
+int sbus_map_sg(struct device *dev, struct scatterlist *sg,
+		int n, int direction);
+void sbus_unmap_sg(struct device *dev, struct scatterlist *sg,
+		   int n, int direction);
+void sbus_dma_sync_single_for_cpu(struct device *dev, dma_addr_t ba,
+				  size_t size, int direction);
+void sbus_dma_sync_single_for_device(struct device *dev, dma_addr_t ba,
+				     size_t size, int direction);
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 11dccf9..0b30359 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -49,6 +49,8 @@
 #include <asm/iommu.h>
 #include <asm/io-unit.h>
 
+#include "dma.h"
+
 #define mmu_inval_dma_area(p, l)	/* Anton pulled it out for 2.4.0-xx */
 
 static struct resource *_sparc_find_resource(struct resource *r,
-- 
1.5.6.5.GIT

