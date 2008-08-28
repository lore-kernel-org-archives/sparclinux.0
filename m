From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:23:45 +0000
Subject: [PATCH 11/49]: myri_sbus: Convert to pure OF driver.
Message-Id: <20080827.212345.239454702.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


myri_sbus: Convert to pure OF driver.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/net/myri_sbus.c |  156 ++++++++++++++++++++--------------------------
 drivers/net/myri_sbus.h |    2 +-
 2 files changed, 69 insertions(+), 89 deletions(-)

diff --git a/drivers/net/myri_sbus.c b/drivers/net/myri_sbus.c
index f2a3ff2..03867b1 100644
--- a/drivers/net/myri_sbus.c
+++ b/drivers/net/myri_sbus.c
@@ -1,6 +1,6 @@
 /* myri_sbus.c: MyriCOM MyriNET SBUS card driver.
  *
- * Copyright (C) 1996, 1999, 2006 David S. Miller (davem@davemloft.net)
+ * Copyright (C) 1996, 1999, 2006, 2008 David S. Miller (davem@davemloft.net)
  */
 
 static char version[] @@ -23,6 +23,8 @@ static char version[]  #include <linux/skbuff.h>
 #include <linux/bitops.h>
 #include <linux/dma-mapping.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <net/dst.h>
 #include <net/arp.h>
@@ -34,7 +36,6 @@ static char version[]  #include <asm/dma.h>
 #include <asm/byteorder.h>
 #include <asm/idprom.h>
-#include <asm/sbus.h>
 #include <asm/openprom.h>
 #include <asm/oplib.h>
 #include <asm/auxio.h>
@@ -244,7 +245,7 @@ static void myri_clean_rings(struct myri_eth *mp)
 			u32 dma_addr;
 
 			dma_addr = sbus_readl(&rxd->myri_scatters[0].addr);
