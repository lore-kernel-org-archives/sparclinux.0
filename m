From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 05 Nov 2009 07:45:35 +0000
Subject: [PATCH 02/11] of/flattree: merge of_scan_flat_dt
Message-Id: <20091105074527.10460.23877.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
References: <20091105073728.10460.6061.stgit@angua>
In-Reply-To: <20091105073728.10460.6061.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, benh@kernel.crashing.org, sfr@canb.auug.org.au, davem@davemloft.net, sparclinux@vger.kernel.org, monstr@monstr.eu

Merge common code between PowerPC and Microblaze
---

 arch/microblaze/kernel/prom.c |   61 --------------------------------------
 arch/powerpc/kernel/prom.c    |   61 --------------------------------------
 drivers/of/fdt.c              |   65 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 122 deletions(-)

diff --git a/arch/microblaze/kernel/prom.c b/arch/microblaze/kernel/prom.c
index 06d620a..0db8ee6 100644
--- a/arch/microblaze/kernel/prom.c
+++ b/arch/microblaze/kernel/prom.c
@@ -50,67 +50,6 @@ typedef u32 cell_t;
 /* export that to outside world */
 struct device_node *of_chosen;
 
-/**
- * This function is used to scan the flattened device-tree, it is
- * used to extract the memory informations at boot before we can
- * unflatten the tree
- */
-int __init of_scan_flat_dt(int (*it)(unsigned long node,
-				     const char *uname, int depth,
-				     void *data),
-			   void *data)
-{
-	unsigned long p = ((unsigned long)initial_boot_params) +
-		initial_boot_params->off_dt_struct;
-	int rc = 0;
-	int depth = -1;
-
-	do {
-		u32 tag = *((u32 *)p);
-		char *pathp;
-
-		p += 4;
-		if (tag = OF_DT_END_NODE) {
-			depth--;
-			continue;
-		}
-		if (tag = OF_DT_NOP)
-			continue;
-		if (tag = OF_DT_END)
-			break;
-		if (tag = OF_DT_PROP) {
-			u32 sz = *((u32 *)p);
-			p += 8;
-			if (initial_boot_params->version < 0x10)
-				p = _ALIGN(p, sz >= 8 ? 8 : 4);
-			p += sz;
-			p = _ALIGN(p, 4);
-			continue;
-		}
-		if (tag != OF_DT_BEGIN_NODE) {
-			printk(KERN_WARNING "Invalid tag %x scanning flattened"
-				" device tree !\n", tag);
-			return -EINVAL;
-		}
-		depth++;
-		pathp = (char *)p;
-		p = _ALIGN(p + strlen(pathp) + 1, 4);
-		if ((*pathp) = '/') {
-			char *lp, *np;
-			for (lp = NULL, np = pathp; *np; np++)
-				if ((*np) = '/')
-					lp = np+1;
-			if (lp != NULL)
-				pathp = lp;
-		}
-		rc = it(p, pathp, depth, data);
-		if (rc != 0)
-			break;
-	} while (1);
-
-	return rc;
-}
-
 unsigned long __init of_get_flat_dt_root(void)
 {
 	unsigned long p = ((unsigned long)initial_boot_params) +
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index fccf7e4..14a07b9 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -80,67 +80,6 @@ extern rwlock_t devtree_lock;	/* temporary while merging */
 /* export that to outside world */
 struct device_node *of_chosen;
 
-/**
- * This function is used to scan the flattened device-tree, it is
- * used to extract the memory informations at boot before we can
- * unflatten the tree
- */
-int __init of_scan_flat_dt(int (*it)(unsigned long node,
-				     const char *uname, int depth,
-				     void *data),
-			   void *data)
-{
-	unsigned long p = ((unsigned long)initial_boot_params) +
-		initial_boot_params->off_dt_struct;
-	int rc = 0;
-	int depth = -1;
-
-	do {
-		u32 tag = *((u32 *)p);
-		char *pathp;
-		
-		p += 4;
-		if (tag = OF_DT_END_NODE) {
-			depth --;
-			continue;
-		}
-		if (tag = OF_DT_NOP)
-			continue;
-		if (tag = OF_DT_END)
-			break;
-		if (tag = OF_DT_PROP) {
-			u32 sz = *((u32 *)p);
-			p += 8;
-			if (initial_boot_params->version < 0x10)
-				p = _ALIGN(p, sz >= 8 ? 8 : 4);
-			p += sz;
-			p = _ALIGN(p, 4);
-			continue;
-		}
-		if (tag != OF_DT_BEGIN_NODE) {
-			printk(KERN_WARNING "Invalid tag %x scanning flattened"
-			       " device tree !\n", tag);
-			return -EINVAL;
-		}
-		depth++;
-		pathp = (char *)p;
-		p = _ALIGN(p + strlen(pathp) + 1, 4);
-		if ((*pathp) = '/') {
-			char *lp, *np;
-			for (lp = NULL, np = pathp; *np; np++)
-				if ((*np) = '/')
-					lp = np+1;
-			if (lp != NULL)
-				pathp = lp;
-		}
-		rc = it(p, pathp, depth, data);
-		if (rc != 0)
-			break;		
-	} while(1);
-
-	return rc;
-}
-
 unsigned long __init of_get_flat_dt_root(void)
 {
 	unsigned long p = ((unsigned long)initial_boot_params) +
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 9faa9a5..7c3c13c 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -19,3 +19,68 @@ char *find_flat_dt_string(u32 offset)
 	return ((char *)initial_boot_params) +
 		initial_boot_params->off_dt_strings + offset;
 }
+
+/**
+ * of_scan_flat_dt - scan flattend tree blob and call callback on each.
+ * @it: callback function
+ * @data: context data pointer
+ *
+ * This function is used to scan the flattened device-tree, it is
+ * used to extract the memory informations at boot before we can
+ * unflatten the tree
+ */
+int __init of_scan_flat_dt(int (*it)(unsigned long node,
+				     const char *uname, int depth,
+				     void *data),
+			   void *data)
+{
+	unsigned long p = ((unsigned long)initial_boot_params) +
+		initial_boot_params->off_dt_struct;
+	int rc = 0;
+	int depth = -1;
+
+	do {
+		u32 tag = *((u32 *)p);
+		char *pathp;
+
+		p += 4;
+		if (tag = OF_DT_END_NODE) {
+			depth--;
+			continue;
+		}
+		if (tag = OF_DT_NOP)
+			continue;
+		if (tag = OF_DT_END)
+			break;
+		if (tag = OF_DT_PROP) {
+			u32 sz = *((u32 *)p);
+			p += 8;
+			if (initial_boot_params->version < 0x10)
+				p = _ALIGN(p, sz >= 8 ? 8 : 4);
+			p += sz;
+			p = _ALIGN(p, 4);
+			continue;
+		}
+		if (tag != OF_DT_BEGIN_NODE) {
+			printk(KERN_WARNING "Invalid tag %x scanning flattened"
+			       " device tree !\n", tag);
+			return -EINVAL;
+		}
+		depth++;
+		pathp = (char *)p;
+		p = _ALIGN(p + strlen(pathp) + 1, 4);
+		if ((*pathp) = '/') {
+			char *lp, *np;
+			for (lp = NULL, np = pathp; *np; np++)
+				if ((*np) = '/')
+					lp = np+1;
+			if (lp != NULL)
+				pathp = lp;
+		}
+		rc = it(p, pathp, depth, data);
+		if (rc != 0)
+			break;
+	} while (1);
+
+	return rc;
+}

