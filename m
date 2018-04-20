From: Christoph Hellwig <hch@lst.de>
Date: Fri, 20 Apr 2018 08:02:54 +0000
Subject: [PATCH 03/22] dma-mapping: provide a generic dma-noncoherent implementation
Message-Id: <20180420080313.18796-4-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180420080313.18796-1-hch@lst.de>
In-Reply-To: <20180420080313.18796-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org

Add a new dma_map_ops implementation that uses dma-direct for the
address mapping of streaming mappings, and which requires arch-specific
implemenations of coherent allocate/free.

Architectures have to provide flushing helpers to ownership trasnfers
to the device and/or CPU, and can provide optional implementations of
the coherent mmap functionality, and the cache_flush routines for
non-coherent long term allocations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 MAINTAINERS                       |   2 +
 include/asm-generic/dma-mapping.h |   9 +++
 include/linux/dma-direct.h        |   7 ++-
 include/linux/dma-mapping.h       |   1 +
 include/linux/dma-noncoherent.h   |  47 ++++++++++++++
 lib/Kconfig                       |  20 ++++++
 lib/Makefile                      |   1 +
 lib/dma-direct.c                  |   8 +--
 lib/dma-noncoherent.c             | 101 ++++++++++++++++++++++++++++++
 9 files changed, 191 insertions(+), 5 deletions(-)
 create mode 100644 include/linux/dma-noncoherent.h
 create mode 100644 lib/dma-noncoherent.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b60179d948bb..bbaf5459d297 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4327,12 +4327,14 @@ W:	http://git.infradead.org/users/hch/dma-mapping.git
 S:	Supported
 F:	lib/dma-debug.c
 F:	lib/dma-direct.c
+F:	lib/dma-noncoherent.c
 F:	lib/dma-virt.c
 F:	drivers/base/dma-mapping.c
 F:	drivers/base/dma-coherent.c
 F:	include/asm-generic/dma-mapping.h
 F:	include/linux/dma-direct.h
 F:	include/linux/dma-mapping.h
+F:	include/linux/dma-noncoherent.h
 
 DME1737 HARDWARE MONITOR DRIVER
 M:	Juerg Haefliger <juergh@gmail.com>
diff --git a/include/asm-generic/dma-mapping.h b/include/asm-generic/dma-mapping.h
index 880a292d792f..ad2868263867 100644
--- a/include/asm-generic/dma-mapping.h
+++ b/include/asm-generic/dma-mapping.h
@@ -4,7 +4,16 @@
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
+	/*
+	 * Use the non-coherent ops if available.  If an architecture wants a
+	 * more fine-grained selection of operations it will have to implement
+	 * get_arch_dma_ops itself or use the per-device dma_ops.
+	 */
+#ifdef CONFIG_DMA_NONCOHERENT_OPS
+	return &dma_noncoherent_ops;
+#else
 	return &dma_direct_ops;
+#endif
 }
 
 #endif /* _ASM_GENERIC_DMA_MAPPING_H */
diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index 53ad6a47f513..8d9f33febde5 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -59,6 +59,11 @@ void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t gfp, unsigned long attrs);
 void dma_direct_free(struct device *dev, size_t size, void *cpu_addr,
 		dma_addr_t dma_addr, unsigned long attrs);
+dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
+		unsigned long offset, size_t size, enum dma_data_direction dir,
+		unsigned long attrs);
+int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
+		enum dma_data_direction dir, unsigned long attrs);
 int dma_direct_supported(struct device *dev, u64 mask);
-
+int dma_direct_mapping_error(struct device *dev, dma_addr_t dma_addr);
 #endif /* _LINUX_DMA_DIRECT_H */
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 25a9a2b04f78..4be070df5fc5 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -136,6 +136,7 @@ struct dma_map_ops {
 };
 
 extern const struct dma_map_ops dma_direct_ops;
+extern const struct dma_map_ops dma_noncoherent_ops;
 extern const struct dma_map_ops dma_virt_ops;
 
 #define DMA_BIT_MASK(n)	(((n) = 64) ? ~0ULL : ((1ULL<<(n))-1))
