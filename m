From: konrad@gaisler.com
Date: Wed, 10 Jun 2009 10:19:21 +0000
Subject: [PATCH 5/7] Added support for AMBA bus. The device is a AMBA bus if
Message-Id: <1244629161-23939-1-git-send-email-konrad@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Konrad Eisele <konrad@gaisler.com>

> We use unconditional includes. The protection needs to be in the .h file
> as needed.
>

Done

>> +int of_bus_default_map(u32 *addr, const u32 *range,
>>  			      int na, int ns, int pna)
>>  {
> This is just too ugly.

Use a single SPARC_LEON_STATIC instead

>> +};
> We had this in leon.h too?

removed


> This file give me the impression that more effort could have been
> put into consolidating more of this code.
> David & Robert already did a gret effort for 32 + 64 bit sparc here.
> So please do not ruin it.
> 
> In these code path you need to justify each and every single
> use of ifdef/endif. What we have here is not good enough..
> 
> I know this is hard words but this stuff needs to be maintainable
> also in three years from now.
> 
I've done some rework. Now the only change is the callback:

		if (prom_build_more)
			prom_build_more(dp, nextp);

that is to be initialized if called. Is this acceptible?		


it is a child of prom node "ambapp" (AMBA plug and play).
Two functions leon_trans_init() and leon_node_init()
(defined in sparc/kernel/leon.c) are called in the
prom_build_tree() path if CONFIG_SPARC_LEON is defined.
leon_node_init() will build up the device tree using
AMBA plug and play.
---
 arch/sparc/kernel/of_device_32.c |   45 +++++++++++++++++++++++++++++++++++++-
 arch/sparc/kernel/prom_32.c      |   38 ++++++++++++++++++++++++++++++++
 arch/sparc/kernel/prom_common.c  |   10 +++++++-
 3 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/of_device_32.c b/arch/sparc/kernel/of_device_32.c
index 0a83bd7..e62daa2 100644
--- a/arch/sparc/kernel/of_device_32.c
+++ b/arch/sparc/kernel/of_device_32.c
@@ -8,6 +8,7 @@ #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
+#include <asm/leon.h>
 
 static int node_match(struct device *dev, void *data)
 {
@@ -125,7 +126,7 @@ static int of_out_of_range(const u32 *ad
 	return 0;
 }
 
-static int of_bus_default_map(u32 *addr, const u32 *range,
+SPARC_LEON_STATIC int of_bus_default_map(u32 *addr, const u32 *range,
 			      int na, int ns, int pna)
 {
 	u32 result[OF_MAX_ADDR_CELLS];
@@ -269,6 +270,37 @@ static unsigned long of_bus_sbus_get_fla
 	return IORESOURCE_MEM;
 }
 
+#ifdef CONFIG_SPARC_LEON
+
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
+
+#endif
 
 /*
  * Array of bus specific translators
@@ -293,6 +325,17 @@ static struct of_bus of_busses[] = {
 		.map = of_bus_sbus_map,
 		.get_flags = of_bus_sbus_get_flags,
 	},
+#ifdef CONFIG_SPARC_LEON
+	/* AMBA */
+	{
+		.name = "ambapp",
+		.addr_prop_name = "reg",
+		.match = of_bus_ambapp_match,
+		.count_cells = of_bus_ambapp_count_cells,
+		.map = of_bus_ambapp_map,
+		.get_flags = of_bus_ambapp_get_flags,
+	},
+#endif
 	/* Default */
 	{
 		.name = "default",
diff --git a/arch/sparc/kernel/prom_32.c b/arch/sparc/kernel/prom_32.c
index fe43e80..5aee484 100644
--- a/arch/sparc/kernel/prom_32.c
+++ b/arch/sparc/kernel/prom_32.c
@@ -24,6 +24,7 @@ #include <linux/module.h>
 
 #include <asm/prom.h>
 #include <asm/oplib.h>
+#include <asm/leon.h>
 
 #include "prom.h"
 
@@ -131,6 +132,39 @@ static void __init ebus_path_component(s
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
@@ -143,6 +177,10 @@ static void __init __build_path_componen
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
@@ -22,9 +22,12 @@ #include <linux/slab.h>
 #include <linux/of.h>
 #include <asm/prom.h>
 #include <asm/oplib.h>
+#include <asm/leon.h>
 
 #include "prom.h"
 
+void (*prom_build_more)(struct device_node *dp, struct device_node ***nextp);
+
 struct device_node *of_console_device;
 EXPORT_SYMBOL(of_console_device);
 
@@ -161,7 +164,7 @@ static struct property * __init build_on
 			name = prom_nextprop(node, prev, p->name);
 		}
 
-		if (strlen(name) = 0) {
+		if (!name || strlen(name) = 0) {
 			tmp = p;
 			return NULL;
 		}
@@ -242,7 +245,7 @@ static struct device_node * __init prom_
 	return dp;
 }
 
-static char * __init build_full_name(struct device_node *dp)
+SPARC_LEON_STATIC char * __init build_full_name(struct device_node *dp)
 {
 	int len, ourlen, plen;
 	char *n;
@@ -289,6 +292,9 @@ static struct device_node * __init prom_
 
 		dp->child = prom_build_tree(dp, prom_getchild(node), nextp);
 
+		if (prom_build_more)
+			prom_build_more(dp, nextp);
+		
 		node = prom_getsibling(node);
 	}
 
-- 
1.4.2.1

