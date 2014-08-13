From: David Miller <davem@davemloft.net>
Date: Wed, 13 Aug 2014 06:34:05 +0000
Subject: [PATCH 1/3] sparc64: Expand PCI bridge probing debug logging.
Message-Id: <20140812.233405.1754149695816034237.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Dump the various aspects of the PCI bridge probed at boot time, most
importantly the bridge number ranges, and the ranges property.

This helps diagnose PCI resource issues and other problems by giving
ofpci_debug=1 on the boot command line.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/pci.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 539babf..da24fb6 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -432,6 +432,11 @@ static void of_scan_pci_bridge(struct pci_pbm_info *pbm,
 		       node->full_name);
 		return;
 	}
+
+	if (ofpci_verbose)
+		printk("    Bridge bus range [%u --> %u]\n",
+		       busrange[0], busrange[1]);
+
 	ranges = of_get_property(node, "ranges", &len);
 	simba = 0;
 	if (ranges = NULL) {
@@ -451,6 +456,10 @@ static void of_scan_pci_bridge(struct pci_pbm_info *pbm,
 	pci_bus_insert_busn_res(bus, busrange[0], busrange[1]);
 	bus->bridge_ctl = 0;
 
+	if (ofpci_verbose)
+		printk("    Bridge ranges[%p] simba[%d]\n",
+		       ranges, simba);
+
 	/* parse ranges property, or cook one up by hand for Simba */
 	/* PCI #address-cells = 3 and #size-cells = 2 always */
 	res = &dev->resource[PCI_BRIDGE_RESOURCES];
@@ -468,6 +477,14 @@ static void of_scan_pci_bridge(struct pci_pbm_info *pbm,
 	}
 	i = 1;
 	for (; len >= 32; len -= 32, ranges += 8) {
+		u64 start;
+
+		if (ofpci_verbose)
+			printk("    RAW Range[%08x:%08x:%08x:%08x:%08x:%08x:"
+			       "%08x:%08x]\n",
+			       ranges[0], ranges[1], ranges[2], ranges[3],
+			       ranges[4], ranges[5], ranges[6], ranges[7]);
+
 		flags = pci_parse_of_flags(ranges[0]);
 		size = GET_64BIT(ranges, 6);
 		if (flags = 0 || size = 0)
@@ -490,8 +507,13 @@ static void of_scan_pci_bridge(struct pci_pbm_info *pbm,
 		}
 
 		res->flags = flags;
-		region.start = GET_64BIT(ranges, 1);
+		region.start = start = GET_64BIT(ranges, 1);
 		region.end = region.start + size - 1;
+
+		if (ofpci_verbose)
+			printk("      Using flags[%08x] start[%016llx] size[%016llx]\n",
+			       flags, start, size);
+
 		pcibios_bus_to_resource(dev->bus, res, &region);
 	}
 after_ranges:
-- 
1.8.1.2

