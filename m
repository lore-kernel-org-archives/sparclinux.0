From: Olaf Hering <olaf@aepfle.de>
Date: Thu, 24 Apr 2008 13:16:00 +0000
Subject: [PATCH v5] create modalias file in sysfs for bus of_platform
Message-Id: <20080424131600.GA15226@aepfle.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20080122142109.GA12967@aepfle.de>
	<20080122144053.GA13019@aepfle.de>
	<20080122190939.GA14124@aepfle.de>
	<18330.32110.449914.354218@cargo.ozlabs.ibm.com>
	<20080126100427.GA1162@aepfle.de>
In-Reply-To: <20080126100427.GA1162@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mackerras <paulus@samba.org>
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org

Create /sys/bus/of_platform/devices/*/modalias file to allow autoloading
of modules. modalias files are already present for many other bus types.
This adds also a newline to the devspec files.

Also create a devspec file for mac-io devices. They were created as a side
effect. Use correct buffer size for mac-io modalias buffer.

Tested on iBook1 and Efika.

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 drivers/macintosh/macio_sysfs.c |   12 +++++++++++-
 drivers/of/device.c             |   36 ++++++++++++++++++++----------------
 drivers/of/platform.c           |    3 +++
 3 files changed, 34 insertions(+), 17 deletions(-)

--- a/drivers/macintosh/macio_sysfs.c
+++ b/drivers/macintosh/macio_sysfs.c
@@ -44,7 +44,7 @@ static ssize_t modalias_show (struct dev
 	struct of_device *ofdev = to_of_device(dev);
 	int len;
 
-	len = of_device_get_modalias(ofdev, buf, PAGE_SIZE);
+	len = of_device_get_modalias(ofdev, buf, PAGE_SIZE - 2);
 
 	buf[len] = '\n';
 	buf[len+1] = 0;
@@ -52,6 +52,15 @@ static ssize_t modalias_show (struct dev
 	return len+1;
 }
 
+static ssize_t devspec_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct of_device *ofdev;
+
+	ofdev = to_of_device(dev);
+	return sprintf(buf, "%s\n", ofdev->node->full_name);
+}
+
 macio_config_of_attr (name, "%s\n");
 macio_config_of_attr (type, "%s\n");
 
@@ -60,5 +69,6 @@ struct device_attribute macio_dev_attrs[
 	__ATTR_RO(type),
 	__ATTR_RO(compatible),
 	__ATTR_RO(modalias),
+	__ATTR_RO(devspec),
 	__ATTR_NULL
 };
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -48,16 +48,32 @@ void of_dev_put(struct of_device *dev)
 }
 EXPORT_SYMBOL(of_dev_put);
 
-static ssize_t dev_show_devspec(struct device *dev,
+static ssize_t devspec_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct of_device *ofdev;
 
 	ofdev = to_of_device(dev);
-	return sprintf(buf, "%s", ofdev->node->full_name);
+	return sprintf(buf, "%s\n", ofdev->node->full_name);
 }
 
-static DEVICE_ATTR(devspec, S_IRUGO, dev_show_devspec, NULL);
+static ssize_t modalias_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct of_device *ofdev = to_of_device(dev);
+	ssize_t len = 0;
+
+	len = of_device_get_modalias(ofdev, buf, PAGE_SIZE - 2);
+	buf[len] = '\n';
+	buf[len+1] = 0;
+	return len+1;
+}
+
+struct device_attribute of_platform_device_attrs[] = {
+	__ATTR_RO(devspec),
+	__ATTR_RO(modalias),
+	__ATTR_NULL
+};
 
 /**
  * of_release_dev - free an of device structure when all users of it are finished.
@@ -78,25 +94,13 @@ EXPORT_SYMBOL(of_release_dev);
 
 int of_device_register(struct of_device *ofdev)
 {
-	int rc;
-
 	BUG_ON(ofdev->node = NULL);
-
-	rc = device_register(&ofdev->dev);
-	if (rc)
-		return rc;
-
-	rc = device_create_file(&ofdev->dev, &dev_attr_devspec);
-	if (rc)
-		device_unregister(&ofdev->dev);
-
-	return rc;
+	return device_register(&ofdev->dev);
 }
 EXPORT_SYMBOL(of_device_register);
 
 void of_device_unregister(struct of_device *ofdev)
 {
-	device_remove_file(&ofdev->dev, &dev_attr_devspec);
 	device_unregister(&ofdev->dev);
 }
 EXPORT_SYMBOL(of_device_unregister);
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -17,6 +17,8 @@
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
 
+extern struct device_attribute of_platform_device_attrs[];
+
 static int of_platform_bus_match(struct device *dev, struct device_driver *drv)
 {
 	struct of_device *of_dev = to_of_device(dev);
@@ -103,6 +105,7 @@ int of_bus_type_init(struct bus_type *bu
 	bus->suspend = of_platform_device_suspend;
 	bus->resume = of_platform_device_resume;
 	bus->shutdown = of_platform_device_shutdown;
+	bus->dev_attrs = of_platform_device_attrs;
 	return bus_register(bus);
 }
 
