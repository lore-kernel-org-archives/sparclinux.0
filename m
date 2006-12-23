From: richm@oldelvet.org.uk
Date: Sat, 23 Dec 2006 23:07:26 +0000
Subject: [PATCH] sparc64: remove unused parameters from isa_dev_get_irq()
Message-Id: <11669152472131-git-send-email-richm@oldelvet.org.uk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Richard Mortimer <richm@oldelvet.org.uk>

The pregs parameter was a leftover from earlier code to query
device settings from OBP. These are no longer used and can be
safely removed.

Signed-off-by: Richard Mortimer <richm@oldelvet.org.uk>
---
 arch/sparc64/kernel/isa.c |   19 +++++++------------
 1 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/sparc64/kernel/isa.c b/arch/sparc64/kernel/isa.c
index cb556f0..da96796 100644
--- a/arch/sparc64/kernel/isa.c
+++ b/arch/sparc64/kernel/isa.c
@@ -22,7 +22,7 @@ static void __init report_dev(struct sparc_isa_device *isa_dev, int child)
 		printk(" [%s", isa_dev->prom_node->name);
 }
 
-static struct linux_prom_registers * __init
+static void __init
 isa_dev_get_resource(struct sparc_isa_device *isa_dev)
 {
 	struct linux_prom_registers *pregs;
@@ -32,7 +32,7 @@ isa_dev_get_resource(struct sparc_isa_device *isa_dev)
 	pregs = of_get_property(isa_dev->prom_node, "reg", &prop_len);
 
 	if (!pregs) {
-		return NULL;
+		return;
 	}
 
 	/* Only the first one is interesting. */
@@ -48,12 +48,9 @@ isa_dev_get_resource(struct sparc_isa_device *isa_dev)
 
 	request_resource(&isa_dev->bus->parent->io_space,
 			 &isa_dev->resource);
-
-	return pregs;
 }
 
-static void __init isa_dev_get_irq(struct sparc_isa_device *isa_dev,
-				   struct linux_prom_registers *pregs)
+static void __init isa_dev_get_irq(struct sparc_isa_device *isa_dev)
 {
 	struct of_device *op = of_find_device_by_node(isa_dev->prom_node);
 
@@ -73,7 +70,6 @@ static void __init isa_fill_children(struct sparc_isa_device *parent_isa_dev)
 
 	printk(" ->");
 	while (dp) {
-		struct linux_prom_registers *regs;
 		struct sparc_isa_device *isa_dev;
 
 		isa_dev = kzalloc(sizeof(*isa_dev), GFP_KERNEL);
@@ -89,8 +85,8 @@ static void __init isa_fill_children(struct sparc_isa_device *parent_isa_dev)
 		isa_dev->bus = parent_isa_dev->bus;
 		isa_dev->prom_node = dp;
 
-		regs = isa_dev_get_resource(isa_dev);
-		isa_dev_get_irq(isa_dev, regs);
+		isa_dev_get_resource(isa_dev);
+		isa_dev_get_irq(isa_dev);
 
 		report_dev(isa_dev, 1);
 
@@ -103,7 +99,6 @@ static void __init isa_fill_devices(struct sparc_isa_bridge *isa_br)
 	struct device_node *dp = isa_br->prom_node->child;
 
 	while (dp) {
-		struct linux_prom_registers *regs;
 		struct sparc_isa_device *isa_dev;
 
 		isa_dev = kzalloc(sizeof(*isa_dev), GFP_KERNEL);
@@ -141,8 +136,8 @@ static void __init isa_fill_devices(struct sparc_isa_bridge *isa_br)
 		isa_dev->bus = isa_br;
 		isa_dev->prom_node = dp;
 
-		regs = isa_dev_get_resource(isa_dev);
-		isa_dev_get_irq(isa_dev, regs);
+		isa_dev_get_resource(isa_dev);
+		isa_dev_get_irq(isa_dev);
 
 		report_dev(isa_dev, 0);
 
-- 
1.4.4.2

