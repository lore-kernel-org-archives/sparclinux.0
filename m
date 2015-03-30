From: chris hyser <chris.hyser@oracle.com>
Date: Mon, 30 Mar 2015 16:41:26 +0000
Subject: [PATCH v3] sunvdc: Complete I/O request if vdisk server error
Message-Id: <55197CB6.2020903@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

sunvdc: Complete I/O request if vdisk server error

If virtual disk server returns an I/O with an error and 0 data transferred,
complete the I/O with EIO to ensure initiating process does not hang
indefinitely.

Signed-off-by: Chris Hyser <chris.hyser@oracle.com>

diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index 4b911ed..dad85fe 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -308,7 +308,11 @@ static void vdc_end_one(struct vdc_port *port, struct vio_dring_state *dr,

  	rqe->req = NULL;

-	__blk_end_request(req, (desc->status ? -EIO : 0), desc->size);
+	if (desc->status) {
+		pr_err(PFX "VIO I/O Error %d\n", desc->status);
+		__blk_end_request_all(req, -EIO);
+	} else
+		__blk_end_request(req, 0, desc->size);

  	vdc_blk_queue_start(port);
  }


