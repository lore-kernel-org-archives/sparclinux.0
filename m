From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:23:40 +0000
Subject: [PATCH 9/49]: sparc: Convert all SBUS drivers to dma_*()
Message-Id: <20080827.212340.100221947.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc: Convert all SBUS drivers to dma_*() interfaces.

And all the SBUS dma interfaces are deleted.

A private implementation remains inside of the 32-bit sparc port which
exists only for the sake of the implementation of dma_*().

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/sbus_32.h    |   17 -------
 arch/sparc/include/asm/sbus_64.h    |   63 --------------------------
 arch/sparc/kernel/sparc_ksyms.c     |    8 ---
 arch/sparc64/kernel/sparc64_ksyms.c |    8 ---
 drivers/atm/fore200e.c              |   16 +++---
 drivers/net/myri_sbus.c             |   63 +++++++++++++-------------
 drivers/net/sunbmac.c               |   68 ++++++++++++++-------------
 drivers/net/sunhme.c                |   85 ++++++++++++++---------------------
 drivers/net/sunlance.c              |   15 +++---
 drivers/net/sunqe.c                 |   45 +++++++++---------
 drivers/scsi/qlogicpti.c            |   53 +++++++++++-----------
 drivers/scsi/sun_esp.c              |   26 ++++++-----
 sound/core/memalloc.c               |    8 ++--
 sound/sparc/dbri.c                  |   41 +++++++++--------
 14 files changed, 206 insertions(+), 310 deletions(-)

diff --git a/arch/sparc/include/asm/sbus_32.h b/arch/sparc/include/asm/sbus_32.h
index 61d99f1..b09284b 100644
--- a/arch/sparc/include/asm/sbus_32.h
+++ b/arch/sparc/include/asm/sbus_32.h
@@ -109,26 +109,9 @@ extern void sbus_set_sbus64(struct sbus_dev *, int);
 extern void sbus_fill_device_irq(struct sbus_dev *);
 
 /* These yield IOMMU mappings in consistent mode. */
-extern void *sbus_alloc_consistent(struct device *, long, u32 *dma_addrp);
-extern void sbus_free_consistent(struct device *, long, void *, u32);
 void prom_adjust_ranges(struct linux_prom_ranges *, int,
 			struct linux_prom_ranges *, int);
 
-#define SBUS_DMA_BIDIRECTIONAL	DMA_BIDIRECTIONAL
-#define SBUS_DMA_TODEVICE	DMA_TO_DEVICE
-#define SBUS_DMA_FROMDEVICE	DMA_FROM_DEVICE
-#define	SBUS_DMA_NONE		DMA_NONE
-
-/* All the rest use streaming mode mappings. */
-extern dma_addr_t sbus_map_single(struct device *, void *, size_t, int);
-extern void sbus_unmap_single(struct device *, dma_addr_t, size_t, int);
-extern int sbus_map_sg(struct device *, struct scatterlist *, int, int);
-extern void sbus_unmap_sg(struct device *, struct scatterlist *, int, int);
-
-/* Finally, allow explicit synchronization of streamable mappings. */
-extern void sbus_dma_sync_single_for_cpu(struct device *, dma_addr_t, size_t, int);
-extern void sbus_dma_sync_single_for_device(struct device *, dma_addr_t, size_t, int);
-
 /* Eric Brower (ebrower@usa.net)
  * Translate SBus interrupt levels to ino values--
  * this is used when converting sbus "interrupts" OBP
diff --git a/arch/sparc/include/asm/sbus_64.h b/arch/sparc/include/asm/sbus_64.h
index b22e99d..9a2f271 100644
--- a/arch/sparc/include/asm/sbus_64.h
+++ b/arch/sparc/include/asm/sbus_64.h
@@ -100,69 +100,6 @@ extern struct sbus_bus *sbus_root;
 extern void sbus_set_sbus64(struct sbus_dev *, int);
 extern void sbus_fill_device_irq(struct sbus_dev *);
 
-static inline void *sbus_alloc_consistent(struct device *dev , size_t size,
-					  dma_addr_t *dma_handle)
-{
-	return dma_alloc_coherent(dev, size, dma_handle, GFP_ATOMIC);
-}
-
-static inline void sbus_free_consistent(struct device *dev, size_t size,
-					void *vaddr, dma_addr_t dma_handle)
-{
-	return dma_free_coherent(dev, size, vaddr, dma_handle);
-}
-
-#define SBUS_DMA_BIDIRECTIONAL	DMA_BIDIRECTIONAL
-#define SBUS_DMA_TODEVICE	DMA_TO_DEVICE
-#define SBUS_DMA_FROMDEVICE	DMA_FROM_DEVICE
-#define	SBUS_DMA_NONE		DMA_NONE
-
-/* All the rest use streaming mode mappings. */
-static inline dma_addr_t sbus_map_single(struct device *dev, void *ptr,
-					 size_t size, int direction)
-{
-	return dma_map_single(dev, ptr, size,
-			      (enum dma_data_direction) direction);
-}
-
-static inline void sbus_unmap_single(struct device *dev,
-				     dma_addr_t dma_addr, size_t size,
-				     int direction)
-{
-	dma_unmap_single(dev, dma_addr, size,
-			 (enum dma_data_direction) direction);
-}
-
-static inline int sbus_map_sg(struct device *dev, struct scatterlist *sg,
-			      int nents, int direction)
-{
-	return dma_map_sg(dev, sg, nents,
-			  (enum dma_data_direction) direction);
-}
-
-static inline void sbus_unmap_sg(struct device *dev, struct scatterlist *sg,
-				 int nents, int direction)
-{
-	dma_unmap_sg(dev, sg, nents,
-		     (enum dma_data_direction) direction);
-}
-
-/* Finally, allow explicit synchronization of streamable mappings. */
-static inline void sbus_dma_sync_single_for_cpu(struct device *dev,
-						dma_addr_t dma_handle,
-						size_t size, int direction)
-{
-	dma_sync_single_for_cpu(dev, dma_handle, size,
-				(enum dma_data_direction) direction);
-}
-
-static inline void sbus_dma_sync_single_for_device(struct device *dev,
-						   dma_addr_t dma_handle,
-						   size_t size, int direction)
-{
-	/* No flushing needed to sync cpu writes to the device.  */
-}
-
 extern void sbus_arch_bus_ranges_init(struct device_node *, struct sbus_bus *);
 extern void sbus_setup_iommu(struct sbus_bus *, struct device_node *);
 extern void sbus_setup_arch_props(struct sbus_bus *, struct device_node *);
diff --git a/arch/sparc/kernel/sparc_ksyms.c b/arch/sparc/kernel/sparc_ksyms.c
index 9d85a83..b1d2c97 100644
--- a/arch/sparc/kernel/sparc_ksyms.c
+++ b/arch/sparc/kernel/sparc_ksyms.c
@@ -155,14 +155,6 @@ EXPORT_SYMBOL(BTFIXUP_CALL(pgprot_noncached));
 #ifdef CONFIG_SBUS
 EXPORT_SYMBOL(sbus_root);
 EXPORT_SYMBOL(sbus_set_sbus64);
-EXPORT_SYMBOL(sbus_alloc_consistent);
-EXPORT_SYMBOL(sbus_free_consistent);
-EXPORT_SYMBOL(sbus_map_single);
-EXPORT_SYMBOL(sbus_unmap_single);
-EXPORT_SYMBOL(sbus_map_sg);
-EXPORT_SYMBOL(sbus_unmap_sg);
-EXPORT_SYMBOL(sbus_dma_sync_single_for_cpu);
-EXPORT_SYMBOL(sbus_dma_sync_single_for_device);
 EXPORT_SYMBOL(sbus_iounmap);
 EXPORT_SYMBOL(sbus_ioremap);
 #endif
