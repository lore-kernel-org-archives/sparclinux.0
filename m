From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:23:57 +0000
Subject: [PATCH 15/49]: sunqe: Convert to pure OF driver.
Message-Id: <20080827.212357.66816794.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sunqe: Convert to pure OF driver.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/net/sunqe.c |  147 ++++++++++++++++++++++++---------------------------
 drivers/net/sunqe.h |    4 +-
 2 files changed, 71 insertions(+), 80 deletions(-)

diff --git a/drivers/net/sunqe.c b/drivers/net/sunqe.c
index 4521972..81604ca 100644
--- a/drivers/net/sunqe.c
+++ b/drivers/net/sunqe.c
@@ -3,7 +3,7 @@
  *          controller out there can be most efficiently programmed
  *          if you make it look like a LANCE.
  *
- * Copyright (C) 1996, 1999, 2003, 2006 David S. Miller (davem@davemloft.net)
+ * Copyright (C) 1996, 1999, 2003, 2006, 2008 David S. Miller (davem@davemloft.net)
  */
 
 #include <linux/module.h>
@@ -25,13 +25,14 @@
 #include <linux/ethtool.h>
 #include <linux/bitops.h>
 #include <linux/dma-mapping.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
 #include <asm/dma.h>
 #include <asm/byteorder.h>
 #include <asm/idprom.h>
-#include <asm/sbus.h>
 #include <asm/openprom.h>
 #include <asm/oplib.h>
 #include <asm/auxio.h>
@@ -41,8 +42,8 @@
 #include "sunqe.h"
 
 #define DRV_NAME	"sunqe"
-#define DRV_VERSION	"4.0"
-#define DRV_RELDATE	"June 23, 2006"
+#define DRV_VERSION	"4.1"
+#define DRV_RELDATE	"August 27, 2008"
 #define DRV_AUTHOR	"David S. Miller (davem@davemloft.net)"
 
 static char version[] @@ -691,12 +692,18 @@ static void qe_set_multicast(struct net_device *dev)
 /* Ethtool support... */
 static void qe_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *info)
 {
+	const struct linux_prom_registers *regs;
 	struct sunqe *qep = dev->priv;
+	struct of_device *op;
 
 	strcpy(info->driver, "sunqe");
 	strcpy(info->version, "3.0");
-	sprintf(info->bus_info, "SBUS:%d",
-		qep->qe_sdev->slot);
+
+	op = qep->op;
+	regs = of_get_property(op->node, "reg", NULL);
+	if (regs)
+		sprintf(info->bus_info, "SBUS:%d", regs->which_io);
+
 }
 
 static u32 qe_get_link(struct net_device *dev)
@@ -718,7 +725,7 @@ static const struct ethtool_ops qe_ethtool_ops = {
 };
 
 /* This is only called once at boot time for each card probed. */
