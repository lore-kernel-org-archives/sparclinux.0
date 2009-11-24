From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 24 Nov 2009 08:19:26 +0000
Subject: [PATCH 08/11] of: Merge of_node_get() and of_node_put()
Message-Id: <20091124081918.6216.77775.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
References: <20091124081316.6216.66310.stgit@angua>
In-Reply-To: <20091124081316.6216.66310.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au, benh@kernel.crashing.org, sfr@canb.auug.org.au, dave

Merge common code between PowerPC and MicroBlaze

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/microblaze/kernel/prom.c |   74 ----------------------------------------
 arch/powerpc/kernel/prom.c    |   73 ----------------------------------------
 drivers/of/base.c             |   75 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 147 deletions(-)

diff --git a/arch/microblaze/kernel/prom.c b/arch/microblaze/kernel/prom.c
index c97192d..c0d53b7 100644
--- a/arch/microblaze/kernel/prom.c
+++ b/arch/microblaze/kernel/prom.c
@@ -313,80 +313,6 @@ struct device_node *of_find_node_by_phandle(phandle handle)
 }
 EXPORT_SYMBOL(of_find_node_by_phandle);
 
-/**
- *	of_node_get - Increment refcount of a node
- *	@node:	Node to inc refcount, NULL is supported to
- *		simplify writing of callers
- *
- *	Returns node.
- */
-struct device_node *of_node_get(struct device_node *node)
-{
-	if (node)
-		kref_get(&node->kref);
-	return node;
-}
-EXPORT_SYMBOL(of_node_get);
-
-static inline struct device_node *kref_to_device_node(struct kref *kref)
-{
-	return container_of(kref, struct device_node, kref);
-}
-
-/**
- *	of_node_release - release a dynamically allocated node
- *	@kref:  kref element of the node to be released
- *
- *	In of_node_put() this function is passed to kref_put()
- *	as the destructor.
- */
-static void of_node_release(struct kref *kref)
-{
-	struct device_node *node = kref_to_device_node(kref);
-	struct property *prop = node->properties;
-
-	/* We should never be releasing nodes that haven't been detached. */
-	if (!of_node_check_flag(node, OF_DETACHED)) {
-		printk(KERN_INFO "WARNING: Bad of_node_put() on %s\n",
-			node->full_name);
-		dump_stack();
-		kref_init(&node->kref);
-		return;
-	}
-
-	if (!of_node_check_flag(node, OF_DYNAMIC))
-		return;
-
-	while (prop) {
-		struct property *next = prop->next;
-		kfree(prop->name);
-		kfree(prop->value);
-		kfree(prop);
-		prop = next;
-
-		if (!prop) {
-			prop = node->deadprops;
-			node->deadprops = NULL;
-		}
-	}
-	kfree(node->full_name);
-	kfree(node->data);
-	kfree(node);
-}
-
-/**
- *	of_node_put - Decrement refcount of a node
- *	@node:	Node to dec refcount, NULL is supported to
- *		simplify writing of callers
- *
- */
-void of_node_put(struct device_node *node)
-{
-	if (node)
-		kref_put(&node->kref, of_node_release);
-}
-EXPORT_SYMBOL(of_node_put);
-
 /*
  * Plug a device node into the tree and global list.
  */
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 65de093..6873db9 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -740,79 +740,6 @@ struct device_node *of_find_next_cache_node(struct device_node *np)
 	return NULL;
 }
 
