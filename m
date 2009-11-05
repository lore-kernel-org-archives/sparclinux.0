From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 05 Nov 2009 07:46:26 +0000
Subject: [PATCH 06/11] of/flattree: Merge of_flat_dt_is_compatible
Message-Id: <20091105074618.10460.86348.stgit@angua>
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

 arch/microblaze/kernel/prom.c |   19 -------------------
 arch/powerpc/kernel/prom.c    |   19 -------------------
 drivers/of/fdt.c              |   24 ++++++++++++++++++++++++
 3 files changed, 24 insertions(+), 38 deletions(-)

diff --git a/arch/microblaze/kernel/prom.c b/arch/microblaze/kernel/prom.c
index d75c625..eb27bd3 100644
--- a/arch/microblaze/kernel/prom.c
+++ b/arch/microblaze/kernel/prom.c
@@ -50,25 +50,6 @@ typedef u32 cell_t;
 /* export that to outside world */
 struct device_node *of_chosen;
 
-int __init of_flat_dt_is_compatible(unsigned long node, const char *compat)
-{
-	const char *cp;
-	unsigned long cplen, l;
-
-	cp = of_get_flat_dt_prop(node, "compatible", &cplen);
-	if (cp = NULL)
-		return 0;
-	while (cplen > 0) {
-		if (strncasecmp(cp, compat, strlen(compat)) = 0)
-			return 1;
-		l = strlen(cp) + 1;
-		cp += l;
-		cplen -= l;
-	}
-
-	return 0;
-}
-
 static void *__init unflatten_dt_alloc(unsigned long *mem, unsigned long size,
 					unsigned long align)
 {
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index cd0a2bf..413e608 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -80,25 +80,6 @@ extern rwlock_t devtree_lock;	/* temporary while merging */
 /* export that to outside world */
 struct device_node *of_chosen;
 
-int __init of_flat_dt_is_compatible(unsigned long node, const char *compat)
-{
-	const char* cp;
-	unsigned long cplen, l;
-
-	cp = of_get_flat_dt_prop(node, "compatible", &cplen);
-	if (cp = NULL)
-		return 0;
-	while (cplen > 0) {
-		if (strncasecmp(cp, compat, strlen(compat)) = 0)
-			return 1;
-		l = strlen(cp) + 1;
-		cp += l;
-		cplen -= l;
-	}
-
-	return 0;
-}
-
 static void *__init unflatten_dt_alloc(unsigned long *mem, unsigned long size,
 				       unsigned long align)
 {
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 7a51343..01a7f5f 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -143,3 +143,27 @@ void *__init of_get_flat_dt_prop(unsigned long node, const char *name,
 	} while (1);
 }
 
+/**
+ * of_flat_dt_is_compatible - Return true if given node has compat in compatible list
+ * @node: node to test
+ * @compat: compatible string to compare with compatible list.
+ */
+int __init of_flat_dt_is_compatible(unsigned long node, const char *compat)
+{
+	const char *cp;
+	unsigned long cplen, l;
+
+	cp = of_get_flat_dt_prop(node, "compatible", &cplen);
+	if (cp = NULL)
+		return 0;
+	while (cplen > 0) {
+		if (strncasecmp(cp, compat, strlen(compat)) = 0)
+			return 1;
+		l = strlen(cp) + 1;
+		cp += l;
+		cplen -= l;
+	}
+
+	return 0;
+}
+

