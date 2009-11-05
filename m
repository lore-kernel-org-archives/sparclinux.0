From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 05 Nov 2009 07:47:05 +0000
Subject: [PATCH 09/11] of: merge prom_{add,remove,modify}_property
Message-Id: <20091105074656.10460.29333.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
References: <20091105073728.10460.6061.stgit@angua>
In-Reply-To: <20091105073728.10460.6061.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, benh@kernel.crashing.org, sfr@canb.auug.org.au, davem@davemloft.net, sparclinux@vger.kernel.org, monstr@monstr.eu

Merge common code between PowerPC and MicroBlaze

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/microblaze/kernel/prom.c |  113 ----------------------------------------
 arch/powerpc/kernel/prom.c    |  114 ----------------------------------------
 drivers/of/base.c             |  116 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 116 insertions(+), 227 deletions(-)

diff --git a/arch/microblaze/kernel/prom.c b/arch/microblaze/kernel/prom.c
index 901d538..a38e373 100644
--- a/arch/microblaze/kernel/prom.c
+++ b/arch/microblaze/kernel/prom.c
@@ -606,119 +606,6 @@ out_unlock:
 	write_unlock_irqrestore(&devtree_lock, flags);
 }
 
-/*
- * Add a property to a node
- */
-int prom_add_property(struct device_node *np, struct property *prop)
-{
-	struct property **next;
-	unsigned long flags;
-
-	prop->next = NULL;
-	write_lock_irqsave(&devtree_lock, flags);
-	next = &np->properties;
-	while (*next) {
-		if (strcmp(prop->name, (*next)->name) = 0) {
-			/* duplicate ! don't insert it */
-			write_unlock_irqrestore(&devtree_lock, flags);
-			return -1;
-		}
-		next = &(*next)->next;
-	}
-	*next = prop;
-	write_unlock_irqrestore(&devtree_lock, flags);
-
-#ifdef CONFIG_PROC_DEVICETREE
-	/* try to add to proc as well if it was initialized */
-	if (np->pde)
-		proc_device_tree_add_prop(np->pde, prop);
-#endif /* CONFIG_PROC_DEVICETREE */
-
-	return 0;
-}
-
-/*
- * Remove a property from a node.  Note that we don't actually
- * remove it, since we have given out who-knows-how-many pointers
- * to the data using get-property.  Instead we just move the property
- * to the "dead properties" list, so it won't be found any more.
- */
-int prom_remove_property(struct device_node *np, struct property *prop)
-{
-	struct property **next;
-	unsigned long flags;
-	int found = 0;
-
-	write_lock_irqsave(&devtree_lock, flags);
-	next = &np->properties;
-	while (*next) {
-		if (*next = prop) {
-			/* found the node */
-			*next = prop->next;
-			prop->next = np->deadprops;
-			np->deadprops = prop;
-			found = 1;
-			break;
-		}
-		next = &(*next)->next;
-	}
-	write_unlock_irqrestore(&devtree_lock, flags);
-
-	if (!found)
-		return -ENODEV;
-
-#ifdef CONFIG_PROC_DEVICETREE
-	/* try to remove the proc node as well */
-	if (np->pde)
-		proc_device_tree_remove_prop(np->pde, prop);
-#endif /* CONFIG_PROC_DEVICETREE */
-
-	return 0;
-}
-
-/*
- * Update a property in a node.  Note that we don't actually
- * remove it, since we have given out who-knows-how-many pointers
- * to the data using get-property.  Instead we just move the property
- * to the "dead properties" list, and add the new property to the
- * property list
- */
-int prom_update_property(struct device_node *np,
-			 struct property *newprop,
-			 struct property *oldprop)
-{
-	struct property **next;
-	unsigned long flags;
-	int found = 0;
-
-	write_lock_irqsave(&devtree_lock, flags);
-	next = &np->properties;
-	while (*next) {
-		if (*next = oldprop) {
-			/* found the node */
-			newprop->next = oldprop->next;
-			*next = newprop;
-			oldprop->next = np->deadprops;
-			np->deadprops = oldprop;
-			found = 1;
-			break;
-		}
-		next = &(*next)->next;
-	}
-	write_unlock_irqrestore(&devtree_lock, flags);
-
-	if (!found)
-		return -ENODEV;
-
-#ifdef CONFIG_PROC_DEVICETREE
-	/* try to add to proc as well if it was initialized */
-	if (np->pde)
-		proc_device_tree_update_prop(np->pde, newprop, oldprop);
-#endif /* CONFIG_PROC_DEVICETREE */
-
-	return 0;
-}
-
 #if defined(CONFIG_DEBUG_FS) && defined(DEBUG)
 static struct debugfs_blob_wrapper flat_dt_blob;
 
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 1280f34..7f88566 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -1130,120 +1130,6 @@ static int __init prom_reconfig_setup(void)
 __initcall(prom_reconfig_setup);
 #endif
 
