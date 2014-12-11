From: Dwight Engen <dwight.engen@oracle.com>
Date: Thu, 11 Dec 2014 17:25:42 +0000
Subject: [PATCH] sunvdc: fix module unload/reload
Message-Id: <1418318742-16406-1-git-send-email-dwight.engen@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Free resources allocated during port/disk probing so that the module may be
successfully reloaded after unloading.

Signed-off-by: Dwight Engen <dwight.engen@oracle.com>
---
 drivers/block/sunvdc.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index 0ebadf9..089ff90 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -896,8 +896,19 @@ static int vdc_port_remove(struct vio_dev *vdev)
 	struct vdc_port *port = dev_get_drvdata(&vdev->dev);
 
 	if (port) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&port->vio.lock, flags);
+		blk_stop_queue(port->disk->queue);
+		spin_unlock_irqrestore(&port->vio.lock, flags);
+
 		del_timer_sync(&port->vio.timer);
 
+		del_gendisk(port->disk);
+		blk_cleanup_queue(port->disk->queue);
+		put_disk(port->disk);
+		port->disk = NULL;
+
 		vdc_free_tx_ring(port);
 		vio_ldc_free(&port->vio);
 
-- 
1.7.1

