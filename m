From: chris hyser <chris.hyser@oracle.com>
Date: Wed, 19 Nov 2014 23:52:34 +0000
Subject: [PATCH] sparc64: sunvdc: Complete I/O request if vdisk server error
Message-Id: <546D2D42.2070202@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi All,

In vdc_end_one() of sunvdc.c a non-zero status indicates an error from Solaris
vds. In the case of an actual disk as the vds backend, the error comes from the
corresponding Solaris driver and may or may not represent an actual vdisk error
and the I/O size may be 0. In this case __blk_end_request() does not complete
the request and there may be no further actions to complete it.  This results
in an indefinite hang of the process initiating the I/O.

with patch:

chrish2> dd if=/dev/zero of=/dev/vdiskc count=1
sunvdc: virtual disk server I/O error 5
end_request: I/O error, dev vdiskc, sector 0
Buffer I/O error on device vdiskc, logical block 0
lost page write due to I/O error on vdiskc
1+0 records in
1+0 records out
512 bytes (512 B) copied, 0.000695392 s, 736 kB/s

Without this patch, dd will hang and cannot be killed. Note, 5 is a Solaris EIO.
Still not sure what that is about. :-(

-chrish


-- >8 --
 From 018ad8a7087a195f082dfdc2ae53288eae4a7487 Mon Sep 17 00:00:00 2001
From: chris hyser <chris.hyser@oracle.com>
Date: Wed, 19 Nov 2014 12:41:56 -0800
Subject: [PATCH] sparc64: sunvdc: Complete I/O request if vdisk server error

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

