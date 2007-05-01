From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 01 May 2007 07:25:37 +0000
Subject: [PATCH 02/11] Start split out of common open firmware code
Message-Id: <20070501172537.3bea0c1a.sfr@canb.auug.org.au>
List-Id: <sparclinux.vger.kernel.org>
References: <20070501172250.80707fb8.sfr@canb.auug.org.au>
In-Reply-To: <20070501172250.80707fb8.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>, paulus@samba.org
Cc: sparclinux@vger.kernel.org, ppc-dev <linuxppc-dev@ozlabs.org>

This creates drivers/of/base.c (depending on CONFIG_OF) and puts
the first trivially common bits from the prom.c files into it.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/Kconfig       |    3 ++
 arch/powerpc/kernel/prom.c |   42 ----------------------------
 arch/sparc/Kconfig         |    3 ++
 arch/sparc/kernel/prom.c   |   42 ----------------------------
 arch/sparc64/Kconfig       |    3 ++
 arch/sparc64/kernel/prom.c |   42 ----------------------------
 drivers/Makefile           |    1 +
 drivers/of/Makefile        |    1 +
 drivers/of/base.c          |   65 ++++++++++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/prom.h |    3 ++
 include/asm-sparc/prom.h   |    3 ++
 include/asm-sparc64/prom.h |    3 ++
 12 files changed, 85 insertions(+), 126 deletions(-)
 create mode 100644 drivers/of/Makefile
 create mode 100644 drivers/of/base.c

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a54a9a2..1a78c01 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -99,6 +99,9 @@ config ARCH_MAY_HAVE_PC_FDC
 config PPC_OF
 	def_bool y
 
+config OF
+	def_bool y
+
 config PPC_UDBG_16550
 	bool
 	default n
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index caef555..d701e89 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -1042,36 +1042,6 @@ void __init early_init_devtree(void *params)
 
 #undef printk
 
-int of_n_addr_cells(struct device_node* np)
-{
-	const int *ip;
-	do {
-		if (np->parent)
-			np = np->parent;
-		ip = of_get_property(np, "#address-cells", NULL);
-		if (ip != NULL)
-			return *ip;
-	} while (np->parent);
-	/* No #address-cells property for the root node, default to 1 */
-	return 1;
-}
-EXPORT_SYMBOL(of_n_addr_cells);
-
-int of_n_size_cells(struct device_node* np)
-{
-	const int* ip;
-	do {
-		if (np->parent)
-			np = np->parent;
-		ip = of_get_property(np, "#size-cells", NULL);
-		if (ip != NULL)
-			return *ip;
-	} while (np->parent);
-	/* No #size-cells property for the root node, default to 1 */
-	return 1;
-}
-EXPORT_SYMBOL(of_n_size_cells);
-
 /** Checks if the given "compat" string matches one of the strings in
  * the device's "compatible" property
  */
