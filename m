From: Yinghai Lu <yinghai@kernel.org>
Date: Fri, 21 Apr 2017 05:04:50 +0000
Subject: [PATCH 03/13] sparc/PCI: Reserve legacy mmio after PCI mmio
Message-Id: <20170421050500.13957-4-yinghai@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20170421050500.13957-1-yinghai@kernel.org>
In-Reply-To: <20170421050500.13957-1-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bhelgaas@google.com>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, Khalid Aziz <khalid.aziz@oracle.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, sparclinux@vger.kernel.org

On one system found bunch of claim resource fail from pci device.
pci_sun4v f02b894c: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x2007e00000000-0x2007e0fffffff] (bus address [0x0000-0xfffffff])
pci_bus 0000:00: root bus resource [mem 0x2000000000000-0x200007effffff] (bus address [0x00000000-0x7effffff])
pci_bus 0000:00: root bus resource [mem 0x2000100000000-0x20007ffffffff] (bus address [0x100000000-0x7ffffffff])
...
PCI: Claiming 0000:00:02.0: Resource 14: 0002000000000000..00020000004fffff [200]
pci 0000:00:02.0: can't claim BAR 14 [mem 0x2000000000000-0x20000004fffff]: address conflict with Video RAM area [??? 0x20000000a0000-0x20000000bffff flags 0x80000000]
pci 0000:02:00.0: can't claim BAR 0 [mem 0x2000000000000-0x20000000fffff]: no compatible bridge window
PCI: Claiming 0000:02:00.0: Resource 3: 0002000000100000..0002000000103fff [200]
pci 0000:02:00.0: can't claim BAR 3 [mem 0x2000000100000-0x2000000103fff]: no compatible bridge window
PCI: Claiming 0000:02:00.1: Resource 0: 0002000000200000..00020000002fffff [200]
pci 0000:02:00.1: can't claim BAR 0 [mem 0x2000000200000-0x20000002fffff]: no compatible bridge window
PCI: Claiming 0000:02:00.1: Resource 3: 0002000000104000..0002000000107fff [200]
pci 0000:02:00.1: can't claim BAR 3 [mem 0x2000000104000-0x2000000107fff]: no compatible bridge window
PCI: Claiming 0000:02:00.2: Resource 0: 0002000000300000..00020000003fffff [200]
pci 0000:02:00.2: can't claim BAR 0 [mem 0x2000000300000-0x20000003fffff]: no compatible bridge window
PCI: Claiming 0000:02:00.2: Resource 3: 0002000000108000..000200000010bfff [200]
pci 0000:02:00.2: can't claim BAR 3 [mem 0x2000000108000-0x200000010bfff]: no compatible bridge window
PCI: Claiming 0000:02:00.3: Resource 0: 0002000000400000..00020000004fffff [200]
pci 0000:02:00.3: can't claim BAR 0 [mem 0x2000000400000-0x20000004fffff]: no compatible bridge window
PCI: Claiming 0000:02:00.3: Resource 3: 000200000010c000..000200000010ffff [200]
pci 0000:02:00.3: can't claim BAR 3 [mem 0x200000010c000-0x200000010ffff]: no compatible bridge window

The bridge 00:02.0 resource does not get reserved as Video RAM take the position early,
and following children resources reservation all fail.

Move down Video RAM area reservation after pci mmio get reserved,
so we leave pci driver to use those regions.

-v5: merge simplify one and use pcibios_bus_to_resource()

-v6: use pci_find_bus_resource()

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Tested-by: Khalid Aziz <khalid.aziz@oracle.com>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/kernel/pci.c        |  1 +
 arch/sparc/kernel/pci_common.c | 59 ++++++++++++++++++++++--------------------
 arch/sparc/kernel/pci_impl.h   |  1 +
 3 files changed, 33 insertions(+), 28 deletions(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index c5cf813..adb9653 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -686,6 +686,7 @@ struct pci_bus *pci_scan_one_pbm(struct pci_pbm_info *pbm,
 	pci_bus_register_of_sysfs(bus);
 
 	pci_claim_bus_resources(bus);
+	pci_register_legacy_regions(bus);
 	pci_bus_add_devices(bus);
 	return bus;
 }
diff --git a/arch/sparc/kernel/pci_common.c b/arch/sparc/kernel/pci_common.c
index 76998f8..1ebc7ff 100644
--- a/arch/sparc/kernel/pci_common.c
+++ b/arch/sparc/kernel/pci_common.c
@@ -328,41 +328,46 @@ void pci_get_pbm_props(struct pci_pbm_info *pbm)
 	}
 }
 
