From: David Miller <davem@davemloft.net>
Date: Sat, 06 Dec 2008 03:05:24 +0000
Subject: [PATCH 10/14]: sparc: Move create_node() and friends into
Message-Id: <20081205.190524.65720852.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc: Move create_node() and friends into prom_common.c

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/prom.h        |    3 +-
 arch/sparc/kernel/prom_32.c     |   38 ------------------------------------
 arch/sparc/kernel/prom_64.c     |   38 ------------------------------------
 arch/sparc/kernel/prom_common.c |   41 ++++++++++++++++++++++++++++++++++++++-
 4 files changed, 42 insertions(+), 78 deletions(-)

diff --git a/arch/sparc/kernel/prom.h b/arch/sparc/kernel/prom.h
index 49c25bd..d14b4ae 100644
--- a/arch/sparc/kernel/prom.h
+++ b/arch/sparc/kernel/prom.h
@@ -15,6 +15,7 @@ extern void irq_trans_init(struct device_node *dp);
 
 extern unsigned int prom_unique_id;
 
-extern struct property * __init build_prop_list(phandle node);
+extern struct device_node * __init create_node(phandle node,
+					       struct device_node *parent);
 
 #endif /* __PROM_H */
diff --git a/arch/sparc/kernel/prom_32.c b/arch/sparc/kernel/prom_32.c
index 5818aa9..5881c14 100644
--- a/arch/sparc/kernel/prom_32.c
+++ b/arch/sparc/kernel/prom_32.c
@@ -196,44 +196,6 @@ static char * __init build_full_name(struct device_node *dp)
 	return n;
 }
 
-static char * __init get_one_property(phandle node, const char *name)
-{
-	char *buf = "<NULL>";
-	int len;
-
-	len = prom_getproplen(node, name);
-	if (len > 0) {
-		buf = prom_early_alloc(len);
-		len = prom_getproperty(node, name, buf, len);
-	}
-
-	return buf;
-}
-
-static struct device_node * __init create_node(phandle node, struct device_node *parent)
-{
-	struct device_node *dp;
-
-	if (!node)
-		return NULL;
-
-	dp = prom_early_alloc(sizeof(*dp));
-	dp->unique_id = prom_unique_id++;
-	dp->parent = parent;
-
-	kref_init(&dp->kref);
-
-	dp->name = get_one_property(node, "name");
-	dp->type = get_one_property(node, "device_type");
-	dp->node = node;
-
-	/* Build interrupts later... */
-
-	dp->properties = build_prop_list(node);
-
-	return dp;
-}
-
 static struct device_node * __init build_tree(struct device_node *parent, phandle node, struct device_node ***nextp)
 {
 	struct device_node *dp;
diff --git a/arch/sparc/kernel/prom_64.c b/arch/sparc/kernel/prom_64.c
index ce96c1c..c1ce987 100644
--- a/arch/sparc/kernel/prom_64.c
+++ b/arch/sparc/kernel/prom_64.c
@@ -399,44 +399,6 @@ static char * __init build_full_name(struct device_node *dp)
 	return n;
 }
 
-static char * __init get_one_property(phandle node, const char *name)
-{
-	char *buf = "<NULL>";
-	int len;
-
-	len = prom_getproplen(node, name);
-	if (len > 0) {
-		buf = prom_early_alloc(len);
-		len = prom_getproperty(node, name, buf, len);
-	}
-
-	return buf;
-}
-
-static struct device_node * __init create_node(phandle node, struct device_node *parent)
-{
-	struct device_node *dp;
-
-	if (!node)
-		return NULL;
-
-	dp = prom_early_alloc(sizeof(*dp));
-	dp->unique_id = prom_unique_id++;
-	dp->parent = parent;
-
-	kref_init(&dp->kref);
-
-	dp->name = get_one_property(node, "name");
-	dp->type = get_one_property(node, "device_type");
-	dp->node = node;
-
-	dp->properties = build_prop_list(node);
-
-	irq_trans_init(dp);
-
-	return dp;
-}
-
 static struct device_node * __init build_tree(struct device_node *parent, phandle node, struct device_node ***nextp)
 {
 	struct device_node *ret = NULL, *prev_sibling = NULL;
diff --git a/arch/sparc/kernel/prom_common.c b/arch/sparc/kernel/prom_common.c
index 7620567..d3eddc7 100644
--- a/arch/sparc/kernel/prom_common.c
+++ b/arch/sparc/kernel/prom_common.c
@@ -184,7 +184,7 @@ static struct property * __init build_one_prop(phandle node, char *prev,
 	return p;
 }
 
-struct property * __init build_prop_list(phandle node)
+static struct property * __init build_prop_list(phandle node)
 {
 	struct property *head, *tail;
 
@@ -201,3 +201,42 @@ struct property * __init build_prop_list(phandle node)
 
 	return head;
 }
+
+static char * __init get_one_property(phandle node, const char *name)
+{
+	char *buf = "<NULL>";
+	int len;
+
+	len = prom_getproplen(node, name);
+	if (len > 0) {
+		buf = prom_early_alloc(len);
+		len = prom_getproperty(node, name, buf, len);
+	}
+
+	return buf;
+}
+
+struct device_node * __init create_node(phandle node,
+					struct device_node *parent)
+{
+	struct device_node *dp;
+
+	if (!node)
+		return NULL;
+
+	dp = prom_early_alloc(sizeof(*dp));
+	dp->unique_id = prom_unique_id++;
+	dp->parent = parent;
+
+	kref_init(&dp->kref);
+
+	dp->name = get_one_property(node, "name");
+	dp->type = get_one_property(node, "device_type");
+	dp->node = node;
+
+	/* Build interrupts later... */
+
+	dp->properties = build_prop_list(node);
+
+	return dp;
+}
-- 
1.5.6.5

