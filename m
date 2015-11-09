From: Christoph Hellwig <hch@lst.de>
Date: Mon, 09 Nov 2015 18:17:21 +0000
Subject: [PATCH 16/16] dma-mapping: remove <asm-generic/dma-coherent.h>
Message-Id: <1447093041-21832-17-git-send-email-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1447093041-21832-1-git-send-email-hch@lst.de>
In-Reply-To: <1447093041-21832-1-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Steven Miao <realmz6@gmail.com>, Ley Foon Tan <lftan@altera.com>, David Howells <dhowells@redhat.com>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, Chris Metcalf <cmetcalf@ezchip.com>, linux-snps-arc@lists.infraded.org, linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com, linux-parisc@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org, sparclinux@vger.kernel.org, iommu@lists.linux-foundation.org

This wasn't an asm-generic header to start with, and can be merged into
dma-mapping.h trivially.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/xtensa/include/asm/dma-mapping.h |  2 --
 drivers/base/dma-mapping.c            |  3 +--
 include/asm-generic/dma-coherent.h    | 32 --------------------------------
 include/linux/dma-mapping.h           | 34 ++++++++++++++++++++++++++++------
 4 files changed, 29 insertions(+), 42 deletions(-)
 delete mode 100644 include/asm-generic/dma-coherent.h

diff --git a/arch/xtensa/include/asm/dma-mapping.h b/arch/xtensa/include/asm/dma-mapping.h
index 32350e9..4e6ff4d 100644
--- a/arch/xtensa/include/asm/dma-mapping.h
+++ b/arch/xtensa/include/asm/dma-mapping.h
@@ -13,8 +13,6 @@
 #include <asm/cache.h>
 #include <asm/io.h>
 
-#include <asm-generic/dma-coherent.h>
-
 #include <linux/mm.h>
 #include <linux/scatterlist.h>
 
diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
index 381e39d..d799662 100644
--- a/drivers/base/dma-mapping.c
+++ b/drivers/base/dma-mapping.c
@@ -12,7 +12,6 @@
 #include <linux/gfp.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
-#include <asm-generic/dma-coherent.h>
 
 /*
  * Managed DMA API
@@ -167,7 +166,7 @@ void dmam_free_noncoherent(struct device *dev, size_t size, void *vaddr,
 }
 EXPORT_SYMBOL(dmam_free_noncoherent);
 
-#ifdef ARCH_HAS_DMA_DECLARE_COHERENT_MEMORY
+#ifdef CONFIG_HAVE_GENERIC_DMA_COHERENT
 
 static void dmam_coherent_decl_release(struct device *dev, void *res)
 {
diff --git a/include/asm-generic/dma-coherent.h b/include/asm-generic/dma-coherent.h
deleted file mode 100644
index 0297e58..0000000
--- a/include/asm-generic/dma-coherent.h
+++ /dev/null
@@ -1,32 +0,0 @@
-#ifndef DMA_COHERENT_H
-#define DMA_COHERENT_H
-
-#ifdef CONFIG_HAVE_GENERIC_DMA_COHERENT
-/*
- * These three functions are only for dma allocator.
- * Don't use them in device drivers.
- */
-int dma_alloc_from_coherent(struct device *dev, ssize_t size,
-				       dma_addr_t *dma_handle, void **ret);
-int dma_release_from_coherent(struct device *dev, int order, void *vaddr);
-
-int dma_mmap_from_coherent(struct device *dev, struct vm_area_struct *vma,
-			    void *cpu_addr, size_t size, int *ret);
-/*
- * Standard interface
- */
-#define ARCH_HAS_DMA_DECLARE_COHERENT_MEMORY
-int dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
-				dma_addr_t device_addr, size_t size, int flags);
-
-void dma_release_declared_memory(struct device *dev);
-
-void *dma_mark_declared_memory_occupied(struct device *dev,
-					dma_addr_t device_addr, size_t size);
-#else
-#define dma_alloc_from_coherent(dev, size, handle, ret) (0)
-#define dma_release_from_coherent(dev, order, vaddr) (0)
-#define dma_mmap_from_coherent(dev, vma, vaddr, order, ret) (0)
-#endif
-
-#endif
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index cc0517b..d6b575b 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -11,7 +11,6 @@
 #include <linux/scatterlist.h>
 #include <linux/kmemcheck.h>
 #include <linux/bug.h>