-static void pci_register_legacy_regions(struct resource *io_res,
-					struct resource *mem_res)
+static void pci_register_region(struct pci_bus *bus, const char *name,
+				resource_size_t rstart, resource_size_t size)
 {
-	struct resource *p;
+	struct resource *res, *conflict, *bus_res;
+	struct pci_bus_region region;
 
-	/* VGA Video RAM. */
-	p = kzalloc(sizeof(*p), GFP_KERNEL);
-	if (!p)
+	res = kzalloc(sizeof(*res), GFP_KERNEL);
+	if (!res)
 		return;
 
-	p->name = "Video RAM area";
-	p->start = mem_res->start + 0xa0000UL;
-	p->end = p->start + 0x1ffffUL;
-	p->flags = IORESOURCE_BUSY;
-	request_resource(mem_res, p);
+	res->flags = IORESOURCE_MEM;
 
-	p = kzalloc(sizeof(*p), GFP_KERNEL);
-	if (!p)
+	region.start = rstart;
+	region.end = rstart + size - 1UL;
+	pcibios_bus_to_resource(bus, res, &region);
+	bus_res = pci_find_bus_resource(bus, res);
+	if (!bus_res) {
+		kfree(res);
 		return;
+	}
+
+	res->name = name;
+	res->flags |= IORESOURCE_BUSY;
+	conflict = request_resource_conflict(bus_res, res);
+	if (conflict) {
+		dev_printk(KERN_DEBUG, &bus->dev,
+			" can't claim %s %pR: address conflict with %s %pR\n",
+			res->name, res, conflict->name, conflict);
+		kfree(res);
+	}
+}
 
-	p->name = "System ROM";
-	p->start = mem_res->start + 0xf0000UL;
-	p->end = p->start + 0xffffUL;
-	p->flags = IORESOURCE_BUSY;
-	request_resource(mem_res, p);
+void pci_register_legacy_regions(struct pci_bus *bus)
+{
+	/* VGA Video RAM. */
+	pci_register_region(bus, "Video RAM area", 0xa0000UL, 0x20000UL);
 
-	p = kzalloc(sizeof(*p), GFP_KERNEL);
-	if (!p)
-		return;
+	pci_register_region(bus, "System ROM",     0xf0000UL, 0x10000UL);
 
-	p->name = "Video ROM";
-	p->start = mem_res->start + 0xc0000UL;
-	p->end = p->start + 0x7fffUL;
-	p->flags = IORESOURCE_BUSY;
-	request_resource(mem_res, p);
+	pci_register_region(bus, "Video ROM",      0xc0000UL,  0x8000UL);
 }
 
 static void pci_register_iommu_region(struct pci_pbm_info *pbm)
@@ -504,8 +509,6 @@ void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
 	if (pbm->mem64_space.flags)
 		request_resource(&iomem_resource, &pbm->mem64_space);
 
-	pci_register_legacy_regions(&pbm->io_space,
-				    &pbm->mem_space);
 	pci_register_iommu_region(pbm);
 }
 
diff --git a/arch/sparc/kernel/pci_impl.h b/arch/sparc/kernel/pci_impl.h
index 2853af7..ff8f5e1 100644
--- a/arch/sparc/kernel/pci_impl.h
+++ b/arch/sparc/kernel/pci_impl.h
@@ -167,6 +167,7 @@ void pci_get_pbm_props(struct pci_pbm_info *pbm);
 struct pci_bus *pci_scan_one_pbm(struct pci_pbm_info *pbm,
 				 struct device *parent);
 void pci_determine_mem_io_space(struct pci_pbm_info *pbm);
+void pci_register_legacy_regions(struct pci_bus *bus);
 
 /* Error reporting support. */
 void pci_scan_for_target_abort(struct pci_pbm_info *, struct pci_bus *);
-- 
2.9.3

