From: David Miller <davem@davemloft.net>
Date: Sat, 06 Dec 2008 03:05:34 +0000
Subject: [PATCH 13/14]: sparc: Move prom_build_devicetree() into
Message-Id: <20081205.190534.17855567.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc: Move prom_build_devicetree() into prom_common.c

To make this work we provide a dummy nop implementation
of of_fill_in_cpu_data() for sparc32.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/prom.h        |    8 +++-----
 arch/sparc/kernel/prom_32.c     |   20 ++------------------
 arch/sparc/kernel/prom_64.c     |   33 +++++++--------------------------
 arch/sparc/kernel/prom_common.c |   32 +++++++++++++++++++++++++++-----
 4 files changed, 39 insertions(+), 54 deletions(-)

diff --git a/arch/sparc/kernel/prom.h b/arch/sparc/kernel/prom.h
index dea8b91..0764b35 100644
--- a/arch/sparc/kernel/prom.h
+++ b/arch/sparc/kernel/prom.h
@@ -24,11 +24,9 @@ static inline int is_root_node(const struct device_node *dp)
 }
 
 extern char *build_path_component(struct device_node *dp);
+extern void of_console_init(void);
+extern void of_fill_in_cpu_data(void);
 
-extern struct device_node * __init prom_create_node(phandle node,
-						    struct device_node *parent);
+extern unsigned int prom_early_allocated;
 
-extern struct device_node * __init prom_build_tree(struct device_node *parent,
-						   phandle node,
-						   struct device_node ***nextp);
 #endif /* __PROM_H */
diff --git a/arch/sparc/kernel/prom_32.c b/arch/sparc/kernel/prom_32.c
index 75eb40b..5ad2012 100644
--- a/arch/sparc/kernel/prom_32.c
+++ b/arch/sparc/kernel/prom_32.c
@@ -27,8 +27,6 @@
 
 #include "prom.h"
 
-static unsigned int prom_early_allocated;
-
 void * __init prom_early_alloc(unsigned long size)
 {
 	void *ret;
@@ -179,7 +177,7 @@ EXPORT_SYMBOL(of_console_options);
 
 extern void restore_current(void);
 
-static void __init of_console_init(void)
+void __init of_console_init(void)
 {
 	char *msg = "OF stdout device is: %s\n";
 	struct device_node *dp;
@@ -297,20 +295,6 @@ static void __init of_console_init(void)
 	printk(msg, of_console_path);
 }
 
-void __init prom_build_devicetree(void)
+void __init of_fill_in_cpu_data(void)
 {
-	struct device_node **nextp;
-
-	allnodes = prom_create_node(prom_root_node, NULL);
-	allnodes->path_component_name = "";
-	allnodes->full_name = "/";
-
-	nextp = &allnodes->allnext;
-	allnodes->child = prom_build_tree(allnodes,
-					  prom_getchild(allnodes->node),
-					  &nextp);
-	of_console_init();
-
-	printk("PROM: Built device tree with %u bytes of memory.\n",
-	       prom_early_allocated);
 }
diff --git a/arch/sparc/kernel/prom_64.c b/arch/sparc/kernel/prom_64.c
index 0279811..3afb838 100644
--- a/arch/sparc/kernel/prom_64.c
+++ b/arch/sparc/kernel/prom_64.c
@@ -32,8 +32,6 @@
 
 #include "prom.h"
 
-static unsigned int prom_early_allocated __initdata;
-
 void * __init prom_early_alloc(unsigned long size)
 {
 	unsigned long paddr = lmb_alloc(size, SMP_CACHE_BYTES);
@@ -401,11 +399,15 @@ struct device_node *of_find_node_by_cpuid(int cpuid)
 	return NULL;
 }
 
-static void __init of_fill_in_cpu_data(void)
+void __init of_fill_in_cpu_data(void)
 {
 	struct device_node *dp;
-	const char *mid_prop = get_mid_prop();
+	const char *mid_prop;
+
+	if (tlb_type = hypervisor)
+		return;
 
+	mid_prop = get_mid_prop();
 	ncpus_probed = 0;
 	for_each_node_by_type(dp, "cpu") {
 		int cpuid = of_getintprop_default(dp, mid_prop, -1);
@@ -533,7 +535,7 @@ EXPORT_SYMBOL(of_console_path);
 char *of_console_options;
 EXPORT_SYMBOL(of_console_options);
 
-static void __init of_console_init(void)
+void __init of_console_init(void)
 {
 	char *msg = "OF stdout device is: %s\n";
 	struct device_node *dp;
@@ -576,24 +578,3 @@ static void __init of_console_init(void)
 
 	printk(msg, of_console_path);
 }
-
-void __init prom_build_devicetree(void)
-{
-	struct device_node **nextp;
-
-	allnodes = prom_create_node(prom_root_node, NULL);
-	allnodes->path_component_name = "";
-	allnodes->full_name = "/";
-
-	nextp = &allnodes->allnext;
-	allnodes->child = prom_build_tree(allnodes,
-					  prom_getchild(allnodes->node),
-					  &nextp);
-	of_console_init();
-
-	printk("PROM: Built device tree with %u bytes of memory.\n",
-	       prom_early_allocated);
-
-	if (tlb_type != hypervisor)
-		of_fill_in_cpu_data();
-}
diff --git a/arch/sparc/kernel/prom_common.c b/arch/sparc/kernel/prom_common.c
index 3b5de2f..95e8e5d 100644
--- a/arch/sparc/kernel/prom_common.c
+++ b/arch/sparc/kernel/prom_common.c
@@ -216,8 +216,8 @@ static char * __init get_one_property(phandle node, const char *name)
 	return buf;
 }
 
-struct device_node * __init prom_create_node(phandle node,
-					     struct device_node *parent)
+static struct device_node * __init prom_create_node(phandle node,
+						    struct device_node *parent)
 {
 	struct device_node *dp;
 
@@ -261,9 +261,9 @@ static char * __init build_full_name(struct device_node *dp)
 	return n;
 }
 
-struct device_node * __init prom_build_tree(struct device_node *parent,
-					    phandle node,
-					    struct device_node ***nextp)
+static struct device_node * __init prom_build_tree(struct device_node *parent,
+						   phandle node,
+						   struct device_node ***nextp)
 {
 	struct device_node *ret = NULL, *prev_sibling = NULL;
 	struct device_node *dp;
@@ -293,3 +293,25 @@ struct device_node * __init prom_build_tree(struct device_node *parent,
 
 	return ret;
 }
+
+unsigned int prom_early_allocated __initdata;
+
+void __init prom_build_devicetree(void)
+{
+	struct device_node **nextp;
+
+	allnodes = prom_create_node(prom_root_node, NULL);
+	allnodes->path_component_name = "";
+	allnodes->full_name = "/";
+
+	nextp = &allnodes->allnext;
+	allnodes->child = prom_build_tree(allnodes,
+					  prom_getchild(allnodes->node),
+					  &nextp);
+	of_console_init();
+
+	printk("PROM: Built device tree with %u bytes of memory.\n",
+	       prom_early_allocated);
+
+	of_fill_in_cpu_data();
+}
-- 
1.5.6.5

