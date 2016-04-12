From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Tue, 12 Apr 2016 00:57:05 +0000
Subject: [PATCH] sparc/pci: Refactor dev_archdata initialization into pci_init_dev_archdata
Message-Id: <20160412005705.GF12906@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The function pcibios_add_device() added by commit d0c31e020057
("sparc/PCI: Fix for panic while enabling SR-IOV") initializes
the dev_archdata by doing a memcpy from the PF. This has the
problem that it erroneously copies the OF device without
explicitly refcounting it.

As David Miller pointed out: "Generally speaking we don't
really support hot-plug for OF probed devices, but if we did
all of the device tree pointers have to be refcounted properly."

To fix this error, and also avoid code duplication, this patch
creates a new helper function, pci_init_dev_archdata(), that
initializes the fields in dev_archdata, and can be invoked
by callers after they have taken the needed refcounts

Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Tested-by: Babu Moger <babu.moger@oracle.com>

---
 arch/sparc/kernel/pci.c |   29 +++++++++++++++++++++--------
 1 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 9f9614d..c2b202d 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -245,6 +245,18 @@ static void pci_parse_of_addrs(struct platform_device *op,
 	}
 }
 
+static void pci_init_dev_archdata(struct dev_archdata *sd, void *iommu,
+				  void *stc, void *host_controller,
+				  struct platform_device  *op,
+				  int numa_node)
+{
+	sd->iommu = iommu;
+	sd->stc = stc;
+	sd->host_controller = host_controller;
+	sd->op = op;
+	sd->numa_node = numa_node;
+}
+
 static struct pci_dev *of_create_pci_dev(struct pci_pbm_info *pbm,
 					 struct device_node *node,
 					 struct pci_bus *bus, int devfn)
@@ -259,13 +271,10 @@ static struct pci_dev *of_create_pci_dev(struct pci_pbm_info *pbm,
 	if (!dev)
 		return NULL;
 
+	op = of_find_device_by_node(node);
 	sd = &dev->dev.archdata;
-	sd->iommu = pbm->iommu;
-	sd->stc = &pbm->stc;
-	sd->host_controller = pbm;
-	sd->op = op = of_find_device_by_node(node);
-	sd->numa_node = pbm->numa_node;
-
+	pci_init_dev_archdata(sd, pbm->iommu, &pbm->stc, pbm, op,
+			      pbm->numa_node);
 	sd = &op->dev.archdata;
 	sd->iommu = pbm->iommu;
 	sd->stc = &pbm->stc;
@@ -1003,9 +1012,13 @@ int pcibios_add_device(struct pci_dev *dev)
 	 * Copy dev_archdata from PF to VF
 	 */
 	if (dev->is_virtfn) {
+		struct dev_archdata *psd;
+
 		pdev = dev->physfn;
-		memcpy(&dev->dev.archdata, &pdev->dev.archdata,
-		       sizeof(struct dev_archdata));
+		psd = &pdev->dev.archdata;
+		pci_init_dev_archdata(&dev->dev.archdata, psd->iommu,
+				      psd->stc, psd->host_controller, NULL,
+				      psd->numa_node);
 	}
 	return 0;
 }
-- 
1.7.1

