From: David Miller <davem@davemloft.net>
Date: Fri, 22 Aug 2008 04:21:42 +0000
Subject: [PATCH 1/3]: sparc: Implement irq_of_parse_and_map() and
Message-Id: <20080821.212142.31324813.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080821.001017.261408123.davem@davemloft.net>
In-Reply-To: <20080821.001017.261408123.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@ozlabs.org
Cc: scottwood@freescale.com, paulus@samba.org, sparclinux@vger.kernel.org


sparc: Implement irq_of_parse_and_map() and irq_dispose_mapping().

This allows more OF layer code to be shared between powerpc and
sparc.

With feedback and suggestions from Anton Vorontsov.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/prom.h   |   10 ++++++++++
 arch/sparc/kernel/of_device.c   |   11 +++++++++++
 arch/sparc64/kernel/of_device.c |   11 +++++++++++
 3 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/prom.h b/arch/sparc/include/asm/prom.h
index fd55522..b44e0c7 100644
--- a/arch/sparc/include/asm/prom.h
+++ b/arch/sparc/include/asm/prom.h
@@ -94,6 +94,16 @@ static inline void of_node_put(struct device_node *node)
 {
 }
 
+/* These routines are here to provide compatibility with how powerpc
+ * handles IRQ mapping for OF device nodes.  We precompute and permanently
+ * register them in the of_device objects, whereas powerpc computes them
+ * on request.
+ */
+extern unsigned int irq_of_parse_and_map(struct device_node *node, int index);
+static inline void irq_dispose_mapping(unsigned int virq)
+{
+}
+
 /*
  * NB:  This is here while we transition from using asm/prom.h
  * to linux/of.h
diff --git a/arch/sparc/kernel/of_device.c b/arch/sparc/kernel/of_device.c
index cc4c235..aace71f 100644
--- a/arch/sparc/kernel/of_device.c
+++ b/arch/sparc/kernel/of_device.c
@@ -29,6 +29,17 @@ struct of_device *of_find_device_by_node(struct device_node *dp)
 }
 EXPORT_SYMBOL(of_find_device_by_node);
 
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
 #ifdef CONFIG_PCI
 struct bus_type ebus_bus_type;
 EXPORT_SYMBOL(ebus_bus_type);
diff --git a/arch/sparc64/kernel/of_device.c b/arch/sparc64/kernel/of_device.c
index f8b50cb..a30f2af 100644
--- a/arch/sparc64/kernel/of_device.c
+++ b/arch/sparc64/kernel/of_device.c
@@ -55,6 +55,17 @@ struct of_device *of_find_device_by_node(struct device_node *dp)
 }
 EXPORT_SYMBOL(of_find_device_by_node);
 
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
 #ifdef CONFIG_PCI
 struct bus_type ebus_bus_type;
 EXPORT_SYMBOL(ebus_bus_type);
-- 
1.5.6.5.GIT

