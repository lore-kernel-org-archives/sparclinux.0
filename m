From: Christoph Hellwig <hch@lst.de>
Date: Tue, 22 May 2018 12:04:28 +0000
Subject: [PATCH 23/25] parisc: merge pcx_dma_ops and pcxl_dma_ops
Message-Id: <20180522120430.28709-24-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180522120430.28709-1-hch@lst.de>
In-Reply-To: <20180522120430.28709-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org

The only difference is that pcxl supports dma coherent allocations, while
pcx only supports non-consistent allocations and otherwise fails.

But dma_alloc* is not in the fast path, and merging these two allows an
easy migration path to the generic dma-noncoherent implementation, so
do it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/parisc/include/asm/dma-mapping.h |  3 +-
 arch/parisc/kernel/pci-dma.c          | 80 ++++++++++++---------------
 arch/parisc/kernel/setup.c            |  8 +--
 arch/parisc/mm/init.c                 | 11 +---
 4 files changed, 43 insertions(+), 59 deletions(-)

diff --git a/arch/parisc/include/asm/dma-mapping.h b/arch/parisc/include/asm/dma-mapping.h
index 01e1fc057c83..eeec8dd18e74 100644
--- a/arch/parisc/include/asm/dma-mapping.h
+++ b/arch/parisc/include/asm/dma-mapping.h
@@ -22,8 +22,7 @@
 */
 
 #ifdef CONFIG_PA11
-extern const struct dma_map_ops pcxl_dma_ops;
-extern const struct dma_map_ops pcx_dma_ops;
+extern const struct dma_map_ops pa11_dma_ops;
 #endif
 
 extern const struct dma_map_ops *hppa_dma_ops;
diff --git a/arch/parisc/kernel/pci-dma.c b/arch/parisc/kernel/pci-dma.c
index 91bc0cac03a1..52304cb290f9 100644
--- a/arch/parisc/kernel/pci-dma.c
+++ b/arch/parisc/kernel/pci-dma.c
@@ -408,7 +408,7 @@ pcxl_dma_init(void)
 
 __initcall(pcxl_dma_init);
 
