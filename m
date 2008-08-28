From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:25:09 +0000
Subject: [PATCH 44/49]: sparc: Remove generic SBUS probing layer.
Message-Id: <20080827.212509.114520998.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc: Remove generic SBUS probing layer.

The individual SBUS IOMMU arch code now sets the IOMMU information
directly into the OF device objects.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/io-unit.h  |    2 -
 arch/sparc/include/asm/iommu_32.h |    2 -
 arch/sparc/include/asm/irq_64.h   |    1 -
 arch/sparc/kernel/ioport.c        |   23 -----
 arch/sparc/mm/io-unit.c           |   30 +++++--
 arch/sparc/mm/iommu.c             |   40 +++++----
 arch/sparc64/kernel/sbus.c        |  122 +++++++++++++++------------
 drivers/sbus/Makefile             |    4 -
 drivers/sbus/sbus.c               |  170 -------------------------------------
 9 files changed, 108 insertions(+), 286 deletions(-)
 delete mode 100644 drivers/sbus/sbus.c

diff --git a/arch/sparc/include/asm/io-unit.h b/arch/sparc/include/asm/io-unit.h
index 5df63ef..96823b4 100644
--- a/arch/sparc/include/asm/io-unit.h
+++ b/arch/sparc/include/asm/io-unit.h
@@ -59,6 +59,4 @@ extern __u32 iounit_map_dma_init(struct sbus_bus *, int);
 #define iounit_map_dma_finish(sbus, addr, len) mmu_release_scsi_one(addr, len, sbus)
 extern __u32 iounit_map_dma_page(__u32, void *, struct sbus_bus *);
 
-extern void iounit_init(struct sbus_bus *sbus);
-
 #endif /* !(_SPARC_IO_UNIT_H) */
diff --git a/arch/sparc/include/asm/iommu_32.h b/arch/sparc/include/asm/iommu_32.h
index 6b115a1..70c589c 100644
--- a/arch/sparc/include/asm/iommu_32.h
+++ b/arch/sparc/include/asm/iommu_32.h
@@ -118,6 +118,4 @@ static inline void iommu_invalidate_page(struct iommu_regs *regs, unsigned long
 	regs->pageflush = (ba & PAGE_MASK);
 }
 
-extern void iommu_init(struct device_node *dp, struct sbus_bus *sbus);
-
 #endif /* !(_SPARC_IOMMU_H) */
diff --git a/arch/sparc/include/asm/irq_64.h b/arch/sparc/include/asm/irq_64.h
index e3dd930..71673ec 100644
--- a/arch/sparc/include/asm/irq_64.h
+++ b/arch/sparc/include/asm/irq_64.h
@@ -56,7 +56,6 @@ extern unsigned int sun4u_build_msi(u32 portid, unsigned int *virt_irq_p,
 				    unsigned long imap_base,
 				    unsigned long iclr_base);
 extern void sun4u_destroy_msi(unsigned int virt_irq);
