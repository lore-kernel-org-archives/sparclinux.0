From: Rob Herring <robh@kernel.org>
Date: Wed, 07 Nov 2018 22:31:45 +0000
Subject: [PATCH 2/8] of: Drop full path from Sparc PDT full_name
Message-Id: <20181107223151.14991-3-robh@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20181107223151.14991-1-robh@kernel.org>
In-Reply-To: <20181107223151.14991-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

Now that there are no more users of path_component_name outside of
the PDT code and users of device_node.full_name are converted to use
"%pOF" printf specifier, we can align Sparc with other arches and store
just the base node name and unit address in full_name. This makes
path_component_name redundant, so it can be removed.

As full_name is used by printf specifiers, set it as early as possible.

Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/pdt.c   | 26 +++-----------------------
 include/linux/of.h |  1 -
 2 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/drivers/of/pdt.c b/drivers/of/pdt.c
index 013e65de074a..40321b6b82e2 100644
--- a/drivers/of/pdt.c
+++ b/drivers/of/pdt.c
@@ -32,24 +32,7 @@ unsigned int of_pdt_unique_id __initdata;
 
 static char * __init of_pdt_build_full_name(struct device_node *dp)
 {
-	int len, ourlen, plen;
-	char *n;
-
-	dp->path_component_name = build_path_component(dp);
-
-	plen = strlen(dp->parent->full_name);
-	ourlen = strlen(dp->path_component_name);
-	len = ourlen + plen + 2;
-
-	n = prom_early_alloc(len);
-	strcpy(n, dp->parent->full_name);
-	if (!of_node_is_root(dp->parent)) {
-		strcpy(n + plen, "/");
-		plen++;
-	}
-	strcpy(n + plen, dp->path_component_name);
-
-	return n;
+	return build_path_component(dp);
 }
 
 #else /* CONFIG_SPARC */
@@ -181,6 +164,8 @@ static struct device_node * __init of_pdt_create_node(phandle node,
 
 	dp->properties = of_pdt_build_prop_list(node);
 
+	dp->full_name = of_pdt_build_full_name(dp);
+
 	irq_trans_init(dp);
 
 	return dp;
@@ -204,8 +189,6 @@ static struct device_node * __init of_pdt_build_tree(struct device_node *parent,
 			ret = dp;
 		prev_sibling = dp;
 
-		dp->full_name = of_pdt_build_full_name(dp);
-
 		dp->child = of_pdt_build_tree(dp, of_pdt_prom_ops->getchild(node));
 
 		if (of_pdt_build_more)
@@ -228,9 +211,6 @@ void __init of_pdt_build_devicetree(phandle root_node, struct of_pdt_ops *ops)
 	of_pdt_prom_ops = ops;
 
 	of_root = of_pdt_create_node(root_node, NULL);
-#if defined(CONFIG_SPARC)
-	of_root->path_component_name = "";
-#endif
 	of_root->full_name = "/";
 
 	of_root->child = of_pdt_build_tree(of_root,
diff --git a/include/linux/of.h b/include/linux/of.h
index a5aee3c438ad..0fe5bef81a7e 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -66,7 +66,6 @@ struct device_node {
 	unsigned long _flags;
 	void	*data;
 #if defined(CONFIG_SPARC)
-	const char *path_component_name;
 	unsigned int unique_id;
 	struct of_irq_controller *irq_trans;
 #endif
-- 
2.19.1
