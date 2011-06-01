From: Kjetil Oftedal <oftedal@gmail.com>
Date: Wed, 01 Jun 2011 21:11:41 +0000
Subject: [PATCH 3/3] Add support for allocating irqs for bootbus devices
Message-Id: <Pine.LNX.4.64.1106012304260.16937@oizys.tordivel.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Some devices that can generate interrupts are connected directly to the 
CPU through the bootbus on sun4d. This patch allows IRQs to be allocated 
for such devices. The information used for allocating interrupts for 
sbus devices are present at the corresponding SBI node. For bootbus 
devices this information is present in the bootbus node.

Signed-off-by: Kjetil Oftedal <oftedal@gmail.com>
---
 arch/sparc/kernel/sun4d_irq.c |   48 
+++++++++++++++++++++++------------------
 1 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/arch/sparc/kernel/sun4d_irq.c b/arch/sparc/kernel/sun4d_irq.c
index eaec8a9..1d13c5b 100644
--- a/arch/sparc/kernel/sun4d_irq.c
+++ b/arch/sparc/kernel/sun4d_irq.c
@@ -334,7 +334,8 @@ unsigned int sun4d_build_device_irq(struct platform_device *op,
                                     unsigned int real_irq)
 {
 	struct device_node *dp = op->dev.of_node;
-	struct device_node *io_unit, *sbi = dp->parent;
+	struct device_node *board_parent, *bus = dp->parent;
+	char *bus_connection;
 	const struct linux_prom_registers *regs;
 	unsigned int pil;
 	unsigned int irq;
@@ -342,13 +343,20 @@ unsigned int sun4d_build_device_irq(struct platform_device *op,
 	int sbusl;
 
 	irq = real_irq;
-	while (sbi) {
-		if (!strcmp(sbi->name, "sbi"))
+	while (bus) {
+		if (!strcmp(bus->name, "sbi")) {
+			bus_connection = "io-unit";
 			break;
+		}
+
+		if (!strcmp(bus->name, "bootbus")) {
+			bus_connection = "cpu-unit";
+			break;
+		}
 
-		sbi = sbi->parent;
+		bus = bus->parent;
 	}
-	if (!sbi)
+	if (!bus)
 		goto err_out;
 
 	regs = of_get_property(dp, "reg", NULL);
@@ -358,17 +366,19 @@ unsigned int sun4d_build_device_irq(struct platform_device *op,
 	slot = regs->which_io;
 
 	/*
-	 *  If SBI's parent is not io-unit or the io-unit lacks
-	 * a "board#" property, something is very wrong.
+	 * If Bus nodes parent is not io-unit/cpu-unit or the io-unit/cpu-unit
+	 * lacks a "board#" property, something is very wrong.
 	 */
-	if (!sbi->parent || strcmp(sbi->parent->name, "io-unit")) {
-		printk("%s: Error, parent is not io-unit.\n", sbi->full_name);
+	if (!bus->parent || strcmp(bus->parent->name, bus_connection)) {
+		printk(KERN_ERR "%s: Error, parent is not %s.\n",
+			bus->full_name, bus_connection);
 		goto err_out;
 	}
-	io_unit = sbi->parent;
-	board = of_getintprop_default(io_unit, "board#", -1);
+	board_parent = bus->parent;
+	board = of_getintprop_default(board_parent, "board#", -1);
 	if (board = -1) {
-		printk("%s: Error, lacks board# property.\n", io_unit->full_name);
+		printk(KERN_ERR "%s: Error, lacks board# property.\n",
+			board_parent->full_name);
 		goto err_out;
 	}
 
