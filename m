From: Dwight Engen <dwight.engen@oracle.com>
Date: Thu, 11 Dec 2014 17:26:17 +0000
Subject: [PATCH 3/3] sunvdc: reconnect ldc after vds service domain restarts
Message-Id: <1418318777-16453-3-git-send-email-dwight.engen@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This change enables the sunvdc driver to reconnect and recover if a vds
service domain is disconnected or bounced.

By default, it will wait indefinitely for the service domain to become
available again, but will honor a non-zero vdc-timout md property if one
is set. If a timeout is reached, any in-progress I/O's are completed
with -EIO.

Signed-off-by: Dwight Engen <dwight.engen@oracle.com>
Reviewed-by: Chris Hyser <chris.hyser@oracle.com>
---
 drivers/block/sunvdc.c |  205 ++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 183 insertions(+), 22 deletions(-)

diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index 65cec15..4b911ed 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -23,8 +23,8 @@
 
 #define DRV_MODULE_NAME		"sunvdc"
 #define PFX DRV_MODULE_NAME	": "
-#define DRV_MODULE_VERSION	"1.1"
-#define DRV_MODULE_RELDATE	"February 13, 2013"
+#define DRV_MODULE_VERSION	"1.2"
+#define DRV_MODULE_RELDATE	"November 24, 2014"
 
 static char version[]  	DRV_MODULE_NAME ".c:v" DRV_MODULE_VERSION " (" DRV_MODULE_RELDATE ")\n";
@@ -40,6 +40,8 @@ MODULE_VERSION(DRV_MODULE_VERSION);
 #define WAITING_FOR_GEN_CMD	0x04
 #define WAITING_FOR_ANY		-1
 
+static struct workqueue_struct *sunvdc_wq;
+
 struct vdc_req_entry {
 	struct request		*req;
 };
@@ -60,6 +62,10 @@ struct vdc_port {
 	u64			max_xfer_size;
 	u32			vdisk_block_size;
 
+	u64			ldc_timeout;
+	struct timer_list	ldc_reset_timer;
+	struct work_struct	ldc_reset_work;
+
 	/* The server fills these in for us in the disk attribute
 	 * ACK packet.
 	 */
@@ -71,6 +77,10 @@ struct vdc_port {
 	char			disk_name[32];
 };
 
+static void vdc_ldc_reset(struct vdc_port *port);
+static void vdc_ldc_reset_work(struct work_struct *work);
+static void vdc_ldc_reset_timer(unsigned long _arg);
+
 static inline struct vdc_port *to_vdc_port(struct vio_driver_state *vio)
 {
 	return container_of(vio, struct vdc_port, vio);
@@ -150,6 +160,21 @@ static const struct block_device_operations vdc_fops = {
 	.ioctl		= vdc_ioctl,
 };
 
+static void vdc_blk_queue_start(struct vdc_port *port)
+{
+	struct vio_dring_state *dr = &port->vio.drings[VIO_DRIVER_TX_RING];
+
+	/* restart blk queue when ring is half emptied. also called after
+	 * handshake completes, so check for initial handshake before we've
+	 * allocated a disk.
+	 */
+	if (port->disk && blk_queue_stopped(port->disk->queue) &&
+	    vdc_tx_dring_avail(dr) * 100 / VDC_TX_RING_SIZE >= 50) {
+		blk_start_queue(port->disk->queue);
+	}
+
+}
+
 static void vdc_finish(struct vio_driver_state *vio, int err, int waiting_for)
 {
 	if (vio->cmp &&
@@ -163,7 +188,11 @@ static void vdc_finish(struct vio_driver_state *vio, int err, int waiting_for)
 
 static void vdc_handshake_complete(struct vio_driver_state *vio)
 {
+	struct vdc_port *port = to_vdc_port(vio);
+
+	del_timer(&port->ldc_reset_timer);
 	vdc_finish(vio, 0, WAITING_FOR_LINK_UP);
+	vdc_blk_queue_start(port);
 }
 
 static int vdc_handle_unknown(struct vdc_port *port, void *arg)
@@ -281,10 +310,7 @@ static void vdc_end_one(struct vdc_port *port, struct vio_dring_state *dr,
 
 	__blk_end_request(req, (desc->status ? -EIO : 0), desc->size);
 
-	/* restart blk queue when ring is half emptied */
-	if (blk_queue_stopped(port->disk->queue) &&
-	    vdc_tx_dring_avail(dr) * 100 / VDC_TX_RING_SIZE >= 50)
-		blk_start_queue(port->disk->queue);
+	vdc_blk_queue_start(port);
 }
 
 static int vdc_ack(struct vdc_port *port, void *msgbuf)
@@ -317,17 +343,20 @@ static void vdc_event(void *arg, int event)
 
 	spin_lock_irqsave(&vio->lock, flags);
 
-	if (unlikely(event = LDC_EVENT_RESET ||
-		     event = LDC_EVENT_UP)) {
+	if (unlikely(event = LDC_EVENT_RESET)) {
 		vio_link_state_change(vio, event);
-		spin_unlock_irqrestore(&vio->lock, flags);
-		return;
+		queue_work(sunvdc_wq, &port->ldc_reset_work);
+		goto out;
+	}
+
+	if (unlikely(event = LDC_EVENT_UP)) {
+		vio_link_state_change(vio, event);
+		goto out;
 	}
 
 	if (unlikely(event != LDC_EVENT_DATA_READY)) {
-		printk(KERN_WARNING PFX "Unexpected LDC event %d\n", event);
-		spin_unlock_irqrestore(&vio->lock, flags);
-		return;
+		pr_warn(PFX "Unexpected LDC event %d\n", event);
+		goto out;
 	}
 
 	err = 0;
@@ -371,6 +400,7 @@ static void vdc_event(void *arg, int event)
 	}
 	if (err < 0)
 		vdc_finish(&port->vio, err, WAITING_FOR_ANY);
+out:
 	spin_unlock_irqrestore(&vio->lock, flags);
 }
 
@@ -403,6 +433,8 @@ static int __vdc_tx_trigger(struct vdc_port *port)
 			delay = 128;
 	} while (err = -EAGAIN);
 
+	if (err = -ENOTCONN)
+		vdc_ldc_reset(port);
 	return err;
 }
 
@@ -690,12 +722,9 @@ static void vdc_free_tx_ring(struct vdc_port *port)
 	}
 }
 
