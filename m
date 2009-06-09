From: Konrad Eisele <konrad@gaisler.com>
Date: Tue, 09 Jun 2009 11:22:14 +0000
Subject: [PATCH 5/7] Added support for AMBA bus
Message-Id: <4A2E45E6.1050506@gaisler.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------010208010901070001060008"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------010208010901070001060008
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

 From 1c076b182a3bc3e6c332df7c4f4436d69e7fa3b6 Mon Sep 17 00:00:00 2001
From: Konrad Eisele <konrad@gaisler.com>
Date: Tue, 9 Jun 2009 13:03:50 +0200
Subject: [PATCH 5/7] Added support for AMBA bus. The device is a AMBA bus if
it is a child of prom node "ambapp" (AMBA plug and play).
Two functions leon_trans_init() and leon_node_init()
(defined in sparc/kernel/leon.c) are called in the
prom_build_tree() path if CONFIG_LEON is defined.
leon_node_init() will build up the device tree using
AMBA plug and play.

Signed-off-by: Konrad Eisele <konrad@gaisler.com>
---
  arch/sparc/kernel/of_device_32.c |   50 +++++++++++++++++++++++++++++++++++++-
  arch/sparc/kernel/prom_32.c      |   42 ++++++++++++++++++++++++++++++++
  arch/sparc/kernel/prom_common.c  |   20 ++++++++++++++-
  3 files changed, 109 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/of_device_32.c b/arch/sparc/kernel/of_device_32.c
index 0a83bd7..1d1e75a 100644
--- a/arch/sparc/kernel/of_device_32.c
+++ b/arch/sparc/kernel/of_device_32.c
@@ -8,6 +8,9 @@ #include <linux/slab.h>
  #include <linux/errno.h>
  #include <linux/of_device.h>
  #include <linux/of_platform.h>
+#if defined(CONFIG_LEON)
+#include <asm/leon.h>
+#endif

  static int node_match(struct device *dev, void *data)
  {
@@ -125,7 +128,10 @@ static int of_out_of_range(const u32 *ad
  	return 0;
  }

-static int of_bus_default_map(u32 *addr, const u32 *range,
+#if !defined(CONFIG_LEON)
+static
+#endif
+int of_bus_default_map(u32 *addr, const u32 *range,
  			      int na, int ns, int pna)
  {
  	u32 result[OF_MAX_ADDR_CELLS];
@@ -269,6 +275,37 @@ static unsigned long of_bus_sbus_get_fla
  	return IORESOURCE_MEM;
  }

+#if defined(CONFIG_LEON)
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
@@ -293,6 +330,17 @@ static struct of_bus of_busses[] = {
  		.map = of_bus_sbus_map,
  		.get_flags = of_bus_sbus_get_flags,
  	},
+#if defined(CONFIG_LEON)
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
index fe43e80..308bd01 100644
--- a/arch/sparc/kernel/prom_32.c
+++ b/arch/sparc/kernel/prom_32.c
@@ -131,6 +131,44 @@ static void __init ebus_path_component(s
  		regs->which_io, regs->phys_addr);
  }

+#if defined(CONFIG_LEON)
+
+struct amba_prom_registers {
+	unsigned int phys_addr;	/* The physical address of this register */
+	unsigned int reg_size;	/* How many bytes does this register take up? */
+};
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
@@ -143,6 +181,10 @@ static void __init __build_path_componen
  			return sbus_path_component(dp, tmp_buf);
  		if (!strcmp(parent->type, "ebus"))
  			return ebus_path_component(dp, tmp_buf);
+#if defined(CONFIG_LEON)
+		if (!strcmp(parent->type, "ambapp"))
+			return ambapp_path_component(dp, tmp_buf);
+#endif

  		/* "isa" is handled with platform naming */
  	}
diff --git a/arch/sparc/kernel/prom_common.c b/arch/sparc/kernel/prom_common.c
index 0fb5789..d865b65 100644
--- a/arch/sparc/kernel/prom_common.c
+++ b/arch/sparc/kernel/prom_common.c
@@ -22,6 +22,11 @@ #include <linux/slab.h>
  #include <linux/of.h>
  #include <asm/prom.h>
  #include <asm/oplib.h>
+#if defined(CONFIG_LEON)
+extern void __init leon_trans_init(struct device_node *dp);
+extern void __init leon_node_init(struct device_node *dp,
+				  struct device_node ***nextp);
+#endif

  #include "prom.h"

@@ -161,7 +166,7 @@ static struct property * __init build_on
  			name = prom_nextprop(node, prev, p->name);
  		}

-		if (strlen(name) == 0) {
+		if (!name || strlen(name) == 0) {
  			tmp = p;
  			return NULL;
  		}
@@ -237,12 +242,19 @@ static struct device_node * __init prom_

  	dp->properties = build_prop_list(node);

+#if defined(CONFIG_LEON)
+	leon_trans_init(dp);
+#endif
  	irq_trans_init(dp);

  	return dp;
  }

-static char * __init build_full_name(struct device_node *dp)
+#if !defined(CONFIG_LEON)
+static
+#else
+char * __init build_full_name(struct device_node *dp)
+#endif
  {
  	int len, ourlen, plen;
  	char *n;
@@ -289,6 +301,10 @@ static struct device_node * __init prom_

  		dp->child = prom_build_tree(dp, prom_getchild(node), nextp);

+#if defined(CONFIG_LEON)
+		leon_node_init(dp, nextp);
+#endif
+
  		node = prom_getsibling(node);
  	}

