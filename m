From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:25:07 +0000
Subject: [PATCH 43/49]: sparc: Add OF archdata propagation helper.
Message-Id: <20080827.212507.25291469.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc: Add OF archdata propagation helper.

Add a helper function that, given a bus of_device node, propagates
all iommu, stc, and host_controller values down to the child nodes.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/of_device.h |    2 ++
 arch/sparc/kernel/of_device.c      |   22 ++++++++++++++++++++++
 arch/sparc64/kernel/of_device.c    |   22 ++++++++++++++++++++++
 3 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/of_device.h b/arch/sparc/include/asm/of_device.h
index bba777a..a5d9811 100644
--- a/arch/sparc/include/asm/of_device.h
+++ b/arch/sparc/include/asm/of_device.h
@@ -30,6 +30,8 @@ struct of_device
 extern void __iomem *of_ioremap(struct resource *res, unsigned long offset, unsigned long size, char *name);
 extern void of_iounmap(struct resource *res, void __iomem *base, unsigned long size);
 
+extern void of_propagate_archdata(struct of_device *bus);
+
 /* This is just here during the transition */
 #include <linux/of_platform.h>
 
diff --git a/arch/sparc/kernel/of_device.c b/arch/sparc/kernel/of_device.c
index aace71f..8fdc1b3 100644
--- a/arch/sparc/kernel/of_device.c
+++ b/arch/sparc/kernel/of_device.c
@@ -40,6 +40,28 @@ unsigned int irq_of_parse_and_map(struct device_node *node, int index)
 }
 EXPORT_SYMBOL(irq_of_parse_and_map);
 
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
 #ifdef CONFIG_PCI
 struct bus_type ebus_bus_type;
 EXPORT_SYMBOL(ebus_bus_type);
diff --git a/arch/sparc64/kernel/of_device.c b/arch/sparc64/kernel/of_device.c
index a30f2af..b22475f 100644
--- a/arch/sparc64/kernel/of_device.c
+++ b/arch/sparc64/kernel/of_device.c
@@ -66,6 +66,28 @@ unsigned int irq_of_parse_and_map(struct device_node *node, int index)
 }
 EXPORT_SYMBOL(irq_of_parse_and_map);
 
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
 #ifdef CONFIG_PCI
 struct bus_type ebus_bus_type;
 EXPORT_SYMBOL(ebus_bus_type);
-- 
1.5.6.5.GIT

