From: Dwight Engen <dwight.engen@oracle.com>
Date: Fri, 19 Sep 2014 13:43:02 +0000
Subject: [PATCH] vio: fix reuse of vio_dring slot
Message-Id: <1411134182-26705-1-git-send-email-dwight.engen@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

vio_dring_avail() will allow use of every dring entry, but when the last
entry is allocated then dr->prod = dr->cons which is indistinguishable from
the ring empty condition. This causes the next allocation to reuse an entry.
When this happens in sunvdc, the server side vds driver begins nack'ing the
messages and ends up resetting the ldc channel. This problem does not effect
sunvnet since it checks for < 2.

The fix here is to just never allocate the very last dring slot so that full
and empty are not the same condition. The request start path was changed to
check for the ring being full a bit earlier, and to stop the blk_queue if
there is no space left. The blk_queue will be restarted once the ring is
only half full again. The number of ring entries was increased to 512 which
matches the sunvnet and Solaris vdc drivers, and greatly reduces the
frequency of hitting the ring full condition and the associated blk_queue
stop/starting. The checks in sunvent were adjusted to account for
vio_dring_avail() returning 1 less.

Orabug: 19441666
OraBZ: 14983

Signed-off-by: Dwight Engen <dwight.engen@oracle.com>
---
 arch/sparc/include/asm/vio.h       |    2 +-
 drivers/block/sunvdc.c             |   39 +++++++++++++++++++++--------------
 drivers/net/ethernet/sun/sunvnet.c |    4 +-
 3 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/arch/sparc/include/asm/vio.h b/arch/sparc/include/asm/vio.h
index 76290c8..2986120 100644
--- a/arch/sparc/include/asm/vio.h
+++ b/arch/sparc/include/asm/vio.h
@@ -265,7 +265,7 @@ static inline u32 vio_dring_avail(struct vio_dring_state *dr,
 				  unsigned int ring_size)
 {
 	return (dr->pending -
-		((dr->prod - dr->cons) & (ring_size - 1)));
+		((dr->prod - dr->cons) & (ring_size - 1)) - 1);
 }
 
 #define VIO_MAX_TYPE_LEN	32
diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index 1a9360d..756b8ec 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -33,7 +33,7 @@ MODULE_DESCRIPTION("Sun LDOM virtual disk client driver");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_MODULE_VERSION);
 
-#define VDC_TX_RING_SIZE	256
+#define VDC_TX_RING_SIZE	512
 
 #define WAITING_FOR_LINK_UP	0x01
 #define WAITING_FOR_TX_SPACE	0x02
@@ -283,7 +283,9 @@ static void vdc_end_one(struct vdc_port *port, struct vio_dring_state *dr,
 
 	__blk_end_request(req, (desc->status ? -EIO : 0), desc->size);
 
-	if (blk_queue_stopped(port->disk->queue))
+	/* restart blk queue when ring is half emptied */
+	if (blk_queue_stopped(port->disk->queue) &&
+	    vdc_tx_dring_avail(dr) * 100 / VDC_TX_RING_SIZE >= 50)
 		blk_start_queue(port->disk->queue);
 }
 
@@ -435,12 +437,6 @@ static int __send_request(struct request *req)
 	for (i = 0; i < nsg; i++)
 		len += sg[i].length;
 
-	if (unlikely(vdc_tx_dring_avail(dr) < 1)) {
-		blk_stop_queue(port->disk->queue);
-		err = -ENOMEM;
-		goto out;
-	}
-
 	desc = vio_dring_cur(dr);
 
 	err = ldc_map_sg(port->vio.lp, sg, nsg,
@@ -480,21 +476,32 @@ static int __send_request(struct request *req)
 		port->req_id++;
 		dr->prod = (dr->prod + 1) & (VDC_TX_RING_SIZE - 1);
 	}
-out:
 
 	return err;
 }
 
-static void do_vdc_request(struct request_queue *q)
+static void do_vdc_request(struct request_queue *rq)
 {
-	while (1) {
-		struct request *req = blk_fetch_request(q);
+	struct request *req;
 
-		if (!req)
-			break;
+	while ((req = blk_peek_request(rq)) != NULL) {
+		struct vdc_port *port;
+		struct vio_dring_state *dr;
 
-		if (__send_request(req) < 0)
-			__blk_end_request_all(req, -EIO);
+		port = req->rq_disk->private_data;
+		dr = &port->vio.drings[VIO_DRIVER_TX_RING];
+		if (unlikely(vdc_tx_dring_avail(dr) < 1))
+			goto wait;
+
+		blk_start_request(req);
+
+		if (__send_request(req) < 0) {
+			blk_requeue_request(rq, req);
+wait:
+			/* Avoid pointless unplugs. */
+			blk_stop_queue(rq);
+			break;
+		}
 	}
 }
 
diff --git a/drivers/net/ethernet/sun/sunvnet.c b/drivers/net/ethernet/sun/sunvnet.c
index 23c89ab..b7cca71 100644
--- a/drivers/net/ethernet/sun/sunvnet.c
+++ b/drivers/net/ethernet/sun/sunvnet.c
@@ -690,7 +690,7 @@ static int vnet_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	spin_lock_irqsave(&port->vio.lock, flags);
 
 	dr = &port->vio.drings[VIO_DRIVER_TX_RING];
-	if (unlikely(vnet_tx_dring_avail(dr) < 2)) {
+	if (unlikely(vnet_tx_dring_avail(dr) < 1)) {
 		if (!netif_queue_stopped(dev)) {
 			netif_stop_queue(dev);
 
@@ -746,7 +746,7 @@ static int vnet_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	dev->stats.tx_bytes += skb->len;
 
 	dr->prod = (dr->prod + 1) & (VNET_TX_RING_SIZE - 1);
-	if (unlikely(vnet_tx_dring_avail(dr) < 2)) {
+	if (unlikely(vnet_tx_dring_avail(dr) < 1)) {
 		netif_stop_queue(dev);
 		if (vnet_tx_dring_avail(dr) > VNET_TX_WAKEUP_THRESH(dr))
 			netif_wake_queue(dev);
-- 
1.7.1

