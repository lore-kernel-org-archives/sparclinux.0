From: Jag Raman <jag.raman@oracle.com>
Date: Thu, 03 Aug 2017 17:44:04 +0000
Subject: [PATCH v1 12/13] sparc64: vcc: Add break_ctl TTY operation
Message-Id: <15cc233d3b083e8ad7a64ef674dc207e724ac597.1501781770.git.jag.raman@oracle.com>
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
index f7325f8..16e2f9e 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -959,6 +959,40 @@ static int vcc_chars_in_buffer(struct tty_struct *tty)
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
@@ -966,6 +1000,7 @@ static int vcc_chars_in_buffer(struct tty_struct *tty)
 	.write			= vcc_write,
 	.write_room		= vcc_write_room,
 	.chars_in_buffer	= vcc_chars_in_buffer,
+	.break_ctl		= vcc_break_ctl,
 };
 
 #define VCC_TTY_FLAGS   (TTY_DRIVER_DYNAMIC_DEV | TTY_DRIVER_REAL_RAW)
-- 
1.7.1

