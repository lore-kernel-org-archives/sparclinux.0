From: David Miller <davem@davemloft.net>
Date: Tue, 02 Sep 2008 08:05:38 +0000
Subject: [PATCH 3/3]: pci_sun4v: Use of_get_property().
Message-Id: <20080902.010538.214948254.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


pci_sun4v: Use of_get_property().

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc64/kernel/pci_sun4v.c |   21 +++++++--------------
 1 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/sparc64/kernel/pci_sun4v.c b/arch/sparc64/kernel/pci_sun4v.c
index 4839c50..6bed2f6 100644
--- a/arch/sparc64/kernel/pci_sun4v.c
+++ b/arch/sparc64/kernel/pci_sun4v.c
@@ -587,22 +587,15 @@ static unsigned long __init probe_existing_entries(struct pci_pbm_info *pbm,
 
 static int __init pci_sun4v_iommu_init(struct pci_pbm_info *pbm)
 {
+	static const u32 vdma_default[] = { 0x80000000, 0x80000000 };
 	struct iommu *iommu = pbm->iommu;
-	struct property *prop;
 	unsigned long num_tsb_entries, sz, tsbsize;
-	u32 vdma[2], dma_mask, dma_offset;
-
-	prop = of_find_property(pbm->prom_node, "virtual-dma", NULL);
-	if (prop) {
-		u32 *val = prop->value;
-
-		vdma[0] = val[0];
-		vdma[1] = val[1];
-	} else {
-		/* No property, use default values. */
-		vdma[0] = 0x80000000;
-		vdma[1] = 0x80000000;
-	}
+	u32 dma_mask, dma_offset;
+	const u32 *vdma;
+
+	vdma = of_get_property(pbm->prom_node, "virtual-dma", NULL);
+	if (!vdma)
+		vdma = vdma_default;
 
 	if ((vdma[0] | vdma[1]) & ~IO_PAGE_MASK) {
 		printk(KERN_ERR PFX "Strange virtual-dma[%08x:%08x].\n",
-- 
1.5.6.5.GIT

