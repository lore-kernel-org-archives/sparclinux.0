From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:23:32 +0000
Subject: [PATCH 6/49]: sparc: Make SBUS DMA interfaces take struct device.
Message-Id: <20080827.212332.106037842.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc: Make SBUS DMA interfaces take struct device.

This is the first step in converting all the SBUS drivers
over to generic dma_*().

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/sbus_32.h    |   20 ++++++--------
 arch/sparc/include/asm/sbus_64.h    |   48 +++++++++++------------------------
 arch/sparc/kernel/ioport.c          |   43 ++++++++++++++-----------------
 arch/sparc/kernel/sparc_ksyms.c     |    2 -
 arch/sparc64/kernel/sparc64_ksyms.c |    2 -
 drivers/atm/fore200e.c              |   34 +++++++++++++++++-------
 drivers/net/myri_sbus.c             |   27 ++++++++++++-------
 drivers/net/sunbmac.c               |   28 +++++++++++---------
 drivers/net/sunhme.c                |   36 ++++++++++++++------------
 drivers/net/sunhme.h                |    1 +
 drivers/net/sunlance.c              |    5 ++-
 drivers/net/sunqe.c                 |   12 ++++----
 drivers/scsi/qlogicpti.c            |   21 ++++++++-------
 drivers/scsi/sun_esp.c              |   23 +++++++++++-----
 sound/core/memalloc.c               |    6 +++-
 sound/sparc/dbri.c                  |   15 ++++++----
 16 files changed, 167 insertions(+), 156 deletions(-)

diff --git a/arch/sparc/include/asm/sbus_32.h b/arch/sparc/include/asm/sbus_32.h
index a7b4fa2..61d99f1 100644
--- a/arch/sparc/include/asm/sbus_32.h
+++ b/arch/sparc/include/asm/sbus_32.h
@@ -109,8 +109,8 @@ extern void sbus_set_sbus64(struct sbus_dev *, int);
 extern void sbus_fill_device_irq(struct sbus_dev *);
 
 /* These yield IOMMU mappings in consistent mode. */
-extern void *sbus_alloc_consistent(struct sbus_dev *, long, u32 *dma_addrp);
-extern void sbus_free_consistent(struct sbus_dev *, long, void *, u32);
+extern void *sbus_alloc_consistent(struct device *, long, u32 *dma_addrp);
+extern void sbus_free_consistent(struct device *, long, void *, u32);
 void prom_adjust_ranges(struct linux_prom_ranges *, int,
 			struct linux_prom_ranges *, int);
 
