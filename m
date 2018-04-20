From: Christoph Hellwig <hch@lst.de>
Date: Fri, 20 Apr 2018 08:03:13 +0000
Subject: [PATCH 22/22] parisc: use generic dma_noncoherent_ops
Message-Id: <20180420080313.18796-23-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180420080313.18796-1-hch@lst.de>
In-Reply-To: <20180420080313.18796-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org

Switch to the generic noncoherent direct mapping implementation.

Parisc previously had two different non-coherent dma ops implementation
that just different in the way coherent allocations were handled or not
handled.  The different behavior is not selected at runtime in the
arch_dma_alloc and arch_dma_free routines.  The non-coherent allocation
in the pcx cases now uses the dma_direct helpers that are a little more
sophisticated and used by a lot of other architectures.

Fix sync_single_for_cpu to do skip the cache flush unless the transfer
is to the device to match the more tested unmap_single path which should
have the same cache coherency implications.

This also now consistenly uses flush_kernel_dcache_range for cache
flushing while previously some of the SG based operations used
flush_kernel_vmap_range instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/parisc/Kconfig                   |   4 +
 arch/parisc/include/asm/dma-mapping.h |   5 -
 arch/parisc/kernel/pci-dma.c          | 181 ++++----------------------
 arch/parisc/kernel/setup.c            |   8 +-
 arch/parisc/mm/init.c                 |  11 +-
 5 files changed, 35 insertions(+), 174 deletions(-)

diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 47047f0cbe35..80166a1cbcb7 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -188,6 +188,10 @@ config PA20
 config PA11
 	def_bool y
 	depends on PA7000 || PA7100LC || PA7200 || PA7300LC
+	select ARCH_HAS_SYNC_DMA_FOR_CPU
+	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select DMA_NONCOHERENT_OPS
+	select DMA_NONCOHERENT_CACHE_SYNC
 
 config PREFETCH
 	def_bool y
diff --git a/arch/parisc/include/asm/dma-mapping.h b/arch/parisc/include/asm/dma-mapping.h
index 01e1fc057c83..44a9f97194aa 100644
--- a/arch/parisc/include/asm/dma-mapping.h
+++ b/arch/parisc/include/asm/dma-mapping.h
@@ -21,11 +21,6 @@
 ** flush/purge and allocate "regular" cacheable pages for everything.
 */
 
-#ifdef CONFIG_PA11
-extern const struct dma_map_ops pcxl_dma_ops;
-extern const struct dma_map_ops pcx_dma_ops;
-#endif
-
 extern const struct dma_map_ops *hppa_dma_ops;
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
diff --git a/arch/parisc/kernel/pci-dma.c b/arch/parisc/kernel/pci-dma.c
index 91bc0cac03a1..235e2e53959e 100644
--- a/arch/parisc/kernel/pci-dma.c
+++ b/arch/parisc/kernel/pci-dma.c
@@ -21,13 +21,12 @@
 #include <linux/init.h>
 #include <linux/gfp.h>
 #include <linux/mm.h>
-#include <linux/pci.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/string.h>
 #include <linux/types.h>
-#include <linux/scatterlist.h>
-#include <linux/export.h>
+#include <linux/dma-direct.h>
+#include <linux/dma-noncoherent.h>
 
 #include <asm/cacheflush.h>
 #include <asm/dma.h>    /* for DMA_CHUNK_SIZE */
@@ -447,178 +446,48 @@ static void pa11_dma_free(struct device *dev, size_t size, void *vaddr,
 	free_pages((unsigned long)__va(dma_handle), order);
 }
 
-static dma_addr_t pa11_dma_map_page(struct device *dev, struct page *page,
-		unsigned long offset, size_t size,
-		enum dma_data_direction direction, unsigned long attrs)
+void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir)
 {
-	void *addr = page_address(page) + offset;
-	BUG_ON(direction = DMA_NONE);
-
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		flush_kernel_dcache_range((unsigned long) addr, size);
-
-	return virt_to_phys(addr);
+	flush_kernel_dcache_range((unsigned long)phys_to_virt(paddr), size);
 }
 
