From: Jag Raman <jag.raman@oracle.com>
Date: Fri, 09 Jun 2017 16:30:55 +0000
Subject: [PATCH v1 06/12] sparc64: add MDESC node name property to VIO device metadata
Message-Id: <0be25e29ae56ab36a892ea186ce661dbb775459c.1497024216.git.jag.raman@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Add the MDESC node name of MDESC client to VIO device metadata. It is
later used to uniquely identify a node in the MDESC. VIO & MDESC APIs
are updated to handle this node name.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 arch/sparc/include/asm/mdesc.h |    7 ++--
 arch/sparc/include/asm/vio.h   |    2 +
 arch/sparc/kernel/mdesc.c      |   79 +++++++++++++++++++---------------------
 arch/sparc/kernel/vio.c        |   24 ++++++++----
 4 files changed, 60 insertions(+), 52 deletions(-)

diff --git a/arch/sparc/include/asm/mdesc.h b/arch/sparc/include/asm/mdesc.h
index d8f6160..d4f3b0d 100644
--- a/arch/sparc/include/asm/mdesc.h
+++ b/arch/sparc/include/asm/mdesc.h
@@ -63,9 +63,10 @@ u64 mdesc_next_arc(struct mdesc_handle *handle, u64 from,
 void mdesc_update(void);
 
 struct mdesc_notifier_client {
-	void (*add)(struct mdesc_handle *handle, u64 node);
-	void (*remove)(struct mdesc_handle *handle, u64 node);
-
+	void (*add)(struct mdesc_handle *handle, u64 node,
+		    const char *node_name);
+	void (*remove)(struct mdesc_handle *handle, u64 node,
+		       const char *node_name);
 	const char			*node_name;
 	struct mdesc_notifier_client	*next;
 };
diff --git a/arch/sparc/include/asm/vio.h b/arch/sparc/include/asm/vio.h
index 9dca7a8..69cb3a5 100644
--- a/arch/sparc/include/asm/vio.h
+++ b/arch/sparc/include/asm/vio.h
@@ -316,12 +316,14 @@ static inline u32 vio_dring_prev(struct vio_dring_state *dr, u32 index)
 }
 
 #define VIO_MAX_TYPE_LEN	32
+#define VIO_MAX_NAME_LEN	32
 #define VIO_MAX_COMPAT_LEN	64
 
 struct vio_dev {
 	u64			mp;
 	struct device_node	*dp;
 
+	char			node_name[VIO_MAX_NAME_LEN];
 	char			type[VIO_MAX_TYPE_LEN];
 	char			compat[VIO_MAX_COMPAT_LEN];
 	int			compat_len;
diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
index 135178e..4aabafc 100644
--- a/arch/sparc/kernel/mdesc.c
+++ b/arch/sparc/kernel/mdesc.c
@@ -268,7 +268,7 @@ void mdesc_register_notifier(struct mdesc_notifier_client *client)
 	client_list = client;
 
 	mdesc_for_each_node_by_name(cur_mdesc, node, client->node_name)
-		client->add(cur_mdesc, node);
+		client->add(cur_mdesc, node, client->node_name);
 
 	mutex_unlock(&mdesc_mutex);
 }
