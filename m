From: Jag Raman <jag.raman@oracle.com>
Date: Fri, 09 Jun 2017 16:30:53 +0000
Subject: [PATCH v1 04/12] sparc64: expand MDESC interface
Message-Id: <214c8e29bc065cb831b81a7e3f9e0b6f27c62f81.1497024216.git.jag.raman@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Add the following two APIs to Machine Description (MDESC)
- mdesc_get_node: Searches for a node in the Machine
  Description tree based on given information about
  that node.
- mdesc_get_node_info: Retrieves information about a
  given node.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 arch/sparc/include/asm/mdesc.h |   17 ++++
 arch/sparc/kernel/mdesc.c      |  177 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 194 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/mdesc.h b/arch/sparc/include/asm/mdesc.h
index aebeb88..d8f6160 100644
--- a/arch/sparc/include/asm/mdesc.h
+++ b/arch/sparc/include/asm/mdesc.h
@@ -16,6 +16,7 @@
 void mdesc_release(struct mdesc_handle *);
 
 #define MDESC_NODE_NULL		(~(u64)0)
+#define MDESC_MAX_STR_LEN	256
 
 u64 mdesc_node_by_name(struct mdesc_handle *handle,
 		       u64 from_node, const char *name);
@@ -71,6 +72,22 @@ struct mdesc_notifier_client {
 
 void mdesc_register_notifier(struct mdesc_notifier_client *client);
 
+union md_node_info {
+	struct vdev_port {
+		u64 id;				/* id */
+		u64 parent_cfg_hdl;		/* parent config handle */
+		char name[MDESC_MAX_STR_LEN];	/* name (property) */
+	} vdev_port;
+	struct ds_port {
+		u64 id;				/* id */
+	} ds_port;
+};
+
+u64 mdesc_get_node(struct mdesc_handle *hp, char *node_name,
+		   union md_node_info *node_info);
+int mdesc_get_node_info(struct mdesc_handle *hp, u64 node,
+			char *node_name, union md_node_info *node_info);
+
 void mdesc_fill_in_cpu_data(cpumask_t *mask);
 void mdesc_populate_present_mask(cpumask_t *mask);
 void mdesc_get_page_sizes(cpumask_t *mask, unsigned long *pgsz_mask);
diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
index c0765bb..dfbc354 100644
--- a/arch/sparc/kernel/mdesc.c
+++ b/arch/sparc/kernel/mdesc.c
@@ -75,6 +75,51 @@ struct mdesc_handle {
 	struct mdesc_hdr	mdesc;
 };
 
+typedef int (*mdesc_node_info_f)(struct mdesc_handle *, u64,
+				 union md_node_info *);
+typedef bool (*mdesc_node_match_f)(union md_node_info *, union md_node_info *);
+
+struct md_node_ops {
+	char *name;
+	mdesc_node_info_f get_info;
+	mdesc_node_match_f node_match;
+};
+
+static int get_vdev_port_node_info(struct mdesc_handle *md, u64 node,
+				   union md_node_info *node_info);
+static bool vdev_port_node_match(union md_node_info *a_node_info,
+				 union md_node_info *b_node_info);
+static int get_ds_port_node_info(struct mdesc_handle *md, u64 node,
+				 union md_node_info *node_info);
+static bool ds_port_node_match(union md_node_info *a_node_info,
+			       union md_node_info *b_node_info);
+
+/* supported node types which can be registered */
+static struct md_node_ops md_node_ops_table[] = {
+	{"virtual-device-port", get_vdev_port_node_info, vdev_port_node_match},
+	{"domain-services-port", get_ds_port_node_info, ds_port_node_match},
+	{NULL, NULL, NULL}
+};
+
+static void mdesc_get_node_ops(char *node_name, mdesc_node_info_f *node_info_f,
+			       mdesc_node_match_f *node_match_f)
+{
+	int i;
+
+	*node_info_f = NULL;
+	*node_match_f = NULL;
+
+	if (node_name != NULL) {
+		for (i = 0; md_node_ops_table[i].name != NULL; i++) {
+			if (strcmp(md_node_ops_table[i].name, node_name) = 0) {
+				*node_info_f = md_node_ops_table[i].get_info;
+				*node_match_f = md_node_ops_table[i].node_match;
+				break;
+			}
+		}
+	}
+}
+
 static void mdesc_handle_init(struct mdesc_handle *hp,
 			      unsigned int handle_size,
 			      void *base)
@@ -249,6 +294,75 @@ void mdesc_register_notifier(struct mdesc_notifier_client *client)
 	return id;
 }
 
