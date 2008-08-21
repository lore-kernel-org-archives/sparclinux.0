From: David Miller <davem@davemloft.net>
Date: Thu, 21 Aug 2008 07:10:22 +0000
Subject: [PATCH 2/3]: of_i2c: Add sparc support.
Message-Id: <20080821.001022.25151381.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@ozlabs.org
Cc: sparclinux@vger.kernel.org, paulus@samba.org


of_i2c: Add sparc support.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/of/Kconfig  |    2 +-
 drivers/of/of_i2c.c |   58 ++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index f821dbc..67dea24 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -10,7 +10,7 @@ config OF_GPIO
 
 config OF_I2C
 	def_tristate I2C
-	depends on PPC_OF && I2C
+	depends on OF && I2C
 	help
 	  OpenFirmware I2C accessors
 
diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
index 6a98dc8..beb4102 100644
--- a/drivers/of/of_i2c.c
+++ b/drivers/of/of_i2c.c
@@ -19,8 +19,20 @@
 void of_register_i2c_devices(struct i2c_adapter *adap,
 			     struct device_node *adap_node)
 {
-	void *result;
 	struct device_node *node;
+	int num_addr_cells = 1;
+	const int *prop;
+	void *result;
+
+	prop = of_get_property(adap_node, "#address-cells", NULL);
+	if (prop)
+		num_addr_cells = *prop;
+
+	if (num_addr_cells != 1 && num_addr_cells != 2) {
+		printk(KERN_ERR "of-i2c: invalid address cells %d\n",
+		       num_addr_cells);
+		return;
+	}
 
 	for_each_child_of_node(adap_node, node) {
 		struct i2c_board_info info = {};
@@ -31,16 +43,48 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
 			continue;
 
 		addr = of_get_property(node, "reg", &len);
-		if (!addr || len < sizeof(int) || *addr > (1 << 10) - 1) {
-			printk(KERN_ERR
-			       "of-i2c: invalid i2c device entry\n");
+		if (!addr || len < (num_addr_cells * sizeof(int))) {
+			printk(KERN_ERR "of-i2c: invalid i2c device entry\n");
 			continue;
 		}
+		switch (num_addr_cells) {
+		case 1:
+			info.addr = addr[0];
+			break;
+		case 2:
+			/* XXX addr[0], the first cell, is bus number XXX */
+			info.addr = addr[1];
+			break;
+		}
 
+#ifdef CONFIG_SPARC
+		/* In my copy of the I2C bindings for IEEE1275 the
+		 * register value is encoded as a 2-cell value:
+		 *
+		 * Bit #    33222222 22221111 11111100 00000000
+		 *          10987654 32109876 54321098 76543210
+		 *
+		 * bus:     00000000 00000000 00000000 bbbbbbbb
+		 * address: 00000000 00000000 00000sss sssssss0
+		 *
+		 * where:
+		 * bbbbbbbb        8-bit unsigned number representing
+		 *                 the I2C bus address within this I2C bus
+		 *                 controller node
+		 * ssssssssss      10-bit unsigned number representing the
+		 *                 slave address
+		 *
+		 * When doing I2C transfers to a device the low bit of
+		 * the address indicates whether the transfer is a read or
+		 * a write, and the upper bits indicate the device address.
+		 *
+		 * The Linux I2C layer wants device addresses which elide this
+		 * direction bit.  Thus we should shift the OF provided reg
+		 * property address down by one bit.
+		 */
+		info.addr >>= 1;
+#endif
 		info.irq = irq_of_parse_and_map(node, 0);
-
-		info.addr = *addr;
-
 		request_module(info.type);
 
 		result = i2c_new_device(adap, &info);
-- 
1.5.6.5.GIT