diff --git a/arch/sparc64/kernel/sparc64_ksyms.c b/arch/sparc64/kernel/sparc64_ksyms.c
index 1c56c8b..901c264 100644
--- a/arch/sparc64/kernel/sparc64_ksyms.c
+++ b/arch/sparc64/kernel/sparc64_ksyms.c
@@ -162,14 +162,6 @@ EXPORT_SYMBOL(auxio_set_lte);
 #ifdef CONFIG_SBUS
 EXPORT_SYMBOL(sbus_root);
 EXPORT_SYMBOL(sbus_set_sbus64);
-EXPORT_SYMBOL(sbus_alloc_consistent);
-EXPORT_SYMBOL(sbus_free_consistent);
-EXPORT_SYMBOL(sbus_map_single);
-EXPORT_SYMBOL(sbus_unmap_single);
-EXPORT_SYMBOL(sbus_map_sg);
-EXPORT_SYMBOL(sbus_unmap_sg);
-EXPORT_SYMBOL(sbus_dma_sync_single_for_cpu);
-EXPORT_SYMBOL(sbus_dma_sync_single_for_device);
 #endif
 EXPORT_SYMBOL(outsb);
 EXPORT_SYMBOL(outsw);
diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
index c5ab44f..f607e59 100644
--- a/drivers/atm/fore200e.c
+++ b/drivers/atm/fore200e.c
@@ -680,7 +680,7 @@ fore200e_sba_dma_map(struct fore200e* fore200e, void* virt_addr, int size, int d
 {
     struct sbus_dev *sdev = fore200e->bus_dev;
     struct device *dev = &sdev->ofdev.dev;
-    u32 dma_addr = sbus_map_single(dev, virt_addr, size, direction);
+    u32 dma_addr = dma_map_single(dev, virt_addr, size, direction);
 
     DPRINTK(3, "SBUS DVMA mapping: virt_addr = 0x%p, size = %d, direction = %d --> dma_addr = 0x%08x\n",
 	    virt_addr, size, direction, dma_addr);
@@ -698,7 +698,7 @@ fore200e_sba_dma_unmap(struct fore200e* fore200e, u32 dma_addr, int size, int di
     DPRINTK(3, "SBUS DVMA unmapping: dma_addr = 0x%08x, size = %d, direction = %d,\n",
 	    dma_addr, size, direction);
 
-    sbus_unmap_single(dev, dma_addr, size, direction);
+    dma_unmap_single(dev, dma_addr, size, direction);
 }
 
 
@@ -710,7 +710,7 @@ fore200e_sba_dma_sync_for_cpu(struct fore200e* fore200e, u32 dma_addr, int size,
 
     DPRINTK(3, "SBUS DVMA sync: dma_addr = 0x%08x, size = %d, direction = %d\n", dma_addr, size, direction);
     
-    sbus_dma_sync_single_for_cpu(dev, dma_addr, size, direction);
+    dma_sync_single_for_cpu(dev, dma_addr, size, direction);
 }
 
 static void
@@ -721,7 +721,7 @@ fore200e_sba_dma_sync_for_device(struct fore200e* fore200e, u32 dma_addr, int si
 
     DPRINTK(3, "SBUS DVMA sync: dma_addr = 0x%08x, size = %d, direction = %d\n", dma_addr, size, direction);
 
-    sbus_dma_sync_single_for_device(dev, dma_addr, size, direction);
+    dma_sync_single_for_device(dev, dma_addr, size, direction);
 }
 
 
@@ -738,8 +738,8 @@ fore200e_sba_dma_chunk_alloc(struct fore200e* fore200e, struct chunk* chunk,
     chunk->alloc_size = chunk->align_size = size * nbr;
 
     /* returned chunks are page-aligned */
-    chunk->alloc_addr = sbus_alloc_consistent(dev, chunk->alloc_size,
-					      &chunk->dma_addr);
+    chunk->alloc_addr = dma_alloc_coherent(dev, chunk->alloc_size,
+					   &chunk->dma_addr, GFP_ATOMIC);
 
     if ((chunk->alloc_addr = NULL) || (chunk->dma_addr = 0))
 	return -ENOMEM;
@@ -758,8 +758,8 @@ fore200e_sba_dma_chunk_free(struct fore200e* fore200e, struct chunk* chunk)
     struct sbus_dev *sdev = (struct sbus_dev *) fore200e->bus_dev;
     struct device *dev = &sdev->ofdev.dev;
 
-    sbus_free_consistent(dev, chunk->alloc_size,
-			 chunk->alloc_addr, chunk->dma_addr);
+    dma_free_coherent(dev, chunk->alloc_size,
+		      chunk->alloc_addr, chunk->dma_addr);
 }
 
 
diff --git a/drivers/net/myri_sbus.c b/drivers/net/myri_sbus.c
index c174621..858880b 100644
--- a/drivers/net/myri_sbus.c
+++ b/drivers/net/myri_sbus.c
@@ -22,6 +22,7 @@ static char version[]  #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 #include <linux/bitops.h>
+#include <linux/dma-mapping.h>
 
 #include <net/dst.h>
 #include <net/arp.h>
@@ -243,8 +244,8 @@ static void myri_clean_rings(struct myri_eth *mp)
 			u32 dma_addr;
 
 			dma_addr = sbus_readl(&rxd->myri_scatters[0].addr);
-			sbus_unmap_single(&mp->myri_sdev->ofdev.dev, dma_addr,
-					  RX_ALLOC_SIZE, SBUS_DMA_FROMDEVICE);
+			dma_unmap_single(&mp->myri_sdev->ofdev.dev, dma_addr,
+					 RX_ALLOC_SIZE, DMA_FROM_DEVICE);
 			dev_kfree_skb(mp->rx_skbs[i]);
 			mp->rx_skbs[i] = NULL;
 		}
@@ -260,9 +261,9 @@ static void myri_clean_rings(struct myri_eth *mp)
 			u32 dma_addr;
 
 			dma_addr = sbus_readl(&txd->myri_gathers[0].addr);
-			sbus_unmap_single(&mp->myri_sdev->ofdev.dev, dma_addr,
-					  (skb->len + 3) & ~3,
-					  SBUS_DMA_TODEVICE);
+			dma_unmap_single(&mp->myri_sdev->ofdev.dev, dma_addr,
+					 (skb->len + 3) & ~3,
+					 DMA_TO_DEVICE);
 			dev_kfree_skb(mp->tx_skbs[i]);
 			mp->tx_skbs[i] = NULL;
 		}
@@ -291,9 +292,9 @@ static void myri_init_rings(struct myri_eth *mp, int from_irq)
 		skb->dev = dev;
 		skb_put(skb, RX_ALLOC_SIZE);
 
-		dma_addr = sbus_map_single(&mp->myri_sdev->ofdev.dev,
-					   skb->data, RX_ALLOC_SIZE,
-					   SBUS_DMA_FROMDEVICE);
+		dma_addr = dma_map_single(&mp->myri_sdev->ofdev.dev,
+					  skb->data, RX_ALLOC_SIZE,
+					  DMA_FROM_DEVICE);
 		sbus_writel(dma_addr, &rxd[i].myri_scatters[0].addr);
 		sbus_writel(RX_ALLOC_SIZE, &rxd[i].myri_scatters[0].len);
 		sbus_writel(i, &rxd[i].ctx);
@@ -349,8 +350,8 @@ static void myri_tx(struct myri_eth *mp, struct net_device *dev)
 
 		DTX(("SKB[%d] ", entry));
 		dma_addr = sbus_readl(&sq->myri_txd[entry].myri_gathers[0].addr);
