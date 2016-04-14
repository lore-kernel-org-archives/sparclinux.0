From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 14 Apr 2016 09:10:33 +0000
Subject: Re: Enable module aliases for vio on sparc/sparc64
Message-Id: <570F5E89.2080102@physik.fu-berlin.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------050001010001070209040808"
List-Id: <sparclinux.vger.kernel.org>
References: <570B52AE.8080603@physik.fu-berlin.de>
In-Reply-To: <570B52AE.8080603@physik.fu-berlin.de>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------050001010001070209040808
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

On 04/14/2016 03:53 AM, David Miller wrote:
> You're not hooking this function up at all into the operations.  Looks like
> you are mixing this patch up with other local changes.

You are right. I was switching over to your tree and the __ATTR_RO
somehow fell off while doing that.

> And again, please, empty line after local variable declarations.

I have cleaned up the formatting in both patches and edited
the commit messages, attaching updated patches.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

--------------050001010001070209040808
Content-Type: text/x-diff;
 name="0001-sparc-Implement-and-wire-up-modalias_show-for-vio.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-sparc-Implement-and-wire-up-modalias_show-for-vio.patch"

From b7e3362d71c9d1cb972e5c16e4b9054f8f3de63f Mon Sep 17 00:00:00 2001
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 14 Apr 2016 01:16:14 +0200
Subject: [PATCH 1/2] sparc: Implement and wire up modalias_show for vio.

Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
---
 arch/sparc/kernel/vio.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/sparc/kernel/vio.c b/arch/sparc/kernel/vio.c
index cb5789c..e7fd1e5 100644
--- a/arch/sparc/kernel/vio.c
+++ b/arch/sparc/kernel/vio.c
@@ -105,9 +105,18 @@ static ssize_t type_show(struct device *dev,
 	return sprintf(buf, "%s\n", vdev->type);
 }
 
+static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
+                             char *buf)
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


--------------050001010001070209040808
Content-Type: text/x-diff;
 name="0002-sparc-Implement-and-wire-up-vio_hotplug-for-vio.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-sparc-Implement-and-wire-up-vio_hotplug-for-vio.patch"

From 8b42bee34ffadaa1f10d2af6662214fc979fc45d Mon Sep 17 00:00:00 2001
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 14 Apr 2016 01:19:40 +0200
Subject: [PATCH 2/2] sparc: Implement and wire up vio_hotplug for vio.

Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
---
 arch/sparc/kernel/vio.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/sparc/kernel/vio.c b/arch/sparc/kernel/vio.c
index e7fd1e5..73b33b1 100644
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


--------------050001010001070209040808--