-static void *pa11_dma_alloc(struct device *dev, size_t size,
+static void *pcxl_dma_alloc(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t flag, unsigned long attrs)
 {
 	unsigned long vaddr;
@@ -435,16 +435,44 @@ static void *pa11_dma_alloc(struct device *dev, size_t size,
 	return (void *)vaddr;
 }
 
+static void *pcx_dma_alloc(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t flag, unsigned long attrs)
+{
+	void *addr;
+
+	if ((attrs & DMA_ATTR_NON_CONSISTENT) = 0)
+		return NULL;
+
+	addr = (void *)__get_free_pages(flag, get_order(size));
+	if (addr)
+		*dma_handle = (dma_addr_t)virt_to_phys(addr);
+
+	return addr;
+}
+
+static void *pa11_dma_alloc(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
+{
+
+	if (boot_cpu_data.cpu_type = pcxl2 || boot_cpu_data.cpu_type = pcxl)
+		return pcxl_dma_alloc(dev, size, dma_handle, gfp, attrs);
+	else
+		return pcx_dma_alloc(dev, size, dma_handle, gfp, attrs);
+}
+
 static void pa11_dma_free(struct device *dev, size_t size, void *vaddr,
 		dma_addr_t dma_handle, unsigned long attrs)
 {
-	int order;
+	int order = get_order(size);
 
-	order = get_order(size);
-	size = 1 << (order + PAGE_SHIFT);
-	unmap_uncached_pages((unsigned long)vaddr, size);
-	pcxl_free_range((unsigned long)vaddr, size);
-	free_pages((unsigned long)__va(dma_handle), order);
+	if (boot_cpu_data.cpu_type = pcxl2 || boot_cpu_data.cpu_type = pcxl) {
+		size = 1 << (order + PAGE_SHIFT);
+		unmap_uncached_pages((unsigned long)vaddr, size);
+		pcxl_free_range((unsigned long)vaddr, size);
+
+		vaddr = __va(dma_handle);
+	}
+	free_pages((unsigned long)vaddr, get_order(size));
 }
 
 static dma_addr_t pa11_dma_map_page(struct device *dev, struct page *page,
@@ -573,7 +601,7 @@ static void pa11_dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 	flush_kernel_dcache_range((unsigned long)vaddr, size);
 }
 
-const struct dma_map_ops pcxl_dma_ops = {
+const struct dma_map_ops pa11_dma_ops = {
 	.alloc =		pa11_dma_alloc,
 	.free =			pa11_dma_free,
 	.map_page =		pa11_dma_map_page,
@@ -586,39 +614,3 @@ const struct dma_map_ops pcxl_dma_ops = {
 	.sync_sg_for_device =	pa11_dma_sync_sg_for_device,
 	.cache_sync =		pa11_dma_cache_sync,
 };
-
-static void *pcx_dma_alloc(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t flag, unsigned long attrs)
-{
-	void *addr;
-
-	if ((attrs & DMA_ATTR_NON_CONSISTENT) = 0)
-		return NULL;
-
-	addr = (void *)__get_free_pages(flag, get_order(size));
-	if (addr)
-		*dma_handle = (dma_addr_t)virt_to_phys(addr);
-
-	return addr;
-}
-
-static void pcx_dma_free(struct device *dev, size_t size, void *vaddr,
-		dma_addr_t iova, unsigned long attrs)
-{
-	free_pages((unsigned long)vaddr, get_order(size));
-	return;
-}
-
-const struct dma_map_ops pcx_dma_ops = {
-	.alloc =		pcx_dma_alloc,
-	.free =			pcx_dma_free,
-	.map_page =		pa11_dma_map_page,
-	.unmap_page =		pa11_dma_unmap_page,
-	.map_sg =		pa11_dma_map_sg,
-	.unmap_sg =		pa11_dma_unmap_sg,
-	.sync_single_for_cpu =	pa11_dma_sync_single_for_cpu,
-	.sync_single_for_device = pa11_dma_sync_single_for_device,
-	.sync_sg_for_cpu =	pa11_dma_sync_sg_for_cpu,
-	.sync_sg_for_device =	pa11_dma_sync_sg_for_device,
-	.cache_sync =		pa11_dma_cache_sync,
-};
diff --git a/arch/parisc/kernel/setup.c b/arch/parisc/kernel/setup.c
index 8d3a7b80ac42..5c8450a22255 100644
--- a/arch/parisc/kernel/setup.c
+++ b/arch/parisc/kernel/setup.c
@@ -97,14 +97,12 @@ void __init dma_ops_init(void)
 		panic(	"PA-RISC Linux currently only supports machines that conform to\n"
 			"the PA-RISC 1.1 or 2.0 architecture specification.\n");
 
-	case pcxs:
-	case pcxt:
-		hppa_dma_ops = &pcx_dma_ops;
-		break;
 	case pcxl2:
 		pa7300lc_init();
 	case pcxl: /* falls through */
-		hppa_dma_ops = &pcxl_dma_ops;
+	case pcxs:
+	case pcxt:
+		hppa_dma_ops = &pa11_dma_ops;
 		break;
 	default:
 		break;
diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
index cab32ee824d2..4ad91c28ecbe 100644
--- a/arch/parisc/mm/init.c
+++ b/arch/parisc/mm/init.c
@@ -19,7 +19,6 @@
 #include <linux/gfp.h>
 #include <linux/delay.h>
 #include <linux/init.h>
-#include <linux/pci.h>		/* for hppa_dma_ops and pcxl_dma_ops */
 #include <linux/initrd.h>
 #include <linux/swap.h>
 #include <linux/unistd.h>
@@ -616,17 +615,13 @@ void __init mem_init(void)
 	free_all_bootmem();
 
 #ifdef CONFIG_PA11
-	if (hppa_dma_ops = &pcxl_dma_ops) {
+	if (boot_cpu_data.cpu_type = pcxl2 || boot_cpu_data.cpu_type = pcxl) {
 		pcxl_dma_start = (unsigned long)SET_MAP_OFFSET(MAP_START);
 		parisc_vmalloc_start = SET_MAP_OFFSET(pcxl_dma_start
 						+ PCXL_DMA_MAP_SIZE);
-	} else {
-		pcxl_dma_start = 0;
-		parisc_vmalloc_start = SET_MAP_OFFSET(MAP_START);
-	}
-#else
-	parisc_vmalloc_start = SET_MAP_OFFSET(MAP_START);
+	} else
 #endif
+		parisc_vmalloc_start = SET_MAP_OFFSET(MAP_START);
 
 	mem_init_print_info(NULL);
 
-- 
2.17.0