diff --git a/include/linux/dma-noncoherent.h b/include/linux/dma-noncoherent.h
new file mode 100644
index 000000000000..10b2654d549b
--- /dev/null
+++ b/include/linux/dma-noncoherent.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_DMA_NONCOHERENT_H
+#define _LINUX_DMA_NONCOHERENT_H 1
+
+#include <linux/dma-mapping.h>
+
+void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
+		gfp_t gfp, unsigned long attrs);
+void arch_dma_free(struct device *dev, size_t size, void *cpu_addr,
+		dma_addr_t dma_addr, unsigned long attrs);
+
+#ifdef CONFIG_DMA_NONCOHERENT_MMAP
+int arch_dma_mmap(struct device *dev, struct vm_area_struct *vma,
+		void *cpu_addr, dma_addr_t dma_addr, size_t size,
+		unsigned long attrs);
+#else
+#define arch_dma_mmap NULL
+#endif /* CONFIG_DMA_NONCOHERENT_MMAP */
+
+#ifdef CONFIG_DMA_NONCOHERENT_CACHE_SYNC
+void arch_dma_cache_sync(struct device *dev, void *vaddr, size_t size,
+		enum dma_data_direction direction);
+#else
+#define arch_dma_cache_sync NULL
+#endif /* CONFIG_DMA_NONCOHERENT_CACHE_SYNC */
+
+#ifdef CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE
+void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir);
+#else
+static inline void arch_sync_dma_for_device(struct device *dev,
+		phys_addr_t paddr, size_t size, enum dma_data_direction dir)
+{
+}
+#endif /* ARCH_HAS_SYNC_DMA_FOR_DEVICE */
+
+#ifdef CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU
+void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir);
+#else
+static inline void arch_sync_dma_for_cpu(struct device *dev,
+		phys_addr_t paddr, size_t size, enum dma_data_direction dir)
+{
+}
+#endif /* ARCH_HAS_SYNC_DMA_FOR_CPU */
+
+#endif /* _LINUX_DMA_NONCOHERENT_H */
diff --git a/lib/Kconfig b/lib/Kconfig
index 726b0562caa7..ae4bf1d8af11 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -441,10 +441,30 @@ config ARCH_DMA_ADDR_T_64BIT
 config IOMMU_HELPER
 	bool
 
+config ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	bool
+
+config ARCH_HAS_SYNC_DMA_FOR_CPU
+	bool
+	select NEED_DMA_MAP_STATE
+
 config DMA_DIRECT_OPS
 	bool
 	depends on HAS_DMA
 
+config DMA_NONCOHERENT_OPS
+	bool
+	depends on HAS_DMA
+	select DMA_DIRECT_OPS
+
+config DMA_NONCOHERENT_MMAP
+	bool
+	depends on DMA_NONCOHERENT_OPS
+
+config DMA_NONCOHERENT_CACHE_SYNC
+	bool
+	depends on DMA_NONCOHERENT_OPS
+
 config DMA_VIRT_OPS
 	bool
 	depends on HAS_DMA
diff --git a/lib/Makefile b/lib/Makefile
index 94203b5eecd4..9f18c8152281 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -30,6 +30,7 @@ lib-$(CONFIG_PRINTK) += dump_stack.o
 lib-$(CONFIG_MMU) += ioremap.o
 lib-$(CONFIG_SMP) += cpumask.o
 lib-$(CONFIG_DMA_DIRECT_OPS) += dma-direct.o
+lib-$(CONFIG_DMA_NONCOHERENT_OPS) += dma-noncoherent.o
 lib-$(CONFIG_DMA_VIRT_OPS) += dma-virt.o
 
 lib-y	+= kobject.o klist.o
diff --git a/lib/dma-direct.c b/lib/dma-direct.c
index 199ae4cdd28f..9abb93541dfe 100644
--- a/lib/dma-direct.c
+++ b/lib/dma-direct.c
@@ -120,7 +120,7 @@ void dma_direct_free(struct device *dev, size_t size, void *cpu_addr,
 		free_pages((unsigned long)cpu_addr, page_order);
 }
 
-static dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
+dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size, enum dma_data_direction dir,
 		unsigned long attrs)
 {
@@ -131,8 +131,8 @@ static dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
 	return dma_addr;
 }
 
-static int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl,
-		int nents, enum dma_data_direction dir, unsigned long attrs)
+int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
+		enum dma_data_direction dir, unsigned long attrs)
 {
 	int i;
 	struct scatterlist *sg;
@@ -167,7 +167,7 @@ int dma_direct_supported(struct device *dev, u64 mask)
 	return 1;
 }
 
