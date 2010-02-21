From: David Miller <davem@davemloft.net>
Date: Sun, 21 Feb 2010 03:58:43 +0000
Subject: [PATCH]: Create PCI slot sysfs nodes.
Message-Id: <20100220.195843.110599281.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


I just committed the following patch to sparc-next-2.6

It looks for the 'slot-names' property in PCI bus nodes and
creates PCI slot objects if found.

Ben, maybe something similar exists on PowerPC?

sparc64: If 'slot-names' property exist, create sysfs PCI slot information.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/pci.c |   75 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 592b03d..d7e1cf0 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -1094,3 +1094,78 @@ static int __init pcibios_init(void)
 	return 0;
 }
 subsys_initcall(pcibios_init);
+
+#ifdef CONFIG_SYSFS
+static void __devinit pci_bus_slot_names(struct device_node *node,
+					 struct pci_bus *bus)
+{
+	const struct pci_slot_names {
+		u32	slot_mask;
+		char	names[0];
+	} *prop;
+	const char *sp;
+	int len, i;
+	u32 mask;
+
+	prop = of_get_property(node, "slot-names", &len);
+	if (!prop)
+		return;
+
+	mask = prop->slot_mask;
+	sp = prop->names;
+
+	if (ofpci_verbose)
+		printk("PCI: Making slots for [%s] mask[0x%02x]\n",
+		       node->full_name, mask);
+
+	i = 0;
+	while (mask) {
+		struct pci_slot *pci_slot;
+		u32 this_bit = 1 << i;
+
+		if (!(mask & this_bit)) {
+			i++;
+			continue;
+		}
+
+		if (ofpci_verbose)
+			printk("PCI: Making slot [%s]\n", sp);
+
+		pci_slot = pci_create_slot(bus, i, sp, NULL);
+		if (IS_ERR(pci_slot))
+			printk(KERN_ERR "PCI: pci_create_slot returned %ld\n",
+			       PTR_ERR(pci_slot));
+
+		sp += strlen(sp) + 1;
+		mask &= ~this_bit;
+		i++;
+	}
+}
+
+static int __init of_pci_slot_init(void)
+{
+	struct pci_bus *pbus = NULL;
+
+	while ((pbus = pci_find_next_bus(pbus)) != NULL) {
+		struct device_node *node;
+
+		if (pbus->self) {
+			struct dev_archdata *sd = pbus->self->sysdata;
+
+			/* PCI->PCI bridge */
+			node = sd->prom_node;
+		} else {
+			struct pci_pbm_info *pbm = pbus->sysdata;
+
+			/* Host PCI controller */
+			node = pbm->op->node;
+		}
+
+		pci_bus_slot_names(node, pbus);
+	}
+
+	return 0;
+}
+
+module_init(of_pci_slot_init);
+#endif
-- 
1.6.6.1