-		sbus_unmap_single(&mp->myri_sdev->ofdev.dev, dma_addr,
-				  skb->len, SBUS_DMA_TODEVICE);
+		dma_unmap_single(&mp->myri_sdev->ofdev.dev, dma_addr,
+				 skb->len, DMA_TO_DEVICE);
 		dev_kfree_skb(skb);
 		mp->tx_skbs[entry] = NULL;
 		dev->stats.tx_packets++;
@@ -429,9 +430,9 @@ static void myri_rx(struct myri_eth *mp, struct net_device *dev)
 
 		/* Check for errors. */
 		DRX(("rxd[%d]: %p len[%d] csum[%08x] ", entry, rxd, len, csum));
-		sbus_dma_sync_single_for_cpu(&mp->myri_sdev->ofdev.dev,
-					     sbus_readl(&rxd->myri_scatters[0].addr),
-					     RX_ALLOC_SIZE, SBUS_DMA_FROMDEVICE);
+		dma_sync_single_for_cpu(&mp->myri_sdev->ofdev.dev,
+					sbus_readl(&rxd->myri_scatters[0].addr),
+					RX_ALLOC_SIZE, DMA_FROM_DEVICE);
 		if (len < (ETH_HLEN + MYRI_PAD_LEN) || (skb->data[0] != MYRI_PAD_LEN)) {
 			DRX(("ERROR["));
 			dev->stats.rx_errors++;
@@ -448,10 +449,10 @@ static void myri_rx(struct myri_eth *mp, struct net_device *dev)
 			drops++;
 			DRX(("DROP "));
 			dev->stats.rx_dropped++;
-			sbus_dma_sync_single_for_device(&mp->myri_sdev->ofdev.dev,
-							sbus_readl(&rxd->myri_scatters[0].addr),
-							RX_ALLOC_SIZE,
-							SBUS_DMA_FROMDEVICE);
+			dma_sync_single_for_device(&mp->myri_sdev->ofdev.dev,
+						   sbus_readl(&rxd->myri_scatters[0].addr),
+						   RX_ALLOC_SIZE,
+						   DMA_FROM_DEVICE);
 			sbus_writel(RX_ALLOC_SIZE, &rxd->myri_scatters[0].len);
 			sbus_writel(index, &rxd->ctx);
 			sbus_writel(1, &rxd->num_sg);
@@ -470,17 +471,17 @@ static void myri_rx(struct myri_eth *mp, struct net_device *dev)
 				DRX(("skb_alloc(FAILED) "));
 				goto drop_it;
 			}
-			sbus_unmap_single(&mp->myri_sdev->ofdev.dev,
-					  sbus_readl(&rxd->myri_scatters[0].addr),
-					  RX_ALLOC_SIZE,
-					  SBUS_DMA_FROMDEVICE);
+			dma_unmap_single(&mp->myri_sdev->ofdev.dev,
+					 sbus_readl(&rxd->myri_scatters[0].addr),
+					 RX_ALLOC_SIZE,
+					 DMA_FROM_DEVICE);
 			mp->rx_skbs[index] = new_skb;
 			new_skb->dev = dev;
 			skb_put(new_skb, RX_ALLOC_SIZE);
-			dma_addr = sbus_map_single(&mp->myri_sdev->ofdev.dev,
-						   new_skb->data,
-						   RX_ALLOC_SIZE,
-						   SBUS_DMA_FROMDEVICE);
+			dma_addr = dma_map_single(&mp->myri_sdev->ofdev.dev,
+						  new_skb->data,
+						  RX_ALLOC_SIZE,
+						  DMA_FROM_DEVICE);
 			sbus_writel(dma_addr, &rxd->myri_scatters[0].addr);
 			sbus_writel(RX_ALLOC_SIZE, &rxd->myri_scatters[0].len);
 			sbus_writel(index, &rxd->ctx);
@@ -506,10 +507,10 @@ static void myri_rx(struct myri_eth *mp, struct net_device *dev)
 
 			/* Reuse original ring buffer. */
 			DRX(("reuse "));
-			sbus_dma_sync_single_for_device(&mp->myri_sdev->ofdev.dev,
-							sbus_readl(&rxd->myri_scatters[0].addr),
-							RX_ALLOC_SIZE,
-							SBUS_DMA_FROMDEVICE);
+			dma_sync_single_for_device(&mp->myri_sdev->ofdev.dev,
+						   sbus_readl(&rxd->myri_scatters[0].addr),
+						   RX_ALLOC_SIZE,
+						   DMA_FROM_DEVICE);
 			sbus_writel(RX_ALLOC_SIZE, &rxd->myri_scatters[0].len);
 			sbus_writel(index, &rxd->ctx);
 			sbus_writel(1, &rxd->num_sg);
@@ -658,8 +659,8 @@ static int myri_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		sbus_writew((skb->data[4] << 8) | skb->data[5], &txd->addr[3]);
 	}
 
-	dma_addr = sbus_map_single(&mp->myri_sdev->ofdev.dev, skb->data,
-				   len, SBUS_DMA_TODEVICE);
+	dma_addr = dma_map_single(&mp->myri_sdev->ofdev.dev, skb->data,
+				  len, DMA_TO_DEVICE);
 	sbus_writel(dma_addr, &txd->myri_gathers[0].addr);
 	sbus_writel(len, &txd->myri_gathers[0].len);
 	sbus_writel(1, &txd->num_sg);
diff --git a/drivers/net/sunbmac.c b/drivers/net/sunbmac.c
index b92218c..8fe4c49 100644
--- a/drivers/net/sunbmac.c
+++ b/drivers/net/sunbmac.c
@@ -23,6 +23,7 @@
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 #include <linux/bitops.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/auxio.h>
 #include <asm/byteorder.h>
@@ -239,9 +240,10 @@ static void bigmac_init_rings(struct bigmac *bp, int from_irq)
 		skb_reserve(skb, 34);
 
 		bb->be_rxd[i].rx_addr -			sbus_map_single(&bp->bigmac_sdev->ofdev.dev, skb->data,
-					RX_BUF_ALLOC_SIZE - 34,
-					SBUS_DMA_FROMDEVICE);
+			dma_map_single(&bp->bigmac_sdev->ofdev.dev,
+				       skb->data,
+				       RX_BUF_ALLOC_SIZE - 34,
+				       DMA_FROM_DEVICE);
 		bb->be_rxd[i].rx_flags  			(RXD_OWN | ((RX_BUF_ALLOC_SIZE - 34) & RXD_LENGTH));
 	}
@@ -776,9 +778,9 @@ static void bigmac_tx(struct bigmac *bp)
 		skb = bp->tx_skbs[elem];
 		bp->enet_stats.tx_packets++;
 		bp->enet_stats.tx_bytes += skb->len;
-		sbus_unmap_single(&bp->bigmac_sdev->ofdev.dev,
-				  this->tx_addr, skb->len,
-				  SBUS_DMA_TODEVICE);
+		dma_unmap_single(&bp->bigmac_sdev->ofdev.dev,
+				 this->tx_addr, skb->len,
+				 DMA_TO_DEVICE);
 
 		DTX(("skb(%p) ", skb));
 		bp->tx_skbs[elem] = NULL;
@@ -831,19 +833,19 @@ static void bigmac_rx(struct bigmac *bp)
 				drops++;
 				goto drop_it;
 			}
