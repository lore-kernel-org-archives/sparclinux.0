From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 07 Oct 2009 04:32:27 +0000
Subject: [RFC PATCH 12/12] of: merge of_find_all_nodes() implementations
Message-Id: <20091007043219.16890.40203.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
References: <20091007041007.16890.62194.stgit@angua>
In-Reply-To: <20091007041007.16890.62194.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, Stephen Rothwell <sfr@canb.auug.org.au>, davem@davemloft.net, sparclinux@vger.kernel.org, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org

Merge common code between Microblaze and PowerPC, and make it available
to Sparc

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/microblaze/kernel/prom.c |   23 -----------------------
 arch/powerpc/kernel/prom.c    |   23 -----------------------
 drivers/of/base.c             |   26 +++++++++++++++++++++++++-
 include/linux/of.h            |    3 ++-
 4 files changed, 27 insertions(+), 48 deletions(-)

diff --git a/arch/microblaze/kernel/prom.c b/arch/microblaze/kernel/prom.c
index c005cc6..b817df1 100644
--- a/arch/microblaze/kernel/prom.c
+++ b/arch/microblaze/kernel/prom.c
@@ -860,29 +860,6 @@ struct device_node *of_find_node_by_phandle(phandle handle)
 EXPORT_SYMBOL(of_find_node_by_phandle);
 
 /**
- *	of_find_all_nodes - Get next node in global list
- *	@prev:	Previous node or NULL to start iteration
- *		of_node_put() will be called on it
- *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.
- */
-struct device_node *of_find_all_nodes(struct device_node *prev)
-{
-	struct device_node *np;
-
-	read_lock(&devtree_lock);
-	np = prev ? prev->allnext : allnodes;
-	for (; np != NULL; np = np->allnext)
-		if (of_node_get(np))
-			break;
-	of_node_put(prev);
-	read_unlock(&devtree_lock);
-	return np;
-}
-EXPORT_SYMBOL(of_find_all_nodes);
-
-/**
  *	of_node_get - Increment refcount of a node
  *	@node:	Node to inc refcount, NULL is supported to
  *		simplify writing of callers
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index d4405b9..4ec3008 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -1317,29 +1317,6 @@ struct device_node *of_find_next_cache_node(struct device_node *np)
 }
 
 /**
- *	of_find_all_nodes - Get next node in global list
- *	@prev:	Previous node or NULL to start iteration
- *		of_node_put() will be called on it
- *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.
- */
-struct device_node *of_find_all_nodes(struct device_node *prev)
-{
-	struct device_node *np;
-
-	read_lock(&devtree_lock);
-	np = prev ? prev->allnext : allnodes;
-	for (; np != 0; np = np->allnext)
-		if (of_node_get(np))
-			break;
-	of_node_put(prev);
-	read_unlock(&devtree_lock);
-	return np;
-}
-EXPORT_SYMBOL(of_find_all_nodes);
-
-/**
  *	of_node_get - Increment refcount of a node
  *	@node:	Node to inc refcount, NULL is supported to
  *		simplify writing of callers
diff --git a/drivers/of/base.c b/drivers/of/base.c
index ddf224d..e6627b2 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -9,7 +9,8 @@
  *
  *  Adapted for sparc and sparc64 by David S. Miller davem@davemloft.net
  *
- *  Reconsolidated from arch/x/kernel/prom.c by Stephen Rothwell.
+ *  Reconsolidated from arch/x/kernel/prom.c by Stephen Rothwell and
+ *  Grant Likely.
  *
  *      This program is free software; you can redistribute it and/or
  *      modify it under the terms of the GNU General Public License
@@ -82,6 +83,29 @@ struct property *of_find_property(const struct device_node *np,
 }
 EXPORT_SYMBOL(of_find_property);
 
+/**
+ * of_find_all_nodes - Get next node in global list
+ * @prev:	Previous node or NULL to start iteration
+ *		of_node_put() will be called on it
+ *
+ * Returns a node pointer with refcount incremented, use
+ * of_node_put() on it when done.
+ */
+struct device_node *of_find_all_nodes(struct device_node *prev)
+{
+	struct device_node *np;
+
+	read_lock(&devtree_lock);
+	np = prev ? prev->allnext : allnodes;
+	for (; np != NULL; np = np->allnext)
+		if (of_node_get(np))
+			break;
+	of_node_put(prev);
+	read_unlock(&devtree_lock);
+	return np;
+}
+EXPORT_SYMBOL(of_find_all_nodes);
+
 /*
  * Find a property with a given name for a given node
  * and return the value.
diff --git a/include/linux/of.h b/include/linux/of.h
index 4636bba..e7facd8 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -79,6 +79,8 @@ set_node_proc_entry(struct device_node *dn, struct proc_dir_entry *de)
 	dn->pde = de;
 }
 
+extern struct device_node *of_find_all_nodes(struct device_node *prev);
+
 #if defined(CONFIG_SPARC)
 /* Dummy ref counting routines - to be implemented later */
 static inline struct device_node *of_node_get(struct device_node *node)
@@ -90,7 +92,6 @@ static inline void of_node_put(struct device_node *node)
 }
 
 #else
-extern struct device_node *of_find_all_nodes(struct device_node *prev);
 extern struct device_node *of_node_get(struct device_node *node);
 extern void of_node_put(struct device_node *node);
 #endif

