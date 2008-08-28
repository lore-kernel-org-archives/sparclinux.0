From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:23:56 +0000
Subject: [PATCH 14/49]: sunlance: Convert to pure OF driver.
Message-Id: <20080827.212356.92435125.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sunlance: Convert to pure OF driver.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/net/sunlance.c |   87 ++++++++++++++++++++++--------------------------
 1 files changed, 40 insertions(+), 47 deletions(-)

diff --git a/drivers/net/sunlance.c b/drivers/net/sunlance.c
index 6575888..292feb2 100644
--- a/drivers/net/sunlance.c
+++ b/drivers/net/sunlance.c
@@ -92,6 +92,8 @@ static char lancestr[] = "LANCE";
 #include <linux/ethtool.h>
 #include <linux/bitops.h>
 #include <linux/dma-mapping.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
@@ -99,7 +101,6 @@ static char lancestr[] = "LANCE";
 #include <asm/pgtable.h>
 #include <asm/byteorder.h>	/* Used by the checksum routines */
 #include <asm/idprom.h>
-#include <asm/sbus.h>
 #include <asm/prom.h>
 #include <asm/auxio.h>		/* For tpe-link-test? setting */
 #include <asm/irq.h>
@@ -264,7 +265,8 @@ struct lance_private {
 	char	       	       *name;
 	dma_addr_t		init_block_dvma;
 	struct net_device      *dev;		  /* Backpointer	*/
-	struct sbus_dev	       *sdev;
+	struct of_device       *op;
+	struct of_device       *lebuffer;
 	struct timer_list       multicast_timer;
 };
 
