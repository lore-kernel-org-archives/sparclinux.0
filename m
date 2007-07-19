From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 19 Jul 2007 15:20:32 +0000
Subject: [PATCH 12/12] Create drivers/of/platform.c
Message-Id: <20070720012032.ad4419a1.sfr@canb.auug.org.au>
List-Id: <sparclinux.vger.kernel.org>
References: <20070718173024.50204a1a.sfr@canb.auug.org.au>
	<20070720010742.e60c67a7.sfr@canb.auug.org.au>
In-Reply-To: <20070720010742.e60c67a7.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ppc-dev <linuxppc-dev@ozlabs.org>, sparclinux@vger.kernel.org
Cc: paulus@samba.org, "David S. Miller" <davem@davemloft.net>, wli@holomorphy.com

and populate it with the common parts from PowerPC and Sparc[64].

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/of_platform.c |   82 +-------------------------
 arch/sparc/kernel/of_device.c     |  107 +++------------------------------
 arch/sparc64/kernel/of_device.c   |  118 ++++---------------------------------
 drivers/of/Makefile               |    2 +-
 drivers/of/platform.c             |   96 ++++++++++++++++++++++++++++++
 include/linux/of_platform.h       |    2 +
 6 files changed, 120 insertions(+), 287 deletions(-)
 create mode 100644 drivers/of/platform.c

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/of_platform.c b/arch/powerpc/kernel/of_platform.c
index 9536ed7..93e6367 100644
--- a/arch/powerpc/kernel/of_platform.c
+++ b/arch/powerpc/kernel/of_platform.c
@@ -55,94 +55,14 @@ static struct of_device_id of_default_bus_ids[] = {
 
 static atomic_t bus_no_reg_magic;
 
-/*
- *
- * OF platform device type definition & base infrastructure
- *
- */
-
-static int of_platform_bus_match(struct device *dev, struct device_driver *drv)
-{
-	struct of_device * of_dev = to_of_device(dev);
-	struct of_platform_driver * of_drv = to_of_platform_driver(drv);
-	const struct of_device_id * matches = of_drv->match_table;
-
-	if (!matches)
-		return 0;
-
-	return of_match_device(matches, of_dev) != NULL;
-}
-
-static int of_platform_device_probe(struct device *dev)
-{
-	int error = -ENODEV;
-	struct of_platform_driver *drv;
-	struct of_device *of_dev;
-	const struct of_device_id *match;
-
-	drv = to_of_platform_driver(dev->driver);
-	of_dev = to_of_device(dev);
-
-	if (!drv->probe)
-		return error;
-
-	of_dev_get(of_dev);
-
-	match = of_match_device(drv->match_table, of_dev);
-	if (match)
-		error = drv->probe(of_dev, match);
-	if (error)
-		of_dev_put(of_dev);
-
-	return error;
-}
-
-static int of_platform_device_remove(struct device *dev)
-{
-	struct of_device * of_dev = to_of_device(dev);
-	struct of_platform_driver * drv = to_of_platform_driver(dev->driver);
-
-	if (dev->driver && drv->remove)
-		drv->remove(of_dev);
-	return 0;
-}
-
-static int of_platform_device_suspend(struct device *dev, pm_message_t state)
-{
-	struct of_device * of_dev = to_of_device(dev);
-	struct of_platform_driver * drv = to_of_platform_driver(dev->driver);
-	int error = 0;
-
-	if (dev->driver && drv->suspend)
-		error = drv->suspend(of_dev, state);
-	return error;
-}
-
-static int of_platform_device_resume(struct device * dev)
-{
-	struct of_device * of_dev = to_of_device(dev);
-	struct of_platform_driver * drv = to_of_platform_driver(dev->driver);
-	int error = 0;
-
-	if (dev->driver && drv->resume)
-		error = drv->resume(of_dev);
-	return error;
-}
-
 struct bus_type of_platform_bus_type = {
-       .name	= "of_platform",
-       .match	= of_platform_bus_match,
        .uevent	= of_device_uevent,
-       .probe	= of_platform_device_probe,
-       .remove	= of_platform_device_remove,
-       .suspend	= of_platform_device_suspend,
-       .resume	= of_platform_device_resume,
 };
 EXPORT_SYMBOL(of_platform_bus_type);
 
 static int __init of_bus_driver_init(void)
 {
-	return bus_register(&of_platform_bus_type);
+	return of_bus_type_init(&of_platform_bus_type, "of_platform");
 }
 
 postcore_initcall(of_bus_driver_init);
diff --git a/arch/sparc/kernel/of_device.c b/arch/sparc/kernel/of_device.c
index cb21983..7176040 100644
--- a/arch/sparc/kernel/of_device.c
+++ b/arch/sparc/kernel/of_device.c
@@ -5,77 +5,9 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/slab.h>
-
-#include <asm/errno.h>
-#include <asm/of_device.h>
-
-static int of_platform_bus_match(struct device *dev, struct device_driver *drv)
-{
-	struct of_device * of_dev = to_of_device(dev);
-	struct of_platform_driver * of_drv = to_of_platform_driver(drv);
-	const struct of_device_id * matches = of_drv->match_table;
-
-	if (!matches)
-		return 0;
-
-	return of_match_device(matches, of_dev) != NULL;
-}
-
-static int of_platform_device_probe(struct device *dev)
-{
-	int error = -ENODEV;
-	struct of_platform_driver *drv;
-	struct of_device *of_dev;
-	const struct of_device_id *match;
-
-	drv = to_of_platform_driver(dev->driver);
-	of_dev = to_of_device(dev);
-
-	if (!drv->probe)
-		return error;
-
-	of_dev_get(of_dev);
-
-	match = of_match_device(drv->match_table, of_dev);
-	if (match)
-		error = drv->probe(of_dev, match);
-	if (error)
-		of_dev_put(of_dev);
-
-	return error;
-}
-
-static int of_platform_device_remove(struct device *dev)
-{
-	struct of_device * of_dev = to_of_device(dev);
-	struct of_platform_driver * drv = to_of_platform_driver(dev->driver);
-
-	if (dev->driver && drv->remove)
-		drv->remove(of_dev);
-	return 0;
-}
-
-static int of_platform_device_suspend(struct device *dev, pm_message_t state)
-{
-	struct of_device * of_dev = to_of_device(dev);
-	struct of_platform_driver * drv = to_of_platform_driver(dev->driver);
-	int error = 0;
-
-	if (dev->driver && drv->suspend)
-		error = drv->suspend(of_dev, state);
-	return error;
-}
-
-static int of_platform_device_resume(struct device * dev)
-{
-	struct of_device * of_dev = to_of_device(dev);
-	struct of_platform_driver * drv = to_of_platform_driver(dev->driver);
-	int error = 0;
-
-	if (dev->driver && drv->resume)
-		error = drv->resume(of_dev);
-	return error;
-}
+#include <linux/errno.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
 
 static int node_match(struct device *dev, void *data)
 {
@@ -98,37 +30,16 @@ struct of_device *of_find_device_by_node(struct device_node *dp)
 EXPORT_SYMBOL(of_find_device_by_node);
 
 #ifdef CONFIG_PCI
-struct bus_type ebus_bus_type = {
-       .name	= "ebus",
-       .match	= of_platform_bus_match,
-       .probe	= of_platform_device_probe,
-       .remove	= of_platform_device_remove,
-       .suspend	= of_platform_device_suspend,
-       .resume	= of_platform_device_resume,
-};
+struct bus_type ebus_bus_type;
 EXPORT_SYMBOL(ebus_bus_type);
 #endif
 
 #ifdef CONFIG_SBUS
-struct bus_type sbus_bus_type = {
-       .name	= "sbus",
-       .match	= of_platform_bus_match,
-       .probe	= of_platform_device_probe,
-       .remove	= of_platform_device_remove,
-       .suspend	= of_platform_device_suspend,
-       .resume	= of_platform_device_resume,
-};
+struct bus_type sbus_bus_type;
 EXPORT_SYMBOL(sbus_bus_type);
 #endif
 
-struct bus_type of_platform_bus_type = {
-       .name	= "of",
-       .match	= of_platform_bus_match,
-       .probe	= of_platform_device_probe,
-       .remove	= of_platform_device_remove,
-       .suspend	= of_platform_device_suspend,
-       .resume	= of_platform_device_resume,
-};
+struct bus_type of_platform_bus_type;
 EXPORT_SYMBOL(of_platform_bus_type);
 
 static inline u64 of_read_addr(const u32 *cell, int size)
@@ -639,14 +550,14 @@ static int __init of_bus_driver_init(void)
 {
 	int err;
 
-	err = bus_register(&of_platform_bus_type);
+	err = of_bus_type_init(&of_platform_bus_type, "of");
 #ifdef CONFIG_PCI
 	if (!err)
-		err = bus_register(&ebus_bus_type);
+		err = of_bus_type_init(&ebus_bus_type, "ebus");
 #endif
 #ifdef CONFIG_SBUS
 	if (!err)
-		err = bus_register(&sbus_bus_type);
+		err = of_bus_type_init(&sbus_bus_type, "sbus");
 #endif
 
 	if (!err)
diff --git a/arch/sparc64/kernel/of_device.c b/arch/sparc64/kernel/of_device.c
index 485f857..7b0dce9 100644
--- a/arch/sparc64/kernel/of_device.c
+++ b/arch/sparc64/kernel/of_device.c
@@ -5,77 +5,9 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/slab.h>
-
-#include <asm/errno.h>
-#include <asm/of_device.h>
-
-static int of_platform_bus_match(struct device *dev, struct device_driver *drv)
-{
-	struct of_device * of_dev = to_of_device(dev);
-	struct of_platform_driver * of_drv = to_of_platform_driver(drv);
-	const struct of_device_id * matches = of_drv->match_table;
-
-	if (!matches)
-		return 0;
-
-	return of_match_device(matches, of_dev) != NULL;
-}
-
-static int of_platform_device_probe(struct device *dev)
-{
-	int error = -ENODEV;
-	struct of_platform_driver *drv;
-	struct of_device *of_dev;
-	const struct of_device_id *match;
-
-	drv = to_of_platform_driver(dev->driver);
-	of_dev = to_of_device(dev);
-
-	if (!drv->probe)
-		return error;
-
-	of_dev_get(of_dev);
-
-	match = of_match_device(drv->match_table, of_dev);
-	if (match)
-		error = drv->probe(of_dev, match);
-	if (error)
-		of_dev_put(of_dev);
-
-	return error;
-}
-
-static int of_platform_device_remove(struct device *dev)
-{
-	struct of_device * of_dev = to_of_device(dev);
-	struct of_platform_driver * drv = to_of_platform_driver(dev->driver);
-
-	if (dev->driver && drv->remove)
-		drv->remove(of_dev);
-	return 0;
-}
-
-static int of_platform_device_suspend(struct device *dev, pm_message_t state)
-{
-	struct of_device * of_dev = to_of_device(dev);
-	struct of_platform_driver * drv = to_of_platform_driver(dev->driver);
-	int error = 0;
-
-	if (dev->driver && drv->suspend)
-		error = drv->suspend(of_dev, state);
-	return error;
-}
-
-static int of_platform_device_resume(struct device * dev)
-{
-	struct of_device * of_dev = to_of_device(dev);
-	struct of_platform_driver * drv = to_of_platform_driver(dev->driver);
-	int error = 0;
-
-	if (dev->driver && drv->resume)
-		error = drv->resume(of_dev);
-	return error;
-}
+#include <linux/errno.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
 
 void __iomem *of_ioremap(struct resource *res, unsigned long offset, unsigned long size, char *name)
 {
@@ -123,47 +55,19 @@ struct of_device *of_find_device_by_node(struct device_node *dp)
 EXPORT_SYMBOL(of_find_device_by_node);
 
 #ifdef CONFIG_PCI
-struct bus_type isa_bus_type = {
-       .name	= "isa",
-       .match	= of_platform_bus_match,
-       .probe	= of_platform_device_probe,
-       .remove	= of_platform_device_remove,
-       .suspend	= of_platform_device_suspend,
-       .resume	= of_platform_device_resume,
-};
+struct bus_type isa_bus_type;
 EXPORT_SYMBOL(isa_bus_type);
 
-struct bus_type ebus_bus_type = {
-       .name	= "ebus",
-       .match	= of_platform_bus_match,
-       .probe	= of_platform_device_probe,
-       .remove	= of_platform_device_remove,
-       .suspend	= of_platform_device_suspend,
-       .resume	= of_platform_device_resume,
-};
+struct bus_type ebus_bus_type;
 EXPORT_SYMBOL(ebus_bus_type);
 #endif
 
 #ifdef CONFIG_SBUS
-struct bus_type sbus_bus_type = {
-       .name	= "sbus",
-       .match	= of_platform_bus_match,
-       .probe	= of_platform_device_probe,
-       .remove	= of_platform_device_remove,
-       .suspend	= of_platform_device_suspend,
-       .resume	= of_platform_device_resume,
-};
+struct bus_type sbus_bus_type;
 EXPORT_SYMBOL(sbus_bus_type);
 #endif
 
-struct bus_type of_platform_bus_type = {
-       .name	= "of",
-       .match	= of_platform_bus_match,
-       .probe	= of_platform_device_probe,
-       .remove	= of_platform_device_remove,
-       .suspend	= of_platform_device_suspend,
-       .resume	= of_platform_device_resume,
-};
+struct bus_type of_platform_bus_type;
 EXPORT_SYMBOL(of_platform_bus_type);
 
 static inline u64 of_read_addr(const u32 *cell, int size)
@@ -926,16 +830,16 @@ static int __init of_bus_driver_init(void)
 {
 	int err;
 
-	err = bus_register(&of_platform_bus_type);
+	err = of_bus_type_init(&of_platform_bus_type, "of");
 #ifdef CONFIG_PCI
 	if (!err)
-		err = bus_register(&isa_bus_type);
+		err = of_bus_type_init(&isa_bus_type, "isa");
 	if (!err)
-		err = bus_register(&ebus_bus_type);
+		err = of_bus_type_init(&ebus_bus_type, "ebus");
 #endif
 #ifdef CONFIG_SBUS
 	if (!err)
-		err = bus_register(&sbus_bus_type);
+		err = of_bus_type_init(&sbus_bus_type, "sbus");
 #endif
 
 	if (!err)
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index c46d998..ab9be5d 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -1,2 +1,2 @@
 obj-y = base.o
-obj-$(CONFIG_OF_DEVICE) += device.o
+obj-$(CONFIG_OF_DEVICE) += device.o platform.o
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
new file mode 100644
index 0000000..864f09f
--- /dev/null
+++ b/drivers/of/platform.c
@@ -0,0 +1,96 @@
+/*
+ *    Copyright (C) 2006 Benjamin Herrenschmidt, IBM Corp.
+ *			 <benh@kernel.crashing.org>
+ *    and		 Arnd Bergmann, IBM Corp.
+ *    Merged from powerpc/kernel/of_platform.c and
+ *    sparc{,64}/kernel/of_device.c by Stephen Rothwell
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ *
+ */
+#include <linux/errno.h>
+#include <linux/device.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+
+static int of_platform_bus_match(struct device *dev, struct device_driver *drv)
+{
+	struct of_device *of_dev = to_of_device(dev);
+	struct of_platform_driver *of_drv = to_of_platform_driver(drv);
+	const struct of_device_id *matches = of_drv->match_table;
+
+	if (!matches)
+		return 0;
+
+	return of_match_device(matches, of_dev) != NULL;
+}
+
+static int of_platform_device_probe(struct device *dev)
+{
+	int error = -ENODEV;
+	struct of_platform_driver *drv;
+	struct of_device *of_dev;
+	const struct of_device_id *match;
+
+	drv = to_of_platform_driver(dev->driver);
+	of_dev = to_of_device(dev);
+
+	if (!drv->probe)
+		return error;
+
+	of_dev_get(of_dev);
+
+	match = of_match_device(drv->match_table, of_dev);
+	if (match)
+		error = drv->probe(of_dev, match);
+	if (error)
+		of_dev_put(of_dev);
+
+	return error;
+}
+
+static int of_platform_device_remove(struct device *dev)
+{
+	struct of_device *of_dev = to_of_device(dev);
+	struct of_platform_driver *drv = to_of_platform_driver(dev->driver);
+
+	if (dev->driver && drv->remove)
+		drv->remove(of_dev);
+	return 0;
+}
+
+static int of_platform_device_suspend(struct device *dev, pm_message_t state)
+{
+	struct of_device *of_dev = to_of_device(dev);
+	struct of_platform_driver *drv = to_of_platform_driver(dev->driver);
+	int error = 0;
+
+	if (dev->driver && drv->suspend)
+		error = drv->suspend(of_dev, state);
+	return error;
+}
+
+static int of_platform_device_resume(struct device * dev)
+{
+	struct of_device *of_dev = to_of_device(dev);
+	struct of_platform_driver *drv = to_of_platform_driver(dev->driver);
+	int error = 0;
+
+	if (dev->driver && drv->resume)
+		error = drv->resume(of_dev);
+	return error;
+}
+
+int of_bus_type_init(struct bus_type *bus, const char *name)
+{
+	bus->name = name;
+	bus->match = of_platform_bus_match;
+	bus->probe = of_platform_device_probe;
+	bus->remove = of_platform_device_remove;
+	bus->suspend = of_platform_device_suspend;
+	bus->resume = of_platform_device_resume;
+	return bus_register(bus);
+}
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index c85d0f8..5fd44e6 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -52,4 +52,6 @@ struct of_platform_driver
 
 extern struct of_device *of_find_device_by_node(struct device_node *np);
 
+extern int of_bus_type_init(struct bus_type *bus, const char *name);
+
 #endif	/* _LINUX_OF_PLATFORM_H */
-- 
1.5.2.3

