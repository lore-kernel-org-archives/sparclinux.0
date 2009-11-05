From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 05 Nov 2009 07:46:51 +0000
Subject: [PATCH 08/11] of/flattree: Merge unflatten_device_tree
Message-Id: <20091105074643.10460.95772.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
References: <20091105073728.10460.6061.stgit@angua>
In-Reply-To: <20091105073728.10460.6061.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, benh@kernel.crashing.org, sfr@canb.auug.org.au, davem@davemloft.net, sparclinux@vger.kernel.org, monstr@monstr.eu

Merge common code between PowerPC and MicroBlaze

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/microblaze/include/asm/prom.h |    1 -
 arch/microblaze/kernel/prom.c      |   49 ----------------------------------
 arch/powerpc/kernel/prom.c         |   50 -----------------------------------
 drivers/of/fdt.c                   |   52 ++++++++++++++++++++++++++++++++++++
 include/linux/of.h                 |    3 ++
 include/linux/of_fdt.h             |    4 ---
 6 files changed, 55 insertions(+), 104 deletions(-)

diff --git a/arch/microblaze/include/asm/prom.h b/arch/microblaze/include/asm/prom.h
index ef3ec1d..07d1063 100644
--- a/arch/microblaze/include/asm/prom.h
+++ b/arch/microblaze/include/asm/prom.h
@@ -37,7 +37,6 @@ extern struct device_node *of_chosen;
 
 #define HAVE_ARCH_DEVTREE_FIXUPS
 
-extern struct device_node *allnodes;	/* temporary while merging */
 extern rwlock_t devtree_lock;	/* temporary while merging */
 
 /* For updating the device tree at runtime */
diff --git a/arch/microblaze/kernel/prom.c b/arch/microblaze/kernel/prom.c
index 021770a..901d538 100644
--- a/arch/microblaze/kernel/prom.c
+++ b/arch/microblaze/kernel/prom.c
@@ -50,55 +50,6 @@ typedef u32 cell_t;
 /* export that to outside world */
 struct device_node *of_chosen;
 
-/**
- * unflattens the device-tree passed by the firmware, creating the
- * tree of struct device_node. It also fills the "name" and "type"
- * pointers of the nodes so the normal device-tree walking functions
- * can be used (this used to be done by finish_device_tree)
- */
-void __init unflatten_device_tree(void)
-{
-	unsigned long start, mem, size;
-	struct device_node **allnextp = &allnodes;
-
-	pr_debug(" -> unflatten_device_tree()\n");
-
-	/* First pass, scan for size */
-	start = ((unsigned long)initial_boot_params) +
-		initial_boot_params->off_dt_struct;
-	size = unflatten_dt_node(0, &start, NULL, NULL, 0);
-	size = (size | 3) + 1;
-
-	pr_debug("  size is %lx, allocating...\n", size);
-
-	/* Allocate memory for the expanded device tree */
-	mem = lmb_alloc(size + 4, __alignof__(struct device_node));
-	mem = (unsigned long) __va(mem);
-
-	((u32 *)mem)[size / 4] = 0xdeadbeef;
-
-	pr_debug("  unflattening %lx...\n", mem);
-
-	/* Second pass, do actual unflattening */
-	start = ((unsigned long)initial_boot_params) +
-		initial_boot_params->off_dt_struct;
-	unflatten_dt_node(mem, &start, NULL, &allnextp, 0);
-	if (*((u32 *)start) != OF_DT_END)
-		printk(KERN_WARNING "Weird tag at end of tree: %08x\n",
-			*((u32 *)start));
-	if (((u32 *)mem)[size / 4] != 0xdeadbeef)
-		printk(KERN_WARNING "End of tree marker overwritten: %08x\n",
-			((u32 *)mem)[size / 4]);
-	*allnextp = NULL;
-
-	/* Get pointer to OF "/chosen" node for use everywhere */
-	of_chosen = of_find_node_by_path("/chosen");
-	if (of_chosen = NULL)
-		of_chosen = of_find_node_by_path("/chosen@0");
-
-	pr_debug(" <- unflatten_device_tree()\n");
-}
-
 #define early_init_dt_scan_drconf_memory(node) 0
 
 static int __init early_init_dt_scan_cpus(unsigned long node,
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index a102a0a..1280f34 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -73,8 +73,6 @@ unsigned long tce_alloc_start, tce_alloc_end;
 
 typedef u32 cell_t;
 
-extern struct device_node *allnodes;	/* temporary while merging */
-
 extern rwlock_t devtree_lock;	/* temporary while merging */
 
 /* export that to outside world */
@@ -119,54 +117,6 @@ static void __init move_device_tree(void)
 	DBG("<- move_device_tree\n");
 }
 
