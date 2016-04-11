From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Mon, 11 Apr 2016 07:30:54 +0000
Subject: Enable module aliases for vio on sparc/sparc64
Message-Id: <570B52AE.8080603@physik.fu-berlin.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------090407060906020406010503"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------090407060906020406010503
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi Dave!

We have had issues when installing Debian's sparc64 port on SPARC
machines with virtualization support. In order to be able to install
Linux into an LDOM container, both the modules sunvdc and sunvnet
need to be loaded to enable block device and networking support
within the virtual machine.

Unfortunately, these modules are never loaded automatically despite
being present and the hardware supporting it. After some discussion
in Debian's bug tracker [1], Ben Hutchings, Debian's kernel maintainer,
mentioned that this is a result of the VIO bus implementation on
sparc/sparc64 not supporting module aliases and consequently automatic
loading.

Ben has provided a minimal and dirty patch which enables aliases
for vio on sparc/sparc64, but he says the better solution would
be to merge VIO implementations on both sparc/sparc64 and PowerPC,
the latter already supporting module aliases and auto loading.

A quick hotfix as Ben suggested would be great for the time being
as it would unbreak the Debian installation within LDOMs, so
I was wondering whether you could merge the patch?

Any other suggestion?

Thanks,
Adrian

> [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=815977#40

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

--------------090407060906020406010503
Content-Type: text/x-patch;
 name="sparc-vio-add-modalias-attribute-to-support-auto-loading-drivers.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="sparc-vio-add-modalias-attribute-to-support-auto-loading-dri";
 filename*1="vers.patch"

From: Ben Hutchings <ben@decadent.org.uk>
Date: Mon, 11 Apr 2016 00:30:34 +0100
Subject: sparc: vio: Add modalias attribute to support auto-loading drivers
Bug-Debian: https://bugs.debian.org/815977

Add a modalias attribute for vio devices, matching the syntax
supported by file2alias and the PowerPC vio implementation.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/sparc/kernel/vio.c
+++ b/arch/sparc/kernel/vio.c
@@ -105,9 +105,31 @@ static ssize_t type_show(struct device *dev,
 	return sprintf(buf, "%s\n", vdev->type);
 }
 
+static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	const struct vio_dev *vdev = to_vio_dev(dev);
+	struct device_node *dn;
+	const char *cp;
+
+	dn = dev->of_node;
+	if (!dn) {
+		strcpy(buf, "\n");
+		return strlen(buf);
+	}
+	cp = of_get_property(dn, "compatible", NULL);
+	if (!cp) {
+		strcpy(buf, "\n");
+		return strlen(buf);
+	}
+
+	return sprintf(buf, "vio:T%sS%s\n", vdev->type, cp);
+}
+
 static struct device_attribute vio_dev_attrs[] = {
 	__ATTR_RO(devspec),
 	__ATTR_RO(type),
+	__ATTR_RO(modalias),
 	__ATTR_NULL
 };
 

--------------090407060906020406010503--
