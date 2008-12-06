From: David Miller <davem@davemloft.net>
Date: Sat, 06 Dec 2008 03:05:26 +0000
Subject: [PATCH 11/14]: sparc: Match sparc32's build_tree() up to sparc64's
Message-Id: <20081205.190526.47726776.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc: Match sparc32's build_tree() up to sparc64's

Sparc64 uses a non-recursive sibling traversal algorithm
that never got propagated into the sparc32 copy of this
code.

Sync them up.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/prom_32.c |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/kernel/prom_32.c b/arch/sparc/kernel/prom_32.c
index 5881c14..35cb4c7 100644
--- a/arch/sparc/kernel/prom_32.c
+++ b/arch/sparc/kernel/prom_32.c
@@ -198,23 +198,33 @@ static char * __init build_full_name(struct device_node *dp)
 
 static struct device_node * __init build_tree(struct device_node *parent, phandle node, struct device_node ***nextp)
 {
+	struct device_node *ret = NULL, *prev_sibling = NULL;
 	struct device_node *dp;
 
-	dp = create_node(node, parent);
-	if (dp) {
+	while (1) {
+		dp = create_node(node, parent);
+		if (!dp)
+			break;
+
+		if (prev_sibling)
+			prev_sibling->sibling = dp;
+
+		if (!ret)
+			ret = dp;
+		prev_sibling = dp;
+
 		*(*nextp) = dp;
 		*nextp = &dp->allnext;
 
-		dp->parent = parent;
 		dp->path_component_name = build_path_component(dp);
 		dp->full_name = build_full_name(dp);
 
 		dp->child = build_tree(dp, prom_getchild(node), nextp);
 
-		dp->sibling = build_tree(parent, prom_getsibling(node), nextp);
+		node = prom_getsibling(node);
 	}
 
-	return dp;
+	return ret;
 }
 
 struct device_node *of_console_device;
-- 
1.5.6.5

