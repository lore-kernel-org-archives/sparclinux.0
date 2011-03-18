From: David Miller <davem@davemloft.net>
Date: Fri, 18 Mar 2011 22:32:48 +0000
Subject: [PATCH] sparc: Implement of_address_to_resource().
Message-Id: <20110318.153248.214207483.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Similarly to irq_of_parse_and_map(), find the platform_device
object and return the pre-computed resource.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/of_device_common.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/of_device_common.c b/arch/sparc/kernel/of_device_common.c
index 49ddff5..0ed0321 100644
--- a/arch/sparc/kernel/of_device_common.c
+++ b/arch/sparc/kernel/of_device_common.c
@@ -22,6 +22,19 @@ unsigned int irq_of_parse_and_map(struct device_node *node, int index)
 }
 EXPORT_SYMBOL(irq_of_parse_and_map);
 
+int of_address_to_resource(struct device_node *node, int index,
+			   struct resource *r)
+{
+	struct platform_device *op = of_find_device_by_node(node);
+
+	if (!op || index >= op->num_resources)
+		return -EINVAL;
+
+	memcpy(r, &op->archdata.resource[index], sizeof(*r));
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_address_to_resource);
+
 /* Take the archdata values for IOMMU, STC, and HOSTDATA found in
  * BUS and propagate to all child platform_device objects.
  */
-- 
1.7.4.1

