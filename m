From: Tushar Dave <tushar.n.dave@oracle.com>
Date: Fri, 28 Oct 2016 17:12:42 +0000
Subject: [PATCH v3 3/6] sparc64: Initialize iommu_map_table and iommu_pool
Message-Id: <1477674765-22160-4-git-send-email-tushar.n.dave@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1477674765-22160-1-git-send-email-tushar.n.dave@oracle.com>
In-Reply-To: <1477674765-22160-1-git-send-email-tushar.n.dave@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, chris.hyser@oracle.com, sowmini.varadhan@oracle.com, vgupta@synopsys.com, jroedel@suse.de, egtvedt@samfundet.no, robin.murphy@arm.com, m.szyprowski@samsung.com, krzk@kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Like legacy IOMMU, use common iommu_map_table and iommu_pool for ATU.
This change initializes iommu_map_table and iommu_pool for ATU.

Signed-off-by: Tushar Dave <tushar.n.dave@oracle.com>
Reviewed-by: chris hyser <chris.hyser@oracle.com>
Reviewed-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
---
 arch/sparc/include/asm/iommu_64.h |  2 ++
 arch/sparc/kernel/pci_sun4v.c     | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/sparc/include/asm/iommu_64.h b/arch/sparc/include/asm/iommu_64.h
index 93daa59..f24f356 100644
--- a/arch/sparc/include/asm/iommu_64.h
+++ b/arch/sparc/include/asm/iommu_64.h
@@ -45,8 +45,10 @@ struct atu_ranges {
 struct atu {
 	struct	atu_ranges	*ranges;
 	struct	atu_iotsb	*iotsb;
+	struct	iommu_map_table	tbl;
 	u64			base;
 	u64			size;
+	u64			dma_addr_mask;
 };
 
 struct iommu {
diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index 2afb86c..242477c 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -644,6 +644,8 @@ static int pci_sun4v_atu_init(struct pci_pbm_info *pbm)
 	struct atu *atu = pbm->iommu->atu;
 	unsigned long err;
 	const u64 *ranges;
+	u64 map_size, num_iotte;
+	u64 dma_mask;
 	const u32 *page_size;
 	int len;
 
@@ -682,6 +684,23 @@ static int pci_sun4v_atu_init(struct pci_pbm_info *pbm)
 		return err;
 	}
 
+	/* Create ATU iommu map.
+	 * One bit represents one iotte in IOTSB table.
+	 */
+	dma_mask = (roundup_pow_of_two(atu->size) - 1UL);
+	num_iotte = atu->size / IO_PAGE_SIZE;
+	map_size = num_iotte / 8;
+	atu->tbl.table_map_base = atu->base;
+	atu->dma_addr_mask = dma_mask;
+	atu->tbl.map = kzalloc(map_size, GFP_KERNEL);
+	if (!atu->tbl.map)
+		return -ENOMEM;
+
+	iommu_tbl_pool_init(&atu->tbl, num_iotte, IO_PAGE_SHIFT,
+			    NULL, false /* no large_pool */,
+			    0 /* default npools */,
+			    false /* want span boundary checking */);
+
 	return 0;
 }
 
-- 
1.9.1

