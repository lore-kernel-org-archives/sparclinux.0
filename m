From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 14 Apr 2016 18:14:42 +0000
Subject: [PATCH 2/2] sparc: Implement and wire up vio_hotplug for vio.
Message-Id: <1460657682-12209-3-git-send-email-glaubitz@physik.fu-berlin.de>
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
index d705560..f6bb857 100644
--- a/arch/sparc/kernel/vio.c
+++ b/arch/sparc/kernel/vio.c
@@ -45,6 +45,14 @@ static const struct vio_device_id *vio_match_device(
 	return NULL;
 }
 
+static int vio_hotplug(struct device *dev, struct kobj_uevent_env *env)
+{
+	const struct vio_dev *vio_dev = to_vio_dev(dev);
+
+	add_uevent_var(env, "MODALIAS=vio:T%sS%s", vio_dev->type, vio_dev->compat);
+	return 0;
+}
+
 static int vio_bus_match(struct device *dev, struct device_driver *drv)
 {
 	struct vio_dev *vio_dev = to_vio_dev(dev);
@@ -123,6 +131,7 @@ static struct device_attribute vio_dev_attrs[] = {
 static struct bus_type vio_bus_type = {
 	.name		= "vio",
 	.dev_attrs	= vio_dev_attrs,
+	.uevent         = vio_hotplug,
 	.match		= vio_bus_match,
 	.probe		= vio_device_probe,
 	.remove		= vio_device_remove,
-- 
2.8.0.rc3

