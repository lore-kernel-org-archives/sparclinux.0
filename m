From: Jag Raman <jag.raman@oracle.com>
Date: Tue, 15 Aug 2017 21:03:08 +0000
Subject: [PATCH v2 12/13] sparc64: vcc: Add break_ctl TTY operation
Message-Id: <2cde62d84d824f27f5087ea1ec63a17963f44665.1502829972.git.jag.raman@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Add handler to support TTY break_ctl operation

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/tty/vcc.c |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index 070c541..f913217 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -960,6 +960,40 @@ static int vcc_chars_in_buffer(struct tty_struct *tty)
 	return num;
 }
 
+static int vcc_break_ctl(struct tty_struct *tty, int state)
+{
+	struct vcc_port *port;
+	unsigned long flags;
+
+	if (unlikely(!tty)) {
+		pr_err("VCC: break_ctl: Invalid TTY handle\n");
+		return -ENXIO;
+	}
+
+	port = vcc_get_ne(tty->index);
+	if (unlikely(!port)) {
+		pr_err("VCC: break_ctl: Failed to find VCC port\n");
+		return -ENODEV;
+	}
+
+	/* Turn off break */
+	if (state = 0) {
+		vcc_put(port, false);
+		return 0;
+	}
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	if (vcc_send_ctl(port, VCC_CTL_BREAK) < 0)
+		vcc_kick_tx(port);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	vcc_put(port, false);
+
+	return 0;
+}
+
 static const struct tty_operations vcc_ops = {
 	.open			= vcc_open,
 	.close			= vcc_close,
@@ -967,6 +1001,7 @@ static int vcc_chars_in_buffer(struct tty_struct *tty)
 	.write			= vcc_write,
 	.write_room		= vcc_write_room,
 	.chars_in_buffer	= vcc_chars_in_buffer,
+	.break_ctl		= vcc_break_ctl,
 };
 
 #define VCC_TTY_FLAGS   (TTY_DRIVER_DYNAMIC_DEV | TTY_DRIVER_REAL_RAW)
-- 
1.7.1

