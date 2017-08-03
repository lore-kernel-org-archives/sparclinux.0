From: Jag Raman <jag.raman@oracle.com>
Date: Thu, 03 Aug 2017 17:43:56 +0000
Subject: [PATCH v1 04/13] sparc64: vcc: Enable VCC port probe and removal
Message-Id: <1f9f12d074c5fc449a9a2f25c82b974bfd68317e.1501781770.git.jag.raman@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Enables VCC port probe and removal to initialize and terminate
VCC ports respectively. When a device/port matching the VCC driver
is added, the probe function is invoked along with a reference
to the device. remove function is called when the device is
removed.

Also add APIs to cache and retrieve VCC ports from a VCC table

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 arch/sparc/include/asm/vio.h |    9 +
 arch/sparc/kernel/vio.c      |    1 +
 arch/sparc/kernel/viohs.c    |   12 +-
 drivers/tty/vcc.c            |  378 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 397 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/include/asm/vio.h b/arch/sparc/include/asm/vio.h
index d1c47e9..f3d4ac2 100644
--- a/arch/sparc/include/asm/vio.h
+++ b/arch/sparc/include/asm/vio.h
@@ -52,6 +52,7 @@ struct vio_ver_info {
 #define VDEV_NETWORK_SWITCH	0x02
 #define VDEV_DISK		0x03
 #define VDEV_DISK_SERVER	0x04
+#define VDEV_CONSOLE_CON	0x05
 
 	u8			resv1[3];
 	u64			resv2[5];
@@ -282,6 +283,14 @@ struct vio_dring_state {
 	struct ldc_trans_cookie	cookies[VIO_MAX_RING_COOKIES];
 };
 
+#define VIO_TAG_SIZE		((int)sizeof(struct vio_msg_tag))
+#define VIO_VCC_MTU_SIZE	(LDC_PACKET_SIZE - VIO_TAG_SIZE)
+
+struct vio_vcc {
+	struct vio_msg_tag	tag;
+	char			data[VIO_VCC_MTU_SIZE];
+};
+
 static inline void *vio_dring_cur(struct vio_dring_state *dr)
 {
 	return dr->base + (dr->entry_size * dr->prod);
diff --git a/arch/sparc/kernel/vio.c b/arch/sparc/kernel/vio.c
index 1c8763c..da1ac3f 100644
--- a/arch/sparc/kernel/vio.c
+++ b/arch/sparc/kernel/vio.c
@@ -246,6 +246,7 @@ u64 vio_vdev_node(struct mdesc_handle *hp, struct vio_dev *vdev)
 
 	return node;
 }
+EXPORT_SYMBOL(vio_vdev_node);
 
 static void vio_fill_channel_info(struct mdesc_handle *hp, u64 mp,
 				  struct vio_dev *vdev)
diff --git a/arch/sparc/kernel/viohs.c b/arch/sparc/kernel/viohs.c
index d4f13c0..dcd278f 100644
--- a/arch/sparc/kernel/viohs.c
+++ b/arch/sparc/kernel/viohs.c
@@ -814,15 +814,21 @@ int vio_driver_init(struct vio_driver_state *vio, struct vio_dev *vdev,
 	case VDEV_NETWORK_SWITCH:
 	case VDEV_DISK:
 	case VDEV_DISK_SERVER:
+	case VDEV_CONSOLE_CON:
 		break;
 
 	default:
 		return -EINVAL;
 	}
 
-	if (!ops || !ops->send_attr || !ops->handle_attr ||
-	    !ops->handshake_complete)
-		return -EINVAL;
+	if (dev_class = VDEV_NETWORK ||
+	    dev_class = VDEV_NETWORK_SWITCH ||
+	    dev_class = VDEV_DISK ||
+	    dev_class = VDEV_DISK_SERVER) {
+		if (!ops || !ops->send_attr || !ops->handle_attr ||
+		    !ops->handshake_complete)
+			return -EINVAL;
+	}
 
 	if (!ver_table || ver_table_size < 0)
 		return -EINVAL;
diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index ba3384d..b231903 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -3,8 +3,13 @@
  * Copyright (C) 2017 Oracle. All rights reserved.
  */
 
+#include <linux/delay.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/slab.h>
 #include <linux/tty.h>
+#include <asm/vio.h>
+#include <asm/ldc.h>
 
 #define DRV_MODULE_NAME		"vcc"
 #define DRV_MODULE_VERSION	"1.1"
@@ -17,6 +22,33 @@
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_MODULE_VERSION);
 
