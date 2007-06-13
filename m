From: David Miller <davem@davemloft.net>
Date: Wed, 13 Jun 2007 06:53:19 +0000
Subject: Re: parport_pc BUG in dma-mapping.h
Message-Id: <20070612.235319.112264415.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0705121525460.4493@math>
In-Reply-To: <Pine.SOC.4.64.0705121525460.4493@math>
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Wed, 16 May 2007 20:32:38 +0300 (EEST)

> > This should fix it, thanks for the report:
> > 
> > commit 9ac6d4a4b85004dbb907f1d3b34412afe16f3758
> > Author: David S. Miller <davem@sunset.davemloft.net>
> > Date:   Mon May 14 02:56:03 2007 -0700
> > 
> >     [SPARC64]: Accept ebus_bus_type for generic DMA ops.
> >     
> >     Based upon a bug report by Meelis Roos.
> >     
> >     Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> Unfortunately it does not seems to fix it.

All along the compiler was telling us the problem:

In file included from drivers/parport/parport_pc.c:67:
include/asm/parport.h: In function $,1rx(Bparport_isa_probe$,1ry(B:
include/asm/parport.h:148: error: request for member $,1rx(Bdev$,1ry(B in something not a structure or union
include/asm/parport.h: In function $,1rx(Bparport_pc_find_nonpci_ports$,1ry(B:
include/asm/parport.h:203: error: request for member $,1rx(Bdev$,1ry(B in something not a structure or union

The following patch should fix things for good:

commit f75823072cd2bfa6e7aacafa15c9e5af7ce8d879
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Tue Jun 12 23:53:03 2007 -0700

    [SPARC64]: Really fix parport.
    
    We were passing a "struct pci_dev *" instead of a
    "struct device *" to the parport registry routines.
    No wonder things exploded.
    
    The ebus_bus_type hacks can be backed out from
    asm-sparc64/dma-mapping.h, those were wrong.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/include/asm-sparc64/dma-mapping.h b/include/asm-sparc64/dma-mapping.h
index 4e21c2f..c58ec16 100644
--- a/include/asm-sparc64/dma-mapping.h
+++ b/include/asm-sparc64/dma-mapping.h
@@ -15,8 +15,7 @@
 static inline int
 dma_supported(struct device *dev, u64 mask)
 {
-	BUG_ON(dev->bus != &pci_bus_type &&
-	       dev->bus != &ebus_bus_type);
+	BUG_ON(dev->bus != &pci_bus_type);
 
 	return pci_dma_supported(to_pci_dev(dev), mask);
 }
@@ -24,8 +23,7 @@ dma_supported(struct device *dev, u64 mask)
 static inline int
 dma_set_mask(struct device *dev, u64 dma_mask)
 {
-	BUG_ON(dev->bus != &pci_bus_type &&
-	       dev->bus != &ebus_bus_type);
+	BUG_ON(dev->bus != &pci_bus_type);
 
 	return pci_set_dma_mask(to_pci_dev(dev), dma_mask);
 }
@@ -34,8 +32,7 @@ static inline void *
 dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		   gfp_t flag)
 {
-	BUG_ON(dev->bus != &pci_bus_type &&
-	       dev->bus != &ebus_bus_type);
+	BUG_ON(dev->bus != &pci_bus_type);
 
 	return pci_iommu_ops->alloc_consistent(to_pci_dev(dev), size, dma_handle, flag);
 }
@@ -44,8 +41,7 @@ static inline void
 dma_free_coherent(struct device *dev, size_t size, void *cpu_addr,
 		    dma_addr_t dma_handle)
 {
-	BUG_ON(dev->bus != &pci_bus_type &&
-	       dev->bus != &ebus_bus_type);
+	BUG_ON(dev->bus != &pci_bus_type);
 
 	pci_free_consistent(to_pci_dev(dev), size, cpu_addr, dma_handle);
 }
@@ -54,8 +50,7 @@ static inline dma_addr_t
 dma_map_single(struct device *dev, void *cpu_addr, size_t size,
 	       enum dma_data_direction direction)
 {
-	BUG_ON(dev->bus != &pci_bus_type &&
-	       dev->bus != &ebus_bus_type);
+	BUG_ON(dev->bus != &pci_bus_type);
 
 	return pci_map_single(to_pci_dev(dev), cpu_addr, size, (int)direction);
 }
@@ -64,8 +59,7 @@ static inline void
 dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
 		 enum dma_data_direction direction)
 {
-	BUG_ON(dev->bus != &pci_bus_type &&
-	       dev->bus != &ebus_bus_type);
+	BUG_ON(dev->bus != &pci_bus_type);
 
 	pci_unmap_single(to_pci_dev(dev), dma_addr, size, (int)direction);
 }
@@ -75,8 +69,7 @@ dma_map_page(struct device *dev, struct page *page,
 	     unsigned long offset, size_t size,
 	     enum dma_data_direction direction)
 {
-	BUG_ON(dev->bus != &pci_bus_type &&
-	       dev->bus != &ebus_bus_type);
+	BUG_ON(dev->bus != &pci_bus_type);
 
 	return pci_map_page(to_pci_dev(dev), page, offset, size, (int)direction);
 }
@@ -85,8 +78,7 @@ static inline void
 dma_unmap_page(struct device *dev, dma_addr_t dma_address, size_t size,
 	       enum dma_data_direction direction)
 {
-	BUG_ON(dev->bus != &pci_bus_type &&
-	       dev->bus != &ebus_bus_type);
+	BUG_ON(dev->bus != &pci_bus_type);
 
 	pci_unmap_page(to_pci_dev(dev), dma_address, size, (int)direction);
 }
@@ -95,8 +87,7 @@ static inline int
 dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 	   enum dma_data_direction direction)
 {
-	BUG_ON(dev->bus != &pci_bus_type &&
-	       dev->bus != &ebus_bus_type);
+	BUG_ON(dev->bus != &pci_bus_type);
 
 	return pci_map_sg(to_pci_dev(dev), sg, nents, (int)direction);
 }
@@ -105,8 +96,7 @@ static inline void
 dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
 	     enum dma_data_direction direction)
 {
-	BUG_ON(dev->bus != &pci_bus_type &&
-	       dev->bus != &ebus_bus_type);
+	BUG_ON(dev->bus != &pci_bus_type);
 
 	pci_unmap_sg(to_pci_dev(dev), sg, nhwentries, (int)direction);
 }
@@ -115,8 +105,7 @@ static inline void
 dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle, size_t size,
 			enum dma_data_direction direction)
 {
-	BUG_ON(dev->bus != &pci_bus_type &&
-	       dev->bus != &ebus_bus_type);
+	BUG_ON(dev->bus != &pci_bus_type);
 
 	pci_dma_sync_single_for_cpu(to_pci_dev(dev), dma_handle,
 				    size, (int)direction);
@@ -126,8 +115,7 @@ static inline void
 dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle, size_t size,
 			   enum dma_data_direction direction)
 {
-	BUG_ON(dev->bus != &pci_bus_type &&
-	       dev->bus != &ebus_bus_type);
+	BUG_ON(dev->bus != &pci_bus_type);
 
 	pci_dma_sync_single_for_device(to_pci_dev(dev), dma_handle,
 				       size, (int)direction);
@@ -137,8 +125,7 @@ static inline void
 dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg, int nelems,
 		    enum dma_data_direction direction)
 {
-	BUG_ON(dev->bus != &pci_bus_type &&
-	       dev->bus != &ebus_bus_type);
+	BUG_ON(dev->bus != &pci_bus_type);
 
 	pci_dma_sync_sg_for_cpu(to_pci_dev(dev), sg, nelems, (int)direction);
 }
@@ -147,8 +134,7 @@ static inline void
 dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg, int nelems,
 		       enum dma_data_direction direction)
 {
-	BUG_ON(dev->bus != &pci_bus_type &&
-	       dev->bus != &ebus_bus_type);
+	BUG_ON(dev->bus != &pci_bus_type);
 
 	pci_dma_sync_sg_for_device(to_pci_dev(dev), sg, nelems, (int)direction);
 }
diff --git a/include/asm-sparc64/parport.h b/include/asm-sparc64/parport.h
index 6340a52..23cc63f 100644
--- a/include/asm-sparc64/parport.h
+++ b/include/asm-sparc64/parport.h
@@ -145,7 +145,7 @@ static int parport_isa_probe(int count)
 			 */
 			if (parport_pc_probe_port(base, base + 0x400,
 						  child->irq, PARPORT_DMA_NOFIFO,
-						  child->bus->self))
+						  &child->bus->self->dev))
 				count++;
 		}
 	}
@@ -199,7 +199,8 @@ static int parport_pc_find_nonpci_ports (int autoirq, int autodma)
 
 				if (parport_pc_probe_port(base, base + 0x400,
 							  edev->irqs[0],
-							  count, ebus->self))
+							  count,
+							  &ebus->self->dev))
 					count++;
 			}
 		}

