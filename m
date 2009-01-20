From: Robert Reif <reif@earthlink.net>
Date: Tue, 20 Jan 2009 03:21:08 +0000
Subject: [PATCH] move of_device common code to of_device_common
Message-Id: <49754324.2080201@earthlink.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------040507020100000001030403"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------040507020100000001030403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch moves code common to of_device_32.c and of_device_64.c into 
of_device_common.h and of_device_common.c.

The only functional difference is in sparc32 where of_bus_default_map is 
used in place of of_bus_sbus_map because they are equivelent.

There is still room for further code consolidation with some minor 
refactoring.

Boot tested on sparc32 and compile tested on sparc64.

Signed-off-by: Robert Reif <reif@earthlink.net>

--------------040507020100000001030403
Content-Type: text/x-diff;
 name="of_device_common.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="of_device_common.diff"

 arch/sparc/kernel/Makefile           |    1 +
 arch/sparc/kernel/of_device_32.c     |  178 +---------------------------------
 arch/sparc/kernel/of_device_64.c     |  172 +--------------------------------
 arch/sparc/kernel/of_device_common.c |  157 ++++++++++++++++++++++++++++++
 arch/sparc/kernel/of_device_common.h |   36 +++++++
 5 files changed, 199 insertions(+), 345 deletions(-)

diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index 53adcaa..ef902e7 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -37,6 +37,7 @@ obj-y                   += una_asm_$(BITS).o
 obj-$(CONFIG_SPARC32)   += muldiv.o
 obj-y                   += prom_common.o
 obj-y                   += prom_$(BITS).o
+obj-y                   += of_device_common.o
 obj-y                   += of_device_$(BITS).o
 obj-$(CONFIG_SPARC64)   += prom_irqtrans.o
 
diff --git a/arch/sparc/kernel/of_device_32.c b/arch/sparc/kernel/of_device_32.c
index 0a83bd7..9039670 100644
--- a/arch/sparc/kernel/of_device_32.c
+++ b/arch/sparc/kernel/of_device_32.c
@@ -6,159 +6,11 @@
 #include <linux/mod_devicetable.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
+#include <linux/irq.h>
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
 
