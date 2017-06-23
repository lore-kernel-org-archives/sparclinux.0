From: Jag Raman <jag.raman@oracle.com>
Date: Fri, 23 Jun 2017 18:58:39 +0000
Subject: [PATCH v2 11/12] sparc64: Enhance search for VIO device in MDESC
Message-Id: <bb41d109892d5fec876ecdac88c8d6b540fd1628.1498238657.git.jag.raman@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Enhances search for VIO device in MDESC by leveraging already existing
MDESC APIs. Enhances changes in earlier patch,
"sparc: Machine description indices can vary", by using existing MD
search functions. It also specifies a match function, thereby
enabling device_find_child() to use it for the purpose of matching
device nodes in MDESC.

An API to find VDEV node in MDESC based on its md_node_info is also
added. It is planned to be used by VIO device clients in the future.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
---
v2:
 - Invocations of mdesc_node_get() & mdesc_get_node_info()
   have been updated to use the prototypes defined in patch 4/5

 arch/sparc/include/asm/vio.h |    5 ++-
 arch/sparc/kernel/mdesc.c    |    2 +
 arch/sparc/kernel/vio.c      |  120 ++++++++++++++++++++----------------------
 3 files changed, 64 insertions(+), 63 deletions(-)

diff --git a/arch/sparc/include/asm/vio.h b/arch/sparc/include/asm/vio.h
index d8eb195..25ede61 100644
--- a/arch/sparc/include/asm/vio.h
+++ b/arch/sparc/include/asm/vio.h
@@ -329,7 +329,6 @@ struct vio_dev {
 	int			compat_len;
 
 	u64			dev_no;
-	u64			id;
 
 	unsigned long		channel_id;
 
@@ -341,6 +340,9 @@ struct vio_dev {
 	/* Handle to the root of "channel-devices" sub-tree in MDESC */
 	u64			cdev_handle;
 
+	/* MD specific data used to identify the vdev in MD */
+	union md_node_info	md_node_info;
+
 	struct device		dev;
 };
 
@@ -497,5 +499,6 @@ int vio_driver_init(struct vio_driver_state *vio, struct vio_dev *vdev,
 
 void vio_port_up(struct vio_driver_state *vio);
 int vio_set_intr(unsigned long dev_ino, int state);
+u64 vio_vdev_node(struct mdesc_handle *hp, struct vio_dev *vdev);
 
 #endif /* _SPARC64_VIO_H */
diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
index f795ee0..e4b4e79 100644
--- a/arch/sparc/kernel/mdesc.c
+++ b/arch/sparc/kernel/mdesc.c
@@ -574,6 +574,7 @@ u64 mdesc_get_node(struct mdesc_handle *hp, const char *node_name,
 
 	return hp_node;
 }
+EXPORT_SYMBOL(mdesc_get_node);
 
 int mdesc_get_node_info(struct mdesc_handle *hp, u64 node,
 			const char *node_name, union md_node_info *node_info)
@@ -603,6 +604,7 @@ int mdesc_get_node_info(struct mdesc_handle *hp, u64 node,
 
 	return 0;
 }
+EXPORT_SYMBOL(mdesc_get_node_info);
 
 static struct mdesc_elem *node_block(struct mdesc_hdr *mdesc)
 {
diff --git a/arch/sparc/kernel/vio.c b/arch/sparc/kernel/vio.c
index ea63f02..624f0a9 100644
--- a/arch/sparc/kernel/vio.c
+++ b/arch/sparc/kernel/vio.c
@@ -217,6 +217,32 @@ static DEVICE_ATTR(obppath, S_IRUSR | S_IRGRP | S_IROTH,
 	return cfg_handle;
 }
 
+/**
+ * vio_vdev_node() - Find VDEV node in MD
+ * @hp:  Handle to the MD
+ * @vdev:  Pointer to VDEV
+ *
+ * Find the node in the current MD which matches the given vio_dev. This
+ * must be done dynamically since the node value can change if the MD
+ * is updated.
+ *
+ * NOTE: the MD must be locked, using mdesc_grab(), when calling this routine
+ *
+ * Return: The VDEV node in MDESC
+ */
+u64 vio_vdev_node(struct mdesc_handle *hp, struct vio_dev *vdev)
+{
+	u64 node;
+
+	if (vdev = NULL)
+		return MDESC_NODE_NULL;
+
+	node = mdesc_get_node(hp, (const char *)vdev->node_name,
+			      &vdev->md_node_info);
+
+	return node;
+}
+
 static void vio_fill_channel_info(struct mdesc_handle *hp, u64 mp,
 				  struct vio_dev *vdev)
 {
@@ -316,16 +342,13 @@ int vio_set_intr(unsigned long dev_ino, int state)
 	if (!id) {
 		dev_set_name(&vdev->dev, "%s", type);
 		vdev->dev_no = ~(u64)0;
-		vdev->id = ~(u64)0;
 	} else if (!cfg_handle) {
 		dev_set_name(&vdev->dev, "%s-%llu", type, *id);
 		vdev->dev_no = *id;
-		vdev->id = ~(u64)0;
 	} else {
 		dev_set_name(&vdev->dev, "%s-%llu-%llu", type,
 			     *cfg_handle, *id);
 		vdev->dev_no = *cfg_handle;
-		vdev->id = *id;
 	}
 
 	vdev->dev.parent = parent;
@@ -347,11 +370,24 @@ int vio_set_intr(unsigned long dev_ino, int state)
 	}
 	vdev->dp = dp;
 
-	/* node_name is NULL for the parent/channel-devices node */
-	if (node_name != NULL)
+	/*
+	 * node_name is NULL for the parent/channel-devices node and
+	 * the parent doesn't require the MD node info.
+	 */
+	if (node_name != NULL) {
 		(void) snprintf(vdev->node_name, VIO_MAX_NAME_LEN, "%s",
 				node_name);
 
+		err = mdesc_get_node_info(hp, mp, node_name,
+					  &vdev->md_node_info);
+		if (err) {
+			pr_err("VIO: Could not get MD node info %s, err=%d\n",
+			       dev_name(&vdev->dev), err);
+			kfree(vdev);
+			return NULL;
+		}
+	}
+
 	pr_info("VIO: Adding device %s (tx_ino = %llx, rx_ino = %llx)\n",
 		dev_name(&vdev->dev), vdev->tx_ino, vdev->rx_ino);
 
@@ -375,68 +411,36 @@ static void vio_add(struct mdesc_handle *hp, u64 node,
 	(void) vio_create_one(hp, node, node_name, &root_vdev->dev);
 }
 
-struct vio_md_node_query {
-	const char *type;
-	u64 dev_no;
-	u64 id;
+struct vio_remove_node_data {
+	struct mdesc_handle *hp;
+	u64 node;
 };
 
 static int vio_md_node_match(struct device *dev, void *arg)
 {
-	struct vio_md_node_query *query = (struct vio_md_node_query *) arg;
 	struct vio_dev *vdev = to_vio_dev(dev);
+	struct vio_remove_node_data *node_data;
+	u64 node;
 
-	if (vdev->dev_no != query->dev_no)
-		return 0;
-	if (vdev->id != query->id)
-		return 0;
-	if (strcmp(vdev->type, query->type))
-		return 0;
+	node_data = (struct vio_remove_node_data *)arg;
 
-	return 1;
+	node = vio_vdev_node(node_data->hp, vdev);
+
+	if (node = node_data->node)
+		return 1;
+	else
+		return 0;
 }
 
 static void vio_remove(struct mdesc_handle *hp, u64 node, const char *node_name)
 {
-	const char *type;
-	const u64 *id, *cfg_handle;
-	u64 a;
-	struct vio_md_node_query query;
+	struct vio_remove_node_data node_data;
 	struct device *dev;
 
-	type = mdesc_get_property(hp, node, "device-type", NULL);
-	if (!type) {
-		type = mdesc_get_property(hp, node, "name", NULL);
-		if (!type)
-			type = mdesc_node_name(hp, node);
-	}
-
-	query.type = type;
-
-	id = mdesc_get_property(hp, node, "id", NULL);
-	cfg_handle = NULL;
-	mdesc_for_each_arc(a, hp, node, MDESC_ARC_TYPE_BACK) {
-		u64 target;
-
-		target = mdesc_arc_target(hp, a);
-		cfg_handle = mdesc_get_property(hp, target,
-						"cfg-handle", NULL);
-		if (cfg_handle)
-			break;
-	}
-
-	if (!id) {
-		query.dev_no = ~(u64)0;
-		query.id = ~(u64)0;
-	} else if (!cfg_handle) {
-		query.dev_no = *id;
-		query.id = ~(u64)0;
-	} else {
-		query.dev_no = *cfg_handle;
-		query.id = *id;
-	}
+	node_data.hp = hp;
+	node_data.node = node;
 
-	dev = device_find_child(&root_vdev->dev, &query,
+	dev = device_find_child(&root_vdev->dev, (void *)&node_data,
 				vio_md_node_match);
 	if (dev) {
 		printk(KERN_INFO "VIO: Removing device %s\n", dev_name(dev));
@@ -444,15 +448,7 @@ static void vio_remove(struct mdesc_handle *hp, u64 node, const char *node_name)
 		device_unregister(dev);
 		put_device(dev);
 	} else {
-		if (!id)
-			printk(KERN_ERR "VIO: Removed unknown %s node.\n",
-			       type);
-		else if (!cfg_handle)
-			printk(KERN_ERR "VIO: Removed unknown %s node %llu.\n",
-			       type, *id);
-		else
-			printk(KERN_ERR "VIO: Removed unknown %s node %llu-%llu.\n",
-			       type, *cfg_handle, *id);
+		pr_err("VIO: %s node not found in MDESC\n", node_name);
 	}
 }
 
-- 
1.7.1

