From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 17 Oct 2007 03:41:23 +0000
Subject: [PATCH 1/2] [SPARC/64] Consolidate of_register_driver
Message-Id: <20071017134123.cfe10b79.sfr@canb.auug.org.au>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, ppc-dev <linuxppc-dev@ozlabs.org>, wli@holomorphy.com

Also of_unregister_driver.  These will be shortly also used by the
PowerPC code.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/sparc/kernel/of_device.c     |   20 --------------------
 arch/sparc64/kernel/of_device.c   |   20 --------------------
 drivers/of/platform.c             |   21 +++++++++++++++++++++
 include/asm-sparc/of_platform.h   |    5 +----
 include/asm-sparc64/of_platform.h |    5 +----
 include/linux/of_platform.h       |    4 ++++
 6 files changed, 27 insertions(+), 48 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/sparc/kernel/of_device.c b/arch/sparc/kernel/of_device.c
index fb2caef..3ea000d 100644
--- a/arch/sparc/kernel/of_device.c
+++ b/arch/sparc/kernel/of_device.c
@@ -585,24 +585,6 @@ static int __init of_debug(char *str)
 
 __setup("of_debug=", of_debug);
 
-int of_register_driver(struct of_platform_driver *drv, struct bus_type *bus)
-{
-	/* initialize common driver fields */
-	if (!drv->driver.name)
-		drv->driver.name = drv->name;
-	if (!drv->driver.owner)
-		drv->driver.owner = drv->owner;
-	drv->driver.bus = bus;
-
-	/* register with core */
-	return driver_register(&drv->driver);
-}
-
-void of_unregister_driver(struct of_platform_driver *drv)
-{
-	driver_unregister(&drv->driver);
-}
-
 struct of_device* of_platform_device_create(struct device_node *np,
 					    const char *bus_id,
 					    struct device *parent,
@@ -628,6 +610,4 @@ struct of_device* of_platform_device_create(struct device_node *np,
 	return dev;
 }
 
-EXPORT_SYMBOL(of_register_driver);
-EXPORT_SYMBOL(of_unregister_driver);
 EXPORT_SYMBOL(of_platform_device_create);
diff --git a/arch/sparc64/kernel/of_device.c b/arch/sparc64/kernel/of_device.c
index 42d7798..fc5c0cc 100644
--- a/arch/sparc64/kernel/of_device.c
+++ b/arch/sparc64/kernel/of_device.c
@@ -869,26 +869,6 @@ static int __init of_debug(char *str)
 
 __setup("of_debug=", of_debug);
 
-int of_register_driver(struct of_platform_driver *drv, struct bus_type *bus)
-{
-	/* initialize common driver fields */
-	if (!drv->driver.name)
-		drv->driver.name = drv->name;
-	if (!drv->driver.owner)
-		drv->driver.owner = drv->owner;
-	drv->driver.bus = bus;
-
-	/* register with core */
-	return driver_register(&drv->driver);
-}
-EXPORT_SYMBOL(of_register_driver);
-
-void of_unregister_driver(struct of_platform_driver *drv)
-{
-	driver_unregister(&drv->driver);
-}
-EXPORT_SYMBOL(of_unregister_driver);
-
 struct of_device* of_platform_device_create(struct device_node *np,
 					    const char *bus_id,
 					    struct device *parent,
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 864f09f..b47bb2d 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -12,6 +12,7 @@
  *
  */
 #include <linux/errno.h>
+#include <linux/module.h>
 #include <linux/device.h>
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
@@ -94,3 +95,23 @@ int of_bus_type_init(struct bus_type *bus, const char *name)
 	bus->resume = of_platform_device_resume;
 	return bus_register(bus);
 }
+
+int of_register_driver(struct of_platform_driver *drv, struct bus_type *bus)
+{
+	/* initialize common driver fields */
+	if (!drv->driver.name)
+		drv->driver.name = drv->name;
+	if (!drv->driver.owner)
+		drv->driver.owner = drv->owner;
+	drv->driver.bus = bus;
+
+	/* register with core */
+	return driver_register(&drv->driver);
+}
+EXPORT_SYMBOL(of_register_driver);
+
+void of_unregister_driver(struct of_platform_driver *drv)
+{
+	driver_unregister(&drv->driver);
+}
+EXPORT_SYMBOL(of_unregister_driver);
diff --git a/include/asm-sparc/of_platform.h b/include/asm-sparc/of_platform.h
index 64a2300..d638737 100644
--- a/include/asm-sparc/of_platform.h
+++ b/include/asm-sparc/of_platform.h
@@ -18,12 +18,9 @@
 
 extern struct bus_type ebus_bus_type;
 extern struct bus_type sbus_bus_type;
-extern struct bus_type of_platform_bus_type;
+
 #define of_bus_type	of_platform_bus_type	/* for compatibility */
 
-extern int of_register_driver(struct of_platform_driver *drv,
-			      struct bus_type *bus);
-extern void of_unregister_driver(struct of_platform_driver *drv);
 extern struct of_device *of_platform_device_create(struct device_node *np,
 						   const char *bus_id,
 						   struct device *parent,
diff --git a/include/asm-sparc64/of_platform.h b/include/asm-sparc64/of_platform.h
index f7c1f17..f15cfa7 100644
--- a/include/asm-sparc64/of_platform.h
+++ b/include/asm-sparc64/of_platform.h
@@ -19,12 +19,9 @@
 extern struct bus_type isa_bus_type;
 extern struct bus_type ebus_bus_type;
 extern struct bus_type sbus_bus_type;
-extern struct bus_type of_platform_bus_type;
+
 #define of_bus_type	of_platform_bus_type	/* for compatibility */
 
-extern int of_register_driver(struct of_platform_driver *drv,
-			      struct bus_type *bus);
-extern void of_unregister_driver(struct of_platform_driver *drv);
 extern struct of_device *of_platform_device_create(struct device_node *np,
 						   const char *bus_id,
 						   struct device *parent,
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index 448f70b..a8efcfe 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -48,6 +48,10 @@ struct of_platform_driver
 #define	to_of_platform_driver(drv) \
 	container_of(drv,struct of_platform_driver, driver)
 
+extern int of_register_driver(struct of_platform_driver *drv,
+			      struct bus_type *bus);
+extern void of_unregister_driver(struct of_platform_driver *drv);
+
 #include <asm/of_platform.h>
 
 extern struct of_device *of_find_device_by_node(struct device_node *np);
-- 
1.5.3.4

