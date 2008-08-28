From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:23:50 +0000
Subject: [PATCH 13/49]: sunhme: Convert to pure OF driver.
Message-Id: <20080827.212350.47860902.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sunhme: Convert to pure OF driver.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/net/sunhme.c |  243 ++++++++++++++++++++------------------------------
 drivers/net/sunhme.h |    8 +--
 2 files changed, 97 insertions(+), 154 deletions(-)

diff --git a/drivers/net/sunhme.c b/drivers/net/sunhme.c
index d15da94..7638a9f 100644
--- a/drivers/net/sunhme.c
+++ b/drivers/net/sunhme.c
@@ -3,7 +3,7 @@
  *           "Happy Meal Ethernet" found on SunSwift SBUS cards.
  *
  * Copyright (C) 1996, 1998, 1999, 2002, 2003,
-		 2006 David S. Miller (davem@davemloft.net)
+ *		2006, 2008 David S. Miller (davem@davemloft.net)
  *
  * Changes :
  * 2000/11/11 Willy Tarreau <willy AT meta-x.org>
@@ -42,8 +42,9 @@
 #include <asm/byteorder.h>
 
 #ifdef CONFIG_SPARC
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <asm/idprom.h>
-#include <asm/sbus.h>
 #include <asm/openprom.h>
 #include <asm/oplib.h>
 #include <asm/prom.h>
@@ -61,8 +62,8 @@
 #include "sunhme.h"
 
 #define DRV_NAME	"sunhme"
-#define DRV_VERSION	"3.00"
-#define DRV_RELDATE	"June 23, 2006"
+#define DRV_VERSION	"3.10"
+#define DRV_RELDATE	"August 26, 2008"
 #define DRV_AUTHOR	"David S. Miller (davem@davemloft.net)"
 
 static char version[] @@ -1206,7 +1207,8 @@ static void happy_meal_clean_rings(struct happy_meal *hp)
 
 			rxd = &hp->happy_block->happy_meal_rxd[i];
 			dma_addr = hme_read_desc32(hp, &rxd->rx_addr);
-			hme_dma_unmap(hp, dma_addr, RX_BUF_ALLOC_SIZE, DMA_FROM_DEVICE);
+			dma_unmap_single(hp->dma_dev, dma_addr,
+					 RX_BUF_ALLOC_SIZE, DMA_FROM_DEVICE);
 			dev_kfree_skb_any(skb);
 			hp->rx_skbs[i] = NULL;
 		}
@@ -1224,10 +1226,10 @@ static void happy_meal_clean_rings(struct happy_meal *hp)
 			for (frag = 0; frag <= skb_shinfo(skb)->nr_frags; frag++) {
 				txd = &hp->happy_block->happy_meal_txd[i];
 				dma_addr = hme_read_desc32(hp, &txd->tx_addr);
-				hme_dma_unmap(hp, dma_addr,
-					      (hme_read_desc32(hp, &txd->tx_flags)
-					       & TXFLAG_SIZE),
-					      DMA_TO_DEVICE);
+				dma_unmap_single(hp->dma_dev, dma_addr,
+						 (hme_read_desc32(hp, &txd->tx_flags)
+						  & TXFLAG_SIZE),
+						 DMA_TO_DEVICE);
 
 				if (frag != skb_shinfo(skb)->nr_frags)
 					i++;
@@ -1269,7 +1271,8 @@ static void happy_meal_init_rings(struct happy_meal *hp)
 		skb_put(skb, (ETH_FRAME_LEN + RX_OFFSET + 4));
 		hme_write_rxd(hp, &hb->happy_meal_rxd[i],
 			      (RXFLAG_OWN | ((RX_BUF_ALLOC_SIZE - RX_OFFSET) << 16)),
-			      hme_dma_map(hp, skb->data, RX_BUF_ALLOC_SIZE, DMA_FROM_DEVICE));
+			      dma_map_single(hp->dma_dev, skb->data, RX_BUF_ALLOC_SIZE,
+					     DMA_FROM_DEVICE));
 		skb_reserve(skb, RX_OFFSET);
 	}
 
