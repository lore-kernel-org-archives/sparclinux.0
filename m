From: Andres Salomon <dilinger@queued.net>
Date: Fri, 18 Mar 2011 00:32:34 +0000
Subject: [PATCH 2/4] of/promtree: switch to building the DT using of_attach_node
Message-Id: <1300408356-15253-3-git-send-email-dilinger@queued.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1300408356-15253-1-git-send-email-dilinger@queued.net>
In-Reply-To: <1300408356-15253-1-git-send-email-dilinger-pFFUokh25LWsTnJN9+BGXg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Use common functions (of_attach_node) to build the device tree.  This
allows us to drop a bit of code, and improves readability of the
tree building code.

Note that this changes what gets passed to the of_pdt_build_more()
hook.  The only user of this hook is sparc's leon_kernel.c, which ends
up using it to call prom_amba_init.  However, prom_amba_init isn't
actually set in the kernel, so I can't tell whether this actually breaks
behavior or not.

Signed-off-by: Andres Salomon <dilinger@queued.net>
---
 drivers/of/pdt.c |   30 ++++++------------------------
 1 files changed, 6 insertions(+), 24 deletions(-)

diff --git a/drivers/of/pdt.c b/drivers/of/pdt.c
index 4d87b5d..f3ddc2d 100644
--- a/drivers/of/pdt.c
+++ b/drivers/of/pdt.c
@@ -193,11 +193,8 @@ static struct device_node * __init of_pdt_create_node(phandle node,
 	return dp;
 }
 
-static struct device_node * __init of_pdt_build_tree(struct device_node *parent,
-						   phandle node,
-						   struct device_node ***nextp)
+static void __init of_pdt_build_tree(struct device_node *parent, phandle node)
 {
-	struct device_node *ret = NULL, *prev_sibling = NULL;
 	struct device_node *dp;
 
 	while (1) {
@@ -205,34 +202,20 @@ static struct device_node * __init of_pdt_build_tree(struct device_node *parent,
 		if (!dp)
 			break;
 
-		if (prev_sibling)
-			prev_sibling->sibling = dp;
-
-		if (!ret)
-			ret = dp;
-		prev_sibling = dp;
-
-		*(*nextp) = dp;
-		*nextp = &dp->allnext;
-
 		dp->full_name = of_pdt_build_full_name(dp);
+		of_attach_node(dp);
 
-		dp->child = of_pdt_build_tree(dp,
-				of_pdt_prom_ops->getchild(node), nextp);
+		of_pdt_build_tree(dp, of_pdt_prom_ops->getchild(node));
 
 		if (of_pdt_build_more)
-			of_pdt_build_more(dp, nextp);
+			of_pdt_build_more(dp, NULL);
 
 		node = of_pdt_prom_ops->getsibling(node);
 	}
-
-	return ret;
 }
 
 void __init of_pdt_build_devicetree(phandle root_node, struct of_pdt_ops *ops)
 {
-	struct device_node **nextp;
-
 	BUG_ON(!ops);
 	of_pdt_prom_ops = ops;
 
@@ -242,7 +225,6 @@ void __init of_pdt_build_devicetree(phandle root_node, struct of_pdt_ops *ops)
 #endif
 	allnodes->full_name = "/";
 
-	nextp = &allnodes->allnext;
-	allnodes->child = of_pdt_build_tree(allnodes,
-			of_pdt_prom_ops->getchild(allnodes->phandle), &nextp);
+	of_pdt_build_tree(allnodes,
+			of_pdt_prom_ops->getchild(allnodes->phandle));
 }
-- 
1.7.2.3

