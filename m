From: David Miller <davem@davemloft.net>
Date: Thu, 28 Jul 2011 08:44:27 +0000
Subject: [PATCH 6/6] n2_crypto: Attach on Niagara-T3.
Message-Id: <20110728.014427.883746454748233812.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


A small modification was necessary since in the machine description
for 'n2cp' and 'ncp' nodes, there no longer is an 'intr' property.

That's OK because this property was always nothing more than an
array of integers '1' ... 'nr_inos + 1' so we can just compute it
in-place.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/crypto/n2_core.c |   33 ++++++++++++++++++---------------
 1 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/crypto/n2_core.c b/drivers/crypto/n2_core.c
index 2e5b204..d0183dd 100644
--- a/drivers/crypto/n2_core.c
+++ b/drivers/crypto/n2_core.c
@@ -1,6 +1,6 @@
 /* n2_core.c: Niagara2 Stream Processing Unit (SPU) crypto support.
  *
- * Copyright (C) 2010 David S. Miller <davem@davemloft.net>
+ * Copyright (C) 2010, 2011 David S. Miller <davem@davemloft.net>
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -31,8 +31,8 @@
 #include "n2_core.h"
 
 #define DRV_MODULE_NAME		"n2_crypto"
-#define DRV_MODULE_VERSION	"0.1"
-#define DRV_MODULE_RELDATE	"April 29, 2010"
+#define DRV_MODULE_VERSION	"0.2"
+#define DRV_MODULE_RELDATE	"July 28, 2011"
 
 static char version[] __devinitdata  	DRV_MODULE_NAME ".c:v" DRV_MODULE_VERSION " (" DRV_MODULE_RELDATE ")\n";
@@ -1823,22 +1823,17 @@ static int spu_mdesc_scan(struct mdesc_handle *mdesc, struct platform_device *de
 static int __devinit get_irq_props(struct mdesc_handle *mdesc, u64 node,
 				   struct spu_mdesc_info *ip)
 {
-	const u64 *intr, *ino;
-	int intr_len, ino_len;
+	const u64 *ino;
+	int ino_len;
 	int i;
 
-	intr = mdesc_get_property(mdesc, node, "intr", &intr_len);
-	if (!intr)
-		return -ENODEV;
-
 	ino = mdesc_get_property(mdesc, node, "ino", &ino_len);
-	if (!ino)
+	if (!ino) {
+		printk("NO 'ino'\n");
 		return -ENODEV;
+	}
 
-	if (intr_len != ino_len)
-		return -EINVAL;
-
-	ip->num_intrs = intr_len / sizeof(u64);
+	ip->num_intrs = ino_len / sizeof(u64);
 	ip->ino_table = kzalloc((sizeof(struct ino_blob) *
 				 ip->num_intrs),
 				GFP_KERNEL);
@@ -1847,7 +1842,7 @@ static int __devinit get_irq_props(struct mdesc_handle *mdesc, u64 node,
 
 	for (i = 0; i < ip->num_intrs; i++) {
 		struct ino_blob *b = &ip->ino_table[i];
-		b->intr = intr[i];
+		b->intr = i + 1;
 		b->ino = ino[i];
 	}
 
@@ -2204,6 +2199,10 @@ static struct of_device_id n2_crypto_match[] = {
 		.name = "n2cp",
 		.compatible = "SUNW,vf-cwq",
 	},
+	{
+		.name = "n2cp",
+		.compatible = "SUNW,kt-cwq",
+	},
 	{},
 };
 
@@ -2228,6 +2227,10 @@ static struct of_device_id n2_mau_match[] = {
 		.name = "ncp",
 		.compatible = "SUNW,vf-mau",
 	},
+	{
+		.name = "ncp",
+		.compatible = "SUNW,kt-mau",
+	},
 	{},
 };
 
-- 
1.7.2.5

