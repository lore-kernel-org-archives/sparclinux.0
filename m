From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 24 Nov 2009 08:19:01 +0000
Subject: [PATCH 06/11] of/flattree: merge early_init_devtree() and
Message-Id: <20091124081853.6216.68105.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
References: <20091124081316.6216.66310.stgit@angua>
In-Reply-To: <20091124081316.6216.66310.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au, benh@kernel.crashing.org, sfr@canb.auug.org.au, dave

Merge common code between Microblaze and PowerPC

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/microblaze/kernel/prom.c |   53 +++--------------------
 arch/powerpc/kernel/prom.c    |   94 +++--------------------------------------
 drivers/of/fdt.c              |   92 ++++++++++++++++++++++++++++++++++++++++
 include/linux/of_fdt.h        |    7 +++
 4 files changed, 115 insertions(+), 131 deletions(-)

diff --git a/arch/microblaze/kernel/prom.c b/arch/microblaze/kernel/prom.c
index 7ee021f..543465a 100644
--- a/arch/microblaze/kernel/prom.c
+++ b/arch/microblaze/kernel/prom.c
@@ -47,9 +47,8 @@ struct device_node *of_chosen;
 
 #define early_init_dt_scan_drconf_memory(node) 0
 
-static int __init early_init_dt_scan_cpus(unsigned long node,
-					  const char *uname, int depth,
-					  void *data)
+int __init early_init_dt_scan_cpus(unsigned long node, const char *uname,
+				   int depth, void *data)
 {
 	static int logical_cpuid;
 	char *type = of_get_flat_dt_prop(node, "device_type", NULL);
@@ -113,8 +112,8 @@ void __init early_init_dt_scan_chosen_arch(unsigned long node)
 	/* No Microblaze specific code here */
 }
 
-static int __init early_init_dt_scan_memory(unsigned long node,
-				const char *uname, int depth, void *data)
+int __init early_init_dt_scan_memory(unsigned long node, const char *uname,
+				     int depth, void *data)
 {
 	char *type = of_get_flat_dt_prop(node, "device_type", NULL);
 	u32 *reg, *endp;
@@ -201,7 +200,7 @@ static inline unsigned long phyp_dump_calculate_reserve_size(void)
  * without reserving anything. The memory in case of dump being
  * active is freed when the dump is collected (by userland tools).
  */
-static void __init phyp_dump_reserve_mem(void)
+void __init phyp_dump_reserve_mem(void)
 {
 	unsigned long base, size;
 	unsigned long variable_reserve_size;
@@ -240,7 +239,7 @@ static void __init phyp_dump_reserve_mem(void)
 	}
 }
 #else
-static inline void __init phyp_dump_reserve_mem(void) {}
+inline void __init phyp_dump_reserve_mem(void) {}
 #endif /* CONFIG_PHYP_DUMP  && CONFIG_PPC_RTAS */
 
 #ifdef CONFIG_EARLY_PRINTK
@@ -277,45 +276,9 @@ int __init early_uartlite_console(void)
 }
 #endif
 
-void __init early_init_devtree(void *params)
+void __init early_init_devtree_arch(void)
 {
-	pr_debug(" -> early_init_devtree(%p)\n", params);
-
-	/* Setup flat device-tree pointer */
-	initial_boot_params = params;
-
-#ifdef CONFIG_PHYP_DUMP
-	/* scan tree to see if dump occured during last boot */
-	of_scan_flat_dt(early_init_dt_scan_phyp_dump, NULL);
-#endif
-
-	/* Retrieve various informations from the /chosen node of the
-	 * device-tree, including the platform type, initrd location and
-	 * size, TCE reserve, and more ...
-	 */
-	of_scan_flat_dt(early_init_dt_scan_chosen, NULL);
-
-	/* Scan memory nodes and rebuild LMBs */
-	lmb_init();
-	of_scan_flat_dt(early_init_dt_scan_root, NULL);
-	of_scan_flat_dt(early_init_dt_scan_memory, NULL);
-
-	/* Save command line for /proc/cmdline and then parse parameters */
-	strlcpy(boot_command_line, cmd_line, COMMAND_LINE_SIZE);
-	parse_early_param();
-
-	lmb_analyze();
-
-	pr_debug("Phys. mem: %lx\n", (unsigned long) lmb_phys_mem_size());
-
-	pr_debug("Scanning CPUs ...\n");
-
-	/* Retreive CPU related informations from the flat tree
-	 * (altivec support, boot CPU ID, ...)
-	 */
-	of_scan_flat_dt(early_init_dt_scan_cpus, NULL);
-
-	pr_debug(" <- early_init_devtree()\n");
+	/* No Microblaze specific code here */
 }
 
 /**
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 2c7d4a3..a5b3b9d 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -84,33 +84,6 @@ static int __init early_parse_mem(char *p)
 }
 early_param("mem", early_parse_mem);
 
-/**
- * move_device_tree - move tree to an unused area, if needed.
- *
- * The device tree may be allocated beyond our memory limit, or inside the
- * crash kernel region for kdump. If so, move it out of the way.
- */
-static void __init move_device_tree(void)
-{
-	unsigned long start, size;
-	void *p;
-
-	DBG("-> move_device_tree\n");
-
-	start = __pa(initial_boot_params);
-	size = initial_boot_params->totalsize;
-
-	if ((memory_limit && (start + size) > memory_limit) ||
-			overlaps_crashkernel(start, size)) {
-		p = __va(lmb_alloc_base(size, PAGE_SIZE, lmb.rmo_size));
-		memcpy(p, initial_boot_params, size);
-		initial_boot_params = (struct boot_param_header *)p;
-		DBG("Moved device tree to 0x%p\n", p);
-	}
-
-	DBG("<- move_device_tree\n");
-}
-
 /*
  * ibm,pa-features is a per-cpu property that contains a string of
  * attribute descriptors, each of which has a 2 byte header plus up
@@ -267,9 +240,8 @@ static void __init check_cpu_feature_properties(unsigned long node)
 	}
 }
 
-static int __init early_init_dt_scan_cpus(unsigned long node,
-					  const char *uname, int depth,
-					  void *data)
+int __init early_init_dt_scan_cpus(unsigned long node, const char *uname,
+				   int depth, void *data)
 {
 	static int logical_cpuid = 0;
 	char *type = of_get_flat_dt_prop(node, "device_type", NULL);
@@ -483,8 +455,8 @@ static int __init early_init_dt_scan_drconf_memory(unsigned long node)
 #define early_init_dt_scan_drconf_memory(node)	0
 #endif /* CONFIG_PPC_PSERIES */
 
