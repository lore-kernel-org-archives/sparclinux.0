From: Jag Raman <jag.raman@oracle.com>
Date: Tue, 15 Aug 2017 21:03:06 +0000
Subject: [PATCH v2 10/13] sparc64: vcc: Add write & write_room TTY operations
Message-Id: <1dda16cbd80d137a2e0e7a4c0cca8d7718a5347a.1502829972.git.jag.raman@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Add handlers to support TTY write & write_room operations

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/tty/vcc.c |  101 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 98 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index 67be5a5..0c0fe22 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -844,10 +844,105 @@ static void vcc_hangup(struct tty_struct *tty)
 	tty_port_hangup(tty->port);
 }
 
+static int vcc_write(struct tty_struct *tty, const unsigned char *buf,
+		     int count)
+{
+	struct vcc_port *port;
+	struct vio_vcc *pkt;
+	unsigned long flags;
+	int total_sent = 0;
+	int tosend = 0;
+	int rv = -EINVAL;
+
+	if (unlikely(!tty)) {
+		pr_err("VCC: write: Invalid TTY handle\n");
+		return -ENXIO;
+	}
+
+	port = vcc_get_ne(tty->index);
+	if (unlikely(!port)) {
+		pr_err("VCC: write: Failed to find VCC port");
+		return -ENODEV;
+	}
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	pkt = &port->buffer;
+	pkt->tag.type = VIO_TYPE_DATA;
+
+	while (count > 0) {
+		/* Minimum of data to write and space available */
+		tosend = min(count, (VCC_BUFF_LEN - port->chars_in_buffer));
+
+		if (!tosend)
+			break;
+
+		memcpy(&pkt->data[port->chars_in_buffer], &buf[total_sent],
+		       tosend);
+		port->chars_in_buffer += tosend;
+		pkt->tag.stype = tosend;
+
+		vccdbg("TAG [%02x:%02x:%04x:%08x]\n", pkt->tag.type,
+		       pkt->tag.stype, pkt->tag.stype_env, pkt->tag.sid);
+		vccdbg("DATA [%s]\n", pkt->data);
+		vccdbgl(port->vio.lp);
+
+		/* Since we know we have enough room in VCC buffer for tosend
+		 * we record that it was sent regardless of whether the
+		 * hypervisor actually took it because we have it buffered.
+		 */
+		rv = ldc_write(port->vio.lp, pkt, (VIO_TAG_SIZE + tosend));
+		vccdbg("VCC: write: ldc_write(%d)=%d\n",
+		       (VIO_TAG_SIZE + tosend), rv);
+
+		total_sent += tosend;
+		count -= tosend;
+		if (rv < 0) {
+			vcc_kick_tx(port);
+			break;
+		}
+
+		port->chars_in_buffer = 0;
+	}
+
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	vcc_put(port, false);
+
+	vccdbg("VCC: write: total=%d rv=%d", total_sent, rv);
+
+	return total_sent ? total_sent : rv;
+}
+
+static int vcc_write_room(struct tty_struct *tty)
+{
+	struct vcc_port *port;
+	u64 num;
+
+	if (unlikely(!tty)) {
+		pr_err("VCC: write_room: Invalid TTY handle\n");
+		return -ENXIO;
+	}
+
+	port = vcc_get_ne(tty->index);
+	if (unlikely(!port)) {
+		pr_err("VCC: write_room: Failed to find VCC port\n");
+		return -ENODEV;
+	}
+
+	num = VCC_BUFF_LEN - port->chars_in_buffer;
+
+	vcc_put(port, false);
+
+	return num;
+}
+
 static const struct tty_operations vcc_ops = {
-	.open	= vcc_open,
-	.close	= vcc_close,
-	.hangup	= vcc_hangup,
+	.open		= vcc_open,
+	.close		= vcc_close,
+	.hangup		= vcc_hangup,
+	.write		= vcc_write,
+	.write_room	= vcc_write_room,
 };
 
 #define VCC_TTY_FLAGS   (TTY_DRIVER_DYNAMIC_DEV | TTY_DRIVER_REAL_RAW)
-- 
1.7.1

