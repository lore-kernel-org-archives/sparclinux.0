From: Christoph Hellwig <hch@lst.de>
Date: Tue, 24 Apr 2018 14:02:33 +0000
Subject: [PATCH 1/3] dma-debug: move initialization to common code
Message-Id: <20180424140235.9125-2-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180424140235.9125-1-hch@lst.de>
In-Reply-To: <20180424140235.9125-1-hch-jcswGhMUV9g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org, Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, Vincent Chen <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org, openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org, Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org, linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org

Most mainstream architectures are using 65536 entries, so lets stick to
that.  If someone is really desperate to override it that can still be
done through <asm/dma-mapping.h>, but I'd rather see a really good
rationale for that.

dma_debug_init is now called as a core_initcall, which for many
architectures means much earlier, and provides dma-debug functionality
earlier in the boot process.  This should be safe as it only relies
on the memory allocator already being available.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/mm/dma-mapping-nommu.c |  9 ---------
 arch/arm/mm/dma-mapping.c       |  9 ---------
 arch/arm64/mm/dma-mapping.c     | 10 ----------
 arch/c6x/kernel/dma.c           | 11 -----------
 arch/ia64/kernel/dma-mapping.c  | 10 ----------
 arch/microblaze/kernel/dma.c    | 11 -----------
 arch/mips/mm/dma-default.c      | 10 ----------
 arch/openrisc/kernel/dma.c      | 11 -----------
 arch/powerpc/kernel/dma.c       |  3 ---
 arch/s390/pci/pci_dma.c         |  9 ---------
 arch/sh/mm/consistent.c         |  9 ---------
 arch/sparc/kernel/Makefile      |  2 --
 arch/sparc/kernel/dma.c         | 13 -------------
 arch/x86/kernel/pci-dma.c       |  4 ----
 arch/xtensa/kernel/pci-dma.c    |  9 ---------
 include/linux/dma-debug.h       |  6 ------
 lib/dma-debug.c                 | 21 ++++++++++++++-------
 17 files changed, 14 insertions(+), 143 deletions(-)
 delete mode 100644 arch/sparc/kernel/dma.c

diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
index 619f24a42d09..f448a0663b10 100644
--- a/arch/arm/mm/dma-mapping-nommu.c
+++ b/arch/arm/mm/dma-mapping-nommu.c
@@ -241,12 +241,3 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 void arch_teardown_dma_ops(struct device *dev)
 {
 }
-
-#define PREALLOC_DMA_DEBUG_ENTRIES	4096
-
-static int __init dma_debug_do_init(void)
-{
-	dma_debug_init(PREALLOC_DMA_DEBUG_ENTRIES);
-	return 0;
-}
-core_initcall(dma_debug_do_init);
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 8c398fedbbb6..c26bf83f44ca 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1165,15 +1165,6 @@ int arm_dma_supported(struct device *dev, u64 mask)
 	return __dma_supported(dev, mask, false);
 }
 
-#define PREALLOC_DMA_DEBUG_ENTRIES	4096
-
-static int __init dma_debug_do_init(void)
-{
-	dma_debug_init(PREALLOC_DMA_DEBUG_ENTRIES);
-	return 0;
-}
-core_initcall(dma_debug_do_init);
-
 #ifdef CONFIG_ARM_DMA_USE_IOMMU
 
 static int __dma_info_to_prot(enum dma_data_direction dir, unsigned long attrs)
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index a96ec0181818..db01f2709842 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -508,16 +508,6 @@ static int __init arm64_dma_init(void)
 }
 arch_initcall(arm64_dma_init);
 
-#define PREALLOC_DMA_DEBUG_ENTRIES	4096
-
-static int __init dma_debug_do_init(void)
-{
-	dma_debug_init(PREALLOC_DMA_DEBUG_ENTRIES);
-	return 0;
-}
-fs_initcall(dma_debug_do_init);
-
-
 #ifdef CONFIG_IOMMU_DMA
 #include <linux/dma-iommu.h>
 #include <linux/platform_device.h>