-/**
- * unflattens the device-tree passed by the firmware, creating the
- * tree of struct device_node. It also fills the "name" and "type"
- * pointers of the nodes so the normal device-tree walking functions
- * can be used (this used to be done by finish_device_tree)
- */
-void __init unflatten_device_tree(void)
-{
-	unsigned long start, mem, size;
-	struct device_node **allnextp = &allnodes;
-
-	DBG(" -> unflatten_device_tree()\n");
-
-	/* First pass, scan for size */
-	start = ((unsigned long)initial_boot_params) +
-		initial_boot_params->off_dt_struct;
-	size = unflatten_dt_node(0, &start, NULL, NULL, 0);
-	size = (size | 3) + 1;
-
-	DBG("  size is %lx, allocating...\n", size);
-
-	/* Allocate memory for the expanded device tree */
-	mem = lmb_alloc(size + 4, __alignof__(struct device_node));
-	mem = (unsigned long) __va(mem);
-
-	((u32 *)mem)[size / 4] = 0xdeadbeef;
-
-	DBG("  unflattening %lx...\n", mem);
-
-	/* Second pass, do actual unflattening */
-	start = ((unsigned long)initial_boot_params) +
-		initial_boot_params->off_dt_struct;
-	unflatten_dt_node(mem, &start, NULL, &allnextp, 0);
-	if (*((u32 *)start) != OF_DT_END)
-		printk(KERN_WARNING "Weird tag at end of tree: %08x\n", *((u32 *)start));
-	if (((u32 *)mem)[size / 4] != 0xdeadbeef)
-		printk(KERN_WARNING "End of tree marker overwritten: %08x\n",
-		       ((u32 *)mem)[size / 4] );
-	*allnextp = NULL;
-
-	/* Get pointer to OF "/chosen" node for use everywhere */
-	of_chosen = of_find_node_by_path("/chosen");
-	if (of_chosen = NULL)
-		of_chosen = of_find_node_by_path("/chosen@0");
-
-	DBG(" <- unflatten_device_tree()\n");
-}
-
 /*
  * ibm,pa-features is a per-cpu property that contains a string of
  * attribute descriptors, each of which has a 2 byte header plus up
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index df1ac8d..ad3a2b6 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -9,6 +9,8 @@
  * version 2 as published by the Free Software Foundation.
  */
 
+#include <linux/kernel.h>
+#include <linux/lmb.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 
@@ -367,3 +369,53 @@ unsigned long __init unflatten_dt_node(unsigned long mem,
 	*p += 4;
 	return mem;
 }
+
+/**
+ * unflatten_device_tree - create tree of device_nodes from flat blob
+ *
+ * unflattens the device-tree passed by the firmware, creating the
+ * tree of struct device_node. It also fills the "name" and "type"
+ * pointers of the nodes so the normal device-tree walking functions
+ * can be used.
+ */
+void __init unflatten_device_tree(void)
+{
+	unsigned long start, mem, size;
+	struct device_node **allnextp = &allnodes;
+
+	pr_debug(" -> unflatten_device_tree()\n");
+
+	/* First pass, scan for size */
+	start = ((unsigned long)initial_boot_params) +
+		initial_boot_params->off_dt_struct;
+	size = unflatten_dt_node(0, &start, NULL, NULL, 0);
+	size = (size | 3) + 1;
+
+	pr_debug("  size is %lx, allocating...\n", size);
+
+	/* Allocate memory for the expanded device tree */
+	mem = lmb_alloc(size + 4, __alignof__(struct device_node));
+	mem = (unsigned long) __va(mem);
+
+	((u32 *)mem)[size / 4] = 0xdeadbeef;
+
+	pr_debug("  unflattening %lx...\n", mem);
+
+	/* Second pass, do actual unflattening */
+	start = ((unsigned long)initial_boot_params) +
+		initial_boot_params->off_dt_struct;
+	unflatten_dt_node(mem, &start, NULL, &allnextp, 0);
+	if (*((u32 *)start) != OF_DT_END)
+		pr_warning("Weird tag at end of tree: %08x\n", *((u32 *)start));
+	if (((u32 *)mem)[size / 4] != 0xdeadbeef)
+		pr_warning("End of tree marker overwritten: %08x\n",
+			   ((u32 *)mem)[size / 4]);
+	*allnextp = NULL;
+
+	/* Get pointer to OF "/chosen" node for use everywhere */
+	of_chosen = of_find_node_by_path("/chosen");
+	if (of_chosen = NULL)
+		of_chosen = of_find_node_by_path("/chosen@0");
+
+	pr_debug(" <- unflatten_device_tree()\n");
+}
diff --git a/include/linux/of.h b/include/linux/of.h
index e7facd8..bec2157 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -63,6 +63,9 @@ struct device_node {
 #endif
 };
 
+/* Pointer for first entry in chain of all nodes. */
+extern struct device_node *allnodes;
+
 static inline int of_node_check_flag(struct device_node *n, unsigned long flag)
 {
 	return test_bit(flag, &n->_flags);
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index ace9068..81231e0 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -69,10 +69,6 @@ extern void *of_get_flat_dt_prop(unsigned long node, const char *name,
 				 unsigned long *size);
 extern int of_flat_dt_is_compatible(unsigned long node, const char *name);
 extern unsigned long of_get_flat_dt_root(void);
-extern unsigned long unflatten_dt_node(unsigned long mem, unsigned long *p,
-					struct device_node *dad,
-					struct device_node ***allnextpp,
-					unsigned long fpsize);
 
 /* Other Prototypes */
 extern void finish_device_tree(void);

