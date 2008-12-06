From: David Miller <davem@davemloft.net>
Date: Sat, 06 Dec 2008 03:05:06 +0000
Subject: [PATCH 3/14]: sparc: Create common area for OF device layer code.
Message-Id: <20081205.190506.38087266.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc: Create common area for OF device layer code.

This is where common code implementations will go as we unify
32-bit and 64-bit OF device tree code.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/Makefile      |    1 +
 arch/sparc/kernel/prom_32.c     |   94 ------------------------------
 arch/sparc/kernel/prom_64.c     |   94 ------------------------------
 arch/sparc/kernel/prom_common.c |  121 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 122 insertions(+), 188 deletions(-)
 create mode 100644 arch/sparc/kernel/prom_common.c

diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index cd13d7f..d0d63b1 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -35,6 +35,7 @@ obj-y                   += ptrace_$(BITS).o
 obj-y                   += unaligned_$(BITS).o
 obj-y                   += una_asm_$(BITS).o
 obj-$(CONFIG_SPARC32)   += muldiv.o
+obj-y                   += prom_common.o
 obj-y                   += prom_$(BITS).o
 obj-y                   += of_device_$(BITS).o
 
diff --git a/arch/sparc/kernel/prom_32.c b/arch/sparc/kernel/prom_32.c
index 715455b..e41df66 100644
--- a/arch/sparc/kernel/prom_32.c
+++ b/arch/sparc/kernel/prom_32.c
@@ -27,100 +27,6 @@
 
 #include "prom.h"
 
-struct device_node *of_find_node_by_phandle(phandle handle)
-{
-	struct device_node *np;
-
-	for (np = allnodes; np != 0; np = np->allnext)
-		if (np->node = handle)
-			break;
-
-	return np;
-}
-EXPORT_SYMBOL(of_find_node_by_phandle);
-
-int of_getintprop_default(struct device_node *np, const char *name, int def)
-{
-	struct property *prop;
-	int len;
-
-	prop = of_find_property(np, name, &len);
-	if (!prop || len != 4)
-		return def;
-
-	return *(int *) prop->value;
-}
-EXPORT_SYMBOL(of_getintprop_default);
-
-DEFINE_MUTEX(of_set_property_mutex);
-EXPORT_SYMBOL(of_set_property_mutex);
-
-int of_set_property(struct device_node *dp, const char *name, void *val, int len)
-{
-	struct property **prevp;
-	void *new_val;
-	int err;
-
-	new_val = kmalloc(len, GFP_KERNEL);
-	if (!new_val)
-		return -ENOMEM;
-
-	memcpy(new_val, val, len);
-
-	err = -ENODEV;
-
-	write_lock(&devtree_lock);
-	prevp = &dp->properties;
-	while (*prevp) {
-		struct property *prop = *prevp;
-
-		if (!strcasecmp(prop->name, name)) {
-			void *old_val = prop->value;
-			int ret;
-
-			mutex_lock(&of_set_property_mutex);
-			ret = prom_setprop(dp->node, (char *) name, val, len);
-			mutex_unlock(&of_set_property_mutex);
-
-			err = -EINVAL;
-			if (ret >= 0) {
-				prop->value = new_val;
-				prop->length = len;
-
-				if (OF_IS_DYNAMIC(prop))
-					kfree(old_val);
-
-				OF_MARK_DYNAMIC(prop);
-
-				err = 0;
-			}
-			break;
-		}
-		prevp = &(*prevp)->next;
-	}
-	write_unlock(&devtree_lock);
-
-	/* XXX Upate procfs if necessary... */
-
-	return err;
-}
-EXPORT_SYMBOL(of_set_property);
-
-int of_find_in_proplist(const char *list, const char *match, int len)
-{
-	while (len > 0) {
-		int l;
-
-		if (!strcmp(list, match))
-			return 1;
-		l = strlen(list) + 1;
-		list += l;
-		len -= l;
-	}
-	return 0;
-}
-EXPORT_SYMBOL(of_find_in_proplist);
-
 static unsigned int prom_early_allocated;
 
 static void * __init prom_early_alloc(unsigned long size)
diff --git a/arch/sparc/kernel/prom_64.c b/arch/sparc/kernel/prom_64.c
index 651448d..1f5666a 100644
--- a/arch/sparc/kernel/prom_64.c
+++ b/arch/sparc/kernel/prom_64.c
@@ -32,100 +32,6 @@
 
 #include "prom.h"
 
