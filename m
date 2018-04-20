From: Christoph Hellwig <hch@lst.de>
Date: Fri, 20 Apr 2018 08:03:10 +0000
Subject: [PATCH 19/22] sh: use generic dma_noncoherent_ops
Message-Id: <20180420080313.18796-20-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180420080313.18796-1-hch@lst.de>
In-Reply-To: <20180420080313.18796-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org

Switch to the generic noncoherent direct mapping implementation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/Kconfig                   |  3 +-
 arch/sh/include/asm/Kbuild        |  1 +
 arch/sh/include/asm/dma-mapping.h | 26 -----------
 arch/sh/kernel/Makefile           |  1 -
 arch/sh/kernel/dma-nommu.c        | 75 -------------------------------
 arch/sh/mm/consistent.c           | 24 +++++-----
 6 files changed, 13 insertions(+), 117 deletions(-)
 delete mode 100644 arch/sh/include/asm/dma-mapping.h
 delete mode 100644 arch/sh/kernel/dma-nommu.c

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 23e7432302b0..23ed245407b1 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -50,7 +50,6 @@ config SUPERH
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_NMI
-	select NEED_DMA_MAP_STATE
 	select NEED_SG_DMA_LENGTH
 
 	help
@@ -163,6 +162,8 @@ config DMA_COHERENT
 
 config DMA_NONCOHERENT
 	def_bool !DMA_COHERENT
+	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select DMA_NONCOHERENT_OPS
 
 config PGTABLE_LEVELS
 	default 3 if X2TLB
diff --git a/arch/sh/include/asm/Kbuild b/arch/sh/include/asm/Kbuild
index 1efcce74997b..50f7e878ea1b 100644
--- a/arch/sh/include/asm/Kbuild
+++ b/arch/sh/include/asm/Kbuild
@@ -1,6 +1,7 @@
 generic-y += current.h
 generic-y += delay.h
 generic-y += div64.h
+generic-y += dma-mapping.h
 generic-y += emergency-restart.h
 generic-y += exec.h
 generic-y += irq_regs.h
diff --git a/arch/sh/include/asm/dma-mapping.h b/arch/sh/include/asm/dma-mapping.h
deleted file mode 100644
index 1ebc6a4eb1c5..000000000000
--- a/arch/sh/include/asm/dma-mapping.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_SH_DMA_MAPPING_H
-#define __ASM_SH_DMA_MAPPING_H
-
-extern const struct dma_map_ops nommu_dma_ops;
-
-static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
-{
-#ifdef CONFIG_DMA_NONCOHERENT
-	return &nommu_dma_ops;
-#else
-	return &dma_direct_ops;
-#endif
-}
-
-extern void *dma_generic_alloc_coherent(struct device *dev, size_t size,
-					dma_addr_t *dma_addr, gfp_t flag,
-					unsigned long attrs);
-extern void dma_generic_free_coherent(struct device *dev, size_t size,
-				      void *vaddr, dma_addr_t dma_handle,
-				      unsigned long attrs);
-
-void sh_sync_dma_for_device(void *vaddr, size_t size,
-	    enum dma_data_direction dir);
-
-#endif /* __ASM_SH_DMA_MAPPING_H */
diff --git a/arch/sh/kernel/Makefile b/arch/sh/kernel/Makefile
index cb5f1bfb52de..985106e13614 100644
--- a/arch/sh/kernel/Makefile
+++ b/arch/sh/kernel/Makefile
@@ -45,7 +45,6 @@ obj-$(CONFIG_DUMP_CODE)		+= disassemble.o
 obj-$(CONFIG_HIBERNATION)	+= swsusp.o
 obj-$(CONFIG_DWARF_UNWINDER)	+= dwarf.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o perf_callchain.o
-obj-$(CONFIG_DMA_NONCOHERENT)	+= dma-nommu.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)		+= hw_breakpoint.o
 
 ccflags-y := -Werror
