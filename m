From: Jag Raman <jag.raman@oracle.com>
Date: Thu, 03 Aug 2017 17:43:58 +0000
Subject: [PATCH v1 06/13] sparc64: vcc: Add RX & TX timer for delayed LDC operation
Message-Id: <92bf7beadd3d50f0c6e27578c00c96bfc1bf296e.1501781770.git.jag.raman@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Add RX & TX timers to perform delayed/asynchronous LDC
read and write operations.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 arch/sparc/kernel/ldc.c |    1 +
 drivers/tty/vcc.c       |  197 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 197 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/kernel/ldc.c b/arch/sparc/kernel/ldc.c
index 1169915..acffbc8 100644
--- a/arch/sparc/kernel/ldc.c
+++ b/arch/sparc/kernel/ldc.c
@@ -1480,6 +1480,7 @@ int ldc_rx_reset(struct ldc_channel *lp)
 {
 	return __set_rx_head(lp, lp->rx_tail);
 }
+EXPORT_SYMBOL(ldc_rx_reset);
 
 void __ldc_print(struct ldc_channel *lp, const char *caller)
 {
diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index d168547..84a8dd7 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -9,6 +9,7 @@
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/tty.h>
+#include <linux/tty_flip.h>
 #include <asm/vio.h>
 #include <asm/ldc.h>
 
@@ -52,10 +53,15 @@ struct vcc_port {
 
 #define VCC_MAX_PORTS		1024
 #define VCC_MINOR_START		0	/* must be zero */
+#define VCC_BUFF_LEN		VIO_VCC_MTU_SIZE
 
 #define VCC_CTL_BREAK		-1
 #define VCC_CTL_HUP		-2
 
+#define TIMER_SET(v, x, t)	((v)->x##_timer.expires = (t))
+#define TIMER_CLEAR(v, x)	((v)->x##_timer.expires = 0)
+#define TIMER_ACTIVE(v, x)	((v)->x##_timer.expires)
+
 static const char vcc_driver_name[] = "vcc";
 static const char vcc_device_node[] = "vcc";
 static struct tty_driver *vcc_tty_driver;
@@ -256,6 +262,187 @@ static void vcc_put(struct vcc_port *port, bool excl)
 	return port;
 }
 
+static void vcc_kick_rx(struct vcc_port *port)
+{
+	struct vio_driver_state *vio = &port->vio;
+
+	assert_spin_locked(&port->lock);
+
+	if (TIMER_ACTIVE(port, rx))
+		return;
+
+	disable_irq_nosync(vio->vdev->rx_irq);
+	TIMER_SET(port, rx, (jiffies + 1));
+	add_timer(&port->rx_timer);
+}
+
+static void vcc_kick_tx(struct vcc_port *port)
+{
+	assert_spin_locked(&port->lock);
+
+	if (TIMER_ACTIVE(port, tx))
+		return;
+
+	TIMER_SET(port, tx, (jiffies + 1));
+	add_timer(&port->tx_timer);
+}
+
+static int vcc_rx_check(struct tty_struct *tty, int size)
+{
+	if (WARN_ON(!tty || !tty->port))
+		return 1;
+
+	/* tty_buffer_request_room won't sleep because it uses
+	 * GFP_ATOMIC flag to allocate buffer
+	 */
+	if (test_bit(TTY_THROTTLED, &tty->flags) ||
+	    (tty_buffer_request_room(tty->port, VCC_BUFF_LEN) < VCC_BUFF_LEN))
+		return 0;
+
+	return 1;
+}
+
+static int vcc_rx(struct tty_struct *tty, char *buf, int size)
+{
+	int len = 0;
+
+	if (WARN_ON(!tty || !tty->port))
+		return len;
+
+	len = tty_insert_flip_string(tty->port, buf, size);
+	if (len)
+		tty_flip_buffer_push(tty->port);
+
+	return len;
+}
+
+static int vcc_ldc_read(struct vcc_port *port)
+{
+	struct vio_driver_state *vio = &port->vio;
+	struct tty_struct *tty;
+	struct vio_vcc pkt;
+	int rv = 0;
+
+	tty = port->tty;
+	if (!tty) {
+		rv = ldc_rx_reset(vio->lp);
+		vccdbg("VCC: reset rx q: rv=%d\n", rv);
+		goto done;
+	}
+
+	/* Read as long as LDC has incoming data. */
+	while (1) {
+		if (!vcc_rx_check(tty, VIO_VCC_MTU_SIZE)) {
+			vcc_kick_rx(port);
+			break;
+		}
+
+		vccdbgl(vio->lp);
+
+		rv = ldc_read(vio->lp, &pkt, sizeof(pkt));
+		if (rv <= 0)
+			break;
+
+		vccdbg("VCC: ldc_read()=%d\n", rv);
+		vccdbg("TAG [%02x:%02x:%04x:%08x]\n",
+		       pkt.tag.type, pkt.tag.stype,
+		       pkt.tag.stype_env, pkt.tag.sid);
+
+		if (pkt.tag.type = VIO_TYPE_DATA) {
+			vccdbgp(pkt);
+			/* vcc_rx_check ensures memory availability */
+			vcc_rx(tty, pkt.data, pkt.tag.stype);
+		} else {
+			pr_err("VCC: unknown msg [%02x:%02x:%04x:%08x]\n",
+			       pkt.tag.type, pkt.tag.stype,
+			       pkt.tag.stype_env, pkt.tag.sid);
+			rv = -ECONNRESET;
+			break;
+		}
+
+		WARN_ON(rv != LDC_PACKET_SIZE);
+	}
+
+done:
+	return rv;
+}
+
+static void vcc_rx_timer(unsigned long index)
+{
+	struct vio_driver_state *vio;
+	struct vcc_port *port;
+	unsigned long flags;
+	int rv;
+
+	port = vcc_get_ne(index);
+	if (!port)
+		return;
+
+	spin_lock_irqsave(&port->lock, flags);
+	TIMER_CLEAR(port, rx);
+
+	vio = &port->vio;
+
+	enable_irq(vio->vdev->rx_irq);
+
+	if (!port->tty)
+		goto done;
+
+	rv = vcc_ldc_read(port);
+	if (rv = -ECONNRESET)
+		vio_conn_reset(vio);
+
+done:
+	spin_unlock_irqrestore(&port->lock, flags);
+	vcc_put(port, false);
+}
+
+static void vcc_tx_timer(unsigned long index)
+{
+	struct vcc_port *port;
+	struct vio_vcc *pkt;
+	unsigned long flags;
+	int tosend = 0;
+	int rv;
+
+	port = vcc_get_ne(index);
+	if (!port)
+		return;
+
+	spin_lock_irqsave(&port->lock, flags);
+	TIMER_CLEAR(port, tx);
+
+	if (!port->tty)
+		goto done;
+
+	tosend = min(VCC_BUFF_LEN, port->chars_in_buffer);
+	if (!tosend)
+		goto done;
+
+	pkt = &port->buffer;
+	pkt->tag.type = VIO_TYPE_DATA;
+	pkt->tag.stype = tosend;
+	vccdbgl(port->vio.lp);
+
+	rv = ldc_write(port->vio.lp, pkt, (VIO_TAG_SIZE + tosend));
+	WARN_ON(!rv);
+
+	if (rv < 0) {
+		vccdbg("VCC: ldc_write()=%d\n", rv);
+		vcc_kick_tx(port);
+	} else {
+		struct tty_struct *tty = port->tty;
+
+		port->chars_in_buffer = 0;
+		if (tty)
+			tty_wakeup(tty);
+	}
+
+done:
+	spin_unlock_irqrestore(&port->lock, flags);
+	vcc_put(port, false);
+}
+
 static void vcc_event(void *arg, int event)
 {
 }
@@ -322,7 +509,7 @@ static ssize_t vcc_sysfs_break_store(struct device *dev,
 	if (sscanf(buf, "%ud", &brk) != 1 || brk != 1)
 		rv = -EINVAL;
 	else if (vcc_send_ctl(port, VCC_CTL_BREAK) < 0)
-		pr_err("VCC: unable to send CTL_BREAK\n");
+		vcc_kick_tx(port);
 
 	spin_unlock_irqrestore(&port->lock, flags);
 
@@ -428,6 +615,14 @@ static int vcc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 	if (rv)
 		goto free_domain;
 
+	init_timer(&port->rx_timer);
+	port->rx_timer.function = vcc_rx_timer;
+	port->rx_timer.data = port->index;
+
+	init_timer(&port->tx_timer);
+	port->tx_timer.function = vcc_tx_timer;
+	port->tx_timer.data = port->index;
+
 	dev_set_drvdata(&vdev->dev, port);
 
 	/* It's possible to receive IRQs in the middle of vio_port_up. Disable
-- 
1.7.1