-static int __init early_init_dt_scan_memory(unsigned long node,
-					    const char *uname, int depth, void *data)
+int __init early_init_dt_scan_memory(unsigned long node, const char *uname,
+				     int depth, void *data)
 {
 	char *type = of_get_flat_dt_prop(node, "device_type", NULL);
 	u32 *reg, *endp;
@@ -543,7 +515,7 @@ static int __init early_init_dt_scan_memory(unsigned long node,
 	return 0;
 }
 
-static void __init early_reserve_mem(void)
+void __init early_reserve_mem(void)
 {
 	u64 base, size;
 	u64 *reserve_map;
@@ -635,7 +607,7 @@ static inline unsigned long phyp_dump_calculate_reserve_size(void)
  * without reserving anything. The memory in case of dump being
  * active is freed when the dump is collected (by userland tools).
  */
-static void __init phyp_dump_reserve_mem(void)
+void __init phyp_dump_reserve_mem(void)
 {
 	unsigned long base, size;
 	unsigned long variable_reserve_size;
@@ -674,44 +646,13 @@ static void __init phyp_dump_reserve_mem(void)
 	}
 }
 #else
-static inline void __init phyp_dump_reserve_mem(void) {}
+inline void __init phyp_dump_reserve_mem(void) {}
 #endif /* CONFIG_PHYP_DUMP  && CONFIG_PPC_RTAS */
 
-
-void __init early_init_devtree(void *params)
+void __init early_init_devtree_arch(void)
 {
 	phys_addr_t limit;
 
-	DBG(" -> early_init_devtree(%p)\n", params);
-
-	/* Setup flat device-tree pointer */
-	initial_boot_params = params;
-
-#ifdef CONFIG_PPC_RTAS
-	/* Some machines might need RTAS info for debugging, grab it now. */
-	of_scan_flat_dt(early_init_dt_scan_rtas, NULL);
-#endif
-
-#ifdef CONFIG_PHYP_DUMP
-	/* scan tree to see if dump occured during last boot */
-	of_scan_flat_dt(early_init_dt_scan_phyp_dump, NULL);
-#endif
-
-	/* Retrieve various informations from the /chosen node of the
-	 * device-tree, including the platform type, initrd location and
-	 * size, TCE reserve, and more ...
-	 */
-	of_scan_flat_dt(early_init_dt_scan_chosen, NULL);
-
-	/* Scan memory nodes and rebuild LMBs */
-	lmb_init();
-	of_scan_flat_dt(early_init_dt_scan_root, NULL);
-	of_scan_flat_dt(early_init_dt_scan_memory, NULL);
-
-	/* Save command line for /proc/cmdline and then parse parameters */
-	strlcpy(boot_command_line, cmd_line, COMMAND_LINE_SIZE);
-	parse_early_param();
-
 	/* Reserve LMB regions used by kernel, initrd, dt, etc... */
 	lmb_reserve(PHYSICAL_START, __pa(klimit) - PHYSICAL_START);
 	/* If relocatable, reserve first 32k for interrupt vectors etc. */
@@ -734,27 +675,8 @@ void __init early_init_devtree(void *params)
 			limit = memsize & PAGE_MASK;
 	}
 	lmb_enforce_memory_limit(limit);
-
-	lmb_analyze();
-	lmb_dump_all();
-
-	DBG("Phys. mem: %llx\n", lmb_phys_mem_size());
-
-	/* We may need to relocate the flat tree, do it now.
-	 * FIXME .. and the initrd too? */
-	move_device_tree();
-
-	DBG("Scanning CPUs ...\n");
-
-	/* Retreive CPU related informations from the flat tree
-	 * (altivec support, boot CPU ID, ...)
-	 */
-	of_scan_flat_dt(early_init_dt_scan_cpus, NULL);
-
-	DBG(" <- early_init_devtree()\n");
 }
 
