From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 07 Mar 2012 22:34:32 +0000
Subject: [PATCH v3 29/34] sparc/PCI: get rid of device resource fixups
Message-Id: <20120307223432.25669.51388.stgit@bhelgaas.mtv.corp.google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-arch@vger.kernel.org, linux-pci@vger.kernel.org, sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

Tell the PCI core about host bridge address translation so it can take
care of bus-to-resource conversion for us.

Previously, when enumerating PCI devices from the OF device tree, sparc
used pci_resource_adjust() to perform this address fixup for P2P bridge
windows in the following places:

    pci_cfg_fake_ranges()
    apb_fake_ranges()
    of_scan_pci_bridge()

This patch replaces pci_resource_adjust() with the generic
pcibios_bus_to_resource() and the appropriate pci_add_resource_offset()
use to tell the PCI core about host bridge apertures and offsets.

Resources of non-P2P bridge devices are set in pci_parse_of_addrs() and,
as far as I can see, never converted to CPU addresses.

CC: "David S. Miller" <davem@davemloft.net>
CC: sparclinux@vger.kernel.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/sparc/include/asm/pci_32.h |    8 ---
 arch/sparc/include/asm/pci_64.h |    8 ---
 arch/sparc/kernel/leon_pci.c    |   47 +++--------------
 arch/sparc/kernel/pci.c         |  106 +++++++++++----------------------------
 4 files changed, 38 insertions(+), 131 deletions(-)

diff --git a/arch/sparc/include/asm/pci_32.h b/arch/sparc/include/asm/pci_32.h
index 6de7f7b..6384f30 100644
--- a/arch/sparc/include/asm/pci_32.h
+++ b/arch/sparc/include/asm/pci_32.h
@@ -52,13 +52,7 @@ static inline void pci_dma_burst_advice(struct pci_dev *pdev,
  * 64Kbytes by the Host controller.
  */
 
-extern void
-pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
-			struct resource *res);
-
-extern void
-pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
-			struct pci_bus_region *region);
+#define ARCH_HAS_GENERIC_PCI_OFFSETS
 
 static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 {
diff --git a/arch/sparc/include/asm/pci_64.h b/arch/sparc/include/asm/pci_64.h
index 755a4bb..2918bd1 100644
--- a/arch/sparc/include/asm/pci_64.h
+++ b/arch/sparc/include/asm/pci_64.h
@@ -73,13 +73,7 @@ extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 			       enum pci_mmap_state mmap_state,
 			       int write_combine);
 
