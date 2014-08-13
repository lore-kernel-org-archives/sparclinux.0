From: David Miller <davem@davemloft.net>
Date: Wed, 13 Aug 2014 06:34:11 +0000
Subject: [PATCH 2/3] sparc64: Skip bogus PCI bridge ranges.
Message-Id: <20140812.233411.1651009555108248978.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


It seems that when a PCI Express bridge is not in use and has no devices
behind it, the ranges property is bogus.  Specifically the size property
is of the form [0xffffffff:...], and if you add this size to the resource
start address the 64-bit calculation will overflow.

Just check specifically for this size value signature and skip them.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/pci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index da24fb6..cc4c31e 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -489,6 +489,17 @@ static void of_scan_pci_bridge(struct pci_pbm_info *pbm,
 		size = GET_64BIT(ranges, 6);
 		if (flags = 0 || size = 0)
 			continue;
+
+		/* On PCI-Express systems, PCI bridges that have no devices downstream
+		 * have a bogus size value where the first 32-bit cell is 0xffffffff.
+		 * This results in a bogus range where start + size overflows.
+		 *
+		 * Just skip these otherwise the kernel will complain when the resource
+		 * tries to be claimed.
+		 */
+		if (size >> 32 = 0xffffffff)
+			continue;
+
 		if (flags & IORESOURCE_IO) {
 			res = bus->resource[0];
 			if (res->flags) {
-- 
1.8.1.2

