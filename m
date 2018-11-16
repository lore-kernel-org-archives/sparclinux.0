From: Rob Herring <robh@kernel.org>
Date: Fri, 16 Nov 2018 21:06:54 +0000
Subject: [PATCH v2 03/10] sparc: Convert to using %pOF instead of full_name
Message-Id: <20181116210701.22968-4-robh@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Now that we have a custom printf format specifier, convert users of
full_name to use %pOF instead. This is preparation to remove storing
of the full path string for each node.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/sparc/kernel/auxio_64.c     |  3 +--
 arch/sparc/kernel/chmc.c         |  8 +++----
 arch/sparc/kernel/of_device_32.c |  7 +++----
 arch/sparc/kernel/of_device_64.c | 36 +++++++++++++++-----------------
 arch/sparc/kernel/pci.c          | 31 +++++++++++++--------------
 arch/sparc/kernel/prom_32.c      |  4 ++--
 arch/sparc/kernel/sbus.c         |  4 ++--
 arch/sparc/kernel/sun4d_irq.c    |  8 +++----
 arch/sparc/kernel/time_64.c      | 12 +++++------
 arch/sparc/kernel/vio.c          |  2 +-
 10 files changed, 55 insertions(+), 60 deletions(-)

diff --git a/arch/sparc/kernel/auxio_64.c b/arch/sparc/kernel/auxio_64.c
index 4e8f56c3793c..6145658d915a 100644
--- a/arch/sparc/kernel/auxio_64.c
+++ b/arch/sparc/kernel/auxio_64.c
@@ -123,8 +123,7 @@ static int auxio_probe(struct platform_device *dev)
 	if (!auxio_register)
 		return -ENODEV;
 
-	printk(KERN_INFO "AUXIO: Found device at %s\n",
-	       dp->full_name);
+	printk(KERN_INFO "AUXIO: Found device at %pOF\n", dp);
 
 	if (auxio_devtype = AUXIO_TYPE_EBUS)
 		auxio_set_led(AUXIO_LED_ON);
diff --git a/arch/sparc/kernel/chmc.c b/arch/sparc/kernel/chmc.c
index 0de4bcb8261f..61fe1b951ba3 100644
--- a/arch/sparc/kernel/chmc.c
+++ b/arch/sparc/kernel/chmc.c
@@ -464,8 +464,8 @@ static int jbusmc_probe(struct platform_device *op)
 
 	mc_list_add(&p->list);
 
-	printk(KERN_INFO PFX "UltraSPARC-IIIi memory controller at %s\n",
-	       op->dev.of_node->full_name);
+	printk(KERN_INFO PFX "UltraSPARC-IIIi memory controller at %pOF\n",
+	       op->dev.of_node);
 
 	dev_set_drvdata(&op->dev, p);
 
@@ -747,8 +747,8 @@ static int chmc_probe(struct platform_device *op)
 
 	mc_list_add(&p->list);
 