-			sbus_unmap_single(&bp->bigmac_sdev->ofdev.dev,
-					  this->rx_addr,
-					  RX_BUF_ALLOC_SIZE - 34,
-					  SBUS_DMA_FROMDEVICE);
+			dma_unmap_single(&bp->bigmac_sdev->ofdev.dev,
+					 this->rx_addr,
+					 RX_BUF_ALLOC_SIZE - 34,
+					 DMA_FROM_DEVICE);
 			bp->rx_skbs[elem] = new_skb;
 			new_skb->dev = bp->dev;
 			skb_put(new_skb, ETH_FRAME_LEN);
 			skb_reserve(new_skb, 34);
 			this->rx_addr -				sbus_map_single(&bp->bigmac_sdev->ofdev.dev,
-						new_skb->data,
-						RX_BUF_ALLOC_SIZE - 34,
-						SBUS_DMA_FROMDEVICE);
+				dma_map_single(&bp->bigmac_sdev->ofdev.dev,
+					       new_skb->data,
+					       RX_BUF_ALLOC_SIZE - 34,
+					       DMA_FROM_DEVICE);
 			this->rx_flags  				(RXD_OWN | ((RX_BUF_ALLOC_SIZE - 34) & RXD_LENGTH));
 
@@ -858,13 +860,13 @@ static void bigmac_rx(struct bigmac *bp)
 			}
 			skb_reserve(copy_skb, 2);
 			skb_put(copy_skb, len);
-			sbus_dma_sync_single_for_cpu(&bp->bigmac_sdev->ofdev.dev,
-						     this->rx_addr, len,
-						     SBUS_DMA_FROMDEVICE);
+			dma_sync_single_for_cpu(&bp->bigmac_sdev->ofdev.dev,
+						this->rx_addr, len,
+						DMA_FROM_DEVICE);
 			skb_copy_to_linear_data(copy_skb, (unsigned char *)skb->data, len);
-			sbus_dma_sync_single_for_device(&bp->bigmac_sdev->ofdev.dev,
-							this->rx_addr, len,
-							SBUS_DMA_FROMDEVICE);
+			dma_sync_single_for_device(&bp->bigmac_sdev->ofdev.dev,
+						   this->rx_addr, len,
+						   DMA_FROM_DEVICE);
 
 			/* Reuse original ring buffer. */
 			this->rx_flags @@ -960,8 +962,8 @@ static int bigmac_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	u32 mapping;
 
 	len = skb->len;
-	mapping = sbus_map_single(&bp->bigmac_sdev->ofdev.dev, skb->data,
-				  len, SBUS_DMA_TODEVICE);
+	mapping = dma_map_single(&bp->bigmac_sdev->ofdev.dev, skb->data,
+				 len, DMA_TO_DEVICE);
 
 	/* Avoid a race... */
 	spin_lock_irq(&bp->lock);
@@ -1185,9 +1187,9 @@ static int __devinit bigmac_ether_init(struct sbus_dev *qec_sdev)
 	bigmac_stop(bp);
 
 	/* Allocate transmit/receive descriptor DVMA block. */
-	bp->bmac_block = sbus_alloc_consistent(&bp->bigmac_sdev->ofdev.dev,
-					       PAGE_SIZE,
-					       &bp->bblock_dvma);
+	bp->bmac_block = dma_alloc_coherent(&bp->bigmac_sdev->ofdev.dev,
+					    PAGE_SIZE,
+					    &bp->bblock_dvma, GFP_ATOMIC);
 	if (bp->bmac_block = NULL || bp->bblock_dvma = 0) {
 		printk(KERN_ERR "BIGMAC: Cannot allocate consistent DMA.\n");
 		goto fail_and_cleanup;
@@ -1247,10 +1249,10 @@ fail_and_cleanup:
 		sbus_iounmap(bp->tregs, TCVR_REG_SIZE);
 
 	if (bp->bmac_block)
-		sbus_free_consistent(&bp->bigmac_sdev->ofdev.dev,
-				     PAGE_SIZE,
-				     bp->bmac_block,
-				     bp->bblock_dvma);
+		dma_free_coherent(&bp->bigmac_sdev->ofdev.dev,
+				  PAGE_SIZE,
+				  bp->bmac_block,
+				  bp->bblock_dvma);
 
 	/* This also frees the co-located 'dev->priv' */
 	free_netdev(dev);
@@ -1282,10 +1284,10 @@ static int __devexit bigmac_sbus_remove(struct of_device *dev)
 	sbus_iounmap(bp->creg, CREG_REG_SIZE);
 	sbus_iounmap(bp->bregs, BMAC_REG_SIZE);
 	sbus_iounmap(bp->tregs, TCVR_REG_SIZE);
-	sbus_free_consistent(&bp->bigmac_sdev->ofdev.dev,
-			     PAGE_SIZE,
-			     bp->bmac_block,
-			     bp->bblock_dvma);
+	dma_free_coherent(&bp->bigmac_sdev->ofdev.dev,
+			  PAGE_SIZE,
+			  bp->bmac_block,
+			  bp->bblock_dvma);
 
 	free_netdev(net_dev);
 
diff --git a/drivers/net/sunhme.c b/drivers/net/sunhme.c
index cd93fc5..69cc771 100644
--- a/drivers/net/sunhme.c
+++ b/drivers/net/sunhme.c
@@ -34,6 +34,7 @@
 #include <linux/skbuff.h>
 #include <linux/mm.h>
 #include <linux/bitops.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
@@ -277,13 +278,13 @@ do {	(__txd)->tx_addr = (__force hme32)(u32)(__addr); \
 } while(0)
 #define hme_read_desc32(__hp, __p)	((__force u32)(hme32)*(__p))
 #define hme_dma_map(__hp, __ptr, __size, __dir) \
-	sbus_map_single((__hp)->dma_dev, (__ptr), (__size), (__dir))
+	dma_map_single((__hp)->dma_dev, (__ptr), (__size), (__dir))
 #define hme_dma_unmap(__hp, __addr, __size, __dir) \
-	sbus_unmap_single((__hp)->dma_dev, (__addr), (__size), (__dir))
+	dma_unmap_single((__hp)->dma_dev, (__addr), (__size), (__dir))
 #define hme_dma_sync_for_cpu(__hp, __addr, __size, __dir) \
-	sbus_dma_sync_single_for_cpu((__hp)->dma_dev, (__addr), (__size), (__dir))
+	dma_dma_sync_single_for_cpu((__hp)->dma_dev, (__addr), (__size), (__dir))
 #define hme_dma_sync_for_device(__hp, __addr, __size, __dir) \
-	sbus_dma_sync_single_for_device((__hp)->dma_dev, (__addr), (__size), (__dir))
+	dma_dma_sync_single_for_device((__hp)->dma_dev, (__addr), (__size), (__dir))
 #else
 /* PCI only compilation */
 #define hme_write32(__hp, __reg, __val) \
@@ -316,25 +317,6 @@ static inline u32 hme_read_desc32(struct happy_meal *hp, hme32 *p)
 #endif
 
 
-#ifdef SBUS_DMA_BIDIRECTIONAL
-#	define DMA_BIDIRECTIONAL	SBUS_DMA_BIDIRECTIONAL
-#else
-#	define DMA_BIDIRECTIONAL	0
-#endif
-
-#ifdef SBUS_DMA_FROMDEVICE
-#	define DMA_FROMDEVICE		SBUS_DMA_FROMDEVICE
-#else
-#	define DMA_TODEVICE		1
-#endif
-
-#ifdef SBUS_DMA_TODEVICE
-#	define DMA_TODEVICE		SBUS_DMA_TODEVICE
-#else
-#	define DMA_FROMDEVICE		2
-#endif
-
-
 /* Oh yes, the MIF BitBang is mighty fun to program.  BitBucket is more like it. */
 static void BB_PUT_BIT(struct happy_meal *hp, void __iomem *tregs, int bit)
 {
@@ -1224,7 +1206,7 @@ static void happy_meal_clean_rings(struct happy_meal *hp)
 
 			rxd = &hp->happy_block->happy_meal_rxd[i];
 			dma_addr = hme_read_desc32(hp, &rxd->rx_addr);
-			hme_dma_unmap(hp, dma_addr, RX_BUF_ALLOC_SIZE, DMA_FROMDEVICE);
+			hme_dma_unmap(hp, dma_addr, RX_BUF_ALLOC_SIZE, DMA_FROM_DEVICE);
 			dev_kfree_skb_any(skb);
 			hp->rx_skbs[i] = NULL;
 		}
@@ -1245,7 +1227,7 @@ static void happy_meal_clean_rings(struct happy_meal *hp)
 				hme_dma_unmap(hp, dma_addr,
 					      (hme_read_desc32(hp, &txd->tx_flags)
 					       & TXFLAG_SIZE),
-					      DMA_TODEVICE);
+					      DMA_TO_DEVICE);
 
 				if (frag != skb_shinfo(skb)->nr_frags)
 					i++;
