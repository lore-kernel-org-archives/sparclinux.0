From: Rob Herring <robh@kernel.org>
Date: Wed, 07 Nov 2018 22:31:46 +0000
Subject: [PATCH 3/8] sparc: prom: use property "name" directly to construct node names
Message-Id: <20181107223151.14991-4-robh@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20181107223151.14991-1-robh@kernel.org>
In-Reply-To: <20181107223151.14991-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

In preparation to remove direct accesses to the device_node.name
pointer, retrieve the node name from the "name" property instead.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/sparc/kernel/prom_32.c | 20 ++++++++++------
 arch/sparc/kernel/prom_64.c | 47 +++++++++++++++++++++++--------------
 2 files changed, 42 insertions(+), 25 deletions(-)

diff --git a/arch/sparc/kernel/prom_32.c b/arch/sparc/kernel/prom_32.c
index d41e2a749c5d..30e33b461970 100644
--- a/arch/sparc/kernel/prom_32.c
+++ b/arch/sparc/kernel/prom_32.c
@@ -60,6 +60,7 @@ void * __init prom_early_alloc(unsigned long size)
  */
 static void __init sparc32_path_component(struct device_node *dp, char *tmp_buf)
 {
+	const char *name = of_get_property(dp, "name", NULL);
 	struct linux_prom_registers *regs;
 	struct property *rprop;
 
@@ -69,13 +70,14 @@ static void __init sparc32_path_component(struct device_node *dp, char *tmp_buf)
 
 	regs = rprop->value;
 	sprintf(tmp_buf, "%s@%x,%x",
-		dp->name,
+		name,
 		regs->which_io, regs->phys_addr);
 }
 
 /* "name@slot,offset"  */
 static void __init sbus_path_component(struct device_node *dp, char *tmp_buf)
 {
+	const char *name = of_get_property(dp, "name", NULL);
 	struct linux_prom_registers *regs;
 	struct property *prop;
 
@@ -85,7 +87,7 @@ static void __init sbus_path_component(struct device_node *dp, char *tmp_buf)
 
 	regs = prop->value;
 	sprintf(tmp_buf, "%s@%x,%x",
-		dp->name,
+		name,
 		regs->which_io,
 		regs->phys_addr);
 }
@@ -93,6 +95,7 @@ static void __init sbus_path_component(struct device_node *dp, char *tmp_buf)
 /* "name@devnum[,func]" */
 static void __init pci_path_component(struct device_node *dp, char *tmp_buf)
 {
+	const char *name = of_get_property(dp, "name", NULL);
 	struct linux_prom_pci_registers *regs;
 	struct property *prop;
 	unsigned int devfn;
@@ -105,12 +108,12 @@ static void __init pci_path_component(struct device_node *dp, char *tmp_buf)
 	devfn = (regs->phys_hi >> 8) & 0xff;
 	if (devfn & 0x07) {
 		sprintf(tmp_buf, "%s@%x,%x",
-			dp->name,
+			name,
 			devfn >> 3,
 			devfn & 0x07);
 	} else {
 		sprintf(tmp_buf, "%s@%x",
-			dp->name,
+			name,
 			devfn >> 3);
 	}
 }
@@ -118,6 +121,7 @@ static void __init pci_path_component(struct device_node *dp, char *tmp_buf)
 /* "name@addrhi,addrlo" */
 static void __init ebus_path_component(struct device_node *dp, char *tmp_buf)
 {
+	const char *name = of_get_property(dp, "name", NULL);
 	struct linux_prom_registers *regs;
 	struct property *prop;
 
@@ -128,13 +132,14 @@ static void __init ebus_path_component(struct device_node *dp, char *tmp_buf)
 	regs = prop->value;
 
 	sprintf(tmp_buf, "%s@%x,%x",
-		dp->name,
+		name,
 		regs->which_io, regs->phys_addr);
 }
 
 /* "name:vendor:device@irq,addrlo" */
 static void __init ambapp_path_component(struct device_node *dp, char *tmp_buf)
 {
+	const char *name = of_get_property(dp, "name", NULL);
 	struct amba_prom_registers *regs;
 	unsigned int *intr, *device, *vendor, reg0;
 	struct property *prop;
@@ -168,7 +173,7 @@ static void __init ambapp_path_component(struct device_node *dp, char *tmp_buf)
 	device = prop->value;
 
 	sprintf(tmp_buf, "%s:%d:%d@%x,%x",
-		dp->name, *vendor, *device,
+		name, *vendor, *device,
 		*intr, reg0);
 }
 
