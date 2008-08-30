From: David Miller <davem@davemloft.net>
Date: Sat, 30 Aug 2008 05:43:19 +0000
Subject: [PATCH]: sparc64: Propagate PCI device archdata into OF device
Message-Id: <20080829.224319.198110834.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


We need this to convert parport/floppy/cs4231 to pure OF device
drivers, and away from the EBUS device probing layer.

sparc64: Propagate PCI device archdata into OF device tree for EBUS.

In order to convert EBUS drivers doing DMA into pure OF drivers,
we need the of_device->dev.archdata setup properly.

EBUS instances that can provide DMA for device nodes sit on PCI,
so detect and propagate the information there.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc64/kernel/pci.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/sparc64/kernel/pci.c b/arch/sparc64/kernel/pci.c
index 9bb4b8c..71d423a 100644
--- a/arch/sparc64/kernel/pci.c
+++ b/arch/sparc64/kernel/pci.c
@@ -337,6 +337,7 @@ struct pci_dev *of_create_pci_dev(struct pci_pbm_info *pbm,
 				  struct pci_bus *bus, int devfn)
 {
 	struct dev_archdata *sd;
+	struct of_device *op;
 	struct pci_dev *dev;
 	const char *type;
 	u32 class;
@@ -350,14 +351,17 @@ struct pci_dev *of_create_pci_dev(struct pci_pbm_info *pbm,
 	sd->stc = &pbm->stc;
 	sd->host_controller = pbm;
 	sd->prom_node = node;
-	sd->op = of_find_device_by_node(node);
+	sd->op = op = of_find_device_by_node(node);
 	sd->numa_node = pbm->numa_node;
 
-	sd = &sd->op->dev.archdata;
+	sd = &op->dev.archdata;
 	sd->iommu = pbm->iommu;
 	sd->stc = &pbm->stc;
 	sd->numa_node = pbm->numa_node;
 
+	if (!strcmp(node->name, "ebus"))
+		of_propagate_archdata(op);
+
 	type = of_get_property(node, "device_type", NULL);
 	if (type = NULL)
 		type = "";
-- 
1.5.6.5.GIT