-extern void
-pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
-			struct resource *res);
-
-extern void
-pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
-			struct pci_bus_region *region);
+#define ARCH_HAS_GENERIC_PCI_OFFSETS
 
 static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 {
diff --git a/arch/sparc/kernel/leon_pci.c b/arch/sparc/kernel/leon_pci.c
index c7bec25..aba6b95 100644
--- a/arch/sparc/kernel/leon_pci.c
+++ b/arch/sparc/kernel/leon_pci.c
@@ -15,14 +15,19 @@
 
 /* The LEON architecture does not rely on a BIOS or bootloader to setup
  * PCI for us. The Linux generic routines are used to setup resources,
- * reset values of confuration-space registers settings ae preseved.
+ * reset values of configuration-space register settings are preserved.
+ *
+ * PCI Memory and Prefetchable Memory is direct-mapped. However I/O Space is
+ * accessed through a Window which is translated to low 64KB in PCI space, the
+ * first 4KB is not used so 60KB is available.
  */
 void leon_pci_init(struct platform_device *ofdev, struct leon_pci_info *info)
 {
 	LIST_HEAD(resources);
 	struct pci_bus *root_bus;
 
-	pci_add_resource(&resources, &info->io_space);
+	pci_add_resource_offset(&resources, &info->io_space,
+				info->io_space.start - 0x1000);
 	pci_add_resource(&resources, &info->mem_space);
 
 	root_bus = pci_scan_root_bus(&ofdev->dev, 0, info->ops, info,
@@ -38,44 +43,6 @@ void leon_pci_init(struct platform_device *ofdev, struct leon_pci_info *info)
 	}
 }
 
-/* PCI Memory and Prefetchable Memory is direct-mapped. However I/O Space is
- * accessed through a Window which is translated to low 64KB in PCI space, the
- * first 4KB is not used so 60KB is available.
- *
- * This function is used by generic code to translate resource addresses into
- * PCI addresses.
- */
-void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
-			     struct resource *res)
-{
-	struct leon_pci_info *info = dev->bus->sysdata;
-
-	region->start = res->start;
-	region->end = res->end;
-
-	if (res->flags & IORESOURCE_IO) {
-		region->start -= (info->io_space.start - 0x1000);
-		region->end -= (info->io_space.start - 0x1000);
-	}
-}
-EXPORT_SYMBOL(pcibios_resource_to_bus);
-
-/* see pcibios_resource_to_bus() comment */
-void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
-			     struct pci_bus_region *region)
-{
-	struct leon_pci_info *info = dev->bus->sysdata;
-
-	res->start = region->start;
-	res->end = region->end;
-
-	if (res->flags & IORESOURCE_IO) {
-		res->start += (info->io_space.start - 0x1000);
-		res->end += (info->io_space.start - 0x1000);
-	}
-}
-EXPORT_SYMBOL(pcibios_bus_to_resource);
-
 void __devinit pcibios_fixup_bus(struct pci_bus *pbus)
 {
 	struct leon_pci_info *info = pbus->sysdata;
diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index bb8bc2e..fdaf218 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -375,13 +375,6 @@ static void __devinit apb_calc_first_last(u8 map, u32 *first_p, u32 *last_p)
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
@@ -390,7 +383,8 @@ static void __devinit pci_cfg_fake_ranges(struct pci_dev *dev,
 					  struct pci_bus *bus,
 					  struct pci_pbm_info *pbm)
 {
-	struct resource *res;
+	struct pci_bus_region region;
+	struct resource *res, res2;
 	u8 io_base_lo, io_limit_lo;
 	u16 mem_base_lo, mem_limit_lo;
 	unsigned long base, limit;
@@ -412,11 +406,14 @@ static void __devinit pci_cfg_fake_ranges(struct pci_dev *dev,
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
@@ -428,9 +425,9 @@ static void __devinit pci_cfg_fake_ranges(struct pci_dev *dev,
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
@@ -459,9 +456,9 @@ static void __devinit pci_cfg_fake_ranges(struct pci_dev *dev,
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
 
@@ -472,6 +469,7 @@ static void __devinit apb_fake_ranges(struct pci_dev *dev,
 				      struct pci_bus *bus,
 				      struct pci_pbm_info *pbm)
 {
+	struct pci_bus_region region;
 	struct resource *res;
 	u32 first, last;
 	u8 map;
@@ -479,18 +477,18 @@ static void __devinit apb_fake_ranges(struct pci_dev *dev,
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
@@ -506,6 +504,7 @@ static void __devinit of_scan_pci_bridge(struct pci_pbm_info *pbm,
 	struct pci_bus *bus;
 	const u32 *busrange, *ranges;
 	int len, i, simba;
+	struct pci_bus_region region;
 	struct resource *res;
 	unsigned int flags;
 	u64 size;
@@ -556,8 +555,6 @@ static void __devinit of_scan_pci_bridge(struct pci_pbm_info *pbm,
 	}
 	i = 1;
 	for (; len >= 32; len -= 32, ranges += 8) {
-		struct resource *root;
-
 		flags = pci_parse_of_flags(ranges[0]);
 		size = GET_64BIT(ranges, 6);
 		if (flags = 0 || size = 0)
@@ -569,7 +566,6 @@ static void __devinit of_scan_pci_bridge(struct pci_pbm_info *pbm,
 				       " for bridge %s\n", node->full_name);
 				continue;
 			}
-			root = &pbm->io_space;
 		} else {
 			if (i >= PCI_NUM_RESOURCES - PCI_BRIDGE_RESOURCES) {
 				printk(KERN_ERR "PCI: too many memory ranges"
@@ -578,18 +574,12 @@ static void __devinit of_scan_pci_bridge(struct pci_pbm_info *pbm,
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
@@ -691,8 +681,10 @@ struct pci_bus * __devinit pci_scan_one_pbm(struct pci_pbm_info *pbm,
 
 	printk("PCI: Scanning PBM %s\n", node->full_name);
 
-	pci_add_resource(&resources, &pbm->io_space);
-	pci_add_resource(&resources, &pbm->mem_space);
+	pci_add_resource_offset(&resources, &pbm->io_space,
+				pbm->io_space.start);
+	pci_add_resource_offset(&resources, &pbm->mem_space,
+				pbm->mem_space.start);
 	bus = pci_create_root_bus(parent, pbm->pci_first_busno, pbm->pci_ops,
 				  pbm, &resources);
 	if (!bus) {
@@ -755,46 +747,6 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 	return 0;
 }
 
-void pcibios_resource_to_bus(struct pci_dev *pdev, struct pci_bus_region *region,
-			     struct resource *res)
-{
-	struct pci_pbm_info *pbm = pdev->bus->sysdata;
-	struct resource zero_res, *root;
-
-	zero_res.start = 0;
-	zero_res.end = 0;
-	zero_res.flags = res->flags;
-
-	if (res->flags & IORESOURCE_IO)
-		root = &pbm->io_space;
-	else
-		root = &pbm->mem_space;
-
-	pci_resource_adjust(&zero_res, root);
-
-	region->start = res->start - zero_res.start;
-	region->end = res->end - zero_res.start;
-}
-EXPORT_SYMBOL(pcibios_resource_to_bus);
-
-void pcibios_bus_to_resource(struct pci_dev *pdev, struct resource *res,
-			     struct pci_bus_region *region)
-{
-	struct pci_pbm_info *pbm = pdev->bus->sysdata;
-	struct resource *root;
-
-	res->start = region->start;
-	res->end = region->end;
-
-	if (res->flags & IORESOURCE_IO)
-		root = &pbm->io_space;
-	else
-		root = &pbm->mem_space;
-
-	pci_resource_adjust(res, root);
-}
-EXPORT_SYMBOL(pcibios_bus_to_resource);
-
 char * __devinit pcibios_setup(char *str)
 {
 	return str;

