From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:23:34 +0000
Subject: [PATCH 7/49]: sparc32: Make mmu_{get,release}_*() take a struct
Message-Id: <20080827.212334.157789344.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc32: Make mmu_{get,release}_*() take a struct device pointer.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/dma.h |   22 ++++++++++++--------
 arch/sparc/kernel/ioport.c   |   17 +++------------
 arch/sparc/mm/io-unit.c      |   16 +++++++-------
 arch/sparc/mm/iommu.c        |   45 ++++++++++++++++++++---------------------
 4 files changed, 47 insertions(+), 53 deletions(-)

diff --git a/arch/sparc/include/asm/dma.h b/arch/sparc/include/asm/dma.h
index 4935634..5955177 100644
--- a/arch/sparc/include/asm/dma.h
+++ b/arch/sparc/include/asm/dma.h
@@ -100,16 +100,20 @@ BTFIXUPDEF_CALL(void,   mmu_unlockarea, char *, unsigned long)
 #define mmu_lockarea(vaddr,len) BTFIXUP_CALL(mmu_lockarea)(vaddr,len)
 #define mmu_unlockarea(vaddr,len) BTFIXUP_CALL(mmu_unlockarea)(vaddr,len)
 
+struct page;
+struct device;
+struct scatterlist;
+
 /* These are implementations for sbus_map_sg/sbus_unmap_sg... collapse later */