-			dma_unmap_single(&mp->myri_sdev->ofdev.dev, dma_addr,
+			dma_unmap_single(&mp->myri_op->dev, dma_addr,
 					 RX_ALLOC_SIZE, DMA_FROM_DEVICE);
 			dev_kfree_skb(mp->rx_skbs[i]);
 			mp->rx_skbs[i] = NULL;
@@ -261,7 +262,7 @@ static void myri_clean_rings(struct myri_eth *mp)
 			u32 dma_addr;
 
 			dma_addr = sbus_readl(&txd->myri_gathers[0].addr);
-			dma_unmap_single(&mp->myri_sdev->ofdev.dev, dma_addr,
+			dma_unmap_single(&mp->myri_op->dev, dma_addr,
 					 (skb->len + 3) & ~3,
 					 DMA_TO_DEVICE);
 			dev_kfree_skb(mp->tx_skbs[i]);
@@ -292,7 +293,7 @@ static void myri_init_rings(struct myri_eth *mp, int from_irq)
 		skb->dev = dev;
 		skb_put(skb, RX_ALLOC_SIZE);
 
-		dma_addr = dma_map_single(&mp->myri_sdev->ofdev.dev,
+		dma_addr = dma_map_single(&mp->myri_op->dev,
 					  skb->data, RX_ALLOC_SIZE,
 					  DMA_FROM_DEVICE);
 		sbus_writel(dma_addr, &rxd[i].myri_scatters[0].addr);
@@ -350,7 +351,7 @@ static void myri_tx(struct myri_eth *mp, struct net_device *dev)
 
 		DTX(("SKB[%d] ", entry));
 		dma_addr = sbus_readl(&sq->myri_txd[entry].myri_gathers[0].addr);
-		dma_unmap_single(&mp->myri_sdev->ofdev.dev, dma_addr,
+		dma_unmap_single(&mp->myri_op->dev, dma_addr,
 				 skb->len, DMA_TO_DEVICE);
 		dev_kfree_skb(skb);
 		mp->tx_skbs[entry] = NULL;
@@ -430,7 +431,7 @@ static void myri_rx(struct myri_eth *mp, struct net_device *dev)
 
 		/* Check for errors. */
 		DRX(("rxd[%d]: %p len[%d] csum[%08x] ", entry, rxd, len, csum));
-		dma_sync_single_for_cpu(&mp->myri_sdev->ofdev.dev,
+		dma_sync_single_for_cpu(&mp->myri_op->dev,
 					sbus_readl(&rxd->myri_scatters[0].addr),
 					RX_ALLOC_SIZE, DMA_FROM_DEVICE);
 		if (len < (ETH_HLEN + MYRI_PAD_LEN) || (skb->data[0] != MYRI_PAD_LEN)) {
@@ -449,7 +450,7 @@ static void myri_rx(struct myri_eth *mp, struct net_device *dev)
 			drops++;
 			DRX(("DROP "));
 			dev->stats.rx_dropped++;
-			dma_sync_single_for_device(&mp->myri_sdev->ofdev.dev,
+			dma_sync_single_for_device(&mp->myri_op->dev,
 						   sbus_readl(&rxd->myri_scatters[0].addr),
 						   RX_ALLOC_SIZE,
 						   DMA_FROM_DEVICE);
@@ -471,14 +472,14 @@ static void myri_rx(struct myri_eth *mp, struct net_device *dev)
 				DRX(("skb_alloc(FAILED) "));
 				goto drop_it;
 			}
-			dma_unmap_single(&mp->myri_sdev->ofdev.dev,
+			dma_unmap_single(&mp->myri_op->dev,
 					 sbus_readl(&rxd->myri_scatters[0].addr),
 					 RX_ALLOC_SIZE,
 					 DMA_FROM_DEVICE);
 			mp->rx_skbs[index] = new_skb;
 			new_skb->dev = dev;
 			skb_put(new_skb, RX_ALLOC_SIZE);
-			dma_addr = dma_map_single(&mp->myri_sdev->ofdev.dev,
+			dma_addr = dma_map_single(&mp->myri_op->dev,
 						  new_skb->data,
 						  RX_ALLOC_SIZE,
 						  DMA_FROM_DEVICE);
@@ -507,7 +508,7 @@ static void myri_rx(struct myri_eth *mp, struct net_device *dev)
 
 			/* Reuse original ring buffer. */
 			DRX(("reuse "));
-			dma_sync_single_for_device(&mp->myri_sdev->ofdev.dev,
+			dma_sync_single_for_device(&mp->myri_op->dev,
 						   sbus_readl(&rxd->myri_scatters[0].addr),
 						   RX_ALLOC_SIZE,
 						   DMA_FROM_DEVICE);
@@ -659,7 +660,7 @@ static int myri_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		sbus_writew((skb->data[4] << 8) | skb->data[5], &txd->addr[3]);
 	}
 
-	dma_addr = dma_map_single(&mp->myri_sdev->ofdev.dev, skb->data,
+	dma_addr = dma_map_single(&mp->myri_op->dev, skb->data,
 				  len, DMA_TO_DEVICE);
 	sbus_writel(dma_addr, &txd->myri_gathers[0].addr);
 	sbus_writel(len, &txd->myri_gathers[0].len);
@@ -899,30 +900,30 @@ static const struct header_ops myri_header_ops = {
 	.cache_update	= myri_header_cache_update,
 };
 
-static int __devinit myri_ether_init(struct sbus_dev *sdev)
+static int __devinit myri_sbus_probe(struct of_device *op, const struct of_device_id *match)
 {
-	static int num;
+	struct device_node *dp = op->node;
 	static unsigned version_printed;
 	struct net_device *dev;
-	struct myri_eth *mp;
-	unsigned char prop_buf[32];
-	int i;
 	DECLARE_MAC_BUF(mac);
+	struct myri_eth *mp;
+	const void *prop;
+	static int num;
+	int i, len;
 
-	DET(("myri_ether_init(%p,%d):\n", sdev, num));
+	DET(("myri_ether_init(%p,%d):\n", op, num));
 	dev = alloc_etherdev(sizeof(struct myri_eth));
-
 	if (!dev)
 		return -ENOMEM;
 
 	if (version_printed++ = 0)
 		printk(version);
 
-	SET_NETDEV_DEV(dev, &sdev->ofdev.dev);
+	SET_NETDEV_DEV(dev, &op->dev);
 
-	mp = (struct myri_eth *) dev->priv;
+	mp = netdev_priv(dev);
 	spin_lock_init(&mp->irq_lock);
-	mp->myri_sdev = sdev;
+	mp->myri_op = op;
 
 	/* Clean out skb arrays. */
 	for (i = 0; i < (RX_RING_SIZE + 1); i++)
@@ -932,55 +933,44 @@ static int __devinit myri_ether_init(struct sbus_dev *sdev)
 		mp->tx_skbs[i] = NULL;
 
 	/* First check for EEPROM information. */
-	i = prom_getproperty(sdev->prom_node, "myrinet-eeprom-info",
-			     (char *)&mp->eeprom, sizeof(struct myri_eeprom));
-	DET(("prom_getprop(myrinet-eeprom-info) returns %d\n", i));
-	if (i = 0 || i = -1) {
+	prop = of_get_property(dp, "myrinet-eeprom-info", &len);
+
+	if (prop)
+		memcpy(&mp->eeprom, prop, sizeof(struct myri_eeprom));
+	if (!prop) {
 		/* No eeprom property, must cook up the values ourselves. */
 		DET(("No EEPROM: "));
 		mp->eeprom.bus_type = BUS_TYPE_SBUS;
-		mp->eeprom.cpuvers = prom_getintdefault(sdev->prom_node,"cpu_version",0);
-		mp->eeprom.cval = prom_getintdefault(sdev->prom_node,"clock_value",0);
-		mp->eeprom.ramsz = prom_getintdefault(sdev->prom_node,"sram_size",0);
-		DET(("cpuvers[%d] cval[%d] ramsz[%d]\n", mp->eeprom.cpuvers,
-		     mp->eeprom.cval, mp->eeprom.ramsz));
-		if (mp->eeprom.cpuvers = 0) {
-			DET(("EEPROM: cpuvers was zero, setting to %04x\n",CPUVERS_2_3));
+		mp->eeprom.cpuvers +			of_getintprop_default(dp, "cpu_version", 0);
+		mp->eeprom.cval +			of_getintprop_default(dp, "clock_value", 0);
+		mp->eeprom.ramsz = of_getintprop_default(dp, "sram_size", 0);
+		if (!mp->eeprom.cpuvers)
 			mp->eeprom.cpuvers = CPUVERS_2_3;
-		}
-		if (mp->eeprom.cpuvers < CPUVERS_3_0) {
-			DET(("EEPROM: cpuvers < CPUVERS_3_0, clockval set to zero.\n"));
+		if (mp->eeprom.cpuvers < CPUVERS_3_0)
 			mp->eeprom.cval = 0;
-		}
-		if (mp->eeprom.ramsz = 0) {
-			DET(("EEPROM: ramsz = 0, setting to 128k\n"));
+		if (!mp->eeprom.ramsz)
 			mp->eeprom.ramsz = (128 * 1024);
-		}
-		i = prom_getproperty(sdev->prom_node, "myrinet-board-id",
-				     &prop_buf[0], 10);
-		DET(("EEPROM: prom_getprop(myrinet-board-id) returns %d\n", i));
-		if ((i != 0) && (i != -1))
-			memcpy(&mp->eeprom.id[0], &prop_buf[0], 6);
+
+		prop = of_get_property(dp, "myrinet-board-id", &len);
+		if (prop)
+			memcpy(&mp->eeprom.id[0], prop, 6);
 		else
 			set_boardid_from_idprom(mp, num);
-		i = prom_getproperty(sdev->prom_node, "fpga_version",
-				     &mp->eeprom.fvers[0], 32);
-		DET(("EEPROM: prom_getprop(fpga_version) returns %d\n", i));
-		if (i = 0 || i = -1)
+
+		prop = of_get_property(dp, "fpga_version", &len);
+		if (prop)
+			memcpy(&mp->eeprom.fvers[0], prop, 32);
+		else
 			memset(&mp->eeprom.fvers[0], 0, 32);
 
 		if (mp->eeprom.cpuvers = CPUVERS_4_1) {
-			DET(("EEPROM: cpuvers CPUVERS_4_1, "));
-			if (mp->eeprom.ramsz = (128 * 1024)) {
-				DET(("ramsize 128k, setting to 256k, "));
+			if (mp->eeprom.ramsz = (128 * 1024))
 				mp->eeprom.ramsz = (256 * 1024);
-			}
-			if ((mp->eeprom.cval=0x40414041)||(mp->eeprom.cval=0x90449044)){
-				DET(("changing cval from %08x to %08x ",
-				     mp->eeprom.cval, 0x50e450e4));
+			if ((mp->eeprom.cval = 0x40414041) ||
+			    (mp->eeprom.cval = 0x90449044))
 				mp->eeprom.cval = 0x50e450e4;
-			}
-			DET(("\n"));
 		}
 	}
 #ifdef DEBUG_DETECT
@@ -999,8 +989,8 @@ static int __devinit myri_ether_init(struct sbus_dev *sdev)
 		 * XXX only a valid version for PCI cards?  Ask feldy...
 		 */
 		DET(("Mapping regs for cpuvers < CPUVERS_4_0\n"));
-		mp->regs = sbus_ioremap(&sdev->resource[0], 0,
-					mp->reg_size, "MyriCOM Regs");
+		mp->regs = of_ioremap(&op->resource[0], 0,
+				      mp->reg_size, "MyriCOM Regs");
 		if (!mp->regs) {
 			printk("MyriCOM: Cannot map MyriCOM registers.\n");
 			goto err;
@@ -1009,13 +999,12 @@ static int __devinit myri_ether_init(struct sbus_dev *sdev)
 		mp->lregs = mp->lanai + (0x10000 * 2);
 	} else {
 		DET(("Mapping regs for cpuvers >= CPUVERS_4_0\n"));
-		mp->cregs = sbus_ioremap(&sdev->resource[0], 0,
-					 PAGE_SIZE, "MyriCOM Control Regs");
-		mp->lregs = sbus_ioremap(&sdev->resource[0], (256 * 1024),
+		mp->cregs = of_ioremap(&op->resource[0], 0,
+				       PAGE_SIZE, "MyriCOM Control Regs");
+		mp->lregs = of_ioremap(&op->resource[0], (256 * 1024),
 					 PAGE_SIZE, "MyriCOM LANAI Regs");
-		mp->lanai -			sbus_ioremap(&sdev->resource[0], (512 * 1024),
-				     mp->eeprom.ramsz, "MyriCOM SRAM");
+		mp->lanai = of_ioremap(&op->resource[0], (512 * 1024),
+				       mp->eeprom.ramsz, "MyriCOM SRAM");
 	}
 	DET(("Registers mapped: cregs[%p] lregs[%p] lanai[%p]\n",
 	     mp->cregs, mp->lregs, mp->lanai));
@@ -1047,16 +1036,15 @@ static int __devinit myri_ether_init(struct sbus_dev *sdev)
 	myri_reset_on(mp->cregs);
 
 	/* Get the supported DVMA burst sizes from our SBUS. */
-	mp->myri_bursts = prom_getintdefault(mp->myri_sdev->bus->prom_node,
-					     "burst-sizes", 0x00);
-
+	mp->myri_bursts = of_getintprop_default(dp->parent,
+						"burst-sizes", 0x00);
 	if (!sbus_can_burst64())
 		mp->myri_bursts &= ~(DMA_BURST64);
 
 	DET(("MYRI bursts %02x\n", mp->myri_bursts));
 
 	/* Encode SBUS interrupt level in second control register. */
-	i = prom_getint(sdev->prom_node, "interrupts");
+	i = of_getintprop_default(dp, "interrupts", 0);
 	if (i = 0)
 		i = 4;
 	DET(("prom_getint(interrupts)=%d, irqlvl set to %04x\n",
@@ -1071,7 +1059,7 @@ static int __devinit myri_ether_init(struct sbus_dev *sdev)
 	dev->tx_timeout = &myri_tx_timeout;
 	dev->watchdog_timeo = 5*HZ;
 	dev->set_multicast_list = &myri_set_multicast;
-	dev->irq = sdev->irqs[0];
+	dev->irq = op->irqs[0];
 
 	/* Register interrupt handler now. */
 	DET(("Requesting MYRIcom IRQ line.\n"));
@@ -1096,7 +1084,7 @@ static int __devinit myri_ether_init(struct sbus_dev *sdev)
 		goto err_free_irq;
 	}
 
-	dev_set_drvdata(&sdev->ofdev.dev, mp);
+	dev_set_drvdata(&op->dev, mp);
 
 	num++;
 
@@ -1113,17 +1101,9 @@ err:
 	return -ENODEV;
 }
 
-
-static int __devinit myri_sbus_probe(struct of_device *dev, const struct of_device_id *match)
-{
-	struct sbus_dev *sdev = to_sbus_device(&dev->dev);
-
-	return myri_ether_init(sdev);
-}
-
-static int __devexit myri_sbus_remove(struct of_device *dev)
+static int __devexit myri_sbus_remove(struct of_device *op)
 {
-	struct myri_eth *mp = dev_get_drvdata(&dev->dev);
+	struct myri_eth *mp = dev_get_drvdata(&op->dev);
 	struct net_device *net_dev = mp->dev;
 
 	unregister_netdevice(net_dev);
@@ -1131,16 +1111,16 @@ static int __devexit myri_sbus_remove(struct of_device *dev)
 	free_irq(net_dev->irq, net_dev);
 
 	if (mp->eeprom.cpuvers < CPUVERS_4_0) {
-		sbus_iounmap(mp->regs, mp->reg_size);
+		of_iounmap(&op->resource[0], mp->regs, mp->reg_size);
 	} else {
-		sbus_iounmap(mp->cregs, PAGE_SIZE);
-		sbus_iounmap(mp->lregs, (256 * 1024));
-		sbus_iounmap(mp->lanai, (512 * 1024));
+		of_iounmap(&op->resource[0], mp->cregs, PAGE_SIZE);
+		of_iounmap(&op->resource[0], mp->lregs, (256 * 1024));
+		of_iounmap(&op->resource[0], mp->lanai, (512 * 1024));
 	}
 
 	free_netdev(net_dev);
 
-	dev_set_drvdata(&dev->dev, NULL);
+	dev_set_drvdata(&op->dev, NULL);
 
 	return 0;
 }
@@ -1166,7 +1146,7 @@ static struct of_platform_driver myri_sbus_driver = {
 
 static int __init myri_sbus_init(void)
 {
-	return of_register_driver(&myri_sbus_driver, &sbus_bus_type);
+	return of_register_driver(&myri_sbus_driver, &of_bus_type);
 }
 
 static void __exit myri_sbus_exit(void)
diff --git a/drivers/net/myri_sbus.h b/drivers/net/myri_sbus.h
index 5d93fcc..ff363e9 100644
--- a/drivers/net/myri_sbus.h
+++ b/drivers/net/myri_sbus.h
@@ -288,7 +288,7 @@ struct myri_eth {
 	struct myri_eeprom		eeprom;		/* Local copy of EEPROM.      */
 	unsigned int			reg_size;	/* Size of register space.    */
 	unsigned int			shmem_base;	/* Offset to shared ram.      */
-	struct sbus_dev			*myri_sdev;	/* Our SBUS device struct.    */
+	struct of_device		*myri_op;	/* Our OF device struct.    */
 };
 
 /* We use this to acquire receive skb's that we can DMA directly into. */
-- 
1.5.6.5.GIT

