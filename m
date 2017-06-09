From: Jag Raman <jag.raman@oracle.com>
Date: Fri, 09 Jun 2017 16:30:56 +0000
Subject: [PATCH v1 07/12] sparc64: refactor code to obtain cfg_handle property from MDESC
Message-Id: <0ba4b63164de955208983b08b7b1685da2677399.1497024216.git.jag.raman@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Refactors code to get the cfg_handle property of a node from Machine
Description (MDESC)

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 arch/sparc/kernel/vio.c |   30 +++++++++++++++++++-----------
 1 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/arch/sparc/kernel/vio.c b/arch/sparc/kernel/vio.c
index d5cf831..bcb754c 100644
--- a/arch/sparc/kernel/vio.c
+++ b/arch/sparc/kernel/vio.c
@@ -181,6 +181,24 @@ static DEVICE_ATTR(obppath, S_IRUSR | S_IRGRP | S_IROTH,
 static struct vio_dev *root_vdev;
 static u64 cdev_cfg_handle;
 
+static const u64 *vio_cfg_handle(struct mdesc_handle *hp, u64 node)
+{
+	const u64 *cfg_handle = NULL;
+	u64 a;
+
+	mdesc_for_each_arc(a, hp, node, MDESC_ARC_TYPE_BACK) {
+		u64 target;
+
+		target = mdesc_arc_target(hp, a);
+		cfg_handle = mdesc_get_property(hp, target,
+						"cfg-handle", NULL);
+		if (cfg_handle)
+			break;
+	}
+
+	return cfg_handle;
+}
+
 static void vio_fill_channel_info(struct mdesc_handle *hp, u64 mp,
 				  struct vio_dev *vdev)
 {
@@ -226,7 +244,6 @@ int vio_set_intr(unsigned long dev_ino, int state)
 	struct vio_dev *vdev;
 	int err, tlen, clen;
 	const u64 *id, *cfg_handle;
-	u64 a;
 
 	type = mdesc_get_property(hp, mp, "device-type", &tlen);
 	if (!type) {
@@ -244,16 +261,7 @@ int vio_set_intr(unsigned long dev_ino, int state)
 
 	id = mdesc_get_property(hp, mp, "id", NULL);
 
-	cfg_handle = NULL;
-	mdesc_for_each_arc(a, hp, mp, MDESC_ARC_TYPE_BACK) {
-		u64 target;
-
-		target = mdesc_arc_target(hp, a);
-		cfg_handle = mdesc_get_property(hp, target,
-						"cfg-handle", NULL);
-		if (cfg_handle)
-			break;
-	}
+	cfg_handle = vio_cfg_handle(hp, mp);
 
 	bus_id_name = type;
 	if (!strcmp(type, "domain-services-port"))
-- 
1.7.1

