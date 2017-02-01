From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Date: Wed, 01 Feb 2017 19:09:26 +0000
Subject: [PATCH] sunvdc: Add support for setting physical sector size
Message-Id: <1485976166-31220-1-git-send-email-Liam.Howlett@Oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Physical sector size is supported in v1.2 of the vDisk protocol and
should be set if available.  If protocol version 1.2 is used and the
physical disk size is unavailable, then the disk is considered busy.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 drivers/block/sunvdc.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index cab1573..3f3a3ab 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -34,6 +34,7 @@ MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_MODULE_VERSION);
 
 #define VDC_TX_RING_SIZE	512
+#define VDC_DEFAULT_BLK_SIZE	512
 
 #define WAITING_FOR_LINK_UP	0x01
 #define WAITING_FOR_TX_SPACE	0x02
@@ -73,6 +74,7 @@ struct vdc_port {
 	u32			vdisk_size;
 	u8			vdisk_type;
 	u8			vdisk_mtype;
+	u32			vdisk_phys_blksz;
 
 	char			disk_name[32];
 };
@@ -88,6 +90,7 @@ static inline struct vdc_port *to_vdc_port(struct vio_driver_state *vio)
 
 /* Ordered from largest major to lowest */
 static struct vio_version vdc_versions[] = {
+	{ .major = 1, .minor = 2 },
 	{ .major = 1, .minor = 1 },
 	{ .major = 1, .minor = 0 },
 };
@@ -271,6 +274,11 @@ static int vdc_handle_attr(struct vio_driver_state *vio, void *arg)
 		if (pkt->max_xfer_size < port->max_xfer_size)
 			port->max_xfer_size = pkt->max_xfer_size;
 		port->vdisk_block_size = pkt->vdisk_block_size;
+
+		port->vdisk_phys_blksz = VDC_DEFAULT_BLK_SIZE;
+		if (vdc_version_supported(port, 1, 2))
+			port->vdisk_phys_blksz = pkt->phys_block_size;
+
 		return 0;
 	} else {
 		printk(KERN_ERR PFX "%s: Attribute NACK\n", vio->name);
@@ -754,6 +762,12 @@ static int probe_disk(struct vdc_port *port)
 	if (err)
 		return err;
 
+	/* Using version 1.2 means vdisk_phys_blksz should be set unless the
+	 * disk is reserved by another system.
+	 */
+	if (vdc_version_supported(port, 1, 2) && !port->vdisk_phys_blksz)
+		return -ENODEV;
+
 	if (vdc_version_supported(port, 1, 1)) {
 		/* vdisk_size should be set during the handshake, if it wasn't
 		 * then the underlying disk is reserved by another system
@@ -829,6 +843,8 @@ static int probe_disk(struct vdc_port *port)
 		}
 	}
 
+	blk_queue_physical_block_size(q, port->vdisk_phys_blksz);
+
 	pr_info(PFX "%s: %u sectors (%u MB) protocol %d.%d\n",
 	       g->disk_name,
 	       port->vdisk_size, (port->vdisk_size >> (20 - 9)),
@@ -910,7 +926,7 @@ static int vdc_port_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 	if (err)
 		goto err_out_free_port;
 
-	port->vdisk_block_size = 512;
+	port->vdisk_block_size = VDC_DEFAULT_BLK_SIZE;
 	port->max_xfer_size = ((128 * 1024) / port->vdisk_block_size);
 	port->ring_cookies = ((port->max_xfer_size *
 			       port->vdisk_block_size) / PAGE_SIZE) + 2;
-- 
2.1.4