+struct vcc_port {
+	struct vio_driver_state vio;
+
+	spinlock_t lock;
+	char *domain;
+	struct tty_struct *tty;	/* only populated while dev is open */
+	unsigned long index;	/* index into the vcc_table */
+
+	u64 refcnt;
+	bool excl_locked;
+
+	bool removed;
+
+	/* This buffer is required to support the tty write_room interface
+	 * and guarantee that any characters that the driver accepts will
+	 * be eventually sent, either immediately or later.
+	 */
+	int chars_in_buffer;
+	struct vio_vcc buffer;
+
+	struct timer_list rx_timer;
+	struct timer_list tx_timer;
+};
+
+/* Microseconds that thread will delay waiting for a vcc port ref */
+#define VCC_REF_DELAY		100
+
 #define VCC_MAX_PORTS		1024
 #define VCC_MINOR_START		0	/* must be zero */
 
@@ -24,6 +56,9 @@
 static const char vcc_device_node[] = "vcc";
 static struct tty_driver *vcc_tty_driver;
 
+static struct vcc_port *vcc_table[VCC_MAX_PORTS];
+static DEFINE_SPINLOCK(vcc_table_lock);
+
 int vcc_dbg;
 int vcc_dbg_ldc;
 int vcc_dbg_vio;
@@ -70,6 +105,339 @@
 	.c_ospeed = 38400
 };
 
