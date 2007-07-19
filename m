From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 19 Jul 2007 15:19:25 +0000
Subject: [PATCH 11/12] Create linux/of_platorm.h
Message-Id: <20070720011925.f51f998a.sfr@canb.auug.org.au>
List-Id: <sparclinux.vger.kernel.org>
References: <20070718173024.50204a1a.sfr@canb.auug.org.au>
	<20070720010742.e60c67a7.sfr@canb.auug.org.au>
In-Reply-To: <20070720010742.e60c67a7.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ppc-dev <linuxppc-dev@ozlabs.org>, sparclinux@vger.kernel.org
Cc: paulus@samba.org, "David S. Miller" <davem@davemloft.net>, wli@holomorphy.com

Move common stuff from asm-powerpc/of_platform.h to here and
move the common bits from asm-sparc*/of_device.h here as well.

Create asm-sparc*/of_platform.h and move appropriate parts of
of_device.h to them.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/asm-powerpc/of_platform.h |   38 ++++---------------------
 include/asm-sparc/of_device.h     |   39 +-------------------------
 include/asm-sparc/of_platform.h   |   32 +++++++++++++++++++++
 include/asm-sparc64/of_device.h   |   40 +-------------------------
 include/asm-sparc64/of_platform.h |   33 ++++++++++++++++++++++
 include/linux/of_platform.h       |   55 +++++++++++++++++++++++++++++++++++++
 6 files changed, 130 insertions(+), 107 deletions(-)
 create mode 100644 include/asm-sparc/of_platform.h
 create mode 100644 include/asm-sparc64/of_platform.h
 create mode 100644 include/linux/of_platform.h

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/include/asm-powerpc/of_platform.h b/include/asm-powerpc/of_platform.h
index 217eafb..80e6fad 100644
--- a/include/asm-powerpc/of_platform.h
+++ b/include/asm-powerpc/of_platform.h
@@ -1,3 +1,5 @@
+#ifndef _ASM_POWERPC_OF_PLATFORM_H
+#define _ASM_POWERPC_OF_PLATFORM_H
 /*
  *    Copyright (C) 2006 Benjamin Herrenschmidt, IBM Corp.
  *			 <benh@kernel.crashing.org>
@@ -9,37 +11,8 @@
  *
  */
 
-#include <asm/of_device.h>
-
-/*
- * The of_platform_bus_type is a bus type used by drivers that do not
- * attach to a macio or similar bus but still use OF probing
- * mechanism
- */
-extern struct bus_type of_platform_bus_type;
-
-/*
- * An of_platform_driver driver is attached to a basic of_device on
- * the "platform bus" (of_platform_bus_type)
- */
-struct of_platform_driver
-{
-	char			*name;
-	struct of_device_id	*match_table;
-	struct module		*owner;
-
-	int	(*probe)(struct of_device* dev,
-			 const struct of_device_id *match);
-	int	(*remove)(struct of_device* dev);
-
-	int	(*suspend)(struct of_device* dev, pm_message_t state);
-	int	(*resume)(struct of_device* dev);
-	int	(*shutdown)(struct of_device* dev);
-
-	struct device_driver	driver;
-};
-#define	to_of_platform_driver(drv) \
-	container_of(drv,struct of_platform_driver, driver)
+/* This is just here during the transition */
+#include <linux/of_platform.h>
 
 /* Platform drivers register/unregister */
 extern int of_register_platform_driver(struct of_platform_driver *drv);
@@ -56,5 +29,6 @@ extern int of_platform_bus_probe(struct device_node *root,
 				 struct of_device_id *matches,
 				 struct device *parent);
 
-extern struct of_device *of_find_device_by_node(struct device_node *np);
 extern struct of_device *of_find_device_by_phandle(phandle ph);
+
+#endif	/* _ASM_POWERPC_OF_PLATFORM_H */
diff --git a/include/asm-sparc/of_device.h b/include/asm-sparc/of_device.h
index fd8e957..e5f5aed 100644
--- a/include/asm-sparc/of_device.h
+++ b/include/asm-sparc/of_device.h
@@ -7,11 +7,6 @@
 #include <linux/mod_devicetable.h>
 #include <asm/openprom.h>
 
