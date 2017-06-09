From: Jag Raman <jag.raman@oracle.com>
Date: Fri, 09 Jun 2017 16:30:59 +0000
Subject: [PATCH v1 10/12] sparc64: enhance VIO device probing
Message-Id: <7d4210189f4b634bfab3fc43b917309b25b49ed9.1497024216.git.jag.raman@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

- Allocate IRQs for VIO devices during probing.
- Allow clients to specify if IRQs would be allocated for a given
  VIO device.
- Cache the device handle of the root node of channel-devices sub-tree in
  Machine Description (MDESC).

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 arch/sparc/include/asm/vio.h |    5 ++++
 arch/sparc/kernel/vio.c      |   53 +++++++++++++++++++++++++++++------------
 2 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/arch/sparc/include/asm/vio.h b/arch/sparc/include/asm/vio.h
index 69cb3a5..d8eb195 100644
--- a/arch/sparc/include/asm/vio.h
+++ b/arch/sparc/include/asm/vio.h
@@ -336,6 +336,10 @@ struct vio_dev {
 	unsigned int		tx_irq;
 	unsigned int		rx_irq;
 	u64			rx_ino;
+	u64			tx_ino;
+
+	/* Handle to the root of "channel-devices" sub-tree in MDESC */
+	u64			cdev_handle;
 
 	struct device		dev;
 };
@@ -349,6 +353,7 @@ struct vio_driver {
 	void (*shutdown)(struct vio_dev *dev);
 	unsigned long			driver_data;
 	struct device_driver		driver;
+	bool				no_irq;
 };
 
 struct vio_version {
diff --git a/arch/sparc/kernel/vio.c b/arch/sparc/kernel/vio.c
index e142708..7d2e00e 100644
--- a/arch/sparc/kernel/vio.c
+++ b/arch/sparc/kernel/vio.c
@@ -70,15 +70,26 @@ static int vio_device_probe(struct device *dev)
 	struct vio_dev *vdev = to_vio_dev(dev);
 	struct vio_driver *drv = to_vio_driver(dev->driver);
 	const struct vio_device_id *id;
-	int error = -ENODEV;
 
-	if (drv->probe) {
-		id = vio_match_device(drv->id_table, vdev);
-		if (id)
-			error = drv->probe(vdev, id);
+	if (!drv->probe)
+		return -ENODEV;
+
+	id = vio_match_device(drv->id_table, vdev);
+	if (!id)
+		return -ENODEV;
+
+	/* alloc irqs (unless the driver specified not to) */
+	if (!drv->no_irq) {
+		if (vdev->tx_irq = 0 && vdev->tx_ino != ~0UL)
+			vdev->tx_irq = sun4v_build_virq(vdev->cdev_handle,
+							vdev->tx_ino);
+
+		if (vdev->rx_irq = 0 && vdev->rx_ino != ~0UL)
+			vdev->rx_irq = sun4v_build_virq(vdev->cdev_handle,
+							vdev->rx_ino);
 	}
 
-	return error;
+	return drv->probe(vdev, id);
 }
 
 static int vio_device_remove(struct device *dev)
@@ -86,8 +97,15 @@ static int vio_device_remove(struct device *dev)
 	struct vio_dev *vdev = to_vio_dev(dev);
 	struct vio_driver *drv = to_vio_driver(dev->driver);
 
-	if (drv->remove)
+	if (drv->remove) {
+		/*
+		 * Ideally, we would remove/deallocate tx/rx virqs
+		 * here - however, there are currently no support
+		 * routines to do so at the moment. TBD
+		 */
+
 		return drv->remove(vdev);
+	}
 
 	return 1;
 }
@@ -204,6 +222,9 @@ static void vio_fill_channel_info(struct mdesc_handle *hp, u64 mp,
 {
 	u64 a;
 
+	vdev->tx_ino = ~0UL;
+	vdev->rx_ino = ~0UL;
+	vdev->channel_id = ~0UL;
 	mdesc_for_each_arc(a, hp, mp, MDESC_ARC_TYPE_FWD) {
 		const u64 *chan_id;
 		const u64 *irq;
@@ -213,18 +234,18 @@ static void vio_fill_channel_info(struct mdesc_handle *hp, u64 mp,
 
 		irq = mdesc_get_property(hp, target, "tx-ino", NULL);
 		if (irq)
-			vdev->tx_irq = sun4v_build_virq(cdev_cfg_handle, *irq);
+			vdev->tx_ino = *irq;
 
 		irq = mdesc_get_property(hp, target, "rx-ino", NULL);
-		if (irq) {
-			vdev->rx_irq = sun4v_build_virq(cdev_cfg_handle, *irq);
+		if (irq)
 			vdev->rx_ino = *irq;
-		}
 
 		chan_id = mdesc_get_property(hp, target, "id", NULL);
 		if (chan_id)
 			vdev->channel_id = *chan_id;
 	}
+
+	vdev->cdev_handle = cdev_cfg_handle;
 }
 
 int vio_set_intr(unsigned long dev_ino, int state)
@@ -286,9 +307,8 @@ int vio_set_intr(unsigned long dev_ino, int state)
 		memset(vdev->compat, 0, sizeof(vdev->compat));
 	vdev->compat_len = clen;
 
-	vdev->channel_id = ~0UL;
-	vdev->tx_irq = ~0;
-	vdev->rx_irq = ~0;
+	vdev->tx_irq = 0;
+	vdev->rx_irq = 0;
 
 	vio_fill_channel_info(hp, mp, vdev);
 
@@ -326,13 +346,14 @@ int vio_set_intr(unsigned long dev_ino, int state)
 	}
 	vdev->dp = dp;
 
-	printk(KERN_INFO "VIO: Adding device %s\n", dev_name(&vdev->dev));
-
 	/* node_name is NULL for the parent/channel-devices node */
 	if (node_name != NULL)
 		(void) snprintf(vdev->node_name, VIO_MAX_NAME_LEN, "%s",
 				node_name);
 
+	pr_info("VIO: Adding device %s (tx_ino = %llx, rx_ino = %llx)\n",
+		dev_name(&vdev->dev), vdev->tx_ino, vdev->rx_ino);
+
 	err = device_register(&vdev->dev);
 	if (err) {
 		printk(KERN_ERR "VIO: Could not register device %s, err=%d\n",
-- 
1.7.1