-- 
1.4.2.1


--------------010208010901070001060008
Content-Type: text/plain;
 name="0005-Added-support-for-AMBA-bus.-The-device-is-a-AMBA-bus-if.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0005-Added-support-for-AMBA-bus.-The-device-is-a-AMBA-bus-if";
 filename*1=".txt"

From 1c076b182a3bc3e6c332df7c4f4436d69e7fa3b6 Mon Sep 17 00:00:00 2001
From: Konrad Eisele <konrad@gaisler.com>
Date: Tue, 9 Jun 2009 13:03:50 +0200
Subject: [PATCH 5/7] Added support for AMBA bus. The device is a AMBA bus if
it is a child of prom node "ambapp" (AMBA plug and play).
Two functions leon_trans_init() and leon_node_init()
(defined in sparc/kernel/leon.c) are called in the
prom_build_tree() path if CONFIG_LEON is defined.
leon_node_init() will build up the device tree using
AMBA plug and play.

Signed-off-by: Konrad Eisele <konrad@gaisler.com>
---
 arch/sparc/kernel/of_device_32.c |   50 +++++++++++++++++++++++++++++++++++++-
 arch/sparc/kernel/prom_32.c      |   42 ++++++++++++++++++++++++++++++++
 arch/sparc/kernel/prom_common.c  |   20 ++++++++++++++-
 3 files changed, 109 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/of_device_32.c b/arch/sparc/kernel/of_device_32.c
index 0a83bd7..1d1e75a 100644
--- a/arch/sparc/kernel/of_device_32.c
+++ b/arch/sparc/kernel/of_device_32.c
@@ -8,6 +8,9 @@ #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
+#if defined(CONFIG_LEON)
+#include <asm/leon.h>
+#endif
 
 static int node_match(struct device *dev, void *data)
 {
@@ -125,7 +128,10 @@ static int of_out_of_range(const u32 *ad
 	return 0;
 }
 
-static int of_bus_default_map(u32 *addr, const u32 *range,
+#if !defined(CONFIG_LEON)
+static
+#endif
+int of_bus_default_map(u32 *addr, const u32 *range,
 			      int na, int ns, int pna)
 {
 	u32 result[OF_MAX_ADDR_CELLS];
@@ -269,6 +275,37 @@ static unsigned long of_bus_sbus_get_fla
 	return IORESOURCE_MEM;
 }
 
+#if defined(CONFIG_LEON)
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
@@ -293,6 +330,17 @@ static struct of_bus of_busses[] = {
 		.map = of_bus_sbus_map,
 		.get_flags = of_bus_sbus_get_flags,
 	},
+#if defined(CONFIG_LEON)
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
index fe43e80..308bd01 100644
--- a/arch/sparc/kernel/prom_32.c
+++ b/arch/sparc/kernel/prom_32.c
@@ -131,6 +131,44 @@ static void __init ebus_path_component(s
 		regs->which_io, regs->phys_addr);
 }
 
+#if defined(CONFIG_LEON)
+
+struct amba_prom_registers {
+	unsigned int phys_addr;	/* The physical address of this register */
+	unsigned int reg_size;	/* How many bytes does this register take up? */
+};
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
@@ -143,6 +181,10 @@ static void __init __build_path_componen
 			return sbus_path_component(dp, tmp_buf);
 		if (!strcmp(parent->type, "ebus"))
 			return ebus_path_component(dp, tmp_buf);
+#if defined(CONFIG_LEON)
+		if (!strcmp(parent->type, "ambapp"))
+			return ambapp_path_component(dp, tmp_buf);
+#endif
 
 		/* "isa" is handled with platform naming */
 	}
diff --git a/arch/sparc/kernel/prom_common.c b/arch/sparc/kernel/prom_common.c
index 0fb5789..d865b65 100644
--- a/arch/sparc/kernel/prom_common.c
+++ b/arch/sparc/kernel/prom_common.c
@@ -22,6 +22,11 @@ #include <linux/slab.h>
 #include <linux/of.h>
 #include <asm/prom.h>
 #include <asm/oplib.h>
+#if defined(CONFIG_LEON)
+extern void __init leon_trans_init(struct device_node *dp);
+extern void __init leon_node_init(struct device_node *dp,
+				  struct device_node ***nextp);
+#endif
 
 #include "prom.h"
 
@@ -161,7 +166,7 @@ static struct property * __init build_on
 			name = prom_nextprop(node, prev, p->name);
 		}
 
-		if (strlen(name) == 0) {
+		if (!name || strlen(name) == 0) {
 			tmp = p;
 			return NULL;
 		}
@@ -237,12 +242,19 @@ static struct device_node * __init prom_
 
 	dp->properties = build_prop_list(node);
 
+#if defined(CONFIG_LEON)
+	leon_trans_init(dp);
+#endif
 	irq_trans_init(dp);
 
 	return dp;
 }
 
-static char * __init build_full_name(struct device_node *dp)
+#if !defined(CONFIG_LEON)
+static
+#else
+char * __init build_full_name(struct device_node *dp)
+#endif
 {
 	int len, ourlen, plen;
 	char *n;
@@ -289,6 +301,10 @@ static struct device_node * __init prom_
 
 		dp->child = prom_build_tree(dp, prom_getchild(node), nextp);
 
+#if defined(CONFIG_LEON)
+		leon_node_init(dp, nextp);
+#endif
+
 		node = prom_getsibling(node);
 	}
 
-- 
1.4.2.1


--------------010208010901070001060008--