-extern struct bus_type ebus_bus_type;
-extern struct bus_type sbus_bus_type;
-extern struct bus_type of_platform_bus_type;
-#define of_bus_type	of_platform_bus_type	/* for compatibility */
-
 /*
  * The of_device is a kind of "base class" that is a superset of
  * struct device for use by devices attached to an OF node and
@@ -35,39 +30,9 @@ struct of_device
 extern void __iomem *of_ioremap(struct resource *res, unsigned long offset, unsigned long size, char *name);
 extern void of_iounmap(struct resource *res, void __iomem *base, unsigned long size);
 
-extern struct of_device *of_find_device_by_node(struct device_node *);
-
-/*
- * An of_platform_driver driver is attached to a basic of_device on
- * the ISA, EBUS, and SBUS busses on sparc64.
- */
-struct of_platform_driver
-{
-	char			*name;
-	struct of_device_id	*match_table;
-	struct module		*owner;
-
-	int	(*probe)(struct of_device* dev, const struct of_device_id *match);
-	int	(*remove)(struct of_device* dev);
-
-	int	(*suspend)(struct of_device* dev, pm_message_t state);
-	int	(*resume)(struct of_device* dev);
-	int	(*shutdown)(struct of_device* dev);
-
-	struct device_driver	driver;
-};
-#define	to_of_platform_driver(drv) container_of(drv,struct of_platform_driver, driver)
-
-extern int of_register_driver(struct of_platform_driver *drv,
-			      struct bus_type *bus);
-extern void of_unregister_driver(struct of_platform_driver *drv);
-extern struct of_device *of_platform_device_create(struct device_node *np,
-						   const char *bus_id,
-						   struct device *parent,
-						   struct bus_type *bus);
-
-/* This is just here during the transition */
+/* These are just here during the transition */
 #include <linux/of_device.h>
+#include <linux/of_platform.h>
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_SPARC_OF_DEVICE_H */
diff --git a/include/asm-sparc/of_platform.h b/include/asm-sparc/of_platform.h
new file mode 100644
index 0000000..64a2300
--- /dev/null
+++ b/include/asm-sparc/of_platform.h
@@ -0,0 +1,32 @@
+#ifndef _ASM_SPARC_OF_PLATFORM_H
+#define _ASM_SPARC_OF_PLATFORM_H
+/*
+ *    Copyright (C) 2006 Benjamin Herrenschmidt, IBM Corp.
+ *			 <benh@kernel.crashing.org>
+ *    Modified for Sparc by merging parts of asm-sparc/of_device.h
+ *		by Stephen Rothwell
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ *
+ */
+
+/* This is just here during the transition */
+#include <linux/of_platform.h>
+
+extern struct bus_type ebus_bus_type;
+extern struct bus_type sbus_bus_type;
+extern struct bus_type of_platform_bus_type;
+#define of_bus_type	of_platform_bus_type	/* for compatibility */
+
+extern int of_register_driver(struct of_platform_driver *drv,
+			      struct bus_type *bus);
+extern void of_unregister_driver(struct of_platform_driver *drv);
+extern struct of_device *of_platform_device_create(struct device_node *np,
+						   const char *bus_id,
+						   struct device *parent,
+						   struct bus_type *bus);
+
+#endif	/* _ASM_SPARC_OF_PLATFORM_H */
diff --git a/include/asm-sparc64/of_device.h b/include/asm-sparc64/of_device.h
index daf36eb..46d69b3 100644
--- a/include/asm-sparc64/of_device.h
+++ b/include/asm-sparc64/of_device.h
@@ -7,12 +7,6 @@
 #include <linux/mod_devicetable.h>
 #include <asm/openprom.h>
 