-struct device_node *of_find_node_by_phandle(phandle handle)
-{
-	struct device_node *np;
-
-	for (np = allnodes; np; np = np->allnext)
-		if (np->node = handle)
-			break;
-
-	return np;
-}
-EXPORT_SYMBOL(of_find_node_by_phandle);
-
-int of_getintprop_default(struct device_node *np, const char *name, int def)
-{
-	struct property *prop;
-	int len;
-
-	prop = of_find_property(np, name, &len);
-	if (!prop || len != 4)
-		return def;
-
-	return *(int *) prop->value;
-}
-EXPORT_SYMBOL(of_getintprop_default);
-
-DEFINE_MUTEX(of_set_property_mutex);
-EXPORT_SYMBOL(of_set_property_mutex);
-
-int of_set_property(struct device_node *dp, const char *name, void *val, int len)
-{
-	struct property **prevp;
-	void *new_val;
-	int err;
-
-	new_val = kmalloc(len, GFP_KERNEL);
-	if (!new_val)
-		return -ENOMEM;
-
-	memcpy(new_val, val, len);
-
-	err = -ENODEV;
-
-	write_lock(&devtree_lock);
-	prevp = &dp->properties;
-	while (*prevp) {
-		struct property *prop = *prevp;
-
-		if (!strcasecmp(prop->name, name)) {
-			void *old_val = prop->value;
-			int ret;
-
-			mutex_lock(&of_set_property_mutex);
-			ret = prom_setprop(dp->node, name, val, len);
-			mutex_unlock(&of_set_property_mutex);
-
-			err = -EINVAL;
-			if (ret >= 0) {
-				prop->value = new_val;
-				prop->length = len;
-
-				if (OF_IS_DYNAMIC(prop))
-					kfree(old_val);
-
-				OF_MARK_DYNAMIC(prop);
-
-				err = 0;
-			}
-			break;
-		}
-		prevp = &(*prevp)->next;
-	}
-	write_unlock(&devtree_lock);
-
-	/* XXX Upate procfs if necessary... */
-
-	return err;
-}
-EXPORT_SYMBOL(of_set_property);
-
-int of_find_in_proplist(const char *list, const char *match, int len)
-{
-	while (len > 0) {
-		int l;
-
-		if (!strcmp(list, match))
-			return 1;
-		l = strlen(list) + 1;
-		list += l;
-		len -= l;
-	}
-	return 0;
-}
-EXPORT_SYMBOL(of_find_in_proplist);
-
 static unsigned int prom_early_allocated __initdata;
 
 static void * __init prom_early_alloc(unsigned long size)
diff --git a/arch/sparc/kernel/prom_common.c b/arch/sparc/kernel/prom_common.c
new file mode 100644
index 0000000..ded8c62
--- /dev/null
+++ b/arch/sparc/kernel/prom_common.c
@@ -0,0 +1,121 @@
+/* prom_common.c: OF device tree support common code.
+ *
+ * Paul Mackerras	August 1996.
+ * Copyright (C) 1996-2005 Paul Mackerras.
+ *
+ *  Adapted for 64bit PowerPC by Dave Engebretsen and Peter Bergner.
+ *    {engebret|bergner}@us.ibm.com
+ *
+ *  Adapted for sparc by David S. Miller davem@davemloft.net
+ *
+ *      This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <asm/prom.h>
+#include <asm/oplib.h>
+
+#include "prom.h"
+
+struct device_node *of_find_node_by_phandle(phandle handle)
+{
+	struct device_node *np;
+
+	for (np = allnodes; np; np = np->allnext)
+		if (np->node = handle)
+			break;
+
+	return np;
+}
+EXPORT_SYMBOL(of_find_node_by_phandle);
+
+int of_getintprop_default(struct device_node *np, const char *name, int def)
+{
+	struct property *prop;
+	int len;
+
+	prop = of_find_property(np, name, &len);
+	if (!prop || len != 4)
+		return def;
+
+	return *(int *) prop->value;
+}
+EXPORT_SYMBOL(of_getintprop_default);
+
+DEFINE_MUTEX(of_set_property_mutex);
+EXPORT_SYMBOL(of_set_property_mutex);
+
+int of_set_property(struct device_node *dp, const char *name, void *val, int len)
+{
+	struct property **prevp;
+	void *new_val;
+	int err;
+
+	new_val = kmalloc(len, GFP_KERNEL);
+	if (!new_val)
+		return -ENOMEM;
+
+	memcpy(new_val, val, len);
+
+	err = -ENODEV;
+
+	write_lock(&devtree_lock);
+	prevp = &dp->properties;
+	while (*prevp) {
+		struct property *prop = *prevp;
+
+		if (!strcasecmp(prop->name, name)) {
+			void *old_val = prop->value;
+			int ret;
+
+			mutex_lock(&of_set_property_mutex);
+			ret = prom_setprop(dp->node, name, val, len);
+			mutex_unlock(&of_set_property_mutex);
+
+			err = -EINVAL;
+			if (ret >= 0) {
+				prop->value = new_val;
+				prop->length = len;
+
+				if (OF_IS_DYNAMIC(prop))
+					kfree(old_val);
+
+				OF_MARK_DYNAMIC(prop);
+
+				err = 0;
+			}
+			break;
+		}
+		prevp = &(*prevp)->next;
+	}
+	write_unlock(&devtree_lock);
+
+	/* XXX Upate procfs if necessary... */
+
+	return err;
+}
+EXPORT_SYMBOL(of_set_property);
+
+int of_find_in_proplist(const char *list, const char *match, int len)
+{
+	while (len > 0) {
+		int l;
+
+		if (!strcmp(list, match))
+			return 1;
+		l = strlen(list) + 1;
+		list += l;
+		len -= l;
+	}
+	return 0;
+}
+EXPORT_SYMBOL(of_find_in_proplist);
+
-- 
1.5.6.5