@@ -120,18 +120,14 @@ void prom_adjust_ranges(struct linux_prom_ranges *, int,
 #define	SBUS_DMA_NONE		DMA_NONE
 
 /* All the rest use streaming mode mappings. */
-extern dma_addr_t sbus_map_single(struct sbus_dev *, void *, size_t, int);
-extern void sbus_unmap_single(struct sbus_dev *, dma_addr_t, size_t, int);
-extern int sbus_map_sg(struct sbus_dev *, struct scatterlist *, int, int);
-extern void sbus_unmap_sg(struct sbus_dev *, struct scatterlist *, int, int);
+extern dma_addr_t sbus_map_single(struct device *, void *, size_t, int);
+extern void sbus_unmap_single(struct device *, dma_addr_t, size_t, int);
+extern int sbus_map_sg(struct device *, struct scatterlist *, int, int);
+extern void sbus_unmap_sg(struct device *, struct scatterlist *, int, int);
 
 /* Finally, allow explicit synchronization of streamable mappings. */
-extern void sbus_dma_sync_single_for_cpu(struct sbus_dev *, dma_addr_t, size_t, int);
-#define sbus_dma_sync_single sbus_dma_sync_single_for_cpu
-extern void sbus_dma_sync_single_for_device(struct sbus_dev *, dma_addr_t, size_t, int);
-extern void sbus_dma_sync_sg_for_cpu(struct sbus_dev *, struct scatterlist *, int, int);
-#define sbus_dma_sync_sg sbus_dma_sync_sg_for_cpu
-extern void sbus_dma_sync_sg_for_device(struct sbus_dev *, struct scatterlist *, int, int);
+extern void sbus_dma_sync_single_for_cpu(struct device *, dma_addr_t, size_t, int);
+extern void sbus_dma_sync_single_for_device(struct device *, dma_addr_t, size_t, int);
 
 /* Eric Brower (ebrower@usa.net)
  * Translate SBus interrupt levels to ino values--
diff --git a/arch/sparc/include/asm/sbus_64.h b/arch/sparc/include/asm/sbus_64.h
index b606c14..b22e99d 100644
--- a/arch/sparc/include/asm/sbus_64.h
+++ b/arch/sparc/include/asm/sbus_64.h
@@ -100,17 +100,16 @@ extern struct sbus_bus *sbus_root;
 extern void sbus_set_sbus64(struct sbus_dev *, int);
 extern void sbus_fill_device_irq(struct sbus_dev *);
 
-static inline void *sbus_alloc_consistent(struct sbus_dev *sdev , size_t size,
+static inline void *sbus_alloc_consistent(struct device *dev , size_t size,
 					  dma_addr_t *dma_handle)
 {
-	return dma_alloc_coherent(&sdev->ofdev.dev, size,
-				  dma_handle, GFP_ATOMIC);
+	return dma_alloc_coherent(dev, size, dma_handle, GFP_ATOMIC);
 }
 
-static inline void sbus_free_consistent(struct sbus_dev *sdev, size_t size,
+static inline void sbus_free_consistent(struct device *dev, size_t size,
 					void *vaddr, dma_addr_t dma_handle)
 {
-	return dma_free_coherent(&sdev->ofdev.dev, size, vaddr, dma_handle);
+	return dma_free_coherent(dev, size, vaddr, dma_handle);
 }
 
 #define SBUS_DMA_BIDIRECTIONAL	DMA_BIDIRECTIONAL
@@ -119,68 +118,51 @@ static inline void sbus_free_consistent(struct sbus_dev *sdev, size_t size,
 #define	SBUS_DMA_NONE		DMA_NONE
 
 /* All the rest use streaming mode mappings. */
-static inline dma_addr_t sbus_map_single(struct sbus_dev *sdev, void *ptr,
+static inline dma_addr_t sbus_map_single(struct device *dev, void *ptr,
 					 size_t size, int direction)
 {
-	return dma_map_single(&sdev->ofdev.dev, ptr, size,
+	return dma_map_single(dev, ptr, size,
 			      (enum dma_data_direction) direction);
 }
 
-static inline void sbus_unmap_single(struct sbus_dev *sdev,
+static inline void sbus_unmap_single(struct device *dev,
 				     dma_addr_t dma_addr, size_t size,
 				     int direction)
 {
-	dma_unmap_single(&sdev->ofdev.dev, dma_addr, size,
+	dma_unmap_single(dev, dma_addr, size,
 			 (enum dma_data_direction) direction);
 }
 
-static inline int sbus_map_sg(struct sbus_dev *sdev, struct scatterlist *sg,
+static inline int sbus_map_sg(struct device *dev, struct scatterlist *sg,
 			      int nents, int direction)
 {
-	return dma_map_sg(&sdev->ofdev.dev, sg, nents,
+	return dma_map_sg(dev, sg, nents,
 			  (enum dma_data_direction) direction);
 }
 
-static inline void sbus_unmap_sg(struct sbus_dev *sdev, struct scatterlist *sg,
+static inline void sbus_unmap_sg(struct device *dev, struct scatterlist *sg,
 				 int nents, int direction)
 {
-	dma_unmap_sg(&sdev->ofdev.dev, sg, nents,
+	dma_unmap_sg(dev, sg, nents,
 		     (enum dma_data_direction) direction);
 }
 
 /* Finally, allow explicit synchronization of streamable mappings. */
-static inline void sbus_dma_sync_single_for_cpu(struct sbus_dev *sdev,
+static inline void sbus_dma_sync_single_for_cpu(struct device *dev,
 						dma_addr_t dma_handle,
 						size_t size, int direction)
 {
-	dma_sync_single_for_cpu(&sdev->ofdev.dev, dma_handle, size,
+	dma_sync_single_for_cpu(dev, dma_handle, size,
 				(enum dma_data_direction) direction);
 }
-#define sbus_dma_sync_single sbus_dma_sync_single_for_cpu
 
-static inline void sbus_dma_sync_single_for_device(struct sbus_dev *sdev,
+static inline void sbus_dma_sync_single_for_device(struct device *dev,
 						   dma_addr_t dma_handle,
 						   size_t size, int direction)
 {
 	/* No flushing needed to sync cpu writes to the device.  */
 }
 
-static inline void sbus_dma_sync_sg_for_cpu(struct sbus_dev *sdev,
-					    struct scatterlist *sg,
-					    int nents, int direction)
-{
-	dma_sync_sg_for_cpu(&sdev->ofdev.dev, sg, nents,
-			    (enum dma_data_direction) direction);
-}
-#define sbus_dma_sync_sg sbus_dma_sync_sg_for_cpu
-
-static inline void sbus_dma_sync_sg_for_device(struct sbus_dev *sdev,
-					       struct scatterlist *sg,
-					       int nents, int direction)
-{
-	/* No flushing needed to sync cpu writes to the device.  */
-}
-
 extern void sbus_arch_bus_ranges_init(struct device_node *, struct sbus_bus *);
 extern void sbus_setup_iommu(struct sbus_bus *, struct device_node *);
 extern void sbus_setup_arch_props(struct sbus_bus *, struct device_node *);
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index f6158c4..aa73b3b 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -300,11 +300,10 @@ void __init sbus_fill_device_irq(struct sbus_dev *sdev)
  * Allocate a chunk of memory suitable for DMA.
  * Typically devices use them for control blocks.
  * CPU may access them without any explicit flushing.
- *
- * XXX Some clever people know that sdev is not used and supply NULL. Watch.
  */
-void *sbus_alloc_consistent(struct sbus_dev *sdev, long len, u32 *dma_addrp)
+void *sbus_alloc_consistent(struct device *dev, long len, u32 *dma_addrp)
 {
+	struct of_device *op = to_of_device(dev);
 	unsigned long len_total = (len + PAGE_SIZE-1) & PAGE_MASK;
 	unsigned long va;
 	struct resource *res;
@@ -341,10 +340,7 @@ void *sbus_alloc_consistent(struct sbus_dev *sdev, long len, u32 *dma_addrp)
 	if (mmu_map_dma_area(dma_addrp, va, res->start, len_total) != 0)
 		goto err_noiommu;
 
-	/* Set the resource name, if known. */
-	if (sdev) {
-		res->name = sdev->prom_name;
-	}
+	res->name = op->node->name;
 
 	return (void *)(unsigned long)res->start;
 
@@ -358,7 +354,7 @@ err_nopages:
 	return NULL;
 }
 
-void sbus_free_consistent(struct sbus_dev *sdev, long n, void *p, u32 ba)
+void sbus_free_consistent(struct device *dev, long n, void *p, u32 ba)
 {
 	struct resource *res;
 	struct page *pgv;
@@ -396,8 +392,10 @@ void sbus_free_consistent(struct sbus_dev *sdev, long n, void *p, u32 ba)
  * CPU view of this memory may be inconsistent with
  * a device view and explicit flushing is necessary.
  */
-dma_addr_t sbus_map_single(struct sbus_dev *sdev, void *va, size_t len, int direction)
+dma_addr_t sbus_map_single(struct device *dev, void *va, size_t len, int direction)
 {
+	struct sbus_dev *sdev = to_sbus_device(dev);
+
 	/* XXX why are some lengths signed, others unsigned? */
 	if (len <= 0) {
 		return 0;
@@ -409,13 +407,16 @@ dma_addr_t sbus_map_single(struct sbus_dev *sdev, void *va, size_t len, int dire
 	return mmu_get_scsi_one(va, len, sdev->bus);
 }
 
-void sbus_unmap_single(struct sbus_dev *sdev, dma_addr_t ba, size_t n, int direction)
+void sbus_unmap_single(struct device *dev, dma_addr_t ba, size_t n, int direction)
 {
+	struct sbus_dev *sdev = to_sbus_device(dev);
 	mmu_release_scsi_one(ba, n, sdev->bus);
 }
 
-int sbus_map_sg(struct sbus_dev *sdev, struct scatterlist *sg, int n, int direction)
+int sbus_map_sg(struct device *dev, struct scatterlist *sg, int n, int direction)
 {
+	struct sbus_dev *sdev = to_sbus_device(dev);
+
 	mmu_get_scsi_sgl(sg, n, sdev->bus);
 
 	/*
@@ -425,16 +426,19 @@ int sbus_map_sg(struct sbus_dev *sdev, struct scatterlist *sg, int n, int direct
 	return n;
 }
 
-void sbus_unmap_sg(struct sbus_dev *sdev, struct scatterlist *sg, int n, int direction)
+void sbus_unmap_sg(struct device *dev, struct scatterlist *sg, int n, int direction)
 {
+	struct sbus_dev *sdev = to_sbus_device(dev);
+
 	mmu_release_scsi_sgl(sg, n, sdev->bus);
 }
 
 /*
  */
-void sbus_dma_sync_single_for_cpu(struct sbus_dev *sdev, dma_addr_t ba, size_t size, int direction)
+void sbus_dma_sync_single_for_cpu(struct device *dev, dma_addr_t ba, size_t size, int direction)
 {
 #if 0
+	struct sbus_dev *sdev = to_sbus_device(dev);
 	unsigned long va;
 	struct resource *res;
 
@@ -452,9 +456,10 @@ void sbus_dma_sync_single_for_cpu(struct sbus_dev *sdev, dma_addr_t ba, size_t s
 #endif
 }
 
-void sbus_dma_sync_single_for_device(struct sbus_dev *sdev, dma_addr_t ba, size_t size, int direction)
+void sbus_dma_sync_single_for_device(struct device *dev, dma_addr_t ba, size_t size, int direction)
 {
 #if 0
+	struct sbus_dev *sdev = to_sbus_device(dev);
 	unsigned long va;
 	struct resource *res;
 
@@ -472,16 +477,6 @@ void sbus_dma_sync_single_for_device(struct sbus_dev *sdev, dma_addr_t ba, size_
 #endif
 }
 
-void sbus_dma_sync_sg_for_cpu(struct sbus_dev *sdev, struct scatterlist *sg, int n, int direction)
-{
-	printk("sbus_dma_sync_sg_for_cpu: not implemented yet\n");
-}
-
-void sbus_dma_sync_sg_for_device(struct sbus_dev *sdev, struct scatterlist *sg, int n, int direction)
-{
-	printk("sbus_dma_sync_sg_for_device: not implemented yet\n");
-}
-
 /* Support code for sbus_init().  */
 /*
  * XXX This functions appears to be a distorted version of
diff --git a/arch/sparc/kernel/sparc_ksyms.c b/arch/sparc/kernel/sparc_ksyms.c
index 8a392d3..9d85a83 100644
--- a/arch/sparc/kernel/sparc_ksyms.c
+++ b/arch/sparc/kernel/sparc_ksyms.c
@@ -163,8 +163,6 @@ EXPORT_SYMBOL(sbus_map_sg);
 EXPORT_SYMBOL(sbus_unmap_sg);
 EXPORT_SYMBOL(sbus_dma_sync_single_for_cpu);
 EXPORT_SYMBOL(sbus_dma_sync_single_for_device);
-EXPORT_SYMBOL(sbus_dma_sync_sg_for_cpu);
-EXPORT_SYMBOL(sbus_dma_sync_sg_for_device);
 EXPORT_SYMBOL(sbus_iounmap);
 EXPORT_SYMBOL(sbus_ioremap);
 #endif
diff --git a/arch/sparc64/kernel/sparc64_ksyms.c b/arch/sparc64/kernel/sparc64_ksyms.c
index 8e6ac5c..1c56c8b 100644
--- a/arch/sparc64/kernel/sparc64_ksyms.c
+++ b/arch/sparc64/kernel/sparc64_ksyms.c
@@ -170,8 +170,6 @@ EXPORT_SYMBOL(sbus_map_sg);
 EXPORT_SYMBOL(sbus_unmap_sg);
 EXPORT_SYMBOL(sbus_dma_sync_single_for_cpu);
 EXPORT_SYMBOL(sbus_dma_sync_single_for_device);
-EXPORT_SYMBOL(sbus_dma_sync_sg_for_cpu);
-EXPORT_SYMBOL(sbus_dma_sync_sg_for_device);
 #endif
 EXPORT_SYMBOL(outsb);
 EXPORT_SYMBOL(outsw);
diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
index 73338d2..c5ab44f 100644
--- a/drivers/atm/fore200e.c
+++ b/drivers/atm/fore200e.c
@@ -678,7 +678,9 @@ fore200e_sba_write(u32 val, volatile u32 __iomem *addr)
 static u32
 fore200e_sba_dma_map(struct fore200e* fore200e, void* virt_addr, int size, int direction)
 {
-    u32 dma_addr = sbus_map_single((struct sbus_dev*)fore200e->bus_dev, virt_addr, size, direction);
+    struct sbus_dev *sdev = fore200e->bus_dev;
+    struct device *dev = &sdev->ofdev.dev;
+    u32 dma_addr = sbus_map_single(dev, virt_addr, size, direction);
 
     DPRINTK(3, "SBUS DVMA mapping: virt_addr = 0x%p, size = %d, direction = %d --> dma_addr = 0x%08x\n",
 	    virt_addr, size, direction, dma_addr);
@@ -690,27 +692,36 @@ fore200e_sba_dma_map(struct fore200e* fore200e, void* virt_addr, int size, int d
 static void
 fore200e_sba_dma_unmap(struct fore200e* fore200e, u32 dma_addr, int size, int direction)
 {
+    struct sbus_dev *sdev = fore200e->bus_dev;
+    struct device *dev = &sdev->ofdev.dev;
+
     DPRINTK(3, "SBUS DVMA unmapping: dma_addr = 0x%08x, size = %d, direction = %d,\n",
 	    dma_addr, size, direction);
 
-    sbus_unmap_single((struct sbus_dev*)fore200e->bus_dev, dma_addr, size, direction);
+    sbus_unmap_single(dev, dma_addr, size, direction);
 }
 
 
 static void
 fore200e_sba_dma_sync_for_cpu(struct fore200e* fore200e, u32 dma_addr, int size, int direction)
 {
+    struct sbus_dev *sdev = fore200e->bus_dev;
+    struct device *dev = &sdev->ofdev.dev;
+
     DPRINTK(3, "SBUS DVMA sync: dma_addr = 0x%08x, size = %d, direction = %d\n", dma_addr, size, direction);
     
-    sbus_dma_sync_single_for_cpu((struct sbus_dev*)fore200e->bus_dev, dma_addr, size, direction);
+    sbus_dma_sync_single_for_cpu(dev, dma_addr, size, direction);
 }
 
 static void
 fore200e_sba_dma_sync_for_device(struct fore200e* fore200e, u32 dma_addr, int size, int direction)
 {
+    struct sbus_dev *sdev = fore200e->bus_dev;
+    struct device *dev = &sdev->ofdev.dev;
+
     DPRINTK(3, "SBUS DVMA sync: dma_addr = 0x%08x, size = %d, direction = %d\n", dma_addr, size, direction);
 
-    sbus_dma_sync_single_for_device((struct sbus_dev*)fore200e->bus_dev, dma_addr, size, direction);
+    sbus_dma_sync_single_for_device(dev, dma_addr, size, direction);
 }
 
 
@@ -721,11 +732,13 @@ static int
 fore200e_sba_dma_chunk_alloc(struct fore200e* fore200e, struct chunk* chunk,
 			     int size, int nbr, int alignment)
 {
+    struct sbus_dev *sdev = (struct sbus_dev *) fore200e->bus_dev;
+    struct device *dev = &sdev->ofdev.dev;
+
     chunk->alloc_size = chunk->align_size = size * nbr;
 
     /* returned chunks are page-aligned */
-    chunk->alloc_addr = sbus_alloc_consistent((struct sbus_dev*)fore200e->bus_dev,
-					      chunk->alloc_size,
+    chunk->alloc_addr = sbus_alloc_consistent(dev, chunk->alloc_size,
 					      &chunk->dma_addr);
 
     if ((chunk->alloc_addr = NULL) || (chunk->dma_addr = 0))
@@ -742,10 +755,11 @@ fore200e_sba_dma_chunk_alloc(struct fore200e* fore200e, struct chunk* chunk,
 static void
 fore200e_sba_dma_chunk_free(struct fore200e* fore200e, struct chunk* chunk)
 {
-    sbus_free_consistent((struct sbus_dev*)fore200e->bus_dev,
-			 chunk->alloc_size,
-			 chunk->alloc_addr,
-			 chunk->dma_addr);
+    struct sbus_dev *sdev = (struct sbus_dev *) fore200e->bus_dev;
+    struct device *dev = &sdev->ofdev.dev;
+
+    sbus_free_consistent(dev, chunk->alloc_size,
+			 chunk->alloc_addr, chunk->dma_addr);
 }
 
 
diff --git a/drivers/net/myri_sbus.c b/drivers/net/myri_sbus.c
index 656a260..c174621 100644
--- a/drivers/net/myri_sbus.c
+++ b/drivers/net/myri_sbus.c
@@ -243,7 +243,8 @@ static void myri_clean_rings(struct myri_eth *mp)
 			u32 dma_addr;
 
 			dma_addr = sbus_readl(&rxd->myri_scatters[0].addr);
-			sbus_unmap_single(mp->myri_sdev, dma_addr, RX_ALLOC_SIZE, SBUS_DMA_FROMDEVICE);
+			sbus_unmap_single(&mp->myri_sdev->ofdev.dev, dma_addr,
+					  RX_ALLOC_SIZE, SBUS_DMA_FROMDEVICE);
 			dev_kfree_skb(mp->rx_skbs[i]);
 			mp->rx_skbs[i] = NULL;
 		}
@@ -259,7 +260,9 @@ static void myri_clean_rings(struct myri_eth *mp)
 			u32 dma_addr;
 
 			dma_addr = sbus_readl(&txd->myri_gathers[0].addr);
-			sbus_unmap_single(mp->myri_sdev, dma_addr, (skb->len + 3) & ~3, SBUS_DMA_TODEVICE);
+			sbus_unmap_single(&mp->myri_sdev->ofdev.dev, dma_addr,
+					  (skb->len + 3) & ~3,
+					  SBUS_DMA_TODEVICE);
 			dev_kfree_skb(mp->tx_skbs[i]);
 			mp->tx_skbs[i] = NULL;
 		}
@@ -288,7 +291,9 @@ static void myri_init_rings(struct myri_eth *mp, int from_irq)
 		skb->dev = dev;
 		skb_put(skb, RX_ALLOC_SIZE);
 
-		dma_addr = sbus_map_single(mp->myri_sdev, skb->data, RX_ALLOC_SIZE, SBUS_DMA_FROMDEVICE);
+		dma_addr = sbus_map_single(&mp->myri_sdev->ofdev.dev,
+					   skb->data, RX_ALLOC_SIZE,
+					   SBUS_DMA_FROMDEVICE);
 		sbus_writel(dma_addr, &rxd[i].myri_scatters[0].addr);
 		sbus_writel(RX_ALLOC_SIZE, &rxd[i].myri_scatters[0].len);
 		sbus_writel(i, &rxd[i].ctx);
@@ -344,7 +349,8 @@ static void myri_tx(struct myri_eth *mp, struct net_device *dev)
 
 		DTX(("SKB[%d] ", entry));
 		dma_addr = sbus_readl(&sq->myri_txd[entry].myri_gathers[0].addr);
-		sbus_unmap_single(mp->myri_sdev, dma_addr, skb->len, SBUS_DMA_TODEVICE);
+		sbus_unmap_single(&mp->myri_sdev->ofdev.dev, dma_addr,
+				  skb->len, SBUS_DMA_TODEVICE);
 		dev_kfree_skb(skb);
 		mp->tx_skbs[entry] = NULL;
 		dev->stats.tx_packets++;
@@ -423,7 +429,7 @@ static void myri_rx(struct myri_eth *mp, struct net_device *dev)
 
 		/* Check for errors. */
 		DRX(("rxd[%d]: %p len[%d] csum[%08x] ", entry, rxd, len, csum));
-		sbus_dma_sync_single_for_cpu(mp->myri_sdev,
+		sbus_dma_sync_single_for_cpu(&mp->myri_sdev->ofdev.dev,
 					     sbus_readl(&rxd->myri_scatters[0].addr),
 					     RX_ALLOC_SIZE, SBUS_DMA_FROMDEVICE);
 		if (len < (ETH_HLEN + MYRI_PAD_LEN) || (skb->data[0] != MYRI_PAD_LEN)) {
@@ -442,7 +448,7 @@ static void myri_rx(struct myri_eth *mp, struct net_device *dev)
 			drops++;
 			DRX(("DROP "));
 			dev->stats.rx_dropped++;
-			sbus_dma_sync_single_for_device(mp->myri_sdev,
+			sbus_dma_sync_single_for_device(&mp->myri_sdev->ofdev.dev,
 							sbus_readl(&rxd->myri_scatters[0].addr),
 							RX_ALLOC_SIZE,
 							SBUS_DMA_FROMDEVICE);
@@ -464,14 +470,14 @@ static void myri_rx(struct myri_eth *mp, struct net_device *dev)
 				DRX(("skb_alloc(FAILED) "));
 				goto drop_it;
 			}
-			sbus_unmap_single(mp->myri_sdev,
+			sbus_unmap_single(&mp->myri_sdev->ofdev.dev,
 					  sbus_readl(&rxd->myri_scatters[0].addr),
 					  RX_ALLOC_SIZE,
 					  SBUS_DMA_FROMDEVICE);
 			mp->rx_skbs[index] = new_skb;
 			new_skb->dev = dev;
 			skb_put(new_skb, RX_ALLOC_SIZE);
-			dma_addr = sbus_map_single(mp->myri_sdev,
+			dma_addr = sbus_map_single(&mp->myri_sdev->ofdev.dev,
 						   new_skb->data,
 						   RX_ALLOC_SIZE,
 						   SBUS_DMA_FROMDEVICE);
@@ -500,7 +506,7 @@ static void myri_rx(struct myri_eth *mp, struct net_device *dev)
 
 			/* Reuse original ring buffer. */
 			DRX(("reuse "));
-			sbus_dma_sync_single_for_device(mp->myri_sdev,
+			sbus_dma_sync_single_for_device(&mp->myri_sdev->ofdev.dev,
 							sbus_readl(&rxd->myri_scatters[0].addr),
 							RX_ALLOC_SIZE,
 							SBUS_DMA_FROMDEVICE);
@@ -652,7 +658,8 @@ static int myri_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		sbus_writew((skb->data[4] << 8) | skb->data[5], &txd->addr[3]);
 	}
 
-	dma_addr = sbus_map_single(mp->myri_sdev, skb->data, len, SBUS_DMA_TODEVICE);
+	dma_addr = sbus_map_single(&mp->myri_sdev->ofdev.dev, skb->data,
+				   len, SBUS_DMA_TODEVICE);
 	sbus_writel(dma_addr, &txd->myri_gathers[0].addr);
 	sbus_writel(len, &txd->myri_gathers[0].len);
 	sbus_writel(1, &txd->num_sg);
diff --git a/drivers/net/sunbmac.c b/drivers/net/sunbmac.c
index 0e4a88d..b92218c 100644
--- a/drivers/net/sunbmac.c
+++ b/drivers/net/sunbmac.c
@@ -239,7 +239,7 @@ static void bigmac_init_rings(struct bigmac *bp, int from_irq)
 		skb_reserve(skb, 34);
 
 		bb->be_rxd[i].rx_addr -			sbus_map_single(bp->bigmac_sdev, skb->data,
+			sbus_map_single(&bp->bigmac_sdev->ofdev.dev, skb->data,
 					RX_BUF_ALLOC_SIZE - 34,
 					SBUS_DMA_FROMDEVICE);
 		bb->be_rxd[i].rx_flags @@ -776,7 +776,7 @@ static void bigmac_tx(struct bigmac *bp)
 		skb = bp->tx_skbs[elem];
 		bp->enet_stats.tx_packets++;
 		bp->enet_stats.tx_bytes += skb->len;
-		sbus_unmap_single(bp->bigmac_sdev,
+		sbus_unmap_single(&bp->bigmac_sdev->ofdev.dev,
 				  this->tx_addr, skb->len,
 				  SBUS_DMA_TODEVICE);
 
@@ -831,7 +831,7 @@ static void bigmac_rx(struct bigmac *bp)
 				drops++;
 				goto drop_it;
 			}
-			sbus_unmap_single(bp->bigmac_sdev,
+			sbus_unmap_single(&bp->bigmac_sdev->ofdev.dev,
 					  this->rx_addr,
 					  RX_BUF_ALLOC_SIZE - 34,
 					  SBUS_DMA_FROMDEVICE);
@@ -839,10 +839,11 @@ static void bigmac_rx(struct bigmac *bp)
 			new_skb->dev = bp->dev;
 			skb_put(new_skb, ETH_FRAME_LEN);
 			skb_reserve(new_skb, 34);
-			this->rx_addr = sbus_map_single(bp->bigmac_sdev,
-							new_skb->data,
-							RX_BUF_ALLOC_SIZE - 34,
-							SBUS_DMA_FROMDEVICE);
+			this->rx_addr +				sbus_map_single(&bp->bigmac_sdev->ofdev.dev,
+						new_skb->data,
+						RX_BUF_ALLOC_SIZE - 34,
+						SBUS_DMA_FROMDEVICE);
 			this->rx_flags  				(RXD_OWN | ((RX_BUF_ALLOC_SIZE - 34) & RXD_LENGTH));
 
@@ -857,11 +858,11 @@ static void bigmac_rx(struct bigmac *bp)
 			}
 			skb_reserve(copy_skb, 2);
 			skb_put(copy_skb, len);
-			sbus_dma_sync_single_for_cpu(bp->bigmac_sdev,
+			sbus_dma_sync_single_for_cpu(&bp->bigmac_sdev->ofdev.dev,
 						     this->rx_addr, len,
 						     SBUS_DMA_FROMDEVICE);
 			skb_copy_to_linear_data(copy_skb, (unsigned char *)skb->data, len);
-			sbus_dma_sync_single_for_device(bp->bigmac_sdev,
+			sbus_dma_sync_single_for_device(&bp->bigmac_sdev->ofdev.dev,
 							this->rx_addr, len,
 							SBUS_DMA_FROMDEVICE);
 
@@ -959,7 +960,8 @@ static int bigmac_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	u32 mapping;
 
 	len = skb->len;
-	mapping = sbus_map_single(bp->bigmac_sdev, skb->data, len, SBUS_DMA_TODEVICE);
+	mapping = sbus_map_single(&bp->bigmac_sdev->ofdev.dev, skb->data,
+				  len, SBUS_DMA_TODEVICE);
 
 	/* Avoid a race... */
 	spin_lock_irq(&bp->lock);
@@ -1183,7 +1185,7 @@ static int __devinit bigmac_ether_init(struct sbus_dev *qec_sdev)
 	bigmac_stop(bp);
 
 	/* Allocate transmit/receive descriptor DVMA block. */
-	bp->bmac_block = sbus_alloc_consistent(bp->bigmac_sdev,
+	bp->bmac_block = sbus_alloc_consistent(&bp->bigmac_sdev->ofdev.dev,
 					       PAGE_SIZE,
 					       &bp->bblock_dvma);
 	if (bp->bmac_block = NULL || bp->bblock_dvma = 0) {
@@ -1245,7 +1247,7 @@ fail_and_cleanup:
 		sbus_iounmap(bp->tregs, TCVR_REG_SIZE);
 
 	if (bp->bmac_block)
-		sbus_free_consistent(bp->bigmac_sdev,
+		sbus_free_consistent(&bp->bigmac_sdev->ofdev.dev,
 				     PAGE_SIZE,
 				     bp->bmac_block,
 				     bp->bblock_dvma);
@@ -1280,7 +1282,7 @@ static int __devexit bigmac_sbus_remove(struct of_device *dev)
 	sbus_iounmap(bp->creg, CREG_REG_SIZE);
 	sbus_iounmap(bp->bregs, BMAC_REG_SIZE);
 	sbus_iounmap(bp->tregs, TCVR_REG_SIZE);
-	sbus_free_consistent(bp->bigmac_sdev,
+	sbus_free_consistent(&bp->bigmac_sdev->ofdev.dev,
 			     PAGE_SIZE,
 			     bp->bmac_block,
 			     bp->bblock_dvma);
diff --git a/drivers/net/sunhme.c b/drivers/net/sunhme.c
index b79d5f0..cd93fc5 100644
--- a/drivers/net/sunhme.c
+++ b/drivers/net/sunhme.c
@@ -251,13 +251,13 @@ static u32 pci_hme_read_desc32(hme32 *p)
 #define hme_read_desc32(__hp, __p) \
 	((__hp)->read_desc32(__p))
 #define hme_dma_map(__hp, __ptr, __size, __dir) \
-	((__hp)->dma_map((__hp)->happy_dev, (__ptr), (__size), (__dir)))
+	((__hp)->dma_map((__hp)->dma_dev, (__ptr), (__size), (__dir)))
 #define hme_dma_unmap(__hp, __addr, __size, __dir) \
-	((__hp)->dma_unmap((__hp)->happy_dev, (__addr), (__size), (__dir)))
+	((__hp)->dma_unmap((__hp)->dma_dev, (__addr), (__size), (__dir)))
 #define hme_dma_sync_for_cpu(__hp, __addr, __size, __dir) \
-	((__hp)->dma_sync_for_cpu((__hp)->happy_dev, (__addr), (__size), (__dir)))
+	((__hp)->dma_sync_for_cpu((__hp)->dma_dev, (__addr), (__size), (__dir)))
 #define hme_dma_sync_for_device(__hp, __addr, __size, __dir) \
-	((__hp)->dma_sync_for_device((__hp)->happy_dev, (__addr), (__size), (__dir)))
+	((__hp)->dma_sync_for_device((__hp)->dma_dev, (__addr), (__size), (__dir)))
 #else
 #ifdef CONFIG_SBUS
 /* SBUS only compilation */
@@ -277,13 +277,13 @@ do {	(__txd)->tx_addr = (__force hme32)(u32)(__addr); \
 } while(0)
 #define hme_read_desc32(__hp, __p)	((__force u32)(hme32)*(__p))
 #define hme_dma_map(__hp, __ptr, __size, __dir) \
-	sbus_map_single((__hp)->happy_dev, (__ptr), (__size), (__dir))
+	sbus_map_single((__hp)->dma_dev, (__ptr), (__size), (__dir))
 #define hme_dma_unmap(__hp, __addr, __size, __dir) \
-	sbus_unmap_single((__hp)->happy_dev, (__addr), (__size), (__dir))
+	sbus_unmap_single((__hp)->dma_dev, (__addr), (__size), (__dir))
 #define hme_dma_sync_for_cpu(__hp, __addr, __size, __dir) \
-	sbus_dma_sync_single_for_cpu((__hp)->happy_dev, (__addr), (__size), (__dir))
+	sbus_dma_sync_single_for_cpu((__hp)->dma_dev, (__addr), (__size), (__dir))
 #define hme_dma_sync_for_device(__hp, __addr, __size, __dir) \
-	sbus_dma_sync_single_for_device((__hp)->happy_dev, (__addr), (__size), (__dir))
+	sbus_dma_sync_single_for_device((__hp)->dma_dev, (__addr), (__size), (__dir))
 #else
 /* PCI only compilation */
 #define hme_write32(__hp, __reg, __val) \
@@ -305,13 +305,13 @@ static inline u32 hme_read_desc32(struct happy_meal *hp, hme32 *p)
 	return le32_to_cpup((__le32 *)p);
 }
 #define hme_dma_map(__hp, __ptr, __size, __dir) \
-	pci_map_single((__hp)->happy_dev, (__ptr), (__size), (__dir))
+	pci_map_single((__hp)->dma_dev, (__ptr), (__size), (__dir))
 #define hme_dma_unmap(__hp, __addr, __size, __dir) \
-	pci_unmap_single((__hp)->happy_dev, (__addr), (__size), (__dir))
+	pci_unmap_single((__hp)->dma_dev, (__addr), (__size), (__dir))
 #define hme_dma_sync_for_cpu(__hp, __addr, __size, __dir) \
-	pci_dma_sync_single_for_cpu((__hp)->happy_dev, (__addr), (__size), (__dir))
+	pci_dma_sync_single_for_cpu((__hp)->dma_dev, (__addr), (__size), (__dir))
 #define hme_dma_sync_for_device(__hp, __addr, __size, __dir) \
-	pci_dma_sync_single_for_device((__hp)->happy_dev, (__addr), (__size), (__dir))
+	pci_dma_sync_single_for_device((__hp)->dma_dev, (__addr), (__size), (__dir))
 #endif
 #endif
 
@@ -2716,6 +2716,7 @@ static int __devinit happy_meal_sbus_probe_one(struct sbus_dev *sdev, int is_qfe
 	hp = dev->priv;
 
 	hp->happy_dev = sdev;
+	hp->dma_dev = &sdev->ofdev.dev;
 
 	spin_lock_init(&hp->happy_lock);
 
@@ -2785,7 +2786,7 @@ static int __devinit happy_meal_sbus_probe_one(struct sbus_dev *sdev, int is_qfe
 	hp->happy_bursts = of_getintprop_default(sdev->bus->ofdev.node,
 						 "burst-sizes", 0x00);
 
-	hp->happy_block = sbus_alloc_consistent(hp->happy_dev,
+	hp->happy_block = sbus_alloc_consistent(hp->dma_dev,
 						PAGE_SIZE,
 						&hp->hblock_dvma);
 	err = -ENOMEM;
@@ -2860,7 +2861,7 @@ static int __devinit happy_meal_sbus_probe_one(struct sbus_dev *sdev, int is_qfe
 	return 0;
 
 err_out_free_consistent:
-	sbus_free_consistent(hp->happy_dev,
+	sbus_free_consistent(hp->dma_dev,
 			     PAGE_SIZE,
 			     hp->happy_block,
 			     hp->hblock_dvma);
@@ -3035,6 +3036,7 @@ static int __devinit happy_meal_pci_probe(struct pci_dev *pdev,
 	memset(hp, 0, sizeof(*hp));
 
 	hp->happy_dev = pdev;
+	hp->dma_dev = pdev;
 
 	spin_lock_init(&hp->happy_lock);
 
@@ -3231,12 +3233,12 @@ static void __devexit happy_meal_pci_remove(struct pci_dev *pdev)
 
 	unregister_netdev(net_dev);
 
-	pci_free_consistent(hp->happy_dev,
+	pci_free_consistent(hp->dma_dev,
 			    PAGE_SIZE,
 			    hp->happy_block,
 			    hp->hblock_dvma);
 	iounmap(hp->gregs);
-	pci_release_regions(hp->happy_dev);
+	pci_release_regions(hp->dma_dev);
 
 	free_netdev(net_dev);
 
@@ -3306,7 +3308,7 @@ static int __devexit hme_sbus_remove(struct of_device *dev)
 	sbus_iounmap(hp->erxregs, ERX_REG_SIZE);
 	sbus_iounmap(hp->bigmacregs, BMAC_REG_SIZE);
 	sbus_iounmap(hp->tcvregs, TCVR_REG_SIZE);
-	sbus_free_consistent(hp->happy_dev,
+	sbus_free_consistent(hp->dma_dev,
 			     PAGE_SIZE,
 			     hp->happy_block,
 			     hp->hblock_dvma);
diff --git a/drivers/net/sunhme.h b/drivers/net/sunhme.h
index 4da5539..756e96e 100644
--- a/drivers/net/sunhme.h
+++ b/drivers/net/sunhme.h
@@ -413,6 +413,7 @@ struct happy_meal {
 
 	/* This is either a sbus_dev or a pci_dev. */
 	void			  *happy_dev;
+	void			  *dma_dev;
 
 	spinlock_t		  happy_lock;
 
diff --git a/drivers/net/sunlance.c b/drivers/net/sunlance.c
index 24ffecb..4f4baf9 100644
--- a/drivers/net/sunlance.c
+++ b/drivers/net/sunlance.c
@@ -1283,7 +1283,7 @@ static void lance_free_hwresources(struct lance_private *lp)
 		sbus_iounmap(lp->init_block_iomem,
 			     sizeof(struct lance_init_block));
 	} else if (lp->init_block_mem) {
-		sbus_free_consistent(lp->sdev,
+		sbus_free_consistent(&lp->sdev->ofdev.dev,
 				     sizeof(struct lance_init_block),
 				     lp->init_block_mem,
 				     lp->init_block_dvma);
@@ -1384,7 +1384,8 @@ static int __devinit sparc_lance_probe_one(struct sbus_dev *sdev,
 		lp->tx = lance_tx_pio;
 	} else {
 		lp->init_block_mem -			sbus_alloc_consistent(sdev, sizeof(struct lance_init_block),
+			sbus_alloc_consistent(&sdev->ofdev.dev,
+					      sizeof(struct lance_init_block),
 					      &lp->init_block_dvma);
 		if (!lp->init_block_mem || lp->init_block_dvma = 0) {
 			printk(KERN_ERR "SunLance: Cannot allocate consistent DMA memory.\n");
diff --git a/drivers/net/sunqe.c b/drivers/net/sunqe.c
index e811331..ac8049c 100644
--- a/drivers/net/sunqe.c
+++ b/drivers/net/sunqe.c
@@ -879,10 +879,10 @@ static int __devinit qec_ether_init(struct sbus_dev *sdev)
 		goto fail;
 	}
 
-	qe->qe_block = sbus_alloc_consistent(qe->qe_sdev,
+	qe->qe_block = sbus_alloc_consistent(&qe->qe_sdev->ofdev.dev,
 					     PAGE_SIZE,
 					     &qe->qblock_dvma);
-	qe->buffers = sbus_alloc_consistent(qe->qe_sdev,
+	qe->buffers = sbus_alloc_consistent(&qe->qe_sdev->ofdev.dev,
 					    sizeof(struct sunqe_buffers),
 					    &qe->buffers_dvma);
 	if (qe->qe_block = NULL || qe->qblock_dvma = 0 ||
@@ -926,12 +926,12 @@ fail:
 	if (qe->mregs)
 		sbus_iounmap(qe->mregs, MREGS_REG_SIZE);
 	if (qe->qe_block)
-		sbus_free_consistent(qe->qe_sdev,
+		sbus_free_consistent(&qe->qe_sdev->ofdev.dev,
 				     PAGE_SIZE,
 				     qe->qe_block,
 				     qe->qblock_dvma);
 	if (qe->buffers)
-		sbus_free_consistent(qe->qe_sdev,
+		sbus_free_consistent(&qe->qe_sdev->ofdev.dev,
 				     sizeof(struct sunqe_buffers),
 				     qe->buffers,
 				     qe->buffers_dvma);
@@ -957,11 +957,11 @@ static int __devexit qec_sbus_remove(struct of_device *dev)
 
 	sbus_iounmap(qp->qcregs, CREG_REG_SIZE);
 	sbus_iounmap(qp->mregs, MREGS_REG_SIZE);
-	sbus_free_consistent(qp->qe_sdev,
+	sbus_free_consistent(&qp->qe_sdev->ofdev.dev,
 			     PAGE_SIZE,
 			     qp->qe_block,
 			     qp->qblock_dvma);
-	sbus_free_consistent(qp->qe_sdev,
+	sbus_free_consistent(&qp->qe_sdev->ofdev.dev,
 			     sizeof(struct sunqe_buffers),
 			     qp->buffers,
 			     qp->buffers_dvma);
diff --git a/drivers/scsi/qlogicpti.c b/drivers/scsi/qlogicpti.c
index 4a1cf63..f010506 100644
--- a/drivers/scsi/qlogicpti.c
+++ b/drivers/scsi/qlogicpti.c
@@ -788,7 +788,7 @@ static int __devinit qpti_map_queues(struct qlogicpti *qpti)
 	struct sbus_dev *sdev = qpti->sdev;
 
 #define QSIZE(entries)	(((entries) + 1) * QUEUE_ENTRY_LEN)
-	qpti->res_cpu = sbus_alloc_consistent(sdev,
+	qpti->res_cpu = sbus_alloc_consistent(&sdev->ofdev.dev,
 					      QSIZE(RES_QUEUE_LEN),
 					      &qpti->res_dvma);
 	if (qpti->res_cpu = NULL ||
@@ -797,12 +797,12 @@ static int __devinit qpti_map_queues(struct qlogicpti *qpti)
 		return -1;
 	}
 
-	qpti->req_cpu = sbus_alloc_consistent(sdev,
+	qpti->req_cpu = sbus_alloc_consistent(&sdev->ofdev.dev,
 					      QSIZE(QLOGICPTI_REQ_QUEUE_LEN),
 					      &qpti->req_dvma);
 	if (qpti->req_cpu = NULL ||
 	    qpti->req_dvma = 0) {
-		sbus_free_consistent(sdev, QSIZE(RES_QUEUE_LEN),
+		sbus_free_consistent(&sdev->ofdev.dev, QSIZE(RES_QUEUE_LEN),
 				     qpti->res_cpu, qpti->res_dvma);
 		printk("QPTI: Cannot map request queue.\n");
 		return -1;
@@ -875,8 +875,9 @@ static inline int load_cmd(struct scsi_cmnd *Cmnd, struct Command_Entry *cmd,
 		int sg_count;
 
 		sg = scsi_sglist(Cmnd);
-		sg_count = sbus_map_sg(qpti->sdev, sg, scsi_sg_count(Cmnd),
-		                                      Cmnd->sc_data_direction);
+		sg_count = sbus_map_sg(&qpti->sdev->ofdev.dev, sg,
+				       scsi_sg_count(Cmnd),
+				       Cmnd->sc_data_direction);
 
 		ds = cmd->dataseg;
 		cmd->segment_cnt = sg_count;
@@ -1151,7 +1152,7 @@ static struct scsi_cmnd *qlogicpti_intr_handler(struct qlogicpti *qpti)
 			Cmnd->result = DID_ERROR << 16;
 
 		if (scsi_bufflen(Cmnd))
-			sbus_unmap_sg(qpti->sdev,
+			sbus_unmap_sg(&qpti->sdev->ofdev.dev,
 				      scsi_sglist(Cmnd), scsi_sg_count(Cmnd),
 				      Cmnd->sc_data_direction);
 
@@ -1356,10 +1357,10 @@ static int __devinit qpti_sbus_probe(struct of_device *dev, const struct of_devi
 
 fail_unmap_queues:
 #define QSIZE(entries)	(((entries) + 1) * QUEUE_ENTRY_LEN)
-	sbus_free_consistent(qpti->sdev,
+	sbus_free_consistent(&qpti->sdev->ofdev.dev,
 			     QSIZE(RES_QUEUE_LEN),
 			     qpti->res_cpu, qpti->res_dvma);
-	sbus_free_consistent(qpti->sdev,
+	sbus_free_consistent(&qpti->sdev->ofdev.dev,
 			     QSIZE(QLOGICPTI_REQ_QUEUE_LEN),
 			     qpti->req_cpu, qpti->req_dvma);
 #undef QSIZE
@@ -1394,10 +1395,10 @@ static int __devexit qpti_sbus_remove(struct of_device *dev)
 	free_irq(qpti->irq, qpti);
 
 #define QSIZE(entries)	(((entries) + 1) * QUEUE_ENTRY_LEN)
-	sbus_free_consistent(qpti->sdev,
+	sbus_free_consistent(&qpti->sdev->ofdev.dev,
 			     QSIZE(RES_QUEUE_LEN),
 			     qpti->res_cpu, qpti->res_dvma);
-	sbus_free_consistent(qpti->sdev,
+	sbus_free_consistent(&qpti->sdev->ofdev.dev,
 			     QSIZE(QLOGICPTI_REQ_QUEUE_LEN),
 			     qpti->req_cpu, qpti->req_dvma);
 #undef QSIZE
diff --git a/drivers/scsi/sun_esp.c b/drivers/scsi/sun_esp.c
index d110b94..35b6e2c 100644
--- a/drivers/scsi/sun_esp.c
+++ b/drivers/scsi/sun_esp.c
@@ -101,7 +101,7 @@ static int __devinit esp_sbus_map_command_block(struct esp *esp)
 {
 	struct sbus_dev *sdev = esp->dev;
 
-	esp->command_block = sbus_alloc_consistent(sdev, 16,
+	esp->command_block = sbus_alloc_consistent(&sdev->ofdev.dev, 16,
 						   &esp->command_block_dma);
 	if (!esp->command_block)
 		return -ENOMEM;
@@ -223,25 +223,33 @@ static u8 sbus_esp_read8(struct esp *esp, unsigned long reg)
 static dma_addr_t sbus_esp_map_single(struct esp *esp, void *buf,
 				      size_t sz, int dir)
 {
-	return sbus_map_single(esp->dev, buf, sz, dir);
+	struct sbus_dev *sdev = esp->dev;
+
+	return sbus_map_single(&sdev->ofdev.dev, buf, sz, dir);
 }
 
 static int sbus_esp_map_sg(struct esp *esp, struct scatterlist *sg,
 				  int num_sg, int dir)
 {
-	return sbus_map_sg(esp->dev, sg, num_sg, dir);
+	struct sbus_dev *sdev = esp->dev;
+
+	return sbus_map_sg(&sdev->ofdev.dev, sg, num_sg, dir);
 }
 
 static void sbus_esp_unmap_single(struct esp *esp, dma_addr_t addr,
 				  size_t sz, int dir)
 {
-	sbus_unmap_single(esp->dev, addr, sz, dir);
+	struct sbus_dev *sdev = esp->dev;
+
+	sbus_unmap_single(&sdev->ofdev.dev, addr, sz, dir);
 }
 
 static void sbus_esp_unmap_sg(struct esp *esp, struct scatterlist *sg,
 			      int num_sg, int dir)
 {
-	sbus_unmap_sg(esp->dev, sg, num_sg, dir);
+	struct sbus_dev *sdev = esp->dev;
+
+	sbus_unmap_sg(&sdev->ofdev.dev, sg, num_sg, dir);
 }
 
 static int sbus_esp_irq_pending(struct esp *esp)
@@ -550,7 +558,7 @@ static int __devinit esp_sbus_probe_one(struct device *dev,
 fail_free_irq:
 	free_irq(host->irq, esp);
 fail_unmap_command_block:
-	sbus_free_consistent(esp->dev, 16,
+	sbus_free_consistent(&esp_dev->ofdev.dev, 16,
 			     esp->command_block,
 			     esp->command_block_dma);
 fail_unmap_regs:
@@ -589,6 +597,7 @@ static int __devinit esp_sbus_probe(struct of_device *dev, const struct of_devic
 static int __devexit esp_sbus_remove(struct of_device *dev)
 {
 	struct esp *esp = dev_get_drvdata(&dev->dev);
+	struct sbus_dev *sdev = esp->dev;
 	struct of_device *dma_of = esp->dma;
 	unsigned int irq = esp->host->irq;
 	u32 val;
@@ -600,7 +609,7 @@ static int __devexit esp_sbus_remove(struct of_device *dev)
 	dma_write32(val & ~DMA_INT_ENAB, DMA_CSR);
 
 	free_irq(irq, esp);
-	sbus_free_consistent(esp->dev, 16,
+	sbus_free_consistent(&sdev->ofdev.dev, 16,
 			     esp->command_block,
 			     esp->command_block_dma);
 	sbus_iounmap(esp->regs, SBUS_ESP_REG_SIZE);
diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
index f5d6d8d..cc80397 100644
--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -192,7 +192,8 @@ static void *snd_malloc_sbus_pages(struct device *dev, size_t size,
 	snd_assert(size > 0, return NULL);
 	snd_assert(dma_addr != NULL, return NULL);
 	pg = get_order(size);
-	res = sbus_alloc_consistent(sdev, PAGE_SIZE * (1 << pg), dma_addr);
+	res = sbus_alloc_consistent(&sdev->ofdev.dev, PAGE_SIZE * (1 << pg),
+				    dma_addr);
 	if (res != NULL)
 		inc_snd_pages(pg);
 	return res;
@@ -208,7 +209,8 @@ static void snd_free_sbus_pages(struct device *dev, size_t size,
 		return;
 	pg = get_order(size);
 	dec_snd_pages(pg);
-	sbus_free_consistent(sdev, PAGE_SIZE * (1 << pg), ptr, dma_addr);
+	sbus_free_consistent(&sdev->ofdev.dev, PAGE_SIZE * (1 << pg),
+			     ptr, dma_addr);
 }
 
 #endif /* CONFIG_SBUS */
diff --git a/sound/sparc/dbri.c b/sound/sparc/dbri.c
index ee2e1b4..a6b32ec 100644
--- a/sound/sparc/dbri.c
+++ b/sound/sparc/dbri.c
@@ -2097,7 +2097,8 @@ static int snd_dbri_hw_params(struct snd_pcm_substream *substream,
 		else
 			direction = SBUS_DMA_FROMDEVICE;
 
-		info->dvma_buffer = sbus_map_single(dbri->sdev,
+		info->dvma_buffer +			sbus_map_single(&dbri->sdev->ofdev.dev,
 					runtime->dma_area,
 					params_buffer_bytes(hw_params),
 					direction);
@@ -2125,7 +2126,7 @@ static int snd_dbri_hw_free(struct snd_pcm_substream *substream)
 		else
 			direction = SBUS_DMA_FROMDEVICE;
 
-		sbus_unmap_single(dbri->sdev, info->dvma_buffer,
+		sbus_unmap_single(&dbri->sdev->ofdev.dev, info->dvma_buffer,
 				  substream->runtime->buffer_size, direction);
 		info->dvma_buffer = 0;
 	}
@@ -2524,7 +2525,8 @@ static int __devinit snd_dbri_create(struct snd_card *card,
 	dbri->sdev = sdev;
 	dbri->irq = irq;
 
-	dbri->dma = sbus_alloc_consistent(sdev, sizeof(struct dbri_dma),
+	dbri->dma = sbus_alloc_consistent(&sdev->ofdev.dev,
+					  sizeof(struct dbri_dma),
 					  &dbri->dma_dvma);
 	memset((void *)dbri->dma, 0, sizeof(struct dbri_dma));
 
@@ -2537,7 +2539,7 @@ static int __devinit snd_dbri_create(struct snd_card *card,
 				  dbri->regs_size, "DBRI Registers");
 	if (!dbri->regs) {
 		printk(KERN_ERR "DBRI: could not allocate registers\n");
-		sbus_free_consistent(sdev, sizeof(struct dbri_dma),
+		sbus_free_consistent(&sdev->ofdev.dev, sizeof(struct dbri_dma),
 				     (void *)dbri->dma, dbri->dma_dvma);
 		return -EIO;
 	}
@@ -2547,7 +2549,7 @@ static int __devinit snd_dbri_create(struct snd_card *card,
 	if (err) {
 		printk(KERN_ERR "DBRI: Can't get irq %d\n", dbri->irq);
 		sbus_iounmap(dbri->regs, dbri->regs_size);
-		sbus_free_consistent(sdev, sizeof(struct dbri_dma),
+		sbus_free_consistent(&sdev->ofdev.dev, sizeof(struct dbri_dma),
 				     (void *)dbri->dma, dbri->dma_dvma);
 		return err;
 	}
@@ -2575,7 +2577,8 @@ static void snd_dbri_free(struct snd_dbri *dbri)
 		sbus_iounmap(dbri->regs, dbri->regs_size);
 
 	if (dbri->dma)
-		sbus_free_consistent(dbri->sdev, sizeof(struct dbri_dma),
+		sbus_free_consistent(&dbri->sdev->ofdev.dev,
+				     sizeof(struct dbri_dma),
 				     (void *)dbri->dma, dbri->dma_dvma);
 }
 
-- 
1.5.6.5.GIT

