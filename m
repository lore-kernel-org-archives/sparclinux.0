From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 10 Feb 2012 02:37:43 +0000
Subject: [PATCH v2 16/18] sparc/PCI: get rid of device resource fixups
Message-Id: <20120210023743.10311.96138.stgit@bhelgaas.mtv.corp.google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20120210023424.10311.82445.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120210023424.10311.82445.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

Tell the PCI core about host bridge address translation so it can take
care of bus-to-resource conversion for us.

N.B. Leon apparently never uses initial BAR values, so it didn't matter
that we never fixed up the I/O resources from bus address to CPU addresses.

Other sparc uses pci_of_scan_bus(), which sets device resources directly
to CPU addresses, not bus addresses, so it didn't need pcibios_fixup_bus()
either.  But by telling the core about the offsets, we can nuke
pcibios_resource_to_bus().

CC: "David S. Miller" <davem@davemloft.net>
CC: sparclinux@vger.kernel.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/sparc/include/asm/pci_32.h |    8 +------
 arch/sparc/include/asm/pci_64.h |    8 +------
 arch/sparc/kernel/leon_pci.c    |   47 ++++++---------------------------------
 arch/sparc/kernel/pci.c         |   46 +++-----------------------------------
 4 files changed, 13 insertions(+), 96 deletions(-)

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
index bb8bc2e..253e8ac 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -691,8 +691,10 @@ struct pci_bus * __devinit pci_scan_one_pbm(struct pci_pbm_info *pbm,
 
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
@@ -755,46 +757,6 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
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

