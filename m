From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 07 Mar 2012 01:00:27 +0000
Subject: [PATCH v1 4/9] sparc/PCI: convert devtree bus addresses to resource
Message-Id: <20120307010027.27465.93846.stgit@bhelgaas.mtv.corp.google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20120307005905.27465.71131.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120307005905.27465.71131.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: sparclinux@vger.kernel.org, linux-pci@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

Normal PCI enumeration via PCI config space uses __pci_read_base(), where
the PCI core applies any bus-to-resource offset.  But sparc doesn't use
that path when enumerating via the device tree.

This adds the corresponding bus-to-resource conversion in the paths that
read BAR values from the OF device tree.

CC: "David S. Miller" <davem@davemloft.net>
CC: sparclinux@vger.kernel.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/sparc/kernel/pci.c |   66 +++++++++++++++++++++--------------------------
 1 files changed, 29 insertions(+), 37 deletions(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 253e8ac..b4fbfe4 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -202,6 +202,7 @@ static void pci_parse_of_addrs(struct platform_device *op,
 			       struct device_node *node,
 			       struct pci_dev *dev)
 {
+	struct pci_bus_region region;
 	struct resource *op_res;
 	const u32 *addrs;
 	int proplen;
@@ -236,10 +237,11 @@ static void pci_parse_of_addrs(struct platform_device *op,
 			printk(KERN_ERR "PCI: bad cfg reg num 0x%x\n", i);
 			continue;
 		}
-		res->start = op_res->start;
-		res->end = op_res->end;
 		res->flags = flags;
 		res->name = pci_name(dev);
+		region.start = op_res->start;
+		region.end = op_res->end;
+		pcibios_bus_to_resource(dev, res, &region);
 	}
 }
 
@@ -375,13 +377,6 @@ static void __devinit apb_calc_first_last(u8 map, u32 *first_p, u32 *last_p)
 	*last_p = last;
 }
 
