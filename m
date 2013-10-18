From: Kjetil Oftedal <oftedal@gmail.com>
Date: Fri, 18 Oct 2013 20:28:29 +0000
Subject: [PATCH] sparc: PCI: Fix incorrect address calculation of PCI Bridge windows on Simba-bridges
Message-Id: <Pine.LNX.4.64.1310182159280.5208@oizys.tordivel.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The SIMBA APB Bridges lacks the 'ranges' of-property describing the 
PCI I/O and memory areas located beneath the bridge. Faking this 
information has been performed by reading range registers in the 
APB bridge, and calculating the corresponding areas.

In commit 01f94c4a6ced476ce69b895426fc29bfc48c69bd 
("Fix sabre pci controllers with new probing scheme.") a bug was 
introduced into this calculation, causing the PCI memory areas 
to be calculated incorrectly: The shift size was set to be 
identical for I/O and MEM ranges, which is incorrect.

This patch set the shift size of the MEM range back to the 
value used before 01f94c4a6ced476ce69b895426fc29bfc48c69bd.

Signed-off-by: Kjetil Oftedal <oftedal@gmail.com>
---
 arch/sparc/kernel/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index bc4d3f5..cb02145 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -398,8 +398,8 @@ static void apb_fake_ranges(struct pci_dev *dev,
 	apb_calc_first_last(map, &first, &last);
 	res = bus->resource[1];
 	res->flags = IORESOURCE_MEM;
-	region.start = (first << 21);
-	region.end = (last << 21) + ((1 << 21) - 1);
+	region.start = (first << 29);
+	region.end = (last << 29) + ((1 << 29) - 1);
 	pcibios_bus_to_resource(dev, res, &region);
 }
 
