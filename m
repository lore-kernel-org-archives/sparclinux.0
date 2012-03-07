From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 07 Mar 2012 01:00:53 +0000
Subject: [PATCH v1 9/9] sparc/PCI: replace pci_cfg_fake_ranges() with pci_read_bridge_bases()
Message-Id: <20120307010053.27465.43061.stgit@bhelgaas.mtv.corp.google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20120307005905.27465.71131.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120307005905.27465.71131.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: sparclinux@vger.kernel.org, linux-pci@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

The generic code to read P2P bridge windows is functionally equivalent
to the sparc-specific pci_cfg_fake_ranges(), so use the generic code.

CC: "David S. Miller" <davem@davemloft.net>
CC: sparclinux@vger.kernel.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/sparc/kernel/pci.c |   92 +----------------------------------------------
 1 files changed, 1 insertions(+), 91 deletions(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index c7ad207..b4644cf 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -377,96 +377,6 @@ static void __devinit apb_calc_first_last(u8 map, u32 *first_p, u32 *last_p)
 	*last_p = last;
 }
 
-/* For PCI bus devices which lack a 'ranges' property we interrogate
- * the config space values to set the resources, just like the generic
- * Linux PCI probing code does.
- */
-static void __devinit pci_cfg_fake_ranges(struct pci_dev *dev,
-					  struct pci_bus *bus,
-					  struct pci_pbm_info *pbm)
-{
-	struct pci_bus_region region;
-	struct resource *res;
-	u8 io_base_lo, io_limit_lo;
-	u16 mem_base_lo, mem_limit_lo;
-	unsigned long io_mask, io_granularity, base, limit;
-
-	io_mask = PCI_IO_RANGE_MASK;
-	io_granularity = 0x1000;
-	if (dev->io_window_1k) {
-		/* Support 1K I/O space granularity */
-		io_mask = PCI_IO_1K_RANGE_MASK;
-		io_granularity = 0x400;
-	}
-
-	pci_read_config_byte(dev, PCI_IO_BASE, &io_base_lo);
-	pci_read_config_byte(dev, PCI_IO_LIMIT, &io_limit_lo);
-	base = (io_base_lo & io_mask) << 8;
-	limit = (io_limit_lo & io_mask) << 8;
-
-	if ((io_base_lo & PCI_IO_RANGE_TYPE_MASK) = PCI_IO_RANGE_TYPE_32) {
-		u16 io_base_hi, io_limit_hi;
-
-		pci_read_config_word(dev, PCI_IO_BASE_UPPER16, &io_base_hi);
-		pci_read_config_word(dev, PCI_IO_LIMIT_UPPER16, &io_limit_hi);
-		base |= (io_base_hi << 16);
-		limit |= (io_limit_hi << 16);
-	}
-
-	res = bus->resource[0];
-	if (base <= limit) {
-		res->flags = (io_base_lo & PCI_IO_RANGE_TYPE_MASK) | IORESOURCE_IO;
-		region.start = base;
-		region.end = limit + io_granularity - 1;
-		pcibios_bus_to_resource(dev, res, &region);
-	}
-
-	pci_read_config_word(dev, PCI_MEMORY_BASE, &mem_base_lo);
-	pci_read_config_word(dev, PCI_MEMORY_LIMIT, &mem_limit_lo);
-	base = (mem_base_lo & PCI_MEMORY_RANGE_MASK) << 16;
-	limit = (mem_limit_lo & PCI_MEMORY_RANGE_MASK) << 16;
-
-	res = bus->resource[1];
-	if (base <= limit) {
-		res->flags = ((mem_base_lo & PCI_MEMORY_RANGE_TYPE_MASK) |
-			      IORESOURCE_MEM);
-		region.start = base;
-		region.end = limit + 0xfffff;
-		pcibios_bus_to_resource(dev, res, &region);
-	}
-
-	pci_read_config_word(dev, PCI_PREF_MEMORY_BASE, &mem_base_lo);
-	pci_read_config_word(dev, PCI_PREF_MEMORY_LIMIT, &mem_limit_lo);
-	base = (mem_base_lo & PCI_PREF_RANGE_MASK) << 16;
-	limit = (mem_limit_lo & PCI_PREF_RANGE_MASK) << 16;
-
-	if ((mem_base_lo & PCI_PREF_RANGE_TYPE_MASK) = PCI_PREF_RANGE_TYPE_64) {
-		u32 mem_base_hi, mem_limit_hi;
-
-		pci_read_config_dword(dev, PCI_PREF_BASE_UPPER32, &mem_base_hi);
-		pci_read_config_dword(dev, PCI_PREF_LIMIT_UPPER32, &mem_limit_hi);
-
-		/*
-		 * Some bridges set the base > limit by default, and some
-		 * (broken) BIOSes do not initialize them.  If we find
-		 * this, just assume they are not being used.
-		 */
-		if (mem_base_hi <= mem_limit_hi) {
-			base |= ((long) mem_base_hi) << 32;
-			limit |= ((long) mem_limit_hi) << 32;
-		}
-	}
-
-	res = bus->resource[2];
-	if (base <= limit) {
-		res->flags = ((mem_base_lo & PCI_MEMORY_RANGE_TYPE_MASK) |
-			      IORESOURCE_MEM | IORESOURCE_PREFETCH);
-		region.start = base;
-		region.end = limit + 0xfffff;
-		pcibios_bus_to_resource(dev, res, &region);
-	}
-}
-
 /* Cook up fake bus resources for SUNW,simba PCI bridges which lack
  * a proper 'ranges' property.
  */
@@ -555,7 +465,7 @@ static void __devinit of_scan_pci_bridge(struct pci_pbm_info *pbm,
 		apb_fake_ranges(dev, bus, pbm);
 		goto after_ranges;
 	} else if (ranges = NULL) {
-		pci_cfg_fake_ranges(dev, bus, pbm);
+		pci_read_bridge_bases(bus);
 		goto after_ranges;
 	}
 	i = 1;

