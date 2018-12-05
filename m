From: Rob Herring <robh@kernel.org>
Date: Wed, 05 Dec 2018 19:50:38 +0000
Subject: [PATCH] sbus: Use of_node_name_eq for node name comparisons
Message-Id: <20181205195050.4759-22-robh@kernel.org>
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
 drivers/sbus/char/bbc_envctrl.c | 4 ++--
 drivers/sbus/char/envctrl.c     | 6 +++---
 drivers/sbus/char/flash.c       | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/sbus/char/bbc_envctrl.c b/drivers/sbus/char/bbc_envctrl.c
index fb5bcf6dddc1..4f2dd21e44a0 100644
--- a/drivers/sbus/char/bbc_envctrl.c
+++ b/drivers/sbus/char/bbc_envctrl.c
@@ -571,9 +571,9 @@ int bbc_envctrl_init(struct bbc_i2c_bus *bp)
 	int devidx = 0;
 
 	while ((op = bbc_i2c_getdev(bp, devidx++)) != NULL) {
-		if (!strcmp(op->dev.of_node->name, "temperature"))
+		if (of_node_name_eq(op->dev.of_node, "temperature"))
 			attach_one_temp(bp, op, temp_index++);
-		if (!strcmp(op->dev.of_node->name, "fan-control"))
+		if (of_node_name_eq(op->dev.of_node, "fan-control"))
 			attach_one_fan(bp, op, fan_index++);
 	}
 	if (temp_index != 0 && fan_index != 0) {
diff --git a/drivers/sbus/char/envctrl.c b/drivers/sbus/char/envctrl.c
index 56e962a01493..08b7d25c1136 100644
--- a/drivers/sbus/char/envctrl.c
+++ b/drivers/sbus/char/envctrl.c
@@ -906,7 +906,7 @@ static void envctrl_init_i2c_child(struct device_node *dp,
 		int len;
 
 		root_node = of_find_node_by_path("/");
-		if (!strcmp(root_node->name, "SUNW,UltraSPARC-IIi-cEngine")) {
+		if (of_node_name_eq(root_node, "SUNW,UltraSPARC-IIi-cEngine")) {
 			for (len = 0; len < PCF8584_MAX_CHANNELS; ++len) {
 				pchild->mon_type[len] = ENVCTRL_NOMON;
 			}
@@ -1037,10 +1037,10 @@ static int envctrl_probe(struct platform_device *op)
 	index = 0;
 	dp = op->dev.of_node->child;
 	while (dp) {
-		if (!strcmp(dp->name, "gpio")) {
+		if (of_node_name_eq(dp, "gpio")) {
 			i2c_childlist[index].i2ctype = I2C_GPIO;
 			envctrl_init_i2c_child(dp, &(i2c_childlist[index++]));
-		} else if (!strcmp(dp->name, "adc")) {
+		} else if (of_node_name_eq(dp, "adc")) {
 			i2c_childlist[index].i2ctype = I2C_ADC;
 			envctrl_init_i2c_child(dp, &(i2c_childlist[index++]));
 		}
diff --git a/drivers/sbus/char/flash.c b/drivers/sbus/char/flash.c
index a610b8d3d11f..515dc1ff1e33 100644
--- a/drivers/sbus/char/flash.c
+++ b/drivers/sbus/char/flash.c
@@ -165,9 +165,9 @@ static int flash_probe(struct platform_device *op)
 
 	parent = dp->parent;
 
-	if (strcmp(parent->name, "sbus") &&
-	    strcmp(parent->name, "sbi") &&
-	    strcmp(parent->name, "ebus"))
+	if (!of_node_name_eq(parent, "sbus") &&
+	    !of_node_name_eq(parent, "sbi") &&
+	    !of_node_name_eq(parent, "ebus"))
 		return -ENODEV;
 
 	flash.read_base = op->resource[0].start;
-- 
2.19.1
