From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 24 Nov 2009 08:18:48 +0000
Subject: [PATCH 05/11] of/flattree: merge early_init_dt_scan_chosen()
Message-Id: <20091124081840.6216.49419.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
References: <20091124081316.6216.66310.stgit@angua>
In-Reply-To: <20091124081316.6216.66310.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au, benh@kernel.crashing.org, sfr@canb.auug.org.au, dave

Merge common code between PowerPC and Microblaze.  This patch
splits the arch-specific stuff out into a new function,
early_init_dt_scan_chosen_arch().

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/microblaze/kernel/prom.c |   44 ++-------------------------------------
 arch/powerpc/kernel/prom.c    |   46 +++++++++--------------------------------
 drivers/of/fdt.c              |   38 ++++++++++++++++++++++++++++++++++
 include/linux/of_fdt.h        |    3 +++
 4 files changed, 53 insertions(+), 78 deletions(-)

diff --git a/arch/microblaze/kernel/prom.c b/arch/microblaze/kernel/prom.c
index 7760186..7ee021f 100644
--- a/arch/microblaze/kernel/prom.c
+++ b/arch/microblaze/kernel/prom.c
@@ -108,49 +108,9 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 	return 0;
 }
 
-static int __init early_init_dt_scan_chosen(unsigned long node,
-				const char *uname, int depth, void *data)
+void __init early_init_dt_scan_chosen_arch(unsigned long node)
 {
-	unsigned long l;
-	char *p;
-
-	pr_debug("search \"chosen\", depth: %d, uname: %s\n", depth, uname);
-
-	if (depth != 1 ||
-		(strcmp(uname, "chosen") != 0 &&
-				strcmp(uname, "chosen@0") != 0))
-		return 0;
-
-#ifdef CONFIG_KEXEC
-	lprop = (u64 *)of_get_flat_dt_prop(node,
-				"linux,crashkernel-base", NULL);
-	if (lprop)
-		crashk_res.start = *lprop;
-
-	lprop = (u64 *)of_get_flat_dt_prop(node,
-				"linux,crashkernel-size", NULL);
-	if (lprop)
-		crashk_res.end = crashk_res.start + *lprop - 1;
-#endif
-
-	early_init_dt_check_for_initrd(node);
-
-	/* Retreive command line */
-	p = of_get_flat_dt_prop(node, "bootargs", &l);
-	if (p != NULL && l > 0)
-		strlcpy(cmd_line, p, min((int)l, COMMAND_LINE_SIZE));
-
-#ifdef CONFIG_CMDLINE
-#ifndef CONFIG_CMDLINE_FORCE
-	if (p = NULL || l = 0 || (l = 1 && (*p) = 0))
-#endif
-		strlcpy(cmd_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
-#endif /* CONFIG_CMDLINE */
-
-	pr_debug("Command line is: %s\n", cmd_line);
-
-	/* break now */
-	return 1;
+	/* No Microblaze specific code here */
 }
 
 static int __init early_init_dt_scan_memory(unsigned long node,
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 43cdba2..2c7d4a3 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -367,18 +367,9 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 	return 0;
 }
 
-static int __init early_init_dt_scan_chosen(unsigned long node,
-					    const char *uname, int depth, void *data)
+void __init early_init_dt_scan_chosen_arch(unsigned long node)
 {
 	unsigned long *lprop;
-	unsigned long l;
-	char *p;
-
-	DBG("search \"chosen\", depth: %d, uname: %s\n", depth, uname);
-
-	if (depth != 1 ||
-	    (strcmp(uname, "chosen") != 0 && strcmp(uname, "chosen@0") != 0))
-		return 0;
 
 #ifdef CONFIG_PPC64
 	/* check if iommu is forced on or off */
@@ -389,17 +380,17 @@ static int __init early_init_dt_scan_chosen(unsigned long node,
 #endif
 
 	/* mem=x on the command line is the preferred mechanism */
- 	lprop = of_get_flat_dt_prop(node, "linux,memory-limit", NULL);
- 	if (lprop)
- 		memory_limit = *lprop;
+	lprop = of_get_flat_dt_prop(node, "linux,memory-limit", NULL);
+	if (lprop)
+		memory_limit = *lprop;
 
 #ifdef CONFIG_PPC64
- 	lprop = of_get_flat_dt_prop(node, "linux,tce-alloc-start", NULL);
- 	if (lprop)
- 		tce_alloc_start = *lprop;
- 	lprop = of_get_flat_dt_prop(node, "linux,tce-alloc-end", NULL);
- 	if (lprop)
- 		tce_alloc_end = *lprop;
+	lprop = of_get_flat_dt_prop(node, "linux,tce-alloc-start", NULL);
+	if (lprop)
+		tce_alloc_start = *lprop;
+	lprop = of_get_flat_dt_prop(node, "linux,tce-alloc-end", NULL);
+	if (lprop)
+		tce_alloc_end = *lprop;
 #endif
 
 #ifdef CONFIG_KEXEC
@@ -411,23 +402,6 @@ static int __init early_init_dt_scan_chosen(unsigned long node,
 	if (lprop)
 		crashk_res.end = crashk_res.start + *lprop - 1;
 #endif
-
-	early_init_dt_check_for_initrd(node);
-
-	/* Retreive command line */
- 	p = of_get_flat_dt_prop(node, "bootargs", &l);
-	if (p != NULL && l > 0)
-		strlcpy(cmd_line, p, min((int)l, COMMAND_LINE_SIZE));
-
-#ifdef CONFIG_CMDLINE
-	if (p = NULL || l = 0 || (l = 1 && (*p) = 0))
-		strlcpy(cmd_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
-#endif /* CONFIG_CMDLINE */
-
-	DBG("Command line is: %s\n", cmd_line);
-
-	/* break now */
-	return 1;
 }
 
 #ifdef CONFIG_PPC_PSERIES
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index ebce509..616a476 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -15,6 +15,10 @@
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 
+#ifdef CONFIG_PPC
+#include <asm/machdep.h>
+#endif /* CONFIG_PPC */
+
 int __initdata dt_root_addr_cells;
 int __initdata dt_root_size_cells;
 
@@ -440,6 +444,40 @@ u64 __init dt_mem_next_cell(int s, u32 **cellp)
 	return of_read_number(p, s);
 }
 
+int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
+				     int depth, void *data)
+{
+	unsigned long l;
+	char *p;
+
+	pr_debug("search \"chosen\", depth: %d, uname: %s\n", depth, uname);
+
+	if (depth != 1 ||
+	    (strcmp(uname, "chosen") != 0 && strcmp(uname, "chosen@0") != 0))
+		return 0;
+
+	early_init_dt_check_for_initrd(node);
+
+	/* Retreive command line */
+	p = of_get_flat_dt_prop(node, "bootargs", &l);
+	if (p != NULL && l > 0)
+		strlcpy(cmd_line, p, min((int)l, COMMAND_LINE_SIZE));
+
+#ifdef CONFIG_CMDLINE
+#ifndef CONFIG_CMDLINE_FORCE
+	if (p = NULL || l = 0 || (l = 1 && (*p) = 0))
+#endif
+		strlcpy(cmd_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
+#endif /* CONFIG_CMDLINE */
+
+	early_init_dt_scan_chosen_arch(node);
+
+	pr_debug("Command line is: %s\n", cmd_line);
+
+	/* break now */
+	return 1;
+}
+
 /**
  * unflatten_device_tree - create tree of device_nodes from flat blob
  *
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index d1a37e5..8118d45 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -71,6 +71,9 @@ extern void *of_get_flat_dt_prop(unsigned long node, const char *name,
 				 unsigned long *size);
 extern int of_flat_dt_is_compatible(unsigned long node, const char *name);
 extern unsigned long of_get_flat_dt_root(void);
+extern void early_init_dt_scan_chosen_arch(unsigned long node);
+extern int early_init_dt_scan_chosen(unsigned long node, const char *uname,
+				     int depth, void *data);
 extern void early_init_dt_check_for_initrd(unsigned long node);
 extern u64 dt_mem_next_cell(int s, u32 **cellp);
 