@@ -196,12 +201,13 @@ static void __init __build_path_component(struct device_node *dp, char *tmp_buf)
 
 char * __init build_path_component(struct device_node *dp)
 {
+	const char *name = of_get_property(dp, "name", NULL);
 	char tmp_buf[64], *n;
 
 	tmp_buf[0] = '\0';
 	__build_path_component(dp, tmp_buf);
 	if (tmp_buf[0] = '\0')
-		strcpy(tmp_buf, dp->name);
+		strcpy(tmp_buf, name);
 
 	n = prom_early_alloc(strlen(tmp_buf) + 1);
 	strcpy(n, tmp_buf);
diff --git a/arch/sparc/kernel/prom_64.c b/arch/sparc/kernel/prom_64.c
index c37955d127fe..1667df573f6f 100644
--- a/arch/sparc/kernel/prom_64.c
+++ b/arch/sparc/kernel/prom_64.c
@@ -72,6 +72,7 @@ void * __init prom_early_alloc(unsigned long size)
  */
 static void __init sun4v_path_component(struct device_node *dp, char *tmp_buf)
 {
+	const char *name = of_get_property(dp, "name", NULL);
 	struct linux_prom64_registers *regs;
 	struct property *rprop;
 	u32 high_bits, low_bits, type;
@@ -83,7 +84,7 @@ static void __init sun4v_path_component(struct device_node *dp, char *tmp_buf)
 	regs = rprop->value;
 	if (!of_node_is_root(dp->parent)) {
 		sprintf(tmp_buf, "%s@%x,%x",
-			dp->name,
+			name,
 			(unsigned int) (regs->phys_addr >> 32UL),
 			(unsigned int) (regs->phys_addr & 0xffffffffUL));
 		return;
@@ -98,21 +99,22 @@ static void __init sun4v_path_component(struct device_node *dp, char *tmp_buf)
 
 		if (low_bits)
 			sprintf(tmp_buf, "%s@%s%x,%x",
-				dp->name, prefix,
+				name, prefix,
 				high_bits, low_bits);
 		else
 			sprintf(tmp_buf, "%s@%s%x",
-				dp->name,
+				name,
 				prefix,
 				high_bits);
 	} else if (type = 12) {
 		sprintf(tmp_buf, "%s@%x",
-			dp->name, high_bits);
+			name, high_bits);
 	}
 }
 
 static void __init sun4u_path_component(struct device_node *dp, char *tmp_buf)
 {
+	const char *name = of_get_property(dp, "name", NULL);
 	struct linux_prom64_registers *regs;
 	struct property *prop;
 
@@ -123,7 +125,7 @@ static void __init sun4u_path_component(struct device_node *dp, char *tmp_buf)
 	regs = prop->value;
 	if (!of_node_is_root(dp->parent)) {
 		sprintf(tmp_buf, "%s@%x,%x",
-			dp->name,
+			name,
 			(unsigned int) (regs->phys_addr >> 32UL),
 			(unsigned int) (regs->phys_addr & 0xffffffffUL));
 		return;
@@ -139,7 +141,7 @@ static void __init sun4u_path_component(struct device_node *dp, char *tmp_buf)
 			mask = 0x7fffff;
 
 		sprintf(tmp_buf, "%s@%x,%x",
-			dp->name,
+			name,
 			*(u32 *)prop->value,
 			(unsigned int) (regs->phys_addr & mask));
 	}
@@ -148,6 +150,7 @@ static void __init sun4u_path_component(struct device_node *dp, char *tmp_buf)
 /* "name@slot,offset"  */
 static void __init sbus_path_component(struct device_node *dp, char *tmp_buf)
 {
+	const char *name = of_get_property(dp, "name", NULL);
 	struct linux_prom_registers *regs;
 	struct property *prop;
 
@@ -157,7 +160,7 @@ static void __init sbus_path_component(struct device_node *dp, char *tmp_buf)
 
 	regs = prop->value;
 	sprintf(tmp_buf, "%s@%x,%x",
-		dp->name,
+		name,
 		regs->which_io,
 		regs->phys_addr);
 }
@@ -165,6 +168,7 @@ static void __init sbus_path_component(struct device_node *dp, char *tmp_buf)
 /* "name@devnum[,func]" */
 static void __init pci_path_component(struct device_node *dp, char *tmp_buf)
 {
+	const char *name = of_get_property(dp, "name", NULL);
 	struct linux_prom_pci_registers *regs;
 	struct property *prop;
 	unsigned int devfn;
@@ -177,12 +181,12 @@ static void __init pci_path_component(struct device_node *dp, char *tmp_buf)
 	devfn = (regs->phys_hi >> 8) & 0xff;
 	if (devfn & 0x07) {
 		sprintf(tmp_buf, "%s@%x,%x",
-			dp->name,
+			name,
 			devfn >> 3,
 			devfn & 0x07);
 	} else {
 		sprintf(tmp_buf, "%s@%x",
-			dp->name,
+			name,
 			devfn >> 3);
 	}
 }
@@ -190,6 +194,7 @@ static void __init pci_path_component(struct device_node *dp, char *tmp_buf)
 /* "name@UPA_PORTID,offset" */
 static void __init upa_path_component(struct device_node *dp, char *tmp_buf)
 {
+	const char *name = of_get_property(dp, "name", NULL);
 	struct linux_prom64_registers *regs;
 	struct property *prop;
 
@@ -204,7 +209,7 @@ static void __init upa_path_component(struct device_node *dp, char *tmp_buf)
 		return;
 
 	sprintf(tmp_buf, "%s@%x,%x",
-		dp->name,
+		name,
 		*(u32 *) prop->value,
 		(unsigned int) (regs->phys_addr & 0xffffffffUL));
 }
@@ -212,6 +217,7 @@ static void __init upa_path_component(struct device_node *dp, char *tmp_buf)
 /* "name@reg" */
 static void __init vdev_path_component(struct device_node *dp, char *tmp_buf)
 {
+	const char *name = of_get_property(dp, "name", NULL);
 	struct property *prop;
 	u32 *regs;
 
@@ -221,12 +227,13 @@ static void __init vdev_path_component(struct device_node *dp, char *tmp_buf)
 
 	regs = prop->value;
 
-	sprintf(tmp_buf, "%s@%x", dp->name, *regs);
+	sprintf(tmp_buf, "%s@%x", name, *regs);
 }
 
 /* "name@addrhi,addrlo" */
 static void __init ebus_path_component(struct device_node *dp, char *tmp_buf)
 {
+	const char *name = of_get_property(dp, "name", NULL);
 	struct linux_prom64_registers *regs;
 	struct property *prop;
 
@@ -237,7 +244,7 @@ static void __init ebus_path_component(struct device_node *dp, char *tmp_buf)
 	regs = prop->value;
 
 	sprintf(tmp_buf, "%s@%x,%x",
-		dp->name,
+		name,
 		(unsigned int) (regs->phys_addr >> 32UL),
 		(unsigned int) (regs->phys_addr & 0xffffffffUL));
 }
@@ -245,6 +252,7 @@ static void __init ebus_path_component(struct device_node *dp, char *tmp_buf)
 /* "name@bus,addr" */
 static void __init i2c_path_component(struct device_node *dp, char *tmp_buf)
 {
+	const char *name = of_get_property(dp, "name", NULL);
 	struct property *prop;
 	u32 *regs;
 
@@ -258,12 +266,13 @@ static void __init i2c_path_component(struct device_node *dp, char *tmp_buf)
 	 * property of the i2c bus node etc. etc.
 	 */
 	sprintf(tmp_buf, "%s@%x,%x",
-		dp->name, regs[0], regs[1]);
+		name, regs[0], regs[1]);
 }
 
 /* "name@reg0[,reg1]" */
 static void __init usb_path_component(struct device_node *dp, char *tmp_buf)
 {
+	const char *name = of_get_property(dp, "name", NULL);
 	struct property *prop;
 	u32 *regs;
 
@@ -275,16 +284,17 @@ static void __init usb_path_component(struct device_node *dp, char *tmp_buf)
 
 	if (prop->length = sizeof(u32) || regs[1] = 1) {
 		sprintf(tmp_buf, "%s@%x",
-			dp->name, regs[0]);
+			name, regs[0]);
 	} else {
 		sprintf(tmp_buf, "%s@%x,%x",
-			dp->name, regs[0], regs[1]);
+			name, regs[0], regs[1]);
 	}
 }
 
 /* "name@reg0reg1[,reg2reg3]" */
 static void __init ieee1394_path_component(struct device_node *dp, char *tmp_buf)
 {
+	const char *name = of_get_property(dp, "name", NULL);
 	struct property *prop;
 	u32 *regs;
 
@@ -296,10 +306,10 @@ static void __init ieee1394_path_component(struct device_node *dp, char *tmp_buf
 
 	if (regs[2] || regs[3]) {
 		sprintf(tmp_buf, "%s@%08x%08x,%04x%08x",
-			dp->name, regs[0], regs[1], regs[2], regs[3]);
+			name, regs[0], regs[1], regs[2], regs[3]);
 	} else {
 		sprintf(tmp_buf, "%s@%08x%08x",
-			dp->name, regs[0], regs[1]);
+			name, regs[0], regs[1]);
 	}
 }
 
@@ -356,12 +366,13 @@ static void __init __build_path_component(struct device_node *dp, char *tmp_buf)
 
 char * __init build_path_component(struct device_node *dp)
 {
+	const char *name = of_get_property(dp, "name", NULL);
 	char tmp_buf[64], *n;
 
 	tmp_buf[0] = '\0';
 	__build_path_component(dp, tmp_buf);
 	if (tmp_buf[0] = '\0')
-		strcpy(tmp_buf, dp->name);
+		strcpy(tmp_buf, name);
 
 	n = prom_early_alloc(strlen(tmp_buf) + 1);
 	strcpy(n, tmp_buf);
-- 
2.19.1
