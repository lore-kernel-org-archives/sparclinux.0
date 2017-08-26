From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 26 Aug 2017 19:26:44 +0000
Subject: [PATCH] sbus: Delete an error message for a failed memory allocation in uctrl_probe()
Message-Id: <f53e3426-14b4-dceb-6599-1d15f3eeee84@users.sourceforge.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 26 Aug 2017 21:21:33 +0200

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/sbus/char/uctrl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/sbus/char/uctrl.c b/drivers/sbus/char/uctrl.c
index 0a5013350acd..f3b9f7e87ffa 100644
--- a/drivers/sbus/char/uctrl.c
+++ b/drivers/sbus/char/uctrl.c
@@ -352,10 +352,8 @@ static int uctrl_probe(struct platform_device *op)
 	int err = -ENOMEM;
 
 	p = kzalloc(sizeof(*p), GFP_KERNEL);
-	if (!p) {
-		printk(KERN_ERR "uctrl: Unable to allocate device struct.\n");
+	if (!p)
 		goto out;
-	}
 
 	p->regs = of_ioremap(&op->resource[0], 0,
 			     resource_size(&op->resource[0]),
-- 
2.14.0