-	printk(KERN_INFO PFX "UltraSPARC-III memory controller at %s [%s]\n",
-	       dp->full_name,
+	printk(KERN_INFO PFX "UltraSPARC-III memory controller at %pOF [%s]\n",
+	       dp,
 	       (p->layout_size ? "ACTIVE" : "INACTIVE"));
 
 	dev_set_drvdata(&op->dev, p);
diff --git a/arch/sparc/kernel/of_device_32.c b/arch/sparc/kernel/of_device_32.c
index e4abe9b8f97a..ab133e2753ab 100644
--- a/arch/sparc/kernel/of_device_32.c
+++ b/arch/sparc/kernel/of_device_32.c
@@ -324,8 +324,8 @@ static void __init build_device_resources(struct platform_device *op,
 		memset(r, 0, sizeof(*r));
 
 		if (of_resource_verbose)
-			printk("%s reg[%d] -> %llx\n",
-			       op->dev.of_node->full_name, index,
+			printk("%pOF reg[%d] -> %llx\n",
+			       op->dev.of_node, index,
 			       result);
 
 		if (result != OF_BAD_ADDR) {
@@ -386,8 +386,7 @@ static struct platform_device * __init scan_one_device(struct device_node *dp,
 	op->dev.dma_mask = &op->dev.coherent_dma_mask;
 
 	if (of_device_register(op)) {
-		printk("%s: Could not register of device.\n",
-		       dp->full_name);
+		printk("%pOF: Could not register of device.\n", dp);
 		kfree(op);
 		op = NULL;
 	}
diff --git a/arch/sparc/kernel/of_device_64.c b/arch/sparc/kernel/of_device_64.c
index 6df6086968c6..2353cb7bc40f 100644
--- a/arch/sparc/kernel/of_device_64.c
+++ b/arch/sparc/kernel/of_device_64.c
@@ -341,9 +341,9 @@ static void __init build_device_resources(struct platform_device *op,
 
 	/* Prevent overrunning the op->resources[] array.  */
 	if (num_reg > PROMREG_MAX) {
-		printk(KERN_WARNING "%s: Too many regs (%d), "
+		printk(KERN_WARNING "%pOF: Too many regs (%d), "
 		       "limiting to %d.\n",
-		       op->dev.of_node->full_name, num_reg, PROMREG_MAX);
+		       op->dev.of_node, num_reg, PROMREG_MAX);
 		num_reg = PROMREG_MAX;
 	}
 
@@ -401,8 +401,8 @@ static void __init build_device_resources(struct platform_device *op,
 		memset(r, 0, sizeof(*r));
 
 		if (of_resource_verbose)
-			printk("%s reg[%d] -> %llx\n",
-			       op->dev.of_node->full_name, index,
+			printk("%pOF reg[%d] -> %llx\n",
+			       op->dev.of_node, index,
 			       result);
 
 		if (result != OF_BAD_ADDR) {
@@ -548,8 +548,8 @@ static unsigned int __init build_one_device_irq(struct platform_device *op,
 					       dp->irq_trans->data);
 
 		if (of_irq_verbose)
-			printk("%s: direct translate %x --> %x\n",
-			       dp->full_name, orig_irq, irq);
+			printk("%pOF: direct translate %x --> %x\n",
+			       dp, orig_irq, irq);
 
 		goto out;
 	}
@@ -579,10 +579,9 @@ static unsigned int __init build_one_device_irq(struct platform_device *op,
 						   &irq);
 
 			if (of_irq_verbose)
-				printk("%s: Apply [%s:%x] imap --> [%s:%x]\n",
-				       op->dev.of_node->full_name,
-				       pp->full_name, this_orig_irq,
-				       of_node_full_name(iret), irq);
+				printk("%pOF: Apply [%pOF:%x] imap --> [%pOF:%x]\n",
+				       op->dev.of_node,
+				       pp, this_orig_irq, iret, irq);
 
 			if (!iret)
 				break;
@@ -597,10 +596,10 @@ static unsigned int __init build_one_device_irq(struct platform_device *op,
 
 				irq = pci_irq_swizzle(dp, pp, irq);
 				if (of_irq_verbose)
-					printk("%s: PCI swizzle [%s] "
+					printk("%pOF: PCI swizzle [%pOF] "
 					       "%x --> %x\n",
-					       op->dev.of_node->full_name,
-					       pp->full_name, this_orig_irq,
+					       op->dev.of_node,
+					       pp, this_orig_irq,
 					       irq);
 
 			}
@@ -619,8 +618,8 @@ static unsigned int __init build_one_device_irq(struct platform_device *op,
 	irq = ip->irq_trans->irq_build(op->dev.of_node, irq,
 				       ip->irq_trans->data);
 	if (of_irq_verbose)
-		printk("%s: Apply IRQ trans [%s] %x --> %x\n",
-		      op->dev.of_node->full_name, ip->full_name, orig_irq, irq);
+		printk("%pOF: Apply IRQ trans [%pOF] %x --> %x\n",
+		      op->dev.of_node, ip, orig_irq, irq);
 
 out:
 	nid = of_node_to_nid(dp);
@@ -656,9 +655,9 @@ static struct platform_device * __init scan_one_device(struct device_node *dp,
 
 		/* Prevent overrunning the op->irqs[] array.  */
 		if (op->archdata.num_irqs > PROMINTR_MAX) {
-			printk(KERN_WARNING "%s: Too many irqs (%d), "
+			printk(KERN_WARNING "%pOF: Too many irqs (%d), "
 			       "limiting to %d.\n",
-			       dp->full_name, op->archdata.num_irqs, PROMINTR_MAX);
+			       dp, op->archdata.num_irqs, PROMINTR_MAX);
 			op->archdata.num_irqs = PROMINTR_MAX;
 		}
 		memcpy(op->archdata.irqs, irq, op->archdata.num_irqs * 4);
@@ -680,8 +679,7 @@ static struct platform_device * __init scan_one_device(struct device_node *dp,
 	op->dev.dma_mask = &op->dev.coherent_dma_mask;
 
 	if (of_device_register(op)) {
-		printk("%s: Could not register of device.\n",
-		       dp->full_name);
+		printk("%pOF: Could not register of device.\n", dp);
 		kfree(op);
 		op = NULL;
 	}
diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 17ea16a1337c..45ba2757a1b9 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -431,13 +431,13 @@ static void of_scan_pci_bridge(struct pci_pbm_info *pbm,
 	u64 size;
 
 	if (ofpci_verbose)
-		pci_info(dev, "of_scan_pci_bridge(%s)\n", node->full_name);
+		pci_info(dev, "of_scan_pci_bridge(%pOF)\n", node);
 
 	/* parse bus-range property */
 	busrange = of_get_property(node, "bus-range", &len);
 	if (busrange = NULL || len != 8) {
-		pci_info(dev, "Can't get bus-range for PCI-PCI bridge %s\n",
-		       node->full_name);
+		pci_info(dev, "Can't get bus-range for PCI-PCI bridge %pOF\n",
+		       node);
 		return;
 	}
 
@@ -455,8 +455,8 @@ static void of_scan_pci_bridge(struct pci_pbm_info *pbm,
 
 	bus = pci_add_new_bus(dev->bus, dev, busrange[0]);
 	if (!bus) {
-		pci_err(dev, "Failed to create pci bus for %s\n",
-			node->full_name);
+		pci_err(dev, "Failed to create pci bus for %pOF\n",
+			node);
 		return;
 	}
 
@@ -512,13 +512,13 @@ static void of_scan_pci_bridge(struct pci_pbm_info *pbm,
 			res = bus->resource[0];
 			if (res->flags) {
 				pci_err(dev, "ignoring extra I/O range"
-					" for bridge %s\n", node->full_name);
+					" for bridge %pOF\n", node);
 				continue;
 			}
 		} else {
 			if (i >= PCI_NUM_RESOURCES - PCI_BRIDGE_RESOURCES) {
 				pci_err(dev, "too many memory ranges"
-					" for bridge %s\n", node->full_name);
+					" for bridge %pOF\n", node);
 				continue;
 			}
 			res = bus->resource[i];
@@ -554,14 +554,14 @@ static void pci_of_scan_bus(struct pci_pbm_info *pbm,
 	struct pci_dev *dev;
 
 	if (ofpci_verbose)
-		pci_info(bus, "scan_bus[%s] bus no %d\n",
-			 node->full_name, bus->number);
+		pci_info(bus, "scan_bus[%pOF] bus no %d\n",
+			 node, bus->number);
 
 	child = NULL;
 	prev_devfn = -1;
 	while ((child = of_get_next_child(node, child)) != NULL) {
 		if (ofpci_verbose)
-			pci_info(bus, "  * %s\n", child->full_name);
+			pci_info(bus, "  * %pOF\n", child);
 		reg = of_get_property(child, "reg", &reglen);
 		if (reg = NULL || reglen < 20)
 			continue;
@@ -598,7 +598,7 @@ show_pciobppath_attr(struct device * dev, struct device_attribute * attr, char *
 	pdev = to_pci_dev(dev);
 	dp = pdev->dev.of_node;
 
-	return snprintf (buf, PAGE_SIZE, "%s\n", dp->full_name);
+	return snprintf (buf, PAGE_SIZE, "%pOF\n", dp);
 }
 
 static DEVICE_ATTR(obppath, S_IRUSR | S_IRGRP | S_IROTH, show_pciobppath_attr, NULL);
@@ -698,7 +698,7 @@ struct pci_bus *pci_scan_one_pbm(struct pci_pbm_info *pbm,
 	struct device_node *node = pbm->op->dev.of_node;
 	struct pci_bus *bus;
 
-	printk("PCI: Scanning PBM %s\n", node->full_name);
+	printk("PCI: Scanning PBM %pOF\n", node);
 
 	pci_add_resource_offset(&resources, &pbm->io_space,
 				pbm->io_offset);
@@ -714,8 +714,7 @@ struct pci_bus *pci_scan_one_pbm(struct pci_pbm_info *pbm,
 	bus = pci_create_root_bus(parent, pbm->pci_first_busno, pbm->pci_ops,
 				  pbm, &resources);
 	if (!bus) {
-		printk(KERN_ERR "Failed to create bus for %s\n",
-		       node->full_name);
+		printk(KERN_ERR "Failed to create bus for %pOF\n", node);
 		pci_free_resource_list(&resources);
 		return NULL;
 	}
@@ -1111,8 +1110,8 @@ static void pci_bus_slot_names(struct device_node *node, struct pci_bus *bus)
 	sp = prop->names;
 
 	if (ofpci_verbose)
-		pci_info(bus, "Making slots for [%s] mask[0x%02x]\n",
-			 node->full_name, mask);
+		pci_info(bus, "Making slots for [%pOF] mask[0x%02x]\n",
+			 node, mask);
 
 	i = 0;
 	while (mask) {
diff --git a/arch/sparc/kernel/prom_32.c b/arch/sparc/kernel/prom_32.c
index d41e2a749c5d..daa84b2461d3 100644
--- a/arch/sparc/kernel/prom_32.c
+++ b/arch/sparc/kernel/prom_32.c
@@ -255,7 +255,7 @@ void __init of_console_init(void)
 		}
 		of_console_device = dp;
 
-		strcpy(of_console_path, dp->full_name);
+		sprintf(of_console_path, "%pOF", dp);
 		if (!strcmp(type, "serial")) {
 			strcat(of_console_path,
 			       (skip ? ":b" : ":a"));
@@ -295,7 +295,7 @@ void __init of_console_init(void)
 		of_console_device = dp;
 
 		if (prom_vers = PROM_V2) {
-			strcpy(of_console_path, dp->full_name);
+			sprintf(of_console_path, "%pOF", dp);
 			switch (*romvec->pv_stdout) {
 			case PROMDEV_TTYA:
 				strcat(of_console_path, ":a");
diff --git a/arch/sparc/kernel/sbus.c b/arch/sparc/kernel/sbus.c
index c133dfc37c5c..41c5deb581b8 100644
--- a/arch/sparc/kernel/sbus.c
+++ b/arch/sparc/kernel/sbus.c
@@ -67,8 +67,8 @@ void sbus_set_sbus64(struct device *dev, int bursts)
 
 	regs = of_get_property(op->dev.of_node, "reg", NULL);
 	if (!regs) {
-		printk(KERN_ERR "sbus_set_sbus64: Cannot find regs for %s\n",
-		       op->dev.of_node->full_name);
+		printk(KERN_ERR "sbus_set_sbus64: Cannot find regs for %pOF\n",
+		       op->dev.of_node);
 		return;
 	}
 	slot = regs->which_io;
diff --git a/arch/sparc/kernel/sun4d_irq.c b/arch/sparc/kernel/sun4d_irq.c
index d869d409fce6..6d266d7dd2b6 100644
--- a/arch/sparc/kernel/sun4d_irq.c
+++ b/arch/sparc/kernel/sun4d_irq.c
@@ -361,15 +361,15 @@ static unsigned int sun4d_build_device_irq(struct platform_device *op,
 	 * lacks a "board#" property, something is very wrong.
 	 */
 	if (!bus->parent || strcmp(bus->parent->name, bus_connection)) {
-		printk(KERN_ERR "%s: Error, parent is not %s.\n",
-			bus->full_name, bus_connection);
+		printk(KERN_ERR "%pOF: Error, parent is not %s.\n",
+			bus, bus_connection);
 		goto err_out;
 	}
 	board_parent = bus->parent;
 	board = of_getintprop_default(board_parent, "board#", -1);
 	if (board = -1) {
-		printk(KERN_ERR "%s: Error, lacks board# property.\n",
-			board_parent->full_name);
+		printk(KERN_ERR "%pOF: Error, lacks board# property.\n",
+			board_parent);
 		goto err_out;
 	}
 
diff --git a/arch/sparc/kernel/time_64.c b/arch/sparc/kernel/time_64.c
index 5f356dc8e178..68a80f9baea7 100644
--- a/arch/sparc/kernel/time_64.c
+++ b/arch/sparc/kernel/time_64.c
@@ -445,8 +445,8 @@ static int rtc_probe(struct platform_device *op)
 {
 	struct resource *r;
 
-	printk(KERN_INFO "%s: RTC regs at 0x%llx\n",
-	       op->dev.of_node->full_name, op->resource[0].start);
+	printk(KERN_INFO "%pOF: RTC regs at 0x%llx\n",
+	       op->dev.of_node, op->resource[0].start);
 
 	/* The CMOS RTC driver only accepts IORESOURCE_IO, so cons
 	 * up a fake resource so that the probe works for all cases.
@@ -501,8 +501,8 @@ static struct platform_device rtc_bq4802_device = {
 static int bq4802_probe(struct platform_device *op)
 {
 
-	printk(KERN_INFO "%s: BQ4802 regs at 0x%llx\n",
-	       op->dev.of_node->full_name, op->resource[0].start);
+	printk(KERN_INFO "%pOF: BQ4802 regs at 0x%llx\n",
+	       op->dev.of_node, op->resource[0].start);
 
 	rtc_bq4802_device.resource = &op->resource[0];
 	return platform_device_register(&rtc_bq4802_device);
@@ -565,8 +565,8 @@ static int mostek_probe(struct platform_device *op)
 	    strcmp(dp->parent->parent->name, "central") != 0)
 		return -ENODEV;
 
-	printk(KERN_INFO "%s: Mostek regs at 0x%llx\n",
-	       dp->full_name, op->resource[0].start);
+	printk(KERN_INFO "%pOF: Mostek regs at 0x%llx\n",
+	       dp, op->resource[0].start);
 
 	m48t59_rtc.resource = &op->resource[0];
 	return platform_device_register(&m48t59_rtc);
diff --git a/arch/sparc/kernel/vio.c b/arch/sparc/kernel/vio.c
index 32bae68e34c1..0b578d03797b 100644
--- a/arch/sparc/kernel/vio.c
+++ b/arch/sparc/kernel/vio.c
@@ -193,7 +193,7 @@ show_pciobppath_attr(struct device *dev, struct device_attribute *attr,
 	vdev = to_vio_dev(dev);
 	dp = vdev->dp;
 
-	return snprintf (buf, PAGE_SIZE, "%s\n", dp->full_name);
+	return snprintf (buf, PAGE_SIZE, "%pOF\n", dp);
 }
 
 static DEVICE_ATTR(obppath, S_IRUSR | S_IRGRP | S_IROTH,
-- 
2.19.1