diff --git a/arch/c6x/kernel/dma.c b/arch/c6x/kernel/dma.c
index 9fff8be75f58..31e1a9ec3a9c 100644
--- a/arch/c6x/kernel/dma.c
+++ b/arch/c6x/kernel/dma.c
@@ -136,14 +136,3 @@ const struct dma_map_ops c6x_dma_ops = {
 	.sync_sg_for_cpu	= c6x_dma_sync_sg_for_cpu,
 };
 EXPORT_SYMBOL(c6x_dma_ops);
-
-/* Number of entries preallocated for DMA-API debugging */
-#define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
-
-static int __init dma_init(void)
-{
-	dma_debug_init(PREALLOC_DMA_DEBUG_ENTRIES);
-
-	return 0;
-}
-fs_initcall(dma_init);
diff --git a/arch/ia64/kernel/dma-mapping.c b/arch/ia64/kernel/dma-mapping.c
index f2d57e66fd86..7a471d8d67d4 100644
--- a/arch/ia64/kernel/dma-mapping.c
+++ b/arch/ia64/kernel/dma-mapping.c
@@ -9,16 +9,6 @@ int iommu_detected __read_mostly;
 const struct dma_map_ops *dma_ops;
 EXPORT_SYMBOL(dma_ops);
 
-#define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
-
-static int __init dma_init(void)
-{
-	dma_debug_init(PREALLOC_DMA_DEBUG_ENTRIES);
-
-	return 0;
-}
-fs_initcall(dma_init);
-
 const struct dma_map_ops *dma_get_ops(struct device *dev)
 {
 	return dma_ops;
diff --git a/arch/microblaze/kernel/dma.c b/arch/microblaze/kernel/dma.c
index c91e8cef98dd..3145e7dc8ab1 100644
--- a/arch/microblaze/kernel/dma.c
+++ b/arch/microblaze/kernel/dma.c
@@ -184,14 +184,3 @@ const struct dma_map_ops dma_nommu_ops = {
 	.sync_sg_for_device	= dma_nommu_sync_sg_for_device,
 };
 EXPORT_SYMBOL(dma_nommu_ops);
-
-/* Number of entries preallocated for DMA-API debugging */
-#define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
-
-static int __init dma_init(void)
-{
-	dma_debug_init(PREALLOC_DMA_DEBUG_ENTRIES);
-
-	return 0;
-}
-fs_initcall(dma_init);
diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index dcafa43613b6..f9fef0028ca2 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -402,13 +402,3 @@ static const struct dma_map_ops mips_default_dma_map_ops = {
 
 const struct dma_map_ops *mips_dma_map_ops = &mips_default_dma_map_ops;
 EXPORT_SYMBOL(mips_dma_map_ops);
-
-#define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
-
-static int __init mips_dma_init(void)
-{
-	dma_debug_init(PREALLOC_DMA_DEBUG_ENTRIES);
-
-	return 0;
-}
-fs_initcall(mips_dma_init);
diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
index a945f00011b4..ec7fd45704d2 100644
--- a/arch/openrisc/kernel/dma.c
+++ b/arch/openrisc/kernel/dma.c
@@ -247,14 +247,3 @@ const struct dma_map_ops or1k_dma_map_ops = {
 	.sync_single_for_device = or1k_sync_single_for_device,
 };
 EXPORT_SYMBOL(or1k_dma_map_ops);
-
-/* Number of entries preallocated for DMA-API debugging */
-#define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
-
-static int __init dma_init(void)
-{
-	dma_debug_init(PREALLOC_DMA_DEBUG_ENTRIES);
-
-	return 0;
-}
-fs_initcall(dma_init);
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index da20569de9d4..138157deeadf 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -309,8 +309,6 @@ int dma_set_coherent_mask(struct device *dev, u64 mask)
 }
 EXPORT_SYMBOL(dma_set_coherent_mask);
 
-#define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
-
 int dma_set_mask(struct device *dev, u64 dma_mask)
 {
 	if (ppc_md.dma_set_mask)
@@ -361,7 +359,6 @@ EXPORT_SYMBOL_GPL(dma_get_required_mask);
 
 static int __init dma_init(void)
 {
-	dma_debug_init(PREALLOC_DMA_DEBUG_ENTRIES);
 #ifdef CONFIG_PCI
 	dma_debug_add_bus(&pci_bus_type);
 #endif
diff --git a/arch/s390/pci/pci_dma.c b/arch/s390/pci/pci_dma.c
index 2d15d84c20ed..5dee7a922589 100644
--- a/arch/s390/pci/pci_dma.c
+++ b/arch/s390/pci/pci_dma.c
@@ -668,15 +668,6 @@ void zpci_dma_exit(void)
 	kmem_cache_destroy(dma_region_table_cache);
 }
 
-#define PREALLOC_DMA_DEBUG_ENTRIES	(1 << 16)
-
-static int __init dma_debug_do_init(void)
-{
-	dma_debug_init(PREALLOC_DMA_DEBUG_ENTRIES);
-	return 0;
-}
-fs_initcall(dma_debug_do_init);
-
 const struct dma_map_ops s390_pci_dma_ops = {
 	.alloc		= s390_dma_alloc,
 	.free		= s390_dma_free,
diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
index 8ce98691d822..35ea3099a3b6 100644
--- a/arch/sh/mm/consistent.c
+++ b/arch/sh/mm/consistent.c
@@ -20,18 +20,9 @@
 #include <asm/cacheflush.h>
 #include <asm/addrspace.h>
 
-#define PREALLOC_DMA_DEBUG_ENTRIES	4096
-
 const struct dma_map_ops *dma_ops;
 EXPORT_SYMBOL(dma_ops);
 
-static int __init dma_init(void)
-{
-	dma_debug_init(PREALLOC_DMA_DEBUG_ENTRIES);
-	return 0;
-}
-fs_initcall(dma_init);
-
 void *dma_generic_alloc_coherent(struct device *dev, size_t size,
 				 dma_addr_t *dma_handle, gfp_t gfp,
 				 unsigned long attrs)
diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index 76cb57750dda..84cfc5a428d6 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -74,8 +74,6 @@ obj-$(CONFIG_SPARC64)	+= pcr.o
 obj-$(CONFIG_SPARC64)	+= nmi.o
 obj-$(CONFIG_SPARC64_SMP) += cpumap.o
 
-obj-y                     += dma.o
-
 obj-$(CONFIG_PCIC_PCI)    += pcic.o
 obj-$(CONFIG_LEON_PCI)    += leon_pci.o
 obj-$(CONFIG_SPARC_GRPCI2)+= leon_pci_grpci2.o
diff --git a/arch/sparc/kernel/dma.c b/arch/sparc/kernel/dma.c
deleted file mode 100644
index f73e7597c971..000000000000
--- a/arch/sparc/kernel/dma.c
+++ /dev/null
@@ -1,13 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/kernel.h>
-#include <linux/dma-mapping.h>
-#include <linux/dma-debug.h>
-
-#define PREALLOC_DMA_DEBUG_ENTRIES       (1 << 15)
-
-static int __init dma_init(void)
-{
-	dma_debug_init(PREALLOC_DMA_DEBUG_ENTRIES);
-	return 0;
-}
-fs_initcall(dma_init);
diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index 77625b60a510..bcbaa2e8031e 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -55,9 +55,6 @@ struct device x86_dma_fallback_dev = {
 };
 EXPORT_SYMBOL(x86_dma_fallback_dev);
 
-/* Number of entries preallocated for DMA-API debugging */
-#define PREALLOC_DMA_DEBUG_ENTRIES       65536
-
 void __init pci_iommu_alloc(void)
 {
 	struct iommu_table_entry *p;
@@ -189,7 +186,6 @@ EXPORT_SYMBOL(arch_dma_supported);
 static int __init pci_iommu_init(void)
 {
 	struct iommu_table_entry *p;
-	dma_debug_init(PREALLOC_DMA_DEBUG_ENTRIES);
 
 #ifdef CONFIG_PCI
 	dma_debug_add_bus(&pci_bus_type);
diff --git a/arch/xtensa/kernel/pci-dma.c b/arch/xtensa/kernel/pci-dma.c
index 732631ce250f..392b4a80ebc2 100644
--- a/arch/xtensa/kernel/pci-dma.c
+++ b/arch/xtensa/kernel/pci-dma.c
@@ -261,12 +261,3 @@ const struct dma_map_ops xtensa_dma_map_ops = {
 	.mapping_error = xtensa_dma_mapping_error,
 };
 EXPORT_SYMBOL(xtensa_dma_map_ops);
-
-#define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
-
-static int __init xtensa_dma_init(void)
-{
-	dma_debug_init(PREALLOC_DMA_DEBUG_ENTRIES);
-	return 0;
-}
-fs_initcall(xtensa_dma_init);
diff --git a/include/linux/dma-debug.h b/include/linux/dma-debug.h
index c7d844f09c3a..a785f2507159 100644
--- a/include/linux/dma-debug.h
+++ b/include/linux/dma-debug.h
@@ -30,8 +30,6 @@ struct bus_type;
 
 extern void dma_debug_add_bus(struct bus_type *bus);
 
-extern void dma_debug_init(u32 num_entries);
-
 extern int dma_debug_resize_entries(u32 num_entries);
 
 extern void debug_dma_map_page(struct device *dev, struct page *page,
@@ -100,10 +98,6 @@ static inline void dma_debug_add_bus(struct bus_type *bus)
 {
 }
 
-static inline void dma_debug_init(u32 num_entries)
-{
-}
-
 static inline int dma_debug_resize_entries(u32 num_entries)
 {
 	return 0;
diff --git a/lib/dma-debug.c b/lib/dma-debug.c
index 7f5cdc1e6b29..712a897174e4 100644
--- a/lib/dma-debug.c
+++ b/lib/dma-debug.c
@@ -41,6 +41,11 @@
 #define HASH_FN_SHIFT   13
 #define HASH_FN_MASK    (HASH_SIZE - 1)
 
+/* allow architectures to override this if absolutely required */
+#ifndef PREALLOC_DMA_DEBUG_ENTRIES
+#define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
+#endif
+
 enum {
 	dma_debug_single,
 	dma_debug_page,
@@ -1004,18 +1009,16 @@ void dma_debug_add_bus(struct bus_type *bus)
 	bus_register_notifier(bus, nb);
 }
 
-/*
- * Let the architectures decide how many entries should be preallocated.
- */
-void dma_debug_init(u32 num_entries)
+static int dma_debug_init(void)
 {
+	u32 num_entries;
 	int i;
 
 	/* Do not use dma_debug_initialized here, since we really want to be
 	 * called to set dma_debug_initialized
 	 */
 	if (global_disable)
-		return;
+		return 0;
 
 	for (i = 0; i < HASH_SIZE; ++i) {
 		INIT_LIST_HEAD(&dma_entry_hash[i].list);
@@ -1026,17 +1029,19 @@ void dma_debug_init(u32 num_entries)
 		pr_err("DMA-API: error creating debugfs entries - disabling\n");
 		global_disable = true;
 
-		return;
+		return 0;
 	}
 
 	if (req_entries)
 		num_entries = req_entries;
+	else
+		num_entries = PREALLOC_DMA_DEBUG_ENTRIES;
 
 	if (prealloc_memory(num_entries) != 0) {
 		pr_err("DMA-API: debugging out of memory error - disabled\n");
 		global_disable = true;
 
-		return;
+		return 0;
 	}
 
 	nr_total_entries = num_free_entries;
@@ -1044,7 +1049,9 @@ void dma_debug_init(u32 num_entries)
 	dma_debug_initialized = true;
 
 	pr_info("DMA-API: debugging enabled by kernel config\n");
+	return 0;
 }
+core_initcall(dma_debug_init);
 
 static __init int dma_debug_cmdline(char *str)
 {
-- 
2.17.0

