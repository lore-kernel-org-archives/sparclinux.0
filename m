From: Yinghai Lu <yinghai@kernel.org>
Date: Fri, 21 Apr 2017 05:04:52 +0000
Subject: [PATCH 05/13] sparc/PCI: Keep resource idx order with bridge register number
Message-Id: <20170421050500.13957-6-yinghai@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20170421050500.13957-1-yinghai@kernel.org>
In-Reply-To: <20170421050500.13957-1-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bhelgaas@google.com>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, Khalid Aziz <khalid.aziz@oracle.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, sparclinux@vger.kernel.org

On one system found strange "no compatible bridge window" warning
even we already had pref_compat support that add extra pref bit for device
resource.

PCI: Claiming 0000:00:01.0: Resource 14: 0002000100000000..000200010fffffff [10220c]
PCI: Claiming 0000:01:00.0: Resource 1: 0002000100000000..000200010000ffff [100214]
pci 0000:01:00.0: can't claim BAR 1 [mem 0x2000100000000-0x200010000ffff 64bit]: no compatible bridge window

It turns out that pci_resource_compatible()/pci_up_path_over_pref_mem64()
just check resource with bridge pref mmio register idx 15, and we have put
resource to use mmio register idx 14 during of_scan_pci_bridge()
as the bridge does not have mmio resource.

We already fix pci_up_path_over_pref_mem64() to check all bus resources.

And at the same time, this patch make resource to have consistent sequence
like other arch or directly from pci_read_bridge_bases(),
even when non-pref mmio is missing, or out of ordering in firmware reporting.

Just hold i = 1 for non pref mmio, and i = 2 for pref mmio.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Tested-by: Khalid Aziz <khalid.aziz@oracle.com>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/kernel/pci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index adb9653..887441e 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -481,7 +481,7 @@ static void of_scan_pci_bridge(struct pci_pbm_info *pbm,
 		pci_read_bridge_bases(bus);
 		goto after_ranges;
 	}
-	i = 1;
+	i = 3;
 	for (; len >= 32; len -= 32, ranges += 8) {
 		u64 start;
 
@@ -513,6 +513,12 @@ static void of_scan_pci_bridge(struct pci_pbm_info *pbm,
 				       " for bridge %s\n", node->full_name);
 				continue;
 			}
+		} else if ((flags & IORESOURCE_PREFETCH) &&
+			   !bus->resource[2]->flags) {
+			res = bus->resource[2];
+		} else if (((flags & (IORESOURCE_MEM | IORESOURCE_PREFETCH)) =
+			    IORESOURCE_MEM) && !bus->resource[1]->flags) {
+			res = bus->resource[1];
 		} else {
 			if (i >= PCI_NUM_RESOURCES - PCI_BRIDGE_RESOURCES) {
 				printk(KERN_ERR "PCI: too many memory ranges"
-- 
2.9.3

