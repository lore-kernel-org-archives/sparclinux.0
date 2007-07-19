From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 19 Jul 2007 15:10:12 +0000
Subject: [PATCH 03/12] Consolidate of_device_is_compatible
Message-Id: <20070720011012.4eca281d.sfr@canb.auug.org.au>
List-Id: <sparclinux.vger.kernel.org>
References: <20070718173024.50204a1a.sfr@canb.auug.org.au>
	<20070720010742.e60c67a7.sfr@canb.auug.org.au>
In-Reply-To: <20070720010742.e60c67a7.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ppc-dev <linuxppc-dev@ozlabs.org>, sparclinux@vger.kernel.org
Cc: paulus@samba.org, "David S. Miller" <davem@davemloft.net>, wli@holomorphy.com

The only difference here is that Sparc uses strncmp to match compatibility
names while PowerPC uses strncasecmp.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/prom.c |   25 -------------------------
 arch/sparc/kernel/prom.c   |   21 ---------------------
 arch/sparc64/kernel/prom.c |   21 ---------------------
 drivers/of/base.c          |   24 ++++++++++++++++++++++++
 include/asm-powerpc/prom.h |    2 ++
 include/asm-sparc/prom.h   |    2 ++
 include/asm-sparc64/prom.h |    2 ++
 7 files changed, 30 insertions(+), 67 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 6c9419a..c009d21 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -1057,31 +1057,6 @@ void __init early_init_devtree(void *params)
 }
 
 
-/** Checks if the given "compat" string matches one of the strings in
- * the device's "compatible" property
- */
-int of_device_is_compatible(const struct device_node *device,
-		const char *compat)
-{
-	const char* cp;
-	int cplen, l;
-
-	cp = of_get_property(device, "compatible", &cplen);
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
-EXPORT_SYMBOL(of_device_is_compatible);
-
-
 /**
  * Indicates whether the root node has a given value in its
  * compatible property.
diff --git a/arch/sparc/kernel/prom.c b/arch/sparc/kernel/prom.c
index ac3f3c2..f2ce0d4 100644
--- a/arch/sparc/kernel/prom.c
+++ b/arch/sparc/kernel/prom.c
@@ -32,27 +32,6 @@ static struct device_node *allnodes;
  */
 static DEFINE_RWLOCK(devtree_lock);
 
-int of_device_is_compatible(const struct device_node *device,
-			    const char *compat)
-{
-	const char* cp;
-	int cplen, l;
-
-	cp = of_get_property(device, "compatible", &cplen);
-	if (cp = NULL)
-		return 0;
-	while (cplen > 0) {
-		if (strncmp(cp, compat, strlen(compat)) = 0)
-			return 1;
-		l = strlen(cp) + 1;
-		cp += l;
-		cplen -= l;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(of_device_is_compatible);
-
 struct device_node *of_get_parent(const struct device_node *node)
 {
 	struct device_node *np;
diff --git a/arch/sparc64/kernel/prom.c b/arch/sparc64/kernel/prom.c
index 8f926d4..4d6fb07 100644
--- a/arch/sparc64/kernel/prom.c
+++ b/arch/sparc64/kernel/prom.c
@@ -37,27 +37,6 @@ static struct device_node *allnodes;
  */
 static DEFINE_RWLOCK(devtree_lock);
 
-int of_device_is_compatible(const struct device_node *device,
-			    const char *compat)
-{
-	const char* cp;
-	int cplen, l;
-
-	cp = of_get_property(device, "compatible", &cplen);
-	if (cp = NULL)
-		return 0;
-	while (cplen > 0) {
-		if (strncmp(cp, compat, strlen(compat)) = 0)
-			return 1;
-		l = strlen(cp) + 1;
-		cp += l;
-		cplen -= l;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(of_device_is_compatible);
-
 struct device_node *of_get_parent(const struct device_node *node)
 {
 	struct device_node *np;
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 723d80d..d6dc5e7 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -63,3 +63,27 @@ const void *of_get_property(const struct device_node *np, const char *name,
 	return pp ? pp->value : NULL;
 }
 EXPORT_SYMBOL(of_get_property);
+
+/** Checks if the given "compat" string matches one of the strings in
+ * the device's "compatible" property
+ */
+int of_device_is_compatible(const struct device_node *device,
+		const char *compat)
+{
+	const char* cp;
+	int cplen, l;
+
+	cp = of_get_property(device, "compatible", &cplen);
+	if (cp = NULL)
+		return 0;
+	while (cplen > 0) {
+		if (of_compat_cmp(cp, compat, strlen(compat)) = 0)
+			return 1;
+		l = strlen(cp) + 1;
+		cp += l;
+		cplen -= l;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(of_device_is_compatible);
diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
index 9fe0152..b05f8f2 100644
--- a/include/asm-powerpc/prom.h
+++ b/include/asm-powerpc/prom.h
@@ -24,6 +24,8 @@
 #define OF_ROOT_NODE_ADDR_CELLS_DEFAULT	1
 #define OF_ROOT_NODE_SIZE_CELLS_DEFAULT	1
 
+#define of_compat_cmp(s1, s2, l)	strncasecmp((s1), (s2), (l))
+
 /* Definitions used by the flattened device tree */
 #define OF_DT_HEADER		0xd00dfeed	/* marker */
 #define OF_DT_BEGIN_NODE	0x1		/* Start of node, full name */
diff --git a/include/asm-sparc/prom.h b/include/asm-sparc/prom.h
index a8a121f..c755c69 100644
--- a/include/asm-sparc/prom.h
+++ b/include/asm-sparc/prom.h
@@ -23,6 +23,8 @@
 #define OF_ROOT_NODE_ADDR_CELLS_DEFAULT	2
 #define OF_ROOT_NODE_SIZE_CELLS_DEFAULT	1
 
+#define of_compat_cmp(s1, s2, l)	strncmp((s1), (s2), (l))
+
 typedef u32 phandle;
 typedef u32 ihandle;
 
diff --git a/include/asm-sparc64/prom.h b/include/asm-sparc64/prom.h
index c98d154..040d198 100644
--- a/include/asm-sparc64/prom.h
+++ b/include/asm-sparc64/prom.h
@@ -23,6 +23,8 @@
 #define OF_ROOT_NODE_ADDR_CELLS_DEFAULT	2
 #define OF_ROOT_NODE_SIZE_CELLS_DEFAULT	1
 
+#define of_compat_cmp(s1, s2, l)	strncmp((s1), (s2), (l))
+
 typedef u32 phandle;
 typedef u32 ihandle;
 
-- 
1.5.2.3

