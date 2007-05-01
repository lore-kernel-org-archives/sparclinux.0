From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 01 May 2007 07:28:40 +0000
Subject: [PATCH 05/11] Consolidate of_get_parent
Message-Id: <20070501172840.912968cc.sfr@canb.auug.org.au>
List-Id: <sparclinux.vger.kernel.org>
References: <20070501172250.80707fb8.sfr@canb.auug.org.au>
In-Reply-To: <20070501172250.80707fb8.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>, paulus@samba.org
Cc: sparclinux@vger.kernel.org, ppc-dev <linuxppc-dev@ozlabs.org>

This requires creating dummy of_node_{get,put} routines for sparc and
sparc64.  It also adds a read_lock around the parent accesses.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/prom.c |   21 ---------------------
 arch/sparc/kernel/prom.c   |   13 -------------
 arch/sparc64/kernel/prom.c |   13 -------------
 drivers/of/base.c          |   21 +++++++++++++++++++++
 include/asm-sparc/prom.h   |    9 +++++++++
 include/asm-sparc64/prom.h |    9 +++++++++
 6 files changed, 39 insertions(+), 47 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 939d5e4..55e67ca 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -1225,27 +1225,6 @@ struct device_node *of_find_all_nodes(struct device_node *prev)
 EXPORT_SYMBOL(of_find_all_nodes);
 
 /**
- *	of_get_parent - Get a node's parent if any
- *	@node:	Node to get parent
- *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.
- */
-struct device_node *of_get_parent(const struct device_node *node)
-{
-	struct device_node *np;
-
-	if (!node)
-		return NULL;
-
-	read_lock(&devtree_lock);
-	np = of_node_get(node->parent);
-	read_unlock(&devtree_lock);
-	return np;
-}
-EXPORT_SYMBOL(of_get_parent);
-
-/**
  *	of_get_next_child - Iterate a node childs
  *	@node:	parent node
  *	@prev:	previous child of the parent node, or NULL to get first
diff --git a/arch/sparc/kernel/prom.c b/arch/sparc/kernel/prom.c
index 0f5aab4..b378715 100644
--- a/arch/sparc/kernel/prom.c
+++ b/arch/sparc/kernel/prom.c
@@ -29,19 +29,6 @@ static struct device_node *allnodes;
 
 extern rwlock_t devtree_lock;	/* temporary while merging */
 
-struct device_node *of_get_parent(const struct device_node *node)
-{
-	struct device_node *np;
-
-	if (!node)
-		return NULL;
-
-	np = node->parent;
-
-	return np;
-}
-EXPORT_SYMBOL(of_get_parent);
-
 struct device_node *of_get_next_child(const struct device_node *node,
 	struct device_node *prev)
 {
diff --git a/arch/sparc64/kernel/prom.c b/arch/sparc64/kernel/prom.c
index c759660..f876079 100644
--- a/arch/sparc64/kernel/prom.c
+++ b/arch/sparc64/kernel/prom.c
@@ -33,19 +33,6 @@ static struct device_node *allnodes;
 
 extern rwlock_t devtree_lock;	/* temporary while merging */
 
-struct device_node *of_get_parent(const struct device_node *node)
-{
-	struct device_node *np;
-
-	if (!node)
-		return NULL;
-
-	np = node->parent;
-
-	return np;
-}
-EXPORT_SYMBOL(of_get_parent);
-
 struct device_node *of_get_next_child(const struct device_node *node,
 	struct device_node *prev)
 {
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 70b6084..82bb786 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -113,3 +113,24 @@ int of_device_is_compatible(const struct device_node *device,
 	return 0;
 }
 EXPORT_SYMBOL(of_device_is_compatible);
+
+/**
+ *	of_get_parent - Get a node's parent if any
+ *	@node:	Node to get parent
+ *
+ *	Returns a node pointer with refcount incremented, use
+ *	of_node_put() on it when done.
+ */
+struct device_node *of_get_parent(const struct device_node *node)
+{
+	struct device_node *np;
+
+	if (!node)
+		return NULL;
+
+	read_lock(&devtree_lock);
+	np = of_node_get(node->parent);
+	read_unlock(&devtree_lock);
+	return np;
+}
+EXPORT_SYMBOL(of_get_parent);
diff --git a/include/asm-sparc/prom.h b/include/asm-sparc/prom.h
index 22abc2a..5dc4c0e 100644
--- a/include/asm-sparc/prom.h
+++ b/include/asm-sparc/prom.h
@@ -66,6 +66,15 @@ extern int of_getintprop_default(struct device_node *np,
 
 extern void prom_build_devicetree(void);
 
+/* Dummy ref counting routines - to be implemented later */
+static inline struct device_node *of_node_get(struct device_node *node)
+{
+	return node;
+}
+static inline void of_node_put(struct device_node *node)
+{
+}
+
 /*
  * NB:  This is here while we transition from using asm/prom.h
  * to linux/of.h
diff --git a/include/asm-sparc64/prom.h b/include/asm-sparc64/prom.h
index f88c412..afd707a 100644
--- a/include/asm-sparc64/prom.h
+++ b/include/asm-sparc64/prom.h
@@ -74,6 +74,15 @@ extern int of_getintprop_default(struct device_node *np,
 
 extern void prom_build_devicetree(void);
 
+/* Dummy ref counting routines - to be implemented later */
+static inline struct device_node *of_node_get(struct device_node *node)
+{
+	return node;
+}
+static inline void of_node_put(struct device_node *node)
+{
+}
+
 /*
  * NB:  This is here while we transition from using asm/prom.h
  * to linux/of.h
-- 
1.5.1.2

