From: Jag Raman <jag.raman@oracle.com>
Date: Tue, 15 Aug 2017 21:03:01 +0000
Subject: [PATCH v2 05/13] sparc64: vcc: Create sysfs attribute group
Message-Id: <903983656b5558b03e6a9cd14d9218144855871c.1502829972.git.jag.raman@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Create sysfs attribute group to show the domain name and
send break command.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 v2: remove sysfs attr group during cleanup

 drivers/tty/vcc.c |   82 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 82 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index 4edace1..72e0879 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -7,6 +7,7 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/sysfs.h>
 #include <linux/tty.h>
 #include <asm/vio.h>
 #include <asm/ldc.h>
@@ -52,6 +53,9 @@ struct vcc_port {
 #define VCC_MAX_PORTS		1024
 #define VCC_MINOR_START		0	/* must be zero */
 
+#define VCC_CTL_BREAK		-1
+#define VCC_CTL_HUP		-2
+
 static const char vcc_driver_name[] = "vcc";
 static const char vcc_device_node[] = "vcc";
 static struct tty_driver *vcc_tty_driver;
@@ -268,6 +272,77 @@ static void vcc_event(void *arg, int event)
 	{ .major = 1, .minor = 0 },
 };
 
+static ssize_t vcc_sysfs_domain_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct vcc_port *port;
+	int rv;
+
+	port = dev_get_drvdata(dev);
+	if (!port)
+		return -ENODEV;
+
+	rv = scnprintf(buf, PAGE_SIZE, "%s\n", port->domain);
+
+	return rv;
+}
+
+static int vcc_send_ctl(struct vcc_port *port, int ctl)
+{
+	struct vio_vcc pkt;
+	int rv;
+
+	pkt.tag.type = VIO_TYPE_CTRL;
+	pkt.tag.sid = ctl;
+	pkt.tag.stype = 0;
+
+	rv = ldc_write(port->vio.lp, &pkt, sizeof(pkt.tag));
+	WARN_ON(!rv);
+	vccdbg("VCC: ldc_write(%ld)=%d\n", sizeof(pkt.tag), rv);
+
+	return rv;
+}
+
+static ssize_t vcc_sysfs_break_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct vcc_port *port;
+	unsigned long flags;
+	int rv = count;
+	int brk;
+
+	port = dev_get_drvdata(dev);
+	if (!port)
+		return -ENODEV;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	if (sscanf(buf, "%ud", &brk) != 1 || brk != 1)
+		rv = -EINVAL;
+	else if (vcc_send_ctl(port, VCC_CTL_BREAK) < 0)
+		pr_err("VCC: unable to send CTL_BREAK\n");
+
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	return rv;
+}
+
+static DEVICE_ATTR(domain, 0400, vcc_sysfs_domain_show, NULL);
+static DEVICE_ATTR(break, 0200, NULL, vcc_sysfs_break_store);
+
+static struct attribute *vcc_sysfs_entries[] = {
+	&dev_attr_domain.attr,
+	&dev_attr_break.attr,
+	NULL
+};
+
+static struct attribute_group vcc_attribute_group = {
+	.name = NULL,
+	.attrs = vcc_sysfs_entries,
+};
+
 /**
  * vcc_probe() - Initialize VCC port
  * @vdev: Pointer to VIO device of the new VCC port
@@ -349,6 +424,10 @@ static int vcc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 
 	mdesc_release(hp);
 
+	rv = sysfs_create_group(&vdev->dev.kobj, &vcc_attribute_group);
+	if (rv)
+		goto free_domain;
+
 	dev_set_drvdata(&vdev->dev, port);
 
 	/* It's possible to receive IRQs in the middle of vio_port_up. Disable
@@ -360,6 +439,8 @@ static int vcc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 
 	return 0;
 
+free_domain:
+	kfree(port->domain);
 unreg_tty:
 	tty_unregister_device(vcc_tty_driver, port->index);
 free_table:
@@ -408,6 +489,7 @@ static int vcc_remove(struct vio_dev *vdev)
 
 	del_timer_sync(&port->vio.timer);
 	vio_ldc_free(&port->vio);
+	sysfs_remove_group(&vdev->dev.kobj, &vcc_attribute_group);
 	dev_set_drvdata(&vdev->dev, NULL);
 
 	if (port->tty) {
-- 
1.7.1