-static int dma_direct_mapping_error(struct device *dev, dma_addr_t dma_addr)
+int dma_direct_mapping_error(struct device *dev, dma_addr_t dma_addr)
 {
 	return dma_addr = DIRECT_MAPPING_ERROR;
 }
diff --git a/lib/dma-noncoherent.c b/lib/dma-noncoherent.c
new file mode 100644
index 000000000000..f4b8532c20ac
--- /dev/null
+++ b/lib/dma-noncoherent.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Christoph Hellwig.
+ *
+ * DMA operations that map physical memory directly without providing cache
+ * coherence.
+ */
+#include <linux/export.h>
+#include <linux/mm.h>
+#include <linux/dma-direct.h>
+#include <linux/dma-noncoherent.h>
+#include <linux/scatterlist.h>
+
+static void dma_noncoherent_sync_single_for_device(struct device *dev,
+		dma_addr_t addr, size_t size, enum dma_data_direction dir)
+{
+	arch_sync_dma_for_device(dev, dma_to_phys(dev, addr), size, dir);
+}
+
+static void dma_noncoherent_sync_sg_for_device(struct device *dev,
+		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
+{
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(sgl, sg, nents, i)
+		arch_sync_dma_for_device(dev, sg_phys(sg), sg->length, dir);
+}
+
+static dma_addr_t dma_noncoherent_map_page(struct device *dev, struct page *page,
+		unsigned long offset, size_t size, enum dma_data_direction dir,
+		unsigned long attrs)
+{
+	dma_addr_t addr;
+
+	addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
+	if (!dma_mapping_error(dev, addr) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		arch_sync_dma_for_device(dev, page_to_phys(page), size, dir);
+	return addr;
+}
+
+static int dma_noncoherent_map_sg(struct device *dev, struct scatterlist *sgl,
+		int nents, enum dma_data_direction dir, unsigned long attrs)
+{
+	nents = dma_direct_map_sg(dev, sgl, nents, dir, attrs);
+	if (nents > 0 && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		dma_noncoherent_sync_sg_for_device(dev, sgl, nents, dir);
+	return nents;
+}
+
+#ifdef CONFIG_DMA_NONCOHERENT_SYNC_FOR_CPU
+static void dma_noncoherent_sync_single_for_cpu(struct device *dev,
+		dma_addr_t addr, size_t size, enum dma_data_direction dir)
+{
+	arch_sync_dma_for_cpu(dev, dma_to_phys(dev, addr), size, dir);
+}
+
+static void dma_noncoherent_sync_sg_for_cpu(struct device *dev,
+		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
+{
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(sgl, sg, nents, i)
+		arch_sync_dma_for_cpu(dev, sg_phys(sg), sg->length, dir);
+}
+
+static void dma_noncoherent_unmap_page(struct device *dev, dma_addr_t addr,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		dma_noncoherent_sync_single_for_cpu(dev, addr, size, dir);
+}
+
+static void dma_noncoherent_unmap_sg(struct device *dev, struct scatterlist *sgl,
+		int nents, enum dma_data_direction dir, unsigned long attrs)
+{
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		dma_noncoherent_sync_sg_for_cpu(dev, sgl, nents, dir);
+}
+#endif
+
+const struct dma_map_ops dma_noncoherent_ops = {
+	.alloc			= arch_dma_alloc,
+	.free			= arch_dma_free,
+	.mmap			= arch_dma_mmap,
+	.sync_single_for_device	= dma_noncoherent_sync_single_for_device,
+	.sync_sg_for_device	= dma_noncoherent_sync_sg_for_device,
+	.map_page		= dma_noncoherent_map_page,
+	.map_sg			= dma_noncoherent_map_sg,
+#ifdef CONFIG_DMA_NONCOHERENT_SYNC_FOR_CPU
+	.sync_single_for_cpu	= dma_noncoherent_sync_single_for_cpu,
+	.sync_sg_for_cpu	= dma_noncoherent_sync_sg_for_cpu,
+	.unmap_page		= dma_noncoherent_unmap_page,
+	.unmap_sg		= dma_noncoherent_unmap_sg,
+#endif
+	.dma_supported		= dma_direct_supported,
+	.mapping_error		= dma_direct_mapping_error,
+	.cache_sync		= arch_dma_cache_sync,
+};
+EXPORT_SYMBOL(dma_noncoherent_ops);
-- 
2.17.0