-extern struct bus_type isa_bus_type;
-extern struct bus_type ebus_bus_type;
-extern struct bus_type sbus_bus_type;
-extern struct bus_type of_platform_bus_type;
-#define of_bus_type	of_platform_bus_type	/* for compatibility */
-
 /*
  * The of_device is a kind of "base class" that is a superset of
  * struct device for use by devices attached to an OF node and
@@ -36,39 +30,9 @@ struct of_device
 extern void __iomem *of_ioremap(struct resource *res, unsigned long offset, unsigned long size, char *name);
 extern void of_iounmap(struct resource *res, void __iomem *base, unsigned long size);
 
-extern struct of_device *of_find_device_by_node(struct device_node *);
-
-/*
- * An of_platform_driver driver is attached to a basic of_device on
- * the ISA, EBUS, and SBUS busses on sparc64.
- */
-struct of_platform_driver
-{
-	char			*name;
-	struct of_device_id	*match_table;
-	struct module		*owner;
-
-	int	(*probe)(struct of_device* dev, const struct of_device_id *match);
-	int	(*remove)(struct of_device* dev);
-
-	int	(*suspend)(struct of_device* dev, pm_message_t state);
-	int	(*resume)(struct of_device* dev);
-	int	(*shutdown)(struct of_device* dev);
-
-	struct device_driver	driver;
-};
-#define	to_of_platform_driver(drv) container_of(drv,struct of_platform_driver, driver)
-
-extern int of_register_driver(struct of_platform_driver *drv,
-			      struct bus_type *bus);
-extern void of_unregister_driver(struct of_platform_driver *drv);
-extern struct of_device *of_platform_device_create(struct device_node *np,
-						   const char *bus_id,
-						   struct device *parent,
-						   struct bus_type *bus);
-
-/* This is just here during the transition */
+/* These are just here during the transition */
 #include <linux/of_device.h>
+#include <linux/of_platform.h>
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_SPARC64_OF_DEVICE_H */
diff --git a/include/asm-sparc64/of_platform.h b/include/asm-sparc64/of_platform.h
new file mode 100644
index 0000000..f7c1f17
--- /dev/null
+++ b/include/asm-sparc64/of_platform.h
@@ -0,0 +1,33 @@
+#ifndef _ASM_SPARC64_OF_PLATFORM_H
+#define _ASM_SPARC64_OF_PLATFORM_H
+/*
+ *    Copyright (C) 2006 Benjamin Herrenschmidt, IBM Corp.
+ *			 <benh@kernel.crashing.org>
+ *    Modified for Sparc by merging parts of asm-sparc/of_device.h
+ *		by Stephen Rothwell
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ *
+ */
+
+/* This is just here during the transition */
+#include <linux/of_platform.h>
+
+extern struct bus_type isa_bus_type;
+extern struct bus_type ebus_bus_type;
+extern struct bus_type sbus_bus_type;
+extern struct bus_type of_platform_bus_type;
+#define of_bus_type	of_platform_bus_type	/* for compatibility */
+
+extern int of_register_driver(struct of_platform_driver *drv,
+			      struct bus_type *bus);
+extern void of_unregister_driver(struct of_platform_driver *drv);
+extern struct of_device *of_platform_device_create(struct device_node *np,
+						   const char *bus_id,
+						   struct device *parent,
+						   struct bus_type *bus);
+
+#endif	/* _ASM_SPARC64_OF_PLATFORM_H */
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
new file mode 100644
index 0000000..c85d0f8
--- /dev/null
+++ b/include/linux/of_platform.h
@@ -0,0 +1,55 @@
+#ifndef _LINUX_OF_PLATFORM_H
+#define _LINUX_OF_PLATFORM_H
+/*
+ *    Copyright (C) 2006 Benjamin Herrenschmidt, IBM Corp.
+ *			 <benh@kernel.crashing.org>
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/pm.h>
+#include <linux/of_device.h>
+
+/*
+ * The of_platform_bus_type is a bus type used by drivers that do not
+ * attach to a macio or similar bus but still use OF probing
+ * mechanism
+ */
+extern struct bus_type of_platform_bus_type;
+
+/*
+ * An of_platform_driver driver is attached to a basic of_device on
+ * the "platform bus" (of_platform_bus_type) (or ISA, EBUS and SBUS
+ * busses on sparc).
+ */
+struct of_platform_driver
+{
+	char			*name;
+	struct of_device_id	*match_table;
+	struct module		*owner;
+
+	int	(*probe)(struct of_device* dev,
+			 const struct of_device_id *match);
+	int	(*remove)(struct of_device* dev);
+
+	int	(*suspend)(struct of_device* dev, pm_message_t state);
+	int	(*resume)(struct of_device* dev);
+	int	(*shutdown)(struct of_device* dev);
+
+	struct device_driver	driver;
+};
+#define	to_of_platform_driver(drv) \
+	container_of(drv,struct of_platform_driver, driver)
+
+#include <asm/of_platform.h>
+
+extern struct of_device *of_find_device_by_node(struct device_node *np);
+
+#endif	/* _LINUX_OF_PLATFORM_H */
-- 
1.5.2.3