diff --git a/arch/sh/kernel/dma-nommu.c b/arch/sh/kernel/dma-nommu.c
deleted file mode 100644
index 442922a9f8c0..000000000000
--- a/arch/sh/kernel/dma-nommu.c
+++ /dev/null
@@ -1,75 +0,0 @@
-/*
- * DMA mapping support for platforms lacking IOMMUs.
- *
- * Copyright (C) 2009  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-#include <linux/dma-mapping.h>
-#include <linux/io.h>
-#include <asm/cacheflush.h>
-
-static dma_addr_t nommu_map_page(struct device *dev, struct page *page,
-				 unsigned long offset, size_t size,
-				 enum dma_data_direction dir,
-				 unsigned long attrs)
-{
-	dma_addr_t addr = page_to_phys(page) + offset;
-
-	WARN_ON(size = 0);
-
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		sh_sync_dma_for_device(page_address(page) + offset, size, dir);
-
-	return addr;
-}
-
-static int nommu_map_sg(struct device *dev, struct scatterlist *sg,
-			int nents, enum dma_data_direction dir,
-			unsigned long attrs)
-{
-	struct scatterlist *s;
-	int i;
-
-	WARN_ON(nents = 0 || sg[0].length = 0);
-
-	for_each_sg(sg, s, nents, i) {
-		BUG_ON(!sg_page(s));
-
-		if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-			sh_sync_dma_for_device(sg_virt(s), s->length, dir);
-
-		s->dma_address = sg_phys(s);
-		s->dma_length = s->length;
-	}
-
-	return nents;
-}
-
-static void nommu_sync_single_for_device(struct device *dev, dma_addr_t addr,
-			      size_t size, enum dma_data_direction dir)
-{
-	sh_sync_dma_for_device(phys_to_virt(addr), size, dir);
-}
-
-static void nommu_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
-			  int nelems, enum dma_data_direction dir)
-{
-	struct scatterlist *s;
-	int i;
-
-	for_each_sg(sg, s, nelems, i)
-		sh_sync_dma_for_device(sg_virt(s), s->length, dir);
-}
-
-const struct dma_map_ops nommu_dma_ops = {
-	.alloc			= dma_generic_alloc_coherent,
-	.free			= dma_generic_free_coherent,
-	.map_page		= nommu_map_page,
-	.map_sg			= nommu_map_sg,
-	.sync_single_for_device	= nommu_sync_single_for_device,
-	.sync_sg_for_device	= nommu_sync_sg_for_device,
-};
-EXPORT_SYMBOL(nommu_dma_ops);
diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
index 516d481525e1..aaeeb74fdcc3 100644
--- a/arch/sh/mm/consistent.c
+++ b/arch/sh/mm/consistent.c
@@ -12,17 +12,15 @@
 #include <linux/mm.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/dma-mapping.h>
-#include <linux/dma-debug.h>
+#include <linux/dma-noncoherent.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/gfp.h>
 #include <asm/cacheflush.h>
 #include <asm/addrspace.h>
 
-void *dma_generic_alloc_coherent(struct device *dev, size_t size,
-				 dma_addr_t *dma_handle, gfp_t gfp,
-				 unsigned long attrs)
+void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
+		gfp_t gfp, unsigned long attrs)
 {
 	void *ret, *ret_nocache;
 	int order = get_order(size);
@@ -37,7 +35,7 @@ void *dma_generic_alloc_coherent(struct device *dev, size_t size,
 	 * Pages from the page allocator may have data present in
 	 * cache. So flush the cache before using uncached memory.
 	 */
-	sh_sync_dma_for_device(ret, size, DMA_BIDIRECTIONAL);
+	__flush_purge_region(sh_cacheop_vaddr(ret), size);
 
 	ret_nocache = (void __force *)ioremap_nocache(virt_to_phys(ret), size);
 	if (!ret_nocache) {
@@ -52,9 +50,8 @@ void *dma_generic_alloc_coherent(struct device *dev, size_t size,
 	return ret_nocache;
 }
 
-void dma_generic_free_coherent(struct device *dev, size_t size,
-			       void *vaddr, dma_addr_t dma_handle,
-			       unsigned long attrs)
+void arch_dma_free(struct device *dev, size_t size, void *vaddr,
+		dma_addr_t dma_handle, unsigned long attrs)
 {
 	int order = get_order(size);
 	unsigned long pfn = dma_handle >> PAGE_SHIFT;
@@ -66,12 +63,12 @@ void dma_generic_free_coherent(struct device *dev, size_t size,
 	iounmap(vaddr);
 }
 
-void sh_sync_dma_for_device(void *vaddr, size_t size,
-		    enum dma_data_direction direction)
+void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir)
 {
-	void *addr = sh_cacheop_vaddr(vaddr);
+	void *addr = sh_cacheop_vaddr(phys_to_virt(paddr));
 
-	switch (direction) {
+	switch (dir) {
 	case DMA_FROM_DEVICE:		/* invalidate only */
 		__flush_invalidate_region(addr, size);
 		break;
@@ -85,7 +82,6 @@ void sh_sync_dma_for_device(void *vaddr, size_t size,
 		BUG();
 	}
 }
-EXPORT_SYMBOL(sh_sync_dma_for_device);
 
 static int __init memchunk_setup(char *str)
 {
-- 
2.17.0