@@ -1287,7 +1269,7 @@ static void happy_meal_init_rings(struct happy_meal *hp)
 		skb_put(skb, (ETH_FRAME_LEN + RX_OFFSET + 4));
 		hme_write_rxd(hp, &hb->happy_meal_rxd[i],
 			      (RXFLAG_OWN | ((RX_BUF_ALLOC_SIZE - RX_OFFSET) << 16)),
-			      hme_dma_map(hp, skb->data, RX_BUF_ALLOC_SIZE, DMA_FROMDEVICE));
+			      hme_dma_map(hp, skb->data, RX_BUF_ALLOC_SIZE, DMA_FROM_DEVICE));
 		skb_reserve(skb, RX_OFFSET);
 	}
 
@@ -1966,7 +1948,7 @@ static void happy_meal_tx(struct happy_meal *hp)
 			dma_len = hme_read_desc32(hp, &this->tx_flags);
 
 			dma_len &= TXFLAG_SIZE;
-			hme_dma_unmap(hp, dma_addr, dma_len, DMA_TODEVICE);
+			hme_dma_unmap(hp, dma_addr, dma_len, DMA_TO_DEVICE);
 
 			elem = NEXT_TX(elem);
 			this = &txbase[elem];
@@ -2044,13 +2026,13 @@ static void happy_meal_rx(struct happy_meal *hp, struct net_device *dev)
 				drops++;
 				goto drop_it;
 			}
-			hme_dma_unmap(hp, dma_addr, RX_BUF_ALLOC_SIZE, DMA_FROMDEVICE);
+			hme_dma_unmap(hp, dma_addr, RX_BUF_ALLOC_SIZE, DMA_FROM_DEVICE);
 			hp->rx_skbs[elem] = new_skb;
 			new_skb->dev = dev;
 			skb_put(new_skb, (ETH_FRAME_LEN + RX_OFFSET + 4));
 			hme_write_rxd(hp, this,
 				      (RXFLAG_OWN|((RX_BUF_ALLOC_SIZE-RX_OFFSET)<<16)),
-				      hme_dma_map(hp, new_skb->data, RX_BUF_ALLOC_SIZE, DMA_FROMDEVICE));
+				      hme_dma_map(hp, new_skb->data, RX_BUF_ALLOC_SIZE, DMA_FROM_DEVICE));
 			skb_reserve(new_skb, RX_OFFSET);
 
 			/* Trim the original skb for the netif. */
@@ -2065,9 +2047,9 @@ static void happy_meal_rx(struct happy_meal *hp, struct net_device *dev)
 
 			skb_reserve(copy_skb, 2);
 			skb_put(copy_skb, len);
-			hme_dma_sync_for_cpu(hp, dma_addr, len, DMA_FROMDEVICE);
+			hme_dma_sync_for_cpu(hp, dma_addr, len, DMA_FROM_DEVICE);
 			skb_copy_from_linear_data(skb, copy_skb->data, len);
