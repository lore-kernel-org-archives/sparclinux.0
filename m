From: David Miller <davem@davemloft.net>
Date: Sat, 06 Dec 2008 03:05:28 +0000
Subject: [PATCH 12/14]: sparc: Move core of OF device tree building code
Message-Id: <20081205.190528.51025366.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc: Move core of OF device tree building code into prom_common.c

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/prom.h        |   17 ++++++++-
 arch/sparc/kernel/prom_32.c     |   69 +++------------------------------------
 arch/sparc/kernel/prom_64.c     |   69 +++------------------------------------
 arch/sparc/kernel/prom_common.c |   57 +++++++++++++++++++++++++++++++-
 4 files changed, 80 insertions(+), 132 deletions(-)

diff --git a/arch/sparc/kernel/prom.h b/arch/sparc/kernel/prom.h
index d14b4ae..dea8b91 100644
--- a/arch/sparc/kernel/prom.h
+++ b/arch/sparc/kernel/prom.h
@@ -15,7 +15,20 @@ extern void irq_trans_init(struct device_node *dp);
 
 extern unsigned int prom_unique_id;
 
-extern struct device_node * __init create_node(phandle node,
-					       struct device_node *parent);
+static inline int is_root_node(const struct device_node *dp)
+{
+	if (!dp)
+		return 0;
 
+	return (dp->parent = NULL);
+}
+
+extern char *build_path_component(struct device_node *dp);
+
+extern struct device_node * __init prom_create_node(phandle node,
+						    struct device_node *parent);
+
+extern struct device_node * __init prom_build_tree(struct device_node *parent,
+						   phandle node,
+						   struct device_node ***nextp);
 #endif /* __PROM_H */
diff --git a/arch/sparc/kernel/prom_32.c b/arch/sparc/kernel/prom_32.c
index 35cb4c7..75eb40b 100644
--- a/arch/sparc/kernel/prom_32.c
+++ b/arch/sparc/kernel/prom_32.c
@@ -42,14 +42,6 @@ void * __init prom_early_alloc(unsigned long size)
 	return ret;
 }
 