-BTFIXUPDEF_CALL(__u32, mmu_get_scsi_one, char *, unsigned long, struct sbus_bus *sbus)
-BTFIXUPDEF_CALL(void,  mmu_get_scsi_sgl, struct scatterlist *, int, struct sbus_bus *sbus)
-BTFIXUPDEF_CALL(void,  mmu_release_scsi_one, __u32, unsigned long, struct sbus_bus *sbus)
-BTFIXUPDEF_CALL(void,  mmu_release_scsi_sgl, struct scatterlist *, int, struct sbus_bus *sbus)
-
-#define mmu_get_scsi_one(vaddr,len,sbus) BTFIXUP_CALL(mmu_get_scsi_one)(vaddr,len,sbus)
-#define mmu_get_scsi_sgl(sg,sz,sbus) BTFIXUP_CALL(mmu_get_scsi_sgl)(sg,sz,sbus)
-#define mmu_release_scsi_one(vaddr,len,sbus) BTFIXUP_CALL(mmu_release_scsi_one)(vaddr,len,sbus)
-#define mmu_release_scsi_sgl(sg,sz,sbus) BTFIXUP_CALL(mmu_release_scsi_sgl)(sg,sz,sbus)
+BTFIXUPDEF_CALL(__u32, mmu_get_scsi_one, struct device *, char *, unsigned long)
+BTFIXUPDEF_CALL(void,  mmu_get_scsi_sgl, struct device *, struct scatterlist *, int)
+BTFIXUPDEF_CALL(void,  mmu_release_scsi_one, struct device *, __u32, unsigned long)
+BTFIXUPDEF_CALL(void,  mmu_release_scsi_sgl, struct device *, struct scatterlist *, int)
+
+#define mmu_get_scsi_one(dev,vaddr,len) BTFIXUP_CALL(mmu_get_scsi_one)(dev,vaddr,len)
+#define mmu_get_scsi_sgl(dev,sg,sz) BTFIXUP_CALL(mmu_get_scsi_sgl)(dev,sg,sz)
+#define mmu_release_scsi_one(dev,vaddr,len) BTFIXUP_CALL(mmu_release_scsi_one)(dev,vaddr,len)
+#define mmu_release_scsi_sgl(dev,sg,sz) BTFIXUP_CALL(mmu_release_scsi_sgl)(dev,sg,sz)
 
 /*
  * mmu_map/unmap are provided by iommu/iounit; Invalid to call on IIep.
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index aa73b3b..11dccf9 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -394,8 +394,6 @@ void sbus_free_consistent(struct device *dev, long n, void *p, u32 ba)
  */
 dma_addr_t sbus_map_single(struct device *dev, void *va, size_t len, int direction)
 {
-	struct sbus_dev *sdev = to_sbus_device(dev);
-
 	/* XXX why are some lengths signed, others unsigned? */
 	if (len <= 0) {
 		return 0;
@@ -404,20 +402,17 @@ dma_addr_t sbus_map_single(struct device *dev, void *va, size_t len, int directi
 	if (len > 256*1024) {			/* __get_free_pages() limit */
 		return 0;
 	}
-	return mmu_get_scsi_one(va, len, sdev->bus);
+	return mmu_get_scsi_one(dev, va, len);
 }
 
 void sbus_unmap_single(struct device *dev, dma_addr_t ba, size_t n, int direction)
 {
-	struct sbus_dev *sdev = to_sbus_device(dev);
-	mmu_release_scsi_one(ba, n, sdev->bus);
+	mmu_release_scsi_one(dev, ba, n);
 }
 
 int sbus_map_sg(struct device *dev, struct scatterlist *sg, int n, int direction)
 {
-	struct sbus_dev *sdev = to_sbus_device(dev);
-
-	mmu_get_scsi_sgl(sg, n, sdev->bus);
+	mmu_get_scsi_sgl(dev, sg, n);
 
 	/*
 	 * XXX sparc64 can return a partial length here. sun4c should do this
@@ -428,9 +423,7 @@ int sbus_map_sg(struct device *dev, struct scatterlist *sg, int n, int direction
 
 void sbus_unmap_sg(struct device *dev, struct scatterlist *sg, int n, int direction)
 {
-	struct sbus_dev *sdev = to_sbus_device(dev);
-
-	mmu_release_scsi_sgl(sg, n, sdev->bus);
+	mmu_release_scsi_sgl(dev, sg, n);
 }
 
 /*
@@ -438,7 +431,6 @@ void sbus_unmap_sg(struct device *dev, struct scatterlist *sg, int n, int direct
 void sbus_dma_sync_single_for_cpu(struct device *dev, dma_addr_t ba, size_t size, int direction)
 {
 #if 0
-	struct sbus_dev *sdev = to_sbus_device(dev);
 	unsigned long va;
 	struct resource *res;
 
@@ -459,7 +451,6 @@ void sbus_dma_sync_single_for_cpu(struct device *dev, dma_addr_t ba, size_t size
 void sbus_dma_sync_single_for_device(struct device *dev, dma_addr_t ba, size_t size, int direction)
 {
 #if 0
-	struct sbus_dev *sdev = to_sbus_device(dev);
 	unsigned long va;
 	struct resource *res;
 
diff --git a/arch/sparc/mm/io-unit.c b/arch/sparc/mm/io-unit.c
index 1093514..4239655 100644
--- a/arch/sparc/mm/io-unit.c
+++ b/arch/sparc/mm/io-unit.c
@@ -125,10 +125,10 @@ nexti:	scan = find_next_zero_bit(iounit->bmap, limit, scan);
 	return vaddr;
 }
 
-static __u32 iounit_get_scsi_one(char *vaddr, unsigned long len, struct sbus_bus *sbus)
+static __u32 iounit_get_scsi_one(struct device *dev, char *vaddr, unsigned long len)
 {
+	struct iounit_struct *iounit = dev->archdata.iommu;
 	unsigned long ret, flags;
-	struct iounit_struct *iounit = sbus->ofdev.dev.archdata.iommu;
 	
 	spin_lock_irqsave(&iounit->lock, flags);
 	ret = iounit_get_area(iounit, (unsigned long)vaddr, len);
@@ -136,10 +136,10 @@ static __u32 iounit_get_scsi_one(char *vaddr, unsigned long len, struct sbus_bus
 	return ret;
 }
 
-static void iounit_get_scsi_sgl(struct scatterlist *sg, int sz, struct sbus_bus *sbus)
+static void iounit_get_scsi_sgl(struct device *dev, struct scatterlist *sg, int sz)
 {
+	struct iounit_struct *iounit = dev->archdata.iommu;
 	unsigned long flags;
-	struct iounit_struct *iounit = sbus->ofdev.dev.archdata.iommu;
 
 	/* FIXME: Cache some resolved pages - often several sg entries are to the same page */
 	spin_lock_irqsave(&iounit->lock, flags);
@@ -152,10 +152,10 @@ static void iounit_get_scsi_sgl(struct scatterlist *sg, int sz, struct sbus_bus
 	spin_unlock_irqrestore(&iounit->lock, flags);
 }
 
-static void iounit_release_scsi_one(__u32 vaddr, unsigned long len, struct sbus_bus *sbus)
+static void iounit_release_scsi_one(struct device *dev, __u32 vaddr, unsigned long len)
 {
+	struct iounit_struct *iounit = dev->archdata.iommu;
 	unsigned long flags;
-	struct iounit_struct *iounit = sbus->ofdev.dev.archdata.iommu;
 	
 	spin_lock_irqsave(&iounit->lock, flags);
 	len = ((vaddr & ~PAGE_MASK) + len + (PAGE_SIZE-1)) >> PAGE_SHIFT;
@@ -166,11 +166,11 @@ static void iounit_release_scsi_one(__u32 vaddr, unsigned long len, struct sbus_
 	spin_unlock_irqrestore(&iounit->lock, flags);
 }
 
-static void iounit_release_scsi_sgl(struct scatterlist *sg, int sz, struct sbus_bus *sbus)
+static void iounit_release_scsi_sgl(struct device *dev, struct scatterlist *sg, int sz)
 {
+	struct iounit_struct *iounit = dev->archdata.iommu;
 	unsigned long flags;
 	unsigned long vaddr, len;
-	struct iounit_struct *iounit = sbus->ofdev.dev.archdata.iommu;
 
 	spin_lock_irqsave(&iounit->lock, flags);
 	while (sz != 0) {
diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index a86c9f5..8e9ab93 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -169,9 +169,9 @@ static void iommu_flush_iotlb(iopte_t *iopte, unsigned int niopte)
 	}
 }
 
-static u32 iommu_get_one(struct page *page, int npages, struct sbus_bus *sbus)
+static u32 iommu_get_one(struct device *dev, struct page *page, int npages)
 {
-	struct iommu_struct *iommu = sbus->ofdev.dev.archdata.iommu;
+	struct iommu_struct *iommu = dev->archdata.iommu;
 	int ioptex;
 	iopte_t *iopte, *iopte0;
 	unsigned int busa, busa0;
@@ -199,8 +199,7 @@ static u32 iommu_get_one(struct page *page, int npages, struct sbus_bus *sbus)
 	return busa0;
 }
 
-static u32 iommu_get_scsi_one(char *vaddr, unsigned int len,
-    struct sbus_bus *sbus)
+static u32 iommu_get_scsi_one(struct device *dev, char *vaddr, unsigned int len)
 {
 	unsigned long off;
 	int npages;
@@ -210,22 +209,22 @@ static u32 iommu_get_scsi_one(char *vaddr, unsigned int len,
 	off = (unsigned long)vaddr & ~PAGE_MASK;
 	npages = (off + len + PAGE_SIZE-1) >> PAGE_SHIFT;
 	page = virt_to_page((unsigned long)vaddr & PAGE_MASK);
-	busa = iommu_get_one(page, npages, sbus);
+	busa = iommu_get_one(dev, page, npages);
 	return busa + off;
 }
 
-static __u32 iommu_get_scsi_one_noflush(char *vaddr, unsigned long len, struct sbus_bus *sbus)
+static __u32 iommu_get_scsi_one_noflush(struct device *dev, char *vaddr, unsigned long len)
 {
-	return iommu_get_scsi_one(vaddr, len, sbus);
+	return iommu_get_scsi_one(dev, vaddr, len);
 }
 
-static __u32 iommu_get_scsi_one_gflush(char *vaddr, unsigned long len, struct sbus_bus *sbus)
+static __u32 iommu_get_scsi_one_gflush(struct device *dev, char *vaddr, unsigned long len)
 {
 	flush_page_for_dma(0);
-	return iommu_get_scsi_one(vaddr, len, sbus);
+	return iommu_get_scsi_one(dev, vaddr, len);
 }
 
-static __u32 iommu_get_scsi_one_pflush(char *vaddr, unsigned long len, struct sbus_bus *sbus)
+static __u32 iommu_get_scsi_one_pflush(struct device *dev, char *vaddr, unsigned long len)
 {
 	unsigned long page = ((unsigned long) vaddr) & PAGE_MASK;
 
@@ -233,23 +232,23 @@ static __u32 iommu_get_scsi_one_pflush(char *vaddr, unsigned long len, struct sb
 		flush_page_for_dma(page);
 		page += PAGE_SIZE;
 	}
-	return iommu_get_scsi_one(vaddr, len, sbus);
+	return iommu_get_scsi_one(dev, vaddr, len);
 }
 
-static void iommu_get_scsi_sgl_noflush(struct scatterlist *sg, int sz, struct sbus_bus *sbus)
+static void iommu_get_scsi_sgl_noflush(struct device *dev, struct scatterlist *sg, int sz)
 {
 	int n;
 
 	while (sz != 0) {
 		--sz;
 		n = (sg->length + sg->offset + PAGE_SIZE-1) >> PAGE_SHIFT;
-		sg->dvma_address = iommu_get_one(sg_page(sg), n, sbus) + sg->offset;
+		sg->dvma_address = iommu_get_one(dev, sg_page(sg), n) + sg->offset;
 		sg->dvma_length = (__u32) sg->length;
 		sg = sg_next(sg);
 	}
 }
 
-static void iommu_get_scsi_sgl_gflush(struct scatterlist *sg, int sz, struct sbus_bus *sbus)
+static void iommu_get_scsi_sgl_gflush(struct device *dev, struct scatterlist *sg, int sz)
 {
 	int n;
 
@@ -257,13 +256,13 @@ static void iommu_get_scsi_sgl_gflush(struct scatterlist *sg, int sz, struct sbu
 	while (sz != 0) {
 		--sz;
 		n = (sg->length + sg->offset + PAGE_SIZE-1) >> PAGE_SHIFT;
-		sg->dvma_address = iommu_get_one(sg_page(sg), n, sbus) + sg->offset;
+		sg->dvma_address = iommu_get_one(dev, sg_page(sg), n) + sg->offset;
 		sg->dvma_length = (__u32) sg->length;
 		sg = sg_next(sg);
 	}
 }
 
-static void iommu_get_scsi_sgl_pflush(struct scatterlist *sg, int sz, struct sbus_bus *sbus)
+static void iommu_get_scsi_sgl_pflush(struct device *dev, struct scatterlist *sg, int sz)
 {
 	unsigned long page, oldpage = 0;
 	int n, i;
@@ -288,15 +287,15 @@ static void iommu_get_scsi_sgl_pflush(struct scatterlist *sg, int sz, struct sbu
 			}
 		}
 
-		sg->dvma_address = iommu_get_one(sg_page(sg), n, sbus) + sg->offset;
+		sg->dvma_address = iommu_get_one(dev, sg_page(sg), n) + sg->offset;
 		sg->dvma_length = (__u32) sg->length;
 		sg = sg_next(sg);
 	}
 }
 
-static void iommu_release_one(u32 busa, int npages, struct sbus_bus *sbus)
+static void iommu_release_one(struct device *dev, u32 busa, int npages)
 {
-	struct iommu_struct *iommu = sbus->ofdev.dev.archdata.iommu;
+	struct iommu_struct *iommu = dev->archdata.iommu;
 	int ioptex;
 	int i;
 
@@ -310,17 +309,17 @@ static void iommu_release_one(u32 busa, int npages, struct sbus_bus *sbus)
 	bit_map_clear(&iommu->usemap, ioptex, npages);
 }
 
-static void iommu_release_scsi_one(__u32 vaddr, unsigned long len, struct sbus_bus *sbus)
+static void iommu_release_scsi_one(struct device *dev, __u32 vaddr, unsigned long len)
 {
 	unsigned long off;
 	int npages;
 
 	off = vaddr & ~PAGE_MASK;
 	npages = (off + len + PAGE_SIZE-1) >> PAGE_SHIFT;
-	iommu_release_one(vaddr & PAGE_MASK, npages, sbus);
+	iommu_release_one(dev, vaddr & PAGE_MASK, npages);
 }
 
-static void iommu_release_scsi_sgl(struct scatterlist *sg, int sz, struct sbus_bus *sbus)
+static void iommu_release_scsi_sgl(struct device *dev, struct scatterlist *sg, int sz)
 {
 	int n;
 
@@ -328,7 +327,7 @@ static void iommu_release_scsi_sgl(struct scatterlist *sg, int sz, struct sbus_b
 		--sz;
 
 		n = (sg->length + sg->offset + PAGE_SIZE-1) >> PAGE_SHIFT;
-		iommu_release_one(sg->dvma_address & PAGE_MASK, n, sbus);
+		iommu_release_one(dev, sg->dvma_address & PAGE_MASK, n);
 		sg->dvma_address = 0x21212121;
 		sg = sg_next(sg);
 	}
-- 
1.5.6.5.GIT

