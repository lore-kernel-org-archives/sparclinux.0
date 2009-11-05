From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 05 Nov 2009 07:47:47 +0000
Subject: [PATCH 11/11] of/flattree: Merge early_init_dt_check_for_initrd()
Message-Id: <20091105074724.10460.4083.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
References: <20091105073728.10460.6061.stgit@angua>
In-Reply-To: <20091105073728.10460.6061.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, benh@kernel.crashing.org, sfr@canb.auug.org.au, davem@davemloft.net, sparclinux@vger.kernel.org, monstr@monstr.eu

Merge common code between PowerPC and Microblaze

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/microblaze/kernel/prom.c |   32 --------------------------------
 arch/powerpc/kernel/prom.c    |   30 ------------------------------
 drivers/of/fdt.c              |   37 +++++++++++++++++++++++++++++++++++++
 include/linux/of_fdt.h        |    1 +
 4 files changed, 38 insertions(+), 62 deletions(-)

diff --git a/arch/microblaze/kernel/prom.c b/arch/microblaze/kernel/prom.c
index a38e373..7959495 100644
--- a/arch/microblaze/kernel/prom.c
+++ b/arch/microblaze/kernel/prom.c
@@ -113,38 +113,6 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 	return 0;
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-static void __init early_init_dt_check_for_initrd(unsigned long node)
-{
-	unsigned long l;
-	u32 *prop;
-
-	pr_debug("Looking for initrd properties... ");
-
-	prop = of_get_flat_dt_prop(node, "linux,initrd-start", &l);
-	if (prop) {
-		initrd_start = (unsigned long)
-					__va((u32)of_read_ulong(prop, l/4));
-
-		prop = of_get_flat_dt_prop(node, "linux,initrd-end", &l);
-		if (prop) {
-			initrd_end = (unsigned long)
-					__va((u32)of_read_ulong(prop, 1/4));
-			initrd_below_start_ok = 1;
-		} else {
-			initrd_start = 0;
-		}
-	}
-
-	pr_debug("initrd_start=0x%lx  initrd_end=0x%lx\n",
-					initrd_start, initrd_end);
-}
-#else
-static inline void early_init_dt_check_for_initrd(unsigned long node)
-{
-}
-#endif /* CONFIG_BLK_DEV_INITRD */
-
 static int __init early_init_dt_scan_chosen(unsigned long node,
 				const char *uname, int depth, void *data)
 {
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 7f88566..1ecd6c6 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -373,36 +373,6 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 	return 0;
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-static void __init early_init_dt_check_for_initrd(unsigned long node)
-{
-	unsigned long l;
-	u32 *prop;
-
-	DBG("Looking for initrd properties... ");
-
-	prop = of_get_flat_dt_prop(node, "linux,initrd-start", &l);
-	if (prop) {
-		initrd_start = (unsigned long)__va(of_read_ulong(prop, l/4));
-
-		prop = of_get_flat_dt_prop(node, "linux,initrd-end", &l);
-		if (prop) {
-			initrd_end = (unsigned long)
-					__va(of_read_ulong(prop, l/4));
-			initrd_below_start_ok = 1;
-		} else {
-			initrd_start = 0;
-		}
-	}
-
-	DBG("initrd_start=0x%lx  initrd_end=0x%lx\n", initrd_start, initrd_end);
-}
-#else
-static inline void early_init_dt_check_for_initrd(unsigned long node)
-{
-}
-#endif /* CONFIG_BLK_DEV_INITRD */
-
 static int __init early_init_dt_scan_chosen(unsigned long node,
 					    const char *uname, int depth, void *data)
 {
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index ad3a2b6..3c58f10 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -11,6 +11,7 @@
 
 #include <linux/kernel.h>
 #include <linux/lmb.h>
+#include <linux/initrd.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 
@@ -370,6 +371,42 @@ unsigned long __init unflatten_dt_node(unsigned long mem,
 	return mem;
 }
 
+#ifdef CONFIG_BLK_DEV_INITRD
+/**
+ * early_init_dt_check_for_initrd - Decode initrd location from flat tree
+ * @node: reference to node containing initrd location ('chosen')
+ */
+void __init early_init_dt_check_for_initrd(unsigned long node)
+{
+	unsigned long len;
+	u32 *prop;
+
+	pr_debug("Looking for initrd properties... ");
+
+	prop = of_get_flat_dt_prop(node, "linux,initrd-start", &len);
+	if (prop) {
+		initrd_start = (unsigned long)
+				__va(of_read_ulong(prop, len/4));
+
+		prop = of_get_flat_dt_prop(node, "linux,initrd-end", &len);
+		if (prop) {
+			initrd_end = (unsigned long)
+				__va(of_read_ulong(prop, len/4));
+			initrd_below_start_ok = 1;
+		} else {
+			initrd_start = 0;
+		}
+	}
+
+	pr_debug("initrd_start=0x%lx  initrd_end=0x%lx\n",
+		 initrd_start, initrd_end);
+}
+#else
+inline void early_init_dt_check_for_initrd(unsigned long node)
+{
+}
+#endif /* CONFIG_BLK_DEV_INITRD */
+
 /**
  * unflatten_device_tree - create tree of device_nodes from flat blob
  *
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index 81231e0..ec2db82 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -69,6 +69,7 @@ extern void *of_get_flat_dt_prop(unsigned long node, const char *name,
 				 unsigned long *size);
 extern int of_flat_dt_is_compatible(unsigned long node, const char *name);
 extern unsigned long of_get_flat_dt_root(void);
+extern void early_init_dt_check_for_initrd(unsigned long node);
 
 /* Other Prototypes */
 extern void finish_device_tree(void);

