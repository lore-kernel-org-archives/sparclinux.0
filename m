From: Dwight Engen <dwight.engen@oracle.com>
Date: Thu, 11 Dec 2014 17:26:15 +0000
Subject: [PATCH 1/3] vio: create routines for inc,dec vio dring indexes
Message-Id: <1418318777-16453-1-git-send-email-dwight.engen@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Both sunvdc and sunvnet implemented distinct functionality for incrementing
and decrementing dring indexes. Create common functions for use by both
from the sunvnet versions, which were chosen since they will still work
correctly in case a non power of two ring size is used.

Signed-off-by: Dwight Engen <dwight.engen@oracle.com>
---
 arch/sparc/include/asm/vio.h       |   15 +++++++++++++++
 drivers/block/sunvdc.c             |    6 +++---
 drivers/net/ethernet/sun/sunvnet.c |   28 ++++++----------------------
 3 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/arch/sparc/include/asm/vio.h b/arch/sparc/include/asm/vio.h
index d758c8d..a05dc1a 100644
--- a/arch/sparc/include/asm/vio.h
+++ b/arch/sparc/include/asm/vio.h
@@ -281,6 +281,21 @@ static inline u32 vio_dring_avail(struct vio_dring_state *dr,
 		((dr->prod - dr->cons) & (ring_size - 1)) - 1);
 }
 
+static inline u32 vio_dring_next(struct vio_dring_state *dr, u32 index)
+{
+	if (++index = dr->num_entries)
+		index = 0;
+	return index;
+}
+
+static inline u32 vio_dring_prev(struct vio_dring_state *dr, u32 index)
+{
+	if (index = 0)
+		return dr->num_entries - 1;
+	else
+		return index - 1;
+}
+
 #define VIO_MAX_TYPE_LEN	32
 #define VIO_MAX_COMPAT_LEN	64
 
diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index 089ff90..65cec15 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -269,7 +269,7 @@ static void vdc_end_one(struct vdc_port *port, struct vio_dring_state *dr,
 
 	ldc_unmap(port->vio.lp, desc->cookies, desc->ncookies);
 	desc->hdr.state = VIO_DESC_FREE;
-	dr->cons = (index + 1) & (VDC_TX_RING_SIZE - 1);
+	dr->cons = vio_dring_next(dr, index);
 
 	req = rqe->req;
 	if (req = NULL) {
@@ -472,7 +472,7 @@ static int __send_request(struct request *req)
 		printk(KERN_ERR PFX "vdc_tx_trigger() failure, err=%d\n", err);
 	} else {
 		port->req_id++;
-		dr->prod = (dr->prod + 1) & (VDC_TX_RING_SIZE - 1);
+		dr->prod = vio_dring_next(dr, dr->prod);
 	}
 
 	return err;
@@ -626,7 +626,7 @@ static int generic_request(struct vdc_port *port, u8 op, void *buf, int len)
 	err = __vdc_tx_trigger(port);
 	if (err >= 0) {
 		port->req_id++;
-		dr->prod = (dr->prod + 1) & (VDC_TX_RING_SIZE - 1);
+		dr->prod = vio_dring_next(dr, dr->prod);
 		spin_unlock_irqrestore(&port->vio.lock, flags);
 
 		wait_for_completion(&comp.com);
diff --git a/drivers/net/ethernet/sun/sunvnet.c b/drivers/net/ethernet/sun/sunvnet.c
index 3652afd..41c9847 100644
--- a/drivers/net/ethernet/sun/sunvnet.c
+++ b/drivers/net/ethernet/sun/sunvnet.c
@@ -373,23 +373,6 @@ static int vnet_send_ack(struct vnet_port *port, struct vio_dring_state *dr,
 	return err;
 }
 
-static u32 next_idx(u32 idx, struct vio_dring_state *dr)
-{
-	if (++idx = dr->num_entries)
-		idx = 0;
-	return idx;
-}
-
-static u32 prev_idx(u32 idx, struct vio_dring_state *dr)
-{
-	if (idx = 0)
-		idx = dr->num_entries - 1;
-	else
-		idx--;
-
-	return idx;
-}
-
 static struct vio_net_desc *get_rx_desc(struct vnet_port *port,
 					struct vio_dring_state *dr,
 					u32 index)
@@ -461,7 +444,8 @@ static int vnet_walk_rx(struct vnet_port *port, struct vio_dring_state *dr,
 	struct vio_driver_state *vio = &port->vio;
 	int ack_start = -1, ack_end = -1;
 
-	end = (end = (u32) -1) ? prev_idx(start, dr) : next_idx(end, dr);
+	end = (end = (u32) -1) ? vio_dring_prev(dr, start)
+				: vio_dring_next(dr, end);
 
 	viodbg(DATA, "vnet_walk_rx start[%08x] end[%08x]\n", start, end);
 
@@ -474,7 +458,7 @@ static int vnet_walk_rx(struct vnet_port *port, struct vio_dring_state *dr,
 		if (ack_start = -1)
 			ack_start = start;
 		ack_end = start;
-		start = next_idx(start, dr);
+		start = vio_dring_next(dr, start);
 		if (ack && start != end) {
 			err = vnet_send_ack(port, dr, ack_start, ack_end,
 					    VIO_DRING_ACTIVE);
@@ -484,7 +468,7 @@ static int vnet_walk_rx(struct vnet_port *port, struct vio_dring_state *dr,
 		}
 	}
 	if (unlikely(ack_start = -1))
-		ack_start = ack_end = prev_idx(start, dr);
+		ack_start = ack_end = vio_dring_prev(dr, start);
 	return vnet_send_ack(port, dr, ack_start, ack_end, VIO_DRING_STOPPED);
 }
 
@@ -522,7 +506,7 @@ static int idx_is_pending(struct vio_dring_state *dr, u32 end)
 			found = 1;
 			break;
 		}
-		idx = next_idx(idx, dr);
+		idx = vio_dring_next(dr, idx);
 	}
 	return found;
 }
@@ -545,7 +529,7 @@ static int vnet_ack(struct vnet_port *port, void *msgbuf)
 	/* sync for race conditions with vnet_start_xmit() and tell xmit it
 	 * is time to send a trigger.
 	 */
-	dr->cons = next_idx(end, dr);
+	dr->cons = vio_dring_next(dr, end);
 	desc = vio_dring_entry(dr, dr->cons);
 	if (desc->hdr.state = VIO_DESC_READY && port->start_cons) {
 		/* vnet_start_xmit() just populated this dring but missed
-- 
1.7.1

