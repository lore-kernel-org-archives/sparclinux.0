From: David Miller <davem@davemloft.net>
Date: Sat, 14 Mar 2009 21:14:42 +0000
Subject: Re: Ultra1 ESP detection problem
Message-Id: <20090314.141442.34667369.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0903132344220.21922@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0903132344220.21922@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Friedrich Oslage <bluebird@gentoo.org>
Date: Sat, 14 Mar 2009 15:43:07 +0100

> Meelis Roos schrieb:
> > [   60.565134] esp: probe of f0062a74 failed with error -12
> 
> I can reproduce this on my Ultra 2. I didn't notice it until now because
> the boot disk is attached to an hme esp(which still works).
> 
> In esp_sbus_map_regs the of_ioremap call failes because res->start is 0
> for non hme cards.
> 
> Basicly your tree looks like this:
> 
> SUNW,Ultra-1
>   sbus
>     SUNW,fas
>     espdma
>       esp
> 
> Of_bus_sbus_match works for "SUNW,fas" but not for "esp" because it only
> checks the direct parent and not the parent's parent for name = "sbus".
> 
> This makes the kernel use of_bus_default_count_cells to calculate the
> resources for "esp" instead of of_bus_sbus_count_cells.
> And since of_bus_default_count_cells doesn't work for sbus systems the
> resources of "esp" aren't detected.

Grumble, I've fixed this already.  See the patch below which has
been in the tree for a while.

We need to figure out why the logic isn't triggering properly.

commit 5280267c1dddb8d413595b87dc406624bb497946
Author: David S. Miller <davem@davemloft.net>
Date:   Wed Sep 3 02:04:41 2008 -0700

    sparc: Fix handling of LANCE and ESP parent nodes in of_device.c
    
    The device nodes that sit above 'esp' and 'le' on SBUS lack a 'ranges'
    property, but we should pass the translation up to the parent node so
    that the SBUS level ranges get applied.
    
    Based upon a bug report from Robert Reif.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

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
