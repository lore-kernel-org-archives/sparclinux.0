From: chris hyser <chris.hyser@oracle.com>
Date: Fri, 21 Nov 2014 21:06:30 +0000
Subject: [PATCH v2] sparc64: sunvdc: Complete I/O request if vdisk server error
Message-Id: <546FA956.1070005@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Sorry for the confusion of the prior message. Below was the intended commit message.

-chrish

sparc64: sunvdc: Complete I/O request if vdisk server error

If virtual disk server returns an I/O with an error and 0 data transferred,
complete the I/O with EIO to ensure initiating process does not hang
indefinitely.

Signed-off-by: Chris Hyser <chris.hyser@oracle.com>

diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index 0ebadf9..17e9a50 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -279,7 +279,12 @@ static void vdc_end_one(struct vdc_port *port, struct vio_dring_state *dr,

  	rqe->req = NULL;

-	__blk_end_request(req, (desc->status ? -EIO : 0), desc->size);
+	if (desc->status && desc->size = 0) {
+		printk(KERN_ERR PFX "virtual disk server I/O error %d\n",
+				desc->status);
+		__blk_end_request_all(req, -EIO);
+	} else
+		__blk_end_request(req, (desc->status ? -EIO : 0) , desc->size);

  	/* restart blk queue when ring is half emptied */
  	if (blk_queue_stopped(port->disk->queue) &&

--
To unsubscribe from this list: send the line "unsubscribe sparclinux" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


