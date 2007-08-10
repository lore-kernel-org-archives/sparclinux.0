From: Robert Reif <reif@earthlink.net>
Date: Fri, 10 Aug 2007 17:40:01 +0000
Subject: [SPARC]: Remove iommu from struct sbus_bus and use archdata like
Message-Id: <46BCA2F1.6080707@earthlink.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------090909040805050304030600"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------090909040805050304030600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Remove iommu from struct sbus_bus and use archdata like sparc64.

Signed-off-by: Robert Reif <reif@earthlink.net>

--------------090909040805050304030600
Content-Type: text/plain;
 name="iommu.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="iommu.diff.txt"

diff --git a/arch/sparc/kernel/ebus.c b/arch/sparc/kernel/ebus.c
index ac352eb..e2d02fd 100644
--- a/arch/sparc/kernel/ebus.c
+++ b/arch/sparc/kernel/ebus.c
@@ -238,6 +238,7 @@ void __init fill_ebus_device(struct device_node *dp, struct linux_ebus_device *d
 	sd = &dev->ofdev.dev.archdata;
 	sd->prom_node = dp;
 	sd->op = &dev->ofdev;
+	sd->iommu = dev->bus->ofdev.dev.parent->archdata.iommu;
 
 	dev->ofdev.node = dp;
 	dev->ofdev.dev.parent = &dev->bus->ofdev.dev;
diff --git a/arch/sparc/mm/io-unit.c b/arch/sparc/mm/io-unit.c
index 4ccda77..7c89893 100644
--- a/arch/sparc/mm/io-unit.c
+++ b/arch/sparc/mm/io-unit.c
@@ -66,7 +66,7 @@ iounit_init(int sbi_node, int io_node, struct sbus_bus *sbus)
 	}
 	if(!xpt) panic("Cannot map External Page Table.");
 	
-	sbus->iommu = (struct iommu_struct *)iounit;
+	sbus->ofdev.dev.archdata.iommu = iounit;
 	iounit->page_table = xpt;
 	spin_lock_init(&iounit->lock);
 	
