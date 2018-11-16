From: Rob Herring <robh@kernel.org>
Date: Fri, 16 Nov 2018 21:06:55 +0000
Subject: [PATCH v2 04/10] of: Drop full path from full_name for PDT systems
Message-Id: <20181116210701.22968-5-robh@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Now that there are no more users of path_component_name for Sparc
outside of the PDT code and all users of device_node.full_name are
converted to use "%pOF" printf specifier, we can align Sparc with FDT
and store just the base node name and unit address in full_name. This
makes path_component_name redundant, so it can be removed.

As full_name is used by printf specifiers, set it as early as possible.

Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
- Also drop full path on !Sparc PDT node name construction. While not 
strictly necessary to do both at the same time, it keeps things aligned.
 
 drivers/of/pdt.c   | 50 +++++++++++++---------------------------------
 include/linux/of.h |  1 -
 2 files changed, 14 insertions(+), 37 deletions(-)

diff --git a/drivers/of/pdt.c b/drivers/of/pdt.c
index 013e65de074a..c1633041621d 100644
--- a/drivers/of/pdt.c
+++ b/drivers/of/pdt.c
@@ -32,24 +32,7 @@ unsigned int of_pdt_unique_id __initdata;
 
 static char * __init of_pdt_build_full_name(struct device_node *dp)
 {
-	int len, ourlen, plen;
-	char *n;
-
-	dp->path_component_name = build_path_component(dp);
-
-	plen = strlen(dp->parent->full_name);
-	ourlen = strlen(dp->path_component_name);
-	len = ourlen + plen + 2;
-
-	n = prom_early_alloc(len);
-	strcpy(n, dp->parent->full_name);
-	if (!of_node_is_root(dp->parent)) {
-		strcpy(n + plen, "/");
-		plen++;
-	}
-	strcpy(n + plen, dp->path_component_name);
-
-	return n;
+	return build_path_component(dp);
 }
 
 #else /* CONFIG_SPARC */
@@ -60,23 +43,21 @@ static inline void irq_trans_init(struct device_node *dp) { }
 static char * __init of_pdt_build_full_name(struct device_node *dp)
 {
 	static int failsafe_id = 0; /* for generating unique names on failure */
+	const char *name;
+	char path[256];
 	char *buf;
 	int len;
 
-	if (of_pdt_prom_ops->pkg2path(dp->phandle, NULL, 0, &len))
-		goto failsafe;
-
-	buf = prom_early_alloc(len + 1);
-	if (of_pdt_prom_ops->pkg2path(dp->phandle, buf, len, &len))
-		goto failsafe;
-	return buf;
+	if (!of_pdt_prom_ops->pkg2path(dp->phandle, path, sizeof(path), &len)) {
+		name = kbasename(path);
+		buf = prom_early_alloc(strlen(name) + 1);
+		strcpy(buf, name);
+		return buf;
+	}
 
- failsafe:
-	buf = prom_early_alloc(strlen(dp->parent->full_name) +
-			       strlen(dp->name) + 16);
-	sprintf(buf, "%s/%s@unknown%i",
-		of_node_is_root(dp->parent) ? "" : dp->parent->full_name,
-		dp->name, failsafe_id++);
+	name = of_get_property(dp, "name", &len);
+	buf = prom_early_alloc(len + 16);
+	sprintf(buf, "%s@unknown%i", name, failsafe_id++);
 	pr_err("%s: pkg2path failed; assigning %s\n", __func__, buf);
 	return buf;
 }
@@ -181,6 +162,8 @@ static struct device_node * __init of_pdt_create_node(phandle node,
 
 	dp->properties = of_pdt_build_prop_list(node);
 
+	dp->full_name = of_pdt_build_full_name(dp);
+
 	irq_trans_init(dp);
 
 	return dp;
@@ -204,8 +187,6 @@ static struct device_node * __init of_pdt_build_tree(struct device_node *parent,
 			ret = dp;
 		prev_sibling = dp;
 
-		dp->full_name = of_pdt_build_full_name(dp);
-
 		dp->child = of_pdt_build_tree(dp, of_pdt_prom_ops->getchild(node));
 
 		if (of_pdt_build_more)
@@ -228,9 +209,6 @@ void __init of_pdt_build_devicetree(phandle root_node, struct of_pdt_ops *ops)
 	of_pdt_prom_ops = ops;
 
 	of_root = of_pdt_create_node(root_node, NULL);
-#if defined(CONFIG_SPARC)
-	of_root->path_component_name = "";
-#endif
 	of_root->full_name = "/";
 
 	of_root->child = of_pdt_build_tree(of_root,
diff --git a/include/linux/of.h b/include/linux/of.h
index a5aee3c438ad..0fe5bef81a7e 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -66,7 +66,6 @@ struct device_node {
 	unsigned long _flags;
 	void	*data;
 #if defined(CONFIG_SPARC)
-	const char *path_component_name;
 	unsigned int unique_id;
 	struct of_irq_controller *irq_trans;
 #endif
-- 
2.19.1
