From: David Miller <davem@davemloft.net>
Date: Fri, 18 Mar 2011 22:48:35 +0000
Subject: [PATCH] sparc: Implement of_iomap().
Message-Id: <20110318.154835.232902675.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Grab the pre-computed resource and map using of_ioremap().

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/of_device_common.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/of_device_common.c b/arch/sparc/kernel/of_device_common.c
index 0ed0321..cb15bbf 100644
--- a/arch/sparc/kernel/of_device_common.c
+++ b/arch/sparc/kernel/of_device_common.c
@@ -35,6 +35,20 @@ int of_address_to_resource(struct device_node *node, int index,
 }
 EXPORT_SYMBOL_GPL(of_address_to_resource);
 
+void __iomem *of_iomap(struct device_node *node, int index)
+{
+	struct platform_device *op = of_find_device_by_node(node);
+	struct resource *r;
+
+	if (!op || index >= op->num_resources)
+		return NULL;
+
+	r = &op->archdata.resource[index];
+
+	return of_ioremap(r, 0, resource_size(r), (char *) r->name);
+}
+EXPORT_SYMBOL(of_iomap);
+
 /* Take the archdata values for IOMMU, STC, and HOSTDATA found in
  * BUS and propagate to all child platform_device objects.
  */
-- 
1.7.4.1

