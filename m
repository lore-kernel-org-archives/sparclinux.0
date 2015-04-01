From: Yinghai Lu <yinghai@kernel.org>
Date: Wed, 01 Apr 2015 02:57:49 +0000
Subject: [PATCH 3/3] PCI: Set pref for mem64 resource of pcie device
Message-Id: <1427857069-6789-4-git-send-email-yinghai@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1427857069-6789-1-git-send-email-yinghai@kernel.org>
In-Reply-To: <1427857069-6789-1-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bhelgaas@google.com>, David Miller <davem@davemloft.net>
Cc: David Ahern <david.ahern@oracle.com>, linux-pci@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, stable@vger.kernel.org

We still get "no compatible bridge window" warning on sparc T5-8
after we add support for 64bit resource parsing for root bus.

 PCI: scan_bus[/pci@300/pci@1/pci@0/pci@6] bus no 8
 PCI: Claiming 0000:00:01.0: Resource 15: 0000800100000000..00008004afffffff [220c]
 PCI: Claiming 0000:01:00.0: Resource 15: 0000800100000000..00008004afffffff [220c]
 PCI: Claiming 0000:02:04.0: Resource 15: 0000800100000000..000080012fffffff [220c]
 PCI: Claiming 0000:03:00.0: Resource 15: 0000800100000000..000080012fffffff [220c]
 PCI: Claiming 0000:04:06.0: Resource 14: 0000800100000000..000080010fffffff [220c]
 PCI: Claiming 0000:05:00.0: Resource 0: 0000800100000000..0000800100001fff [204]
 pci 0000:05:00.0: can't claim BAR 0 [mem 0x800100000000-0x800100001fff]: no compatible bridge window

All the bridges 64-bit resource have pref bit, but the device resource does not
have pref set, then we can not find parent for the device resource,
as we can not put non-pref mem under pref mem.

According to pcie spec errta
https://www.pcisig.com/specifications/pciexpress/base2/PCIe_Base_r2.1_Errata_08Jun10.pdf
page 13, in some case it is ok to mark some as pref.

Only set pref for 64bit mmio when the entire path from the host to the adapter is
over PCI Express.

Fixes: commit d63e2e1f3df9 ("sparc/PCI: Clip bridge windows to fit in upstream windows")
Link: http://lkml.kernel.org/r/CAE9FiQU1gJY1LYrxs+ma5LCTEEe4xmtjRG0aXJ9K_Tsu+m9Wuw@mail.gmail.com
Reported-by: David Ahern <david.ahern@oracle.com>
Tested-by: David Ahern <david.ahern@oracle.com>
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: <stable@vger.kernel.org> #3.19
---
 drivers/pci/probe.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index f71cb7c..4e0cd46 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1507,6 +1507,53 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_enable_acs(dev);
 }
 
+static bool pci_up_path_over_pcie(struct pci_bus *bus)
+{
+	if (!bus)
+		return true;
+
+	if (bus->self && !pci_is_pcie(bus->self))
+		return false;
+
+	return pci_up_path_over_pcie(bus->parent);
+}
+
+/*
+ * According to
+ * https://www.pcisig.com/specifications/pciexpress/base2/PCIe_Base_r2.1_Errata_08Jun10.pdf
+ * page 13, system firmware could put some 64bit non-pref under 64bit pref,
+ * on some cases.
+ * Let's set pref bit for 64bit mmio when entire path from the host to
+ * the adapter is over PCI Express.
+ */
+static void set_pcie_64bit_pref(struct pci_dev *dev)
+{
+	int i;
+
+	if (!pci_is_pcie(dev))
+		return;
+
+	if (!pci_up_path_over_pcie(dev->bus))
+		return;
+
+	for (i = 0; i < PCI_BRIDGE_RESOURCES; i++) {
+		struct resource *res = &dev->resource[i];
+		enum pci_bar_type type;
+		int reg;
+
+		if (!(res->flags & IORESOURCE_MEM_64))
+			continue;
+
+		if (res->flags & IORESOURCE_PREFETCH)
+			continue;
+
+		reg = pci_resource_bar(dev, i, &type);
+		dev_printk(KERN_DEBUG, &dev->dev, "reg 0x%x %pR + pref\n",
+			   reg, res);
+		res->flags |= IORESOURCE_PREFETCH;
+	}
+}
+
 void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 {
 	int ret;
@@ -1536,6 +1583,9 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	/* Initialize various capabilities */
 	pci_init_capabilities(dev);
 
+	/* After pcie_cap is assigned and sriov bar is probed */
+	set_pcie_64bit_pref(dev);
+
 	/*
 	 * Add the device to our list of discovered devices
 	 * and the bus list for fixup functions, etc.
-- 
1.8.4.5