@@ -1529,18 +1499,6 @@ struct property *of_find_property(const struct device_node *np,
 EXPORT_SYMBOL(of_find_property);
 
 /*
- * Find a property with a given name for a given node
- * and return the value.
- */
-const void *of_get_property(const struct device_node *np, const char *name,
-			 int *lenp)
-{
-	struct property *pp = of_find_property(np,name,lenp);
-	return pp ? pp->value : NULL;
-}
-EXPORT_SYMBOL(of_get_property);
-
-/*
  * Add a property to a node
  */
 int prom_add_property(struct device_node* np, struct property* prop)
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index bd992c0..23bcc7e 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -21,6 +21,9 @@ config GENERIC_ISA_DMA
 	bool
 	default y
 
+config OF
+	def_bool y
+
 source "init/Kconfig"
 
 menu "General machine setup"
diff --git a/arch/sparc/kernel/prom.c b/arch/sparc/kernel/prom.c
index eed140b..ac3f3c2 100644
--- a/arch/sparc/kernel/prom.c
+++ b/arch/sparc/kernel/prom.c
@@ -168,18 +168,6 @@ struct property *of_find_property(const struct device_node *np,
 }
 EXPORT_SYMBOL(of_find_property);
 
-/*
- * Find a property with a given name for a given node
- * and return the value.
- */
-const void *of_get_property(const struct device_node *np, const char *name,
-			    int *lenp)
-{
-	struct property *pp = of_find_property(np,name,lenp);
-	return pp ? pp->value : NULL;
-}
-EXPORT_SYMBOL(of_get_property);
-
 int of_getintprop_default(struct device_node *np, const char *name, int def)
 {
 	struct property *prop;
@@ -193,36 +181,6 @@ int of_getintprop_default(struct device_node *np, const char *name, int def)
 }
 EXPORT_SYMBOL(of_getintprop_default);
 
-int of_n_addr_cells(struct device_node *np)
-{
-	const int* ip;
-	do {
-		if (np->parent)
-			np = np->parent;
-		ip = of_get_property(np, "#address-cells", NULL);
-		if (ip != NULL)
-			return *ip;
-	} while (np->parent);
-	/* No #address-cells property for the root node, default to 2 */
-	return 2;
-}
-EXPORT_SYMBOL(of_n_addr_cells);
-
-int of_n_size_cells(struct device_node *np)
-{
-	const int* ip;
-	do {
-		if (np->parent)
-			np = np->parent;
-		ip = of_get_property(np, "#size-cells", NULL);
-		if (ip != NULL)
-			return *ip;
-	} while (np->parent);
-	/* No #size-cells property for the root node, default to 1 */
-	return 1;
-}
-EXPORT_SYMBOL(of_n_size_cells);
-
 int of_set_property(struct device_node *dp, const char *name, void *val, int len)
 {
 	struct property **prevp;
diff --git a/arch/sparc64/Kconfig b/arch/sparc64/Kconfig
index 590a41b..45a7bec 100644
--- a/arch/sparc64/Kconfig
+++ b/arch/sparc64/Kconfig
@@ -58,6 +58,9 @@ config AUDIT_ARCH
 	bool
 	default y
 
+config OF
+	def_bool y
+
 choice
 	prompt "Kernel page size"
 	default SPARC64_PAGE_SIZE_8KB
diff --git a/arch/sparc64/kernel/prom.c b/arch/sparc64/kernel/prom.c
index 5e1fcd0..7ef5488 100644
--- a/arch/sparc64/kernel/prom.c
+++ b/arch/sparc64/kernel/prom.c
@@ -172,18 +172,6 @@ struct property *of_find_property(const struct device_node *np,
 }
 EXPORT_SYMBOL(of_find_property);
 
-/*
- * Find a property with a given name for a given node
- * and return the value.
- */
-const void *of_get_property(const struct device_node *np, const char *name,
-		      int *lenp)
-{
-	struct property *pp = of_find_property(np,name,lenp);
-	return pp ? pp->value : NULL;
-}
-EXPORT_SYMBOL(of_get_property);
-
 int of_getintprop_default(struct device_node *np, const char *name, int def)
 {
 	struct property *prop;
@@ -197,36 +185,6 @@ int of_getintprop_default(struct device_node *np, const char *name, int def)
 }
 EXPORT_SYMBOL(of_getintprop_default);
 
-int of_n_addr_cells(struct device_node *np)
-{
-	const int* ip;
-	do {
-		if (np->parent)
-			np = np->parent;
-		ip = of_get_property(np, "#address-cells", NULL);
-		if (ip != NULL)
-			return *ip;
-	} while (np->parent);
-	/* No #address-cells property for the root node, default to 2 */
-	return 2;
-}
-EXPORT_SYMBOL(of_n_addr_cells);
-
-int of_n_size_cells(struct device_node *np)
-{
-	const int* ip;
-	do {
-		if (np->parent)
-			np = np->parent;
-		ip = of_get_property(np, "#size-cells", NULL);
-		if (ip != NULL)
-			return *ip;
-	} while (np->parent);
-	/* No #size-cells property for the root node, default to 1 */
-	return 1;
-}
-EXPORT_SYMBOL(of_n_size_cells);
-
 int of_set_property(struct device_node *dp, const char *name, void *val, int len)
 {
 	struct property **prevp;
diff --git a/drivers/Makefile b/drivers/Makefile
index 920c975..2065b99 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -80,3 +80,4 @@ obj-$(CONFIG_GENERIC_TIME)	+= clocksource/
 obj-$(CONFIG_DMA_ENGINE)	+= dma/
 obj-$(CONFIG_HID)		+= hid/
 obj-$(CONFIG_PPC_PS3)		+= ps3/
+obj-$(CONFIG_OF)		+= of/
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
new file mode 100644
index 0000000..cddbe84
--- /dev/null
+++ b/drivers/of/Makefile
@@ -0,0 +1 @@
+obj-y = base.o
diff --git a/drivers/of/base.c b/drivers/of/base.c
new file mode 100644
index 0000000..723d80d
--- /dev/null
+++ b/drivers/of/base.c
@@ -0,0 +1,65 @@
+/*
+ * Procedures for creating, accessing and interpreting the device tree.
+ *
+ * Paul Mackerras	August 1996.
+ * Copyright (C) 1996-2005 Paul Mackerras.
+ *
+ *  Adapted for 64bit PowerPC by Dave Engebretsen and Peter Bergner.
+ *    {engebret|bergner}@us.ibm.com
+ *
+ *  Adapted for sparc and sparc64 by David S. Miller davem@davemloft.net
+ *
+ *  Reconsolidated from arch/x/kernel/prom.c by Stephen Rothwell.
+ *
+ *      This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ */
+#include <linux/module.h>
+#include <linux/of.h>
+
+int of_n_addr_cells(struct device_node *np)
+{
+	const int *ip;
+
+	do {
+		if (np->parent)
+			np = np->parent;
+		ip = of_get_property(np, "#address-cells", NULL);
+		if (ip)
+			return *ip;
+	} while (np->parent);
+	/* No #address-cells property for the root node */
+	return OF_ROOT_NODE_ADDR_CELLS_DEFAULT;
+}
+EXPORT_SYMBOL(of_n_addr_cells);
+
+int of_n_size_cells(struct device_node *np)
+{
+	const int *ip;
+
+	do {
+		if (np->parent)
+			np = np->parent;
+		ip = of_get_property(np, "#size-cells", NULL);
+		if (ip)
+			return *ip;
+	} while (np->parent);
+	/* No #size-cells property for the root node */
+	return OF_ROOT_NODE_SIZE_CELLS_DEFAULT;
+}
+EXPORT_SYMBOL(of_n_size_cells);
+
+/*
+ * Find a property with a given name for a given node
+ * and return the value.
+ */
+const void *of_get_property(const struct device_node *np, const char *name,
+			 int *lenp)
+{
+	struct property *pp = of_find_property(np, name, lenp);
+
+	return pp ? pp->value : NULL;
+}
+EXPORT_SYMBOL(of_get_property);
diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
index 7c77ef1..4c28c2c 100644
--- a/include/asm-powerpc/prom.h
+++ b/include/asm-powerpc/prom.h
@@ -22,6 +22,9 @@
 #include <asm/atomic.h>
 #include <asm/io.h>
 
+#define OF_ROOT_NODE_ADDR_CELLS_DEFAULT	1
+#define OF_ROOT_NODE_SIZE_CELLS_DEFAULT	1
+
 /* Definitions used by the flattened device tree */
 #define OF_DT_HEADER		0xd00dfeed	/* marker */
 #define OF_DT_BEGIN_NODE	0x1		/* Start of node, full name */
diff --git a/include/asm-sparc/prom.h b/include/asm-sparc/prom.h
index 1e0e9da..b307471 100644
--- a/include/asm-sparc/prom.h
+++ b/include/asm-sparc/prom.h
@@ -20,6 +20,9 @@
 #include <linux/proc_fs.h>
 #include <asm/atomic.h>
 
+#define OF_ROOT_NODE_ADDR_CELLS_DEFAULT	2
+#define OF_ROOT_NODE_SIZE_CELLS_DEFAULT	1
+
 typedef u32 phandle;
 typedef u32 ihandle;
 
diff --git a/include/asm-sparc64/prom.h b/include/asm-sparc64/prom.h
index 288d78d..12bb084 100644
--- a/include/asm-sparc64/prom.h
+++ b/include/asm-sparc64/prom.h
@@ -20,6 +20,9 @@
 #include <linux/proc_fs.h>
 #include <asm/atomic.h>
 
+#define OF_ROOT_NODE_ADDR_CELLS_DEFAULT	2
+#define OF_ROOT_NODE_SIZE_CELLS_DEFAULT	1
+
 typedef u32 phandle;
 typedef u32 ihandle;
 
-- 
1.5.1.2

