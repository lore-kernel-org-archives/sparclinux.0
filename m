From: David Miller <davem@davemloft.net>
Date: Tue, 31 Jul 2007 01:22:13 +0000
Subject: Re: Sparc32 not working:2.6.23-rc1 (git commit
Message-Id: <20070730.182213.66060389.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0707281903350.27869@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707281903350.27869@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Sun, 29 Jul 2007 22:54:46 +0100 (BST)

> The lock is taken into consideration however, looking at the code, there 
> seems to be an issue with the new code for Sparc32. It does not seem tie 
> up with the code used before!!!. If this is rearly the case then this 
> would explain the memory corruption I am seeing as the functions in tree.c 
> that call the openprom to not match the previous working versions.
> 
> I will try to workout what has happened.

I would suggest that, for now, we address the bug itself by
merely converting sunlance over to the of_*() interfaces.

The patch below is what I'm going to check in upstream.

If you find anything interesting in arch/sparc/prom/tree.c et al.
please let me know.

diff --git a/drivers/net/sunlance.c b/drivers/net/sunlance.c
index 053b7cb..68e4f66 100644
--- a/drivers/net/sunlance.c
+++ b/drivers/net/sunlance.c
@@ -99,8 +99,7 @@ static char lancestr[] = "LANCE";
 #include <asm/byteorder.h>	/* Used by the checksum routines */
 #include <asm/idprom.h>
 #include <asm/sbus.h>
-#include <asm/openprom.h>
-#include <asm/oplib.h>
+#include <asm/prom.h>
 #include <asm/auxio.h>		/* For tpe-link-test? setting */
 #include <asm/irq.h>
 
@@ -1326,6 +1325,7 @@ static int __devinit sparc_lance_probe_one(struct sbus_dev *sdev,
 					   struct sbus_dev *lebuffer)
 {
 	static unsigned version_printed;
+	struct device_node *dp = sdev->ofdev.node;
 	struct net_device *dev;
 	struct lance_private *lp;
 	int    i;
@@ -1389,54 +1389,46 @@ static int __devinit sparc_lance_probe_one(struct sbus_dev *sdev,
 		lp->rx = lance_rx_dvma;
 		lp->tx = lance_tx_dvma;
 	}
-	lp->busmaster_regval = prom_getintdefault(sdev->prom_node,
-						  "busmaster-regval",
-						  (LE_C3_BSWP | LE_C3_ACON |
-						   LE_C3_BCON));
+	lp->busmaster_regval = of_getintprop_default(dp,  "busmaster-regval",
+						     (LE_C3_BSWP |
+						      LE_C3_ACON |
+						      LE_C3_BCON));
 
 	lp->name = lancestr;
 	lp->ledma = ledma;
 
 	lp->burst_sizes = 0;
 	if (lp->ledma) {
-		char prop[6];
+		struct device_node *ledma_dp = ledma->sdev->ofdev.node;
+		const char *prop;
 		unsigned int sbmask;
 		u32 csr;
 
 		/* Find burst-size property for ledma */
-		lp->burst_sizes = prom_getintdefault(ledma->sdev->prom_node,
-						     "burst-sizes", 0);
+		lp->burst_sizes = of_getintprop_default(ledma_dp,
+							"burst-sizes", 0);
 
 		/* ledma may be capable of fast bursts, but sbus may not. */
-		sbmask = prom_getintdefault(ledma->sdev->bus->prom_node,
-					    "burst-sizes", DMA_BURSTBITS);
+		sbmask = of_getintprop_default(ledma_dp, "burst-sizes",
+					       DMA_BURSTBITS);
 		lp->burst_sizes &= sbmask;
 
 		/* Get the cable-selection property */
-		memset(prop, 0, sizeof(prop));
-		prom_getstring(ledma->sdev->prom_node, "cable-selection",
-			       prop, sizeof(prop));
-		if (prop[0] = 0) {
-			int topnd, nd;
+		prop = of_get_property(ledma_dp, "cable-selection", NULL);
+		if (!prop || prop[0] = '\0') {
+			struct device_node *nd;
 
-			printk(KERN_INFO "SunLance: using auto-carrier-detection.\n");
+			printk(KERN_INFO "SunLance: using "
+			       "auto-carrier-detection.\n");
 
-			/* Is this found at /options .attributes in all
-			 * Prom versions? XXX
-			 */
-			topnd = prom_getchild(prom_root_node);
-
-			nd = prom_searchsiblings(topnd, "options");
+			nd = of_find_node_by_path("/options");
 			if (!nd)
 				goto no_link_test;
 
-			if (!prom_node_has_property(nd, "tpe-link-test?"))
+			prop = of_get_property(nd, "tpe-link-test?", NULL);
+			if (!prop)
 				goto no_link_test;
 
-			memset(prop, 0, sizeof(prop));
-			prom_getstring(nd, "tpe-link-test?", prop,
-				       sizeof(prop));
-
 			if (strcmp(prop, "true")) {
 				printk(KERN_NOTICE "SunLance: warning: overriding option "
 				       "'tpe-link-test?'\n");
