From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 19 Jul 2007 15:16:12 +0000
Subject: [PATCH 08/12] Begin to consolidate of_device.c
Message-Id: <20070720011612.cc101b92.sfr@canb.auug.org.au>
List-Id: <sparclinux.vger.kernel.org>
References: <20070718173024.50204a1a.sfr@canb.auug.org.au>
	<20070720010742.e60c67a7.sfr@canb.auug.org.au>
In-Reply-To: <20070720010742.e60c67a7.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ppc-dev <linuxppc-dev@ozlabs.org>, sparclinux@vger.kernel.org
Cc: paulus@samba.org, "David S. Miller" <davem@davemloft.net>, wli@holomorphy.com

This moves all the common parts for the Sparc, Sparc64 and PowerPC
of_device.c files into drivers/of/device.c.

Apart from the simple move, Sparc gains of_match_node() and a call to
of_node_put in of_release_dev().  PowerPC gains better recovery if
device_create_file() fails in of_device_register().

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/of_device.c |  122 +------------------------------------
 arch/sparc/kernel/of_device.c   |  109 +--------------------------------
 arch/sparc64/kernel/of_device.c |  114 +---------------------------------
 drivers/Kconfig                 |    2 +
 drivers/of/Kconfig              |    3 +
 drivers/of/Makefile             |    1 +
 drivers/of/device.c             |  131 +++++++++++++++++++++++++++++++++++++++
 7 files changed, 142 insertions(+), 340 deletions(-)
 create mode 100644 drivers/of/Kconfig
 create mode 100644 drivers/of/device.c

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/of_device.c b/arch/powerpc/kernel/of_device.c
index a464d67..89b911e 100644
--- a/arch/powerpc/kernel/of_device.c
+++ b/arch/powerpc/kernel/of_device.c
@@ -1,5 +1,6 @@
 #include <linux/string.h>
 #include <linux/kernel.h>
+#include <linux/of.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
@@ -8,118 +9,6 @@
 #include <asm/errno.h>
 #include <asm/of_device.h>
 
