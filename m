From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 19 Jul 2007 15:14:50 +0000
Subject: [PATCH 07/12] Consolidate of_find_node_by routines
Message-Id: <20070720011450.d0b97300.sfr@canb.auug.org.au>
List-Id: <sparclinux.vger.kernel.org>
References: <20070718173024.50204a1a.sfr@canb.auug.org.au>
	<20070720010742.e60c67a7.sfr@canb.auug.org.au>
In-Reply-To: <20070720010742.e60c67a7.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ppc-dev <linuxppc-dev@ozlabs.org>, sparclinux@vger.kernel.org
Cc: paulus@samba.org, "David S. Miller" <davem@davemloft.net>, wli@holomorphy.com

This consolidates the routines of_find_node_by_path, of_find_node_by_name,
of_find_node_by_type and of_find_compatible_device.  Again, the comparison
of strings are done differently by Sparc and PowerPC and also these add
read_locks around the iterations.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/prom.c |  115 +-------------------------------------------
 arch/sparc/kernel/prom.c   |   61 +-----------------------
 arch/sparc64/kernel/prom.c |   61 +-----------------------
 drivers/of/base.c          |  115 ++++++++++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/prom.h |    1 +
 include/asm-sparc/prom.h   |    1 +
 include/asm-sparc64/prom.h |    1 +
 7 files changed, 121 insertions(+), 234 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 5fa221c..bdcd23d 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -78,7 +78,7 @@ static struct boot_param_header *initial_boot_params __initdata;
 struct boot_param_header *initial_boot_params;
 #endif
 
-static struct device_node *allnodes = NULL;
+extern struct device_node *allnodes;	/* temporary while merging */
 
 extern rwlock_t devtree_lock;	/* temporary while merging */
 
@@ -1084,119 +1084,6 @@ EXPORT_SYMBOL(machine_is_compatible);
  *******/
 
 /**
- *	of_find_node_by_name - Find a node by its "name" property
- *	@from:	The node to start searching from or NULL, the node
- *		you pass will not be searched, only the next one
- *		will; typically, you pass what the previous call
- *		returned. of_node_put() will be called on it
- *	@name:	The name string to match against
- *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.
- */
-struct device_node *of_find_node_by_name(struct device_node *from,
-	const char *name)
-{
-	struct device_node *np;
-
-	read_lock(&devtree_lock);
-	np = from ? from->allnext : allnodes;
-	for (; np != NULL; np = np->allnext)
-		if (np->name != NULL && strcasecmp(np->name, name) = 0
-		    && of_node_get(np))
-			break;
-	of_node_put(from);
-	read_unlock(&devtree_lock);
-	return np;
-}
-EXPORT_SYMBOL(of_find_node_by_name);
-
-/**
- *	of_find_node_by_type - Find a node by its "device_type" property
- *	@from:	The node to start searching from, or NULL to start searching
- *		the entire device tree. The node you pass will not be
- *		searched, only the next one will; typically, you pass
- *		what the previous call returned. of_node_put() will be
- *		called on from for you.
- *	@type:	The type string to match against
- *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.
- */
-struct device_node *of_find_node_by_type(struct device_node *from,
-	const char *type)
-{
-	struct device_node *np;
-
-	read_lock(&devtree_lock);
-	np = from ? from->allnext : allnodes;
-	for (; np != 0; np = np->allnext)
-		if (np->type != 0 && strcasecmp(np->type, type) = 0
-		    && of_node_get(np))
-			break;
-	of_node_put(from);
-	read_unlock(&devtree_lock);
-	return np;
-}
-EXPORT_SYMBOL(of_find_node_by_type);
-
-/**
- *	of_find_compatible_node - Find a node based on type and one of the
- *                                tokens in its "compatible" property
- *	@from:		The node to start searching from or NULL, the node
- *			you pass will not be searched, only the next one
- *			will; typically, you pass what the previous call
- *			returned. of_node_put() will be called on it
- *	@type:		The type string to match "device_type" or NULL to ignore
- *	@compatible:	The string to match to one of the tokens in the device
- *			"compatible" list.
- *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.
- */
-struct device_node *of_find_compatible_node(struct device_node *from,
-	const char *type, const char *compatible)
-{
-	struct device_node *np;
-
-	read_lock(&devtree_lock);
-	np = from ? from->allnext : allnodes;
-	for (; np != 0; np = np->allnext) {
-		if (type != NULL
-		    && !(np->type != 0 && strcasecmp(np->type, type) = 0))
-			continue;
-		if (of_device_is_compatible(np, compatible) && of_node_get(np))
-			break;
-	}
-	of_node_put(from);
-	read_unlock(&devtree_lock);
-	return np;
-}
-EXPORT_SYMBOL(of_find_compatible_node);
-
-/**
- *	of_find_node_by_path - Find a node matching a full OF path
- *	@path:	The full path to match
- *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.
- */
-struct device_node *of_find_node_by_path(const char *path)
-{
-	struct device_node *np = allnodes;
-
-	read_lock(&devtree_lock);
-	for (; np != 0; np = np->allnext) {
-		if (np->full_name != 0 && strcasecmp(np->full_name, path) = 0
-		    && of_node_get(np))
-			break;
-	}
-	read_unlock(&devtree_lock);
-	return np;
-}
-EXPORT_SYMBOL(of_find_node_by_path);
-
-/**
  *	of_find_node_by_phandle - Find a node given a phandle
  *	@handle:	phandle of the node to find
  *
diff --git a/arch/sparc/kernel/prom.c b/arch/sparc/kernel/prom.c
index 3f8ccfa..012f983 100644
--- a/arch/sparc/kernel/prom.c
+++ b/arch/sparc/kernel/prom.c
@@ -25,23 +25,10 @@
 #include <asm/prom.h>
 #include <asm/oplib.h>
 
-static struct device_node *allnodes;
+extern struct device_node *allnodes;	/* temporary while merging */
 
 extern rwlock_t devtree_lock;	/* temporary while merging */
 
