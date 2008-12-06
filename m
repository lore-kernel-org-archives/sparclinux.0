From: David Miller <davem@davemloft.net>
Date: Sat, 06 Dec 2008 03:05:22 +0000
Subject: [PATCH 9/14]: sparc: Make sparc32's create_node() assign parent
Message-Id: <20081205.190522.230670042.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc: Make sparc32's create_node() assign parent pointer.

This makes it match what sparc64's version does.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/prom_32.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/prom_32.c b/arch/sparc/kernel/prom_32.c
index a6809bc..5818aa9 100644
--- a/arch/sparc/kernel/prom_32.c
+++ b/arch/sparc/kernel/prom_32.c
@@ -210,7 +210,7 @@ static char * __init get_one_property(phandle node, const char *name)
 	return buf;
 }
 
-static struct device_node * __init create_node(phandle node)
+static struct device_node * __init create_node(phandle node, struct device_node *parent)
 {
 	struct device_node *dp;
 
@@ -219,6 +219,7 @@ static struct device_node * __init create_node(phandle node)
 
 	dp = prom_early_alloc(sizeof(*dp));
 	dp->unique_id = prom_unique_id++;
+	dp->parent = parent;
 
 	kref_init(&dp->kref);
 
@@ -237,7 +238,7 @@ static struct device_node * __init build_tree(struct device_node *parent, phandl
 {
 	struct device_node *dp;
 
-	dp = create_node(node);
+	dp = create_node(node, parent);
 	if (dp) {
 		*(*nextp) = dp;
 		*nextp = &dp->allnext;
@@ -387,7 +388,7 @@ void __init prom_build_devicetree(void)
 {
 	struct device_node **nextp;
 
-	allnodes = create_node(prom_root_node);
+	allnodes = create_node(prom_root_node, NULL);
 	allnodes->path_component_name = "";
 	allnodes->full_name = "/";
 
-- 
1.5.6.5