-/*
- * Add a property to a node
- */
-int prom_add_property(struct device_node* np, struct property* prop)
-{
-	struct property **next;
-	unsigned long flags;
-
-	prop->next = NULL;	
-	write_lock_irqsave(&devtree_lock, flags);
-	next = &np->properties;
-	while (*next) {
-		if (strcmp(prop->name, (*next)->name) = 0) {
-			/* duplicate ! don't insert it */
-			write_unlock_irqrestore(&devtree_lock, flags);
-			return -1;
-		}
-		next = &(*next)->next;
-	}
-	*next = prop;
-	write_unlock_irqrestore(&devtree_lock, flags);
-
-#ifdef CONFIG_PROC_DEVICETREE
-	/* try to add to proc as well if it was initialized */
-	if (np->pde)
-		proc_device_tree_add_prop(np->pde, prop);
-#endif /* CONFIG_PROC_DEVICETREE */
-
-	return 0;
-}
-
-/*
- * Remove a property from a node.  Note that we don't actually
- * remove it, since we have given out who-knows-how-many pointers
- * to the data using get-property.  Instead we just move the property
- * to the "dead properties" list, so it won't be found any more.
- */
-int prom_remove_property(struct device_node *np, struct property *prop)
-{
-	struct property **next;
-	unsigned long flags;
-	int found = 0;
-
-	write_lock_irqsave(&devtree_lock, flags);
-	next = &np->properties;
-	while (*next) {
-		if (*next = prop) {
-			/* found the node */
-			*next = prop->next;
-			prop->next = np->deadprops;
-			np->deadprops = prop;
-			found = 1;
-			break;
-		}
-		next = &(*next)->next;
-	}
-	write_unlock_irqrestore(&devtree_lock, flags);
-
-	if (!found)
-		return -ENODEV;
-
-#ifdef CONFIG_PROC_DEVICETREE
-	/* try to remove the proc node as well */
-	if (np->pde)
-		proc_device_tree_remove_prop(np->pde, prop);
-#endif /* CONFIG_PROC_DEVICETREE */
-
-	return 0;
-}
-
-/*
- * Update a property in a node.  Note that we don't actually
- * remove it, since we have given out who-knows-how-many pointers
- * to the data using get-property.  Instead we just move the property
- * to the "dead properties" list, and add the new property to the
- * property list
- */
-int prom_update_property(struct device_node *np,
-			 struct property *newprop,
-			 struct property *oldprop)
-{
-	struct property **next;
-	unsigned long flags;
-	int found = 0;
-
-	write_lock_irqsave(&devtree_lock, flags);
-	next = &np->properties;
-	while (*next) {
-		if (*next = oldprop) {
-			/* found the node */
-			newprop->next = oldprop->next;
-			*next = newprop;
-			oldprop->next = np->deadprops;
-			np->deadprops = oldprop;
-			found = 1;
-			break;
-		}
-		next = &(*next)->next;
-	}
-	write_unlock_irqrestore(&devtree_lock, flags);
-
-	if (!found)
-		return -ENODEV;
-
-#ifdef CONFIG_PROC_DEVICETREE
-	/* try to add to proc as well if it was initialized */
-	if (np->pde)
-		proc_device_tree_update_prop(np->pde, newprop, oldprop);
-#endif /* CONFIG_PROC_DEVICETREE */
-
-	return 0;
-}
-
-
 /* Find the device node for a given logical cpu number, also returns the cpu
  * local thread number (index in ibm,interrupt-server#s) if relevant and
  * asked for (non NULL)
diff --git a/drivers/of/base.c b/drivers/of/base.c
index e6627b2..ec56739 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -658,3 +658,119 @@ err0:
 	return ret;
 }
 EXPORT_SYMBOL(of_parse_phandles_with_args);
+
+/**
+ * prom_add_property - Add a property to a node
+ */
+int prom_add_property(struct device_node *np, struct property *prop)
+{
+	struct property **next;
+	unsigned long flags;
+
+	prop->next = NULL;
+	write_lock_irqsave(&devtree_lock, flags);
+	next = &np->properties;
+	while (*next) {
+		if (strcmp(prop->name, (*next)->name) = 0) {
+			/* duplicate ! don't insert it */
+			write_unlock_irqrestore(&devtree_lock, flags);
+			return -1;
+		}
+		next = &(*next)->next;
+	}
+	*next = prop;
+	write_unlock_irqrestore(&devtree_lock, flags);
+
+#ifdef CONFIG_PROC_DEVICETREE
+	/* try to add to proc as well if it was initialized */
+	if (np->pde)
+		proc_device_tree_add_prop(np->pde, prop);
+#endif /* CONFIG_PROC_DEVICETREE */
+
+	return 0;
+}
+
+/**
+ * prom_remove_property - Remove a property from a node.
+ *
+ * Note that we don't actually remove it, since we have given out
+ * who-knows-how-many pointers to the data using get-property.
+ * Instead we just move the property to the "dead properties"
+ * list, so it won't be found any more.
+ */
+int prom_remove_property(struct device_node *np, struct property *prop)
+{
+	struct property **next;
+	unsigned long flags;
+	int found = 0;
+
+	write_lock_irqsave(&devtree_lock, flags);
+	next = &np->properties;
+	while (*next) {
+		if (*next = prop) {
+			/* found the node */
+			*next = prop->next;
+			prop->next = np->deadprops;
+			np->deadprops = prop;
+			found = 1;
+			break;
+		}
+		next = &(*next)->next;
+	}
+	write_unlock_irqrestore(&devtree_lock, flags);
+
+	if (!found)
+		return -ENODEV;
+
+#ifdef CONFIG_PROC_DEVICETREE
+	/* try to remove the proc node as well */
+	if (np->pde)
+		proc_device_tree_remove_prop(np->pde, prop);
+#endif /* CONFIG_PROC_DEVICETREE */
+
+	return 0;
+}
+
+/*
+ * prom_update_property - Update a property in a node.
+ *
+ * Note that we don't actually remove it, since we have given out
+ * who-knows-how-many pointers to the data using get-property.
+ * Instead we just move the property to the "dead properties" list,
+ * and add the new property to the property list
+ */
+int prom_update_property(struct device_node *np,
+			 struct property *newprop,
+			 struct property *oldprop)
+{
+	struct property **next;
+	unsigned long flags;
+	int found = 0;
+
+	write_lock_irqsave(&devtree_lock, flags);
+	next = &np->properties;
+	while (*next) {
+		if (*next = oldprop) {
+			/* found the node */
+			newprop->next = oldprop->next;
+			*next = newprop;
+			oldprop->next = np->deadprops;
+			np->deadprops = oldprop;
+			found = 1;
+			break;
+		}
+		next = &(*next)->next;
+	}
+	write_unlock_irqrestore(&devtree_lock, flags);
+
+	if (!found)
+		return -ENODEV;
+
+#ifdef CONFIG_PROC_DEVICETREE
+	/* try to add to proc as well if it was initialized */
+	if (np->pde)
+		proc_device_tree_update_prop(np->pde, newprop, oldprop);
+#endif /* CONFIG_PROC_DEVICETREE */
+
+	return 0;
+}

