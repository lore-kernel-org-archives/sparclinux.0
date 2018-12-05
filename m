From: Rob Herring <robh@kernel.org>
Date: Wed, 05 Dec 2018 19:50:47 +0000
Subject: [PATCH] ALSA: sparc: Use of_node_name_eq for node name comparisons
Message-Id: <20181205195050.4759-31-robh@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 sound/sparc/cs4231.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/sparc/cs4231.c b/sound/sparc/cs4231.c
index e73c962590eb..f707cd4886c3 100644
--- a/sound/sparc/cs4231.c
+++ b/sound/sparc/cs4231.c
@@ -2075,12 +2075,12 @@ static int cs4231_ebus_probe(struct platform_device *op)
 static int cs4231_probe(struct platform_device *op)
 {
 #ifdef EBUS_SUPPORT
-	if (!strcmp(op->dev.of_node->parent->name, "ebus"))
+	if (of_node_name_eq(op->dev.of_node->parent, "ebus"))
 		return cs4231_ebus_probe(op);
 #endif
 #ifdef SBUS_SUPPORT
-	if (!strcmp(op->dev.of_node->parent->name, "sbus") ||
-	    !strcmp(op->dev.of_node->parent->name, "sbi"))
+	if (of_node_name_eq(op->dev.of_node->parent, "sbus") ||
+	    of_node_name_eq(op->dev.of_node->parent, "sbi"))
 		return cs4231_sbus_probe(op);
 #endif
 	return -ENODEV;
-- 
2.19.1
