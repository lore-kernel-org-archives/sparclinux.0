From: Christoph Hellwig <hch@lst.de>
Date: Fri, 11 May 2018 07:59:41 +0000
Subject: [PATCH 16/20] mm: split arch/sh/mm/consistent.c
Message-Id: <20180511075945.16548-17-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180511075945.16548-1-hch@lst.de>
In-Reply-To: <20180511075945.16548-1-hch-jcswGhMUV9g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org, Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, Vincent Chen <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org, openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org, Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org, linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org

Half of the file just contains platform device memory setup code which
is required for all builds, and half contains helpers for dma coherent
allocation, which is only needed if CONFIG_DMA_NONCOHERENT is enabled.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/kernel/Makefile       |  2 +-
 arch/sh/kernel/dma-coherent.c | 80 +++++++++++++++++++++++++++++++++++
 arch/sh/mm/consistent.c       | 76 ---------------------------------
 3 files changed, 81 insertions(+), 77 deletions(-)
 create mode 100644 arch/sh/kernel/dma-coherent.c

diff --git a/arch/sh/kernel/Makefile b/arch/sh/kernel/Makefile
index cb5f1bfb52de..d5ddb64bfffe 100644
--- a/arch/sh/kernel/Makefile
+++ b/arch/sh/kernel/Makefile
@@ -45,7 +45,7 @@ obj-$(CONFIG_DUMP_CODE)		+= disassemble.o
 obj-$(CONFIG_HIBERNATION)	+= swsusp.o
 obj-$(CONFIG_DWARF_UNWINDER)	+= dwarf.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o perf_callchain.o
-obj-$(CONFIG_DMA_NONCOHERENT)	+= dma-nommu.o
+obj-$(CONFIG_DMA_NONCOHERENT)	+= dma-nommu.o dma-coherent.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)		+= hw_breakpoint.o
 
 ccflags-y := -Werror
