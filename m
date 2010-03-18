From: Sean MacLennan <smaclennan@pikatech.com>
Date: Thu, 18 Mar 2010 16:59:39 +0000
Subject: Re: [V2 PATCH 06/10] of/drivers: Always use struct device.of_node
Message-Id: <20100318125939.2b39d7f2@lappy.seanm.ca>
List-Id: <sparclinux.vger.kernel.org>
References: <20100318144836.21082.93040.stgit@angua>
	<20100318152238.21082.10985.stgit@angua>
In-Reply-To: <20100318152238.21082.10985.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-kernel@vger.kernel.org, michal.simek@petalogix.com, microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

On Thu, 18 Mar 2010 09:22:39 -0600
Grant Likely <grant.likely@secretlab.ca> wrote:

> The following structure elements duplicate the information in
> 'struct device.of_node' and so are being eliminated.  This patches
> makes all readers of the following elements use device.of_node
> instead.

The NDFC driver also needs a patch... or at least the version from your
last of_patch set does. I am included the patch I needed to get it to
compile.

Cheers,
   Sean

diff --git a/drivers/mtd/nand/ndfc.c b/drivers/mtd/nand/ndfc.c
index 19d94a2..5a232ec 100644
--- a/drivers/mtd/nand/ndfc.c
+++ b/drivers/mtd/nand/ndfc.c
@@ -238,14 +238,14 @@ static int __devinit ndfc_probe(struct of_device *ofdev,
 	dev_set_drvdata(&ofdev->dev, ndfc);
 
 	/* Read the reg property to get the chip select */
-	reg = of_get_property(ofdev->node, "reg", &len);
+	reg = of_get_property(ofdev->dev.of_node, "reg", &len);
 	if (reg = NULL || len != 12) {
 		dev_err(&ofdev->dev, "unable read reg property (%d)\n", len);
 		return -ENOENT;
 	}
 	ndfc->chip_select = reg[0];
 
-	ndfc->ndfcbase = of_iomap(ofdev->node, 0);
+	ndfc->ndfcbase = of_iomap(ofdev->dev.of_node, 0);
 	if (!ndfc->ndfcbase) {
 		dev_err(&ofdev->dev, "failed to get memory\n");
 		return -EIO;
@@ -254,20 +254,20 @@ static int __devinit ndfc_probe(struct of_device *ofdev,
 	ccr = NDFC_CCR_BS(ndfc->chip_select);
 
 	/* It is ok if ccr does not exist - just default to 0 */
-	reg = of_get_property(ofdev->node, "ccr", NULL);
+	reg = of_get_property(ofdev->dev.of_node, "ccr", NULL);
 	if (reg)
 		ccr |= *reg;
 
 	out_be32(ndfc->ndfcbase + NDFC_CCR, ccr);
 
 	/* Set the bank settings if given */
-	reg = of_get_property(ofdev->node, "bank-settings", NULL);
+	reg = of_get_property(ofdev->dev.of_node, "bank-settings", NULL);
 	if (reg) {
 		int offset = NDFC_BCFG0 + (ndfc->chip_select << 2);
 		out_be32(ndfc->ndfcbase + offset, *reg);
 	}
 
-	err = ndfc_chip_init(ndfc, ofdev->node);
+	err = ndfc_chip_init(ndfc, ofdev->dev.of_node);
 	if (err) {
 		iounmap(ndfc->ndfcbase);
 		return err;

