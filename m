From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 14 Apr 2016 18:14:41 +0000
Subject: [PATCH 1/2] sparc: Implement and wire up modalias_show for vio.
Message-Id: <1460657682-12209-2-git-send-email-glaubitz@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
---
 arch/sparc/kernel/vio.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/sparc/kernel/vio.c b/arch/sparc/kernel/vio.c
index cb5789c..d705560 100644
--- a/arch/sparc/kernel/vio.c
+++ b/arch/sparc/kernel/vio.c
@@ -105,9 +105,18 @@ static ssize_t type_show(struct device *dev,
 	return sprintf(buf, "%s\n", vdev->type);
 }
 
+static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	const struct vio_dev *vdev = to_vio_dev(dev);
+
+	return sprintf(buf, "vio:T%sS%s\n", vdev->type, vdev->compat);
+}
+
 static struct device_attribute vio_dev_attrs[] = {
 	__ATTR_RO(devspec),
 	__ATTR_RO(type),
+	__ATTR_RO(modalias),
 	__ATTR_NULL
 };
 
-- 
2.8.0.rc3

