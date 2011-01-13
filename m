From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Thu, 13 Jan 2011 09:05:32 +0000
Subject: [PATCH 1/4 V2] sparc: Replace open coded page alignment with PAGE_ALIGN macro.
Message-Id: <1294909535-6290-2-git-send-email-kristoffer@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Kristoffer Glembo <kristoffer@gaisler.com>
---
 arch/sparc/kernel/ioport.c |   25 +++++++++++--------------
 1 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 41f7e4e..cea49c0 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -254,7 +254,7 @@ static void *sbus_alloc_coherent(struct device *dev, size_t len,
 				 dma_addr_t *dma_addrp, gfp_t gfp)
 {
 	struct platform_device *op = to_platform_device(dev);
-	unsigned long len_total = (len + PAGE_SIZE-1) & PAGE_MASK;
+	unsigned long len_total = PAGE_ALIGN(len);
 	unsigned long va;
 	struct resource *res;
 	int order;
@@ -281,6 +281,7 @@ static void *sbus_alloc_coherent(struct device *dev, size_t len,
 		goto err_nova;
 	}
 	mmu_inval_dma_area(va, len_total);
+
 	// XXX The mmu_map_dma_area does this for us below, see comments.
 	// sparc_mapiorange(0, virt_to_phys(va), res->start, len_total);
 	/*
@@ -321,7 +322,7 @@ static void sbus_free_coherent(struct device *dev, size_t n, void *p,
 		return;
 	}
 
-	n = (n + PAGE_SIZE-1) & PAGE_MASK;
+	n = PAGE_ALIGN(n);
 	if ((res->end-res->start)+1 != n) {
 		printk("sbus_free_consistent: region 0x%lx asked 0x%zx\n",
 		    (long)((res->end-res->start)+1), n);
@@ -430,7 +431,7 @@ arch_initcall(sparc_register_ioport);
 static void *pci32_alloc_coherent(struct device *dev, size_t len,
 				  dma_addr_t *pba, gfp_t gfp)
 {
-	unsigned long len_total = (len + PAGE_SIZE-1) & PAGE_MASK;
+	unsigned long len_total = PAGE_ALIGN(len);
 	unsigned long va;
 	struct resource *res;
 	int order;
@@ -463,10 +464,6 @@ static void *pci32_alloc_coherent(struct device *dev, size_t len,
 		return NULL;
 	}
 	mmu_inval_dma_area(va, len_total);
-#if 0
-/* P3 */ printk("pci_alloc_consistent: kva %lx uncva %lx phys %lx size %lx\n",
-  (long)va, (long)res->start, (long)virt_to_phys(va), len_total);
-#endif
 	sparc_mapiorange(0, virt_to_phys(va), res->start, len_total);
 
 	*pba = virt_to_phys(va); /* equals virt_to_bus (R.I.P.) for us. */
@@ -498,7 +495,7 @@ static void pci32_free_coherent(struct device *dev, size_t n, void *p,
 		return;
 	}
 
-	n = (n + PAGE_SIZE-1) & PAGE_MASK;
+	n = PAGE_ALIGN(n);
 	if ((res->end-res->start)+1 != n) {
 		printk("pci_free_consistent: region 0x%lx asked 0x%lx\n",
 		    (long)((res->end-res->start)+1), (long)n);
@@ -574,7 +571,7 @@ static void pci32_unmap_sg(struct device *dev, struct scatterlist *sgl,
 			BUG_ON(page_address(sg_page(sg)) = NULL);
 			mmu_inval_dma_area(
 			    (unsigned long) page_address(sg_page(sg)),
-			    (sg->length + PAGE_SIZE-1) & PAGE_MASK);
+			    PAGE_ALIGN(sg->length));
 		}
 	}
 }
@@ -594,7 +591,7 @@ static void pci32_sync_single_for_cpu(struct device *dev, dma_addr_t ba,
 {
 	if (dir != PCI_DMA_TODEVICE) {
 		mmu_inval_dma_area((unsigned long)phys_to_virt(ba),
-		    (size + PAGE_SIZE-1) & PAGE_MASK);
+				   PAGE_ALIGN(size));
 	}
 }
 
@@ -603,7 +600,7 @@ static void pci32_sync_single_for_device(struct device *dev, dma_addr_t ba,
 {
 	if (dir != PCI_DMA_TODEVICE) {
 		mmu_inval_dma_area((unsigned long)phys_to_virt(ba),
-		    (size + PAGE_SIZE-1) & PAGE_MASK);
+				   PAGE_ALIGN(size));
 	}
 }
 
@@ -624,7 +621,7 @@ static void pci32_sync_sg_for_cpu(struct device *dev, struct scatterlist *sgl,
 			BUG_ON(page_address(sg_page(sg)) = NULL);
 			mmu_inval_dma_area(
 			    (unsigned long) page_address(sg_page(sg)),
-			    (sg->length + PAGE_SIZE-1) & PAGE_MASK);
+			    PAGE_ALIGN(sg->length));
 		}
 	}
 }
@@ -640,7 +637,7 @@ static void pci32_sync_sg_for_device(struct device *device, struct scatterlist *
 			BUG_ON(page_address(sg_page(sg)) = NULL);
 			mmu_inval_dma_area(
 			    (unsigned long) page_address(sg_page(sg)),
-			    (sg->length + PAGE_SIZE-1) & PAGE_MASK);
+			    PAGE_ALIGN(sg->length));
 		}
 	}
 }
@@ -717,7 +714,7 @@ static const struct file_operations sparc_io_proc_fops = {
 static struct resource *_sparc_find_resource(struct resource *root,
 					     unsigned long hit)
 {
-        struct resource *tmp;
+	struct resource *tmp;
 
 	for (tmp = root->child; tmp != 0; tmp = tmp->sibling) {
 		if (tmp->start <= hit && tmp->end >= hit)
-- 
1.6.4.1

