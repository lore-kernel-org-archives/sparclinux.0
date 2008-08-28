From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:23:47 +0000
Subject: [PATCH 12/49]: sunbmac: Convert to pure OF driver.
Message-Id: <20080827.212347.118714109.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sunbmac: Convert to pure OF driver.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/net/sunbmac.c |  154 ++++++++++++++++++++++---------------------------
 drivers/net/sunbmac.h |    4 +-
 2 files changed, 70 insertions(+), 88 deletions(-)

diff --git a/drivers/net/sunbmac.c b/drivers/net/sunbmac.c
index 8fe4c49..7009a5e 100644
--- a/drivers/net/sunbmac.c
+++ b/drivers/net/sunbmac.c
@@ -1,7 +1,6 @@
-/* $Id: sunbmac.c,v 1.30 2002/01/15 06:48:55 davem Exp $
- * sunbmac.c: Driver for Sparc BigMAC 100baseT ethernet adapters.
+/* sunbmac.c: Driver for Sparc BigMAC 100baseT ethernet adapters.
  *
- * Copyright (C) 1997, 1998, 1999, 2003 David S. Miller (davem@redhat.com)
+ * Copyright (C) 1997, 1998, 1999, 2003, 2008 David S. Miller (davem@davemloft.net)
  */
 
 #include <linux/module.h>
@@ -24,6 +23,8 @@
 #include <linux/skbuff.h>
 #include <linux/bitops.h>
 #include <linux/dma-mapping.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <asm/auxio.h>
 #include <asm/byteorder.h>
@@ -33,15 +34,14 @@
 #include <asm/openprom.h>
 #include <asm/oplib.h>
 #include <asm/pgtable.h>
-#include <asm/sbus.h>
 #include <asm/system.h>
 
 #include "sunbmac.h"
 
 #define DRV_NAME	"sunbmac"
-#define DRV_VERSION	"2.0"
-#define DRV_RELDATE	"11/24/03"
-#define DRV_AUTHOR	"David S. Miller (davem@redhat.com)"
+#define DRV_VERSION	"2.1"
+#define DRV_RELDATE	"August 26, 2008"
+#define DRV_AUTHOR	"David S. Miller (davem@davemloft.net)"
 
 static char version[]  	DRV_NAME ".c:v" DRV_VERSION " " DRV_RELDATE " " DRV_AUTHOR "\n";
