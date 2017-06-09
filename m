From: <gregkh@linuxfoundation.org>
Date: Fri, 09 Jun 2017 18:08:19 +0000
Subject: patch "sparc: vio: use dev_groups and not dev_attrs for bus_type" added to driver-core-next
Message-Id: <149703169921458@kroah.com>
List-Id: <sparclinux.vger.kernel.org>
References: <149699886520255@kroah.com>
In-Reply-To: <149699886520255@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    sparc: vio: use dev_groups and not dev_attrs for bus_type

to my driver-core git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
in the driver-core-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From 33acc6db64f77a7bd773f4bc5cc8fcd1b6976ddc Mon Sep 17 00:00:00 2001
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 6 Jun 2017 14:27:08 +0200
Subject: sparc: vio: use dev_groups and not dev_attrs for bus_type

The dev_attrs field has long been "depreciated" and is finally being
removed, so move the driver to use the "correct" dev_groups field
instead for struct bus_type.

Acked-by: "David S. Miller" <davem@davemloft.net>
Cc: <sparclinux@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/sparc/kernel/vio.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/kernel/vio.c b/arch/sparc/kernel/vio.c
index f6bb857254fc..78bf2cc60924 100644
--- a/arch/sparc/kernel/vio.c
+++ b/arch/sparc/kernel/vio.c
@@ -105,6 +105,7 @@ static ssize_t devspec_show(struct device *dev,
 
 	return sprintf(buf, "%s\n", str);
 }
+static DEVICE_ATTR_RO(devspec);
 
 static ssize_t type_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -112,6 +113,7 @@ static ssize_t type_show(struct device *dev,
 	struct vio_dev *vdev = to_vio_dev(dev);
 	return sprintf(buf, "%s\n", vdev->type);
 }
+static DEVICE_ATTR_RO(type);
 
 static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
@@ -120,17 +122,19 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 
 	return sprintf(buf, "vio:T%sS%s\n", vdev->type, vdev->compat);
 }
+static DEVICE_ATTR_RO(modalias);
 
-static struct device_attribute vio_dev_attrs[] = {
-	__ATTR_RO(devspec),
-	__ATTR_RO(type),
-	__ATTR_RO(modalias),
-	__ATTR_NULL
-};
+static struct attribute *vio_dev_attrs[] = {
+	&dev_attr_devspec.attr,
+	&dev_attr_type.attr,
+	&dev_attr_modalias.attr,
+	NULL,
+ };
+ATTRIBUTE_GROUPS(vio_dev);
 
 static struct bus_type vio_bus_type = {
 	.name		= "vio",
-	.dev_attrs	= vio_dev_attrs,
+	.dev_groups	= vio_dev_groups,
 	.uevent         = vio_hotplug,
 	.match		= vio_bus_match,
 	.probe		= vio_device_probe,
-- 
2.13.1


