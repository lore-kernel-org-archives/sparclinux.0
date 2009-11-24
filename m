From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 24 Nov 2009 08:18:08 +0000
Subject: [PATCH 02/11] of/flattree: Merge earlyinit_dt_scan_root()
Message-Id: <20091124081800.6216.27311.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
References: <20091124081316.6216.66310.stgit@angua>
In-Reply-To: <20091124081316.6216.66310.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au, benh@kernel.crashing.org, sfr@canb.auug.org.au, dave

Merge common code between PowerPC and Microblaze

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/microblaze/kernel/prom.c |   23 -----------------------
 arch/powerpc/kernel/prom.c    |   24 ------------------------
 drivers/of/fdt.c              |   26 ++++++++++++++++++++++++++
 include/linux/of_fdt.h        |    6 ++++++
 4 files changed, 32 insertions(+), 47 deletions(-)

diff --git a/arch/microblaze/kernel/prom.c b/arch/microblaze/kernel/prom.c
index 7959495..189179a 100644
--- a/arch/microblaze/kernel/prom.c
+++ b/arch/microblaze/kernel/prom.c
@@ -42,9 +42,6 @@
 #include <asm/sections.h>
 #include <asm/pci-bridge.h>
 
-static int __initdata dt_root_addr_cells;
-static int __initdata dt_root_size_cells;
-
 typedef u32 cell_t;
 
 /* export that to outside world */
@@ -158,26 +155,6 @@ static int __init early_init_dt_scan_chosen(unsigned long node,
 	return 1;
 }
 
-static int __init early_init_dt_scan_root(unsigned long node,
-				const char *uname, int depth, void *data)
-{
-	u32 *prop;
-
-	if (depth != 0)
-		return 0;
-
-	prop = of_get_flat_dt_prop(node, "#size-cells", NULL);
-	dt_root_size_cells = (prop = NULL) ? 1 : *prop;
-	pr_debug("dt_root_size_cells = %x\n", dt_root_size_cells);
-
-	prop = of_get_flat_dt_prop(node, "#address-cells", NULL);
-	dt_root_addr_cells = (prop = NULL) ? 2 : *prop;
-	pr_debug("dt_root_addr_cells = %x\n", dt_root_addr_cells);
-
-	/* break now */
-	return 1;
-}
-
 static u64 __init dt_mem_next_cell(int s, cell_t **cellp)
 {
 	cell_t *p = *cellp;
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 1ecd6c6..78f65a4 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -61,10 +61,6 @@
 #define DBG(fmt...)
 #endif
 
-
-static int __initdata dt_root_addr_cells;
-static int __initdata dt_root_size_cells;
-
 #ifdef CONFIG_PPC64
 int __initdata iommu_is_off;
 int __initdata iommu_force_on;
@@ -436,26 +432,6 @@ static int __init early_init_dt_scan_chosen(unsigned long node,
 	return 1;
 }
 
-static int __init early_init_dt_scan_root(unsigned long node,
-					  const char *uname, int depth, void *data)
-{
-	u32 *prop;
-
-	if (depth != 0)
-		return 0;
-
-	prop = of_get_flat_dt_prop(node, "#size-cells", NULL);
-	dt_root_size_cells = (prop = NULL) ? 1 : *prop;
-	DBG("dt_root_size_cells = %x\n", dt_root_size_cells);
-
-	prop = of_get_flat_dt_prop(node, "#address-cells", NULL);
-	dt_root_addr_cells = (prop = NULL) ? 2 : *prop;
-	DBG("dt_root_addr_cells = %x\n", dt_root_addr_cells);
-	
-	/* break now */
-	return 1;
-}
-
 static u64 __init dt_mem_next_cell(int s, cell_t **cellp)
 {
 	cell_t *p = *cellp;
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 6ad98e8..be200be 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -15,6 +15,9 @@
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 
+int __initdata dt_root_addr_cells;
+int __initdata dt_root_size_cells;
+
 struct boot_param_header *initial_boot_params;
 
 char *find_flat_dt_string(u32 offset)
@@ -407,6 +410,29 @@ inline void early_init_dt_check_for_initrd(unsigned long node)
 #endif /* CONFIG_BLK_DEV_INITRD */
 
 /**
+ * early_init_dt_scan_root - fetch the top level address and size cells
+ */
+int __init early_init_dt_scan_root(unsigned long node, const char *uname,
+				   int depth, void *data)
+{
+	u32 *prop;
+
+	if (depth != 0)
+		return 0;
+
+	prop = of_get_flat_dt_prop(node, "#size-cells", NULL);
+	dt_root_size_cells = (prop = NULL) ? 1 : *prop;
+	pr_debug("dt_root_size_cells = %x\n", dt_root_size_cells);
+
+	prop = of_get_flat_dt_prop(node, "#address-cells", NULL);
+	dt_root_addr_cells = (prop = NULL) ? 2 : *prop;
+	pr_debug("dt_root_addr_cells = %x\n", dt_root_addr_cells);
+
+	/* break now */
+	return 1;
+}
+
+/**
  * unflatten_device_tree - create tree of device_nodes from flat blob
  *
  * unflattens the device-tree passed by the firmware, creating the
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index ec2db82..828c3cd 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -58,6 +58,8 @@ struct boot_param_header {
 };
 
 /* TBD: Temporary export of fdt globals - remove when code fully merged */
+extern int __initdata dt_root_addr_cells;
+extern int __initdata dt_root_size_cells;
 extern struct boot_param_header *initial_boot_params;
 
 /* For scanning the flat device-tree at boot time */
@@ -71,6 +73,10 @@ extern int of_flat_dt_is_compatible(unsigned long node, const char *name);
 extern unsigned long of_get_flat_dt_root(void);
 extern void early_init_dt_check_for_initrd(unsigned long node);
 
+/* Early flat tree scan hooks */
+extern int early_init_dt_scan_root(unsigned long node, const char *uname,
+				   int depth, void *data);
+
 /* Other Prototypes */
 extern void finish_device_tree(void);
 extern void unflatten_device_tree(void);

