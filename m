From: Jag Raman <jag.raman@oracle.com>
Date: Thu, 03 Aug 2017 17:43:59 +0000
Subject: [PATCH v1 07/13] sparc64: vcc: Enable LDC event processing engine
Message-Id: <06dccdc7a1d8ce6aa507f1b164185cd508d4055e.1501781770.git.jag.raman@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Enable event processing engine to handle LDC events

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/tty/vcc.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index 84a8dd7..8f4afdb 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -443,8 +443,39 @@ static void vcc_tx_timer(unsigned long index)
 	vcc_put(port, false);
 }
 
+/**
+ * vcc_event() - LDC event processing engine
+ * @arg: VCC private data
+ * @event: LDC event
+ *
+ * Handles LDC events for VCC
+ */
 static void vcc_event(void *arg, int event)
 {
+	struct vcc_port *port = (struct vcc_port *)arg;
+	struct vio_driver_state *vio = &port->vio;
+	unsigned long flags;
+	int rv;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	switch (event) {
+	case LDC_EVENT_RESET:
+	case LDC_EVENT_UP:
+		vio_link_state_change(vio, event);
+		break;
+
+	case LDC_EVENT_DATA_READY:
+		rv = vcc_ldc_read(port);
+		if (rv = -ECONNRESET)
+			vio_conn_reset(vio);
+		break;
+
+	default:
+		pr_err("VCC: unexpected LDC event(%d)\n", event);
+	}
+
+	spin_unlock_irqrestore(&port->lock, flags);
 }
 
 static struct ldc_channel_config vcc_ldc_cfg = {
-- 
1.7.1