@@ -1586,9 +1589,9 @@ static int happy_meal_init(struct happy_meal *hp)
 		 */
 #ifdef CONFIG_SBUS
 		if ((hp->happy_flags & HFLAG_PCI) = 0) {
-			struct sbus_dev *sdev = hp->happy_dev;
+			struct of_device *op = hp->happy_dev;
 			if (sbus_can_dma_64bit()) {
-				sbus_set_sbus64(&sdev->ofdev.dev,
+				sbus_set_sbus64(&op->dev,
 						hp->happy_bursts);
 				gcfg |= GREG_CFG_64BIT;
 			}
@@ -1950,7 +1953,7 @@ static void happy_meal_tx(struct happy_meal *hp)
 			dma_len = hme_read_desc32(hp, &this->tx_flags);
 
 			dma_len &= TXFLAG_SIZE;
-			hme_dma_unmap(hp, dma_addr, dma_len, DMA_TO_DEVICE);
+			dma_unmap_single(hp->dma_dev, dma_addr, dma_len, DMA_TO_DEVICE);
 
 			elem = NEXT_TX(elem);
 			this = &txbase[elem];
@@ -2028,13 +2031,14 @@ static void happy_meal_rx(struct happy_meal *hp, struct net_device *dev)
 				drops++;
 				goto drop_it;
 			}
-			hme_dma_unmap(hp, dma_addr, RX_BUF_ALLOC_SIZE, DMA_FROM_DEVICE);
+			dma_unmap_single(hp->dma_dev, dma_addr, RX_BUF_ALLOC_SIZE, DMA_FROM_DEVICE);
 			hp->rx_skbs[elem] = new_skb;
 			new_skb->dev = dev;
 			skb_put(new_skb, (ETH_FRAME_LEN + RX_OFFSET + 4));
 			hme_write_rxd(hp, this,
 				      (RXFLAG_OWN|((RX_BUF_ALLOC_SIZE-RX_OFFSET)<<16)),
-				      hme_dma_map(hp, new_skb->data, RX_BUF_ALLOC_SIZE, DMA_FROM_DEVICE));
+				      dma_map_single(hp->dma_dev, new_skb->data, RX_BUF_ALLOC_SIZE,
+						     DMA_FROM_DEVICE));
 			skb_reserve(new_skb, RX_OFFSET);
 
 			/* Trim the original skb for the netif. */
@@ -2049,10 +2053,9 @@ static void happy_meal_rx(struct happy_meal *hp, struct net_device *dev)
 
 			skb_reserve(copy_skb, 2);
 			skb_put(copy_skb, len);
-			hme_dma_sync_for_cpu(hp, dma_addr, len, DMA_FROM_DEVICE);
+			dma_sync_single_for_cpu(hp->dma_dev, dma_addr, len, DMA_FROM_DEVICE);
 			skb_copy_from_linear_data(skb, copy_skb->data, len);
