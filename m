From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 01 May 2007 07:29:46 +0000
Subject: [PATCH 06/11] Consolidate of_get_next_child
Message-Id: <20070501172946.d17ab9b0.sfr@canb.auug.org.au>
List-Id: <sparclinux.vger.kernel.org>
References: <20070501172250.80707fb8.sfr@canb.auug.org.au>
In-Reply-To: <20070501172250.80707fb8.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>, paulus@samba.org
Cc: sparclinux@vger.kernel.org, ppc-dev <linuxppc-dev@ozlabs.org>

This adds a read_lock around the child/next accesses on Sparc.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/prom.c |   24 ------------------------
 arch/sparc/kernel/prom.c   |   14 --------------
 arch/sparc64/kernel/prom.c |   14 --------------
 drivers/of/base.c          |   24 ++++++++++++++++++++++++
 4 files changed, 24 insertions(+), 52 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 55e67ca..90901e4 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -1225,30 +1225,6 @@ struct device_node *of_find_all_nodes(struct device_node *prev)
 EXPORT_SYMBOL(of_find_all_nodes);
 
 /**
- *	of_get_next_child - Iterate a node childs
- *	@node:	parent node
- *	@prev:	previous child of the parent node, or NULL to get first
- *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.
- */
-struct device_node *of_get_next_child(const struct device_node *node,
-	struct device_node *prev)
-{
-	struct device_node *next;
-
-	read_lock(&devtree_lock);
-	next = prev ? prev->sibling : node->child;
-	for (; next != 0; next = next->sibling)
-		if (of_node_get(next))
-			break;
-	of_node_put(prev);
-	read_unlock(&devtree_lock);
-	return next;
-}
-EXPORT_SYMBOL(of_get_next_child);
-
-/**
  *	of_node_get - Increment refcount of a node
  *	@node:	Node to inc refcount, NULL is supported to
  *		simplify writing of callers
diff --git a/arch/sparc/kernel/prom.c b/arch/sparc/kernel/prom.c
index b378715..3f8ccfa 100644
--- a/arch/sparc/kernel/prom.c
+++ b/arch/sparc/kernel/prom.c
@@ -29,20 +29,6 @@ static struct device_node *allnodes;
 
 extern rwlock_t devtree_lock;	/* temporary while merging */
 
-struct device_node *of_get_next_child(const struct device_node *node,
-	struct device_node *prev)
-{
-	struct device_node *next;
-
-	next = prev ? prev->sibling : node->child;
-	for (; next != 0; next = next->sibling) {
-		break;
-	}
-
-	return next;
-}
-EXPORT_SYMBOL(of_get_next_child);
-
 struct device_node *of_find_node_by_path(const char *path)
 {
 	struct device_node *np = allnodes;
diff --git a/arch/sparc64/kernel/prom.c b/arch/sparc64/kernel/prom.c
index f876079..be3b958 100644
--- a/arch/sparc64/kernel/prom.c
+++ b/arch/sparc64/kernel/prom.c
@@ -33,20 +33,6 @@ static struct device_node *allnodes;
 
 extern rwlock_t devtree_lock;	/* temporary while merging */
 
-struct device_node *of_get_next_child(const struct device_node *node,
-	struct device_node *prev)
-{
-	struct device_node *next;
-
-	next = prev ? prev->sibling : node->child;
-	for (; next != 0; next = next->sibling) {
-		break;
-	}
-
-	return next;
-}
-EXPORT_SYMBOL(of_get_next_child);
-
 struct device_node *of_find_node_by_path(const char *path)
 {
 	struct device_node *np = allnodes;
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 82bb786..6b6dfcc 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -134,3 +134,27 @@ struct device_node *of_get_parent(const struct device_node *node)
 	return np;
 }
 EXPORT_SYMBOL(of_get_parent);
+
+/**
+ *	of_get_next_child - Iterate a node childs
+ *	@node:	parent node
+ *	@prev:	previous child of the parent node, or NULL to get first
+ *
+ *	Returns a node pointer with refcount incremented, use
+ *	of_node_put() on it when done.
+ */
+struct device_node *of_get_next_child(const struct device_node *node,
+	struct device_node *prev)
+{
+	struct device_node *next;
+
+	read_lock(&devtree_lock);
+	next = prev ? prev->sibling : node->child;
+	for (; next; next = next->sibling)
+		if (of_node_get(next))
+			break;
+	of_node_put(prev);
+	read_unlock(&devtree_lock);
+	return next;
+}
+EXPORT_SYMBOL(of_get_next_child);
-- 
1.5.1.2