diff --git a/arch/sh/kernel/dma-coherent.c b/arch/sh/kernel/dma-coherent.c
new file mode 100644
index 000000000000..4f41e5cd5207
--- /dev/null
+++ b/arch/sh/kernel/dma-coherent.c
@@ -0,0 +1,80 @@
+/*
+ * Copyright (C) 2004 - 2007  Paul Mundt
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/mm.h>
+#include <linux/init.h>
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
+#include <asm/cacheflush.h>
+#include <asm/addrspace.h>
+
+void *dma_generic_alloc_coherent(struct device *dev, size_t size,
+				 dma_addr_t *dma_handle, gfp_t gfp,
+				 unsigned long attrs)
+{
+	void *ret, *ret_nocache;
+	int order = get_order(size);
+
+	gfp |= __GFP_ZERO;
+
+	ret = (void *)__get_free_pages(gfp, order);
+	if (!ret)
+		return NULL;
+
+	/*
+	 * Pages from the page allocator may have data present in
+	 * cache. So flush the cache before using uncached memory.
+	 */
+	sh_sync_dma_for_device(ret, size, DMA_BIDIRECTIONAL);
+
+	ret_nocache = (void __force *)ioremap_nocache(virt_to_phys(ret), size);
+	if (!ret_nocache) {
+		free_pages((unsigned long)ret, order);
+		return NULL;
+	}
+
+	split_page(pfn_to_page(virt_to_phys(ret) >> PAGE_SHIFT), order);
+
+	*dma_handle = virt_to_phys(ret) - PFN_PHYS(dev->dma_pfn_offset);
+
+	return ret_nocache;
+}
+
+void dma_generic_free_coherent(struct device *dev, size_t size,
+			       void *vaddr, dma_addr_t dma_handle,
+			       unsigned long attrs)
+{
+	int order = get_order(size);
+	unsigned long pfn = (dma_handle >> PAGE_SHIFT) + dev->dma_pfn_offset;
+	int k;
+
+	for (k = 0; k < (1 << order); k++)
+		__free_pages(pfn_to_page(pfn + k), 0);
+
+	iounmap(vaddr);
+}
+
+void sh_sync_dma_for_device(void *vaddr, size_t size,
+		    enum dma_data_direction direction)
+{
+	void *addr = sh_cacheop_vaddr(vaddr);
+
+	switch (direction) {
+	case DMA_FROM_DEVICE:		/* invalidate only */
+		__flush_invalidate_region(addr, size);
+		break;
+	case DMA_TO_DEVICE:		/* writeback only */
+		__flush_wback_region(addr, size);
+		break;
+	case DMA_BIDIRECTIONAL:		/* writeback and invalidate */
+		__flush_purge_region(addr, size);
+		break;
+	default:
+		BUG();
+	}
+}
+EXPORT_SYMBOL(sh_sync_dma_for_device);
diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
index f18483494c46..5da5be74fb6b 100644
--- a/arch/sh/mm/consistent.c
+++ b/arch/sh/mm/consistent.c
@@ -1,10 +1,6 @@
 /*
- * arch/sh/mm/consistent.c
- *
  * Copyright (C) 2004 - 2007  Paul Mundt
  *
- * Declared coherent memory functions based on arch/x86/kernel/pci-dma_32.c
- *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
@@ -13,79 +9,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
-#include <linux/dma-debug.h>
 #include <linux/io.h>
-#include <linux/module.h>
-#include <linux/gfp.h>
-#include <asm/cacheflush.h>
-#include <asm/addrspace.h>
-
-void *dma_generic_alloc_coherent(struct device *dev, size_t size,
-				 dma_addr_t *dma_handle, gfp_t gfp,
-				 unsigned long attrs)
-{
-	void *ret, *ret_nocache;
-	int order = get_order(size);
-
-	gfp |= __GFP_ZERO;
-
-	ret = (void *)__get_free_pages(gfp, order);
-	if (!ret)
-		return NULL;
-
-	/*
-	 * Pages from the page allocator may have data present in
-	 * cache. So flush the cache before using uncached memory.
-	 */
-	sh_sync_dma_for_device(ret, size, DMA_BIDIRECTIONAL);
-
-	ret_nocache = (void __force *)ioremap_nocache(virt_to_phys(ret), size);
-	if (!ret_nocache) {
-		free_pages((unsigned long)ret, order);
-		return NULL;
-	}
-
-	split_page(pfn_to_page(virt_to_phys(ret) >> PAGE_SHIFT), order);
-
-	*dma_handle = virt_to_phys(ret) - PFN_PHYS(dev->dma_pfn_offset);
-
-	return ret_nocache;
-}
-
-void dma_generic_free_coherent(struct device *dev, size_t size,
-			       void *vaddr, dma_addr_t dma_handle,
-			       unsigned long attrs)
-{
-	int order = get_order(size);
-	unsigned long pfn = (dma_handle >> PAGE_SHIFT) + dev->dma_pfn_offset;
-	int k;
-
-	for (k = 0; k < (1 << order); k++)
-		__free_pages(pfn_to_page(pfn + k), 0);
-
-	iounmap(vaddr);
-}
-
-void sh_sync_dma_for_device(void *vaddr, size_t size,
-		    enum dma_data_direction direction)
-{
-	void *addr = sh_cacheop_vaddr(vaddr);
-
-	switch (direction) {
-	case DMA_FROM_DEVICE:		/* invalidate only */
-		__flush_invalidate_region(addr, size);
-		break;
-	case DMA_TO_DEVICE:		/* writeback only */
-		__flush_wback_region(addr, size);
-		break;
-	case DMA_BIDIRECTIONAL:		/* writeback and invalidate */
-		__flush_purge_region(addr, size);
-		break;
-	default:
-		BUG();
-	}
-}
-EXPORT_SYMBOL(sh_sync_dma_for_device);
 
 static int __init memchunk_setup(char *str)
 {
-- 
2.17.0

