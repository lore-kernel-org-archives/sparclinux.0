From: Daniel Hellstrom <daniel@gaisler.com>
Date: Tue, 04 Jan 2011 11:41:33 +0000
Subject: [PATCH 5/7] SPARC/LEON: avoid AMBAPP name duplicates in openprom fs when REG is missing
Message-Id: <1294141295-26584-5-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

When the REG property is not available the NODE-ID is used as an unique
identifier in order to avoid filesystem name duplicates in /proc/openprom
filesystem

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/kernel/prom_32.c |   27 +++++++++++++++++++--------
 1 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/kernel/prom_32.c b/arch/sparc/kernel/prom_32.c
index 0a37e8c..05fb253 100644
--- a/arch/sparc/kernel/prom_32.c
+++ b/arch/sparc/kernel/prom_32.c
@@ -136,18 +136,29 @@ static void __init ebus_path_component(struct device_node *dp, char *tmp_buf)
 /* "name:vendor:device@irq,addrlo" */
 static void __init ambapp_path_component(struct device_node *dp, char *tmp_buf)
 {
-	struct amba_prom_registers *regs; unsigned int *intr;
-	unsigned int *device, *vendor;
+	struct amba_prom_registers *regs;
+	unsigned int *intr, *device, *vendor, reg0;
 	struct property *prop;
+	int interrupt = 0;
 
+	/* In order to get a unique ID in the device tree (multiple AMBA devices
+	 * may have the same name) the node number is printed
+	 */
 	prop = of_find_property(dp, "reg", NULL);
-	if (!prop)
-		return;
-	regs = prop->value;
+	if (!prop) {
+		reg0 = (unsigned int)dp->phandle;
+	} else {
+		regs = prop->value;
+		reg0 = regs->phys_addr;
+	}
+
+	/* Not all cores have Interrupt */
 	prop = of_find_property(dp, "interrupts", NULL);
 	if (!prop)
-		return;
-	intr = prop->value;
+		intr = &interrupt; /* IRQ0 does not exist */
+	else
+		intr = prop->value;
+
 	prop = of_find_property(dp, "vendor", NULL);
 	if (!prop)
 		return;
@@ -159,7 +170,7 @@ static void __init ambapp_path_component(struct device_node *dp, char *tmp_buf)
 
 	sprintf(tmp_buf, "%s:%d:%d@%x,%x",
 		dp->name, *vendor, *device,
-		*intr, regs->phys_addr);
+		*intr, reg0);
 }
 
 static void __init __build_path_component(struct device_node *dp, char *tmp_buf)
-- 
1.5.4

