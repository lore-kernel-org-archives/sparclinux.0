From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Date: Fri, 23 Oct 2015 20:58:34 +0000
Subject: [PATCH 3/7 v2] powerpc/dma: implement per-platform dma_get_page_shift
Message-Id: <20151023205834.GE10197@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20151023205420.GA10197@linux.vnet.ibm.com>
In-Reply-To: <20151023205420.GA10197@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The IOMMU page size is not always stored in struct iommu on Power.
Specifically if a device is configured for DDW (Dynamic DMA Windows aka.
64-bit direct DMA), the used TCE (Translation Control Entry) size is
stored in a special device property created at run-time by the DDW
configuration code. DDW is a pseries-specific feature, so allow
platforms to override the implementation of dma_get_page_shift if
desired.

Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/machdep.h | 3 ++-
 arch/powerpc/kernel/dma.c          | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 3f191f5..9dd03cf 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -83,9 +83,10 @@ struct machdep_calls {
 #endif
 #endif /* CONFIG_PPC64 */
 
-	/* Platform set_dma_mask and dma_get_required_mask overrides */
+	/* Platform overrides */
 	int		(*dma_set_mask)(struct device *dev, u64 dma_mask);
 	u64		(*dma_get_required_mask)(struct device *dev);
+	unsigned long	(*dma_get_page_shift)(struct device *dev);
 
 	int		(*probe)(void);
 	void		(*setup_arch)(void); /* Optional, may be NULL */
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index e805af2..c363896 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -338,6 +338,8 @@ EXPORT_SYMBOL(dma_set_mask);
 unsigned long dma_get_page_shift(struct device *dev)
 {
 	struct iommu_table *tbl = get_iommu_table_base(dev);
+	if (ppc_md.dma_get_page_shift)
+		return ppc_md.dma_get_page_shift(dev);
 	if (tbl)
 		return tbl->it_page_shift;
 	return PAGE_SHIFT;
-- 
1.9.1