-static inline void qec_init_once(struct sunqec *qecp, struct sbus_dev *qsdev)
+static void qec_init_once(struct sunqec *qecp, struct of_device *op)
 {
 	u8 bsizes = qecp->qec_bursts;
 
@@ -736,15 +743,15 @@ static inline void qec_init_once(struct sunqec *qecp, struct sbus_dev *qsdev)
 	sbus_writel(GLOB_PSIZE_2048, qecp->gregs + GLOB_PSIZE);
 
 	/* Set the local memsize register, divided up to one piece per QE channel. */
-	sbus_writel((qsdev->reg_addrs[1].reg_size >> 2),
+	sbus_writel((resource_size(&op->resource[1]) >> 2),
 		    qecp->gregs + GLOB_MSIZE);
 
 	/* Divide up the local QEC memory amongst the 4 QE receiver and
 	 * transmitter FIFOs.  Basically it is (total / 2 / num_channels).
 	 */
-	sbus_writel((qsdev->reg_addrs[1].reg_size >> 2) >> 1,
+	sbus_writel((resource_size(&op->resource[1]) >> 2) >> 1,
 		    qecp->gregs + GLOB_TSIZE);
-	sbus_writel((qsdev->reg_addrs[1].reg_size >> 2) >> 1,
+	sbus_writel((resource_size(&op->resource[1]) >> 2) >> 1,
 		    qecp->gregs + GLOB_RSIZE);
 }
 
@@ -768,24 +775,21 @@ static u8 __devinit qec_get_burst(struct device_node *dp)
 	return bsizes;
 }
 
-static struct sunqec * __devinit get_qec(struct sbus_dev *child_sdev)
+static struct sunqec * __devinit get_qec(struct of_device *child)
 {
-	struct sbus_dev *qec_sdev = child_sdev->parent;
+	struct of_device *op = to_of_device(child->dev.parent);
 	struct sunqec *qecp;
 
-	for (qecp = root_qec_dev; qecp; qecp = qecp->next_module) {
-		if (qecp->qec_sdev = qec_sdev)
-			break;
-	}
+	qecp = dev_get_drvdata(&op->dev);
 	if (!qecp) {
 		qecp = kzalloc(sizeof(struct sunqec), GFP_KERNEL);
 		if (qecp) {
 			u32 ctrl;
 
-			qecp->qec_sdev = qec_sdev;
-			qecp->gregs = sbus_ioremap(&qec_sdev->resource[0], 0,
-						   GLOB_REG_SIZE,
-						   "QEC Global Registers");
+			qecp->op = op;
+			qecp->gregs = of_ioremap(&op->resource[0], 0,
+						 GLOB_REG_SIZE,
+						 "QEC Global Registers");
 			if (!qecp->gregs)
 				goto fail;
 
@@ -800,16 +804,18 @@ static struct sunqec * __devinit get_qec(struct sbus_dev *child_sdev)
 			if (qec_global_reset(qecp->gregs))
 				goto fail;
 
-			qecp->qec_bursts = qec_get_burst(qec_sdev->ofdev.node);
+			qecp->qec_bursts = qec_get_burst(op->node);
 
-			qec_init_once(qecp, qec_sdev);
+			qec_init_once(qecp, op);
 
-			if (request_irq(qec_sdev->irqs[0], &qec_interrupt,
+			if (request_irq(op->irqs[0], &qec_interrupt,
 					IRQF_SHARED, "qec", (void *) qecp)) {
 				printk(KERN_ERR "qec: Can't register irq.\n");
 				goto fail;
 			}
 
+			dev_set_drvdata(&op->dev, qecp);
+
 			qecp->next_module = root_qec_dev;
 			root_qec_dev = qecp;
 		}
@@ -819,17 +825,17 @@ static struct sunqec * __devinit get_qec(struct sbus_dev *child_sdev)
 
 fail:
 	if (qecp->gregs)
-		sbus_iounmap(qecp->gregs, GLOB_REG_SIZE);
+		of_iounmap(&op->resource[0], qecp->gregs, GLOB_REG_SIZE);
 	kfree(qecp);
 	return NULL;
 }
 
-static int __devinit qec_ether_init(struct sbus_dev *sdev)
+static int __devinit qec_ether_init(struct of_device *op)
 {
 	static unsigned version_printed;
 	struct net_device *dev;
-	struct sunqe *qe;
 	struct sunqec *qecp;
+	struct sunqe *qe;
 	int i, res;
 
 	if (version_printed++ = 0)
@@ -843,48 +849,41 @@ static int __devinit qec_ether_init(struct sbus_dev *sdev)
 
 	qe = netdev_priv(dev);
 
-	i = of_getintprop_default(sdev->ofdev.node, "channel#", -1);
-	if (i = -1) {
-		struct sbus_dev *td = sdev->parent->child;
-		i = 0;
-		while (td != sdev) {
-			td = td->next;
-			i++;
-		}
-	}
+	res = -ENODEV;
+
+	i = of_getintprop_default(op->node, "channel#", -1);
+	if (i = -1)
+		goto fail;
 	qe->channel = i;
 	spin_lock_init(&qe->lock);
 
-	res = -ENODEV;
-	qecp = get_qec(sdev);
+	qecp = get_qec(op);
 	if (!qecp)
 		goto fail;
 
 	qecp->qes[qe->channel] = qe;
 	qe->dev = dev;
 	qe->parent = qecp;
-	qe->qe_sdev = sdev;
+	qe->op = op;
 
 	res = -ENOMEM;
-	qe->qcregs = sbus_ioremap(&qe->qe_sdev->resource[0], 0,
-				  CREG_REG_SIZE, "QEC Channel Registers");
+	qe->qcregs = of_ioremap(&op->resource[0], 0,
+				CREG_REG_SIZE, "QEC Channel Registers");
 	if (!qe->qcregs) {
 		printk(KERN_ERR "qe: Cannot map channel registers.\n");
 		goto fail;
 	}
 
-	qe->mregs = sbus_ioremap(&qe->qe_sdev->resource[1], 0,
-				 MREGS_REG_SIZE, "QE MACE Registers");
+	qe->mregs = of_ioremap(&op->resource[1], 0,
+			       MREGS_REG_SIZE, "QE MACE Registers");
 	if (!qe->mregs) {
 		printk(KERN_ERR "qe: Cannot map MACE registers.\n");
 		goto fail;
 	}
 
-	qe->qe_block = dma_alloc_coherent(&qe->qe_sdev->ofdev.dev,
-					  PAGE_SIZE,
+	qe->qe_block = dma_alloc_coherent(&op->dev, PAGE_SIZE,
 					  &qe->qblock_dvma, GFP_ATOMIC);
-	qe->buffers = dma_alloc_coherent(&qe->qe_sdev->ofdev.dev,
-					 sizeof(struct sunqe_buffers),
+	qe->buffers = dma_alloc_coherent(&op->dev, sizeof(struct sunqe_buffers),
 					 &qe->buffers_dvma, GFP_ATOMIC);
 	if (qe->qe_block = NULL || qe->qblock_dvma = 0 ||
 	    qe->buffers = NULL || qe->buffers_dvma = 0)
@@ -893,7 +892,7 @@ static int __devinit qec_ether_init(struct sbus_dev *sdev)
 	/* Stop this QE. */
 	qe_stop(qe);
 
-	SET_NETDEV_DEV(dev, &sdev->ofdev.dev);
+	SET_NETDEV_DEV(dev, &op->dev);
 
 	dev->open = qe_open;
 	dev->stop = qe_close;
@@ -901,7 +900,7 @@ static int __devinit qec_ether_init(struct sbus_dev *sdev)
 	dev->set_multicast_list = qe_set_multicast;
 	dev->tx_timeout = qe_tx_timeout;
 	dev->watchdog_timeo = 5*HZ;
-	dev->irq = sdev->irqs[0];
+	dev->irq = op->irqs[0];
 	dev->dma = 0;
 	dev->ethtool_ops = &qe_ethtool_ops;
 
@@ -909,7 +908,7 @@ static int __devinit qec_ether_init(struct sbus_dev *sdev)
 	if (res)
 		goto fail;
 
-	dev_set_drvdata(&sdev->ofdev.dev, qe);
+	dev_set_drvdata(&op->dev, qe);
 
 	printk(KERN_INFO "%s: qe channel[%d] ", dev->name, qe->channel);
 	for (i = 0; i < 6; i++)
@@ -923,16 +922,14 @@ static int __devinit qec_ether_init(struct sbus_dev *sdev)
 
 fail:
 	if (qe->qcregs)
-		sbus_iounmap(qe->qcregs, CREG_REG_SIZE);
+		of_iounmap(&op->resource[0], qe->qcregs, CREG_REG_SIZE);
 	if (qe->mregs)
-		sbus_iounmap(qe->mregs, MREGS_REG_SIZE);
+		of_iounmap(&op->resource[1], qe->mregs, MREGS_REG_SIZE);
 	if (qe->qe_block)
-		dma_free_coherent(&qe->qe_sdev->ofdev.dev,
-				  PAGE_SIZE,
-				  qe->qe_block,
-				  qe->qblock_dvma);
+		dma_free_coherent(&op->dev, PAGE_SIZE,
+				  qe->qe_block, qe->qblock_dvma);
 	if (qe->buffers)
-		dma_free_coherent(&qe->qe_sdev->ofdev.dev,
+		dma_free_coherent(&op->dev,
 				  sizeof(struct sunqe_buffers),
 				  qe->buffers,
 				  qe->buffers_dvma);
@@ -942,34 +939,28 @@ fail:
 	return res;
 }
 
-static int __devinit qec_sbus_probe(struct of_device *dev, const struct of_device_id *match)
+static int __devinit qec_sbus_probe(struct of_device *op, const struct of_device_id *match)
 {
-	struct sbus_dev *sdev = to_sbus_device(&dev->dev);
-
-	return qec_ether_init(sdev);
+	return qec_ether_init(op);
 }
 
-static int __devexit qec_sbus_remove(struct of_device *dev)
+static int __devexit qec_sbus_remove(struct of_device *op)
 {
-	struct sunqe *qp = dev_get_drvdata(&dev->dev);
+	struct sunqe *qp = dev_get_drvdata(&op->dev);
 	struct net_device *net_dev = qp->dev;
 
 	unregister_netdev(net_dev);
 
-	sbus_iounmap(qp->qcregs, CREG_REG_SIZE);
-	sbus_iounmap(qp->mregs, MREGS_REG_SIZE);
-	dma_free_coherent(&qp->qe_sdev->ofdev.dev,
-			  PAGE_SIZE,
-			  qp->qe_block,
-			  qp->qblock_dvma);
-	dma_free_coherent(&qp->qe_sdev->ofdev.dev,
-			  sizeof(struct sunqe_buffers),
-			  qp->buffers,
-			  qp->buffers_dvma);
+	of_iounmap(&op->resource[0], qp->qcregs, CREG_REG_SIZE);
+	of_iounmap(&op->resource[1], qp->mregs, MREGS_REG_SIZE);
+	dma_free_coherent(&op->dev, PAGE_SIZE,
+			  qp->qe_block, qp->qblock_dvma);
+	dma_free_coherent(&op->dev, sizeof(struct sunqe_buffers),
+			  qp->buffers, qp->buffers_dvma);
 
 	free_netdev(net_dev);
 
-	dev_set_drvdata(&dev->dev, NULL);
+	dev_set_drvdata(&op->dev, NULL);
 
 	return 0;
 }
@@ -992,7 +983,7 @@ static struct of_platform_driver qec_sbus_driver = {
 
 static int __init qec_init(void)
 {
-	return of_register_driver(&qec_sbus_driver, &sbus_bus_type);
+	return of_register_driver(&qec_sbus_driver, &of_bus_type);
 }
 
 static void __exit qec_exit(void)
@@ -1001,11 +992,11 @@ static void __exit qec_exit(void)
 
 	while (root_qec_dev) {
 		struct sunqec *next = root_qec_dev->next_module;
+		struct of_device *op = root_qec_dev->op;
 
-		free_irq(root_qec_dev->qec_sdev->irqs[0],
-			 (void *) root_qec_dev);
-		sbus_iounmap(root_qec_dev->gregs, GLOB_REG_SIZE);
-
+		free_irq(op->irqs[0], (void *) root_qec_dev);
+		of_iounmap(&op->resource[0], root_qec_dev->gregs,
+			   GLOB_REG_SIZE);
 		kfree(root_qec_dev);
 
 		root_qec_dev = next;
diff --git a/drivers/net/sunqe.h b/drivers/net/sunqe.h
index 347c8dd..5813a7b 100644
--- a/drivers/net/sunqe.h
+++ b/drivers/net/sunqe.h
@@ -314,7 +314,7 @@ struct sunqec {
 	void __iomem		*gregs;		/* QEC Global Registers         */
 	struct sunqe		*qes[4];	/* Each child MACE              */
 	unsigned int            qec_bursts;	/* Support burst sizes          */
-	struct sbus_dev		*qec_sdev;	/* QEC's SBUS device            */
+	struct of_device	*op;		/* QEC's OF device              */
 	struct sunqec		*next_module;	/* List of all QECs in system   */
 };
 
@@ -342,7 +342,7 @@ struct sunqe {
 	__u32				buffers_dvma;	/* DVMA visible address.       */
 	struct sunqec			*parent;
 	u8				mconfig;	/* Base MACE mconfig value     */
-	struct sbus_dev			*qe_sdev;	/* QE's SBUS device struct     */
+	struct of_device		*op;		/* QE's OF device struct       */
 	struct net_device		*dev;		/* QE's netdevice struct       */
 	int				channel;	/* Who am I?                   */
 };
-- 
1.5.6.5.GIT