-static int probe_disk(struct vdc_port *port)
+static int vdc_port_up(struct vdc_port *port)
 {
 	struct vio_completion comp;
-	struct request_queue *q;
-	struct gendisk *g;
-	int err;
 
 	init_completion(&comp.com);
 	comp.err = 0;
@@ -703,10 +732,27 @@ static int probe_disk(struct vdc_port *port)
 	port->vio.cmp = &comp;
 
 	vio_port_up(&port->vio);
-
 	wait_for_completion(&comp.com);
-	if (comp.err)
-		return comp.err;
+	return comp.err;
+}
+
+static void vdc_port_down(struct vdc_port *port)
+{
+	ldc_disconnect(port->vio.lp);
+	ldc_unbind(port->vio.lp);
+	vdc_free_tx_ring(port);
+	vio_ldc_free(&port->vio);
+}
+
+static int probe_disk(struct vdc_port *port)
+{
+	struct request_queue *q;
+	struct gendisk *g;
+	int err;
+
+	err = vdc_port_up(port);
+	if (err)
+		return err;
 
 	if (vdc_version_supported(port, 1, 1)) {
 		/* vdisk_size should be set during the handshake, if it wasn't
@@ -819,6 +865,7 @@ static int vdc_port_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 	struct mdesc_handle *hp;
 	struct vdc_port *port;
 	int err;
+	const u64 *ldc_timeout;
 
 	print_version();
 
@@ -848,6 +895,16 @@ static int vdc_port_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 			 VDCBLK_NAME "%c", 'a' + ((int)vdev->dev_no % 26));
 	port->vdisk_size = -1;
 
+	/* Actual wall time may be double due to do_generic_file_read() doing
+	 * a readahead I/O first, and once that fails it will try to read a
+	 * single page.
+	 */
+	ldc_timeout = mdesc_get_property(hp, vdev->mp, "vdc-timeout", NULL);
+	port->ldc_timeout = ldc_timeout ? *ldc_timeout : 0;
+	setup_timer(&port->ldc_reset_timer, vdc_ldc_reset_timer,
+		    (unsigned long)port);
+	INIT_WORK(&port->ldc_reset_work, vdc_ldc_reset_work);
+
 	err = vio_driver_init(&port->vio, vdev, VDEV_DISK,
 			      vdc_versions, ARRAY_SIZE(vdc_versions),
 			      &vdc_vio_ops, port->disk_name);
@@ -902,6 +959,8 @@ static int vdc_port_remove(struct vio_dev *vdev)
 		blk_stop_queue(port->disk->queue);
 		spin_unlock_irqrestore(&port->vio.lock, flags);
 
+		flush_work(&port->ldc_reset_work);
+		del_timer_sync(&port->ldc_reset_timer);
 		del_timer_sync(&port->vio.timer);
 
 		del_gendisk(port->disk);
@@ -919,6 +978,102 @@ static int vdc_port_remove(struct vio_dev *vdev)
 	return 0;
 }
 
+static void vdc_requeue_inflight(struct vdc_port *port)
+{
+	struct vio_dring_state *dr = &port->vio.drings[VIO_DRIVER_TX_RING];
+	u32 idx;
+
+	for (idx = dr->cons; idx != dr->prod; idx = vio_dring_next(dr, idx)) {
+		struct vio_disk_desc *desc = vio_dring_entry(dr, idx);
+		struct vdc_req_entry *rqe = &port->rq_arr[idx];
+		struct request *req;
+
+		ldc_unmap(port->vio.lp, desc->cookies, desc->ncookies);
+		desc->hdr.state = VIO_DESC_FREE;
+		dr->cons = vio_dring_next(dr, idx);
+
+		req = rqe->req;
+		if (req = NULL) {
+			vdc_end_special(port, desc);
+			continue;
+		}
+
+		rqe->req = NULL;
+		blk_requeue_request(port->disk->queue, req);
+	}
+}
+
+static void vdc_queue_drain(struct vdc_port *port)
+{
+	struct request *req;
+
+	while ((req = blk_fetch_request(port->disk->queue)) != NULL)
+		__blk_end_request_all(req, -EIO);
+}
+
+static void vdc_ldc_reset_timer(unsigned long _arg)
+{
+	struct vdc_port *port = (struct vdc_port *) _arg;
+	struct vio_driver_state *vio = &port->vio;
+	unsigned long flags;
+
+	spin_lock_irqsave(&vio->lock, flags);
+	if (!(port->vio.hs_state & VIO_HS_COMPLETE)) {
+		pr_warn(PFX "%s ldc down %llu seconds, draining queue\n",
+			port->disk_name, port->ldc_timeout);
+		vdc_queue_drain(port);
+		vdc_blk_queue_start(port);
+	}
+	spin_unlock_irqrestore(&vio->lock, flags);
+}
+
+static void vdc_ldc_reset_work(struct work_struct *work)
+{
+	struct vdc_port *port;
+	struct vio_driver_state *vio;
+	unsigned long flags;
+
+	port = container_of(work, struct vdc_port, ldc_reset_work);
+	vio = &port->vio;
+
+	spin_lock_irqsave(&vio->lock, flags);
+	vdc_ldc_reset(port);
+	spin_unlock_irqrestore(&vio->lock, flags);
+}
+
+static void vdc_ldc_reset(struct vdc_port *port)
+{
+	int err;
+
+	assert_spin_locked(&port->vio.lock);
+
+	pr_warn(PFX "%s ldc link reset\n", port->disk_name);
+	blk_stop_queue(port->disk->queue);
+	vdc_requeue_inflight(port);
+	vdc_port_down(port);
+
+	err = vio_ldc_alloc(&port->vio, &vdc_ldc_cfg, port);
+	if (err) {
+		pr_err(PFX "%s vio_ldc_alloc:%d\n", port->disk_name, err);
+		return;
+	}
+
+	err = vdc_alloc_tx_ring(port);
+	if (err) {
+		pr_err(PFX "%s vio_alloc_tx_ring:%d\n", port->disk_name, err);
+		goto err_free_ldc;
+	}
+
+	if (port->ldc_timeout)
+		mod_timer(&port->ldc_reset_timer,
+			  round_jiffies(jiffies + HZ * port->ldc_timeout));
+	mod_timer(&port->vio.timer, round_jiffies(jiffies + HZ));
+	return;
+
+err_free_ldc:
+	vio_ldc_free(&port->vio);
+}
+
 static const struct vio_device_id vdc_port_match[] = {
 	{
 		.type = "vdc-port",
@@ -938,9 +1093,13 @@ static int __init vdc_init(void)
 {
 	int err;
 
+	sunvdc_wq = alloc_workqueue("sunvdc", 0, 0);
+	if (!sunvdc_wq)
+		return -ENOMEM;
+
 	err = register_blkdev(0, VDCBLK_NAME);
 	if (err < 0)
-		goto out_err;
+		goto out_free_wq;
 
 	vdc_major = err;
 
@@ -954,7 +1113,8 @@ out_unregister_blkdev:
 	unregister_blkdev(vdc_major, VDCBLK_NAME);
 	vdc_major = 0;
 
-out_err:
+out_free_wq:
+	destroy_workqueue(sunvdc_wq);
 	return err;
 }
 
@@ -962,6 +1122,7 @@ static void __exit vdc_exit(void)
 {
 	vio_unregister_driver(&vdc_port_driver);
 	unregister_blkdev(vdc_major, VDCBLK_NAME);
+	destroy_workqueue(sunvdc_wq);
 }
 
 module_init(vdc_init);
-- 
1.7.1