@@ -127,7 +127,7 @@ nexti:	scan = find_next_zero_bit(iounit->bmap, limit, scan);
 static __u32 iounit_get_scsi_one(char *vaddr, unsigned long len, struct sbus_bus *sbus)
 {
 	unsigned long ret, flags;
-	struct iounit_struct *iounit = (struct iounit_struct *)sbus->iommu;
+	struct iounit_struct *iounit = sbus->ofdev.dev.archdata.iommu;
 	
 	spin_lock_irqsave(&iounit->lock, flags);
 	ret = iounit_get_area(iounit, (unsigned long)vaddr, len);
@@ -138,7 +138,7 @@ static __u32 iounit_get_scsi_one(char *vaddr, unsigned long len, struct sbus_bus
 static void iounit_get_scsi_sgl(struct scatterlist *sg, int sz, struct sbus_bus *sbus)
 {
 	unsigned long flags;
-	struct iounit_struct *iounit = (struct iounit_struct *)sbus->iommu;
+	struct iounit_struct *iounit = sbus->ofdev.dev.archdata.iommu;
 
 	/* FIXME: Cache some resolved pages - often several sg entries are to the same page */
 	spin_lock_irqsave(&iounit->lock, flags);
@@ -153,7 +153,7 @@ static void iounit_get_scsi_sgl(struct scatterlist *sg, int sz, struct sbus_bus
 static void iounit_release_scsi_one(__u32 vaddr, unsigned long len, struct sbus_bus *sbus)
 {
 	unsigned long flags;
-	struct iounit_struct *iounit = (struct iounit_struct *)sbus->iommu;
+	struct iounit_struct *iounit = sbus->ofdev.dev.archdata.iommu;
 	
 	spin_lock_irqsave(&iounit->lock, flags);
 	len = ((vaddr & ~PAGE_MASK) + len + (PAGE_SIZE-1)) >> PAGE_SHIFT;
@@ -168,7 +168,7 @@ static void iounit_release_scsi_sgl(struct scatterlist *sg, int sz, struct sbus_
 {
 	unsigned long flags;
 	unsigned long vaddr, len;
-	struct iounit_struct *iounit = (struct iounit_struct *)sbus->iommu;
+	struct iounit_struct *iounit = sbus->ofdev.dev.archdata.iommu;
 
 	spin_lock_irqsave(&iounit->lock, flags);
 	while (sz != 0) {
@@ -211,7 +211,7 @@ static int iounit_map_dma_area(dma_addr_t *pba, unsigned long va, __u32 addr, in
 			i = ((addr - IOUNIT_DMA_BASE) >> PAGE_SHIFT);
 
 			for_each_sbus(sbus) {
-				struct iounit_struct *iounit = (struct iounit_struct *)sbus->iommu;
+				struct iounit_struct *iounit = sbus->ofdev.dev.archdata.iommu;
 
 				iopte = (iopte_t *)(iounit->page_table + i);
 				*iopte = MKIOPTE(__pa(page));
@@ -235,7 +235,7 @@ static void iounit_unmap_dma_area(unsigned long addr, int len)
 static struct page *iounit_translate_dvma(unsigned long addr)
 {
 	struct sbus_bus *sbus = sbus_root;	/* They are all the same */
-	struct iounit_struct *iounit = (struct iounit_struct *)sbus->iommu;
+	struct iounit_struct *iounit = sbus->ofdev.dev.archdata.iommu;
 	int i;
 	iopte_t *iopte;
 
@@ -279,7 +279,7 @@ __u32 iounit_map_dma_init(struct sbus_bus *sbus, int size)
 	unsigned long rotor, scan, limit;
 	unsigned long flags;
 	__u32 ret;
-	struct iounit_struct *iounit = (struct iounit_struct *)sbus->iommu;
+	struct iounit_struct *iounit = sbus->ofdev.dev.archdata.iommu;
 
         npages = (size + (PAGE_SIZE-1)) >> PAGE_SHIFT;
 	i = 0x0213;
@@ -315,7 +315,7 @@ nexti:	scan = find_next_zero_bit(iounit->bmap, limit, scan);
 __u32 iounit_map_dma_page(__u32 vaddr, void *addr, struct sbus_bus *sbus)
 {
 	int scan = (vaddr - IOUNIT_DMA_BASE) >> PAGE_SHIFT;
-	struct iounit_struct *iounit = (struct iounit_struct *)sbus->iommu;
+	struct iounit_struct *iounit = sbus->ofdev.dev.archdata.iommu;
 	
 	iounit->page_table[scan] = MKIOPTE(__pa(((unsigned long)addr) & PAGE_MASK));
 	return vaddr + (((unsigned long)addr) & ~PAGE_MASK);
diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index be042ef..52e907a 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -132,7 +132,7 @@ iommu_init(int iommund, struct sbus_bus *sbus)
 	    impl, vers, iommu->page_table,
 	    (int)(IOMMU_NPTES*sizeof(iopte_t)), (int)IOMMU_NPTES);
 
-	sbus->iommu = iommu;
+	sbus->ofdev.dev.archdata.iommu = iommu;
 }
 
 /* This begs to be btfixup-ed by srmmu. */
@@ -166,7 +166,7 @@ static void iommu_flush_iotlb(iopte_t *iopte, unsigned int niopte)
 
 static u32 iommu_get_one(struct page *page, int npages, struct sbus_bus *sbus)
 {
-	struct iommu_struct *iommu = sbus->iommu;
+	struct iommu_struct *iommu = sbus->ofdev.dev.archdata.iommu;
 	int ioptex;
 	iopte_t *iopte, *iopte0;
 	unsigned int busa, busa0;
@@ -291,7 +291,7 @@ static void iommu_get_scsi_sgl_pflush(struct scatterlist *sg, int sz, struct sbu
 
 static void iommu_release_one(u32 busa, int npages, struct sbus_bus *sbus)
 {
-	struct iommu_struct *iommu = sbus->iommu;
+	struct iommu_struct *iommu = sbus->ofdev.dev.archdata.iommu;
 	int ioptex;
 	int i;
 
@@ -334,7 +334,7 @@ static int iommu_map_dma_area(dma_addr_t *pba, unsigned long va,
     unsigned long addr, int len)
 {
 	unsigned long page, end;
-	struct iommu_struct *iommu = sbus_root->iommu;
+	struct iommu_struct *iommu = sbus_root->ofdev.dev.archdata.iommu;
 	iopte_t *iopte = iommu->page_table;
 	iopte_t *first;
 	int ioptex;
@@ -399,7 +399,7 @@ static int iommu_map_dma_area(dma_addr_t *pba, unsigned long va,
 
 static void iommu_unmap_dma_area(unsigned long busa, int len)
 {
-	struct iommu_struct *iommu = sbus_root->iommu;
+	struct iommu_struct *iommu = sbus_root->ofdev.dev.archdata.iommu;
 	iopte_t *iopte = iommu->page_table;
 	unsigned long end;
 	int ioptex = (busa - iommu->start) >> PAGE_SHIFT;
@@ -420,7 +420,7 @@ static void iommu_unmap_dma_area(unsigned long busa, int len)
 
 static struct page *iommu_translate_dvma(unsigned long busa)
 {
-	struct iommu_struct *iommu = sbus_root->iommu;
+	struct iommu_struct *iommu = sbus_root->ofdev.dev.archdata.iommu;
 	iopte_t *iopte = iommu->page_table;
 
 	iopte += ((busa - iommu->start) >> PAGE_SHIFT);
diff --git a/include/asm-sparc/sbus.h b/include/asm-sparc/sbus.h
index d036e44..27d076c 100644
--- a/include/asm-sparc/sbus.h
+++ b/include/asm-sparc/sbus.h
@@ -68,7 +68,6 @@ struct sbus_dev {
 /* This struct describes the SBus(s) found on this machine. */
 struct sbus_bus {
 	struct of_device	ofdev;
-	void			*iommu;		/* Opaque IOMMU cookie */
 	struct sbus_dev		*devices;	/* Link to devices on this SBus */
 	struct sbus_bus		*next;		/* next SBus, if more than one SBus */
 	int			prom_node;	/* PROM device tree node for this SBus */

--------------090909040805050304030600--

