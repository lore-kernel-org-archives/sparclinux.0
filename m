From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Date: Fri, 23 Oct 2015 20:59:25 +0000
Subject: [PATCH 4/7 v2] pseries/iommu: implement DDW-aware dma_get_page_shift
Message-Id: <20151023205925.GF10197@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20151023205420.GA10197@linux.vnet.ibm.com>
In-Reply-To: <20151023205420.GA10197@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

When DDW (Dynamic DMA Windows) are present for a device, we have stored
the TCE (Translation Control Entry) size in a special device tree
property. Check if we have enabled DDW for the device and return the TCE
size from that property if present. If the property isn't present,
fallback to looking the value up in struct iommu_table. If we don't find
a iommu_table, fallback to the kernel's page size.

Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 36 ++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 0946b98..1bf6471 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -1292,6 +1292,40 @@ static u64 dma_get_required_mask_pSeriesLP(struct device *dev)
 	return dma_iommu_ops.get_required_mask(dev);
 }
 
+static unsigned long dma_get_page_shift_pSeriesLP(struct device *dev)
+{
+	struct iommu_table *tbl;
+
+	if (!disable_ddw && dev_is_pci(dev)) {
+		struct pci_dev *pdev = to_pci_dev(dev);
+		struct device_node *dn;
+
+		dn = pci_device_to_OF_node(pdev);
+
+		/* search upwards for ibm,dma-window */
+		for (; dn && PCI_DN(dn) && !PCI_DN(dn)->table_group;
+				dn = dn->parent)
+			if (of_get_property(dn, "ibm,dma-window", NULL))
+				break;
+		/*
+		 * if there is a DDW configuration, the TCE shift is stored in
+		 * the property
+		 */
+		if (dn && PCI_DN(dn)) {
+			const struct dynamic_dma_window_prop *direct64 +				of_get_property(dn, DIRECT64_PROPNAME, NULL);
+			if (direct64)
+				return be32_to_cpu(direct64->tce_shift);
+		}
+	}
+
+	tbl = get_iommu_table_base(dev);
+	if (tbl)
+		return tbl->it_page_shift;
+
+	return PAGE_SHIFT;
+}
+
 #else  /* CONFIG_PCI */
 #define pci_dma_bus_setup_pSeries	NULL
 #define pci_dma_dev_setup_pSeries	NULL
@@ -1299,6 +1333,7 @@ static u64 dma_get_required_mask_pSeriesLP(struct device *dev)
 #define pci_dma_dev_setup_pSeriesLP	NULL
 #define dma_set_mask_pSeriesLP		NULL
 #define dma_get_required_mask_pSeriesLP	NULL
+#define dma_get_page_shift_pSeriesLP	NULL
 #endif /* !CONFIG_PCI */
 
 static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
@@ -1395,6 +1430,7 @@ void iommu_init_early_pSeries(void)
 		pseries_pci_controller_ops.dma_dev_setup = pci_dma_dev_setup_pSeriesLP;
 		ppc_md.dma_set_mask = dma_set_mask_pSeriesLP;
 		ppc_md.dma_get_required_mask = dma_get_required_mask_pSeriesLP;
+		ppc_md.dma_get_page_shift = dma_get_page_shift_pSeriesLP;
 	} else {
 		pseries_pci_controller_ops.dma_bus_setup = pci_dma_bus_setup_pSeries;
 		pseries_pci_controller_ops.dma_dev_setup = pci_dma_dev_setup_pSeries;
-- 
1.9.1