-			hme_dma_sync_for_device(hp, dma_addr, len, DMA_FROMDEVICE);
+			hme_dma_sync_for_device(hp, dma_addr, len, DMA_FROM_DEVICE);
 
 			/* Reuse original ring buffer. */
 			hme_write_rxd(hp, this,
@@ -2300,7 +2282,7 @@ static int happy_meal_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		u32 mapping, len;
 
 		len = skb->len;
-		mapping = hme_dma_map(hp, skb->data, len, DMA_TODEVICE);
+		mapping = hme_dma_map(hp, skb->data, len, DMA_TO_DEVICE);
 		tx_flags |= (TXFLAG_SOP | TXFLAG_EOP);
 		hme_write_txd(hp, &hp->happy_block->happy_meal_txd[entry],
 			      (tx_flags | (len & TXFLAG_SIZE)),
@@ -2314,7 +2296,7 @@ static int happy_meal_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		 * Otherwise we could race with the device.
 		 */
 		first_len = skb_headlen(skb);
-		first_mapping = hme_dma_map(hp, skb->data, first_len, DMA_TODEVICE);
+		first_mapping = hme_dma_map(hp, skb->data, first_len, DMA_TO_DEVICE);
 		entry = NEXT_TX(entry);
 
 		for (frag = 0; frag < skb_shinfo(skb)->nr_frags; frag++) {
@@ -2325,7 +2307,7 @@ static int happy_meal_start_xmit(struct sk_buff *skb, struct net_device *dev)
 			mapping = hme_dma_map(hp,
 					      ((void *) page_address(this_frag->page) +
 					       this_frag->page_offset),
-					      len, DMA_TODEVICE);
+					      len, DMA_TO_DEVICE);
 			this_txflags = tx_flags;
 			if (frag = skb_shinfo(skb)->nr_frags - 1)
 				this_txflags |= TXFLAG_EOP;
@@ -2786,9 +2768,10 @@ static int __devinit happy_meal_sbus_probe_one(struct sbus_dev *sdev, int is_qfe
 	hp->happy_bursts = of_getintprop_default(sdev->bus->ofdev.node,
 						 "burst-sizes", 0x00);
 
-	hp->happy_block = sbus_alloc_consistent(hp->dma_dev,
-						PAGE_SIZE,
-						&hp->hblock_dvma);
+	hp->happy_block = dma_alloc_coherent(hp->dma_dev,
+					     PAGE_SIZE,
+					     &hp->hblock_dvma,
+					     GFP_ATOMIC);
 	err = -ENOMEM;
 	if (!hp->happy_block) {
 		printk(KERN_ERR "happymeal: Cannot allocate descriptors.\n");
@@ -2824,12 +2807,12 @@ static int __devinit happy_meal_sbus_probe_one(struct sbus_dev *sdev, int is_qfe
 	hp->read_desc32 = sbus_hme_read_desc32;
 	hp->write_txd = sbus_hme_write_txd;
 	hp->write_rxd = sbus_hme_write_rxd;
-	hp->dma_map = (u32 (*)(void *, void *, long, int))sbus_map_single;
-	hp->dma_unmap = (void (*)(void *, u32, long, int))sbus_unmap_single;
+	hp->dma_map = (u32 (*)(void *, void *, long, int))dma_map_single;
+	hp->dma_unmap = (void (*)(void *, u32, long, int))dma_unmap_single;
 	hp->dma_sync_for_cpu = (void (*)(void *, u32, long, int))
-		sbus_dma_sync_single_for_cpu;
+		dma_sync_single_for_cpu;
 	hp->dma_sync_for_device = (void (*)(void *, u32, long, int))
-		sbus_dma_sync_single_for_device;
+		dma_sync_single_for_device;
 	hp->read32 = sbus_hme_read32;
 	hp->write32 = sbus_hme_write32;
 #endif
@@ -2844,7 +2827,7 @@ static int __devinit happy_meal_sbus_probe_one(struct sbus_dev *sdev, int is_qfe
 	if (register_netdev(hp->dev)) {
 		printk(KERN_ERR "happymeal: Cannot register net device, "
 		       "aborting.\n");
-		goto err_out_free_consistent;
+		goto err_out_free_coherent;
 	}
 
 	dev_set_drvdata(&sdev->ofdev.dev, hp);
@@ -2860,11 +2843,11 @@ static int __devinit happy_meal_sbus_probe_one(struct sbus_dev *sdev, int is_qfe
 
 	return 0;
 
-err_out_free_consistent:
-	sbus_free_consistent(hp->dma_dev,
-			     PAGE_SIZE,
-			     hp->happy_block,
-			     hp->hblock_dvma);
+err_out_free_coherent:
+	dma_free_coherent(hp->dma_dev,
+			  PAGE_SIZE,
+			  hp->happy_block,
+			  hp->hblock_dvma);
 
 err_out_iounmap:
 	if (hp->gregs)
@@ -3308,10 +3291,10 @@ static int __devexit hme_sbus_remove(struct of_device *dev)
 	sbus_iounmap(hp->erxregs, ERX_REG_SIZE);
 	sbus_iounmap(hp->bigmacregs, BMAC_REG_SIZE);
 	sbus_iounmap(hp->tcvregs, TCVR_REG_SIZE);
-	sbus_free_consistent(hp->dma_dev,
-			     PAGE_SIZE,
-			     hp->happy_block,
-			     hp->hblock_dvma);
+	dma_free_coherent(hp->dma_dev,
+			  PAGE_SIZE,
+			  hp->happy_block,
+			  hp->hblock_dvma);
 
 	free_netdev(net_dev);
 
diff --git a/drivers/net/sunlance.c b/drivers/net/sunlance.c
index 4f4baf9..6575888 100644
--- a/drivers/net/sunlance.c
+++ b/drivers/net/sunlance.c
@@ -91,6 +91,7 @@ static char lancestr[] = "LANCE";
 #include <linux/skbuff.h>
 #include <linux/ethtool.h>
 #include <linux/bitops.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
@@ -1283,10 +1284,10 @@ static void lance_free_hwresources(struct lance_private *lp)
 		sbus_iounmap(lp->init_block_iomem,
 			     sizeof(struct lance_init_block));
 	} else if (lp->init_block_mem) {
-		sbus_free_consistent(&lp->sdev->ofdev.dev,
-				     sizeof(struct lance_init_block),
-				     lp->init_block_mem,
-				     lp->init_block_dvma);
+		dma_free_coherent(&lp->sdev->ofdev.dev,
+				  sizeof(struct lance_init_block),
+				  lp->init_block_mem,
+				  lp->init_block_dvma);
 	}
 }
 
@@ -1384,9 +1385,9 @@ static int __devinit sparc_lance_probe_one(struct sbus_dev *sdev,
 		lp->tx = lance_tx_pio;
 	} else {
 		lp->init_block_mem -			sbus_alloc_consistent(&sdev->ofdev.dev,
-					      sizeof(struct lance_init_block),
-					      &lp->init_block_dvma);
+			dma_alloc_coherent(&sdev->ofdev.dev,
+					   sizeof(struct lance_init_block),
+					   &lp->init_block_dvma, GFP_ATOMIC);
 		if (!lp->init_block_mem || lp->init_block_dvma = 0) {
 			printk(KERN_ERR "SunLance: Cannot allocate consistent DMA memory.\n");
 			goto fail;
diff --git a/drivers/net/sunqe.c b/drivers/net/sunqe.c
index ac8049c..66f66ee 100644
--- a/drivers/net/sunqe.c
+++ b/drivers/net/sunqe.c
@@ -24,6 +24,7 @@
 #include <linux/skbuff.h>
 #include <linux/ethtool.h>
 #include <linux/bitops.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
@@ -879,12 +880,12 @@ static int __devinit qec_ether_init(struct sbus_dev *sdev)
 		goto fail;
 	}
 
-	qe->qe_block = sbus_alloc_consistent(&qe->qe_sdev->ofdev.dev,
-					     PAGE_SIZE,
-					     &qe->qblock_dvma);
-	qe->buffers = sbus_alloc_consistent(&qe->qe_sdev->ofdev.dev,
-					    sizeof(struct sunqe_buffers),
-					    &qe->buffers_dvma);
+	qe->qe_block = dma_alloc_coherent(&qe->qe_sdev->ofdev.dev,
+					  PAGE_SIZE,
+					  &qe->qblock_dvma, GFP_ATOMIC);
+	qe->buffers = dma_alloc_coherent(&qe->qe_sdev->ofdev.dev,
+					 sizeof(struct sunqe_buffers),
+					 &qe->buffers_dvma, GFP_ATOMIC);
 	if (qe->qe_block = NULL || qe->qblock_dvma = 0 ||
 	    qe->buffers = NULL || qe->buffers_dvma = 0)
 		goto fail;
@@ -926,15 +927,15 @@ fail:
 	if (qe->mregs)
 		sbus_iounmap(qe->mregs, MREGS_REG_SIZE);
 	if (qe->qe_block)
-		sbus_free_consistent(&qe->qe_sdev->ofdev.dev,
-				     PAGE_SIZE,
-				     qe->qe_block,
-				     qe->qblock_dvma);
+		dma_free_coherent(&qe->qe_sdev->ofdev.dev,
+				  PAGE_SIZE,
+				  qe->qe_block,
+				  qe->qblock_dvma);
 	if (qe->buffers)
-		sbus_free_consistent(&qe->qe_sdev->ofdev.dev,
-				     sizeof(struct sunqe_buffers),
-				     qe->buffers,
-				     qe->buffers_dvma);
+		dma_free_coherent(&qe->qe_sdev->ofdev.dev,
+				  sizeof(struct sunqe_buffers),
+				  qe->buffers,
+				  qe->buffers_dvma);
 
 	free_netdev(dev);
 
@@ -957,14 +958,14 @@ static int __devexit qec_sbus_remove(struct of_device *dev)
 
 	sbus_iounmap(qp->qcregs, CREG_REG_SIZE);
 	sbus_iounmap(qp->mregs, MREGS_REG_SIZE);
-	sbus_free_consistent(&qp->qe_sdev->ofdev.dev,
-			     PAGE_SIZE,
-			     qp->qe_block,
-			     qp->qblock_dvma);
-	sbus_free_consistent(&qp->qe_sdev->ofdev.dev,
-			     sizeof(struct sunqe_buffers),
-			     qp->buffers,
-			     qp->buffers_dvma);
+	dma_free_coherent(&qp->qe_sdev->ofdev.dev,
+			  PAGE_SIZE,
+			  qp->qe_block,
+			  qp->qblock_dvma);
+	dma_free_coherent(&qp->qe_sdev->ofdev.dev,
+			  sizeof(struct sunqe_buffers),
+			  qp->buffers,
+			  qp->buffers_dvma);
 
 	free_netdev(net_dev);
 
diff --git a/drivers/scsi/qlogicpti.c b/drivers/scsi/qlogicpti.c
index f010506..1559d45 100644
--- a/drivers/scsi/qlogicpti.c
+++ b/drivers/scsi/qlogicpti.c
@@ -25,6 +25,7 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/jiffies.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/byteorder.h>
 
@@ -788,22 +789,22 @@ static int __devinit qpti_map_queues(struct qlogicpti *qpti)
 	struct sbus_dev *sdev = qpti->sdev;
 
 #define QSIZE(entries)	(((entries) + 1) * QUEUE_ENTRY_LEN)
-	qpti->res_cpu = sbus_alloc_consistent(&sdev->ofdev.dev,
-					      QSIZE(RES_QUEUE_LEN),
-					      &qpti->res_dvma);
+	qpti->res_cpu = dma_alloc_coherent(&sdev->ofdev.dev,
+					   QSIZE(RES_QUEUE_LEN),
+					   &qpti->res_dvma, GFP_ATOMIC);
 	if (qpti->res_cpu = NULL ||
 	    qpti->res_dvma = 0) {
 		printk("QPTI: Cannot map response queue.\n");
 		return -1;
 	}
 
-	qpti->req_cpu = sbus_alloc_consistent(&sdev->ofdev.dev,
-					      QSIZE(QLOGICPTI_REQ_QUEUE_LEN),
-					      &qpti->req_dvma);
+	qpti->req_cpu = dma_alloc_coherent(&sdev->ofdev.dev,
+					   QSIZE(QLOGICPTI_REQ_QUEUE_LEN),
+					   &qpti->req_dvma, GFP_ATOMIC);
 	if (qpti->req_cpu = NULL ||
 	    qpti->req_dvma = 0) {
-		sbus_free_consistent(&sdev->ofdev.dev, QSIZE(RES_QUEUE_LEN),
-				     qpti->res_cpu, qpti->res_dvma);
+		dma_free_coherent(&sdev->ofdev.dev, QSIZE(RES_QUEUE_LEN),
+				  qpti->res_cpu, qpti->res_dvma);
 		printk("QPTI: Cannot map request queue.\n");
 		return -1;
 	}
@@ -875,9 +876,9 @@ static inline int load_cmd(struct scsi_cmnd *Cmnd, struct Command_Entry *cmd,
 		int sg_count;
 
 		sg = scsi_sglist(Cmnd);
-		sg_count = sbus_map_sg(&qpti->sdev->ofdev.dev, sg,
-				       scsi_sg_count(Cmnd),
-				       Cmnd->sc_data_direction);
+		sg_count = dma_map_sg(&qpti->sdev->ofdev.dev, sg,
+				      scsi_sg_count(Cmnd),
+				      Cmnd->sc_data_direction);
 
 		ds = cmd->dataseg;
 		cmd->segment_cnt = sg_count;
@@ -1152,9 +1153,9 @@ static struct scsi_cmnd *qlogicpti_intr_handler(struct qlogicpti *qpti)
 			Cmnd->result = DID_ERROR << 16;
 
 		if (scsi_bufflen(Cmnd))
-			sbus_unmap_sg(&qpti->sdev->ofdev.dev,
-				      scsi_sglist(Cmnd), scsi_sg_count(Cmnd),
-				      Cmnd->sc_data_direction);
+			dma_unmap_sg(&qpti->sdev->ofdev.dev,
+				     scsi_sglist(Cmnd), scsi_sg_count(Cmnd),
+				     Cmnd->sc_data_direction);
 
 		qpti->cmd_count[Cmnd->device->id]--;
 		sbus_writew(out_ptr, qpti->qregs + MBOX5);
@@ -1357,12 +1358,12 @@ static int __devinit qpti_sbus_probe(struct of_device *dev, const struct of_devi
 
 fail_unmap_queues:
 #define QSIZE(entries)	(((entries) + 1) * QUEUE_ENTRY_LEN)
-	sbus_free_consistent(&qpti->sdev->ofdev.dev,
-			     QSIZE(RES_QUEUE_LEN),
-			     qpti->res_cpu, qpti->res_dvma);
-	sbus_free_consistent(&qpti->sdev->ofdev.dev,
-			     QSIZE(QLOGICPTI_REQ_QUEUE_LEN),
-			     qpti->req_cpu, qpti->req_dvma);
+	dma_free_coherent(&qpti->sdev->ofdev.dev,
+			  QSIZE(RES_QUEUE_LEN),
+			  qpti->res_cpu, qpti->res_dvma);
+	dma_free_coherent(&qpti->sdev->ofdev.dev,
+			  QSIZE(QLOGICPTI_REQ_QUEUE_LEN),
+			  qpti->req_cpu, qpti->req_dvma);
 #undef QSIZE
 
 fail_unmap_regs:
@@ -1395,12 +1396,12 @@ static int __devexit qpti_sbus_remove(struct of_device *dev)
 	free_irq(qpti->irq, qpti);
 
 #define QSIZE(entries)	(((entries) + 1) * QUEUE_ENTRY_LEN)
-	sbus_free_consistent(&qpti->sdev->ofdev.dev,
-			     QSIZE(RES_QUEUE_LEN),
-			     qpti->res_cpu, qpti->res_dvma);
-	sbus_free_consistent(&qpti->sdev->ofdev.dev,
-			     QSIZE(QLOGICPTI_REQ_QUEUE_LEN),
-			     qpti->req_cpu, qpti->req_dvma);
+	dma_free_coherent(&qpti->sdev->ofdev.dev,
+			  QSIZE(RES_QUEUE_LEN),
+			  qpti->res_cpu, qpti->res_dvma);
+	dma_free_coherent(&qpti->sdev->ofdev.dev,
+			  QSIZE(QLOGICPTI_REQ_QUEUE_LEN),
+			  qpti->req_cpu, qpti->req_dvma);
 #undef QSIZE
 
 	sbus_iounmap(qpti->qregs, qpti->sdev->reg_addrs[0].reg_size);
diff --git a/drivers/scsi/sun_esp.c b/drivers/scsi/sun_esp.c
index 35b6e2c..f750874 100644
--- a/drivers/scsi/sun_esp.c
+++ b/drivers/scsi/sun_esp.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/init.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/irq.h>
 #include <asm/io.h>
@@ -101,8 +102,9 @@ static int __devinit esp_sbus_map_command_block(struct esp *esp)
 {
 	struct sbus_dev *sdev = esp->dev;
 
-	esp->command_block = sbus_alloc_consistent(&sdev->ofdev.dev, 16,
-						   &esp->command_block_dma);
+	esp->command_block = dma_alloc_coherent(&sdev->ofdev.dev, 16,
+						&esp->command_block_dma,
+						GFP_ATOMIC);
 	if (!esp->command_block)
 		return -ENOMEM;
 	return 0;
@@ -225,7 +227,7 @@ static dma_addr_t sbus_esp_map_single(struct esp *esp, void *buf,
 {
 	struct sbus_dev *sdev = esp->dev;
 
-	return sbus_map_single(&sdev->ofdev.dev, buf, sz, dir);
+	return dma_map_single(&sdev->ofdev.dev, buf, sz, dir);
 }
 
 static int sbus_esp_map_sg(struct esp *esp, struct scatterlist *sg,
@@ -233,7 +235,7 @@ static int sbus_esp_map_sg(struct esp *esp, struct scatterlist *sg,
 {
 	struct sbus_dev *sdev = esp->dev;
 
-	return sbus_map_sg(&sdev->ofdev.dev, sg, num_sg, dir);
+	return dma_map_sg(&sdev->ofdev.dev, sg, num_sg, dir);
 }
 
 static void sbus_esp_unmap_single(struct esp *esp, dma_addr_t addr,
@@ -241,7 +243,7 @@ static void sbus_esp_unmap_single(struct esp *esp, dma_addr_t addr,
 {
 	struct sbus_dev *sdev = esp->dev;
 
-	sbus_unmap_single(&sdev->ofdev.dev, addr, sz, dir);
+	dma_unmap_single(&sdev->ofdev.dev, addr, sz, dir);
 }
 
 static void sbus_esp_unmap_sg(struct esp *esp, struct scatterlist *sg,
@@ -249,7 +251,7 @@ static void sbus_esp_unmap_sg(struct esp *esp, struct scatterlist *sg,
 {
 	struct sbus_dev *sdev = esp->dev;
 
-	sbus_unmap_sg(&sdev->ofdev.dev, sg, num_sg, dir);
+	dma_unmap_sg(&sdev->ofdev.dev, sg, num_sg, dir);
 }
 
 static int sbus_esp_irq_pending(struct esp *esp)
@@ -558,9 +560,9 @@ static int __devinit esp_sbus_probe_one(struct device *dev,
 fail_free_irq:
 	free_irq(host->irq, esp);
 fail_unmap_command_block:
-	sbus_free_consistent(&esp_dev->ofdev.dev, 16,
-			     esp->command_block,
-			     esp->command_block_dma);
+	dma_free_coherent(&esp_dev->ofdev.dev, 16,
+			  esp->command_block,
+			  esp->command_block_dma);
 fail_unmap_regs:
 	sbus_iounmap(esp->regs, SBUS_ESP_REG_SIZE);
 fail_unlink:
@@ -609,9 +611,9 @@ static int __devexit esp_sbus_remove(struct of_device *dev)
 	dma_write32(val & ~DMA_INT_ENAB, DMA_CSR);
 
 	free_irq(irq, esp);
-	sbus_free_consistent(&sdev->ofdev.dev, 16,
-			     esp->command_block,
-			     esp->command_block_dma);
+	dma_free_coherent(&sdev->ofdev.dev, 16,
+			  esp->command_block,
+			  esp->command_block_dma);
 	sbus_iounmap(esp->regs, SBUS_ESP_REG_SIZE);
 	of_iounmap(&dma_of->resource[0], esp->dma_regs,
 		   resource_size(&dma_of->resource[0]));
diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
index cc80397..ccaaac4 100644
--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -192,8 +192,8 @@ static void *snd_malloc_sbus_pages(struct device *dev, size_t size,
 	snd_assert(size > 0, return NULL);
 	snd_assert(dma_addr != NULL, return NULL);
 	pg = get_order(size);
-	res = sbus_alloc_consistent(&sdev->ofdev.dev, PAGE_SIZE * (1 << pg),
-				    dma_addr);
+	res = dma_alloc_coherent(&sdev->ofdev.dev, PAGE_SIZE * (1 << pg),
+				 dma_addr, GFP_ATOMIC);
 	if (res != NULL)
 		inc_snd_pages(pg);
 	return res;
@@ -209,8 +209,8 @@ static void snd_free_sbus_pages(struct device *dev, size_t size,
 		return;
 	pg = get_order(size);
 	dec_snd_pages(pg);
-	sbus_free_consistent(&sdev->ofdev.dev, PAGE_SIZE * (1 << pg),
-			     ptr, dma_addr);
+	dma_free_coherent(&sdev->ofdev.dev, PAGE_SIZE * (1 << pg),
+			  ptr, dma_addr);
 }
 
 #endif /* CONFIG_SBUS */
diff --git a/sound/sparc/dbri.c b/sound/sparc/dbri.c
index a6b32ec..5242ecb 100644
--- a/sound/sparc/dbri.c
+++ b/sound/sparc/dbri.c
@@ -57,6 +57,7 @@
 #include <linux/delay.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <linux/dma-mapping.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -2093,15 +2094,15 @@ static int snd_dbri_hw_params(struct snd_pcm_substream *substream,
 	 */
 	if (info->dvma_buffer = 0) {
 		if (DBRI_STREAMNO(substream) = DBRI_PLAY)
-			direction = SBUS_DMA_TODEVICE;
+			direction = DMA_TO_DEVICE;
 		else
-			direction = SBUS_DMA_FROMDEVICE;
+			direction = DMA_FROM_DEVICE;
 
 		info->dvma_buffer -			sbus_map_single(&dbri->sdev->ofdev.dev,
-					runtime->dma_area,
-					params_buffer_bytes(hw_params),
-					direction);
+			dma_map_single(&dbri->sdev->ofdev.dev,
+				       runtime->dma_area,
+				       params_buffer_bytes(hw_params),
+				       direction);
 	}
 
 	direction = params_buffer_bytes(hw_params);
@@ -2122,12 +2123,12 @@ static int snd_dbri_hw_free(struct snd_pcm_substream *substream)
 	 */
 	if (info->dvma_buffer) {
 		if (DBRI_STREAMNO(substream) = DBRI_PLAY)
-			direction = SBUS_DMA_TODEVICE;
+			direction = DMA_TO_DEVICE;
 		else
-			direction = SBUS_DMA_FROMDEVICE;
+			direction = DMA_FROM_DEVICE;
 
-		sbus_unmap_single(&dbri->sdev->ofdev.dev, info->dvma_buffer,
-				  substream->runtime->buffer_size, direction);
+		dma_unmap_single(&dbri->sdev->ofdev.dev, info->dvma_buffer,
+				 substream->runtime->buffer_size, direction);
 		info->dvma_buffer = 0;
 	}
 	if (info->pipe != -1) {
@@ -2525,9 +2526,9 @@ static int __devinit snd_dbri_create(struct snd_card *card,
 	dbri->sdev = sdev;
 	dbri->irq = irq;
 
-	dbri->dma = sbus_alloc_consistent(&sdev->ofdev.dev,
-					  sizeof(struct dbri_dma),
-					  &dbri->dma_dvma);
+	dbri->dma = dma_alloc_coherent(&sdev->ofdev.dev,
+				       sizeof(struct dbri_dma),
+				       &dbri->dma_dvma, GFP_ATOMIC);
 	memset((void *)dbri->dma, 0, sizeof(struct dbri_dma));
 
 	dprintk(D_GEN, "DMA Cmd Block 0x%p (0x%08x)\n",
@@ -2539,8 +2540,8 @@ static int __devinit snd_dbri_create(struct snd_card *card,
 				  dbri->regs_size, "DBRI Registers");
 	if (!dbri->regs) {
 		printk(KERN_ERR "DBRI: could not allocate registers\n");
-		sbus_free_consistent(&sdev->ofdev.dev, sizeof(struct dbri_dma),
-				     (void *)dbri->dma, dbri->dma_dvma);
+		dma_free_coherent(&sdev->ofdev.dev, sizeof(struct dbri_dma),
+				  (void *)dbri->dma, dbri->dma_dvma);
 		return -EIO;
 	}
 
@@ -2549,8 +2550,8 @@ static int __devinit snd_dbri_create(struct snd_card *card,
 	if (err) {
 		printk(KERN_ERR "DBRI: Can't get irq %d\n", dbri->irq);
 		sbus_iounmap(dbri->regs, dbri->regs_size);
-		sbus_free_consistent(&sdev->ofdev.dev, sizeof(struct dbri_dma),
-				     (void *)dbri->dma, dbri->dma_dvma);
+		dma_free_coherent(&sdev->ofdev.dev, sizeof(struct dbri_dma),
+				  (void *)dbri->dma, dbri->dma_dvma);
 		return err;
 	}
 
@@ -2577,9 +2578,9 @@ static void snd_dbri_free(struct snd_dbri *dbri)
 		sbus_iounmap(dbri->regs, dbri->regs_size);
 
 	if (dbri->dma)
-		sbus_free_consistent(&dbri->sdev->ofdev.dev,
-				     sizeof(struct dbri_dma),
-				     (void *)dbri->dma, dbri->dma_dvma);
+		dma_free_coherent(&dbri->sdev->ofdev.dev,
+				  sizeof(struct dbri_dma),
+				  (void *)dbri->dma, dbri->dma_dvma);
 }
 
 static int __devinit dbri_probe(struct of_device *of_dev,
-- 
1.5.6.5.GIT