-static void pa11_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
-		size_t size, enum dma_data_direction direction,
-		unsigned long attrs)
+void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir)
 {
-	BUG_ON(direction = DMA_NONE);
-
-	if (attrs & DMA_ATTR_SKIP_CPU_SYNC)
-		return;
-
-	if (direction = DMA_TO_DEVICE)
+	if (dir = DMA_TO_DEVICE)
 		return;
 
 	/*
-	 * For PCI_DMA_FROMDEVICE this flush is not necessary for the
+	 * For DMA_FROM_DEVICE this flush is not necessary for the
 	 * simple map/unmap case. However, it IS necessary if if
-	 * pci_dma_sync_single_* has been called and the buffer reused.
+	 * dma_sync_single_* has been called and the buffer reused.
 	 */
 
-	flush_kernel_dcache_range((unsigned long) phys_to_virt(dma_handle), size);
-}
-
-static int pa11_dma_map_sg(struct device *dev, struct scatterlist *sglist,
-		int nents, enum dma_data_direction direction,
-		unsigned long attrs)
-{
-	int i;
-	struct scatterlist *sg;
-
-	BUG_ON(direction = DMA_NONE);
-
-	for_each_sg(sglist, sg, nents, i) {
-		unsigned long vaddr = (unsigned long)sg_virt(sg);
-
-		sg_dma_address(sg) = (dma_addr_t) virt_to_phys(vaddr);
-		sg_dma_len(sg) = sg->length;
-
-		if (attrs & DMA_ATTR_SKIP_CPU_SYNC)
-			continue;
-
-		flush_kernel_dcache_range(vaddr, sg->length);
-	}
-	return nents;
+	flush_kernel_dcache_range((unsigned long)phys_to_virt(paddr), size);
 }
 
-static void pa11_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
-		int nents, enum dma_data_direction direction,
-		unsigned long attrs)
-{
-	int i;
-	struct scatterlist *sg;
-
-	BUG_ON(direction = DMA_NONE);
-
-	if (attrs & DMA_ATTR_SKIP_CPU_SYNC)
-		return;
-
-	if (direction = DMA_TO_DEVICE)
-		return;
-
-	/* once we do combining we'll need to use phys_to_virt(sg_dma_address(sglist)) */
-
-	for_each_sg(sglist, sg, nents, i)
-		flush_kernel_vmap_range(sg_virt(sg), sg->length);
-}
-
-static void pa11_dma_sync_single_for_cpu(struct device *dev,
-		dma_addr_t dma_handle, size_t size,
-		enum dma_data_direction direction)
-{
-	BUG_ON(direction = DMA_NONE);
-
-	flush_kernel_dcache_range((unsigned long) phys_to_virt(dma_handle),
-			size);
-}
-
-static void pa11_dma_sync_single_for_device(struct device *dev,
-		dma_addr_t dma_handle, size_t size,
-		enum dma_data_direction direction)
-{
-	BUG_ON(direction = DMA_NONE);
-
-	flush_kernel_dcache_range((unsigned long) phys_to_virt(dma_handle),
-			size);
-}
-
-static void pa11_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sglist, int nents, enum dma_data_direction direction)
-{
-	int i;
-	struct scatterlist *sg;
-
-	/* once we do combining we'll need to use phys_to_virt(sg_dma_address(sglist)) */
-
-	for_each_sg(sglist, sg, nents, i)
-		flush_kernel_vmap_range(sg_virt(sg), sg->length);
-}
-
-static void pa11_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sglist, int nents, enum dma_data_direction direction)
-{
-	int i;
-	struct scatterlist *sg;
-
-	/* once we do combining we'll need to use phys_to_virt(sg_dma_address(sglist)) */
-
-	for_each_sg(sglist, sg, nents, i)
-		flush_kernel_vmap_range(sg_virt(sg), sg->length);
-}
-
-static void pa11_dma_cache_sync(struct device *dev, void *vaddr, size_t size,
+void arch_dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 	       enum dma_data_direction direction)
 {
 	flush_kernel_dcache_range((unsigned long)vaddr, size);
 }
 
-const struct dma_map_ops pcxl_dma_ops = {
-	.alloc =		pa11_dma_alloc,
-	.free =			pa11_dma_free,
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
-
-static void *pcx_dma_alloc(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t flag, unsigned long attrs)
+void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
+		gfp_t gfp, unsigned long attrs)
 {
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
+	if (boot_cpu_data.cpu_type = pcxl2 || boot_cpu_data.cpu_type = pcxl)
+		return pa11_dma_alloc(dev, size, dma_handle, gfp, attrs);
+	if (attrs & DMA_ATTR_NON_CONSISTENT)
+		return dma_direct_alloc(dev, size, dma_handle, gfp, attrs);
+	return NULL;
 }
 
-static void pcx_dma_free(struct device *dev, size_t size, void *vaddr,
-		dma_addr_t iova, unsigned long attrs)
+void arch_dma_free(struct device *dev, size_t size, void *cpu_addr,
+		dma_addr_t dma_addr, unsigned long attrs)
 {
-	free_pages((unsigned long)vaddr, get_order(size));
-	return;
+	if (boot_cpu_data.cpu_type = pcxl2 || boot_cpu_data.cpu_type = pcxl)
+		pa11_dma_free(dev, size, cpu_addr, dma_addr, attrs);
+	else
+		dma_direct_free(dev, size, cpu_addr, dma_addr, attrs);
 }
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
index 8d3a7b80ac42..4e87c35c22b7 100644
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
+		hppa_dma_ops = &dma_noncoherent_ops;
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

