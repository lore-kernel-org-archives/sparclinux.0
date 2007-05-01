From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 01 May 2007 07:27:31 +0000
Subject: [PATCH 04/11] Consolidate of_find_property
Message-Id: <20070501172731.33bf45bb.sfr@canb.auug.org.au>
List-Id: <sparclinux.vger.kernel.org>
References: <20070501172250.80707fb8.sfr@canb.auug.org.au>
In-Reply-To: <20070501172250.80707fb8.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>, paulus@samba.org
Cc: sparclinux@vger.kernel.org, ppc-dev <linuxppc-dev@ozlabs.org>

The only change here is that a readlock is taken while the property list
is being traversed on Sparc where it was not taken previously.

Also, Sparc uses strcasecmp to compare property names while PowerPC
uses strcmp.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/prom.c |   24 +-----------------------
 arch/sparc/kernel/prom.c   |   22 +---------------------
 arch/sparc64/kernel/prom.c |   22 +---------------------
 drivers/of/base.c          |   26 ++++++++++++++++++++++++++
 include/asm-powerpc/prom.h |    1 +
 include/asm-sparc/prom.h   |    1 +
 include/asm-sparc64/prom.h |    1 +
 7 files changed, 32 insertions(+), 65 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 723df55..939d5e4 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -79,10 +79,7 @@ struct boot_param_header *initial_boot_params;
 
 static struct device_node *allnodes = NULL;
 
-/* use when traversing tree through the allnext, child, sibling,
- * or parent members of struct device_node.
- */
-static DEFINE_RWLOCK(devtree_lock);
+extern rwlock_t devtree_lock;	/* temporary while merging */
 
 /* export that to outside world */
 struct device_node *of_chosen;
@@ -1454,25 +1451,6 @@ static int __init prom_reconfig_setup(void)
 __initcall(prom_reconfig_setup);
 #endif
 
-struct property *of_find_property(const struct device_node *np,
-				  const char *name,
-				  int *lenp)
-{
-	struct property *pp;
-
-	read_lock(&devtree_lock);
-	for (pp = np->properties; pp != 0; pp = pp->next)
-		if (strcmp(pp->name, name) = 0) {
-			if (lenp != 0)
-				*lenp = pp->length;
-			break;
-		}
-	read_unlock(&devtree_lock);
-
-	return pp;
-}
-EXPORT_SYMBOL(of_find_property);
-
 /*
  * Add a property to a node
  */
diff --git a/arch/sparc/kernel/prom.c b/arch/sparc/kernel/prom.c
index f2ce0d4..0f5aab4 100644
--- a/arch/sparc/kernel/prom.c
+++ b/arch/sparc/kernel/prom.c
@@ -27,10 +27,7 @@
 
 static struct device_node *allnodes;
 
