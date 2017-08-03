From: Jag Raman <jag.raman@oracle.com>
Date: Thu, 03 Aug 2017 17:44:00 +0000
Subject: [PATCH v1 08/13] sparc64: vcc: Add open & close TTY operations
Message-Id: <aba9f54eac78807e180945e8af7ef0abc2ebffdf.1501781770.git.jag.raman@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Add handlers to support TTY open & close operations

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/tty/vcc.c |   63 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 62 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index 8f4afdb..b9f6aea 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -745,7 +745,68 @@ static int vcc_remove(struct vio_dev *vdev)
 	.name		= "vcc",
 };
 
-static const struct tty_operations vcc_ops;
+static int vcc_open(struct tty_struct *tty, struct file *vcc_file)
+{
+	struct vcc_port *port;
+
+	if (unlikely(!tty)) {
+		pr_err("VCC: open: Invalid TTY handle\n");
+		return -ENXIO;
+	}
+
+	if (tty->count > 1)
+		return -EBUSY;
+
+	port = vcc_get_ne(tty->index);
+	if (unlikely(!port)) {
+		pr_err("VCC: open: Failed to find VCC port\n");
+		return -ENODEV;
+	}
+
+	if (unlikely(!port->vio.lp)) {
+		pr_err("VCC: open: LDC channel not configured\n");
+		vcc_put(port, false);
+		return -EPIPE;
+	}
+	vccdbgl(port->vio.lp);
+
+	vcc_put(port, false);
+
+	if (unlikely(!tty->port)) {
+		pr_err("VCC: open: TTY port not found\n");
+		return -ENXIO;
+	}
+
+	if (unlikely(!tty->port->ops)) {
+		pr_err("VCC: open: TTY ops not defined\n");
+		return -ENXIO;
+	}
+
+	return tty_port_open(tty->port, tty, vcc_file);
+}
+
+static void vcc_close(struct tty_struct *tty, struct file *vcc_file)
+{
+	if (unlikely(!tty)) {
+		pr_err("VCC: close: Invalid TTY handle\n");
+		return;
+	}
+
+	if (unlikely(tty->count > 1))
+		return;
+
+	if (unlikely(!tty->port)) {
+		pr_err("VCC: close: TTY port not found\n");
+		return;
+	}
+
+	tty_port_close(tty->port, tty, vcc_file);
+}
+
+static const struct tty_operations vcc_ops = {
+	.open	= vcc_open,
+	.close	= vcc_close,
+};
 
 #define VCC_TTY_FLAGS   (TTY_DRIVER_DYNAMIC_DEV | TTY_DRIVER_REAL_RAW)
 
-- 
1.7.1