-static int is_root_node(const struct device_node *dp)
-{
-	if (!dp)
-		return 0;
-
-	return (dp->parent = NULL);
-}
-
 /* The following routines deal with the black magic of fully naming a
  * node.
  *
@@ -161,7 +153,7 @@ static void __init __build_path_component(struct device_node *dp, char *tmp_buf)
 	return sparc32_path_component(dp, tmp_buf);
 }
 
-static char * __init build_path_component(struct device_node *dp)
+char * __init build_path_component(struct device_node *dp)
 {
 	char tmp_buf[64], *n;
 
@@ -176,57 +168,6 @@ static char * __init build_path_component(struct device_node *dp)
 	return n;
 }
 
-static char * __init build_full_name(struct device_node *dp)
-{
-	int len, ourlen, plen;
-	char *n;
-
-	plen = strlen(dp->parent->full_name);
-	ourlen = strlen(dp->path_component_name);
-	len = ourlen + plen + 2;
-
-	n = prom_early_alloc(len);
-	strcpy(n, dp->parent->full_name);
-	if (!is_root_node(dp->parent)) {
-		strcpy(n + plen, "/");
-		plen++;
-	}
-	strcpy(n + plen, dp->path_component_name);
-
-	return n;
-}
-
-static struct device_node * __init build_tree(struct device_node *parent, phandle node, struct device_node ***nextp)
-{
-	struct device_node *ret = NULL, *prev_sibling = NULL;
-	struct device_node *dp;
-
-	while (1) {
-		dp = create_node(node, parent);
-		if (!dp)
-			break;
-
-		if (prev_sibling)
-			prev_sibling->sibling = dp;
-
-		if (!ret)
-			ret = dp;
-		prev_sibling = dp;
-
-		*(*nextp) = dp;
-		*nextp = &dp->allnext;
-
-		dp->path_component_name = build_path_component(dp);
-		dp->full_name = build_full_name(dp);
-
-		dp->child = build_tree(dp, prom_getchild(node), nextp);
-
-		node = prom_getsibling(node);
-	}
-
-	return ret;
-}
-
 struct device_node *of_console_device;
 EXPORT_SYMBOL(of_console_device);
 
@@ -360,14 +301,14 @@ void __init prom_build_devicetree(void)
 {
 	struct device_node **nextp;
 
-	allnodes = create_node(prom_root_node, NULL);
+	allnodes = prom_create_node(prom_root_node, NULL);
 	allnodes->path_component_name = "";
 	allnodes->full_name = "/";
 
 	nextp = &allnodes->allnext;
-	allnodes->child = build_tree(allnodes,
-				     prom_getchild(allnodes->node),
-				     &nextp);
+	allnodes->child = prom_build_tree(allnodes,
+					  prom_getchild(allnodes->node),
+					  &nextp);
 	of_console_init();
 
 	printk("PROM: Built device tree with %u bytes of memory.\n",
diff --git a/arch/sparc/kernel/prom_64.c b/arch/sparc/kernel/prom_64.c
index c1ce987..0279811 100644
--- a/arch/sparc/kernel/prom_64.c
+++ b/arch/sparc/kernel/prom_64.c
@@ -51,14 +51,6 @@ void * __init prom_early_alloc(unsigned long size)
 	return ret;
 }
 
-static int is_root_node(const struct device_node *dp)
-{
-	if (!dp)
-		return 0;
-
-	return (dp->parent = NULL);
-}
-
 /* The following routines deal with the black magic of fully naming a
  * node.
  *
@@ -364,7 +356,7 @@ static void __init __build_path_component(struct device_node *dp, char *tmp_buf)
 	}
 }
 
-static char * __init build_path_component(struct device_node *dp)
+char * __init build_path_component(struct device_node *dp)
 {
 	char tmp_buf[64], *n;
 
@@ -379,57 +371,6 @@ static char * __init build_path_component(struct device_node *dp)
 	return n;
 }
 
-static char * __init build_full_name(struct device_node *dp)
-{
-	int len, ourlen, plen;
-	char *n;
-
-	plen = strlen(dp->parent->full_name);
-	ourlen = strlen(dp->path_component_name);
-	len = ourlen + plen + 2;
-
-	n = prom_early_alloc(len);
-	strcpy(n, dp->parent->full_name);
-	if (!is_root_node(dp->parent)) {
-		strcpy(n + plen, "/");
-		plen++;
-	}
-	strcpy(n + plen, dp->path_component_name);
-
-	return n;
-}
-
-static struct device_node * __init build_tree(struct device_node *parent, phandle node, struct device_node ***nextp)
-{
-	struct device_node *ret = NULL, *prev_sibling = NULL;
-	struct device_node *dp;
-
-	while (1) {
-		dp = create_node(node, parent);
-		if (!dp)
-			break;
-
-		if (prev_sibling)
-			prev_sibling->sibling = dp;
-
-		if (!ret)
-			ret = dp;
-		prev_sibling = dp;
-
-		*(*nextp) = dp;
-		*nextp = &dp->allnext;
-
-		dp->path_component_name = build_path_component(dp);
-		dp->full_name = build_full_name(dp);
-
-		dp->child = build_tree(dp, prom_getchild(node), nextp);
-
-		node = prom_getsibling(node);
-	}
-
-	return ret;
-}
-
 static const char *get_mid_prop(void)
 {
 	return (tlb_type = spitfire ? "upa-portid" : "portid");
@@ -640,14 +581,14 @@ void __init prom_build_devicetree(void)
 {
 	struct device_node **nextp;
 
-	allnodes = create_node(prom_root_node, NULL);
+	allnodes = prom_create_node(prom_root_node, NULL);
 	allnodes->path_component_name = "";
 	allnodes->full_name = "/";
 
 	nextp = &allnodes->allnext;
-	allnodes->child = build_tree(allnodes,
-				     prom_getchild(allnodes->node),
-				     &nextp);
+	allnodes->child = prom_build_tree(allnodes,
+					  prom_getchild(allnodes->node),
+					  &nextp);
 	of_console_init();
 
 	printk("PROM: Built device tree with %u bytes of memory.\n",
diff --git a/arch/sparc/kernel/prom_common.c b/arch/sparc/kernel/prom_common.c
index d3eddc7..3b5de2f 100644
--- a/arch/sparc/kernel/prom_common.c
+++ b/arch/sparc/kernel/prom_common.c
@@ -216,8 +216,8 @@ static char * __init get_one_property(phandle node, const char *name)
 	return buf;
 }
 
-struct device_node * __init create_node(phandle node,
-					struct device_node *parent)
+struct device_node * __init prom_create_node(phandle node,
+					     struct device_node *parent)
 {
 	struct device_node *dp;
 
@@ -240,3 +240,56 @@ struct device_node * __init create_node(phandle node,
 
 	return dp;
 }
+
+static char * __init build_full_name(struct device_node *dp)
+{
+	int len, ourlen, plen;
+	char *n;
+
+	plen = strlen(dp->parent->full_name);
+	ourlen = strlen(dp->path_component_name);
+	len = ourlen + plen + 2;
+
+	n = prom_early_alloc(len);
+	strcpy(n, dp->parent->full_name);
+	if (!is_root_node(dp->parent)) {
+		strcpy(n + plen, "/");
+		plen++;
+	}
+	strcpy(n + plen, dp->path_component_name);
+
+	return n;
+}
+
+struct device_node * __init prom_build_tree(struct device_node *parent,
+					    phandle node,
+					    struct device_node ***nextp)
+{
+	struct device_node *ret = NULL, *prev_sibling = NULL;
+	struct device_node *dp;
+
+	while (1) {
+		dp = prom_create_node(node, parent);
+		if (!dp)
+			break;
+
+		if (prev_sibling)
+			prev_sibling->sibling = dp;
+
+		if (!ret)
+			ret = dp;
+		prev_sibling = dp;
+
+		*(*nextp) = dp;
+		*nextp = &dp->allnext;
+
+		dp->path_component_name = build_path_component(dp);
+		dp->full_name = build_full_name(dp);
+
+		dp->child = prom_build_tree(dp, prom_getchild(node), nextp);
+
+		node = prom_getsibling(node);
+	}
+
+	return ret;
+}
-- 
1.5.6.5