-			hme_dma_sync_for_device(hp, dma_addr, len, DMA_FROM_DEVICE);
-
+			dma_sync_single_for_device(hp->dma_dev, dma_addr, len, DMA_FROM_DEVICE);
 			/* Reuse original ring buffer. */
 			hme_write_rxd(hp, this,
 				      (RXFLAG_OWN|((RX_BUF_ALLOC_SIZE-RX_OFFSET)<<16)),
@@ -2284,7 +2287,7 @@ static int happy_meal_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		u32 mapping, len;
 
 		len = skb->len;
-		mapping = hme_dma_map(hp, skb->data, len, DMA_TO_DEVICE);
+		mapping = dma_map_single(hp->dma_dev, skb->data, len, DMA_TO_DEVICE);
 		tx_flags |= (TXFLAG_SOP | TXFLAG_EOP);
 		hme_write_txd(hp, &hp->happy_block->happy_meal_txd[entry],
 			      (tx_flags | (len & TXFLAG_SIZE)),
@@ -2298,7 +2301,8 @@ static int happy_meal_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		 * Otherwise we could race with the device.
 		 */
 		first_len = skb_headlen(skb);
-		first_mapping = hme_dma_map(hp, skb->data, first_len, DMA_TO_DEVICE);
+		first_mapping = dma_map_single(hp->dma_dev, skb->data, first_len,
+					       DMA_TO_DEVICE);
 		entry = NEXT_TX(entry);
 
 		for (frag = 0; frag < skb_shinfo(skb)->nr_frags; frag++) {
@@ -2306,10 +2310,9 @@ static int happy_meal_start_xmit(struct sk_buff *skb, struct net_device *dev)
 			u32 len, mapping, this_txflags;
 
 			len = this_frag->size;
-			mapping = hme_dma_map(hp,
-					      ((void *) page_address(this_frag->page) +
-					       this_frag->page_offset),
-					      len, DMA_TO_DEVICE);
+			mapping = dma_map_page(hp->dma_dev, this_frag->page,
+					       this_frag->page_offset, len,
+					       DMA_TO_DEVICE);
 			this_txflags = tx_flags;
 			if (frag = skb_shinfo(skb)->nr_frags - 1)
 				this_txflags |= TXFLAG_EOP;
@@ -2477,9 +2480,12 @@ static void hme_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *info
 	}
 #ifdef CONFIG_SBUS
 	else {
-		struct sbus_dev *sdev = hp->happy_dev;
-		sprintf(info->bus_info, "SBUS:%d",
-			sdev->slot);
+		const struct linux_prom_registers *regs;
+		struct of_device *op = hp->happy_dev;
+		regs = of_get_property(op->node, "regs", NULL);
+		if (regs)
+			sprintf(info->bus_info, "SBUS:%d",
+				regs->which_io);
 	}
 #endif
 }
@@ -2505,63 +2511,21 @@ static const struct ethtool_ops hme_ethtool_ops = {
 static int hme_version_printed;
 
 #ifdef CONFIG_SBUS
-void __devinit quattro_get_ranges(struct quattro *qp)
-{
-	struct sbus_dev *sdev = qp->quattro_dev;
-	int err;
-
-	err = prom_getproperty(sdev->prom_node,
-			       "ranges",
-			       (char *)&qp->ranges[0],
-			       sizeof(qp->ranges));
-	if (err = 0 || err = -1) {
-		qp->nranges = 0;
-		return;
-	}
-	qp->nranges = (err / sizeof(struct linux_prom_ranges));
-}
-
-static void __devinit quattro_apply_ranges(struct quattro *qp, struct happy_meal *hp)
-{
-	struct sbus_dev *sdev = hp->happy_dev;
-	int rng;
-
-	for (rng = 0; rng < qp->nranges; rng++) {
-		struct linux_prom_ranges *rngp = &qp->ranges[rng];
-		int reg;
-
-		for (reg = 0; reg < 5; reg++) {
-			if (sdev->reg_addrs[reg].which_io =
-			    rngp->ot_child_space)
-				break;
-		}
-		if (reg = 5)
-			continue;
-
-		sdev->reg_addrs[reg].which_io = rngp->ot_parent_space;
-		sdev->reg_addrs[reg].phys_addr += rngp->ot_parent_base;
-	}
-}
-
 /* Given a happy meal sbus device, find it's quattro parent.
  * If none exist, allocate and return a new one.
  *
  * Return NULL on failure.
  */
-static struct quattro * __devinit quattro_sbus_find(struct sbus_dev *goal_sdev)
+static struct quattro * __devinit quattro_sbus_find(struct of_device *child)
 {
-	struct sbus_dev *sdev;
+	struct device *parent = child->dev.parent;
+	struct of_device *op;
 	struct quattro *qp;
-	int i;
 
-	for (qp = qfe_sbus_list; qp != NULL; qp = qp->next) {
-		for (i = 0, sdev = qp->quattro_dev;
-		     (sdev != NULL) && (i < 4);
-		     sdev = sdev->next, i++) {
-			if (sdev = goal_sdev)
-				return qp;
-		}
-	}
+	op = to_of_device(parent);
+	qp = dev_get_drvdata(&op->dev);
+	if (qp)
+		return qp;
 
 	qp = kmalloc(sizeof(struct quattro), GFP_KERNEL);
 	if (qp != NULL) {
@@ -2570,10 +2534,11 @@ static struct quattro * __devinit quattro_sbus_find(struct sbus_dev *goal_sdev)
 		for (i = 0; i < 4; i++)
 			qp->happy_meals[i] = NULL;
 
-		qp->quattro_dev = goal_sdev;
+		qp->quattro_dev = op;
 		qp->next = qfe_sbus_list;
 		qfe_sbus_list = qp;
-		quattro_get_ranges(qp);
+
+		dev_set_drvdata(&op->dev, qp);
 	}
 	return qp;
 }
@@ -2586,10 +2551,10 @@ static void __init quattro_sbus_register_irqs(void)
 	struct quattro *qp;
 
 	for (qp = qfe_sbus_list; qp != NULL; qp = qp->next) {
-		struct sbus_dev *sdev = qp->quattro_dev;
+		struct of_device *op = qp->quattro_dev;
 		int err;
 
-		err = request_irq(sdev->irqs[0],
+		err = request_irq(op->irqs[0],
 				  quattro_sbus_interrupt,
 				  IRQF_SHARED, "Quattro",
 				  qp);
@@ -2605,9 +2570,9 @@ static void quattro_sbus_free_irqs(void)
 	struct quattro *qp;
 
 	for (qp = qfe_sbus_list; qp != NULL; qp = qp->next) {
-		struct sbus_dev *sdev = qp->quattro_dev;
+		struct of_device *op = qp->quattro_dev;
 
-		free_irq(sdev->irqs[0], qp);
+		free_irq(op->irqs[0], qp);
 	}
 }
 #endif /* CONFIG_SBUS */
@@ -2644,9 +2609,9 @@ static struct quattro * __devinit quattro_pci_find(struct pci_dev *pdev)
 #endif /* CONFIG_PCI */
 
 #ifdef CONFIG_SBUS
-static int __devinit happy_meal_sbus_probe_one(struct sbus_dev *sdev, int is_qfe)
+static int __devinit happy_meal_sbus_probe_one(struct of_device *op, int is_qfe)
 {
-	struct device_node *dp = sdev->ofdev.node;
+	struct device_node *dp = op->node, *sbus_dp;
 	struct quattro *qp = NULL;
 	struct happy_meal *hp;
 	struct net_device *dev;
@@ -2655,7 +2620,7 @@ static int __devinit happy_meal_sbus_probe_one(struct sbus_dev *sdev, int is_qfe
 	DECLARE_MAC_BUF(mac);
 
 	if (is_qfe) {
-		qp = quattro_sbus_find(sdev);
+		qp = quattro_sbus_find(op);
 		if (qp = NULL)
 			goto err_out;
 		for (qfe_slot = 0; qfe_slot < 4; qfe_slot++)
@@ -2669,7 +2634,7 @@ static int __devinit happy_meal_sbus_probe_one(struct sbus_dev *sdev, int is_qfe
 	dev = alloc_etherdev(sizeof(struct happy_meal));
 	if (!dev)
 		goto err_out;
-	SET_NETDEV_DEV(dev, &sdev->ofdev.dev);
+	SET_NETDEV_DEV(dev, &op->dev);
 
 	if (hme_version_printed++ = 0)
 		printk(KERN_INFO "%s", version);
@@ -2697,57 +2662,50 @@ static int __devinit happy_meal_sbus_probe_one(struct sbus_dev *sdev, int is_qfe
 			memcpy(dev->dev_addr, idprom->id_ethaddr, 6);
 	}
 
-	hp = dev->priv;
+	hp = netdev_priv(dev);
 
-	hp->happy_dev = sdev;
-	hp->dma_dev = &sdev->ofdev.dev;
+	hp->happy_dev = op;
+	hp->dma_dev = &op->dev;
 
 	spin_lock_init(&hp->happy_lock);
 
 	err = -ENODEV;
-	if (sdev->num_registers != 5) {
-		printk(KERN_ERR "happymeal: Device needs 5 regs, has %d.\n",
-		       sdev->num_registers);
-		goto err_out_free_netdev;
-	}
-
 	if (qp != NULL) {
 		hp->qfe_parent = qp;
 		hp->qfe_ent = qfe_slot;
 		qp->happy_meals[qfe_slot] = dev;
-		quattro_apply_ranges(qp, hp);
 	}
 
-	hp->gregs = sbus_ioremap(&sdev->resource[0], 0,
-				 GREG_REG_SIZE, "HME Global Regs");
+	hp->gregs = of_ioremap(&op->resource[0], 0,
+			       GREG_REG_SIZE, "HME Global Regs");
 	if (!hp->gregs) {
 		printk(KERN_ERR "happymeal: Cannot map global registers.\n");
 		goto err_out_free_netdev;
 	}
 
-	hp->etxregs = sbus_ioremap(&sdev->resource[1], 0,
-				   ETX_REG_SIZE, "HME TX Regs");
+	hp->etxregs = of_ioremap(&op->resource[1], 0,
+				 ETX_REG_SIZE, "HME TX Regs");
 	if (!hp->etxregs) {
 		printk(KERN_ERR "happymeal: Cannot map MAC TX registers.\n");
 		goto err_out_iounmap;
 	}
 
-	hp->erxregs = sbus_ioremap(&sdev->resource[2], 0,
-				   ERX_REG_SIZE, "HME RX Regs");
+	hp->erxregs = of_ioremap(&op->resource[2], 0,
+				 ERX_REG_SIZE, "HME RX Regs");
 	if (!hp->erxregs) {
 		printk(KERN_ERR "happymeal: Cannot map MAC RX registers.\n");
 		goto err_out_iounmap;
 	}
 
-	hp->bigmacregs = sbus_ioremap(&sdev->resource[3], 0,
-				      BMAC_REG_SIZE, "HME BIGMAC Regs");
+	hp->bigmacregs = of_ioremap(&op->resource[3], 0,
+				    BMAC_REG_SIZE, "HME BIGMAC Regs");
 	if (!hp->bigmacregs) {
 		printk(KERN_ERR "happymeal: Cannot map BIGMAC registers.\n");
 		goto err_out_iounmap;
 	}
 
-	hp->tcvregs = sbus_ioremap(&sdev->resource[4], 0,
-				   TCVR_REG_SIZE, "HME Tranceiver Regs");
+	hp->tcvregs = of_ioremap(&op->resource[4], 0,
+				 TCVR_REG_SIZE, "HME Tranceiver Regs");
 	if (!hp->tcvregs) {
 		printk(KERN_ERR "happymeal: Cannot map TCVR registers.\n");
 		goto err_out_iounmap;
@@ -2766,8 +2724,12 @@ static int __devinit happy_meal_sbus_probe_one(struct sbus_dev *sdev, int is_qfe
 	if (qp != NULL)
 		hp->happy_flags |= HFLAG_QUATTRO;
 
+	sbus_dp = to_of_device(op->dev.parent)->node;
+	if (is_qfe)
+		sbus_dp = to_of_device(op->dev.parent->parent)->node;
+
 	/* Get the supported DVMA burst sizes from our Happy SBUS. */
-	hp->happy_bursts = of_getintprop_default(sdev->bus->ofdev.node,
+	hp->happy_bursts = of_getintprop_default(sbus_dp,
 						 "burst-sizes", 0x00);
 
 	hp->happy_block = dma_alloc_coherent(hp->dma_dev,
@@ -2802,19 +2764,13 @@ static int __devinit happy_meal_sbus_probe_one(struct sbus_dev *sdev, int is_qfe
 	/* Happy Meal can do it all... */
 	dev->features |= NETIF_F_SG | NETIF_F_HW_CSUM;
 
-	dev->irq = sdev->irqs[0];
+	dev->irq = op->irqs[0];
 
 #if defined(CONFIG_SBUS) && defined(CONFIG_PCI)
-	/* Hook up PCI register/dma accessors. */
+	/* Hook up SBUS register/descriptor accessors. */
 	hp->read_desc32 = sbus_hme_read_desc32;
 	hp->write_txd = sbus_hme_write_txd;
 	hp->write_rxd = sbus_hme_write_rxd;
-	hp->dma_map = (u32 (*)(void *, void *, long, int))dma_map_single;
-	hp->dma_unmap = (void (*)(void *, u32, long, int))dma_unmap_single;
-	hp->dma_sync_for_cpu = (void (*)(void *, u32, long, int))
-		dma_sync_single_for_cpu;
-	hp->dma_sync_for_device = (void (*)(void *, u32, long, int))
-		dma_sync_single_for_device;
 	hp->read32 = sbus_hme_read32;
 	hp->write32 = sbus_hme_write32;
 #endif
@@ -2832,7 +2788,7 @@ static int __devinit happy_meal_sbus_probe_one(struct sbus_dev *sdev, int is_qfe
 		goto err_out_free_coherent;
 	}
 
-	dev_set_drvdata(&sdev->ofdev.dev, hp);
+	dev_set_drvdata(&op->dev, hp);
 
 	if (qfe_slot != -1)
 		printk(KERN_INFO "%s: Quattro HME slot %d (SBUS) 10/100baseT Ethernet ",
@@ -2853,15 +2809,15 @@ err_out_free_coherent:
 
 err_out_iounmap:
 	if (hp->gregs)
-		sbus_iounmap(hp->gregs, GREG_REG_SIZE);
+		of_iounmap(&op->resource[0], hp->gregs, GREG_REG_SIZE);
 	if (hp->etxregs)
-		sbus_iounmap(hp->etxregs, ETX_REG_SIZE);
+		of_iounmap(&op->resource[1], hp->etxregs, ETX_REG_SIZE);
 	if (hp->erxregs)
-		sbus_iounmap(hp->erxregs, ERX_REG_SIZE);
+		of_iounmap(&op->resource[2], hp->erxregs, ERX_REG_SIZE);
 	if (hp->bigmacregs)
-		sbus_iounmap(hp->bigmacregs, BMAC_REG_SIZE);
+		of_iounmap(&op->resource[3], hp->bigmacregs, BMAC_REG_SIZE);
 	if (hp->tcvregs)
-		sbus_iounmap(hp->tcvregs, TCVR_REG_SIZE);
+		of_iounmap(&op->resource[4], hp->tcvregs, TCVR_REG_SIZE);
 
 err_out_free_netdev:
 	free_netdev(dev);
@@ -3021,7 +2977,7 @@ static int __devinit happy_meal_pci_probe(struct pci_dev *pdev,
 	memset(hp, 0, sizeof(*hp));
 
 	hp->happy_dev = pdev;
-	hp->dma_dev = pdev;
+	hp->dma_dev = &pdev->dev;
 
 	spin_lock_init(&hp->happy_lock);
 
@@ -3108,7 +3064,7 @@ static int __devinit happy_meal_pci_probe(struct pci_dev *pdev,
 #endif
 
 	hp->happy_block = (struct hmeal_init_block *)
-		pci_alloc_consistent(pdev, PAGE_SIZE, &hp->hblock_dvma);
+		dma_alloc_coherent(&pdev->dev, PAGE_SIZE, &hp->hblock_dvma, GFP_KERNEL);
 
 	err = -ENODEV;
 	if (!hp->happy_block) {
@@ -3138,16 +3094,10 @@ static int __devinit happy_meal_pci_probe(struct pci_dev *pdev,
 	dev->features |= NETIF_F_SG | NETIF_F_HW_CSUM;
 
 #if defined(CONFIG_SBUS) && defined(CONFIG_PCI)
-	/* Hook up PCI register/dma accessors. */
+	/* Hook up PCI register/descriptor accessors. */
 	hp->read_desc32 = pci_hme_read_desc32;
 	hp->write_txd = pci_hme_write_txd;
 	hp->write_rxd = pci_hme_write_rxd;
-	hp->dma_map = (u32 (*)(void *, void *, long, int))pci_map_single;
-	hp->dma_unmap = (void (*)(void *, u32, long, int))pci_unmap_single;
-	hp->dma_sync_for_cpu = (void (*)(void *, u32, long, int))
-		pci_dma_sync_single_for_cpu;
-	hp->dma_sync_for_device = (void (*)(void *, u32, long, int))
-		pci_dma_sync_single_for_device;
 	hp->read32 = pci_hme_read32;
 	hp->write32 = pci_hme_write32;
 #endif
@@ -3218,12 +3168,10 @@ static void __devexit happy_meal_pci_remove(struct pci_dev *pdev)
 
 	unregister_netdev(net_dev);
 
-	pci_free_consistent(hp->dma_dev,
-			    PAGE_SIZE,
-			    hp->happy_block,
-			    hp->hblock_dvma);
+	dma_free_coherent(hp->dma_dev, PAGE_SIZE,
+			  hp->happy_block, hp->hblock_dvma);
 	iounmap(hp->gregs);
-	pci_release_regions(hp->dma_dev);
+	pci_release_regions(hp->happy_dev);
 
 	free_netdev(net_dev);
 
@@ -3266,33 +3214,32 @@ static void happy_meal_pci_exit(void)
 #endif
 
 #ifdef CONFIG_SBUS
-static int __devinit hme_sbus_probe(struct of_device *dev, const struct of_device_id *match)
+static int __devinit hme_sbus_probe(struct of_device *op, const struct of_device_id *match)
 {
-	struct sbus_dev *sdev = to_sbus_device(&dev->dev);
-	struct device_node *dp = dev->node;
+	struct device_node *dp = op->node;
 	const char *model = of_get_property(dp, "model", NULL);
 	int is_qfe = (match->data != NULL);
 
 	if (!is_qfe && model && !strcmp(model, "SUNW,sbus-qfe"))
 		is_qfe = 1;
 
-	return happy_meal_sbus_probe_one(sdev, is_qfe);
+	return happy_meal_sbus_probe_one(op, is_qfe);
 }
 
-static int __devexit hme_sbus_remove(struct of_device *dev)
+static int __devexit hme_sbus_remove(struct of_device *op)
 {
-	struct happy_meal *hp = dev_get_drvdata(&dev->dev);
+	struct happy_meal *hp = dev_get_drvdata(&op->dev);
 	struct net_device *net_dev = hp->dev;
 
 	unregister_netdev(net_dev);
 
 	/* XXX qfe parent interrupt... */
 
-	sbus_iounmap(hp->gregs, GREG_REG_SIZE);
-	sbus_iounmap(hp->etxregs, ETX_REG_SIZE);
-	sbus_iounmap(hp->erxregs, ERX_REG_SIZE);
-	sbus_iounmap(hp->bigmacregs, BMAC_REG_SIZE);
-	sbus_iounmap(hp->tcvregs, TCVR_REG_SIZE);
+	of_iounmap(&op->resource[0], hp->gregs, GREG_REG_SIZE);
+	of_iounmap(&op->resource[1], hp->etxregs, ETX_REG_SIZE);
+	of_iounmap(&op->resource[2], hp->erxregs, ERX_REG_SIZE);
+	of_iounmap(&op->resource[3], hp->bigmacregs, BMAC_REG_SIZE);
+	of_iounmap(&op->resource[4], hp->tcvregs, TCVR_REG_SIZE);
 	dma_free_coherent(hp->dma_dev,
 			  PAGE_SIZE,
 			  hp->happy_block,
@@ -3300,7 +3247,7 @@ static int __devexit hme_sbus_remove(struct of_device *dev)
 
 	free_netdev(net_dev);
 
-	dev_set_drvdata(&dev->dev, NULL);
+	dev_set_drvdata(&op->dev, NULL);
 
 	return 0;
 }
@@ -3333,7 +3280,7 @@ static int __init happy_meal_sbus_init(void)
 {
 	int err;
 
-	err = of_register_driver(&hme_sbus_driver, &sbus_bus_type);
+	err = of_register_driver(&hme_sbus_driver, &of_bus_type);
 	if (!err)
 		quattro_sbus_register_irqs();
 
diff --git a/drivers/net/sunhme.h b/drivers/net/sunhme.h
index 756e96e..efd2ca0 100644
--- a/drivers/net/sunhme.h
+++ b/drivers/net/sunhme.h
@@ -405,15 +405,11 @@ struct happy_meal {
 	u32 (*read_desc32)(hme32 *);
 	void (*write_txd)(struct happy_meal_txd *, u32, u32);
 	void (*write_rxd)(struct happy_meal_rxd *, u32, u32);
-	u32 (*dma_map)(void *, void *, long, int);
-	void (*dma_unmap)(void *, u32, long, int);
-	void (*dma_sync_for_cpu)(void *, u32, long, int);
-	void (*dma_sync_for_device)(void *, u32, long, int);
 #endif
 
-	/* This is either a sbus_dev or a pci_dev. */
+	/* This is either an of_device or a pci_dev. */
 	void			  *happy_dev;
-	void			  *dma_dev;
+	struct device		  *dma_dev;
 
 	spinlock_t		  happy_lock;
 
-- 
1.5.6.5.GIT

