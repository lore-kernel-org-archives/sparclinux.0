From: David Miller <davem@davemloft.net>
Date: Fri, 22 Aug 2008 04:22:01 +0000
Subject: [PATCH 2/3]: of_i2c: Abstract out register property interpretation.
Message-Id: <20080821.212201.252967290.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@ozlabs.org
Cc: scottwood@freescale.com, paulus@samba.org, sparclinux@vger.kernel.org


of_i2c: Abstract out register property interpretation.

Pull out client I2C device address calculation into a
helper function, of_i2c_fetch_addr.

At the top level we try to determine the reported
#address-cells property in the I2C bus adapter node,
and default to "1" if the property is not found.

We pass this down to of_i2c_fetch_addr() so that it does
not have to do this probe every iteration.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/powerpc/include/asm/of_i2c.h |   24 ++++++++++++++++++++++++
 drivers/of/of_i2c.c               |   26 ++++++++++++++++----------
 2 files changed, 40 insertions(+), 10 deletions(-)
 create mode 100644 arch/powerpc/include/asm/of_i2c.h

diff --git a/arch/powerpc/include/asm/of_i2c.h b/arch/powerpc/include/asm/of_i2c.h
new file mode 100644
index 0000000..501a24b
--- /dev/null
+++ b/arch/powerpc/include/asm/of_i2c.h
@@ -0,0 +1,24 @@
+#ifndef _ASM_POWERPC_OF_I2C_H
+#define _ASM_POWERPC_OF_I2C_H
+
+static inline int of_i2c_fetch_addr(struct i2c_board_info *bp,
+				    struct device_node *client_node,
+				    struct device_node *adap_node,
+				    int num_addr_cells)
+{
+	const u32 *addr;
+	int len;
+
+	addr = of_get_property(client_node, "reg", &len);
+	if (!addr || len < (num_addr_cells * sizeof(int)) ||
+	    addr[num_addr_cells - 1] > (1 << 10) - 1) {
+		printk(KERN_ERR "of-i2c: invalid i2c device entry\n");
+		return -EINVAL;
+	}
+
+	bp->addr = addr[num_addr_cells - 1];
+
+	return 0;
+}
+
+#endif /* _ASM_POWERPC_OF_I2C_H */
diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
index 6a98dc8..387c74e 100644
--- a/drivers/of/of_i2c.c
+++ b/drivers/of/of_i2c.c
@@ -16,31 +16,37 @@
 #include <linux/of_i2c.h>
 #include <linux/module.h>
 
+#include <asm/of_i2c.h>
+
 void of_register_i2c_devices(struct i2c_adapter *adap,
 			     struct device_node *adap_node)
 {
-	void *result;
 	struct device_node *node;
+	int num_addr_cells = 1;
+	const int *n_cells;
+	void *result;
+
+	n_cells = of_get_property(adap_node, "#address-cells", NULL);
+	if (n_cells)
+		num_addr_cells = *n_cells;
+
+	if (num_addr_cells != 1 && num_addr_cells != 2) {
+		printk(KERN_ERR "of-i2c: invalid address cells %d\n",
+		       num_addr_cells);
+		return;
+	}
 
 	for_each_child_of_node(adap_node, node) {
 		struct i2c_board_info info = {};
-		const u32 *addr;
-		int len;
 
 		if (of_modalias_node(node, info.type, sizeof(info.type)) < 0)
 			continue;
 
-		addr = of_get_property(node, "reg", &len);
-		if (!addr || len < sizeof(int) || *addr > (1 << 10) - 1) {
-			printk(KERN_ERR
-			       "of-i2c: invalid i2c device entry\n");
+		if (of_i2c_fetch_addr(&info, node, adap_node, num_addr_cells))
 			continue;
-		}
 
 		info.irq = irq_of_parse_and_map(node, 0);
 
-		info.addr = *addr;
-
 		request_module(info.type);
 
 		result = i2c_new_device(adap, &info);
-- 
1.5.6.5.GIT