-static int node_match(struct device *dev, void *data)
-{
-	struct of_device *op = to_of_device(dev);
-	struct device_node *dp = data;
-
-	return (op->node == dp);
-}
-
-struct of_device *of_find_device_by_node(struct device_node *dp)
-{
-	struct device *dev = bus_find_device(&of_platform_bus_type, NULL,
-					     dp, node_match);
-
-	if (dev)
-		return to_of_device(dev);
-
-	return NULL;
-}
-EXPORT_SYMBOL(of_find_device_by_node);
-
-unsigned int irq_of_parse_and_map(struct device_node *node, int index)
-{
-	struct of_device *op = of_find_device_by_node(node);
-
-	if (!op || index >= op->num_irqs)
-		return 0;
-
-	return op->irqs[index];
-}
-EXPORT_SYMBOL(irq_of_parse_and_map);
-
-/* Take the archdata values for IOMMU, STC, and HOSTDATA found in
- * BUS and propagate to all child of_device objects.
- */
-void of_propagate_archdata(struct of_device *bus)
-{
-	struct dev_archdata *bus_sd = &bus->dev.archdata;
-	struct device_node *bus_dp = bus->node;
-	struct device_node *dp;
-
-	for (dp = bus_dp->child; dp; dp = dp->sibling) {
-		struct of_device *op = of_find_device_by_node(dp);
-
-		op->dev.archdata.iommu = bus_sd->iommu;
-		op->dev.archdata.stc = bus_sd->stc;
-		op->dev.archdata.host_controller = bus_sd->host_controller;
-		op->dev.archdata.numa_node = bus_sd->numa_node;
-
-		if (dp->child)
-			of_propagate_archdata(op);
-	}
-}
-
-struct bus_type of_platform_bus_type;
-EXPORT_SYMBOL(of_platform_bus_type);
-
-static inline u64 of_read_addr(const u32 *cell, int size)
-{
-	u64 r = 0;
-	while (size--)
-		r = (r << 32) | *(cell++);
-	return r;
-}
-
-static void __init get_cells(struct device_node *dp,
-			     int *addrc, int *sizec)
-{
-	if (addrc)
-		*addrc = of_n_addr_cells(dp);
-	if (sizec)
-		*sizec = of_n_size_cells(dp);
-}
-
-/* Max address size we deal with */
-#define OF_MAX_ADDR_CELLS	4
-
-struct of_bus {
-	const char	*name;
-	const char	*addr_prop_name;
-	int		(*match)(struct device_node *parent);
-	void		(*count_cells)(struct device_node *child,
-				       int *addrc, int *sizec);
-	int		(*map)(u32 *addr, const u32 *range,
-			       int na, int ns, int pna);
-	unsigned long	(*get_flags)(const u32 *addr, unsigned long);
-};
-
-/*
- * Default translator (generic bus)
- */
-
-static void of_bus_default_count_cells(struct device_node *dev,
-				       int *addrc, int *sizec)
-{
-	get_cells(dev, addrc, sizec);
-}
-
-/* Make sure the least significant 64-bits are in-range.  Even
- * for 3 or 4 cell values it is a good enough approximation.
- */
-static int of_out_of_range(const u32 *addr, const u32 *base,
-			   const u32 *size, int na, int ns)
-{
-	u64 a = of_read_addr(addr, na);
-	u64 b = of_read_addr(base, na);
-
-	if (a < b)
-		return 1;
-
-	b += of_read_addr(size, ns);
-	if (a >= b)
-		return 1;
-
-	return 0;
-}
-
-static int of_bus_default_map(u32 *addr, const u32 *range,
-			      int na, int ns, int pna)
-{
-	u32 result[OF_MAX_ADDR_CELLS];
-	int i;
-
-	if (ns > 2) {
-		printk("of_device: Cannot handle size cells (%d) > 2.", ns);
-		return -EINVAL;
-	}
-
-	if (of_out_of_range(addr, range, range + na + pna, na, ns))
-		return -EINVAL;
-
-	/* Start with the parent range base.  */
-	memcpy(result, range + na, pna * 4);
-
-	/* Add in the child address offset.  */
-	for (i = 0; i < na; i++)
-		result[pna - 1 - i] +=
-			(addr[na - 1 - i] -
-			 range[na - 1 - i]);
-
-	memcpy(addr, result, pna * 4);
-
-	return 0;
-}
-
-static unsigned long of_bus_default_get_flags(const u32 *addr, unsigned long flags)
-{
-	if (flags)
-		return flags;
-	return IORESOURCE_MEM;
-}
+#include "of_device_common.h"
 
 /*
  * PCI bus specific translator
@@ -240,30 +92,6 @@ static unsigned long of_bus_pci_get_flags(const u32 *addr, unsigned long flags)
 	return flags;
 }
 
-/*
- * SBUS bus specific translator
- */
-
-static int of_bus_sbus_match(struct device_node *np)
-{
-	return !strcmp(np->name, "sbus") ||
-		!strcmp(np->name, "sbi");
-}
-
-static void of_bus_sbus_count_cells(struct device_node *child,
-				   int *addrc, int *sizec)
-{
-	if (addrc)
-		*addrc = 2;
-	if (sizec)
-		*sizec = 1;
-}
-
-static int of_bus_sbus_map(u32 *addr, const u32 *range, int na, int ns, int pna)
-{
-	return of_bus_default_map(addr, range, na, ns, pna);
-}
-
 static unsigned long of_bus_sbus_get_flags(const u32 *addr, unsigned long flags)
 {
 	return IORESOURCE_MEM;
@@ -290,7 +118,7 @@ static struct of_bus of_busses[] = {
 		.addr_prop_name = "reg",
 		.match = of_bus_sbus_match,
 		.count_cells = of_bus_sbus_count_cells,
-		.map = of_bus_sbus_map,
+		.map = of_bus_default_map,
 		.get_flags = of_bus_sbus_get_flags,
 	},
 	/* Default */
diff --git a/arch/sparc/kernel/of_device_64.c b/arch/sparc/kernel/of_device_64.c
index b4a12c9..881947e 100644
--- a/arch/sparc/kernel/of_device_64.c
+++ b/arch/sparc/kernel/of_device_64.c
@@ -10,6 +10,8 @@
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
 
+#include "of_device_common.h"
+
 void __iomem *of_ioremap(struct resource *res, unsigned long offset, unsigned long size, char *name)
 {
 	unsigned long ret = res->start + offset;
@@ -35,157 +37,6 @@ void of_iounmap(struct resource *res, void __iomem *base, unsigned long size)
 }
 EXPORT_SYMBOL(of_iounmap);
 
-static int node_match(struct device *dev, void *data)
-{
-	struct of_device *op = to_of_device(dev);
-	struct device_node *dp = data;
-
-	return (op->node == dp);
-}
-
-struct of_device *of_find_device_by_node(struct device_node *dp)
-{
-	struct device *dev = bus_find_device(&of_platform_bus_type, NULL,
-					     dp, node_match);
-
-	if (dev)
-		return to_of_device(dev);
-
-	return NULL;
-}
-EXPORT_SYMBOL(of_find_device_by_node);
-
-unsigned int irq_of_parse_and_map(struct device_node *node, int index)
-{
-	struct of_device *op = of_find_device_by_node(node);
-
-	if (!op || index >= op->num_irqs)
-		return 0;
-
-	return op->irqs[index];
-}
-EXPORT_SYMBOL(irq_of_parse_and_map);
-
-/* Take the archdata values for IOMMU, STC, and HOSTDATA found in
- * BUS and propagate to all child of_device objects.
- */
-void of_propagate_archdata(struct of_device *bus)
-{
-	struct dev_archdata *bus_sd = &bus->dev.archdata;
-	struct device_node *bus_dp = bus->node;
-	struct device_node *dp;
-
-	for (dp = bus_dp->child; dp; dp = dp->sibling) {
-		struct of_device *op = of_find_device_by_node(dp);
-
-		op->dev.archdata.iommu = bus_sd->iommu;
-		op->dev.archdata.stc = bus_sd->stc;
-		op->dev.archdata.host_controller = bus_sd->host_controller;
-		op->dev.archdata.numa_node = bus_sd->numa_node;
-
-		if (dp->child)
-			of_propagate_archdata(op);
-	}
-}
-
-struct bus_type of_platform_bus_type;
-EXPORT_SYMBOL(of_platform_bus_type);
-
-static inline u64 of_read_addr(const u32 *cell, int size)
-{
-	u64 r = 0;
-	while (size--)
-		r = (r << 32) | *(cell++);
-	return r;
-}
-
-static void __init get_cells(struct device_node *dp,
-			     int *addrc, int *sizec)
-{
-	if (addrc)
-		*addrc = of_n_addr_cells(dp);
-	if (sizec)
-		*sizec = of_n_size_cells(dp);
-}
-
-/* Max address size we deal with */
-#define OF_MAX_ADDR_CELLS	4
-
-struct of_bus {
-	const char	*name;
-	const char	*addr_prop_name;
-	int		(*match)(struct device_node *parent);
-	void		(*count_cells)(struct device_node *child,
-				       int *addrc, int *sizec);
-	int		(*map)(u32 *addr, const u32 *range,
-			       int na, int ns, int pna);
-	unsigned long	(*get_flags)(const u32 *addr, unsigned long);
-};
-
-/*
- * Default translator (generic bus)
- */
-
-static void of_bus_default_count_cells(struct device_node *dev,
-				       int *addrc, int *sizec)
-{
-	get_cells(dev, addrc, sizec);
-}
-
-/* Make sure the least significant 64-bits are in-range.  Even
- * for 3 or 4 cell values it is a good enough approximation.
- */
-static int of_out_of_range(const u32 *addr, const u32 *base,
-			   const u32 *size, int na, int ns)
-{
-	u64 a = of_read_addr(addr, na);
-	u64 b = of_read_addr(base, na);
-
-	if (a < b)
-		return 1;
-
-	b += of_read_addr(size, ns);
-	if (a >= b)
-		return 1;
-
-	return 0;
-}
-
-static int of_bus_default_map(u32 *addr, const u32 *range,
-			      int na, int ns, int pna)
-{
-	u32 result[OF_MAX_ADDR_CELLS];
-	int i;
-
-	if (ns > 2) {
-		printk("of_device: Cannot handle size cells (%d) > 2.", ns);
-		return -EINVAL;
-	}
-
-	if (of_out_of_range(addr, range, range + na + pna, na, ns))
-		return -EINVAL;
-
-	/* Start with the parent range base.  */
-	memcpy(result, range + na, pna * 4);
-
-	/* Add in the child address offset.  */
-	for (i = 0; i < na; i++)
-		result[pna - 1 - i] +=
-			(addr[na - 1 - i] -
-			 range[na - 1 - i]);
-
-	memcpy(addr, result, pna * 4);
-
-	return 0;
-}
-
-static unsigned long of_bus_default_get_flags(const u32 *addr, unsigned long flags)
-{
-	if (flags)
-		return flags;
-	return IORESOURCE_MEM;
-}
-
 /*
  * PCI bus specific translator
  */
@@ -296,25 +147,6 @@ static unsigned long of_bus_pci_get_flags(const u32 *addr, unsigned long flags)
 }
 
 /*
- * SBUS bus specific translator
- */
-
-static int of_bus_sbus_match(struct device_node *np)
-{
-	return !strcmp(np->name, "sbus") ||
-		!strcmp(np->name, "sbi");
-}
-
-static void of_bus_sbus_count_cells(struct device_node *child,
-				   int *addrc, int *sizec)
-{
-	if (addrc)
-		*addrc = 2;
-	if (sizec)
-		*sizec = 1;
-}
-
-/*
  * FHC/Central bus specific translator.
  *
  * This is just needed to hard-code the address and size cell
diff --git a/arch/sparc/kernel/of_device_common.c b/arch/sparc/kernel/of_device_common.c
new file mode 100644
index 0000000..40b34a8
--- /dev/null
+++ b/arch/sparc/kernel/of_device_common.c
@@ -0,0 +1,157 @@
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/slab.h>
+#include <linux/errno.h>
+#include <linux/irq.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+
+#include "of_device_common.h"
+
+static int node_match(struct device *dev, void *data)
+{
+	struct of_device *op = to_of_device(dev);
+	struct device_node *dp = data;
+
+	return (op->node == dp);
+}
+
+struct of_device *of_find_device_by_node(struct device_node *dp)
+{
+	struct device *dev = bus_find_device(&of_platform_bus_type, NULL,
+					     dp, node_match);
+
+	if (dev)
+		return to_of_device(dev);
+
+	return NULL;
+}
+EXPORT_SYMBOL(of_find_device_by_node);
+
+unsigned int irq_of_parse_and_map(struct device_node *node, int index)
+{
+	struct of_device *op = of_find_device_by_node(node);
+
+	if (!op || index >= op->num_irqs)
+		return 0;
+
+	return op->irqs[index];
+}
+EXPORT_SYMBOL(irq_of_parse_and_map);
+
+/* Take the archdata values for IOMMU, STC, and HOSTDATA found in
+ * BUS and propagate to all child of_device objects.
+ */
+void of_propagate_archdata(struct of_device *bus)
+{
+	struct dev_archdata *bus_sd = &bus->dev.archdata;
+	struct device_node *bus_dp = bus->node;
+	struct device_node *dp;
+
+	for (dp = bus_dp->child; dp; dp = dp->sibling) {
+		struct of_device *op = of_find_device_by_node(dp);
+
+		op->dev.archdata.iommu = bus_sd->iommu;
+		op->dev.archdata.stc = bus_sd->stc;
+		op->dev.archdata.host_controller = bus_sd->host_controller;
+		op->dev.archdata.numa_node = bus_sd->numa_node;
+
+		if (dp->child)
+			of_propagate_archdata(op);
+	}
+}
+
+struct bus_type of_platform_bus_type;
+EXPORT_SYMBOL(of_platform_bus_type);
+
+static void __init get_cells(struct device_node *dp,
+			     int *addrc, int *sizec)
+{
+	if (addrc)
+		*addrc = of_n_addr_cells(dp);
+	if (sizec)
+		*sizec = of_n_size_cells(dp);
+}
+
+/*
+ * Default translator (generic bus)
+ */
+
+void of_bus_default_count_cells(struct device_node *dev, int *addrc, int *sizec)
+{
+	get_cells(dev, addrc, sizec);
+}
+
+/* Make sure the least significant 64-bits are in-range.  Even
+ * for 3 or 4 cell values it is a good enough approximation.
+ */
+int of_out_of_range(const u32 *addr, const u32 *base,
+		    const u32 *size, int na, int ns)
+{
+	u64 a = of_read_addr(addr, na);
+	u64 b = of_read_addr(base, na);
+
+	if (a < b)
+		return 1;
+
+	b += of_read_addr(size, ns);
+	if (a >= b)
+		return 1;
+
+	return 0;
+}
+
+int of_bus_default_map(u32 *addr, const u32 *range, int na, int ns, int pna)
+{
+	u32 result[OF_MAX_ADDR_CELLS];
+	int i;
+
+	if (ns > 2) {
+		printk("of_device: Cannot handle size cells (%d) > 2.", ns);
+		return -EINVAL;
+	}
+
+	if (of_out_of_range(addr, range, range + na + pna, na, ns))
+		return -EINVAL;
+
+	/* Start with the parent range base.  */
+	memcpy(result, range + na, pna * 4);
+
+	/* Add in the child address offset.  */
+	for (i = 0; i < na; i++)
+		result[pna - 1 - i] +=
+			(addr[na - 1 - i] -
+			 range[na - 1 - i]);
+
+	memcpy(addr, result, pna * 4);
+
+	return 0;
+}
+
+unsigned long of_bus_default_get_flags(const u32 *addr, unsigned long flags)
+{
+	if (flags)
+		return flags;
+	return IORESOURCE_MEM;
+}
+
+/*
+ * SBUS bus specific translator
+ */
+
+int of_bus_sbus_match(struct device_node *np)
+{
+	return !strcmp(np->name, "sbus") || !strcmp(np->name, "sbi");
+}
+
+void of_bus_sbus_count_cells(struct device_node *child, int *addrc, int *sizec)
+{
+	if (addrc)
+		*addrc = 2;
+	if (sizec)
+		*sizec = 1;
+}
diff --git a/arch/sparc/kernel/of_device_common.h b/arch/sparc/kernel/of_device_common.h
new file mode 100644
index 0000000..cdfd239
--- /dev/null
+++ b/arch/sparc/kernel/of_device_common.h
@@ -0,0 +1,36 @@
+#ifndef _OF_DEVICE_COMMON_H
+#define _OF_DEVICE_COMMON_H
+
+static inline u64 of_read_addr(const u32 *cell, int size)
+{
+	u64 r = 0;
+	while (size--)
+		r = (r << 32) | *(cell++);
+	return r;
+}
+
+void of_bus_default_count_cells(struct device_node *dev, int *addrc,
+				int *sizec);
+int of_out_of_range(const u32 *addr, const u32 *base,
+		    const u32 *size, int na, int ns);
+int of_bus_default_map(u32 *addr, const u32 *range, int na, int ns, int pna);
+unsigned long of_bus_default_get_flags(const u32 *addr, unsigned long flags);
+
+int of_bus_sbus_match(struct device_node *np);
+void of_bus_sbus_count_cells(struct device_node *child, int *addrc, int *sizec);
+
+/* Max address size we deal with */
+#define OF_MAX_ADDR_CELLS	4
+
+struct of_bus {
+	const char	*name;
+	const char	*addr_prop_name;
+	int		(*match)(struct device_node *parent);
+	void		(*count_cells)(struct device_node *child,
+				       int *addrc, int *sizec);
+	int		(*map)(u32 *addr, const u32 *range,
+			       int na, int ns, int pna);
+	unsigned long	(*get_flags)(const u32 *addr, unsigned long);
+};
+
+#endif /* _OF_DEVICE_COMMON_H */

--------------040507020100000001030403--
