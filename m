From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Date: Thu, 30 Jun 2016 08:26:06 +0000
Subject: [PATCH v5 39/44] sparc: dma-mapping: Use unsigned long for dma_attrs
Message-Id: <1467275171-6298-39-git-send-email-k.kozlowski@samsung.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1467275019-30789-1-git-send-email-k.kozlowski@samsung.com>
 <1467275171-6298-1-git-send-email-k.kozlowski@samsung.com>
In-Reply-To: <1467275171-6298-1-git-send-email-k.kozlowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, hch@infradead.org, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Split out subsystem specific changes for easier reviews. This will be
squashed with main commit.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/sparc/kernel/iommu.c     | 12 ++++++------
 arch/sparc/kernel/ioport.c    | 24 ++++++++++++------------
 arch/sparc/kernel/pci_sun4v.c | 12 ++++++------
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
index 37686828c3d9..5c615abff030 100644
--- a/arch/sparc/kernel/iommu.c
+++ b/arch/sparc/kernel/iommu.c
@@ -196,7 +196,7 @@ static inline void iommu_free_ctx(struct iommu *iommu, int ctx)
 
 static void *dma_4u_alloc_coherent(struct device *dev, size_t size,
 				   dma_addr_t *dma_addrp, gfp_t gfp,
-				   struct dma_attrs *attrs)
+				   unsigned long attrs)
 {
 	unsigned long order, first_page;
 	struct iommu *iommu;
@@ -245,7 +245,7 @@ static void *dma_4u_alloc_coherent(struct device *dev, size_t size,
 
 static void dma_4u_free_coherent(struct device *dev, size_t size,
 				 void *cpu, dma_addr_t dvma,
-				 struct dma_attrs *attrs)
+				 unsigned long attrs)
 {
 	struct iommu *iommu;
 	unsigned long order, npages;
@@ -263,7 +263,7 @@ static void dma_4u_free_coherent(struct device *dev, size_t size,
 static dma_addr_t dma_4u_map_page(struct device *dev, struct page *page,
 				  unsigned long offset, size_t sz,
 				  enum dma_data_direction direction,
-				  struct dma_attrs *attrs)
+				  unsigned long attrs)
 {
 	struct iommu *iommu;
 	struct strbuf *strbuf;
@@ -385,7 +385,7 @@ do_flush_sync:
 
 static void dma_4u_unmap_page(struct device *dev, dma_addr_t bus_addr,
 			      size_t sz, enum dma_data_direction direction,
-			      struct dma_attrs *attrs)
+			      unsigned long attrs)
 {
 	struct iommu *iommu;
 	struct strbuf *strbuf;
@@ -431,7 +431,7 @@ static void dma_4u_unmap_page(struct device *dev, dma_addr_t bus_addr,
 
 static int dma_4u_map_sg(struct device *dev, struct scatterlist *sglist,
 			 int nelems, enum dma_data_direction direction,
-			 struct dma_attrs *attrs)
+			 unsigned long attrs)
 {
 	struct scatterlist *s, *outs, *segstart;
 	unsigned long flags, handle, prot, ctx;
@@ -607,7 +607,7 @@ static unsigned long fetch_sg_ctx(struct iommu *iommu, struct scatterlist *sg)
 
 static void dma_4u_unmap_sg(struct device *dev, struct scatterlist *sglist,
 			    int nelems, enum dma_data_direction direction,
-			    struct dma_attrs *attrs)
+			    unsigned long attrs)
 {
 	unsigned long flags, ctx;
 	struct scatterlist *sg;
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index ffd5ff4678cf..2344103414d1 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -260,7 +260,7 @@ EXPORT_SYMBOL(sbus_set_sbus64);
  */
 static void *sbus_alloc_coherent(struct device *dev, size_t len,
 				 dma_addr_t *dma_addrp, gfp_t gfp,
-				 struct dma_attrs *attrs)
+				 unsigned long attrs)
 {
 	struct platform_device *op = to_platform_device(dev);
 	unsigned long len_total = PAGE_ALIGN(len);
@@ -315,7 +315,7 @@ err_nopages:
 }
 
 static void sbus_free_coherent(struct device *dev, size_t n, void *p,
-			       dma_addr_t ba, struct dma_attrs *attrs)
+			       dma_addr_t ba, unsigned long attrs)
 {
 	struct resource *res;
 	struct page *pgv;
@@ -355,7 +355,7 @@ static void sbus_free_coherent(struct device *dev, size_t n, void *p,
 static dma_addr_t sbus_map_page(struct device *dev, struct page *page,
 				unsigned long offset, size_t len,
 				enum dma_data_direction dir,
-				struct dma_attrs *attrs)
+				unsigned long attrs)
 {
 	void *va = page_address(page) + offset;
 
@@ -371,20 +371,20 @@ static dma_addr_t sbus_map_page(struct device *dev, struct page *page,
 }
 
 static void sbus_unmap_page(struct device *dev, dma_addr_t ba, size_t n,
-			    enum dma_data_direction dir, struct dma_attrs *attrs)
+			    enum dma_data_direction dir, unsigned long attrs)
 {
 	mmu_release_scsi_one(dev, ba, n);
 }
 
 static int sbus_map_sg(struct device *dev, struct scatterlist *sg, int n,
-		       enum dma_data_direction dir, struct dma_attrs *attrs)
+		       enum dma_data_direction dir, unsigned long attrs)
 {
 	mmu_get_scsi_sgl(dev, sg, n);
 	return n;
 }
 
 static void sbus_unmap_sg(struct device *dev, struct scatterlist *sg, int n,
-			  enum dma_data_direction dir, struct dma_attrs *attrs)
+			  enum dma_data_direction dir, unsigned long attrs)
 {
 	mmu_release_scsi_sgl(dev, sg, n);
 }
@@ -429,7 +429,7 @@ arch_initcall(sparc_register_ioport);
  */
 static void *pci32_alloc_coherent(struct device *dev, size_t len,
 				  dma_addr_t *pba, gfp_t gfp,
-				  struct dma_attrs *attrs)
+				  unsigned long attrs)
 {
 	unsigned long len_total = PAGE_ALIGN(len);
 	void *va;
@@ -482,7 +482,7 @@ err_nopages:
  * past this call are illegal.
  */
 static void pci32_free_coherent(struct device *dev, size_t n, void *p,
-				dma_addr_t ba, struct dma_attrs *attrs)
+				dma_addr_t ba, unsigned long attrs)
 {
 	struct resource *res;
 
@@ -518,14 +518,14 @@ static void pci32_free_coherent(struct device *dev, size_t n, void *p,
 static dma_addr_t pci32_map_page(struct device *dev, struct page *page,
 				 unsigned long offset, size_t size,
 				 enum dma_data_direction dir,
-				 struct dma_attrs *attrs)
+				 unsigned long attrs)
 {
 	/* IIep is write-through, not flushing. */
 	return page_to_phys(page) + offset;
 }
 
 static void pci32_unmap_page(struct device *dev, dma_addr_t ba, size_t size,
-			     enum dma_data_direction dir, struct dma_attrs *attrs)
+			     enum dma_data_direction dir, unsigned long attrs)
 {
 	if (dir != PCI_DMA_TODEVICE)
 		dma_make_coherent(ba, PAGE_ALIGN(size));
@@ -548,7 +548,7 @@ static void pci32_unmap_page(struct device *dev, dma_addr_t ba, size_t size,
  */
 static int pci32_map_sg(struct device *device, struct scatterlist *sgl,
 			int nents, enum dma_data_direction dir,
-			struct dma_attrs *attrs)
+			unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int n;
@@ -567,7 +567,7 @@ static int pci32_map_sg(struct device *device, struct scatterlist *sgl,
  */
 static void pci32_unmap_sg(struct device *dev, struct scatterlist *sgl,
 			   int nents, enum dma_data_direction dir,
-			   struct dma_attrs *attrs)
+			   unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int n;
diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index 836e8cef47e2..61c6f935accc 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -130,7 +130,7 @@ static inline long iommu_batch_end(void)
 
 static void *dma_4v_alloc_coherent(struct device *dev, size_t size,
 				   dma_addr_t *dma_addrp, gfp_t gfp,
-				   struct dma_attrs *attrs)
+				   unsigned long attrs)
 {
 	unsigned long flags, order, first_page, npages, n;
 	struct iommu *iommu;
@@ -213,7 +213,7 @@ static void dma_4v_iommu_demap(void *demap_arg, unsigned long entry,
 }
 
 static void dma_4v_free_coherent(struct device *dev, size_t size, void *cpu,
-				 dma_addr_t dvma, struct dma_attrs *attrs)
+				 dma_addr_t dvma, unsigned long attrs)
 {
 	struct pci_pbm_info *pbm;
 	struct iommu *iommu;
@@ -235,7 +235,7 @@ static void dma_4v_free_coherent(struct device *dev, size_t size, void *cpu,
 static dma_addr_t dma_4v_map_page(struct device *dev, struct page *page,
 				  unsigned long offset, size_t sz,
 				  enum dma_data_direction direction,
-				  struct dma_attrs *attrs)
+				  unsigned long attrs)
 {
 	struct iommu *iommu;
 	unsigned long flags, npages, oaddr;
@@ -294,7 +294,7 @@ iommu_map_fail:
 
 static void dma_4v_unmap_page(struct device *dev, dma_addr_t bus_addr,
 			      size_t sz, enum dma_data_direction direction,
-			      struct dma_attrs *attrs)
+			      unsigned long attrs)
 {
 	struct pci_pbm_info *pbm;
 	struct iommu *iommu;
@@ -322,7 +322,7 @@ static void dma_4v_unmap_page(struct device *dev, dma_addr_t bus_addr,
 
 static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
 			 int nelems, enum dma_data_direction direction,
-			 struct dma_attrs *attrs)
+			 unsigned long attrs)
 {
 	struct scatterlist *s, *outs, *segstart;
 	unsigned long flags, handle, prot;
@@ -466,7 +466,7 @@ iommu_map_failed:
 
 static void dma_4v_unmap_sg(struct device *dev, struct scatterlist *sglist,
 			    int nelems, enum dma_data_direction direction,
-			    struct dma_attrs *attrs)
+			    unsigned long attrs)
 {
 	struct pci_pbm_info *pbm;
 	struct scatterlist *sg;
-- 
1.9.1

