From: Dwight Engen <dwight.engen@oracle.com>
Date: Tue, 27 Jan 2015 17:51:52 +0000
Subject: [PATCH] sunvdc: don't dereference port->disk before disk probe finishes
Message-Id: <1422381112-21571-1-git-send-email-dwight.engen@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

If the backing file for a vdisk is not present in the service domain an
ldc reset can occur during the initial port/disk probing. The ldc reset
logic was dereferencing port->disk, which may not have been setup yet.
Guard against this case.

Orabug: 20362258

Signed-off-by: Dwight Engen <dwight.engen@oracle.com>
---
 drivers/block/sunvdc.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index 4b911ed..7587a8c 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -938,6 +938,8 @@ err_out_free_tx_ring:
 	vdc_free_tx_ring(port);
 
 err_out_free_ldc:
+	flush_work(&port->ldc_reset_work);
+	del_timer_sync(&port->ldc_reset_timer);
 	vio_ldc_free(&port->vio);
 
 err_out_free_port:
@@ -1017,6 +1019,9 @@ static void vdc_ldc_reset_timer(unsigned long _arg)
 	struct vio_driver_state *vio = &port->vio;
 	unsigned long flags;
 
+	if (!port->disk)
+		return;
+
 	spin_lock_irqsave(&vio->lock, flags);
 	if (!(port->vio.hs_state & VIO_HS_COMPLETE)) {
 		pr_warn(PFX "%s ldc down %llu seconds, draining queue\n",
@@ -1048,6 +1053,9 @@ static void vdc_ldc_reset(struct vdc_port *port)
 	assert_spin_locked(&port->vio.lock);
 
 	pr_warn(PFX "%s ldc link reset\n", port->disk_name);
+	if (!port->disk)
+		return;
+
 	blk_stop_queue(port->disk->queue);
 	vdc_requeue_inflight(port);
 	vdc_port_down(port);
-- 
1.7.1

