From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 19 Jul 2007 15:18:15 +0000
Subject: [PATCH 10/12] [SPARC/64] Rename some functions like PowerPC
Message-Id: <20070720011815.25969af4.sfr@canb.auug.org.au>
List-Id: <sparclinux.vger.kernel.org>
References: <20070718173024.50204a1a.sfr@canb.auug.org.au>
	<20070720010742.e60c67a7.sfr@canb.auug.org.au>
In-Reply-To: <20070720010742.e60c67a7.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ppc-dev <linuxppc-dev@ozlabs.org>, sparclinux@vger.kernel.org
Cc: paulus@samba.org, "David S. Miller" <davem@davemloft.net>, wli@holomorphy.com

This is to make the of merge easier.  Also rename of_bus_type.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/sparc/kernel/of_device.c   |   42 ++++++++++++++++----------------
 arch/sparc/kernel/time.c        |    2 +-
 arch/sparc64/kernel/auxio.c     |    2 +-
 arch/sparc64/kernel/of_device.c |   50 +++++++++++++++++++-------------------
 arch/sparc64/kernel/power.c     |    2 +-
 arch/sparc64/kernel/time.c      |    2 +-
 include/asm-sparc/of_device.h   |    3 +-
 include/asm-sparc64/of_device.h |    3 +-
 8 files changed, 54 insertions(+), 52 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/sparc/kernel/of_device.c b/arch/sparc/kernel/of_device.c
index 0760b81..cb21983 100644
--- a/arch/sparc/kernel/of_device.c
+++ b/arch/sparc/kernel/of_device.c
@@ -21,7 +21,7 @@ static int of_platform_bus_match(struct device *dev, struct device_driver *drv)
 	return of_match_device(matches, of_dev) != NULL;
 }
 
-static int of_device_probe(struct device *dev)
+static int of_platform_device_probe(struct device *dev)
 {
 	int error = -ENODEV;
 	struct of_platform_driver *drv;
@@ -45,7 +45,7 @@ static int of_device_probe(struct device *dev)
 	return error;
 }
 
-static int of_device_remove(struct device *dev)
+static int of_platform_device_remove(struct device *dev)
 {
 	struct of_device * of_dev = to_of_device(dev);
 	struct of_platform_driver * drv = to_of_platform_driver(dev->driver);
@@ -55,7 +55,7 @@ static int of_device_remove(struct device *dev)
 	return 0;
 }
 
-static int of_device_suspend(struct device *dev, pm_message_t state)
+static int of_platform_device_suspend(struct device *dev, pm_message_t state)
 {
 	struct of_device * of_dev = to_of_device(dev);
 	struct of_platform_driver * drv = to_of_platform_driver(dev->driver);
@@ -66,7 +66,7 @@ static int of_device_suspend(struct device *dev, pm_message_t state)
 	return error;
 }
 
