From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:24:04 +0000
Subject: [PATCH 18/49]: qlogicpti: Convert to pure OF driver.
Message-Id: <20080827.212404.234390718.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


qlogicpti: Convert to pure OF driver.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/scsi/qlogicpti.c |  108 +++++++++++++++++++++++----------------------
 drivers/scsi/qlogicpti.h |    2 +-
 2 files changed, 56 insertions(+), 54 deletions(-)

diff --git a/drivers/scsi/qlogicpti.c b/drivers/scsi/qlogicpti.c
index e16c56c..b6ce82d 100644
--- a/drivers/scsi/qlogicpti.c
+++ b/drivers/scsi/qlogicpti.c
@@ -1,6 +1,6 @@
 /* qlogicpti.c: Performance Technologies QlogicISP sbus card driver.
  *
- * Copyright (C) 1996, 2006 David S. Miller (davem@davemloft.net)
+ * Copyright (C) 1996, 2006, 2008 David S. Miller (davem@davemloft.net)
  *
  * A lot of this driver was directly stolen from Erik H. Moe's PCI
  * Qlogic ISP driver.  Mucho kudos to him for this code.
@@ -26,12 +26,13 @@
 #include <linux/module.h>
 #include <linux/jiffies.h>
 #include <linux/dma-mapping.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <asm/byteorder.h>
 
 #include "qlogicpti.h"
 
-#include <asm/sbus.h>
 #include <asm/dma.h>
 #include <asm/system.h>
 #include <asm/ptrace.h>
@@ -685,19 +686,19 @@ static void __devexit qpti_chain_del(struct qlogicpti *qpti)
 
 static int __devinit qpti_map_regs(struct qlogicpti *qpti)
 {
-	struct sbus_dev *sdev = qpti->sdev;
+	struct of_device *op = qpti->op;
 
-	qpti->qregs = sbus_ioremap(&sdev->resource[0], 0,
-				   sdev->reg_addrs[0].reg_size,
-				   "PTI Qlogic/ISP");
+	qpti->qregs = of_ioremap(&op->resource[0], 0,
+				 resource_size(&op->resource[0]),
+				 "PTI Qlogic/ISP");
 	if (!qpti->qregs) {
 		printk("PTI: Qlogic/ISP registers are unmappable\n");
 		return -1;
 	}
 	if (qpti->is_pti) {
-		qpti->sreg = sbus_ioremap(&sdev->resource[0], (16 * 4096),
-					  sizeof(unsigned char),
-					  "PTI Qlogic/ISP statreg");
+		qpti->sreg = of_ioremap(&op->resource[0], (16 * 4096),
+					sizeof(unsigned char),
+					"PTI Qlogic/ISP statreg");
 		if (!qpti->sreg) {
 			printk("PTI: Qlogic/ISP status register is unmappable\n");
 			return -1;
@@ -708,9 +709,9 @@ static int __devinit qpti_map_regs(struct qlogicpti *qpti)
 
 static int __devinit qpti_register_irq(struct qlogicpti *qpti)
 {
-	struct sbus_dev *sdev = qpti->sdev;
+	struct of_device *op = qpti->op;
 
-	qpti->qhost->irq = qpti->irq = sdev->irqs[0];
+	qpti->qhost->irq = qpti->irq = op->irqs[0];
 
 	/* We used to try various overly-clever things to
 	 * reduce the interrupt processing overhead on
@@ -733,17 +734,19 @@ fail:
 
 static void __devinit qpti_get_scsi_id(struct qlogicpti *qpti)
 {
-	qpti->scsi_id = prom_getintdefault(qpti->prom_node,
-					   "initiator-id",
-					   -1);
+	struct of_device *op = qpti->op;
+	struct device_node *dp;
+
+	dp = op->node;
+
+	qpti->scsi_id = of_getintprop_default(dp, "initiator-id", -1);
 	if (qpti->scsi_id = -1)
-		qpti->scsi_id = prom_getintdefault(qpti->prom_node,
-						   "scsi-initiator-id",
-						   -1);
+		qpti->scsi_id = of_getintprop_default(dp, "scsi-initiator-id",
+						      -1);
 	if (qpti->scsi_id = -1)
 		qpti->scsi_id -			prom_getintdefault(qpti->sdev->bus->prom_node,
-					   "scsi-initiator-id", 7);
+			of_getintprop_default(dp->parent,
+					      "scsi-initiator-id", 7);
 	qpti->qhost->this_id = qpti->scsi_id;
 	qpti->qhost->max_sectors = 64;
 
@@ -752,12 +755,11 @@ static void __devinit qpti_get_scsi_id(struct qlogicpti *qpti)
 
 static void qpti_get_bursts(struct qlogicpti *qpti)
 {
-	struct sbus_dev *sdev = qpti->sdev;
+	struct of_device *op = qpti->op;
 	u8 bursts, bmask;
 
-	bursts = prom_getintdefault(qpti->prom_node, "burst-sizes", 0xff);
-	bmask = prom_getintdefault(sdev->bus->prom_node,
-				   "burst-sizes", 0xff);
+	bursts = of_getintprop_default(op->node, "burst-sizes", 0xff);
+	bmask = of_getintprop_default(op->node->parent, "burst-sizes", 0xff);
 	if (bmask != 0xff)
 		bursts &= bmask;
 	if (bursts = 0xff ||
@@ -786,10 +788,10 @@ static void qpti_get_clock(struct qlogicpti *qpti)
  */
 static int __devinit qpti_map_queues(struct qlogicpti *qpti)
 {
-	struct sbus_dev *sdev = qpti->sdev;
+	struct of_device *op = qpti->op;
 
 #define QSIZE(entries)	(((entries) + 1) * QUEUE_ENTRY_LEN)
-	qpti->res_cpu = dma_alloc_coherent(&sdev->ofdev.dev,
+	qpti->res_cpu = dma_alloc_coherent(&op->dev,
 					   QSIZE(RES_QUEUE_LEN),
 					   &qpti->res_dvma, GFP_ATOMIC);
 	if (qpti->res_cpu = NULL ||
@@ -798,12 +800,12 @@ static int __devinit qpti_map_queues(struct qlogicpti *qpti)
 		return -1;
 	}
 
-	qpti->req_cpu = dma_alloc_coherent(&sdev->ofdev.dev,
+	qpti->req_cpu = dma_alloc_coherent(&op->dev,
 					   QSIZE(QLOGICPTI_REQ_QUEUE_LEN),
 					   &qpti->req_dvma, GFP_ATOMIC);
 	if (qpti->req_cpu = NULL ||
 	    qpti->req_dvma = 0) {
-		dma_free_coherent(&sdev->ofdev.dev, QSIZE(RES_QUEUE_LEN),
+		dma_free_coherent(&op->dev, QSIZE(RES_QUEUE_LEN),
 				  qpti->res_cpu, qpti->res_dvma);
 		printk("QPTI: Cannot map request queue.\n");
 		return -1;
@@ -876,7 +878,7 @@ static inline int load_cmd(struct scsi_cmnd *Cmnd, struct Command_Entry *cmd,
 		int sg_count;
 
 		sg = scsi_sglist(Cmnd);
-		sg_count = dma_map_sg(&qpti->sdev->ofdev.dev, sg,
+		sg_count = dma_map_sg(&qpti->op->dev, sg,
 				      scsi_sg_count(Cmnd),
 				      Cmnd->sc_data_direction);
 
@@ -1153,7 +1155,7 @@ static struct scsi_cmnd *qlogicpti_intr_handler(struct qlogicpti *qpti)
 			Cmnd->result = DID_ERROR << 16;
 
 		if (scsi_bufflen(Cmnd))
-			dma_unmap_sg(&qpti->sdev->ofdev.dev,
+			dma_unmap_sg(&qpti->op->dev,
 				     scsi_sglist(Cmnd), scsi_sg_count(Cmnd),
 				     Cmnd->sc_data_direction);
 
@@ -1269,34 +1271,32 @@ static struct scsi_host_template qpti_template = {
 	.use_clustering		= ENABLE_CLUSTERING,
 };
 
-static int __devinit qpti_sbus_probe(struct of_device *dev, const struct of_device_id *match)
+static int __devinit qpti_sbus_probe(struct of_device *op, const struct of_device_id *match)
 {
-	static int nqptis;
-	struct sbus_dev *sdev = to_sbus_device(&dev->dev);
-	struct device_node *dp = dev->node;
 	struct scsi_host_template *tpnt = match->data;
+	struct device_node *dp = op->node;
 	struct Scsi_Host *host;
 	struct qlogicpti *qpti;
+	static int nqptis;
 	const char *fcode;
 
 	/* Sometimes Antares cards come up not completely
 	 * setup, and we get a report of a zero IRQ.
 	 */
-	if (sdev->irqs[0] = 0)
+	if (op->irqs[0] = 0)
 		return -ENODEV;
 
 	host = scsi_host_alloc(tpnt, sizeof(struct qlogicpti));
 	if (!host)
 		return -ENOMEM;
 
-	qpti = (struct qlogicpti *) host->hostdata;
+	qpti = shost_priv(host);
 
 	host->max_id = MAX_TARGETS;
 	qpti->qhost = host;
-	qpti->sdev = sdev;
+	qpti->op = op;
 	qpti->qpti_id = nqptis;
-	qpti->prom_node = sdev->prom_node;
-	strcpy(qpti->prom_name, sdev->ofdev.node->name);
+	strcpy(qpti->prom_name, op->node->name);
 	qpti->is_pti = strcmp(qpti->prom_name, "QLGC,isp");
 
 	if (qpti_map_regs(qpti) < 0)
@@ -1342,12 +1342,12 @@ static int __devinit qpti_sbus_probe(struct of_device *dev, const struct of_devi
 		(qpti->ultra ? "Ultra" : "Fast"),
 		(qpti->differential ? "differential" : "single ended"));
 
-	if (scsi_add_host(host, &dev->dev)) {
+	if (scsi_add_host(host, &op->dev)) {
 		printk("qlogicpti%d: Failed scsi_add_host\n", qpti->qpti_id);
 		goto fail_unmap_queues;
 	}
 
-	dev_set_drvdata(&sdev->ofdev.dev, qpti);
+	dev_set_drvdata(&op->dev, qpti);
 
 	qpti_chain_add(qpti);
 
@@ -1358,19 +1358,20 @@ static int __devinit qpti_sbus_probe(struct of_device *dev, const struct of_devi
 
 fail_unmap_queues:
 #define QSIZE(entries)	(((entries) + 1) * QUEUE_ENTRY_LEN)
-	dma_free_coherent(&qpti->sdev->ofdev.dev,
+	dma_free_coherent(&op->dev,
 			  QSIZE(RES_QUEUE_LEN),
 			  qpti->res_cpu, qpti->res_dvma);
-	dma_free_coherent(&qpti->sdev->ofdev.dev,
+	dma_free_coherent(&op->dev,
 			  QSIZE(QLOGICPTI_REQ_QUEUE_LEN),
 			  qpti->req_cpu, qpti->req_dvma);
 #undef QSIZE
 
 fail_unmap_regs:
-	sbus_iounmap(qpti->qregs,
-		     qpti->sdev->reg_addrs[0].reg_size);
+	of_iounmap(&op->resource[0], qpti->qregs,
+		   resource_size(&op->resource[0]));
 	if (qpti->is_pti)
-		sbus_iounmap(qpti->sreg, sizeof(unsigned char));
+		of_iounmap(&op->resource[0], qpti->sreg,
+			   sizeof(unsigned char));
 
 fail_free_irq:
 	free_irq(qpti->irq, qpti);
@@ -1381,9 +1382,9 @@ fail_unlink:
 	return -ENODEV;
 }
 
-static int __devexit qpti_sbus_remove(struct of_device *dev)
+static int __devexit qpti_sbus_remove(struct of_device *op)
 {
-	struct qlogicpti *qpti = dev_get_drvdata(&dev->dev);
+	struct qlogicpti *qpti = dev_get_drvdata(&op->dev);
 
 	qpti_chain_del(qpti);
 
@@ -1396,17 +1397,18 @@ static int __devexit qpti_sbus_remove(struct of_device *dev)
 	free_irq(qpti->irq, qpti);
 
 #define QSIZE(entries)	(((entries) + 1) * QUEUE_ENTRY_LEN)
-	dma_free_coherent(&qpti->sdev->ofdev.dev,
+	dma_free_coherent(&op->dev,
 			  QSIZE(RES_QUEUE_LEN),
 			  qpti->res_cpu, qpti->res_dvma);
-	dma_free_coherent(&qpti->sdev->ofdev.dev,
+	dma_free_coherent(&op->dev,
 			  QSIZE(QLOGICPTI_REQ_QUEUE_LEN),
 			  qpti->req_cpu, qpti->req_dvma);
 #undef QSIZE
 
-	sbus_iounmap(qpti->qregs, qpti->sdev->reg_addrs[0].reg_size);
+	of_iounmap(&op->resource[0], qpti->qregs,
+		   resource_size(&op->resource[0]));
 	if (qpti->is_pti)
-		sbus_iounmap(qpti->sreg, sizeof(unsigned char));
+		of_iounmap(&op->resource[0], qpti->sreg, sizeof(unsigned char));
 
 	scsi_host_put(qpti->qhost);
 
@@ -1443,7 +1445,7 @@ static struct of_platform_driver qpti_sbus_driver = {
 
 static int __init qpti_init(void)
 {
-	return of_register_driver(&qpti_sbus_driver, &sbus_bus_type);
+	return of_register_driver(&qpti_sbus_driver, &of_bus_type);
 }
 
 static void __exit qpti_exit(void)
@@ -1454,7 +1456,7 @@ static void __exit qpti_exit(void)
 MODULE_DESCRIPTION("QlogicISP SBUS driver");
 MODULE_AUTHOR("David S. Miller (davem@davemloft.net)");
 MODULE_LICENSE("GPL");
-MODULE_VERSION("2.0");
+MODULE_VERSION("2.1");
 
 module_init(qpti_init);
 module_exit(qpti_exit);
diff --git a/drivers/scsi/qlogicpti.h b/drivers/scsi/qlogicpti.h
index ef6da2d..9c053bb 100644
--- a/drivers/scsi/qlogicpti.h
+++ b/drivers/scsi/qlogicpti.h
@@ -342,7 +342,7 @@ struct qlogicpti {
 	u_int	                  req_in_ptr;		/* index of next request slot */
 	u_int	                  res_out_ptr;		/* index of next result slot  */
 	long	                  send_marker;		/* must we send a marker?     */
-	struct sbus_dev		 *sdev;
+	struct of_device	 *op;
 	unsigned long		  __pad;
 
 	int                       cmd_count[MAX_TARGETS];
-- 
1.5.6.5.GIT

