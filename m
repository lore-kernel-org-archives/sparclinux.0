From: chris.hyser@oracle.com
Date: Fri, 10 Apr 2015 18:07:34 +0000
Subject: [PATCH v4] sparc64: sunvdc: Complete I/O request if vdisk server error
Message-Id: <55281166.vYe5n4+08wPx4lmA%chris.hyser@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

sparc64: sunvdc: Complete I/O request if vdisk server error

If virtual disk server returns an I/O with an error and 0 data transferred,
complete the I/O with EIO to ensure initiating process does not hang
indefinitely.

Signed-off-by: Chris Hyser <chris.hyser@oracle.com>

diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index 4b911ed..cfca5bf 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -308,7 +308,12 @@ static void vdc_end_one(struct vdc_port *port, struct vio_dring_state *dr,
 
 	rqe->req = NULL;
 
-	__blk_end_request(req, (desc->status ? -EIO : 0), desc->size);
+	if (desc->status) {
+		if (printk_ratelimit())
+			pr_err(PFX "VIO I/O Error %d\n", desc->status);
+		__blk_end_request_all(req, -EIO);
+	} else
+		__blk_end_request(req, 0, desc->size);
 
 	vdc_blk_queue_start(port);
 }
