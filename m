From: Olaf Hering <olaf@aepfle.de>
Date: Sat, 26 Jan 2008 10:04:27 +0000
Subject: [PATCH v4] create modalias file in sysfs for bus of_platform
Message-Id: <20080126100427.GA1162@aepfle.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20080122142109.GA12967@aepfle.de>
	<20080122144053.GA13019@aepfle.de>
	<20080122190939.GA14124@aepfle.de>
	<18330.32110.449914.354218@cargo.ozlabs.ibm.com>
In-Reply-To: <18330.32110.449914.354218@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mackerras <paulus@samba.org>
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org

Create /sys/bus/of_platform/devices/*/modalias file to allow autoloading
of modules. modalias files are already present for many other bus types.

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 drivers/of/device.c   |   33 ++++++++++++++++++---------------
 drivers/of/platform.c |    3 +++
 2 files changed, 21 insertions(+), 15 deletions(-)

Index: linux-2.6/drivers/of/device.c
=================================--- linux-2.6.orig/drivers/of/device.c
+++ linux-2.6/drivers/of/device.c
@@ -77,7 +77,7 @@ void of_dev_put(struct of_device *dev)
 }
 EXPORT_SYMBOL(of_dev_put);
 
-static ssize_t dev_show_devspec(struct device *dev,
+static ssize_t devspec_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct of_device *ofdev;
@@ -86,7 +86,22 @@ static ssize_t dev_show_devspec(struct d
 	return sprintf(buf, "%s", ofdev->node->full_name);
 }
 
-static DEVICE_ATTR(devspec, S_IRUGO, dev_show_devspec, NULL);
+static ssize_t modalias_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	ssize_t len;
+
+	len = of_device_get_modalias(to_of_device(dev), buf, PAGE_SIZE - 2);
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
@@ -107,25 +122,13 @@ EXPORT_SYMBOL(of_release_dev);
 
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
Index: linux-2.6/drivers/of/platform.c
=================================--- linux-2.6.orig/drivers/of/platform.c
+++ linux-2.6/drivers/of/platform.c
@@ -17,6 +17,8 @@
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
 
+extern struct device_attribute of_platform_device_attrs[];
+
 static int of_platform_bus_match(struct device *dev, struct device_driver *drv)
 {
 	struct of_device *of_dev = to_of_device(dev);
@@ -93,6 +95,7 @@ int of_bus_type_init(struct bus_type *bu
 	bus->remove = of_platform_device_remove;
 	bus->suspend = of_platform_device_suspend;
 	bus->resume = of_platform_device_resume;
+	bus->dev_attrs = of_platform_device_attrs;
 	return bus_register(bus);
 }
 
