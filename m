From: Rob Herring <robh@kernel.org>
Date: Wed, 29 Aug 2018 20:03:37 +0000
Subject: [PATCH] sbus: Use of_get_child_by_name helper
Message-Id: <20180829200337.15352-1-robh@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

Use the of_get_child_by_name() helper instead of open coding searching
for the '/options' node. This removes directly accessing the name
pointer as well.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/sbus/char/openprom.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/sbus/char/openprom.c b/drivers/sbus/char/openprom.c
index 7b31f19ade83..050879a2ddef 100644
--- a/drivers/sbus/char/openprom.c
+++ b/drivers/sbus/char/openprom.c
@@ -715,22 +715,13 @@ static struct miscdevice openprom_dev = {
 
 static int __init openprom_init(void)
 {
-	struct device_node *dp;
 	int err;
 
 	err = misc_register(&openprom_dev);
 	if (err)
 		return err;
 
-	dp = of_find_node_by_path("/");
-	dp = dp->child;
-	while (dp) {
-		if (!strcmp(dp->name, "options"))
-			break;
-		dp = dp->sibling;
-	}
-	options_node = dp;
-
+	options_node = of_get_child_by_name(of_find_node_by_path("/"), "options");
 	if (!options_node) {
 		misc_deregister(&openprom_dev);
 		return -EIO;
-- 
2.17.1
