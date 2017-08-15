From: Jag Raman <jag.raman@oracle.com>
Date: Tue, 15 Aug 2017 21:03:03 +0000
Subject: [PATCH v2 07/13] sparc64: vcc: Enable LDC event processing engine
Message-Id: <9316a515f750df98cec0cc2a23ec1e0fc3715020.1502829972.git.jag.raman@oracle.com>
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
 v2: Avoid explicit typecast of void pointer

 drivers/tty/vcc.c |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index 27566d5..91f663d 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -437,8 +437,42 @@ static void vcc_tx_timer(unsigned long index)
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
+	struct vio_driver_state *vio;
+	struct vcc_port *port;
+	unsigned long flags;
+	int rv;
+
+	port = arg;
+	vio = &port->vio;
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