@@ -365,55 +365,52 @@ static bool ds_port_node_match(union md_node_info *a_node_info,
 static void invoke_on_missing(const char *name,
 			      struct mdesc_handle *a,
 			      struct mdesc_handle *b,
-			      void (*func)(struct mdesc_handle *, u64))
+			      void (*func)(struct mdesc_handle *, u64,
+					   const char *node_name))
 {
-	u64 node;
+	mdesc_node_match_f node_match_func;
+	mdesc_node_info_f get_info_func;
+	union md_node_info a_node_info;
+	union md_node_info b_node_info;
+	bool found;
+	u64 a_node;
+	u64 b_node;
+	int rv;
 
-	mdesc_for_each_node_by_name(a, node, name) {
-		int found = 0, is_vdc_port = 0;
-		const char *name_prop;
-		const u64 *id;
-		u64 fnode;
-
-		name_prop = mdesc_get_property(a, node, "name", NULL);
-		if (name_prop && !strcmp(name_prop, "vdc-port")) {
-			is_vdc_port = 1;
-			id = parent_cfg_handle(a, node);
-		} else
-			id = mdesc_get_property(a, node, "id", NULL);
-
-		if (!id) {
-			printk(KERN_ERR "MD: Cannot find ID for %s node.\n",
-			       (name_prop ? name_prop : name));
+	/* Find the get_info and node_match ops for the given node name */
+	mdesc_get_node_ops((char *)name, &get_info_func, &node_match_func);
+
+	/* If we didn't find a match, the node type is not supported */
+	if (get_info_func = NULL || node_match_func = NULL) {
+		pr_err("MD: %s node type is not supported\n", name);
+		return;
+	}
+
+	mdesc_for_each_node_by_name(a, a_node, name) {
+		found = false;
+
+		rv = get_info_func(a, a_node, &a_node_info);
+		if (rv != 0) {
+			pr_err("MD: Cannot find 1 or more required match properties for %s node.\n",
+			       name);
 			continue;
 		}
 
-		mdesc_for_each_node_by_name(b, fnode, name) {
-			const u64 *fid;
-
-			if (is_vdc_port) {
-				name_prop = mdesc_get_property(b, fnode,
-							       "name", NULL);
-				if (!name_prop ||
-				    strcmp(name_prop, "vdc-port"))
-					continue;
-				fid = parent_cfg_handle(b, fnode);
-				if (!fid) {
-					printk(KERN_ERR "MD: Cannot find ID "
-					       "for vdc-port node.\n");
-					continue;
-				}
-			} else
-				fid = mdesc_get_property(b, fnode,
-							 "id", NULL);
-
-			if (*id = *fid) {
-				found = 1;
+		/* Check each node in B for node matching a_node */
+		mdesc_for_each_node_by_name(b, b_node, name) {
+			rv = get_info_func(b, b_node, &b_node_info);
+			if (rv != 0)
+				continue;
+
+			if (node_match_func(&a_node_info, &b_node_info)) {
+				found = true;
 				break;
 			}
 		}
+
 		if (!found)
-			func(a, node);
+			func(a, a_node, name);
+
 	}
 }
 
diff --git a/arch/sparc/kernel/vio.c b/arch/sparc/kernel/vio.c
index 075d389..d5cf831 100644
--- a/arch/sparc/kernel/vio.c
+++ b/arch/sparc/kernel/vio.c
@@ -219,7 +219,7 @@ int vio_set_intr(unsigned long dev_ino, int state)
 EXPORT_SYMBOL(vio_set_intr);
 
 static struct vio_dev *vio_create_one(struct mdesc_handle *hp, u64 mp,
-				      struct device *parent)
+				      char *node_name, struct device *parent)
 {
 	const char *type, *compat, *bus_id_name;
 	struct device_node *dp;
@@ -236,7 +236,7 @@ int vio_set_intr(unsigned long dev_ino, int state)
 			tlen = strlen(type) + 1;
 		}
 	}
-	if (tlen > VIO_MAX_TYPE_LEN) {
+	if (tlen > VIO_MAX_TYPE_LEN || strlen(type) >= VIO_MAX_TYPE_LEN) {
 		printk(KERN_ERR "VIO: Type string [%s] is too long.\n",
 		       type);
 		return NULL;
@@ -335,6 +335,11 @@ int vio_set_intr(unsigned long dev_ino, int state)
 
 	printk(KERN_INFO "VIO: Adding device %s\n", dev_name(&vdev->dev));
 
+	/* node_name is NULL for the parent/channel-devices node */
+	if (node_name != NULL)
+		(void) snprintf(vdev->node_name, VIO_MAX_NAME_LEN, "%s",
+				node_name);
+
 	err = device_register(&vdev->dev);
 	if (err) {
 		printk(KERN_ERR "VIO: Could not register device %s, err=%d\n",
@@ -349,9 +354,10 @@ int vio_set_intr(unsigned long dev_ino, int state)
 	return vdev;
 }
 
-static void vio_add(struct mdesc_handle *hp, u64 node)
+static void vio_add(struct mdesc_handle *hp, u64 node,
+		    const char *node_name)
 {
-	(void) vio_create_one(hp, node, &root_vdev->dev);
+	(void) vio_create_one(hp, node, (char *)node_name, &root_vdev->dev);
 }
 
 struct vio_md_node_query {
@@ -375,7 +381,7 @@ static int vio_md_node_match(struct device *dev, void *arg)
 	return 1;
 }
 
-static void vio_remove(struct mdesc_handle *hp, u64 node)
+static void vio_remove(struct mdesc_handle *hp, u64 node, const char *node_name)
 {
 	const char *type;
 	const u64 *id, *cfg_handle;
@@ -446,7 +452,8 @@ static void vio_remove(struct mdesc_handle *hp, u64 node)
  * under "openboot" that we should not mess with as aparently that is
  * reserved exclusively for OBP use.
  */
-static void vio_add_ds(struct mdesc_handle *hp, u64 node)
+static void vio_add_ds(struct mdesc_handle *hp, u64 node,
+		       const char *node_name)
 {
 	int found;
 	u64 a;
@@ -463,7 +470,8 @@ static void vio_add_ds(struct mdesc_handle *hp, u64 node)
 	}
 
 	if (found)
-		(void) vio_create_one(hp, node, &root_vdev->dev);
+		(void) vio_create_one(hp, node, (char *)node_name,
+				      &root_vdev->dev);
 }
 
 static struct mdesc_notifier_client vio_ds_notifier = {
@@ -530,7 +538,7 @@ static int __init vio_init(void)
 
 	cdev_cfg_handle = *cfg_handle;
 
-	root_vdev = vio_create_one(hp, root, NULL);
+	root_vdev = vio_create_one(hp, root, NULL, NULL);
 	err = -ENODEV;
 	if (!root_vdev) {
 		printk(KERN_ERR "VIO: Could not create root device.\n");
-- 
1.7.1

