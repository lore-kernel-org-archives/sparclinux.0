From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 05 Nov 2009 07:46:13 +0000
Subject: [PATCH 05/11] of/flattree: merge of_get_flat_dt_prop
Message-Id: <20091105074606.10460.23775.stgit@angua>
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

 arch/microblaze/kernel/prom.c |   42 ----------------------------------------
 arch/powerpc/kernel/prom.c    |   42 ----------------------------------------
 drivers/of/fdt.c              |   43 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+), 84 deletions(-)

diff --git a/arch/microblaze/kernel/prom.c b/arch/microblaze/kernel/prom.c
index 7eb6f8b..d75c625 100644
--- a/arch/microblaze/kernel/prom.c
+++ b/arch/microblaze/kernel/prom.c
@@ -50,48 +50,6 @@ typedef u32 cell_t;
 /* export that to outside world */
 struct device_node *of_chosen;
 
-/**
- * This function can be used within scan_flattened_dt callback to get
- * access to properties
- */
-void *__init of_get_flat_dt_prop(unsigned long node, const char *name,
-				unsigned long *size)
-{
-	unsigned long p = node;
-
-	do {
-		u32 tag = *((u32 *)p);
-		u32 sz, noff;
-		const char *nstr;
-
-		p += 4;
-		if (tag = OF_DT_NOP)
-			continue;
-		if (tag != OF_DT_PROP)
-			return NULL;
-
-		sz = *((u32 *)p);
-		noff = *((u32 *)(p + 4));
-		p += 8;
-		if (initial_boot_params->version < 0x10)
-			p = _ALIGN(p, sz >= 8 ? 8 : 4);
-
-		nstr = find_flat_dt_string(noff);
-		if (nstr = NULL) {
-			printk(KERN_WARNING "Can't find property index"
-				" name !\n");
-			return NULL;
-		}
-		if (strcmp(name, nstr) = 0) {
-			if (size)
-				*size = sz;
-			return (void *)p;
-		}
-		p += sz;
-		p = _ALIGN(p, 4);
-	} while (1);
-}
-
 int __init of_flat_dt_is_compatible(unsigned long node, const char *compat)
 {
 	const char *cp;
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index b5d5f85..cd0a2bf 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -80,48 +80,6 @@ extern rwlock_t devtree_lock;	/* temporary while merging */
 /* export that to outside world */
 struct device_node *of_chosen;
 
-/**
- * This  function can be used within scan_flattened_dt callback to get
- * access to properties
- */
-void* __init of_get_flat_dt_prop(unsigned long node, const char *name,
-				 unsigned long *size)
-{
-	unsigned long p = node;
-
-	do {
-		u32 tag = *((u32 *)p);
-		u32 sz, noff;
-		const char *nstr;
-
-		p += 4;
-		if (tag = OF_DT_NOP)
-			continue;
-		if (tag != OF_DT_PROP)
-			return NULL;
-
-		sz = *((u32 *)p);
-		noff = *((u32 *)(p + 4));
-		p += 8;
-		if (initial_boot_params->version < 0x10)
-			p = _ALIGN(p, sz >= 8 ? 8 : 4);
-
-		nstr = find_flat_dt_string(noff);
-		if (nstr = NULL) {
-			printk(KERN_WARNING "Can't find property index"
-			       " name !\n");
-			return NULL;
-		}
-		if (strcmp(name, nstr) = 0) {
-			if (size)
-				*size = sz;
-			return (void *)p;
-		}
-		p += sz;
-		p = _ALIGN(p, 4);
-	} while(1);
-}
-
 int __init of_flat_dt_is_compatible(unsigned long node, const char *compat)
 {
 	const char* cp;
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index a6e869e..7a51343 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -100,3 +100,46 @@ unsigned long __init of_get_flat_dt_root(void)
 	return _ALIGN(p + strlen((char *)p) + 1, 4);
 }
 
+/**
+ * of_get_flat_dt_prop - Given a node in the flat blob, return the property pointer
+ *
+ * This  function can be used within scan_flattened_dt callback to get
+ * access to properties
+ */
+void *__init of_get_flat_dt_prop(unsigned long node, const char *name,
+				 unsigned long *size)
+{
+	unsigned long p = node;
+
+	do {
+		u32 tag = *((u32 *)p);
+		u32 sz, noff;
+		const char *nstr;
+
+		p += 4;
+		if (tag = OF_DT_NOP)
+			continue;
+		if (tag != OF_DT_PROP)
+			return NULL;
+
+		sz = *((u32 *)p);
+		noff = *((u32 *)(p + 4));
+		p += 8;
+		if (initial_boot_params->version < 0x10)
+			p = _ALIGN(p, sz >= 8 ? 8 : 4);
+
+		nstr = find_flat_dt_string(noff);
+		if (nstr = NULL) {
+			pr_warning("Can't find property index name !\n");
+			return NULL;
+		}
+		if (strcmp(name, nstr) = 0) {
+			if (size)
+				*size = sz;
+			return (void *)p;
+		}
+		p += sz;
+		p = _ALIGN(p, 4);
+	} while (1);
+}
+