-static void pci_resource_adjust(struct resource *res,
-				struct resource *root)
-{
-	res->start += root->start;
-	res->end += root->start;
-}
-
 /* For PCI bus devices which lack a 'ranges' property we interrogate
  * the config space values to set the resources, just like the generic
  * Linux PCI probing code does.
@@ -390,7 +385,8 @@ static void __devinit pci_cfg_fake_ranges(struct pci_dev *dev,
 					  struct pci_bus *bus,
 					  struct pci_pbm_info *pbm)
 {
-	struct resource *res;
+	struct pci_bus_region region;
+	struct resource *res, res2;
 	u8 io_base_lo, io_limit_lo;
 	u16 mem_base_lo, mem_limit_lo;
 	unsigned long base, limit;
@@ -412,11 +408,14 @@ static void __devinit pci_cfg_fake_ranges(struct pci_dev *dev,
 	res = bus->resource[0];
 	if (base <= limit) {
 		res->flags = (io_base_lo & PCI_IO_RANGE_TYPE_MASK) | IORESOURCE_IO;
+		res2.flags = res->flags;
+		region.start = base;
+		region.end = limit + 0xfff;
+		pcibios_bus_to_resource(dev, &res2, &region);
 		if (!res->start)
-			res->start = base;
+			res->start = res2.start;
 		if (!res->end)
-			res->end = limit + 0xfff;
-		pci_resource_adjust(res, &pbm->io_space);
+			res->end = res2.end;
 	}
 
 	pci_read_config_word(dev, PCI_MEMORY_BASE, &mem_base_lo);
@@ -428,9 +427,9 @@ static void __devinit pci_cfg_fake_ranges(struct pci_dev *dev,
 	if (base <= limit) {
 		res->flags = ((mem_base_lo & PCI_MEMORY_RANGE_TYPE_MASK) |
 			      IORESOURCE_MEM);
-		res->start = base;
-		res->end = limit + 0xfffff;
-		pci_resource_adjust(res, &pbm->mem_space);
+		region.start = base;
+		region.end = limit + 0xfffff;
+		pcibios_bus_to_resource(dev, res, &region);
 	}
 
 	pci_read_config_word(dev, PCI_PREF_MEMORY_BASE, &mem_base_lo);
@@ -459,9 +458,9 @@ static void __devinit pci_cfg_fake_ranges(struct pci_dev *dev,
 	if (base <= limit) {
 		res->flags = ((mem_base_lo & PCI_MEMORY_RANGE_TYPE_MASK) |
 			      IORESOURCE_MEM | IORESOURCE_PREFETCH);
-		res->start = base;
-		res->end = limit + 0xfffff;
-		pci_resource_adjust(res, &pbm->mem_space);
+		region.start = base;
+		region.end = limit + 0xfffff;
+		pcibios_bus_to_resource(dev, res, &region);
 	}
 }
 
@@ -472,6 +471,7 @@ static void __devinit apb_fake_ranges(struct pci_dev *dev,
 				      struct pci_bus *bus,
 				      struct pci_pbm_info *pbm)
 {
+	struct pci_bus_region region;
 	struct resource *res;
 	u32 first, last;
 	u8 map;
@@ -479,18 +479,18 @@ static void __devinit apb_fake_ranges(struct pci_dev *dev,
 	pci_read_config_byte(dev, APB_IO_ADDRESS_MAP, &map);
 	apb_calc_first_last(map, &first, &last);
 	res = bus->resource[0];
-	res->start = (first << 21);
-	res->end = (last << 21) + ((1 << 21) - 1);
 	res->flags = IORESOURCE_IO;
-	pci_resource_adjust(res, &pbm->io_space);
+	region.start = (first << 21);
+	region.end = (last << 21) + ((1 << 21) - 1);
+	pcibios_bus_to_resource(dev, res, &region);
 
 	pci_read_config_byte(dev, APB_MEM_ADDRESS_MAP, &map);
 	apb_calc_first_last(map, &first, &last);
 	res = bus->resource[1];
-	res->start = (first << 21);
-	res->end = (last << 21) + ((1 << 21) - 1);
 	res->flags = IORESOURCE_MEM;
-	pci_resource_adjust(res, &pbm->mem_space);
+	region.start = (first << 21);
+	region.end = (last << 21) + ((1 << 21) - 1);
+	pcibios_bus_to_resource(dev, res, &region);
 }
 
 static void __devinit pci_of_scan_bus(struct pci_pbm_info *pbm,
@@ -506,6 +506,7 @@ static void __devinit of_scan_pci_bridge(struct pci_pbm_info *pbm,
 	struct pci_bus *bus;
 	const u32 *busrange, *ranges;
 	int len, i, simba;
+	struct pci_bus_region region;
 	struct resource *res;
 	unsigned int flags;
 	u64 size;
@@ -556,8 +557,6 @@ static void __devinit of_scan_pci_bridge(struct pci_pbm_info *pbm,
 	}
 	i = 1;
 	for (; len >= 32; len -= 32, ranges += 8) {
-		struct resource *root;
-
 		flags = pci_parse_of_flags(ranges[0]);
 		size = GET_64BIT(ranges, 6);
 		if (flags = 0 || size = 0)
@@ -569,7 +568,6 @@ static void __devinit of_scan_pci_bridge(struct pci_pbm_info *pbm,
 				       " for bridge %s\n", node->full_name);
 				continue;
 			}
-			root = &pbm->io_space;
 		} else {
 			if (i >= PCI_NUM_RESOURCES - PCI_BRIDGE_RESOURCES) {
 				printk(KERN_ERR "PCI: too many memory ranges"
@@ -578,18 +576,12 @@ static void __devinit of_scan_pci_bridge(struct pci_pbm_info *pbm,
 			}
 			res = bus->resource[i];
 			++i;
-			root = &pbm->mem_space;
 		}
 
-		res->start = GET_64BIT(ranges, 1);
-		res->end = res->start + size - 1;
 		res->flags = flags;
-
-		/* Another way to implement this would be to add an of_device
-		 * layer routine that can calculate a resource for a given
-		 * range property value in a PCI device.
-		 */
-		pci_resource_adjust(res, root);
+		region.start = GET_64BIT(ranges, 1);
+		region.end = region.start + size - 1;
+		pcibios_bus_to_resource(dev, res, &region);
 	}
 after_ranges:
 	sprintf(bus->name, "PCI Bus %04x:%02x", pci_domain_nr(bus),

