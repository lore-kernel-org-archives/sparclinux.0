From: Jag Raman <jag.raman@oracle.com>
Date: Thu, 03 Aug 2017 17:44:01 +0000
Subject: [PATCH v1 09/13] sparc64: vcc: Add hangup TTY operation
Message-Id: <dc756d745a3dfcb75da153c69b841b9e886d4934.1501781770.git.jag.raman@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Add handler to support TTY hangup operation

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/tty/vcc.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index b9f6aea..fef6ab4 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -803,9 +803,50 @@ static void vcc_close(struct tty_struct *tty, struct file *vcc_file)
 	tty_port_close(tty->port, tty, vcc_file);
 }
 
+static void vcc_ldc_hup(struct vcc_port *port)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	if (vcc_send_ctl(port, VCC_CTL_HUP) < 0)
+		vcc_kick_tx(port);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static void vcc_hangup(struct tty_struct *tty)
+{
+	struct vcc_port *port;
+
+	if (unlikely(!tty)) {
+		pr_err("VCC: hangup: Invalid TTY handle\n");
+		return;
+	}
+
+	port = vcc_get_ne(tty->index);
+	if (unlikely(!port)) {
+		pr_err("VCC: hangup: Failed to find VCC port\n");
+		return;
+	}
+
+	if (unlikely(!tty->port)) {
+		pr_err("VCC: hangup: TTY port not found\n");
+		vcc_put(port, false);
+		return;
+	}
+
+	vcc_ldc_hup(port);
+
+	vcc_put(port, false);
+
+	tty_port_hangup(tty->port);
+}
+
 static const struct tty_operations vcc_ops = {
 	.open	= vcc_open,
 	.close	= vcc_close,
+	.hangup	= vcc_hangup,
 };
 
 #define VCC_TTY_FLAGS   (TTY_DRIVER_DYNAMIC_DEV | TTY_DRIVER_REAL_RAW)
-- 
1.7.1

