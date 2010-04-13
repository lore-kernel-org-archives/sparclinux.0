From: David Miller <davem@davemloft.net>
Date: Tue, 13 Apr 2010 06:49:04 +0000
Subject: [PATCH 3/3] sparc64: Fix memory leak in
Message-Id: <20100412.234904.109075583.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Found by kmemleak.

If request_resource() fails, we leak the struct resource we
allocated to represent the IOMMU mapping area.

This actually happens on sun4v machines because the IOMEM area is only
reported sans the IOMMU region, unlike all previous systems.  I'll
need to fix that at some point, but for now fix the leak.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/pci_common.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/pci_common.c b/arch/sparc/kernel/pci_common.c
index b775658..8a00058 100644
--- a/arch/sparc/kernel/pci_common.c
+++ b/arch/sparc/kernel/pci_common.c
@@ -371,14 +371,19 @@ static void pci_register_iommu_region(struct pci_pbm_info *pbm)
 		struct resource *rp = kzalloc(sizeof(*rp), GFP_KERNEL);
 
 		if (!rp) {
-			prom_printf("Cannot allocate IOMMU resource.\n");
-			prom_halt();
+			pr_info("%s: Cannot allocate IOMMU resource.\n",
+				pbm->name);
+			return;
 		}
 		rp->name = "IOMMU";
 		rp->start = pbm->mem_space.start + (unsigned long) vdma[0];
 		rp->end = rp->start + (unsigned long) vdma[1] - 1UL;
 		rp->flags = IORESOURCE_BUSY;
-		request_resource(&pbm->mem_space, rp);
+		if (request_resource(&pbm->mem_space, rp)) {
+			pr_info("%s: Unable to request IOMMU resource.\n",
+				pbm->name);
+			kfree(rp);
+		}
 	}
 }
 
-- 
1.7.0.4