-/* use when traversing tree through the allnext, child, sibling,
- * or parent members of struct device_node.
- */
-static DEFINE_RWLOCK(devtree_lock);
+extern rwlock_t devtree_lock;	/* temporary while merging */
 
 struct device_node *of_get_parent(const struct device_node *node)
 {
@@ -130,23 +127,6 @@ struct device_node *of_find_compatible_node(struct device_node *from,
 }
 EXPORT_SYMBOL(of_find_compatible_node);
 
-struct property *of_find_property(const struct device_node *np,
-				  const char *name,
-				  int *lenp)
-{
-	struct property *pp;
-
-	for (pp = np->properties; pp != 0; pp = pp->next) {
-		if (strcasecmp(pp->name, name) = 0) {
-			if (lenp != 0)
-				*lenp = pp->length;
-			break;
-		}
-	}
-	return pp;
-}
-EXPORT_SYMBOL(of_find_property);
-
 int of_getintprop_default(struct device_node *np, const char *name, int def)
 {
 	struct property *prop;
diff --git a/arch/sparc64/kernel/prom.c b/arch/sparc64/kernel/prom.c
index d6dd972..c759660 100644
--- a/arch/sparc64/kernel/prom.c
+++ b/arch/sparc64/kernel/prom.c
@@ -31,10 +31,7 @@
 
 static struct device_node *allnodes;
 
-/* use when traversing tree through the allnext, child, sibling,
- * or parent members of struct device_node.
- */
-static DEFINE_RWLOCK(devtree_lock);
+extern rwlock_t devtree_lock;	/* temporary while merging */
 
 struct device_node *of_get_parent(const struct device_node *node)
 {
@@ -134,23 +131,6 @@ struct device_node *of_find_compatible_node(struct device_node *from,
 }
 EXPORT_SYMBOL(of_find_compatible_node);
 
-struct property *of_find_property(const struct device_node *np,
-				  const char *name,
-				  int *lenp)
-{
-	struct property *pp;
-
-	for (pp = np->properties; pp != 0; pp = pp->next) {
-		if (strcasecmp(pp->name, name) = 0) {
-			if (lenp != 0)
-				*lenp = pp->length;
-			break;
-		}
-	}
-	return pp;
-}
-EXPORT_SYMBOL(of_find_property);
-
 int of_getintprop_default(struct device_node *np, const char *name, int def)
 {
 	struct property *prop;
diff --git a/drivers/of/base.c b/drivers/of/base.c
index d6dc5e7..70b6084 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -18,6 +18,12 @@
  */
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/spinlock.h>
+
+/* use when traversing tree through the allnext, child, sibling,
+ * or parent members of struct device_node.
+ */
+DEFINE_RWLOCK(devtree_lock);
 
 int of_n_addr_cells(struct device_node *np)
 {
@@ -51,6 +57,26 @@ int of_n_size_cells(struct device_node *np)
 }
 EXPORT_SYMBOL(of_n_size_cells);
 
+struct property *of_find_property(const struct device_node *np,
+				  const char *name,
+				  int *lenp)
+{
+	struct property *pp;
+
+	read_lock(&devtree_lock);
+	for (pp = np->properties; pp != 0; pp = pp->next) {
+		if (of_prop_cmp(pp->name, name) = 0) {
+			if (lenp != 0)
+				*lenp = pp->length;
+			break;
+		}
+	}
+	read_unlock(&devtree_lock);
+
+	return pp;
+}
+EXPORT_SYMBOL(of_find_property);
+
 /*
  * Find a property with a given name for a given node
  * and return the value.
diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
index 1417dce..f15c760 100644
--- a/include/asm-powerpc/prom.h
+++ b/include/asm-powerpc/prom.h
@@ -26,6 +26,7 @@
 #define OF_ROOT_NODE_SIZE_CELLS_DEFAULT	1
 
 #define of_compat_cmp(s1, s2, l)	strncasecmp((s1), (s2), (l))
+#define of_prop_cmp(s1, s2)		strcmp((s1), (s2))
 
 /* Definitions used by the flattened device tree */
 #define OF_DT_HEADER		0xd00dfeed	/* marker */
diff --git a/include/asm-sparc/prom.h b/include/asm-sparc/prom.h
index f314ec6..22abc2a 100644
--- a/include/asm-sparc/prom.h
+++ b/include/asm-sparc/prom.h
@@ -24,6 +24,7 @@
 #define OF_ROOT_NODE_SIZE_CELLS_DEFAULT	1
 
 #define of_compat_cmp(s1, s2, l)	strncmp((s1), (s2), (l))
+#define of_prop_cmp(s1, s2)		strcasecmp((s1), (s2))
 
 typedef u32 phandle;
 typedef u32 ihandle;
diff --git a/include/asm-sparc64/prom.h b/include/asm-sparc64/prom.h
index 06edb32..f88c412 100644
--- a/include/asm-sparc64/prom.h
+++ b/include/asm-sparc64/prom.h
@@ -24,6 +24,7 @@
 #define OF_ROOT_NODE_SIZE_CELLS_DEFAULT	1
 
 #define of_compat_cmp(s1, s2, l)	strncmp((s1), (s2), (l))
+#define of_prop_cmp(s1, s2)		strcasecmp((s1), (s2))
 
 typedef u32 phandle;
 typedef u32 ihandle;
-- 
1.5.1.2

