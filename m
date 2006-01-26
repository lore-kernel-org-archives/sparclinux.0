From: Eric Sesterhenn / snakebyte <snakebyte@gmx.de>
Date: Thu, 26 Jan 2006 19:12:04 +0000
Subject: [Patch] BUG_ON() Conversion in arch/sparc/kernel/ioport.c
Message-Id: <1138302724.25503.1.camel@localhost>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

hi,

this changes if() BUG(); constructs to BUG_ON() which is
cleaner and can better optimized away

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>


--- linux-2.6.16-rc1-git4/arch/sparc/kernel/ioport.c.orig	2006-01-26 18:52:48.000000000 +0100
+++ linux-2.6.16-rc1-git4/arch/sparc/kernel/ioport.c	2006-01-26 18:56:00.000000000 +0100
@@ -217,7 +217,7 @@ static void _sparc_free_io(struct resour
 	unsigned long plen;
 
 	plen = res->end - res->start + 1;
-	if ((plen & (PAGE_SIZE-1)) != 0) BUG();
+	BUG_ON((plen & (PAGE_SIZE-1)) != 0);
 	sparc_unmapiorange(res->start, plen);
 	release_resource(res);
 }
@@ -512,8 +512,7 @@ void pci_free_consistent(struct pci_dev 
 dma_addr_t pci_map_single(struct pci_dev *hwdev, void *ptr, size_t size,
     int direction)
 {
-	if (direction = PCI_DMA_NONE)
-		BUG();
+	BUG_ON(direction = PCI_DMA_NONE);
 	/* IIep is write-through, not flushing. */
 	return virt_to_phys(ptr);
 }
@@ -528,8 +527,7 @@ dma_addr_t pci_map_single(struct pci_dev
 void pci_unmap_single(struct pci_dev *hwdev, dma_addr_t ba, size_t size,
     int direction)
 {
-	if (direction = PCI_DMA_NONE)
-		BUG();
+	BUG_ON(direction = PCI_DMA_NONE);
 	if (direction != PCI_DMA_TODEVICE) {
 		mmu_inval_dma_area((unsigned long)phys_to_virt(ba),
 		    (size + PAGE_SIZE-1) & PAGE_MASK);
@@ -542,8 +540,7 @@ void pci_unmap_single(struct pci_dev *hw
 dma_addr_t pci_map_page(struct pci_dev *hwdev, struct page *page,
 			unsigned long offset, size_t size, int direction)
 {
-	if (direction = PCI_DMA_NONE)
-		BUG();
+	BUG_ON(direction = PCI_DMA_NONE);
 	/* IIep is write-through, not flushing. */
 	return page_to_phys(page) + offset;
 }
@@ -551,8 +548,7 @@ dma_addr_t pci_map_page(struct pci_dev *
 void pci_unmap_page(struct pci_dev *hwdev,
 			dma_addr_t dma_address, size_t size, int direction)
 {
-	if (direction = PCI_DMA_NONE)
-		BUG();
+	BUG_ON(direction = PCI_DMA_NONE);
 	/* mmu_inval_dma_area XXX */
 }
 
@@ -576,11 +572,10 @@ int pci_map_sg(struct pci_dev *hwdev, st
 {
 	int n;
 
-	if (direction = PCI_DMA_NONE)
-		BUG();
+	BUG_ON(direction = PCI_DMA_NONE);
 	/* IIep is write-through, not flushing. */
 	for (n = 0; n < nents; n++) {
-		if (page_address(sg->page) = NULL) BUG();
+		BUG_ON(page_address(sg->page) = NULL);
 		sg->dvma_address = virt_to_phys(page_address(sg->page));
 		sg->dvma_length = sg->length;
 		sg++;
@@ -597,11 +592,10 @@ void pci_unmap_sg(struct pci_dev *hwdev,
 {
 	int n;
 
-	if (direction = PCI_DMA_NONE)
-		BUG();
+	BUG_ON(direction = PCI_DMA_NONE);
 	if (direction != PCI_DMA_TODEVICE) {
 		for (n = 0; n < nents; n++) {
-			if (page_address(sg->page) = NULL) BUG();
+			BUG_ON(page_address(sg->page) = NULL);
 			mmu_inval_dma_area(
 			    (unsigned long) page_address(sg->page),
 			    (sg->length + PAGE_SIZE-1) & PAGE_MASK);
@@ -622,8 +616,7 @@ void pci_unmap_sg(struct pci_dev *hwdev,
  */
 void pci_dma_sync_single_for_cpu(struct pci_dev *hwdev, dma_addr_t ba, size_t size, int direction)
 {
-	if (direction = PCI_DMA_NONE)
-		BUG();
+	BUG_ON(direction = PCI_DMA_NONE);
 	if (direction != PCI_DMA_TODEVICE) {
 		mmu_inval_dma_area((unsigned long)phys_to_virt(ba),
 		    (size + PAGE_SIZE-1) & PAGE_MASK);
@@ -632,8 +625,7 @@ void pci_dma_sync_single_for_cpu(struct 
 
 void pci_dma_sync_single_for_device(struct pci_dev *hwdev, dma_addr_t ba, size_t size, int direction)
 {
-	if (direction = PCI_DMA_NONE)
-		BUG();
+	BUG_ON(direction = PCI_DMA_NONE);
 	if (direction != PCI_DMA_TODEVICE) {
 		mmu_inval_dma_area((unsigned long)phys_to_virt(ba),
 		    (size + PAGE_SIZE-1) & PAGE_MASK);
@@ -650,11 +642,10 @@ void pci_dma_sync_sg_for_cpu(struct pci_
 {
 	int n;
 
-	if (direction = PCI_DMA_NONE)
-		BUG();
+	BUG_ON(direction = PCI_DMA_NONE);
 	if (direction != PCI_DMA_TODEVICE) {
 		for (n = 0; n < nents; n++) {
-			if (page_address(sg->page) = NULL) BUG();
+			BUG_ON(page_address(sg->page) = NULL);
 			mmu_inval_dma_area(
 			    (unsigned long) page_address(sg->page),
 			    (sg->length + PAGE_SIZE-1) & PAGE_MASK);
@@ -667,11 +658,10 @@ void pci_dma_sync_sg_for_device(struct p
 {
 	int n;
 
-	if (direction = PCI_DMA_NONE)
-		BUG();
+	BUG_ON(direction = PCI_DMA_NONE);
 	if (direction != PCI_DMA_TODEVICE) {
 		for (n = 0; n < nents; n++) {
-			if (page_address(sg->page) = NULL) BUG();
+			BUG_ON(page_address(sg->page) = NULL);
 			mmu_inval_dma_area(
 			    (unsigned long) page_address(sg->page),
 			    (sg->length + PAGE_SIZE-1) & PAGE_MASK);


