From: Jag Raman <jag.raman@oracle.com>
Date: Tue, 15 Aug 2017 21:03:09 +0000
Subject: [PATCH v2 13/13] sparc64: vcc: Add install & cleanup TTY operations
Message-Id: <7c9f989c3e6b36e07fd81a898c3ffbffeefdbd56.1502829972.git.jag.raman@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Add handlers to support TTY install & cleanup operations

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/tty/vcc.c |   73 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 73 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index f913217..5e60817 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -487,6 +487,8 @@ static void vcc_event(void *arg, int event)
 	{ .major = 1, .minor = 0 },
 };
 
+static struct tty_port_operations vcc_port_ops = { 0 };
+
 static ssize_t vcc_sysfs_domain_show(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
@@ -994,6 +996,75 @@ static int vcc_break_ctl(struct tty_struct *tty, int state)
 	return 0;
 }
 
+static int vcc_install(struct tty_driver *driver, struct tty_struct *tty)
+{
+	struct vcc_port *port_vcc;
+	struct tty_port *port_tty;
+	int ret;
+
+	if (unlikely(!tty)) {
+		pr_err("VCC: install: Invalid TTY handle\n");
+		return -ENXIO;
+	}
+
+	if (tty->index >= VCC_MAX_PORTS)
+		return -EINVAL;
+
+	ret = tty_standard_install(driver, tty);
+	if (ret)
+		return ret;
+
+	port_tty = kzalloc(sizeof(struct tty_port), GFP_KERNEL);
+	if (!port_tty)
+		return -ENOMEM;
+
+	port_vcc = vcc_get(tty->index, true);
+	if (!port_vcc) {
+		pr_err("VCC: install: Failed to find VCC port\n");
+		tty->port = NULL;
+		kfree(port_tty);
+		return -ENODEV;
+	}
+
+	tty_port_init(port_tty);
+	port_tty->ops = &vcc_port_ops;
+	tty->port = port_tty;
+
+	port_vcc->tty = tty;
+
+	vcc_put(port_vcc, true);
+
+	return 0;
+}
+
+static void vcc_cleanup(struct tty_struct *tty)
+{
+	struct vcc_port *port;
+
+	if (unlikely(!tty)) {
+		pr_err("VCC: cleanup: Invalid TTY handle\n");
+		return;
+	}
+
+	port = vcc_get(tty->index, true);
+	if (port) {
+		port->tty = NULL;
+
+		if (port->removed) {
+			vcc_table_remove(tty->index);
+			kfree(port->vio.name);
+			kfree(port->domain);
+			kfree(port);
+		} else {
+			vcc_put(port, true);
+		}
+	}
+
+	tty_port_destroy(tty->port);
+	kfree(tty->port);
+	tty->port = NULL;
+}
+
 static const struct tty_operations vcc_ops = {
 	.open			= vcc_open,
 	.close			= vcc_close,
@@ -1002,6 +1073,8 @@ static int vcc_break_ctl(struct tty_struct *tty, int state)
 	.write_room		= vcc_write_room,
 	.chars_in_buffer	= vcc_chars_in_buffer,
 	.break_ctl		= vcc_break_ctl,
+	.install		= vcc_install,
+	.cleanup		= vcc_cleanup,
 };
 
 #define VCC_TTY_FLAGS   (TTY_DRIVER_DYNAMIC_DEV | TTY_DRIVER_REAL_RAW)
-- 
1.7.1