+static int get_vdev_port_node_info(struct mdesc_handle *md, u64 node,
+				   union md_node_info *node_info)
+{
+	const u64 *parent_cfg_hdlp;
+	const char *name;
+	const u64 *idp;
+
+	/*
+	 * Virtual device nodes are distinguished by:
+	 * 1. "id" property
+	 * 2. "name" property
+	 * 3. parent node "cfg-handle" property
+	 */
+	idp = mdesc_get_property(md, node, "id", NULL);
+	name = mdesc_get_property(md, node, "name", NULL);
+	parent_cfg_hdlp = parent_cfg_handle(md, node);
+
+	if (!idp || !name || !parent_cfg_hdlp)
+		return -1;
+
+	node_info->vdev_port.id = *idp;
+	(void) snprintf(node_info->vdev_port.name, MDESC_MAX_STR_LEN, "%s",
+			name);
+	node_info->vdev_port.parent_cfg_hdl = *parent_cfg_hdlp;
+
+	return 0;
+}
+
+static bool vdev_port_node_match(union md_node_info *a_node_info,
+				 union md_node_info *b_node_info)
+{
+	if (a_node_info->vdev_port.id != b_node_info->vdev_port.id)
+		return false;
+
+	if (a_node_info->vdev_port.parent_cfg_hdl !+	    b_node_info->vdev_port.parent_cfg_hdl)
+		return false;
+
+	if (strncmp(a_node_info->vdev_port.name,
+		    b_node_info->vdev_port.name, MDESC_MAX_STR_LEN) != 0)
+		return false;
+
+	return true;
+}
+
+static int get_ds_port_node_info(struct mdesc_handle *md, u64 node,
+				 union md_node_info *node_info)
+{
+	const u64 *idp;
+
+	/* DS port nodes use the "id" property to distinguish them */
+	idp = mdesc_get_property(md, node, "id", NULL);
+	if (!idp)
+		return -1;
+
+	node_info->ds_port.id = *idp;
+
+	return 0;
+}
+
+static bool ds_port_node_match(union md_node_info *a_node_info,
+			       union md_node_info *b_node_info)
+{
+	if (a_node_info->ds_port.id != b_node_info->ds_port.id)
+		return false;
+
+	return true;
+}
+
 /* Run 'func' on nodes which are in A but not in B.  */
 static void invoke_on_missing(const char *name,
 			      struct mdesc_handle *a,
@@ -367,6 +481,69 @@ void mdesc_update(void)
 	mutex_unlock(&mdesc_mutex);
 }
 
+u64 mdesc_get_node(struct mdesc_handle *hp, char *node_name,
+		   union md_node_info *node_info)
+{
+	mdesc_node_match_f node_match_func;
+	mdesc_node_info_f get_info_func;
+	union md_node_info hp_node_info;
+	u64 hp_node;
+	int rv;
+
+	if (hp = NULL || node_name = NULL || node_info = NULL)
+		return MDESC_NODE_NULL;
+
+	/* Find the ops for the given node name */
+	mdesc_get_node_ops(node_name, &get_info_func, &node_match_func);
+
+	/* If we didn't find a node_match func, the node is not supported */
+	if (get_info_func = NULL || node_match_func = NULL) {
+		pr_err("MD: %s node is not supported\n", node_name);
+		return -EINVAL;
+	}
+
+	mdesc_for_each_node_by_name(hp, hp_node, node_name) {
+		rv = get_info_func(hp, hp_node, &hp_node_info);
+		if (rv != 0)
+			continue;
+
+		if (node_match_func(node_info, &hp_node_info))
+			break;
+	}
+
+	return hp_node;
+}
+
+int mdesc_get_node_info(struct mdesc_handle *hp, u64 node, char *node_name,
+			union md_node_info *node_info)
+{
+	mdesc_node_match_f node_match_func;
+	mdesc_node_info_f get_info_func;
+	int rv;
+
+	if (hp = NULL || node = MDESC_NODE_NULL ||
+	    node_name = NULL || node_info = NULL)
+		return -EINVAL;
+
+	/* Find the get_info op for the given node name */
+	mdesc_get_node_ops(node_name, &get_info_func, &node_match_func);
+
+	/* If we didn't find a get_info_func, the node name is not supported */
+	if (get_info_func = NULL) {
+		pr_err("MD: %s node is not supported\n", node_name);
+		return -EINVAL;
+	}
+
+	rv = get_info_func(hp, node, node_info);
+	if (rv != 0) {
+		pr_err("MD: Cannot find 1 or more required match properties for %s node.\n",
+		       node_name);
+		return -1;
+	}
+
+	return 0;
+}
+
 static struct mdesc_elem *node_block(struct mdesc_hdr *mdesc)
 {
 	return (struct mdesc_elem *) (mdesc + 1);
-- 
1.7.1

