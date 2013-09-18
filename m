From: Thierry Reding <thierry.reding@gmail.com>
Date: Wed, 18 Sep 2013 13:24:43 +0000
Subject: [PATCH v2 01/10] of/irq: Rework of_irq_count()
Message-Id: <1379510692-32435-2-git-send-email-treding@nvidia.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1379510692-32435-1-git-send-email-treding@nvidia.com>
In-Reply-To: <1379510692-32435-1-git-send-email-treding@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The of_irq_to_resource() helper that is used to implement of_irq_count()
tries to resolve interrupts and in fact creates a mapping for resolved
interrupts. That's pretty heavy lifting for something that claims to
just return the number of interrupts requested by a given device node.

Instead, use the more lightweight of_irq_map_one(), which, despite the
name, doesn't create an actual mapping. Perhaps a better name would be
of_irq_translate_one().

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/of/irq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 1752988..5f44388 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -368,9 +368,10 @@ EXPORT_SYMBOL_GPL(of_irq_to_resource);
  */
 int of_irq_count(struct device_node *dev)
 {
+	struct of_irq irq;
 	int nr = 0;
 
-	while (of_irq_to_resource(dev, nr, NULL))
+	while (of_irq_map_one(dev, nr, &irq) = 0)
 		nr++;
 
 	return nr;
-- 
1.8.4

