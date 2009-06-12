From: konrad@gaisler.com
Date: Fri, 12 Jun 2009 08:44:26 +0000
Subject: round2 [PATCH 5/6] Added support for AMBA bus. The device is a AMBA bus if it is a child of prom nod
Message-Id: <1244796266-7359-1-git-send-email-konrad@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Konrad Eisele <konrad@gaisler.com>

---
 arch/sparc/kernel/of_device_32.c |   37 +++++++++++++++++++++++++++++++++++++
 arch/sparc/kernel/prom_32.c      |   38 ++++++++++++++++++++++++++++++++++++++
 arch/sparc/kernel/prom_common.c  |   10 ++++++++--
 3 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/of_device_32.c b/arch/sparc/kernel/of_device_32.c
index 0a83bd7..185e068 100644
--- a/arch/sparc/kernel/of_device_32.c
+++ b/arch/sparc/kernel/of_device_32.c
@@ -8,6 +8,7 @@
 #include <linux/errno.h>
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
+#include <asm/leon.h>
 
 static int node_match(struct device *dev, void *data)
 {
@@ -269,6 +270,33 @@ static unsigned long of_bus_sbus_get_flags(const u32 *addr, unsigned long flags)
 	return IORESOURCE_MEM;
 }
 
+ /*
+ * AMBAPP bus specific translator
+ */
+
+int of_bus_ambapp_match(struct device_node *np)
+{
+	return !strcmp(np->name, "ambapp");
+}
+
+void of_bus_ambapp_count_cells(struct device_node *child,
+				      int *addrc, int *sizec)
+{
+	if (addrc)
+		*addrc = 1;
+	if (sizec)
+		*sizec = 1;
+}
+
+int of_bus_ambapp_map(u32 *addr, const u32 *range, int na, int ns, int pna)
+{
+	return of_bus_default_map(addr, range, na, ns, pna);
+}
+
+unsigned long of_bus_ambapp_get_flags(const u32 *addr, unsigned long flags)
+{
+	return IORESOURCE_MEM;
+}
 
 /*
  * Array of bus specific translators
@@ -293,6 +321,15 @@ static struct of_bus of_busses[] = {
 		.map = of_bus_sbus_map,
 		.get_flags = of_bus_sbus_get_flags,
 	},
+	/* AMBA */
+	{
+		.name = "ambapp",
+		.addr_prop_name = "reg",
+		.match = of_bus_ambapp_match,
+		.count_cells = of_bus_ambapp_count_cells,
+		.map = of_bus_ambapp_map,
+		.get_flags = of_bus_ambapp_get_flags,
+	},
 	/* Default */
 	{
 		.name = "default",
diff --git a/arch/sparc/kernel/prom_32.c b/arch/sparc/kernel/prom_32.c
index fe43e80..5aee484 100644
--- a/arch/sparc/kernel/prom_32.c
+++ b/arch/sparc/kernel/prom_32.c
@@ -24,6 +24,7 @@
 
 #include <asm/prom.h>
 #include <asm/oplib.h>
+#include <asm/leon.h>
 
 #include "prom.h"
 
@@ -131,6 +132,39 @@ static void __init ebus_path_component(struct device_node *dp, char *tmp_buf)
 		regs->which_io, regs->phys_addr);
 }
 
+#ifdef CONFIG_SPARC_LEON
+
+/* "name@irq,addrlo" */
+static void __init ambapp_path_component(struct device_node *dp, char *tmp_buf)
+{
+	struct amba_prom_registers *regs; unsigned int *intr;
+	unsigned int *device, *vendor;
+	struct property *prop;
+
+	prop = of_find_property(dp, "reg", NULL);
+	if (!prop)
+		return;
+	regs = prop->value;
+	prop = of_find_property(dp, "interrupts", NULL);
+	if (!prop)
+		return;
+	intr = prop->value;
+	prop = of_find_property(dp, "vendor", NULL);
+	if (!prop)
+		return;
+	vendor = prop->value;
+	prop = of_find_property(dp, "device", NULL);
+	if (!prop)
+		return;
+	device = prop->value;
+
+	sprintf(tmp_buf, "%s:%d:%d@%x,%x",
+		dp->name, *vendor, *device,
+		*intr, regs->phys_addr);
+}
+
+#endif
+
 static void __init __build_path_component(struct device_node *dp, char *tmp_buf)
 {
 	struct device_node *parent = dp->parent;
@@ -143,6 +177,10 @@ static void __init __build_path_component(struct device_node *dp, char *tmp_buf)
 			return sbus_path_component(dp, tmp_buf);
 		if (!strcmp(parent->type, "ebus"))
 			return ebus_path_component(dp, tmp_buf);
+#ifdef CONFIG_SPARC_LEON
+		if (!strcmp(parent->type, "ambapp"))
+			return ambapp_path_component(dp, tmp_buf);
+#endif
 
 		/* "isa" is handled with platform naming */
 	}
diff --git a/arch/sparc/kernel/prom_common.c b/arch/sparc/kernel/prom_common.c
index 0fb5789..6f661ee 100644
--- a/arch/sparc/kernel/prom_common.c
+++ b/arch/sparc/kernel/prom_common.c
@@ -22,9 +22,12 @@
 #include <linux/of.h>
 #include <asm/prom.h>
 #include <asm/oplib.h>
+#include <asm/leon.h>
 
 #include "prom.h"
 
+void (*prom_build_more)(struct device_node *dp, struct device_node ***nextp);
+
 struct device_node *of_console_device;
 EXPORT_SYMBOL(of_console_device);
 
@@ -161,7 +164,7 @@ static struct property * __init build_one_prop(phandle node, char *prev,
 			name = prom_nextprop(node, prev, p->name);
 		}
 
-		if (strlen(name) = 0) {
+		if (!name || strlen(name) = 0) {
 			tmp = p;
 			return NULL;
 		}
@@ -242,7 +245,7 @@ static struct device_node * __init prom_create_node(phandle node,
 	return dp;
 }
 
-static char * __init build_full_name(struct device_node *dp)
+SPARC_LEON_STATIC char * __init build_full_name(struct device_node *dp)
 {
 	int len, ourlen, plen;
 	char *n;
@@ -289,6 +292,9 @@ static struct device_node * __init prom_build_tree(struct device_node *parent,
 
 		dp->child = prom_build_tree(dp, prom_getchild(node), nextp);
 
+		if (prom_build_more)
+			prom_build_more(dp, nextp);
+		
 		node = prom_getsibling(node);
 	}
 
-- 
1.6.3.2

