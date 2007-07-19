From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 19 Jul 2007 15:17:08 +0000
Subject: [PATCH 09/12] Begin consolidation of of_device.h
Message-Id: <20070720011708.7919947c.sfr@canb.auug.org.au>
List-Id: <sparclinux.vger.kernel.org>
References: <20070718173024.50204a1a.sfr@canb.auug.org.au>
	<20070720010742.e60c67a7.sfr@canb.auug.org.au>
In-Reply-To: <20070720010742.e60c67a7.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ppc-dev <linuxppc-dev@ozlabs.org>, sparclinux@vger.kernel.org
Cc: paulus@samba.org, "David S. Miller" <davem@davemloft.net>, wli@holomorphy.com

This just moves the common stuff from the arch of_device.h files to
linux/of_device.h.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/of/device.c             |    2 +-
 include/asm-powerpc/of_device.h |   22 +++++-----------------
 include/asm-sparc/of_device.h   |   15 ++++-----------
 include/asm-sparc64/of_device.h |   15 ++++-----------
 include/linux/of_device.h       |   26 ++++++++++++++++++++++++++
 5 files changed, 40 insertions(+), 40 deletions(-)
 create mode 100644 include/linux/of_device.h

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 7f233d7..6245f06 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -1,13 +1,13 @@
 #include <linux/string.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/slab.h>
 
 #include <asm/errno.h>
-#include <asm/of_device.h>
 
 /**
  * of_match_node - Tell if an device_node has a matching of_match structure
diff --git a/include/asm-powerpc/of_device.h b/include/asm-powerpc/of_device.h
index e9af49e..ec2a8a2 100644
--- a/include/asm-powerpc/of_device.h
+++ b/include/asm-powerpc/of_device.h
@@ -3,14 +3,12 @@
 #ifdef __KERNEL__
 
 #include <linux/device.h>
-#include <linux/mod_devicetable.h>
-#include <asm/prom.h>
-
+#include <linux/of.h>
 
 /*
  * The of_device is a kind of "base class" that is a superset of
  * struct device for use by devices attached to an OF node and
- * probed using OF properties
+ * probed using OF properties.
  */
 struct of_device
 {
@@ -18,24 +16,14 @@ struct of_device
 	u64			dma_mask;	/* DMA mask */
 	struct device		dev;		/* Generic device interface */
 };
-#define	to_of_device(d) container_of(d, struct of_device, dev)
-
-extern const struct of_device_id *of_match_node(
-	const struct of_device_id *matches, const struct device_node *node);
-extern const struct of_device_id *of_match_device(
-	const struct of_device_id *matches, const struct of_device *dev);
-
-extern struct of_device *of_dev_get(struct of_device *dev);
-extern void of_dev_put(struct of_device *dev);
-
-extern int of_device_register(struct of_device *ofdev);
-extern void of_device_unregister(struct of_device *ofdev);
-extern void of_release_dev(struct device *dev);
 
 extern ssize_t of_device_get_modalias(struct of_device *ofdev,
 					char *str, ssize_t len);
 extern int of_device_uevent(struct device *dev,
 	char **envp, int num_envp, char *buffer, int buffer_size);
 
+/* This is just here during the transition */
+#include <linux/of_device.h>
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_OF_DEVICE_H */
diff --git a/include/asm-sparc/of_device.h b/include/asm-sparc/of_device.h
index 7cb00c1..b625261 100644
--- a/include/asm-sparc/of_device.h
+++ b/include/asm-sparc/of_device.h
@@ -3,9 +3,9 @@
 #ifdef __KERNEL__
 
 #include <linux/device.h>
+#include <linux/of.h>
 #include <linux/mod_devicetable.h>
 #include <asm/openprom.h>
-#include <asm/prom.h>
 
 extern struct bus_type ebus_bus_type;
 extern struct bus_type sbus_bus_type;
@@ -30,19 +30,12 @@ struct of_device
 	int				portid;
 	int				clock_freq;
 };
-#define	to_of_device(d) container_of(d, struct of_device, dev)
 
 extern void __iomem *of_ioremap(struct resource *res, unsigned long offset, unsigned long size, char *name);
 extern void of_iounmap(struct resource *res, void __iomem *base, unsigned long size);
 
 extern struct of_device *of_find_device_by_node(struct device_node *);
 