@@ -1273,7 +1275,7 @@ static void lance_set_multicast_retry(unsigned long _opaque)
 static void lance_free_hwresources(struct lance_private *lp)
 {
 	if (lp->lregs)
-		sbus_iounmap(lp->lregs, LANCE_REG_SIZE);
+		of_iounmap(&lp->op->resource[0], lp->lregs, LANCE_REG_SIZE);
 	if (lp->dregs) {
 		struct of_device *ledma = lp->ledma;
 
@@ -1281,10 +1283,10 @@ static void lance_free_hwresources(struct lance_private *lp)
 			   resource_size(&ledma->resource[0]));
 	}
 	if (lp->init_block_iomem) {
-		sbus_iounmap(lp->init_block_iomem,
-			     sizeof(struct lance_init_block));
+		of_iounmap(&lp->lebuffer->resource[0], lp->init_block_iomem,
+			   sizeof(struct lance_init_block));
 	} else if (lp->init_block_mem) {
-		dma_free_coherent(&lp->sdev->ofdev.dev,
+		dma_free_coherent(&lp->op->dev,
 				  sizeof(struct lance_init_block),
 				  lp->init_block_mem,
 				  lp->init_block_dvma);
@@ -1294,12 +1296,8 @@ static void lance_free_hwresources(struct lance_private *lp)
 /* Ethtool support... */
 static void sparc_lance_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *info)
 {
-	struct lance_private *lp = netdev_priv(dev);
-
 	strcpy(info->driver, "sunlance");
 	strcpy(info->version, "2.02");
-	sprintf(info->bus_info, "SBUS:%d",
-		lp->sdev->slot);
 }
 
 static u32 sparc_lance_get_link(struct net_device *dev)
@@ -1315,16 +1313,16 @@ static const struct ethtool_ops sparc_lance_ethtool_ops = {
 	.get_link		= sparc_lance_get_link,
 };
 
-static int __devinit sparc_lance_probe_one(struct sbus_dev *sdev,
+static int __devinit sparc_lance_probe_one(struct of_device *op,
 					   struct of_device *ledma,
-					   struct sbus_dev *lebuffer)
+					   struct of_device *lebuffer)
 {
+	struct device_node *dp = op->node;
 	static unsigned version_printed;
-	struct device_node *dp = sdev->ofdev.node;
-	struct net_device *dev;
 	struct lance_private *lp;
-	int    i;
+	struct net_device *dev;
 	DECLARE_MAC_BUF(mac);
+	int    i;
 
 	dev = alloc_etherdev(sizeof(struct lance_private) + 8);
 	if (!dev)
@@ -1345,8 +1343,8 @@ static int __devinit sparc_lance_probe_one(struct sbus_dev *sdev,
 		dev->dev_addr[i] = idprom->id_ethaddr[i];
 
 	/* Get the IO region */
-	lp->lregs = sbus_ioremap(&sdev->resource[0], 0,
-				 LANCE_REG_SIZE, lancestr);
+	lp->lregs = of_ioremap(&op->resource[0], 0,
+			       LANCE_REG_SIZE, lancestr);
 	if (!lp->lregs) {
 		printk(KERN_ERR "SunLance: Cannot map registers.\n");
 		goto fail;
@@ -1364,7 +1362,8 @@ static int __devinit sparc_lance_probe_one(struct sbus_dev *sdev,
 		}
 	}
 
-	lp->sdev = sdev;
+	lp->op = op;
+	lp->lebuffer = lebuffer;
 	if (lebuffer) {
 		/* sanity check */
 		if (lebuffer->resource[0].start & 7) {
@@ -1372,8 +1371,8 @@ static int __devinit sparc_lance_probe_one(struct sbus_dev *sdev,
 			goto fail;
 		}
 		lp->init_block_iomem -			sbus_ioremap(&lebuffer->resource[0], 0,
-				     sizeof(struct lance_init_block), "lebuffer");
+			of_ioremap(&lebuffer->resource[0], 0,
+				   sizeof(struct lance_init_block), "lebuffer");
 		if (!lp->init_block_iomem) {
 			printk(KERN_ERR "SunLance: Cannot map PIO buffer.\n");
 			goto fail;
@@ -1385,10 +1384,10 @@ static int __devinit sparc_lance_probe_one(struct sbus_dev *sdev,
 		lp->tx = lance_tx_pio;
 	} else {
 		lp->init_block_mem -			dma_alloc_coherent(&sdev->ofdev.dev,
+			dma_alloc_coherent(&op->dev,
 					   sizeof(struct lance_init_block),
 					   &lp->init_block_dvma, GFP_ATOMIC);
-		if (!lp->init_block_mem || lp->init_block_dvma = 0) {
+		if (!lp->init_block_mem) {
 			printk(KERN_ERR "SunLance: Cannot allocate consistent DMA memory.\n");
 			goto fail;
 		}
@@ -1407,8 +1406,9 @@ static int __devinit sparc_lance_probe_one(struct sbus_dev *sdev,
 	lp->burst_sizes = 0;
 	if (lp->ledma) {
 		struct device_node *ledma_dp = ledma->node;
-		const char *prop;
+		struct device_node *sbus_dp;
 		unsigned int sbmask;
+		const char *prop;
 		u32 csr;
 
 		/* Find burst-size property for ledma */
@@ -1416,7 +1416,8 @@ static int __devinit sparc_lance_probe_one(struct sbus_dev *sdev,
 							"burst-sizes", 0);
 
 		/* ledma may be capable of fast bursts, but sbus may not. */
-		sbmask = of_getintprop_default(ledma_dp, "burst-sizes",
+		sbus_dp = ledma_dp->parent;
+		sbmask = of_getintprop_default(sbus_dp, "burst-sizes",
 					       DMA_BURSTBITS);
 		lp->burst_sizes &= sbmask;
 
@@ -1463,7 +1464,7 @@ no_link_test:
 		lp->dregs = NULL;
 
 	lp->dev = dev;
-	SET_NETDEV_DEV(dev, &sdev->ofdev.dev);
+	SET_NETDEV_DEV(dev, &op->dev);
 	dev->open = &lance_open;
 	dev->stop = &lance_close;
 	dev->hard_start_xmit = &lance_start_xmit;
@@ -1472,9 +1473,7 @@ no_link_test:
 	dev->set_multicast_list = &lance_set_multicast;
 	dev->ethtool_ops = &sparc_lance_ethtool_ops;
 
-	dev->irq = sdev->irqs[0];
-
-	dev->dma = 0;
+	dev->irq = op->irqs[0];
 
 	/* We cannot sleep if the chip is busy during a
 	 * multicast list update event, because such events
@@ -1490,7 +1489,7 @@ no_link_test:
 		goto fail;
 	}
 
-	dev_set_drvdata(&sdev->ofdev.dev, lp);
+	dev_set_drvdata(&op->dev, lp);
 
 	printk(KERN_INFO "%s: LANCE %s\n",
 	       dev->name, print_mac(mac, dev->dev_addr));
@@ -1540,31 +1539,25 @@ static int __exit sunlance_sun4_remove(void)
 
 #else /* !CONFIG_SUN4 */
 
-static int __devinit sunlance_sbus_probe(struct of_device *dev, const struct of_device_id *match)
+static int __devinit sunlance_sbus_probe(struct of_device *op, const struct of_device_id *match)
 {
-	struct sbus_dev *sdev = to_sbus_device(&dev->dev);
+	struct of_device *parent = to_of_device(op->dev.parent);
+	struct device_node *parent_dp = parent->node;
 	int err;
 
-	if (sdev->parent) {
-		struct device_node *parent_node = sdev->parent->ofdev.node;
-		struct of_device *parent;
-
-		parent = of_find_device_by_node(parent_node);
-		if (parent && !strcmp(parent->node->name, "ledma")) {
-			err = sparc_lance_probe_one(sdev, parent, NULL);
-		} else if (parent && !strcmp(parent->node->name, "lebuffer")) {
-			err = sparc_lance_probe_one(sdev, NULL, to_sbus_device(&parent->dev));
-		} else
-			err = sparc_lance_probe_one(sdev, NULL, NULL);
+	if (!strcmp(parent_dp->name, "ledma")) {
+		err = sparc_lance_probe_one(op, parent, NULL);
+	} else if (!strcmp(parent_dp->name, "lebuffer")) {
+		err = sparc_lance_probe_one(op, NULL, parent);
 	} else
-		err = sparc_lance_probe_one(sdev, NULL, NULL);
+		err = sparc_lance_probe_one(op, NULL, NULL);
 
 	return err;
 }
 
-static int __devexit sunlance_sbus_remove(struct of_device *dev)
+static int __devexit sunlance_sbus_remove(struct of_device *op)
 {
-	struct lance_private *lp = dev_get_drvdata(&dev->dev);
+	struct lance_private *lp = dev_get_drvdata(&op->dev);
 	struct net_device *net_dev = lp->dev;
 
 	unregister_netdev(net_dev);
@@ -1573,7 +1566,7 @@ static int __devexit sunlance_sbus_remove(struct of_device *dev)
 
 	free_netdev(net_dev);
 
-	dev_set_drvdata(&dev->dev, NULL);
+	dev_set_drvdata(&op->dev, NULL);
 
 	return 0;
 }
@@ -1598,7 +1591,7 @@ static struct of_platform_driver sunlance_sbus_driver = {
 /* Find all the lance cards on the system and initialize them */
 static int __init sparc_lance_init(void)
 {
-	return of_register_driver(&sunlance_sbus_driver, &sbus_bus_type);
+	return of_register_driver(&sunlance_sbus_driver, &of_bus_type);
 }
 #endif /* !CONFIG_SUN4 */
 
-- 
1.5.6.5.GIT