-extern unsigned int sbus_build_irq(void *sbus, unsigned int ino);
 
 extern unsigned char virt_irq_alloc(unsigned int dev_handle,
 				    unsigned int dev_ino);
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 24645f9..bca2d6f 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -377,22 +377,6 @@ void sbus_dma_sync_single_for_device(struct device *dev, dma_addr_t ba, size_t s
 {
 }
 
-/* Support code for sbus_init().  */
-void __init sbus_setup_iommu(struct sbus_bus *sbus, struct device_node *dp)
-{
-#ifndef CONFIG_SUN4
-	struct device_node *parent = dp->parent;
-
-	if (sparc_cpu_model != sun4d &&
-	    parent != NULL &&
-	    !strcmp(parent->name, "iommu"))
-		iommu_init(parent, sbus);
-
-	if (sparc_cpu_model = sun4d)
-		iounit_init(sbus);
-#endif
-}
-
 static int __init sparc_register_ioport(void)
 {
 	register_proc_sparc_ioport();
@@ -402,13 +386,6 @@ static int __init sparc_register_ioport(void)
 
 arch_initcall(sparc_register_ioport);
 
-void __init sbus_arch_postinit(void)
-{
-	if (sparc_cpu_model = sun4d) {
-		extern void sun4d_init_sbi_irq(void);
-		sun4d_init_sbi_irq();
-	}
-}
 #endif /* CONFIG_SBUS */
 
 #ifdef CONFIG_PCI
diff --git a/arch/sparc/mm/io-unit.c b/arch/sparc/mm/io-unit.c
index 0f97ab3..caf551a 100644
--- a/arch/sparc/mm/io-unit.c
+++ b/arch/sparc/mm/io-unit.c
@@ -34,18 +34,10 @@
 #define IOPERM        (IOUPTE_CACHE | IOUPTE_WRITE | IOUPTE_VALID)
 #define MKIOPTE(phys) __iopte((((phys)>>4) & IOUPTE_PAGE) | IOPERM)
 
-void __init iounit_init(struct sbus_bus *sbus)
+static void __init iounit_iommu_init(struct of_device *op)
 {
-	struct device_node *dp = sbus->ofdev.node;
 	struct iounit_struct *iounit;
 	iopte_t *xpt, *xptend;
-	struct of_device *op;
-
-	op = of_find_device_by_node(dp);
-	if (!op) {
-		prom_printf("SUN4D: Cannot find SBI of_device.\n");
-		prom_halt();
-	}
 
 	iounit = kzalloc(sizeof(struct iounit_struct), GFP_ATOMIC);
 	if (!iounit) {
@@ -66,7 +58,6 @@ void __init iounit_init(struct sbus_bus *sbus)
 		prom_halt();
 	}
 	
-	sbus->ofdev.dev.archdata.iommu = iounit;
 	op->dev.archdata.iommu = iounit;
 	iounit->page_table = xpt;
 	spin_lock_init(&iounit->lock);
@@ -76,6 +67,25 @@ void __init iounit_init(struct sbus_bus *sbus)
 	     	iopte_val(*xpt++) = 0;
 }
 
+static int __init iounit_init(void)
+{
+	extern void sun4d_init_sbi_irq(void);
+	struct device_node *dp;
+
+	for_each_node_by_name(dp, "sbi") {
+		struct of_device *op = of_find_device_by_node(dp);
+
+		iounit_iommu_init(op);
+		of_propagate_archdata(op);
+	}
+
+	sun4d_init_sbi_irq();
+
+	return 0;
+}
+
+subsys_initcall(iounit_init);
+
 /* One has to hold iounit->lock to call this */
 static unsigned long iounit_get_area(struct iounit_struct *iounit, unsigned long vaddr, int size)
 {
diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index 2970cea..7c55450 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -55,33 +55,20 @@ static pgprot_t dvma_prot;		/* Consistent mapping pte flags */
 #define IOPERM        (IOPTE_CACHE | IOPTE_WRITE | IOPTE_VALID)
 #define MKIOPTE(pfn, perm) (((((pfn)<<8) & IOPTE_PAGE) | (perm)) & ~IOPTE_WAZ)
 
-void __init iommu_init(struct device_node *parent, struct sbus_bus *sbus)
+static void __init sbus_iommu_init(struct of_device *op)
 {
-	struct of_device *parent_op, *op;
 	struct iommu_struct *iommu;
 	unsigned int impl, vers;
 	unsigned long *bitmap;
 	unsigned long tmp;
 
-	parent_op = of_find_device_by_node(parent);
-	if (!parent_op) {
-		prom_printf("Unable to find IOMMU of_device\n");
-		prom_halt();
-	}
-
-	op = of_find_device_by_node(sbus->ofdev.node);
-	if (!op) {
-		prom_printf("Unable to find SBUS of_device\n");
-		prom_halt();
-	}
-
 	iommu = kmalloc(sizeof(struct iommu_struct), GFP_ATOMIC);
 	if (!iommu) {
 		prom_printf("Unable to allocate iommu structure\n");
 		prom_halt();
 	}
 
-	iommu->regs = of_ioremap(&parent_op->resource[0], 0, PAGE_SIZE * 3,
+	iommu->regs = of_ioremap(&op->resource[0], 0, PAGE_SIZE * 3,
 				 "iommu_regs");
 	if (!iommu->regs) {
 		prom_printf("Cannot map IOMMU registers\n");
@@ -132,14 +119,29 @@ void __init iommu_init(struct device_node *parent, struct sbus_bus *sbus)
 	else
 		iommu->usemap.num_colors = 1;
 
-	printk("IOMMU: impl %d vers %d table 0x%p[%d B] map [%d b]\n",
-	    impl, vers, iommu->page_table,
-	    (int)(IOMMU_NPTES*sizeof(iopte_t)), (int)IOMMU_NPTES);
+	printk(KERN_INFO "IOMMU: impl %d vers %d table 0x%p[%d B] map [%d b]\n",
+	       impl, vers, iommu->page_table,
+	       (int)(IOMMU_NPTES*sizeof(iopte_t)), (int)IOMMU_NPTES);
 
-	sbus->ofdev.dev.archdata.iommu = iommu;
 	op->dev.archdata.iommu = iommu;
 }
 
+static int __init iommu_init(void)
+{
+	struct device_node *dp;
+
+	for_each_node_by_name(dp, "iommu") {
+		struct of_device *op = of_find_device_by_node(dp);
+
+		sbus_iommu_init(op);
+		of_propagate_archdata(op);
+	}
+
+	return 0;
+}
+
+subsys_initcall(iommu_init);
+
 /* This begs to be btfixup-ed by srmmu. */
 /* Flush the iotlb entries to ram. */
 /* This could be better if we didn't have to flush whole pages. */
diff --git a/arch/sparc64/kernel/sbus.c b/arch/sparc64/kernel/sbus.c
index 0b3e7bc..60605ea 100644
--- a/arch/sparc64/kernel/sbus.c
+++ b/arch/sparc64/kernel/sbus.c
@@ -201,10 +201,9 @@ static unsigned long sysio_imap_to_iclr(unsigned long imap)
 	return imap + diff;
 }
 
-unsigned int sbus_build_irq(void *buscookie, unsigned int ino)
+static unsigned int sbus_build_irq(struct of_device *op, unsigned int ino)
 {
-	struct sbus_bus *sbus = (struct sbus_bus *)buscookie;
-	struct iommu *iommu = sbus->ofdev.dev.archdata.iommu;
+	struct iommu *iommu = op->dev.archdata.iommu;
 	unsigned long reg_base = iommu->write_complete_reg - 0x2000UL;
 	unsigned long imap, iclr;
 	int sbus_level = 0;
@@ -265,12 +264,12 @@ unsigned int sbus_build_irq(void *buscookie, unsigned int ino)
 #define  SYSIO_UEAFSR_RESV2 0x0000001fffffffffUL /* Reserved                  */
 static irqreturn_t sysio_ue_handler(int irq, void *dev_id)
 {
-	struct sbus_bus *sbus = dev_id;
-	struct iommu *iommu = sbus->ofdev.dev.archdata.iommu;
+	struct of_device *op = dev_id;
+	struct iommu *iommu = op->dev.archdata.iommu;
 	unsigned long reg_base = iommu->write_complete_reg - 0x2000UL;
 	unsigned long afsr_reg, afar_reg;
 	unsigned long afsr, afar, error_bits;
-	int reported;
+	int reported, portid;
 
 	afsr_reg = reg_base + SYSIO_UE_AFSR;
 	afar_reg = reg_base + SYSIO_UE_AFAR;
@@ -285,9 +284,11 @@ static irqreturn_t sysio_ue_handler(int irq, void *dev_id)
 		 SYSIO_UEAFSR_SPIO | SYSIO_UEAFSR_SDRD | SYSIO_UEAFSR_SDWR);
 	upa_writeq(error_bits, afsr_reg);
 
+	portid = of_getintprop_default(op->node, "portid", -1);
+
 	/* Log the error. */
 	printk("SYSIO[%x]: Uncorrectable ECC Error, primary error type[%s]\n",
-	       sbus->portid,
+	       portid,
 	       (((error_bits & SYSIO_UEAFSR_PPIO) ?
 		 "PIO" :
 		 ((error_bits & SYSIO_UEAFSR_PDRD) ?
@@ -295,12 +296,12 @@ static irqreturn_t sysio_ue_handler(int irq, void *dev_id)
 		  ((error_bits & SYSIO_UEAFSR_PDWR) ?
 		   "DVMA Write" : "???")))));
 	printk("SYSIO[%x]: DOFF[%lx] SIZE[%lx] MID[%lx]\n",
-	       sbus->portid,
+	       portid,
 	       (afsr & SYSIO_UEAFSR_DOFF) >> 45UL,
 	       (afsr & SYSIO_UEAFSR_SIZE) >> 42UL,
 	       (afsr & SYSIO_UEAFSR_MID) >> 37UL);
-	printk("SYSIO[%x]: AFAR[%016lx]\n", sbus->portid, afar);
-	printk("SYSIO[%x]: Secondary UE errors [", sbus->portid);
+	printk("SYSIO[%x]: AFAR[%016lx]\n", portid, afar);
+	printk("SYSIO[%x]: Secondary UE errors [", portid);
 	reported = 0;
 	if (afsr & SYSIO_UEAFSR_SPIO) {
 		reported++;
@@ -337,12 +338,12 @@ static irqreturn_t sysio_ue_handler(int irq, void *dev_id)
 #define  SYSIO_CEAFSR_RESV2 0x0000001fffffffffUL /* Reserved                  */
 static irqreturn_t sysio_ce_handler(int irq, void *dev_id)
 {
-	struct sbus_bus *sbus = dev_id;
-	struct iommu *iommu = sbus->ofdev.dev.archdata.iommu;
+	struct of_device *op = dev_id;
+	struct iommu *iommu = op->dev.archdata.iommu;
 	unsigned long reg_base = iommu->write_complete_reg - 0x2000UL;
 	unsigned long afsr_reg, afar_reg;
 	unsigned long afsr, afar, error_bits;
-	int reported;
+	int reported, portid;
 
 	afsr_reg = reg_base + SYSIO_CE_AFSR;
 	afar_reg = reg_base + SYSIO_CE_AFAR;
@@ -357,8 +358,10 @@ static irqreturn_t sysio_ce_handler(int irq, void *dev_id)
 		 SYSIO_CEAFSR_SPIO | SYSIO_CEAFSR_SDRD | SYSIO_CEAFSR_SDWR);
 	upa_writeq(error_bits, afsr_reg);
 
+	portid = of_getintprop_default(op->node, "portid", -1);
+
 	printk("SYSIO[%x]: Correctable ECC Error, primary error type[%s]\n",
-	       sbus->portid,
+	       portid,
 	       (((error_bits & SYSIO_CEAFSR_PPIO) ?
 		 "PIO" :
 		 ((error_bits & SYSIO_CEAFSR_PDRD) ?
@@ -370,14 +373,14 @@ static irqreturn_t sysio_ce_handler(int irq, void *dev_id)
 	 * XXX UDB CE trap handler does... -DaveM
 	 */
 	printk("SYSIO[%x]: DOFF[%lx] ECC Syndrome[%lx] Size[%lx] MID[%lx]\n",
-	       sbus->portid,
+	       portid,
 	       (afsr & SYSIO_CEAFSR_DOFF) >> 45UL,
 	       (afsr & SYSIO_CEAFSR_ESYND) >> 48UL,
 	       (afsr & SYSIO_CEAFSR_SIZE) >> 42UL,
 	       (afsr & SYSIO_CEAFSR_MID) >> 37UL);
-	printk("SYSIO[%x]: AFAR[%016lx]\n", sbus->portid, afar);
+	printk("SYSIO[%x]: AFAR[%016lx]\n", portid, afar);
 
-	printk("SYSIO[%x]: Secondary CE errors [", sbus->portid);
+	printk("SYSIO[%x]: Secondary CE errors [", portid);
 	reported = 0;
 	if (afsr & SYSIO_CEAFSR_SPIO) {
 		reported++;
@@ -414,11 +417,11 @@ static irqreturn_t sysio_ce_handler(int irq, void *dev_id)
 #define  SYSIO_SBAFSR_RESV3 0x0000001fffffffffUL /* Reserved                  */
 static irqreturn_t sysio_sbus_error_handler(int irq, void *dev_id)
 {
-	struct sbus_bus *sbus = dev_id;
-	struct iommu *iommu = sbus->ofdev.dev.archdata.iommu;
+	struct of_device *op = dev_id;
+	struct iommu *iommu = op->dev.archdata.iommu;
 	unsigned long afsr_reg, afar_reg, reg_base;
 	unsigned long afsr, afar, error_bits;
-	int reported;
+	int reported, portid;
 
 	reg_base = iommu->write_complete_reg - 0x2000UL;
 	afsr_reg = reg_base + SYSIO_SBUS_AFSR;
@@ -433,9 +436,11 @@ static irqreturn_t sysio_sbus_error_handler(int irq, void *dev_id)
 		 SYSIO_SBAFSR_SLE | SYSIO_SBAFSR_STO | SYSIO_SBAFSR_SBERR);
 	upa_writeq(error_bits, afsr_reg);
 
+	portid = of_getintprop_default(op->node, "portid", -1);
+
 	/* Log the error. */
 	printk("SYSIO[%x]: SBUS Error, primary error type[%s] read(%d)\n",
-	       sbus->portid,
+	       portid,
 	       (((error_bits & SYSIO_SBAFSR_PLE) ?
 		 "Late PIO Error" :
 		 ((error_bits & SYSIO_SBAFSR_PTO) ?
@@ -444,11 +449,11 @@ static irqreturn_t sysio_sbus_error_handler(int irq, void *dev_id)
 		   "Error Ack" : "???")))),
 	       (afsr & SYSIO_SBAFSR_RD) ? 1 : 0);
 	printk("SYSIO[%x]: size[%lx] MID[%lx]\n",
-	       sbus->portid,
+	       portid,
 	       (afsr & SYSIO_SBAFSR_SIZE) >> 42UL,
 	       (afsr & SYSIO_SBAFSR_MID) >> 37UL);
-	printk("SYSIO[%x]: AFAR[%016lx]\n", sbus->portid, afar);
-	printk("SYSIO[%x]: Secondary SBUS errors [", sbus->portid);
+	printk("SYSIO[%x]: AFAR[%016lx]\n", portid, afar);
+	printk("SYSIO[%x]: Secondary SBUS errors [", portid);
 	reported = 0;
 	if (afsr & SYSIO_SBAFSR_SLE) {
 		reported++;
@@ -480,34 +485,37 @@ static irqreturn_t sysio_sbus_error_handler(int irq, void *dev_id)
 #define SYSIO_CE_INO		0x35
 #define SYSIO_SBUSERR_INO	0x36
 
-static void __init sysio_register_error_handlers(struct sbus_bus *sbus)
+static void __init sysio_register_error_handlers(struct of_device *op)
 {
-	struct iommu *iommu = sbus->ofdev.dev.archdata.iommu;
+	struct iommu *iommu = op->dev.archdata.iommu;
 	unsigned long reg_base = iommu->write_complete_reg - 0x2000UL;
 	unsigned int irq;
 	u64 control;
+	int portid;
+
+	portid = of_getintprop_default(op->node, "portid", -1);
 
-	irq = sbus_build_irq(sbus, SYSIO_UE_INO);
+	irq = sbus_build_irq(op, SYSIO_UE_INO);
 	if (request_irq(irq, sysio_ue_handler, 0,
-			"SYSIO_UE", sbus) < 0) {
+			"SYSIO_UE", op) < 0) {
 		prom_printf("SYSIO[%x]: Cannot register UE interrupt.\n",
-			    sbus->portid);
+			    portid);
 		prom_halt();
 	}
 
-	irq = sbus_build_irq(sbus, SYSIO_CE_INO);
+	irq = sbus_build_irq(op, SYSIO_CE_INO);
 	if (request_irq(irq, sysio_ce_handler, 0,
-			"SYSIO_CE", sbus) < 0) {
+			"SYSIO_CE", op) < 0) {
 		prom_printf("SYSIO[%x]: Cannot register CE interrupt.\n",
-			    sbus->portid);
+			    portid);
 		prom_halt();
 	}
 
-	irq = sbus_build_irq(sbus, SYSIO_SBUSERR_INO);
+	irq = sbus_build_irq(op, SYSIO_SBUSERR_INO);
 	if (request_irq(irq, sysio_sbus_error_handler, 0,
-			"SYSIO_SBERR", sbus) < 0) {
+			"SYSIO_SBERR", op) < 0) {
 		prom_printf("SYSIO[%x]: Cannot register SBUS Error interrupt.\n",
-			    sbus->portid);
+			    portid);
 		prom_halt();
 	}
 
@@ -523,19 +531,15 @@ static void __init sysio_register_error_handlers(struct sbus_bus *sbus)
 }
 
 /* Boot time initialization. */
-static void __init sbus_iommu_init(int __node, struct sbus_bus *sbus)
+static void __init sbus_iommu_init(struct of_device *op)
 {
 	const struct linux_prom64_registers *pr;
-	struct device_node *dp;
+	struct device_node *dp = op->node;
 	struct iommu *iommu;
 	struct strbuf *strbuf;
 	unsigned long regs, reg_base;
+	int i, portid;
 	u64 control;
-	int i;
-
-	dp = of_find_node_by_phandle(__node);
-
-	sbus->portid = of_getintprop_default(dp, "upa-portid", -1);
 
 	pr = of_get_property(dp, "reg", NULL);
 	if (!pr) {
@@ -552,9 +556,9 @@ static void __init sbus_iommu_init(int __node, struct sbus_bus *sbus)
 	if (!strbuf)
 		goto fatal_memory_error;
 
-	sbus->ofdev.dev.archdata.iommu = iommu;
-	sbus->ofdev.dev.archdata.stc = strbuf;
-	sbus->ofdev.dev.archdata.numa_node = -1;
+	op->dev.archdata.iommu = iommu;
+	op->dev.archdata.stc = strbuf;
+	op->dev.archdata.numa_node = -1;
 
 	reg_base = regs + SYSIO_IOMMUREG_BASE;
 	iommu->iommu_control = reg_base + IOMMU_CONTROL;
@@ -582,8 +586,9 @@ static void __init sbus_iommu_init(int __node, struct sbus_bus *sbus)
 	 */
 	iommu->write_complete_reg = regs + 0x2000UL;
 
-	printk("SYSIO: UPA portID %x, at %016lx\n",
-	       sbus->portid, regs);
+	portid = of_getintprop_default(op->node, "portid", -1);
+	printk(KERN_INFO "SYSIO: UPA portID %x, at %016lx\n",
+	       portid, regs);
 
 	/* Setup for TSB_SIZE=7, TBW_SIZE=0, MMU_DE=1, MMU_EN=1 */
 	if (iommu_table_init(iommu, IO_TSB_SIZE, MAP_BASE, 0xffffffff, -1))
@@ -641,23 +646,30 @@ static void __init sbus_iommu_init(int __node, struct sbus_bus *sbus)
 
 	/* Now some Xfire specific grot... */
 	if (this_is_starfire)
-		starfire_hookup(sbus->portid);
+		starfire_hookup(portid);
 
-	sysio_register_error_handlers(sbus);
+	sysio_register_error_handlers(op);
 	return;
 
 fatal_memory_error:
 	prom_printf("sbus_iommu_init: Fatal memory allocation error.\n");
 }
 
-void __init sbus_setup_iommu(struct sbus_bus *sbus, struct device_node *dp)
-{
-	sbus_iommu_init(dp->node, sbus);
-}
-
-void __init sbus_arch_postinit(void)
+static int __init sbus_init(void)
 {
 	extern void firetruck_init(void);
+	struct device_node *dp;
+
+	for_each_node_by_name(dp, "sbus") {
+		struct of_device *op = of_find_device_by_node(dp);
+
+		sbus_iommu_init(op);
+		of_propagate_archdata(op);
+	}
 
 	firetruck_init();
+
+	return 0;
 }
+
+subsys_initcall(sbus_init);
diff --git a/drivers/sbus/Makefile b/drivers/sbus/Makefile
index 56f7331..e94dc25 100644
--- a/drivers/sbus/Makefile
+++ b/drivers/sbus/Makefile
@@ -2,8 +2,4 @@
 # Makefile for the linux kernel.
 #
 
-ifneq ($(ARCH),m68k)
-obj-y    := sbus.o
-endif
-
 obj-$(CONFIG_SBUSCHAR) += char/
diff --git a/drivers/sbus/sbus.c b/drivers/sbus/sbus.c
deleted file mode 100644
index 399567b..0000000
--- a/drivers/sbus/sbus.c
+++ /dev/null
@@ -1,170 +0,0 @@
-/* sbus.c: SBus support routines.
- *
- * Copyright (C) 1995, 2006 David S. Miller (davem@davemloft.net)
- */
-
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/init.h>
-#include <linux/device.h>
-#include <linux/of_device.h>
-
-#include <asm/system.h>
-#include <asm/sbus.h>
-#include <asm/dma.h>
-#include <asm/oplib.h>
-#include <asm/prom.h>
-#include <asm/irq.h>
-
-static ssize_t
-show_sbusobppath_attr(struct device * dev, struct device_attribute * attr, char * buf)
-{
-	struct sbus_dev *sbus;
-
-	sbus = to_sbus_device(dev);
-
-	return snprintf (buf, PAGE_SIZE, "%s\n", sbus->ofdev.node->full_name);
-}
-
-static DEVICE_ATTR(obppath, S_IRUSR | S_IRGRP | S_IROTH, show_sbusobppath_attr, NULL);
-
-static void __init fill_sbus_device_iommu(struct sbus_dev *sdev)
-{
-	struct of_device *op = of_find_device_by_node(sdev->ofdev.node);
-	struct dev_archdata *sd, *bus_sd;
-	struct sbus_bus *sbus;
-
-	sbus = sdev->bus;
-	bus_sd = &sbus->ofdev.dev.archdata;
-
-	sd = &sdev->ofdev.dev.archdata;
-	sd->iommu = bus_sd->iommu;
-	sd->stc = bus_sd->stc;
-
-	sd = &op->dev.archdata;
-	sd->iommu = bus_sd->iommu;
-	sd->stc = bus_sd->stc;
-}
-
-static void __init fill_sbus_device(struct device_node *dp, struct sbus_dev *sdev)
-{
-	struct dev_archdata *sd;
-	int err;
-
-	sd = &sdev->ofdev.dev.archdata;
-	sd->prom_node = dp;
-	sd->op = &sdev->ofdev;
-
-	sdev->ofdev.node = dp;
-	if (sdev->parent)
-		sdev->ofdev.dev.parent = &sdev->parent->ofdev.dev;
-	else
-		sdev->ofdev.dev.parent = &sdev->bus->ofdev.dev;
-	sdev->ofdev.dev.bus = &sbus_bus_type;
-	dev_set_name(&sdev->ofdev.dev, "sbus[%08x]", dp->node);
-
-	if (of_device_register(&sdev->ofdev) != 0)
-		printk(KERN_DEBUG "sbus: device registration error for %s!\n",
-		       dp->path_component_name);
-
-	/* WE HAVE BEEN INVADED BY ALIENS! */
-	err = sysfs_create_file(&sdev->ofdev.dev.kobj, &dev_attr_obppath.attr);
-
-	fill_sbus_device_iommu(sdev);
-}
-
-static void __init sdev_insert(struct sbus_dev *sdev, struct sbus_dev **root)
-{
-	while (*root)
-		root = &(*root)->next;
-	*root = sdev;
-	sdev->next = NULL;
-}
-
-static void __init walk_children(struct device_node *dp, struct sbus_dev *parent, struct sbus_bus *sbus)
-{
-	dp = dp->child;
-	while (dp) {
-		struct sbus_dev *sdev;
-
-		sdev = kzalloc(sizeof(struct sbus_dev), GFP_ATOMIC);
-		if (sdev) {
-			sdev_insert(sdev, &parent->child);
-
-			sdev->bus = sbus;
-			sdev->parent = parent;
-
-			fill_sbus_device(dp, sdev);
-
-			walk_children(dp, sdev, sbus);
-		}
-		dp = dp->sibling;
-	}
-}
-
-static void __init build_one_sbus(struct device_node *dp, int num_sbus)
-{
-	struct device_node *dev_dp;
-	struct sbus_bus *sbus;
-
-	sbus = kzalloc(sizeof(struct sbus_bus), GFP_ATOMIC);
-	if (!sbus)
-		return;
-
-	sbus_setup_iommu(sbus, dp);
-
-	printk("sbus%d: ", num_sbus);
-
-	sbus->ofdev.node = dp;
-	sbus->ofdev.dev.parent = NULL;
-	sbus->ofdev.dev.bus = &sbus_bus_type;
-	dev_set_name(&sbus->ofdev.dev, "sbus%d", num_sbus);
-
-	if (of_device_register(&sbus->ofdev) != 0)
-		printk(KERN_DEBUG "sbus: device registration error for %s!\n",
-		       dev_name(&sbus->ofdev.dev));
-
-	dev_dp = dp->child;
-	while (dev_dp) {
-		struct sbus_dev *sdev;
-
-		sdev = kzalloc(sizeof(struct sbus_dev), GFP_ATOMIC);
-		if (sdev) {
-			sdev_insert(sdev, &sbus->devices);
-
-			sdev->bus = sbus;
-			sdev->parent = NULL;
-			sdev->ofdev.dev.archdata.iommu -				sbus->ofdev.dev.archdata.iommu;
-			sdev->ofdev.dev.archdata.stc -				sbus->ofdev.dev.archdata.stc;
-
-			fill_sbus_device(dev_dp, sdev);
-
-			walk_children(dev_dp, sdev, sbus);
-		}
-		dev_dp = dev_dp->sibling;
-	}
-}
-
-static int __init sbus_init(void)
-{
-	struct device_node *dp;
-	const char *sbus_name = "sbus";
-	int num_sbus = 0;
-
-	if (sparc_cpu_model = sun4d)
-		sbus_name = "sbi";
-
-	for_each_node_by_name(dp, sbus_name) {
-		build_one_sbus(dp, num_sbus);
-		num_sbus++;
-
-	}
-
-	sbus_arch_postinit();
-
-	return 0;
-}
-
-subsys_initcall(sbus_init);
-- 
1.5.6.5.GIT