-/**
- *	of_node_get - Increment refcount of a node
- *	@node:	Node to inc refcount, NULL is supported to
- *		simplify writing of callers
- *
- *	Returns node.
- */
-struct device_node *of_node_get(struct device_node *node)
-{
-	if (node)
-		kref_get(&node->kref);
-	return node;
-}
-EXPORT_SYMBOL(of_node_get);
-
-static inline struct device_node * kref_to_device_node(struct kref *kref)
-{
-	return container_of(kref, struct device_node, kref);
-}
-
-/**
- *	of_node_release - release a dynamically allocated node
- *	@kref:  kref element of the node to be released
- *
- *	In of_node_put() this function is passed to kref_put()
- *	as the destructor.
- */
-static void of_node_release(struct kref *kref)
-{
-	struct device_node *node = kref_to_device_node(kref);
-	struct property *prop = node->properties;
-
-	/* We should never be releasing nodes that haven't been detached. */
-	if (!of_node_check_flag(node, OF_DETACHED)) {
-		printk("WARNING: Bad of_node_put() on %s\n", node->full_name);
-		dump_stack();
-		kref_init(&node->kref);
-		return;
-	}
-
-	if (!of_node_check_flag(node, OF_DYNAMIC))
-		return;
-
-	while (prop) {
-		struct property *next = prop->next;
-		kfree(prop->name);
-		kfree(prop->value);
-		kfree(prop);
-		prop = next;
-
-		if (!prop) {
-			prop = node->deadprops;
-			node->deadprops = NULL;
-		}
-	}
-	kfree(node->full_name);
-	kfree(node->data);
-	kfree(node);
-}
-
-/**
- *	of_node_put - Decrement refcount of a node
- *	@node:	Node to dec refcount, NULL is supported to
- *		simplify writing of callers
- *
- */
-void of_node_put(struct device_node *node)
-{
-	if (node)
-		kref_put(&node->kref, of_node_release);
-}
-EXPORT_SYMBOL(of_node_put);
-
 /*
  * Plug a device node into the tree and global list.
  */
diff --git a/drivers/of/base.c b/drivers/of/base.c
index e81558f..4b10c89 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -60,6 +60,81 @@ int of_n_size_cells(struct device_node *np)
 }
 EXPORT_SYMBOL(of_n_size_cells);
 
+#if !defined(CONFIG_SPARC)   /* SPARC doesn't do ref counting (yet) */
+/**
+ *	of_node_get - Increment refcount of a node
+ *	@node:	Node to inc refcount, NULL is supported to
+ *		simplify writing of callers
+ *
+ *	Returns node.
+ */
+struct device_node *of_node_get(struct device_node *node)
+{
+	if (node)
+		kref_get(&node->kref);
+	return node;
+}
+EXPORT_SYMBOL(of_node_get);
+
+static inline struct device_node *kref_to_device_node(struct kref *kref)
+{
+	return container_of(kref, struct device_node, kref);
+}
+
+/**
+ *	of_node_release - release a dynamically allocated node
+ *	@kref:  kref element of the node to be released
+ *
+ *	In of_node_put() this function is passed to kref_put()
+ *	as the destructor.
+ */
+static void of_node_release(struct kref *kref)
+{
+	struct device_node *node = kref_to_device_node(kref);
+	struct property *prop = node->properties;
+
+	/* We should never be releasing nodes that haven't been detached. */
+	if (!of_node_check_flag(node, OF_DETACHED)) {
+		pr_err("ERROR: Bad of_node_put() on %s\n", node->full_name);
+		dump_stack();
+		kref_init(&node->kref);
+		return;
+	}
+
+	if (!of_node_check_flag(node, OF_DYNAMIC))
+		return;
+
+	while (prop) {
+		struct property *next = prop->next;
+		kfree(prop->name);
+		kfree(prop->value);
+		kfree(prop);
+		prop = next;
+
+		if (!prop) {
+			prop = node->deadprops;
+			node->deadprops = NULL;
+		}
+	}
+	kfree(node->full_name);
+	kfree(node->data);
+	kfree(node);
+}
+
+/**
+ *	of_node_put - Decrement refcount of a node
+ *	@node:	Node to dec refcount, NULL is supported to
+ *		simplify writing of callers
+ *
+ */
+void of_node_put(struct device_node *node)
+{
+	if (node)
+		kref_put(&node->kref, of_node_release);
+}
+EXPORT_SYMBOL(of_node_put);
+#endif /* !CONFIG_SPARC */
+
 struct property *of_find_property(const struct device_node *np,
 				  const char *name,
 				  int *lenp)

