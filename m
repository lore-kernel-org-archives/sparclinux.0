From: Jim Quigley <Jim.Quigley@oracle.com>
Date: Fri, 21 Jul 2017 13:20:15 +0000
Subject: [PATCH] sunvdc: prevent sunvdc panic when mpgroup disk added to guest domain
Message-Id: <1500643215-261720-1-git-send-email-Jim.Quigley@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Using mpgroup to define multiple paths for a virtual disk causes multiple
virtual-device-port ports to be created for that virtual device.
Each virtual-device-port port then gets a vdisk created for it by the Linux
sunvdc driver. As mpgroup is not supported by the Linux sunvdc driver it
cannot handle multiple ports for a single vdisk, leading to a kernel panic
at startup.

This fix prevents more than one vdisk per virtual-device-port being created
until full virtual disk multipathing (mpgroup) support is implemented.

Signed-off-by: Jim Quigley <Jim.Quigley@oracle.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Reviewed-by: Aaron Young <aaron.young@oracle.com>
---
 drivers/block/sunvdc.c |   61 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index 6b16ead..ad97494 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -875,6 +875,56 @@ static void print_version(void)
 		printk(KERN_INFO "%s", version);
 }
 
+struct vdc_check_port_data {
+	int	dev_no;
+	char	*type;
+};
+
+static int vdc_device_probed(struct device *dev, void *arg)
+{
+	struct vio_dev *vdev = to_vio_dev(dev);
+	struct vdc_check_port_data *port_data;
+
+	port_data = (struct vdc_check_port_data *)arg;
+
+	if ((vdev->dev_no = port_data->dev_no) &&
+	    (!(strcmp((char *)&vdev->type, port_data->type))) &&
+		dev_get_drvdata(dev)) {
+		/* This device has already been configured
+		 * by vdc_port_probe()
+		 */
+		return 1;
+	} else {
+		return 0;
+	}
+}
+
+/* Determine whether the VIO device is part of an mpgroup
+ * by locating all the virtual-device-port nodes associated
+ * with the parent virtual-device node for the VIO device
+ * and checking whether any of these nodes are vdc-ports
+ * which have already been configured.
+ *
+ * Returns true if this device is part of an mpgroup and has
+ * already been probed.
+ */
+static bool vdc_port_mpgroup_check(struct vio_dev *vdev)
+{
+	struct vdc_check_port_data port_data;
+	struct device *dev;
+
+	port_data.dev_no = vdev->dev_no;
+	port_data.type = (char *)&vdev->type;
+
+	dev = device_find_child(vdev->dev.parent, &port_data,
+				vdc_device_probed);
+
+	if (dev)
+		return true;
+
+	return false;
+}
+
 static int vdc_port_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 {
 	struct mdesc_handle *hp;
@@ -893,6 +943,14 @@ static int vdc_port_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 		goto err_out_release_mdesc;
 	}
 
+	/* Check if this device is part of an mpgroup */
+	if (vdc_port_mpgroup_check(vdev)) {
+		printk(KERN_WARNING
+			"VIO: Ignoring extra vdisk port %s",
+			dev_name(&vdev->dev));
+		goto err_out_release_mdesc;
+	}
+
 	port = kzalloc(sizeof(*port), GFP_KERNEL);
 	err = -ENOMEM;
 	if (!port) {
@@ -943,6 +1001,9 @@ static int vdc_port_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 	if (err)
 		goto err_out_free_tx_ring;
 
+	/* Note that the device driver_data is used to determine
+	 * whether the port has been probed.
+	 */
 	dev_set_drvdata(&vdev->dev, port);
 
 	mdesc_release(hp);
-- 
1.7.1