-
 /**
  * Indicates whether the root node has a given value in its
  * compatible property.
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 616a476..6164781 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -16,7 +16,12 @@
 #include <linux/of_fdt.h>
 
 #ifdef CONFIG_PPC
+#include <asm/kexec.h>
 #include <asm/machdep.h>
+
+#ifdef CONFIG_PPC_RTAS
+#include <asm/rtas.h>
+#endif
 #endif /* CONFIG_PPC */
 
 int __initdata dt_root_addr_cells;
@@ -479,6 +484,93 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 }
 
 /**
+ * early_init_move_devtree - move tree to an unused area, if needed.
+ *
+ * The device tree may be allocated beyond our memory limit, or inside the
+ * crash kernel region for kdump. If so, move it out of the way.
+ */
+#if defined(CONFIG_PPC)
+static void __init early_init_move_devtree(void)
+{
+	unsigned long start, size;
+	void *p;
+
+	pr_debug("-> %s()\n", __func__);
+
+	start = __pa(initial_boot_params);
+	size = initial_boot_params->totalsize;
+
+	if ((memory_limit && (start + size) > memory_limit) ||
+			overlaps_crashkernel(start, size)) {
+		p = __va(lmb_alloc_base(size, PAGE_SIZE, lmb.rmo_size));
+		memcpy(p, initial_boot_params, size);
+		initial_boot_params = (struct boot_param_header *)p;
+		pr_debug("Moved device tree to 0x%p\n", p);
+	}
+
+	pr_debug("<- %s()\n", __func__);
+}
+#else
+static void __init early_init_move_devtree(void) {}
+#endif
+
+void __init early_init_devtree(void *params)
+{
+	pr_debug(" -> early_init_devtree(%p)\n", params);
+
+	/* Setup flat device-tree pointer */
+	initial_boot_params = params;
+
+#ifdef CONFIG_PPC_RTAS
+	/* Some machines might need RTAS info for debugging, grab it now. */
+	of_scan_flat_dt(early_init_dt_scan_rtas, NULL);
+#endif
+
+#ifdef CONFIG_PHYP_DUMP
+	/* scan tree to see if dump occured during last boot */
+	of_scan_flat_dt(early_init_dt_scan_phyp_dump, NULL);
+#endif
+
+	/* Retrieve various informations from the /chosen node of the
+	 * device-tree, including the platform type, initrd location and
+	 * size, TCE reserve, and more ...
+	 */
+	of_scan_flat_dt(early_init_dt_scan_chosen, NULL);
+
+	/* Scan memory nodes and rebuild LMBs */
+	lmb_init();
+	of_scan_flat_dt(early_init_dt_scan_root, NULL);
+	of_scan_flat_dt(early_init_dt_scan_memory, NULL);
+
+	/* Save command line for /proc/cmdline and then parse parameters */
+	strlcpy(boot_command_line, cmd_line, COMMAND_LINE_SIZE);
+	parse_early_param();
+
+	/* This is in an arbitrary spot, but it is temporary.  After all
+	 * the common code is merged, the structure of the early init
+	 * code will be reevaluated and refactored */
+	early_init_devtree_arch();
+
+	lmb_analyze();
+	lmb_dump_all();
+
+	pr_debug("Phys. mem: %llx\n", lmb_phys_mem_size());
+
+	/* We may need to relocate the flat tree, do it now.
+	 * FIXME .. and the initrd too? */
+	early_init_move_devtree();
+
+	pr_debug("Scanning CPUs ...\n");
+
+	/* Retreive CPU related informations from the flat tree
+	 * (altivec support, boot CPU ID, ...)
+	 */
+	of_scan_flat_dt(early_init_dt_scan_cpus, NULL);
+
+	pr_debug(" <- early_init_devtree()\n");
+}
+
+/**
  * unflatten_device_tree - create tree of device_nodes from flat blob
  *
  * unflattens the device-tree passed by the firmware, creating the
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index 8118d45..d1b1571 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -75,6 +75,13 @@ extern void early_init_dt_scan_chosen_arch(unsigned long node);
 extern int early_init_dt_scan_chosen(unsigned long node, const char *uname,
 				     int depth, void *data);
 extern void early_init_dt_check_for_initrd(unsigned long node);
+extern int early_init_dt_scan_cpus(unsigned long node, const char *uname,
+				   int depth, void *data);
+extern int early_init_dt_scan_memory(unsigned long node, const char *uname,
+				     int depth, void *data);
+extern void early_reserve_mem(void);
+extern void early_init_devtree_arch(void);
+extern void phyp_dump_reserve_mem(void);
 extern u64 dt_mem_next_cell(int s, u32 **cellp);
 
 /* Early flat tree scan hooks */

