From: David Miller <davem@davemloft.net>
Date: Fri, 22 Aug 2008 04:21:45 +0000
Subject: [PATCH 3/3]: of_i2c: Add Sparc support.
Message-Id: <20080821.212145.141028767.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@ozlabs.org
Cc: scottwood@freescale.com, paulus@samba.org, sparclinux@vger.kernel.org


of_i2c: Add Sparc support.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/of_i2c.h |   67 +++++++++++++++++++++++++++++++++++++++
 drivers/of/Kconfig              |    2 +-
 2 files changed, 68 insertions(+), 1 deletions(-)
 create mode 100644 arch/sparc/include/asm/of_i2c.h

diff --git a/arch/sparc/include/asm/of_i2c.h b/arch/sparc/include/asm/of_i2c.h
new file mode 100644
index 0000000..93c7c05
--- /dev/null
+++ b/arch/sparc/include/asm/of_i2c.h
@@ -0,0 +1,67 @@
+#ifndef _ASM_SPARC_OF_I2C_H
+#define _ASM_SPARC_OF_I2C_H
+
+/* In my copy of the I2C bindings for IEEE1275 the register value is
+ * encoded as a 2-cell value:
+ *
+ * Bit #    33222222 22221111 11111100 00000000
+ *          10987654 32109876 54321098 76543210
+ *
+ * bus:     00000000 00000000 00000000 bbbbbbbb
+ * address: 00000000 00000000 00000sss sssssss0
+ *
+ * where:
+ * bbbbbbbb        8-bit unsigned number representing
+ *                 the I2C bus address within this I2C bus
+ *                 controller node
+ * ssssssssss      10-bit unsigned number representing the
+ *                 slave address
+ *
+ * When doing I2C transfers to a device the low bit of the address
+ * indicates whether the transfer is a read or a write, and the upper
+ * bits indicate the device address.
+ *
+ * The Linux I2C layer wants device addresses which elide this
+ * direction bit.  Thus we should shift the OF provided reg property
+ * address down by one bit.
+ */
+static inline int of_i2c_fetch_addr(struct i2c_board_info *bp,
+				    struct device_node *client_node,
+				    struct device_node *adap_node,
+				    int num_addr_cells)
+{
+	const u32 *addr;
+	int len;
+
+	addr = of_get_property(client_node, "reg", &len);
+	if (!addr)
+		goto out_inval;
+
+	if (len < (num_addr_cells * sizeof(int)))
+		goto out_inval;
+
+	if (addr[num_addr_cells - 1] > (1 << 10) - 1)
+		goto out_inval;
+
+	switch (num_addr_cells) {
+	case 1:
+		bp->addr = addr[0];
+		break;
+
+	case 2:
+		/* XXX cell 0 contains bus number XXX */
+		bp->addr = addr[1];
+		break;
+
+	default:
+		goto out_inval;
+	}
+
+	return 0;
+
+out_inval:
+	printk(KERN_ERR "of-i2c: invalid i2c device entry\n");
+	return -EINVAL;
+}
+
+#endif /* _ASM_SPARC_OF_I2C_H */
diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index f821dbc..493c717 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -10,7 +10,7 @@ config OF_GPIO
 
 config OF_I2C
 	def_tristate I2C
-	depends on PPC_OF && I2C
+	depends on I2C
 	help
 	  OpenFirmware I2C accessors
 
-- 
1.5.6.5.GIT

