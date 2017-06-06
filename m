From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 06 Jun 2017 19:22:19 +0000
Subject: [PATCH 14/16] sparc: vio: use dev_groups and not dev_attrs for bus_type
Message-Id: <20170606192221.1617-15-gregkh@linuxfoundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20170606192221.1617-1-gregkh@linuxfoundation.org>
In-Reply-To: <20170606192221.1617-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

The dev_attrs field has long been "depreciated" and is finally being
removed, so move the driver to use the "correct" dev_groups field
instead for struct bus_type.

Cc: "David S. Miller" <davem@davemloft.net>
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
2.13.0