-/**
- * of_match_node - Tell if an device_node has a matching of_match structure
- * @ids: array of of device match structures to search in
- * @node: the of device structure to match against
- *
- * Low level utility function used by device matching.
- */
-const struct of_device_id *of_match_node(const struct of_device_id *matches,
-					 const struct device_node *node)
-{
-	while (matches->name[0] || matches->type[0] || matches->compatible[0]) {
-		int match = 1;
-		if (matches->name[0])
-			match &= node->name
-				&& !strcmp(matches->name, node->name);
-		if (matches->type[0])
-			match &= node->type
-				&& !strcmp(matches->type, node->type);
-		if (matches->compatible[0])
-			match &= of_device_is_compatible(node,
-						      matches->compatible);
-		if (match)
-			return matches;
-		matches++;
-	}
-	return NULL;
-}
-
-/**
- * of_match_device - Tell if an of_device structure has a matching
- * of_match structure
- * @ids: array of of device match structures to search in
- * @dev: the of device structure to match against
- *
- * Used by a driver to check whether an of_device present in the
- * system is in its list of supported devices.
- */
-const struct of_device_id *of_match_device(const struct of_device_id *matches,
-					const struct of_device *dev)
-{
-	if (!dev->node)
-		return NULL;
-	return of_match_node(matches, dev->node);
-}
-
-struct of_device *of_dev_get(struct of_device *dev)
-{
-	struct device *tmp;
-
-	if (!dev)
-		return NULL;
-	tmp = get_device(&dev->dev);
-	if (tmp)
-		return to_of_device(tmp);
-	else
-		return NULL;
-}
-
-void of_dev_put(struct of_device *dev)
-{
-	if (dev)
-		put_device(&dev->dev);
-}
-
-static ssize_t dev_show_devspec(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	struct of_device *ofdev;
-
-	ofdev = to_of_device(dev);
-	return sprintf(buf, "%s", ofdev->node->full_name);
-}
-
-static DEVICE_ATTR(devspec, S_IRUGO, dev_show_devspec, NULL);
-
-/**
- * of_release_dev - free an of device structure when all users of it are finished.
- * @dev: device that's been disconnected
- *
- * Will be called only by the device core when all users of this of device are
- * done.
- */
-void of_release_dev(struct device *dev)
-{
-	struct of_device *ofdev;
-
-        ofdev = to_of_device(dev);
-	of_node_put(ofdev->node);
-	kfree(ofdev);
-}
-
-int of_device_register(struct of_device *ofdev)
-{
-	int rc;
-
-	BUG_ON(ofdev->node = NULL);
-
-	rc = device_register(&ofdev->dev);
-	if (rc)
-		return rc;
-
-	return device_create_file(&ofdev->dev, &dev_attr_devspec);
-}
-
-void of_device_unregister(struct of_device *ofdev)
-{
-	device_remove_file(&ofdev->dev, &dev_attr_devspec);
-
-	device_unregister(&ofdev->dev);
-}
-
-
 ssize_t of_device_get_modalias(struct of_device *ofdev,
 				char *str, ssize_t len)
 {
@@ -229,14 +118,5 @@ int of_device_uevent(struct device *dev,
 
 	return 0;
 }
-
-
-EXPORT_SYMBOL(of_match_node);
-EXPORT_SYMBOL(of_match_device);
-EXPORT_SYMBOL(of_device_register);
-EXPORT_SYMBOL(of_device_unregister);
-EXPORT_SYMBOL(of_dev_get);
-EXPORT_SYMBOL(of_dev_put);
-EXPORT_SYMBOL(of_release_dev);
 EXPORT_SYMBOL(of_device_uevent);
 EXPORT_SYMBOL(of_device_get_modalias);
diff --git a/arch/sparc/kernel/of_device.c b/arch/sparc/kernel/of_device.c
index fd7f8cb..0760b81 100644
--- a/arch/sparc/kernel/of_device.c
+++ b/arch/sparc/kernel/of_device.c
@@ -1,5 +1,6 @@
 #include <linux/string.h>
 #include <linux/kernel.h>
+#include <linux/of.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
@@ -8,38 +9,6 @@
 #include <asm/errno.h>
 #include <asm/of_device.h>
 
-/**
- * of_match_device - Tell if an of_device structure has a matching
- * of_match structure
- * @ids: array of of device match structures to search in
- * @dev: the of device structure to match against
- *
- * Used by a driver to check whether an of_device present in the
- * system is in its list of supported devices.
- */
-const struct of_device_id *of_match_device(const struct of_device_id *matches,
-					const struct of_device *dev)
-{
-	if (!dev->node)
-		return NULL;
-	while (matches->name[0] || matches->type[0] || matches->compatible[0]) {
-		int match = 1;
-		if (matches->name[0])
-			match &= dev->node->name
-				&& !strcmp(matches->name, dev->node->name);
-		if (matches->type[0])
-			match &= dev->node->type
-				&& !strcmp(matches->type, dev->node->type);
-		if (matches->compatible[0])
-			match &= of_device_is_compatible(dev->node,
-							 matches->compatible);
-		if (match)
-			return matches;
-		matches++;
-	}
-	return NULL;
-}
-
 static int of_platform_bus_match(struct device *dev, struct device_driver *drv)
 {
 	struct of_device * of_dev = to_of_device(dev);
@@ -52,26 +21,6 @@ static int of_platform_bus_match(struct device *dev, struct device_driver *drv)
 	return of_match_device(matches, of_dev) != NULL;
 }
 
-struct of_device *of_dev_get(struct of_device *dev)
-{
-	struct device *tmp;
-
-	if (!dev)
-		return NULL;
-	tmp = get_device(&dev->dev);
-	if (tmp)
-		return to_of_device(tmp);
-	else
-		return NULL;
-}
-
-void of_dev_put(struct of_device *dev)
-{
-	if (dev)
-		put_device(&dev->dev);
-}
-
-
 static int of_device_probe(struct device *dev)
 {
 	int error = -ENODEV;
@@ -735,56 +684,6 @@ void of_unregister_driver(struct of_platform_driver *drv)
 	driver_unregister(&drv->driver);
 }
 
-
-static ssize_t dev_show_devspec(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct of_device *ofdev;
-
-	ofdev = to_of_device(dev);
-	return sprintf(buf, "%s", ofdev->node->full_name);
-}
-
-static DEVICE_ATTR(devspec, S_IRUGO, dev_show_devspec, NULL);
-
-/**
- * of_release_dev - free an of device structure when all users of it are finished.
- * @dev: device that's been disconnected
- *
- * Will be called only by the device core when all users of this of device are
- * done.
- */
-void of_release_dev(struct device *dev)
-{
-	struct of_device *ofdev;
-
-        ofdev = to_of_device(dev);
-
-	kfree(ofdev);
-}
-
-int of_device_register(struct of_device *ofdev)
-{
-	int rc;
-
-	BUG_ON(ofdev->node = NULL);
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
-}
-
-void of_device_unregister(struct of_device *ofdev)
-{
-	device_remove_file(&ofdev->dev, &dev_attr_devspec);
-	device_unregister(&ofdev->dev);
-}
-
 struct of_device* of_platform_device_create(struct device_node *np,
 					    const char *bus_id,
 					    struct device *parent,
@@ -810,12 +709,6 @@ struct of_device* of_platform_device_create(struct device_node *np,
 	return dev;
 }
 
-EXPORT_SYMBOL(of_match_device);
 EXPORT_SYMBOL(of_register_driver);
 EXPORT_SYMBOL(of_unregister_driver);
-EXPORT_SYMBOL(of_device_register);
-EXPORT_SYMBOL(of_device_unregister);
-EXPORT_SYMBOL(of_dev_get);
-EXPORT_SYMBOL(of_dev_put);
 EXPORT_SYMBOL(of_platform_device_create);
-EXPORT_SYMBOL(of_release_dev);
diff --git a/arch/sparc64/kernel/of_device.c b/arch/sparc64/kernel/of_device.c
index 6676b93..68927bc 100644
--- a/arch/sparc64/kernel/of_device.c
+++ b/arch/sparc64/kernel/of_device.c
@@ -1,5 +1,6 @@
 #include <linux/string.h>
 #include <linux/kernel.h>
+#include <linux/of.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
@@ -8,38 +9,6 @@
 #include <asm/errno.h>
 #include <asm/of_device.h>
 
-/**
- * of_match_device - Tell if an of_device structure has a matching
- * of_match structure
- * @ids: array of of device match structures to search in
- * @dev: the of device structure to match against
- *
- * Used by a driver to check whether an of_device present in the
- * system is in its list of supported devices.
- */
-const struct of_device_id *of_match_device(const struct of_device_id *matches,
-					const struct of_device *dev)
-{
-	if (!dev->node)
-		return NULL;
-	while (matches->name[0] || matches->type[0] || matches->compatible[0]) {
-		int match = 1;
-		if (matches->name[0])
-			match &= dev->node->name
-				&& !strcmp(matches->name, dev->node->name);
-		if (matches->type[0])
-			match &= dev->node->type
-				&& !strcmp(matches->type, dev->node->type);
-		if (matches->compatible[0])
-			match &= of_device_is_compatible(dev->node,
-							 matches->compatible);
-		if (match)
-			return matches;
-		matches++;
-	}
-	return NULL;
-}
-
 static int of_platform_bus_match(struct device *dev, struct device_driver *drv)
 {
 	struct of_device * of_dev = to_of_device(dev);
@@ -52,26 +21,6 @@ static int of_platform_bus_match(struct device *dev, struct device_driver *drv)
 	return of_match_device(matches, of_dev) != NULL;
 }
 
-struct of_device *of_dev_get(struct of_device *dev)
-{
-	struct device *tmp;
-
-	if (!dev)
-		return NULL;
-	tmp = get_device(&dev->dev);
-	if (tmp)
-		return to_of_device(tmp);
-	else
-		return NULL;
-}
-
-void of_dev_put(struct of_device *dev)
-{
-	if (dev)
-		put_device(&dev->dev);
-}
-
-
 static int of_device_probe(struct device *dev)
 {
 	int error = -ENODEV;
@@ -1020,61 +969,13 @@ int of_register_driver(struct of_platform_driver *drv, struct bus_type *bus)
 	/* register with core */
 	return driver_register(&drv->driver);
 }
+EXPORT_SYMBOL(of_register_driver);
 
 void of_unregister_driver(struct of_platform_driver *drv)
 {
 	driver_unregister(&drv->driver);
 }
-
-
-static ssize_t dev_show_devspec(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct of_device *ofdev;
-
-	ofdev = to_of_device(dev);
-	return sprintf(buf, "%s", ofdev->node->full_name);
-}
-
-static DEVICE_ATTR(devspec, S_IRUGO, dev_show_devspec, NULL);
-
-/**
- * of_release_dev - free an of device structure when all users of it are finished.
- * @dev: device that's been disconnected
- *
- * Will be called only by the device core when all users of this of device are
- * done.
- */
-void of_release_dev(struct device *dev)
-{
-	struct of_device *ofdev;
-
-        ofdev = to_of_device(dev);
-
-	kfree(ofdev);
-}
-
-int of_device_register(struct of_device *ofdev)
-{
-	int rc;
-
-	BUG_ON(ofdev->node = NULL);
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
-}
-
-void of_device_unregister(struct of_device *ofdev)
-{
-	device_remove_file(&ofdev->dev, &dev_attr_devspec);
-	device_unregister(&ofdev->dev);
-}
+EXPORT_SYMBOL(of_unregister_driver);
 
 struct of_device* of_platform_device_create(struct device_node *np,
 					    const char *bus_id,
@@ -1100,13 +1001,4 @@ struct of_device* of_platform_device_create(struct device_node *np,
 
 	return dev;
 }
-
-EXPORT_SYMBOL(of_match_device);
-EXPORT_SYMBOL(of_register_driver);
-EXPORT_SYMBOL(of_unregister_driver);
-EXPORT_SYMBOL(of_device_register);
-EXPORT_SYMBOL(of_device_unregister);
-EXPORT_SYMBOL(of_dev_get);
-EXPORT_SYMBOL(of_dev_put);
 EXPORT_SYMBOL(of_platform_device_create);
-EXPORT_SYMBOL(of_release_dev);
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 7916f4b..d53504c 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -8,6 +8,8 @@ source "drivers/connector/Kconfig"
 
 source "drivers/mtd/Kconfig"
 
+source "drivers/of/Kconfig"
+
 source "drivers/parport/Kconfig"
 
 source "drivers/pnp/Kconfig"
diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
new file mode 100644
index 0000000..c03072b
--- /dev/null
+++ b/drivers/of/Kconfig
@@ -0,0 +1,3 @@
+config OF_DEVICE
+	def_bool y
+	depends on OF && (SPARC || PPC_OF)
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index cddbe84..c46d998 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -1 +1,2 @@
 obj-y = base.o
+obj-$(CONFIG_OF_DEVICE) += device.o
diff --git a/drivers/of/device.c b/drivers/of/device.c
new file mode 100644
index 0000000..7f233d7
--- /dev/null
+++ b/drivers/of/device.c
@@ -0,0 +1,131 @@
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/slab.h>
+
+#include <asm/errno.h>
+#include <asm/of_device.h>
+
+/**
+ * of_match_node - Tell if an device_node has a matching of_match structure
+ * @ids: array of of device match structures to search in
+ * @node: the of device structure to match against
+ *
+ * Low level utility function used by device matching.
+ */
+const struct of_device_id *of_match_node(const struct of_device_id *matches,
+					 const struct device_node *node)
+{
+	while (matches->name[0] || matches->type[0] || matches->compatible[0]) {
+		int match = 1;
+		if (matches->name[0])
+			match &= node->name
+				&& !strcmp(matches->name, node->name);
+		if (matches->type[0])
+			match &= node->type
+				&& !strcmp(matches->type, node->type);
+		if (matches->compatible[0])
+			match &= of_device_is_compatible(node,
+						matches->compatible);
+		if (match)
+			return matches;
+		matches++;
+	}
+	return NULL;
+}
+EXPORT_SYMBOL(of_match_node);
+
+/**
+ * of_match_device - Tell if an of_device structure has a matching
+ * of_match structure
+ * @ids: array of of device match structures to search in
+ * @dev: the of device structure to match against
+ *
+ * Used by a driver to check whether an of_device present in the
+ * system is in its list of supported devices.
+ */
+const struct of_device_id *of_match_device(const struct of_device_id *matches,
+					const struct of_device *dev)
+{
+	if (!dev->node)
+		return NULL;
+	return of_match_node(matches, dev->node);
+}
+EXPORT_SYMBOL(of_match_device);
+
+struct of_device *of_dev_get(struct of_device *dev)
+{
+	struct device *tmp;
+
+	if (!dev)
+		return NULL;
+	tmp = get_device(&dev->dev);
+	if (tmp)
+		return to_of_device(tmp);
+	else
+		return NULL;
+}
+EXPORT_SYMBOL(of_dev_get);
+
+void of_dev_put(struct of_device *dev)
+{
+	if (dev)
+		put_device(&dev->dev);
+}
+EXPORT_SYMBOL(of_dev_put);
+
+static ssize_t dev_show_devspec(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct of_device *ofdev;
+
+	ofdev = to_of_device(dev);
+	return sprintf(buf, "%s", ofdev->node->full_name);
+}
+
+static DEVICE_ATTR(devspec, S_IRUGO, dev_show_devspec, NULL);
+
+/**
+ * of_release_dev - free an of device structure when all users of it are finished.
+ * @dev: device that's been disconnected
+ *
+ * Will be called only by the device core when all users of this of device are
+ * done.
+ */
+void of_release_dev(struct device *dev)
+{
+	struct of_device *ofdev;
+
+	ofdev = to_of_device(dev);
+	of_node_put(ofdev->node);
+	kfree(ofdev);
+}
+EXPORT_SYMBOL(of_release_dev);
+
+int of_device_register(struct of_device *ofdev)
+{
+	int rc;
+
+	BUG_ON(ofdev->node = NULL);
+
+	rc = device_register(&ofdev->dev);
+	if (rc)
+		return rc;
+
+	rc = device_create_file(&ofdev->dev, &dev_attr_devspec);
+	if (rc)
+		device_unregister(&ofdev->dev);
+
+	return rc;
+}
+EXPORT_SYMBOL(of_device_register);
+
+void of_device_unregister(struct of_device *ofdev)
+{
+	device_remove_file(&ofdev->dev, &dev_attr_devspec);
+	device_unregister(&ofdev->dev);
+}
+EXPORT_SYMBOL(of_device_unregister);
-- 
1.5.2.3

