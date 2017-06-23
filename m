From: Jag Raman <jag.raman@oracle.com>
Date: Fri, 23 Jun 2017 18:58:36 +0000
Subject: [PATCH v2 08/12] sparc64: remove restriction on VIO device name size
Message-Id: <ac438a6a008ced3f014bfbef8326cc3aba4fee26.1498238657.git.jag.raman@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Removes restriction on VIO device's size limit. Since KOBJ_NAME_LEN
has been dropped from kobject, there doesn't seem to be a
restriction on the device name anymore. This limit therefore
doesn't make sense.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 arch/sparc/kernel/vio.c |   23 ++++-------------------
 1 files changed, 4 insertions(+), 19 deletions(-)

diff --git a/arch/sparc/kernel/vio.c b/arch/sparc/kernel/vio.c
index 1ac5da1..0890a25 100644
--- a/arch/sparc/kernel/vio.c
+++ b/arch/sparc/kernel/vio.c
@@ -240,7 +240,7 @@ int vio_set_intr(unsigned long dev_ino, int state)
 				      const char *node_name,
 				      struct device *parent)
 {
-	const char *type, *compat, *bus_id_name;
+	const char *type, *compat;
 	struct device_node *dp;
 	struct vio_dev *vdev;
 	int err, tlen, clen;
@@ -264,21 +264,6 @@ int vio_set_intr(unsigned long dev_ino, int state)
 
 	cfg_handle = vio_cfg_handle(hp, mp);
 
-	bus_id_name = type;
-	if (!strcmp(type, "domain-services-port"))
-		bus_id_name = "ds";
-
-	/*
-	 * 20 char is the old driver-core name size limit, which is no more.
-	 * This check can probably be removed after review and possible
-	 * adaption of the vio users name length handling.
-	 */
-	if (strlen(bus_id_name) >= 20 - 4) {
-		printk(KERN_ERR "VIO: bus_id_name [%s] is too long.\n",
-		       bus_id_name);
-		return NULL;
-	}
-
 	compat = mdesc_get_property(hp, mp, "device-type", &clen);
 	if (!compat) {
 		clen = 0;
@@ -309,15 +294,15 @@ int vio_set_intr(unsigned long dev_ino, int state)
 	vio_fill_channel_info(hp, mp, vdev);
 
 	if (!id) {
-		dev_set_name(&vdev->dev, "%s", bus_id_name);
+		dev_set_name(&vdev->dev, "%s", type);
 		vdev->dev_no = ~(u64)0;
 		vdev->id = ~(u64)0;
 	} else if (!cfg_handle) {
-		dev_set_name(&vdev->dev, "%s-%llu", bus_id_name, *id);
+		dev_set_name(&vdev->dev, "%s-%llu", type, *id);
 		vdev->dev_no = *id;
 		vdev->id = ~(u64)0;
 	} else {
-		dev_set_name(&vdev->dev, "%s-%llu-%llu", bus_id_name,
+		dev_set_name(&vdev->dev, "%s-%llu-%llu", type,
 			     *cfg_handle, *id);
 		vdev->dev_no = *cfg_handle;
 		vdev->id = *id;
-- 
1.7.1