-static int of_device_resume(struct device * dev)
+static int of_platform_device_resume(struct device * dev)
 {
 	struct of_device * of_dev = to_of_device(dev);
 	struct of_platform_driver * drv = to_of_platform_driver(dev->driver);
@@ -87,7 +87,7 @@ static int node_match(struct device *dev, void *data)
 
 struct of_device *of_find_device_by_node(struct device_node *dp)
 {
-	struct device *dev = bus_find_device(&of_bus_type, NULL,
+	struct device *dev = bus_find_device(&of_platform_bus_type, NULL,
 					     dp, node_match);
 
 	if (dev)
@@ -101,10 +101,10 @@ EXPORT_SYMBOL(of_find_device_by_node);
 struct bus_type ebus_bus_type = {
        .name	= "ebus",
        .match	= of_platform_bus_match,
-       .probe	= of_device_probe,
-       .remove	= of_device_remove,
-       .suspend	= of_device_suspend,
-       .resume	= of_device_resume,
+       .probe	= of_platform_device_probe,
+       .remove	= of_platform_device_remove,
+       .suspend	= of_platform_device_suspend,
+       .resume	= of_platform_device_resume,
 };
 EXPORT_SYMBOL(ebus_bus_type);
 #endif
@@ -113,23 +113,23 @@ EXPORT_SYMBOL(ebus_bus_type);
 struct bus_type sbus_bus_type = {
        .name	= "sbus",
        .match	= of_platform_bus_match,
-       .probe	= of_device_probe,
-       .remove	= of_device_remove,
-       .suspend	= of_device_suspend,
-       .resume	= of_device_resume,
+       .probe	= of_platform_device_probe,
+       .remove	= of_platform_device_remove,
+       .suspend	= of_platform_device_suspend,
+       .resume	= of_platform_device_resume,
 };
 EXPORT_SYMBOL(sbus_bus_type);
 #endif
 
-struct bus_type of_bus_type = {
+struct bus_type of_platform_bus_type = {
        .name	= "of",
        .match	= of_platform_bus_match,
-       .probe	= of_device_probe,
-       .remove	= of_device_remove,
-       .suspend	= of_device_suspend,
-       .resume	= of_device_resume,
+       .probe	= of_platform_device_probe,
+       .remove	= of_platform_device_remove,
+       .suspend	= of_platform_device_suspend,
+       .resume	= of_platform_device_resume,
 };
-EXPORT_SYMBOL(of_bus_type);
+EXPORT_SYMBOL(of_platform_bus_type);
 
 static inline u64 of_read_addr(const u32 *cell, int size)
 {
@@ -595,7 +595,7 @@ build_resources:
 	build_device_resources(op, parent);
 
 	op->dev.parent = parent;
-	op->dev.bus = &of_bus_type;
+	op->dev.bus = &of_platform_bus_type;
 	if (!parent)
 		strcpy(op->dev.bus_id, "root");
 	else
@@ -639,7 +639,7 @@ static int __init of_bus_driver_init(void)
 {
 	int err;
 
-	err = bus_register(&of_bus_type);
+	err = bus_register(&of_platform_bus_type);
 #ifdef CONFIG_PCI
 	if (!err)
 		err = bus_register(&ebus_bus_type);
diff --git a/arch/sparc/kernel/time.c b/arch/sparc/kernel/time.c
index 7b4612d..f2fdbb3 100644
--- a/arch/sparc/kernel/time.c
+++ b/arch/sparc/kernel/time.c
@@ -354,7 +354,7 @@ static struct of_platform_driver clock_driver = {
 /* Probe for the mostek real time clock chip. */
 static int __init clock_init(void)
 {
-	return of_register_driver(&clock_driver, &of_bus_type);
+	return of_register_driver(&clock_driver, &of_platform_bus_type);
 }
 
 /* Must be after subsys_initcall() so that busses are probed.  Must
diff --git a/arch/sparc64/kernel/auxio.c b/arch/sparc64/kernel/auxio.c
index 826118e..7b37976 100644
--- a/arch/sparc64/kernel/auxio.c
+++ b/arch/sparc64/kernel/auxio.c
@@ -155,7 +155,7 @@ static struct of_platform_driver auxio_driver = {
 
 static int __init auxio_init(void)
 {
-	return of_register_driver(&auxio_driver, &of_bus_type);
+	return of_register_driver(&auxio_driver, &of_platform_bus_type);
 }
 
 /* Must be after subsys_initcall() so that busses are probed.  Must
diff --git a/arch/sparc64/kernel/of_device.c b/arch/sparc64/kernel/of_device.c
index 68927bc..485f857 100644
--- a/arch/sparc64/kernel/of_device.c
+++ b/arch/sparc64/kernel/of_device.c
@@ -21,7 +21,7 @@ static int of_platform_bus_match(struct device *dev, struct device_driver *drv)
 	return of_match_device(matches, of_dev) != NULL;
 }
 
-static int of_device_probe(struct device *dev)
+static int of_platform_device_probe(struct device *dev)
 {
 	int error = -ENODEV;
 	struct of_platform_driver *drv;
@@ -45,7 +45,7 @@ static int of_device_probe(struct device *dev)
 	return error;
 }
 
-static int of_device_remove(struct device *dev)
+static int of_platform_device_remove(struct device *dev)
 {
 	struct of_device * of_dev = to_of_device(dev);
 	struct of_platform_driver * drv = to_of_platform_driver(dev->driver);
@@ -55,7 +55,7 @@ static int of_device_remove(struct device *dev)
 	return 0;
 }
 
-static int of_device_suspend(struct device *dev, pm_message_t state)
+static int of_platform_device_suspend(struct device *dev, pm_message_t state)
 {
 	struct of_device * of_dev = to_of_device(dev);
 	struct of_platform_driver * drv = to_of_platform_driver(dev->driver);
@@ -66,7 +66,7 @@ static int of_device_suspend(struct device *dev, pm_message_t state)
 	return error;
 }
 
-static int of_device_resume(struct device * dev)
+static int of_platform_device_resume(struct device * dev)
 {
 	struct of_device * of_dev = to_of_device(dev);
 	struct of_platform_driver * drv = to_of_platform_driver(dev->driver);
@@ -112,7 +112,7 @@ static int node_match(struct device *dev, void *data)
 
 struct of_device *of_find_device_by_node(struct device_node *dp)
 {
-	struct device *dev = bus_find_device(&of_bus_type, NULL,
+	struct device *dev = bus_find_device(&of_platform_bus_type, NULL,
 					     dp, node_match);
 
 	if (dev)
@@ -126,20 +126,20 @@ EXPORT_SYMBOL(of_find_device_by_node);
 struct bus_type isa_bus_type = {
        .name	= "isa",
        .match	= of_platform_bus_match,
-       .probe	= of_device_probe,
-       .remove	= of_device_remove,
-       .suspend	= of_device_suspend,
-       .resume	= of_device_resume,
+       .probe	= of_platform_device_probe,
+       .remove	= of_platform_device_remove,
+       .suspend	= of_platform_device_suspend,
+       .resume	= of_platform_device_resume,
 };
 EXPORT_SYMBOL(isa_bus_type);
 
 struct bus_type ebus_bus_type = {
        .name	= "ebus",
        .match	= of_platform_bus_match,
-       .probe	= of_device_probe,
-       .remove	= of_device_remove,
-       .suspend	= of_device_suspend,
-       .resume	= of_device_resume,
+       .probe	= of_platform_device_probe,
+       .remove	= of_platform_device_remove,
+       .suspend	= of_platform_device_suspend,
+       .resume	= of_platform_device_resume,
 };
 EXPORT_SYMBOL(ebus_bus_type);
 #endif
@@ -148,23 +148,23 @@ EXPORT_SYMBOL(ebus_bus_type);
 struct bus_type sbus_bus_type = {
        .name	= "sbus",
        .match	= of_platform_bus_match,
-       .probe	= of_device_probe,
-       .remove	= of_device_remove,
-       .suspend	= of_device_suspend,
-       .resume	= of_device_resume,
+       .probe	= of_platform_device_probe,
+       .remove	= of_platform_device_remove,
+       .suspend	= of_platform_device_suspend,
+       .resume	= of_platform_device_resume,
 };
 EXPORT_SYMBOL(sbus_bus_type);
 #endif
 
-struct bus_type of_bus_type = {
+struct bus_type of_platform_bus_type = {
        .name	= "of",
        .match	= of_platform_bus_match,
-       .probe	= of_device_probe,
-       .remove	= of_device_remove,
-       .suspend	= of_device_suspend,
-       .resume	= of_device_resume,
+       .probe	= of_platform_device_probe,
+       .remove	= of_platform_device_remove,
+       .suspend	= of_platform_device_suspend,
+       .resume	= of_platform_device_resume,
 };
-EXPORT_SYMBOL(of_bus_type);
+EXPORT_SYMBOL(of_platform_bus_type);
 
 static inline u64 of_read_addr(const u32 *cell, int size)
 {
@@ -882,7 +882,7 @@ static struct of_device * __init scan_one_device(struct device_node *dp,
 		op->irqs[i] = build_one_device_irq(op, parent, op->irqs[i]);
 
 	op->dev.parent = parent;
-	op->dev.bus = &of_bus_type;
+	op->dev.bus = &of_platform_bus_type;
 	if (!parent)
 		strcpy(op->dev.bus_id, "root");
 	else
@@ -926,7 +926,7 @@ static int __init of_bus_driver_init(void)
 {
 	int err;
 
-	err = bus_register(&of_bus_type);
+	err = bus_register(&of_platform_bus_type);
 #ifdef CONFIG_PCI
 	if (!err)
 		err = bus_register(&isa_bus_type);
diff --git a/arch/sparc64/kernel/power.c b/arch/sparc64/kernel/power.c
index 8dd4294..fdc0d0b 100644
--- a/arch/sparc64/kernel/power.c
+++ b/arch/sparc64/kernel/power.c
@@ -170,6 +170,6 @@ static struct of_platform_driver power_driver = {
 
 void __init power_init(void)
 {
-	of_register_driver(&power_driver, &of_bus_type);
+	of_register_driver(&power_driver, &of_platform_bus_type);
 	return;
 }
diff --git a/arch/sparc64/kernel/time.c b/arch/sparc64/kernel/time.c
index 62e316a..592ffcd 100644
--- a/arch/sparc64/kernel/time.c
+++ b/arch/sparc64/kernel/time.c
@@ -835,7 +835,7 @@ static int __init clock_init(void)
 		return 0;
 	}
 
-	return of_register_driver(&clock_driver, &of_bus_type);
+	return of_register_driver(&clock_driver, &of_platform_bus_type);
 }
 
 /* Must be after subsys_initcall() so that busses are probed.  Must
diff --git a/include/asm-sparc/of_device.h b/include/asm-sparc/of_device.h
index b625261..fd8e957 100644
--- a/include/asm-sparc/of_device.h
+++ b/include/asm-sparc/of_device.h
@@ -9,7 +9,8 @@
 
 extern struct bus_type ebus_bus_type;
 extern struct bus_type sbus_bus_type;
-extern struct bus_type of_bus_type;
+extern struct bus_type of_platform_bus_type;
+#define of_bus_type	of_platform_bus_type	/* for compatibility */
 
 /*
  * The of_device is a kind of "base class" that is a superset of
diff --git a/include/asm-sparc64/of_device.h b/include/asm-sparc64/of_device.h
index 68048cb..daf36eb 100644
--- a/include/asm-sparc64/of_device.h
+++ b/include/asm-sparc64/of_device.h
@@ -10,7 +10,8 @@
 extern struct bus_type isa_bus_type;
 extern struct bus_type ebus_bus_type;
 extern struct bus_type sbus_bus_type;
-extern struct bus_type of_bus_type;
+extern struct bus_type of_platform_bus_type;
+#define of_bus_type	of_platform_bus_type	/* for compatibility */
 
 /*
  * The of_device is a kind of "base class" that is a superset of
-- 
1.5.2.3