-struct device_node *of_find_node_by_path(const char *path)
-{
-	struct device_node *np = allnodes;
-
-	for (; np != 0; np = np->allnext) {
-		if (np->full_name != 0 && strcmp(np->full_name, path) = 0)
-			break;
-	}
-
-	return np;
-}
-EXPORT_SYMBOL(of_find_node_by_path);
-
 struct device_node *of_find_node_by_phandle(phandle handle)
 {
 	struct device_node *np;
@@ -54,52 +41,6 @@ struct device_node *of_find_node_by_phandle(phandle handle)
 }
 EXPORT_SYMBOL(of_find_node_by_phandle);
 
-struct device_node *of_find_node_by_name(struct device_node *from,
-	const char *name)
-{
-	struct device_node *np;
-
-	np = from ? from->allnext : allnodes;
-	for (; np != NULL; np = np->allnext)
-		if (np->name != NULL && strcmp(np->name, name) = 0)
-			break;
-
-	return np;
-}
-EXPORT_SYMBOL(of_find_node_by_name);
-
-struct device_node *of_find_node_by_type(struct device_node *from,
-	const char *type)
-{
-	struct device_node *np;
-
-	np = from ? from->allnext : allnodes;
-	for (; np != 0; np = np->allnext)
-		if (np->type != 0 && strcmp(np->type, type) = 0)
-			break;
-
-	return np;
-}
-EXPORT_SYMBOL(of_find_node_by_type);
-
-struct device_node *of_find_compatible_node(struct device_node *from,
-	const char *type, const char *compatible)
-{
-	struct device_node *np;
-
-	np = from ? from->allnext : allnodes;
-	for (; np != 0; np = np->allnext) {
-		if (type != NULL
-		    && !(np->type != 0 && strcmp(np->type, type) = 0))
-			continue;
-		if (of_device_is_compatible(np, compatible))
-			break;
-	}
-
-	return np;
-}
-EXPORT_SYMBOL(of_find_compatible_node);
-
 int of_getintprop_default(struct device_node *np, const char *name, int def)
 {
 	struct property *prop;
diff --git a/arch/sparc64/kernel/prom.c b/arch/sparc64/kernel/prom.c
index ee96ef6..2b2017c 100644
--- a/arch/sparc64/kernel/prom.c
+++ b/arch/sparc64/kernel/prom.c
@@ -30,23 +30,10 @@
 #include <asm/upa.h>
 #include <asm/smp.h>
 
-static struct device_node *allnodes;
+extern struct device_node *allnodes;	/* temporary while merging */
 
 extern rwlock_t devtree_lock;	/* temporary while merging */
 
-struct device_node *of_find_node_by_path(const char *path)
-{
-	struct device_node *np = allnodes;
-
-	for (; np != 0; np = np->allnext) {
-		if (np->full_name != 0 && strcmp(np->full_name, path) = 0)
-			break;
-	}
-
-	return np;
-}
-EXPORT_SYMBOL(of_find_node_by_path);
-
 struct device_node *of_find_node_by_phandle(phandle handle)
 {
 	struct device_node *np;
@@ -59,52 +46,6 @@ struct device_node *of_find_node_by_phandle(phandle handle)
 }
 EXPORT_SYMBOL(of_find_node_by_phandle);
 
-struct device_node *of_find_node_by_name(struct device_node *from,
-	const char *name)
-{
-	struct device_node *np;
-
-	np = from ? from->allnext : allnodes;
-	for (; np != NULL; np = np->allnext)
-		if (np->name != NULL && strcmp(np->name, name) = 0)
-			break;
-
-	return np;
-}
-EXPORT_SYMBOL(of_find_node_by_name);
-
-struct device_node *of_find_node_by_type(struct device_node *from,
-	const char *type)
-{
-	struct device_node *np;
-
-	np = from ? from->allnext : allnodes;
-	for (; np != 0; np = np->allnext)
-		if (np->type != 0 && strcmp(np->type, type) = 0)
-			break;
-
-	return np;
-}
-EXPORT_SYMBOL(of_find_node_by_type);
-
-struct device_node *of_find_compatible_node(struct device_node *from,
-	const char *type, const char *compatible)
-{
-	struct device_node *np;
-
-	np = from ? from->allnext : allnodes;
-	for (; np != 0; np = np->allnext) {
-		if (type != NULL
-		    && !(np->type != 0 && strcmp(np->type, type) = 0))
-			continue;
-		if (of_device_is_compatible(np, compatible))
-			break;
-	}
-
-	return np;
-}
-EXPORT_SYMBOL(of_find_compatible_node);
-
 int of_getintprop_default(struct device_node *np, const char *name, int def)
 {
 	struct property *prop;
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 6b6dfcc..9377f3b 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -20,6 +20,8 @@
 #include <linux/of.h>
 #include <linux/spinlock.h>
 
+struct device_node *allnodes;
+
 /* use when traversing tree through the allnext, child, sibling,
  * or parent members of struct device_node.
  */
@@ -158,3 +160,116 @@ struct device_node *of_get_next_child(const struct device_node *node,
 	return next;
 }
 EXPORT_SYMBOL(of_get_next_child);
+
+/**
+ *	of_find_node_by_path - Find a node matching a full OF path
+ *	@path:	The full path to match
+ *
+ *	Returns a node pointer with refcount incremented, use
+ *	of_node_put() on it when done.
+ */
+struct device_node *of_find_node_by_path(const char *path)
+{
+	struct device_node *np = allnodes;
+
+	read_lock(&devtree_lock);
+	for (; np; np = np->allnext) {
+		if (np->full_name && (of_node_cmp(np->full_name, path) = 0)
+		    && of_node_get(np))
+			break;
+	}
+	read_unlock(&devtree_lock);
+	return np;
+}
+EXPORT_SYMBOL(of_find_node_by_path);
+
+/**
+ *	of_find_node_by_name - Find a node by its "name" property
+ *	@from:	The node to start searching from or NULL, the node
+ *		you pass will not be searched, only the next one
+ *		will; typically, you pass what the previous call
+ *		returned. of_node_put() will be called on it
+ *	@name:	The name string to match against
+ *
+ *	Returns a node pointer with refcount incremented, use
+ *	of_node_put() on it when done.
+ */
+struct device_node *of_find_node_by_name(struct device_node *from,
+	const char *name)
+{
+	struct device_node *np;
+
+	read_lock(&devtree_lock);
+	np = from ? from->allnext : allnodes;
+	for (; np; np = np->allnext)
+		if (np->name && (of_node_cmp(np->name, name) = 0)
+		    && of_node_get(np))
+			break;
+	of_node_put(from);
+	read_unlock(&devtree_lock);
+	return np;
+}
+EXPORT_SYMBOL(of_find_node_by_name);
+
+/**
+ *	of_find_node_by_type - Find a node by its "device_type" property
+ *	@from:	The node to start searching from, or NULL to start searching
+ *		the entire device tree. The node you pass will not be
+ *		searched, only the next one will; typically, you pass
+ *		what the previous call returned. of_node_put() will be
+ *		called on from for you.
+ *	@type:	The type string to match against
+ *
+ *	Returns a node pointer with refcount incremented, use
+ *	of_node_put() on it when done.
+ */
+struct device_node *of_find_node_by_type(struct device_node *from,
+	const char *type)
+{
+	struct device_node *np;
+
+	read_lock(&devtree_lock);
+	np = from ? from->allnext : allnodes;
+	for (; np; np = np->allnext)
+		if (np->type && (of_node_cmp(np->type, type) = 0)
+		    && of_node_get(np))
+			break;
+	of_node_put(from);
+	read_unlock(&devtree_lock);
+	return np;
+}
+EXPORT_SYMBOL(of_find_node_by_type);
+
+/**
+ *	of_find_compatible_node - Find a node based on type and one of the
+ *                                tokens in its "compatible" property
+ *	@from:		The node to start searching from or NULL, the node
+ *			you pass will not be searched, only the next one
+ *			will; typically, you pass what the previous call
+ *			returned. of_node_put() will be called on it
+ *	@type:		The type string to match "device_type" or NULL to ignore
+ *	@compatible:	The string to match to one of the tokens in the device
+ *			"compatible" list.
+ *
+ *	Returns a node pointer with refcount incremented, use
+ *	of_node_put() on it when done.
+ */
+struct device_node *of_find_compatible_node(struct device_node *from,
+	const char *type, const char *compatible)
+{
+	struct device_node *np;
+
+	read_lock(&devtree_lock);
+	np = from ? from->allnext : allnodes;
+	for (; np; np = np->allnext) {
+		if (type
+		    && !(np->type && (of_node_cmp(np->type, type) = 0)))
+			continue;
+		if (of_device_is_compatible(np, compatible) && of_node_get(np))
+			break;
+	}
+	of_node_put(from);
+	read_unlock(&devtree_lock);
+	return np;
+}
+EXPORT_SYMBOL(of_find_compatible_node);
diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
index 75b1144..6e391c9 100644
--- a/include/asm-powerpc/prom.h
+++ b/include/asm-powerpc/prom.h
@@ -26,6 +26,7 @@
 
 #define of_compat_cmp(s1, s2, l)	strncasecmp((s1), (s2), (l))
 #define of_prop_cmp(s1, s2)		strcmp((s1), (s2))
+#define of_node_cmp(s1, s2)		strcasecmp((s1), (s2))
 
 /* Definitions used by the flattened device tree */
 #define OF_DT_HEADER		0xd00dfeed	/* marker */
diff --git a/include/asm-sparc/prom.h b/include/asm-sparc/prom.h
index c7d5495..db9feb7 100644
--- a/include/asm-sparc/prom.h
+++ b/include/asm-sparc/prom.h
@@ -25,6 +25,7 @@
 
 #define of_compat_cmp(s1, s2, l)	strncmp((s1), (s2), (l))
 #define of_prop_cmp(s1, s2)		strcasecmp((s1), (s2))
+#define of_node_cmp(s1, s2)		strcmp((s1), (s2))
 
 typedef u32 phandle;
 typedef u32 ihandle;
diff --git a/include/asm-sparc64/prom.h b/include/asm-sparc64/prom.h
index e83896f..2b9e0d7 100644
--- a/include/asm-sparc64/prom.h
+++ b/include/asm-sparc64/prom.h
@@ -25,6 +25,7 @@
 
 #define of_compat_cmp(s1, s2, l)	strncmp((s1), (s2), (l))
 #define of_prop_cmp(s1, s2)		strcasecmp((s1), (s2))
+#define of_node_cmp(s1, s2)		strcmp((s1), (s2))
 
 typedef u32 phandle;
 typedef u32 ihandle;
-- 
1.5.2.3

