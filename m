From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Wed, 13 Apr 2016 23:22:37 +0000
Subject: Re: Enable module aliases for vio on sparc/sparc64
Message-Id: <570ED4BD.8060805@physik.fu-berlin.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------070007010608080703000704"
List-Id: <sparclinux.vger.kernel.org>
References: <570B52AE.8080603@physik.fu-berlin.de>
In-Reply-To: <570B52AE.8080603@physik.fu-berlin.de>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------070007010608080703000704
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

On 04/14/2016 01:04 AM, John Paul Adrian Glaubitz wrote:
> Testing a much simpler version now. Second.

Attaching two patches which add modalias_show and vio_hotplug. With
the patches applied, module autoloading works as expected.

Going to bed now, it's past midnight here.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

--------------070007010608080703000704
Content-Type: text/x-patch;
 name="0002-sparc-kernel-vio.c-implement-vio_hotplug-and-add-it-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-sparc-kernel-vio.c-implement-vio_hotplug-and-add-it-.pa";
 filename*1="tch"

From 3515ad550f7b1db467664acc9bf0ed3d2aec9fdd Mon Sep 17 00:00:00 2001
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 14 Apr 2016 01:19:40 +0200
Subject: [PATCH 2/2] sparc/kernel/vio.c: implement vio_hotplug and add it to
 vio_bus_type

Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
---
 arch/sparc/kernel/vio.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/sparc/kernel/vio.c b/arch/sparc/kernel/vio.c
index 5a9bb9d..59f4b7c 100644
--- a/arch/sparc/kernel/vio.c
+++ b/arch/sparc/kernel/vio.c
@@ -45,6 +45,13 @@ static const struct vio_device_id *vio_match_device(
 	return NULL;
 }
 
+static int vio_hotplug(struct device *dev, struct kobj_uevent_env *env)
+{
+	const struct vio_dev *vio_dev = to_vio_dev(dev);
+	add_uevent_var(env, "MODALIAS=vio:T%sS%s", vio_dev->type, vio_dev->compat);
+	 return 0;
+}
+
 static int vio_bus_match(struct device *dev, struct device_driver *drv)
 {
 	struct vio_dev *vio_dev = to_vio_dev(dev);
@@ -121,6 +128,7 @@ static struct device_attribute vio_dev_attrs[] = {
 static struct bus_type vio_bus_type = {
 	.name		= "vio",
 	.dev_attrs	= vio_dev_attrs,
+	.uevent         = vio_hotplug,
 	.match		= vio_bus_match,
 	.probe		= vio_device_probe,
 	.remove		= vio_device_remove,
-- 
2.8.0.rc3


--------------070007010608080703000704
Content-Type: text/x-patch;
 name="0001-sparc-kernel-vio.c-implement-modalias_show.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-sparc-kernel-vio.c-implement-modalias_show.patch"

From 8d95bce6a35dc037d1e419896af19e12b3cda910 Mon Sep 17 00:00:00 2001
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 14 Apr 2016 01:16:14 +0200
Subject: [PATCH 1/2] sparc/kernel/vio.c: implement modalias_show()

Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
---
 arch/sparc/kernel/vio.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/sparc/kernel/vio.c b/arch/sparc/kernel/vio.c
index cb5789c..5a9bb9d 100644
--- a/arch/sparc/kernel/vio.c
+++ b/arch/sparc/kernel/vio.c
@@ -105,6 +105,13 @@ static ssize_t type_show(struct device *dev,
 	return sprintf(buf, "%s\n", vdev->type);
 }
 
+static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
+                             char *buf)
+{
+	const struct vio_dev *vdev = to_vio_dev(dev);
+	return sprintf(buf, "vio:T%sS%s\n", vdev->type, vdev->compat);
+}
+
 static struct device_attribute vio_dev_attrs[] = {
 	__ATTR_RO(devspec),
 	__ATTR_RO(type),
-- 
2.8.0.rc3


--------------070007010608080703000704--
