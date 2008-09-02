From: David Miller <davem@davemloft.net>
Date: Tue, 02 Sep 2008 08:05:37 +0000
Subject: [PATCH 2/3]: pci_schizo: Use of_get_property() and delete spurious
Message-Id: <20080902.010537.125065837.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


pci_schizo: Use of_get_property() and delete spurious local vars.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc64/kernel/pci_schizo.c |   25 ++++++++-----------------
 1 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/arch/sparc64/kernel/pci_schizo.c b/arch/sparc64/kernel/pci_schizo.c
index 64904b1..e1c5657 100644
--- a/arch/sparc64/kernel/pci_schizo.c
+++ b/arch/sparc64/kernel/pci_schizo.c
@@ -1152,24 +1152,17 @@ static void schizo_pbm_strbuf_init(struct pci_pbm_info *pbm)
 
 static int schizo_pbm_iommu_init(struct pci_pbm_info *pbm)
 {
-	struct iommu *iommu = pbm->iommu;
+	static const u32 vdma_default[] = { 0xc0000000, 0x40000000 };
 	unsigned long i, tagbase, database;
-	struct property *prop;
-	u32 vdma[2], dma_mask;
+	struct iommu *iommu = pbm->iommu;
 	int tsbsize, err;
+	const u32 *vdma;
+	u32 dma_mask;
 	u64 control;
 
-	prop = of_find_property(pbm->prom_node, "virtual-dma", NULL);
-	if (prop) {
-		u32 *val = prop->value;
-
-		vdma[0] = val[0];
-		vdma[1] = val[1];
-	} else {
-		/* No property, use default values. */
-		vdma[0] = 0xc0000000;
-		vdma[1] = 0x40000000;
-	}
+	vdma = of_get_property(pbm->prom_node, "virtual-dma", NULL);
+	if (!vdma)
+		vdma = vdma_default;
 
 	dma_mask = vdma[0];
 	switch (vdma[1]) {
@@ -1284,7 +1277,6 @@ static int schizo_pbm_iommu_init(struct pci_pbm_info *pbm)
 
 static void schizo_pbm_hw_init(struct pci_pbm_info *pbm)
 {
-	struct property *prop;
 	u64 tmp;
 
 	schizo_write(pbm->pbm_regs + SCHIZO_PCI_IRQ_RETRY, 5);
@@ -1298,8 +1290,7 @@ static void schizo_pbm_hw_init(struct pci_pbm_info *pbm)
 	    pbm->chip_version >= 0x2)
 		tmp |= 0x3UL << SCHIZO_PCICTRL_PTO_SHIFT;
 
-	prop = of_find_property(pbm->prom_node, "no-bus-parking", NULL);
-	if (!prop)
+	if (!of_find_property(pbm->prom_node, "no-bus-parking", NULL))
 		tmp |= SCHIZO_PCICTRL_PARK;
 	else
 		tmp &= ~SCHIZO_PCICTRL_PARK;
-- 
1.5.6.5.GIT

