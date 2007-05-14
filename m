From: David Miller <davem@davemloft.net>
Date: Mon, 14 May 2007 09:56:30 +0000
Subject: Re: parport_pc BUG in dma-mapping.h
Message-Id: <20070514.025630.07640532.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0705121525460.4493@math>
In-Reply-To: <Pine.SOC.4.64.0705121525460.4493@math>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Sun, 13 May 2007 13:20:49 +0300 (EEST)

> > > Tried todays git kernel on Ultra 5 (withe the pci __init change and 
> > > solaris module export patch). Cups startup causes parport_pc probe and 
> > > this causes the following BUG. Full dmesg is also below.
> > 
> > Usually you're so good at providing you're .config in each and every
> > report, but you didn't do that this time, please do so.
> 
> Sorry that I forgot it this time.

This should fix it, thanks for the report:

commit 9ac6d4a4b85004dbb907f1d3b34412afe16f3758
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Mon May 14 02:56:03 2007 -0700

    [SPARC64]: Accept ebus_bus_type for generic DMA ops.
    
    Based upon a bug report by Meelis Roos.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/include/asm-sparc64/dma-mapping.h b/include/asm-sparc64/dma-mapping.h
index 2f858a2..9329429 100644
--- a/include/asm-sparc64/dma-mapping.h
+++ b/include/asm-sparc64/dma-mapping.h
@@ -10,10 +10,13 @@
 /* need struct page definitions */
 #include <linux/mm.h>
 
+#include <asm/of_device.h>
+
 static inline int
 dma_supported(struct device *dev, u64 mask)
 {
-	BUG_ON(dev->bus != &pci_bus_type);
+	BUG_ON(dev->bus != &pci_bus_type &&
+	       dev->bus != &ebus_bus_type);
 
 	return pci_dma_supported(to_pci_dev(dev), mask);
 }
@@ -21,7 +24,8 @@ dma_supported(struct device *dev, u64 mask)
 static inline int
 dma_set_mask(struct device *dev, u64 dma_mask)
 {
-	BUG_ON(dev->bus != &pci_bus_type);
+	BUG_ON(dev->bus != &pci_bus_type &&
+	       dev->bus != &ebus_bus_type);
 
 	return pci_set_dma_mask(to_pci_dev(dev), dma_mask);
 }
@@ -30,7 +34,8 @@ static inline void *
 dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		   gfp_t flag)
 {
-	BUG_ON(dev->bus != &pci_bus_type);
+	BUG_ON(dev->bus != &pci_bus_type &&
+	       dev->bus != &ebus_bus_type);
 
 	return pci_iommu_ops->alloc_consistent(to_pci_dev(dev), size, dma_handle, flag);
 }
@@ -39,7 +44,8 @@ static inline void
 dma_free_coherent(struct device *dev, size_t size, void *cpu_addr,
 		    dma_addr_t dma_handle)
 {
-	BUG_ON(dev->bus != &pci_bus_type);
+	BUG_ON(dev->bus != &pci_bus_type &&
+	       dev->bus != &ebus_bus_type);
 
 	pci_free_consistent(to_pci_dev(dev), size, cpu_addr, dma_handle);
 }
@@ -48,7 +54,8 @@ static inline dma_addr_t
 dma_map_single(struct device *dev, void *cpu_addr, size_t size,
 	       enum dma_data_direction direction)
 {
-	BUG_ON(dev->bus != &pci_bus_type);
+	BUG_ON(dev->bus != &pci_bus_type &&
+	       dev->bus != &ebus_bus_type);
 
 	return pci_map_single(to_pci_dev(dev), cpu_addr, size, (int)direction);
 }
@@ -57,7 +64,8 @@ static inline void
 dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
 		 enum dma_data_direction direction)
 {
-	BUG_ON(dev->bus != &pci_bus_type);
+	BUG_ON(dev->bus != &pci_bus_type &&
+	       dev->bus != &ebus_bus_type);
 
 	pci_unmap_single(to_pci_dev(dev), dma_addr, size, (int)direction);
 }
@@ -67,7 +75,8 @@ dma_map_page(struct device *dev, struct page *page,
 	     unsigned long offset, size_t size,
 	     enum dma_data_direction direction)
 {
-	BUG_ON(dev->bus != &pci_bus_type);
+	BUG_ON(dev->bus != &pci_bus_type &&
+	       dev->bus != &ebus_bus_type);
 
 	return pci_map_page(to_pci_dev(dev), page, offset, size, (int)direction);
 }
@@ -76,7 +85,8 @@ static inline void
 dma_unmap_page(struct device *dev, dma_addr_t dma_address, size_t size,
 	       enum dma_data_direction direction)
 {
-	BUG_ON(dev->bus != &pci_bus_type);
+	BUG_ON(dev->bus != &pci_bus_type &&
+	       dev->bus != &ebus_bus_type);
 
 	pci_unmap_page(to_pci_dev(dev), dma_address, size, (int)direction);
 }
@@ -85,7 +95,8 @@ static inline int
 dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 	   enum dma_data_direction direction)
 {
-	BUG_ON(dev->bus != &pci_bus_type);
+	BUG_ON(dev->bus != &pci_bus_type &&
+	       dev->bus != &ebus_bus_type);
 
 	return pci_map_sg(to_pci_dev(dev), sg, nents, (int)direction);
 }
@@ -94,7 +105,8 @@ static inline void
 dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
 	     enum dma_data_direction direction)
 {
-	BUG_ON(dev->bus != &pci_bus_type);
+	BUG_ON(dev->bus != &pci_bus_type &&
+	       dev->bus != &ebus_bus_type);
 
 	pci_unmap_sg(to_pci_dev(dev), sg, nhwentries, (int)direction);
 }
@@ -103,7 +115,8 @@ static inline void
 dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle, size_t size,
 			enum dma_data_direction direction)
 {
-	BUG_ON(dev->bus != &pci_bus_type);
+	BUG_ON(dev->bus != &pci_bus_type &&
+	       dev->bus != &ebus_bus_type);
 
 	pci_dma_sync_single_for_cpu(to_pci_dev(dev), dma_handle,
 				    size, (int)direction);
@@ -113,7 +126,8 @@ static inline void
 dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle, size_t size,
 			   enum dma_data_direction direction)
 {
-	BUG_ON(dev->bus != &pci_bus_type);
+	BUG_ON(dev->bus != &pci_bus_type &&
+	       dev->bus != &ebus_bus_type);
 
 	pci_dma_sync_single_for_device(to_pci_dev(dev), dma_handle,
 				       size, (int)direction);
@@ -123,7 +137,8 @@ static inline void
 dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg, int nelems,
 		    enum dma_data_direction direction)
 {
-	BUG_ON(dev->bus != &pci_bus_type);
+	BUG_ON(dev->bus != &pci_bus_type &&
+	       dev->bus != &ebus_bus_type);
 
 	pci_dma_sync_sg_for_cpu(to_pci_dev(dev), sg, nelems, (int)direction);
 }
@@ -132,7 +147,8 @@ static inline void
 dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg, int nelems,
 		       enum dma_data_direction direction)
 {
-	BUG_ON(dev->bus != &pci_bus_type);
+	BUG_ON(dev->bus != &pci_bus_type &&
+	       dev->bus != &ebus_bus_type);
 
 	pci_dma_sync_sg_for_device(to_pci_dev(dev), sg, nelems, (int)direction);
 }