@@ -97,8 +97,8 @@ static int qec_global_reset(void __iomem *gregs)
 
 static void qec_init(struct bigmac *bp)
 {
+	struct of_device *qec_op = bp->qec_op;
 	void __iomem *gregs = bp->gregs;
-	struct sbus_dev *qec_sdev = bp->qec_sdev;
 	u8 bsizes = bp->bigmac_bursts;
 	u32 regval;
 
@@ -113,13 +113,13 @@ static void qec_init(struct bigmac *bp)
 	sbus_writel(GLOB_PSIZE_2048, gregs + GLOB_PSIZE);
 
 	/* All of memsize is given to bigmac. */
-	sbus_writel(qec_sdev->reg_addrs[1].reg_size,
+	sbus_writel(resource_size(&qec_op->resource[1]),
 		    gregs + GLOB_MSIZE);
 
 	/* Half to the transmitter, half to the receiver. */
-	sbus_writel(qec_sdev->reg_addrs[1].reg_size >> 1,
+	sbus_writel(resource_size(&qec_op->resource[1]) >> 1,
 		    gregs + GLOB_TSIZE);
-	sbus_writel(qec_sdev->reg_addrs[1].reg_size >> 1,
+	sbus_writel(resource_size(&qec_op->resource[1]) >> 1,
 		    gregs + GLOB_RSIZE);
 }
 
@@ -240,7 +240,7 @@ static void bigmac_init_rings(struct bigmac *bp, int from_irq)
 		skb_reserve(skb, 34);
 
 		bb->be_rxd[i].rx_addr -			dma_map_single(&bp->bigmac_sdev->ofdev.dev,
+			dma_map_single(&bp->bigmac_op->dev,
 				       skb->data,
 				       RX_BUF_ALLOC_SIZE - 34,
 				       DMA_FROM_DEVICE);
@@ -778,7 +778,7 @@ static void bigmac_tx(struct bigmac *bp)
 		skb = bp->tx_skbs[elem];
 		bp->enet_stats.tx_packets++;
 		bp->enet_stats.tx_bytes += skb->len;
-		dma_unmap_single(&bp->bigmac_sdev->ofdev.dev,
+		dma_unmap_single(&bp->bigmac_op->dev,
 				 this->tx_addr, skb->len,
 				 DMA_TO_DEVICE);
 
@@ -833,7 +833,7 @@ static void bigmac_rx(struct bigmac *bp)
 				drops++;
 				goto drop_it;
 			}
-			dma_unmap_single(&bp->bigmac_sdev->ofdev.dev,
+			dma_unmap_single(&bp->bigmac_op->dev,
 					 this->rx_addr,
 					 RX_BUF_ALLOC_SIZE - 34,
 					 DMA_FROM_DEVICE);
@@ -842,7 +842,7 @@ static void bigmac_rx(struct bigmac *bp)
 			skb_put(new_skb, ETH_FRAME_LEN);
 			skb_reserve(new_skb, 34);
 			this->rx_addr -				dma_map_single(&bp->bigmac_sdev->ofdev.dev,
+				dma_map_single(&bp->bigmac_op->dev,
 					       new_skb->data,
 					       RX_BUF_ALLOC_SIZE - 34,
 					       DMA_FROM_DEVICE);
@@ -860,11 +860,11 @@ static void bigmac_rx(struct bigmac *bp)
 			}
 			skb_reserve(copy_skb, 2);
 			skb_put(copy_skb, len);
-			dma_sync_single_for_cpu(&bp->bigmac_sdev->ofdev.dev,
+			dma_sync_single_for_cpu(&bp->bigmac_op->dev,
 						this->rx_addr, len,
 						DMA_FROM_DEVICE);
 			skb_copy_to_linear_data(copy_skb, (unsigned char *)skb->data, len);
-			dma_sync_single_for_device(&bp->bigmac_sdev->ofdev.dev,
+			dma_sync_single_for_device(&bp->bigmac_op->dev,
 						   this->rx_addr, len,
 						   DMA_FROM_DEVICE);
 
@@ -962,7 +962,7 @@ static int bigmac_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	u32 mapping;
 
 	len = skb->len;
-	mapping = dma_map_single(&bp->bigmac_sdev->ofdev.dev, skb->data,
+	mapping = dma_map_single(&bp->bigmac_op->dev, skb->data,
 				 len, DMA_TO_DEVICE);
 
 	/* Avoid a race... */
@@ -1055,12 +1055,8 @@ static void bigmac_set_multicast(struct net_device *dev)
 /* Ethtool support... */
 static void bigmac_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *info)
 {
-	struct bigmac *bp = dev->priv;
-
 	strcpy(info->driver, "sunbmac");
 	strcpy(info->version, "2.0");
-	sprintf(info->bus_info, "SBUS:%d",
-		bp->qec_sdev->slot);
 }
 
 static u32 bigmac_get_link(struct net_device *dev)
@@ -1079,14 +1075,15 @@ static const struct ethtool_ops bigmac_ethtool_ops = {
 	.get_link		= bigmac_get_link,
 };
 
-static int __devinit bigmac_ether_init(struct sbus_dev *qec_sdev)
+static int __devinit bigmac_ether_init(struct of_device *op,
+				       struct of_device *qec_op)
 {
-	struct net_device *dev;
 	static int version_printed;
-	struct bigmac *bp;
+	struct net_device *dev;
 	u8 bsizes, bsizes_more;
-	int i;
 	DECLARE_MAC_BUF(mac);
+	struct bigmac *bp;
+	int i;
 
 	/* Get a new device struct for this interface. */
 	dev = alloc_etherdev(sizeof(struct bigmac));
@@ -1096,32 +1093,21 @@ static int __devinit bigmac_ether_init(struct sbus_dev *qec_sdev)
 	if (version_printed++ = 0)
 		printk(KERN_INFO "%s", version);
 
-	dev->base_addr = (long) qec_sdev;
 	for (i = 0; i < 6; i++)
 		dev->dev_addr[i] = idprom->id_ethaddr[i];
 
 	/* Setup softc, with backpointers to QEC and BigMAC SBUS device structs. */
-	bp = dev->priv;
-	bp->qec_sdev = qec_sdev;
-	bp->bigmac_sdev = qec_sdev->child;
+	bp = netdev_priv(dev);
+	bp->qec_op = qec_op;
+	bp->bigmac_op = op;
 
-	SET_NETDEV_DEV(dev, &bp->bigmac_sdev->ofdev.dev);
+	SET_NETDEV_DEV(dev, &op->dev);
 
 	spin_lock_init(&bp->lock);
 
-	/* Verify the registers we expect, are actually there. */
-	if ((bp->bigmac_sdev->num_registers != 3) ||
-	   (bp->qec_sdev->num_registers != 2)) {
-		printk(KERN_ERR "BIGMAC: Device does not have 2 and 3 regs, it has %d and %d.\n",
-		       bp->qec_sdev->num_registers,
-		       bp->bigmac_sdev->num_registers);
-		printk(KERN_ERR "BIGMAC: Would you like that for here or to go?\n");
-		goto fail_and_cleanup;
-	}
-
 	/* Map in QEC global control registers. */
-	bp->gregs = sbus_ioremap(&bp->qec_sdev->resource[0], 0,
-				 GLOB_REG_SIZE, "BigMAC QEC GLobal Regs");
+	bp->gregs = of_ioremap(&qec_op->resource[0], 0,
+			       GLOB_REG_SIZE, "BigMAC QEC GLobal Regs");
 	if (!bp->gregs) {
 		printk(KERN_ERR "BIGMAC: Cannot map QEC global registers.\n");
 		goto fail_and_cleanup;
@@ -1138,13 +1124,8 @@ static int __devinit bigmac_ether_init(struct sbus_dev *qec_sdev)
 		goto fail_and_cleanup;
 
 	/* Get supported SBUS burst sizes. */
-	bsizes = prom_getintdefault(bp->qec_sdev->prom_node,
-				    "burst-sizes",
-				    0xff);
-
-	bsizes_more = prom_getintdefault(bp->qec_sdev->bus->prom_node,
-					 "burst-sizes",
-					 0xff);
+	bsizes = of_getintprop_default(qec_op->node, "burst-sizes", 0xff);
+	bsizes_more = of_getintprop_default(qec_op->node, "burst-sizes", 0xff);
 
 	bsizes &= 0xff;
 	if (bsizes_more != 0xff)
@@ -1158,16 +1139,16 @@ static int __devinit bigmac_ether_init(struct sbus_dev *qec_sdev)
 	qec_init(bp);
 
 	/* Map in the BigMAC channel registers. */
-	bp->creg = sbus_ioremap(&bp->bigmac_sdev->resource[0], 0,
-				CREG_REG_SIZE, "BigMAC QEC Channel Regs");
+	bp->creg = of_ioremap(&op->resource[0], 0,
+			      CREG_REG_SIZE, "BigMAC QEC Channel Regs");
 	if (!bp->creg) {
 		printk(KERN_ERR "BIGMAC: Cannot map QEC channel registers.\n");
 		goto fail_and_cleanup;
 	}
 
 	/* Map in the BigMAC control registers. */
-	bp->bregs = sbus_ioremap(&bp->bigmac_sdev->resource[1], 0,
-				 BMAC_REG_SIZE, "BigMAC Primary Regs");
+	bp->bregs = of_ioremap(&op->resource[1], 0,
+			       BMAC_REG_SIZE, "BigMAC Primary Regs");
 	if (!bp->bregs) {
 		printk(KERN_ERR "BIGMAC: Cannot map BigMAC primary registers.\n");
 		goto fail_and_cleanup;
@@ -1176,8 +1157,8 @@ static int __devinit bigmac_ether_init(struct sbus_dev *qec_sdev)
 	/* Map in the BigMAC transceiver registers, this is how you poke at
 	 * the BigMAC's PHY.
 	 */
-	bp->tregs = sbus_ioremap(&bp->bigmac_sdev->resource[2], 0,
-				 TCVR_REG_SIZE, "BigMAC Transceiver Regs");
+	bp->tregs = of_ioremap(&op->resource[2], 0,
+			       TCVR_REG_SIZE, "BigMAC Transceiver Regs");
 	if (!bp->tregs) {
 		printk(KERN_ERR "BIGMAC: Cannot map BigMAC transceiver registers.\n");
 		goto fail_and_cleanup;
@@ -1187,7 +1168,7 @@ static int __devinit bigmac_ether_init(struct sbus_dev *qec_sdev)
 	bigmac_stop(bp);
 
 	/* Allocate transmit/receive descriptor DVMA block. */
-	bp->bmac_block = dma_alloc_coherent(&bp->bigmac_sdev->ofdev.dev,
+	bp->bmac_block = dma_alloc_coherent(&bp->bigmac_op->dev,
 					    PAGE_SIZE,
 					    &bp->bblock_dvma, GFP_ATOMIC);
 	if (bp->bmac_block = NULL || bp->bblock_dvma = 0) {
@@ -1196,8 +1177,8 @@ static int __devinit bigmac_ether_init(struct sbus_dev *qec_sdev)
 	}
 
 	/* Get the board revision of this BigMAC. */
-	bp->board_rev = prom_getintdefault(bp->bigmac_sdev->prom_node,
-					   "board-version", 1);
+	bp->board_rev = of_getintprop_default(bp->bigmac_op->node,
+					      "board-version", 1);
 
 	/* Init auto-negotiation timer state. */
 	init_timer(&bp->bigmac_timer);
@@ -1221,7 +1202,7 @@ static int __devinit bigmac_ether_init(struct sbus_dev *qec_sdev)
 	dev->watchdog_timeo = 5*HZ;
 
 	/* Finish net device registration. */
-	dev->irq = bp->bigmac_sdev->irqs[0];
+	dev->irq = bp->bigmac_op->irqs[0];
 	dev->dma = 0;
 
 	if (register_netdev(dev)) {
@@ -1229,7 +1210,7 @@ static int __devinit bigmac_ether_init(struct sbus_dev *qec_sdev)
 		goto fail_and_cleanup;
 	}
 
-	dev_set_drvdata(&bp->bigmac_sdev->ofdev.dev, bp);
+	dev_set_drvdata(&bp->bigmac_op->dev, bp);
 
 	printk(KERN_INFO "%s: BigMAC 100baseT Ethernet %s\n",
 	       dev->name, print_mac(mac, dev->dev_addr));
@@ -1240,16 +1221,16 @@ fail_and_cleanup:
 	/* Something went wrong, undo whatever we did so far. */
 	/* Free register mappings if any. */
 	if (bp->gregs)
-		sbus_iounmap(bp->gregs, GLOB_REG_SIZE);
+		of_iounmap(&qec_op->resource[0], bp->gregs, GLOB_REG_SIZE);
 	if (bp->creg)
-		sbus_iounmap(bp->creg, CREG_REG_SIZE);
+		of_iounmap(&op->resource[0], bp->creg, CREG_REG_SIZE);
 	if (bp->bregs)
-		sbus_iounmap(bp->bregs, BMAC_REG_SIZE);
+		of_iounmap(&op->resource[1], bp->bregs, BMAC_REG_SIZE);
 	if (bp->tregs)
-		sbus_iounmap(bp->tregs, TCVR_REG_SIZE);
+		of_iounmap(&op->resource[2], bp->tregs, TCVR_REG_SIZE);
 
 	if (bp->bmac_block)
-		dma_free_coherent(&bp->bigmac_sdev->ofdev.dev,
+		dma_free_coherent(&bp->bigmac_op->dev,
 				  PAGE_SIZE,
 				  bp->bmac_block,
 				  bp->bblock_dvma);
@@ -1259,48 +1240,49 @@ fail_and_cleanup:
 	return -ENODEV;
 }
 
-/* QEC can be the parent of either QuadEthernet or
- * a BigMAC.  We want the latter.
+/* QEC can be the parent of either QuadEthernet or a BigMAC.  We want
+ * the latter.
  */
-static int __devinit bigmac_sbus_probe(struct of_device *dev, const struct of_device_id *match)
+static int __devinit bigmac_sbus_probe(struct of_device *op,
+				       const struct of_device_id *match)
 {
-	struct sbus_dev *sdev = to_sbus_device(&dev->dev);
-	struct device_node *dp = dev->node;
+	struct device *parent = op->dev.parent;
+	struct of_device *qec_op;
 
-	if (!strcmp(dp->name, "be"))
-		sdev = sdev->parent;
+	qec_op = to_of_device(parent);
 
-	return bigmac_ether_init(sdev);
+	return bigmac_ether_init(op, qec_op);
 }
 
-static int __devexit bigmac_sbus_remove(struct of_device *dev)
+static int __devexit bigmac_sbus_remove(struct of_device *op)
 {
-	struct bigmac *bp = dev_get_drvdata(&dev->dev);
+	struct bigmac *bp = dev_get_drvdata(&op->dev);
+	struct device *parent = op->dev.parent;
 	struct net_device *net_dev = bp->dev;
+	struct of_device *qec_op;
+
+	qec_op = to_of_device(parent);
 
 	unregister_netdevice(net_dev);
 
-	sbus_iounmap(bp->gregs, GLOB_REG_SIZE);
-	sbus_iounmap(bp->creg, CREG_REG_SIZE);
-	sbus_iounmap(bp->bregs, BMAC_REG_SIZE);
-	sbus_iounmap(bp->tregs, TCVR_REG_SIZE);
-	dma_free_coherent(&bp->bigmac_sdev->ofdev.dev,
+	of_iounmap(&qec_op->resource[0], bp->gregs, GLOB_REG_SIZE);
+	of_iounmap(&op->resource[0], bp->creg, CREG_REG_SIZE);
+	of_iounmap(&op->resource[1], bp->bregs, BMAC_REG_SIZE);
+	of_iounmap(&op->resource[2], bp->tregs, TCVR_REG_SIZE);
+	dma_free_coherent(&op->dev,
 			  PAGE_SIZE,
 			  bp->bmac_block,
 			  bp->bblock_dvma);
 
 	free_netdev(net_dev);
 
-	dev_set_drvdata(&dev->dev, NULL);
+	dev_set_drvdata(&op->dev, NULL);
 
 	return 0;
 }
 
 static struct of_device_id bigmac_sbus_match[] = {
 	{
-		.name = "qec",
-	},
-	{
 		.name = "be",
 	},
 	{},
@@ -1317,7 +1299,7 @@ static struct of_platform_driver bigmac_sbus_driver = {
 
 static int __init bigmac_init(void)
 {
-	return of_register_driver(&bigmac_sbus_driver, &sbus_bus_type);
+	return of_register_driver(&bigmac_sbus_driver, &of_bus_type);
 }
 
 static void __exit bigmac_exit(void)
diff --git a/drivers/net/sunbmac.h b/drivers/net/sunbmac.h
index b563d3c..8840bc0 100644
--- a/drivers/net/sunbmac.h
+++ b/drivers/net/sunbmac.h
@@ -329,8 +329,8 @@ struct bigmac {
 	unsigned int		timer_ticks;
 
 	struct net_device_stats	enet_stats;
-	struct sbus_dev		*qec_sdev;
-	struct sbus_dev		*bigmac_sdev;
+	struct of_device	*qec_op;
+	struct of_device	*bigmac_op;
 	struct net_device	*dev;
 };
 
-- 
1.5.6.5.GIT