-extern const struct of_device_id *of_match_device(
-	const struct of_device_id *matches, const struct of_device *dev);
-
-extern struct of_device *of_dev_get(struct of_device *dev);
-extern void of_dev_put(struct of_device *dev);
-
 /*
  * An of_platform_driver driver is attached to a basic of_device on
  * the ISA, EBUS, and SBUS busses on sparc64.
@@ -67,13 +60,13 @@ struct of_platform_driver
 extern int of_register_driver(struct of_platform_driver *drv,
 			      struct bus_type *bus);
 extern void of_unregister_driver(struct of_platform_driver *drv);
-extern int of_device_register(struct of_device *ofdev);
-extern void of_device_unregister(struct of_device *ofdev);
 extern struct of_device *of_platform_device_create(struct device_node *np,
 						   const char *bus_id,
 						   struct device *parent,
 						   struct bus_type *bus);
-extern void of_release_dev(struct device *dev);
+
+/* This is just here during the transition */
+#include <linux/of_device.h>
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_SPARC_OF_DEVICE_H */
diff --git a/include/asm-sparc64/of_device.h b/include/asm-sparc64/of_device.h
index 60e9173..68048cb 100644
--- a/include/asm-sparc64/of_device.h
+++ b/include/asm-sparc64/of_device.h
@@ -3,9 +3,9 @@
 #ifdef __KERNEL__
 
 #include <linux/device.h>
+#include <linux/of.h>
 #include <linux/mod_devicetable.h>
 #include <asm/openprom.h>
-#include <asm/prom.h>
 
 extern struct bus_type isa_bus_type;
 extern struct bus_type ebus_bus_type;
@@ -31,19 +31,12 @@ struct of_device
 	int				portid;
 	int				clock_freq;
 };
-#define	to_of_device(d) container_of(d, struct of_device, dev)
 
 extern void __iomem *of_ioremap(struct resource *res, unsigned long offset, unsigned long size, char *name);
 extern void of_iounmap(struct resource *res, void __iomem *base, unsigned long size);
 
 extern struct of_device *of_find_device_by_node(struct device_node *);
 
-extern const struct of_device_id *of_match_device(
-	const struct of_device_id *matches, const struct of_device *dev);
-
-extern struct of_device *of_dev_get(struct of_device *dev);
-extern void of_dev_put(struct of_device *dev);
-
 /*
  * An of_platform_driver driver is attached to a basic of_device on
  * the ISA, EBUS, and SBUS busses on sparc64.
@@ -68,13 +61,13 @@ struct of_platform_driver
 extern int of_register_driver(struct of_platform_driver *drv,
 			      struct bus_type *bus);
 extern void of_unregister_driver(struct of_platform_driver *drv);
-extern int of_device_register(struct of_device *ofdev);
-extern void of_device_unregister(struct of_device *ofdev);
 extern struct of_device *of_platform_device_create(struct device_node *np,
 						   const char *bus_id,
 						   struct device *parent,
 						   struct bus_type *bus);
-extern void of_release_dev(struct device *dev);
+
+/* This is just here during the transition */
+#include <linux/of_device.h>
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_SPARC64_OF_DEVICE_H */
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
new file mode 100644
index 0000000..91bf84b
--- /dev/null
+++ b/include/linux/of_device.h
@@ -0,0 +1,26 @@
+#ifndef _LINUX_OF_DEVICE_H
+#define _LINUX_OF_DEVICE_H
+#ifdef __KERNEL__
+
+#include <linux/device.h>
+#include <linux/of.h>
+#include <linux/mod_devicetable.h>
+
+#include <asm/of_device.h>
+
+#define	to_of_device(d) container_of(d, struct of_device, dev)
+
+extern const struct of_device_id *of_match_node(
+	const struct of_device_id *matches, const struct device_node *node);
+extern const struct of_device_id *of_match_device(
+	const struct of_device_id *matches, const struct of_device *dev);
+
+extern struct of_device *of_dev_get(struct of_device *dev);
+extern void of_dev_put(struct of_device *dev);
+
+extern int of_device_register(struct of_device *ofdev);
+extern void of_device_unregister(struct of_device *ofdev);
+extern void of_release_dev(struct device *dev);
+
+#endif /* __KERNEL__ */
+#endif /* _LINUX_OF_DEVICE_H */
-- 
1.5.2.3