-#include <asm-generic/dma-coherent.h>
 
 /*
  * A dma_addr_t can hold any valid DMA or bus address for the platform.
@@ -87,6 +86,23 @@ static inline int is_device_dma_capable(struct device *dev)
 	return dev->dma_mask != NULL && *dev->dma_mask != DMA_MASK_NONE;
 }
 
+#ifdef CONFIG_HAVE_GENERIC_DMA_COHERENT
+/*
+ * These three functions are only for dma allocator.
+ * Don't use them in device drivers.
+ */
+int dma_alloc_from_coherent(struct device *dev, ssize_t size,
+				       dma_addr_t *dma_handle, void **ret);
+int dma_release_from_coherent(struct device *dev, int order, void *vaddr);
+
+int dma_mmap_from_coherent(struct device *dev, struct vm_area_struct *vma,
+			    void *cpu_addr, size_t size, int *ret);
+#else
+#define dma_alloc_from_coherent(dev, size, handle, ret) (0)
+#define dma_release_from_coherent(dev, order, vaddr) (0)
+#define dma_mmap_from_coherent(dev, vma, vaddr, order, ret) (0)
+#endif /* CONFIG_HAVE_GENERIC_DMA_COHERENT */
+
 #ifdef CONFIG_HAS_DMA
 #include <asm/dma-mapping.h>
 #else
@@ -568,7 +584,13 @@ static inline int dma_get_cache_alignment(void)
 #define DMA_MEMORY_INCLUDES_CHILDREN	0x04
 #define DMA_MEMORY_EXCLUSIVE		0x08
 
-#ifndef ARCH_HAS_DMA_DECLARE_COHERENT_MEMORY
+#ifdef CONFIG_HAVE_GENERIC_DMA_COHERENT
+int dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
+				dma_addr_t device_addr, size_t size, int flags);
+void dma_release_declared_memory(struct device *dev);
+void *dma_mark_declared_memory_occupied(struct device *dev,
+					dma_addr_t device_addr, size_t size);
+#else
 static inline int
 dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
 			    dma_addr_t device_addr, size_t size, int flags)
@@ -587,7 +609,7 @@ dma_mark_declared_memory_occupied(struct device *dev,
 {
 	return ERR_PTR(-EBUSY);
 }
-#endif
+#endif /* CONFIG_HAVE_GENERIC_DMA_COHERENT */
 
 /*
  * Managed DMA API
@@ -600,13 +622,13 @@ extern void *dmam_alloc_noncoherent(struct device *dev, size_t size,
 				    dma_addr_t *dma_handle, gfp_t gfp);
 extern void dmam_free_noncoherent(struct device *dev, size_t size, void *vaddr,
 				  dma_addr_t dma_handle);
-#ifdef ARCH_HAS_DMA_DECLARE_COHERENT_MEMORY
+#ifdef CONFIG_HAVE_GENERIC_DMA_COHERENT
 extern int dmam_declare_coherent_memory(struct device *dev,
 					phys_addr_t phys_addr,
 					dma_addr_t device_addr, size_t size,
 					int flags);
 extern void dmam_release_declared_memory(struct device *dev);
-#else /* ARCH_HAS_DMA_DECLARE_COHERENT_MEMORY */
+#else /* CONFIG_HAVE_GENERIC_DMA_COHERENT */
 static inline int dmam_declare_coherent_memory(struct device *dev,
 				phys_addr_t phys_addr, dma_addr_t device_addr,
 				size_t size, gfp_t gfp)
@@ -617,7 +639,7 @@ static inline int dmam_declare_coherent_memory(struct device *dev,
 static inline void dmam_release_declared_memory(struct device *dev)
 {
 }
-#endif /* ARCH_HAS_DMA_DECLARE_COHERENT_MEMORY */
+#endif /* CONFIG_HAVE_GENERIC_DMA_COHERENT */
 
 static inline void *dma_alloc_writecombine(struct device *dev, size_t size,
 					   dma_addr_t *dma_addr, gfp_t gfp)
-- 
1.9.1

