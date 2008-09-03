From: David Miller <davem@davemloft.net>
Date: Wed, 03 Sep 2008 09:06:54 +0000
Subject: Re: generic IRQs for sparc32
Message-Id: <20080903.020654.61512019.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080902.010944.25269623.davem@davemloft.net>
In-Reply-To: <20080902.010944.25269623.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Robert Reif <reif@earthlink.net>
Date: Tue, 02 Sep 2008 23:48:39 -0400

> ESP: Mapped regs at fd016000
> ESP: In esp_get_revision(), regs at fd016000
> ESP: In esp_get_revision(), about to read ESP_CFG2, regs now at fd016000
> Unable to handle kernel paging request at virtual address fd016000

I think I figured it out.  We're not calculating the physical
I/O address of the ESP registers properly.  So it's accessing
some random location instead of the ESP chip.

This would have also tripped up Ultra1 systems.

Please try this patch, which I also pushed to sparc-next-2.6

Thanks!

sparc: Fix handling of LANCE and ESP parent nodes in of_device.c

The device nodes that sit above 'esp' and 'le' on SBUS lack a 'ranges'
property, but we should pass the translation up to the parent node so
that the SBUS level ranges get applied.

Based upon a bug report from Robert Reif.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/of_device.c   |   26 ++++++++++++++++++++++----
 arch/sparc64/kernel/of_device.c |   11 ++++++++++-
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/kernel/of_device.c b/arch/sparc/kernel/of_device.c
index c590148..4ef1607 100644
--- a/arch/sparc/kernel/of_device.c
+++ b/arch/sparc/kernel/of_device.c
@@ -344,6 +344,27 @@ static int __init build_one_resource(struct device_node *parent,
 	return 1;
 }
 
+static int __init use_1to1_mapping(struct device_node *pp)
+{
+	/* If we have a ranges property in the parent, use it.  */
+	if (of_find_property(pp, "ranges", NULL) != NULL)
+		return 0;
+
+	/* Some SBUS devices use intermediate nodes to express
+	 * hierarchy within the device itself.  These aren't
+	 * real bus nodes, and don't have a 'ranges' property.
+	 * But, we should still pass the translation work up
+	 * to the SBUS itself.
+	 */
+	if (!strcmp(pp->name, "dma") ||
+	    !strcmp(pp->name, "espdma") ||
+	    !strcmp(pp->name, "ledma") ||
+	    !strcmp(pp->name, "lebuffer"))
+		return 0;
+
+	return 1;
+}
+
 static int of_resource_verbose;
 
 static void __init build_device_resources(struct of_device *op,
@@ -389,10 +410,7 @@ static void __init build_device_resources(struct of_device *op,
 
 		memcpy(addr, reg, na * 4);
 
-		/* If the immediate parent has no ranges property to apply,
-		 * just use a 1<->1 mapping.
-		 */
-		if (of_find_property(pp, "ranges", NULL) = NULL) {
+		if (use_1to1_mapping(pp)) {
 			result = of_read_addr(addr, na);
 			goto build_res;
 		}
diff --git a/arch/sparc64/kernel/of_device.c b/arch/sparc64/kernel/of_device.c
index e427086..c15bcdf 100644
--- a/arch/sparc64/kernel/of_device.c
+++ b/arch/sparc64/kernel/of_device.c
@@ -438,8 +438,17 @@ static int __init use_1to1_mapping(struct device_node *pp)
 
 	/* If the parent is the dma node of an ISA bus, pass
 	 * the translation up to the root.
+	 *
+	 * Some SBUS devices use intermediate nodes to express
+	 * hierarchy within the device itself.  These aren't
+	 * real bus nodes, and don't have a 'ranges' property.
+	 * But, we should still pass the translation work up
+	 * to the SBUS itself.
 	 */
-	if (!strcmp(pp->name, "dma"))
+	if (!strcmp(pp->name, "dma") ||
+	    !strcmp(pp->name, "espdma") ||
+	    !strcmp(pp->name, "ledma") ||
+	    !strcmp(pp->name, "lebuffer"))
 		return 0;
 
 	/* Similarly for all PCI bridges, if we get this far
-- 
1.5.6.5.GIT

