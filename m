From: David Miller <davem@davemloft.net>
Date: Thu, 28 Jul 2011 08:44:23 +0000
Subject: [PATCH 5/6] n2rng: Attach on Niagara-T3.
Message-Id: <20110728.014423.346127809978122665.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


And stop referring to Victoria Falls, as the attribute we're
talking about is whether the rng is multi-unit capable which
applies to several chip variants now.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/char/hw_random/n2-drv.c |   29 +++++++++++++++++------------
 drivers/char/hw_random/n2rng.h  |    2 +-
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/char/hw_random/n2-drv.c b/drivers/char/hw_random/n2-drv.c
index ac6739e..c3de70d 100644
--- a/drivers/char/hw_random/n2-drv.c
+++ b/drivers/char/hw_random/n2-drv.c
@@ -1,6 +1,6 @@
 /* n2-drv.c: Niagara-2 RNG driver.
  *
- * Copyright (C) 2008 David S. Miller <davem@davemloft.net>
+ * Copyright (C) 2008, 2011 David S. Miller <davem@davemloft.net>
  */
 
 #include <linux/kernel.h>
@@ -22,8 +22,8 @@
 
 #define DRV_MODULE_NAME		"n2rng"
 #define PFX DRV_MODULE_NAME	": "
-#define DRV_MODULE_VERSION	"0.1"
-#define DRV_MODULE_RELDATE	"May 15, 2008"
+#define DRV_MODULE_VERSION	"0.2"
+#define DRV_MODULE_RELDATE	"July 27, 2011"
 
 static char version[] __devinitdata  	DRV_MODULE_NAME ".c:v" DRV_MODULE_VERSION " (" DRV_MODULE_RELDATE ")\n";
@@ -623,14 +623,14 @@ static const struct of_device_id n2rng_match[];
 static int __devinit n2rng_probe(struct platform_device *op)
 {
 	const struct of_device_id *match;
-	int victoria_falls;
+	int multi_capable;
 	int err = -ENOMEM;
 	struct n2rng *np;
 
 	match = of_match_device(n2rng_match, &op->dev);
 	if (!match)
 		return -EINVAL;
-	victoria_falls = (match->data != NULL);
+	multi_capable = (match->data != NULL);
 
 	n2rng_driver_version();
 	np = kzalloc(sizeof(*np), GFP_KERNEL);
@@ -640,8 +640,8 @@ static int __devinit n2rng_probe(struct platform_device *op)
 
 	INIT_DELAYED_WORK(&np->work, n2rng_work);
 
-	if (victoria_falls)
-		np->flags |= N2RNG_FLAG_VF;
+	if (multi_capable)
+		np->flags |= N2RNG_FLAG_MULTI;
 
 	err = -ENODEV;
 	np->hvapi_major = 2;
@@ -658,10 +658,10 @@ static int __devinit n2rng_probe(struct platform_device *op)
 		}
 	}
 
-	if (np->flags & N2RNG_FLAG_VF) {
+	if (np->flags & N2RNG_FLAG_MULTI) {
 		if (np->hvapi_major < 2) {
-			dev_err(&op->dev, "VF RNG requires HVAPI major "
-				"version 2 or later, got %lu\n",
+			dev_err(&op->dev, "multi-unit-capable RNG requires "
+				"HVAPI major version 2 or later, got %lu\n",
 				np->hvapi_major);
 			goto out_hvapi_unregister;
 		}
@@ -688,8 +688,8 @@ static int __devinit n2rng_probe(struct platform_device *op)
 		goto out_free_units;
 
 	dev_info(&op->dev, "Found %s RNG, units: %d\n",
-		 ((np->flags & N2RNG_FLAG_VF) ?
-		  "Victoria Falls" : "Niagara2"),
+		 ((np->flags & N2RNG_FLAG_MULTI) ?
+		  "multi-unit-capable" : "single-unit"),
 		 np->num_units);
 
 	np->hwrng.name = "n2rng";
@@ -751,6 +751,11 @@ static const struct of_device_id n2rng_match[] = {
 		.compatible	= "SUNW,vf-rng",
 		.data		= (void *) 1,
 	},
+	{
+		.name		= "random-number-generator",
+		.compatible	= "SUNW,kt-rng",
+		.data		= (void *) 1,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, n2rng_match);
diff --git a/drivers/char/hw_random/n2rng.h b/drivers/char/hw_random/n2rng.h
index 4bea07f..f244ac8 100644
--- a/drivers/char/hw_random/n2rng.h
+++ b/drivers/char/hw_random/n2rng.h
@@ -68,7 +68,7 @@ struct n2rng {
 	struct platform_device	*op;
 
 	unsigned long		flags;
-#define N2RNG_FLAG_VF		0x00000001 /* Victoria Falls RNG, else N2 */
+#define N2RNG_FLAG_MULTI	0x00000001 /* Multi-unit capable RNG */
 #define N2RNG_FLAG_CONTROL	0x00000002 /* Operating in control domain */
 #define N2RNG_FLAG_READY	0x00000008 /* Ready for hw-rng layer      */
 #define N2RNG_FLAG_SHUTDOWN	0x00000010 /* Driver unregistering        */
-- 
1.7.2.5

