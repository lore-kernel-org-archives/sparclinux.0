From: David Miller <davem@davemloft.net>
Date: Wed, 13 Aug 2014 06:34:14 +0000
Subject: [PATCH 3/3] sparc64: Properly claim resources as each PCI bus is probed.
Message-Id: <20140812.233414.1214313377685177502.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Perform a pci_claim_resource() on all valid resources discovered
during the OF device tree scan.

Based almost entirely upon the PCI OF bus probing code which does
the same thing there.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/pci.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index cc4c31e..2e8609e 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -617,6 +617,35 @@ static void pci_bus_register_of_sysfs(struct pci_bus *bus)
 		pci_bus_register_of_sysfs(child_bus);
 }
 
+static void pci_claim_bus_resources(struct pci_bus *bus)
+{
+	struct pci_bus *child_bus;
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		int i;
+
+		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
+			struct resource *r = &dev->resource[i];
+
+			if (r->parent || !r->start || !r->flags)
+				continue;
+
+			pr_info("PCI: Claiming %s: "
+				 "Resource %d: %016llx..%016llx [%x]\n",
+				 pci_name(dev), i,
+				 (unsigned long long)r->start,
+				 (unsigned long long)r->end,
+				 (unsigned int)r->flags);
+
+			pci_claim_resource(dev, i);
+		}
+	}
+
+	list_for_each_entry(child_bus, &bus->children, node)
+		pci_claim_bus_resources(child_bus);
+}
+
 struct pci_bus *pci_scan_one_pbm(struct pci_pbm_info *pbm,
 				 struct device *parent)
 {
@@ -647,6 +676,8 @@ struct pci_bus *pci_scan_one_pbm(struct pci_pbm_info *pbm,
 	pci_bus_add_devices(bus);
 	pci_bus_register_of_sysfs(bus);
 
+	pci_claim_bus_resources(bus);
+
 	return bus;
 }
 
-- 
1.8.1.2