+/**
+ * vcc_table_add() - Add VCC port to the VCC table
+ * @port: pointer to the VCC port
+ *
+ * Return: index of the port in the VCC table on success,
+ *	   -1 on failure
+ */
+static int vcc_table_add(struct vcc_port *port)
+{
+	unsigned long flags;
+	int i;
+
+	spin_lock_irqsave(&vcc_table_lock, flags);
+	for (i = VCC_MINOR_START; i < VCC_MAX_PORTS; i++) {
+		if (!vcc_table[i]) {
+			vcc_table[i] = port;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&vcc_table_lock, flags);
+
+	if (i < VCC_MAX_PORTS)
+		return i;
+	else
+		return -1;
+}
+
+/**
+ * vcc_table_remove() - Removes a VCC port from the VCC table
+ * @index: Index into the VCC table
+ */
+static void vcc_table_remove(unsigned long index)
+{
+	unsigned long flags;
+
+	if (WARN_ON(index >= VCC_MAX_PORTS))
+		return;
+
+	spin_lock_irqsave(&vcc_table_lock, flags);
+	vcc_table[index] = NULL;
+	spin_unlock_irqrestore(&vcc_table_lock, flags);
+}
+
+/**
+ * vcc_get() - Gets a reference to VCC port
+ * @index: Index into the VCC table
+ * @excl: Indicates if an exclusive access is requested
+ *
+ * Return: reference to the VCC port, if found
+ *	   NULL, if port not found
+ */
+static struct vcc_port *vcc_get(unsigned long index, bool excl)
+{
+	struct vcc_port *port;
+	unsigned long flags;
+
+try_again:
+	spin_lock_irqsave(&vcc_table_lock, flags);
+
+	port = vcc_table[index];
+	if (!port) {
+		spin_unlock_irqrestore(&vcc_table_lock, flags);
+		return NULL;
+	}
+
+	if (!excl) {
+		if (port->excl_locked) {
+			spin_unlock_irqrestore(&vcc_table_lock, flags);
+			udelay(VCC_REF_DELAY);
+			goto try_again;
+		}
+		port->refcnt++;
+		spin_unlock_irqrestore(&vcc_table_lock, flags);
+		return port;
+	}
+
+	if (port->refcnt) {
+		spin_unlock_irqrestore(&vcc_table_lock, flags);
+		/* Threads wanting exclusive access will wait half the time,
+		 * probably giving them higher priority in the case of
+		 * multiple waiters.
+		 */
+		udelay(VCC_REF_DELAY/2);
+		goto try_again;
+	}
+
+	port->refcnt++;
+	port->excl_locked = true;
+	spin_unlock_irqrestore(&vcc_table_lock, flags);
+
+	return port;
+}
+
+/**
+ * vcc_put() - Returns a reference to VCC port
+ * @port: pointer to VCC port
+ * @excl: Indicates if the returned reference is an exclusive reference
+ *
+ * Note: It's the caller's responsibility to ensure the correct value
+ *	 for the excl flag
+ */
+static void vcc_put(struct vcc_port *port, bool excl)
+{
+	unsigned long flags;
+
+	if (!port)
+		return;
+
+	spin_lock_irqsave(&vcc_table_lock, flags);
+
+	/* check if caller attempted to put with the wrong flags */
+	if (WARN_ON((excl && !port->excl_locked) ||
+		    (!excl && port->excl_locked)))
+		goto done;
+
+	port->refcnt--;
+
+	if (excl)
+		port->excl_locked = false;
+
+done:
+	spin_unlock_irqrestore(&vcc_table_lock, flags);
+}
+
+/**
+ * vcc_get_ne() - Get a non-exclusive reference to VCC port
+ * @index: Index into the VCC table
+ *
+ * Gets a non-exclusive reference to VCC port, if it's not removed
+ *
+ * Return: pointer to the VCC port, if found
+ *	   NULL, if port not found
+ */
+static struct vcc_port *vcc_get_ne(unsigned long index)
+{
+	struct vcc_port *port;
+
+	port = vcc_get(index, false);
+
+	if (port && port->removed) {
+		vcc_put(port, false);
+		return NULL;
+	}
+
+	return port;
+}
+
+static void vcc_event(void *arg, int event)
+{
+}
+
+static struct ldc_channel_config vcc_ldc_cfg = {
+	.event		= vcc_event,
+	.mtu		= VIO_VCC_MTU_SIZE,
+	.mode		= LDC_MODE_RAW,
+	.debug		= 0,
+};
+
+/* Ordered from largest major to lowest */
+static struct vio_version vcc_versions[] = {
+	{ .major = 1, .minor = 0 },
+};
+
+/**
+ * vcc_probe() - Initialize VCC port
+ * @vdev: Pointer to VIO device of the new VCC port
+ * @id: VIO device ID
+ *
+ * Initializes a VCC port to receive serial console data from
+ * the guest domain. Sets up a TTY end point on the control
+ * domain. Sets up VIO/LDC link between the guest & control
+ * domain endpoints.
+ *
+ * Return: status of the probe
+ */
+static int vcc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
+{
+	struct mdesc_handle *hp;
+	struct vcc_port *port;
+	struct device *dev;
+	const char *domain;
+	char *name;
+	u64 node;
+	int rv;
+
+	vccdbg("VCC: name=%s\n", dev_name(&vdev->dev));
+
+	if (!vcc_tty_driver) {
+		pr_err("VCC: TTY driver not registered\n");
+		return -ENODEV;
+	}
+
+	port = kzalloc(sizeof(struct vcc_port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	name = kstrdup(dev_name(&vdev->dev), GFP_KERNEL);
+
+	rv = vio_driver_init(&port->vio, vdev, VDEV_CONSOLE_CON, vcc_versions,
+			     ARRAY_SIZE(vcc_versions), NULL, name);
+	if (rv)
+		goto free_port;
+
+	port->vio.debug = vcc_dbg_vio;
+	vcc_ldc_cfg.debug = vcc_dbg_ldc;
+
+	rv = vio_ldc_alloc(&port->vio, &vcc_ldc_cfg, port);
+	if (rv)
+		goto free_port;
+
+	spin_lock_init(&port->lock);
+
+	port->index = vcc_table_add(port);
+	if (port->index = -1) {
+		pr_err("VCC: no more TTY indices left for allocation\n");
+		goto free_ldc;
+	}
+
+	/* Register the device using VCC table index as TTY index */
+	dev = tty_register_device(vcc_tty_driver, port->index, &vdev->dev);
+	if (IS_ERR(dev)) {
+		rv = PTR_ERR(dev);
+		goto free_table;
+	}
+
+	hp = mdesc_grab();
+
+	node = vio_vdev_node(hp, vdev);
+	if (node = MDESC_NODE_NULL) {
+		rv = -ENXIO;
+		mdesc_release(hp);
+		goto unreg_tty;
+	}
+
+	domain = mdesc_get_property(hp, node, "vcc-domain-name", NULL);
+	if (!domain) {
+		rv = -ENXIO;
+		mdesc_release(hp);
+		goto unreg_tty;
+	}
+	port->domain = kstrdup(domain, GFP_KERNEL);
+
+	mdesc_release(hp);
+
+	dev_set_drvdata(&vdev->dev, port);
+
+	/* It's possible to receive IRQs in the middle of vio_port_up. Disable
+	 * IRQs until the port is up.
+	 */
+	disable_irq_nosync(vdev->rx_irq);
+	vio_port_up(&port->vio);
+	enable_irq(vdev->rx_irq);
+
+	return 0;
+
+unreg_tty:
+	tty_unregister_device(vcc_tty_driver, port->index);
+free_table:
+	vcc_table_remove(port->index);
+free_ldc:
+	vio_ldc_free(&port->vio);
+free_port:
+	kfree(name);
+	kfree(port);
+
+	return rv;
+}
+
+/**
+ * vcc_remove() - Terminate a VCC port
+ * @vdev: Pointer to VIO device of the VCC port
+ *
+ * Terminates a VCC port. Sets up the teardown of TTY and
+ * VIO/LDC link between guest and primary domains.
+ *
+ * Return: status of removal
+ */
+static int vcc_remove(struct vio_dev *vdev)
+{
+	struct vcc_port *port = dev_get_drvdata(&vdev->dev);
+
+	if (!port)
+		return -ENODEV;
+
+	/* If there's a process with the device open, do a synchronous
+	 * hangup of the TTY. This *may* cause the process to call close
+	 * asynchronously, but it's not guaranteed.
+	 */
+	if (port->tty)
+		tty_vhangup(port->tty);
+
+	/* Get exclusive reference to VCC, ensures that there are no other
+	 * clients to this port
+	 */
+	port = vcc_get(port->index, true);
+
+	if (WARN_ON(!port))
+		return -ENODEV;
+
+	tty_unregister_device(vcc_tty_driver, port->index);
+
+	vio_ldc_free(&port->vio);
+	dev_set_drvdata(&vdev->dev, NULL);
+
+	if (port->tty) {
+		port->removed = true;
+		vcc_put(port, true);
+	} else {
+		vcc_table_remove(port->index);
+
+		kfree(port->vio.name);
+		kfree(port->domain);
+		kfree(port);
+	}
+
+	return 0;
+}
+
+static const struct vio_device_id vcc_match[] = {
+	{
+		.type = "vcc-port",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(vio, vcc_match);
+
+static struct vio_driver vcc_driver = {
+	.id_table	= vcc_match,
+	.probe		= vcc_probe,
+	.remove		= vcc_remove,
+	.name		= "vcc",
+};
+
 static const struct tty_operations vcc_ops;
 
 #define VCC_TTY_FLAGS   (TTY_DRIVER_DYNAMIC_DEV | TTY_DRIVER_REAL_RAW)
@@ -127,11 +495,21 @@ static int __init vcc_init(void)
 		return rv;
 	}
 
+	rv = vio_register_driver(&vcc_driver);
+	if (rv) {
+		pr_err("VCC: VIO driver registration failed\n");
+		vcc_tty_exit();
+	} else {
+		vccdbg("VCC: VIO driver registered successfully\n");
+	}
+
 	return rv;
 }
 
 static void __exit vcc_exit(void)
 {
+	vio_unregister_driver(&vcc_driver);
+	vccdbg("VCC: VIO driver unregistered\n");
 	vcc_tty_exit();
 	vccdbg("VCC: TTY driver unregistered\n");
 }
-- 
1.7.1

