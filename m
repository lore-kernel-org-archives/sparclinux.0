From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:23:43 +0000
Subject: [PATCH 10/49]: sparc: Move SBUS DMA attribute interfaces out of
Message-Id: <20080827.212343.175837671.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc: Move SBUS DMA attribute interfaces out of asm/sbus.h

This is in preparation for the subsequent asm/sbus.h removal.

Also, make these routines take a "struct device" or no
arguments, as appropriate.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/io_32.h   |   11 +++++++++++
 arch/sparc/include/asm/io_64.h   |   11 +++++++++++
 arch/sparc/include/asm/sbus_32.h |    4 ----
 arch/sparc/include/asm/sbus_64.h |    4 ----
 arch/sparc/kernel/ioport.c       |    2 +-
 arch/sparc64/kernel/sbus.c       |   16 +++++++++++++---
 drivers/atm/fore200e.c           |    4 ++--
 drivers/net/myri_sbus.c          |    2 +-
 drivers/net/sunhme.c             |   14 ++++++++------
 drivers/net/sunqe.c              |    2 +-
 drivers/scsi/qlogicpti.c         |    2 +-
 drivers/scsi/sun_esp.c           |    8 +++++---
 12 files changed, 54 insertions(+), 26 deletions(-)

diff --git a/arch/sparc/include/asm/io_32.h b/arch/sparc/include/asm/io_32.h
index 10d7da4..3ab3164 100644
--- a/arch/sparc/include/asm/io_32.h
+++ b/arch/sparc/include/asm/io_32.h
@@ -308,6 +308,17 @@ extern void sbus_iounmap(volatile void __iomem *vaddr, unsigned long size);
 #define RTC_PORT(x)   (rtc_port + (x))
 #define RTC_ALWAYS_BCD  0
 
+static inline int sbus_can_dma_64bit(void)
+{
+	return 0; /* actually, sparc_cpu_model=sun4d */
+}
+static inline int sbus_can_burst64(void)
+{
+	return 0; /* actually, sparc_cpu_model=sun4d */
+}
+struct device;
+extern void sbus_set_sbus64(struct device *, int);
+
 #endif
 
 #define __ARCH_HAS_NO_PAGE_ZERO_MAPPED		1
diff --git a/arch/sparc/include/asm/io_64.h b/arch/sparc/include/asm/io_64.h
index 0bff078..73a9c5d 100644
--- a/arch/sparc/include/asm/io_64.h
+++ b/arch/sparc/include/asm/io_64.h
@@ -495,6 +495,17 @@ extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
 #define sbus_iounmap(__addr, __size)	\
 	release_region((unsigned long)(__addr), (__size))
 
+static inline int sbus_can_dma_64bit(void)
+{
+	return 1;
+}
+static inline int sbus_can_burst64(void)
+{
+	return 1;
+}
+struct device;
+extern void sbus_set_sbus64(struct device *, int);
+
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
  * access
diff --git a/arch/sparc/include/asm/sbus_32.h b/arch/sparc/include/asm/sbus_32.h
index b09284b..435ae39 100644
--- a/arch/sparc/include/asm/sbus_32.h
+++ b/arch/sparc/include/asm/sbus_32.h
@@ -102,10 +102,6 @@ sbus_is_slave(struct sbus_dev *dev)
 	for ((bus) = sbus_root; (bus); (bus) = (bus)->next) \
 		for ((device) = (bus)->devices; (device); (device) = (device)->next)
 
-/* Driver DVMA interfaces. */
-#define sbus_can_dma_64bit(sdev)	(0) /* actually, sparc_cpu_model=sun4d */
-#define sbus_can_burst64(sdev)		(0) /* actually, sparc_cpu_model=sun4d */
-extern void sbus_set_sbus64(struct sbus_dev *, int);
 extern void sbus_fill_device_irq(struct sbus_dev *);
 
 /* These yield IOMMU mappings in consistent mode. */
diff --git a/arch/sparc/include/asm/sbus_64.h b/arch/sparc/include/asm/sbus_64.h
index 9a2f271..79719c2 100644
--- a/arch/sparc/include/asm/sbus_64.h
+++ b/arch/sparc/include/asm/sbus_64.h
@@ -94,10 +94,6 @@ extern struct sbus_bus *sbus_root;
 	for ((bus) = sbus_root; (bus); (bus) = (bus)->next) \
 		for ((device) = (bus)->devices; (device); (device) = (device)->next)
 
-/* Driver DVMA interfaces. */
-#define sbus_can_dma_64bit(sdev)	(1)
-#define sbus_can_burst64(sdev)		(1)
-extern void sbus_set_sbus64(struct sbus_dev *, int);
 extern void sbus_fill_device_irq(struct sbus_dev *);
 
 extern void sbus_arch_bus_ranges_init(struct device_node *, struct sbus_bus *);
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 0b30359..e87ed51 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -250,7 +250,7 @@ static void _sparc_free_io(struct resource *res)
 
 #ifdef CONFIG_SBUS
 
-void sbus_set_sbus64(struct sbus_dev *sdev, int x)
+void sbus_set_sbus64(struct device *dev, int x)
 {
 	printk("sbus_set_sbus64: unsupported\n");
 }
diff --git a/arch/sparc64/kernel/sbus.c b/arch/sparc64/kernel/sbus.c
index e33a8a6..aa47022 100644
--- a/arch/sparc64/kernel/sbus.c
+++ b/arch/sparc64/kernel/sbus.c
@@ -52,13 +52,23 @@
 #define STRBUF_TAG_VALID	0x02UL
 
 /* Enable 64-bit DVMA mode for the given device. */
-void sbus_set_sbus64(struct sbus_dev *sdev, int bursts)
+void sbus_set_sbus64(struct device *dev, int bursts)
 {
-	struct iommu *iommu = sdev->ofdev.dev.archdata.iommu;
-	int slot = sdev->slot;
+	struct iommu *iommu = dev->archdata.iommu;
+	struct of_device *op = to_of_device(dev);
+	const struct linux_prom_registers *regs;
 	unsigned long cfg_reg;
+	int slot;
 	u64 val;
 
+	regs = of_get_property(op->node, "reg", NULL);
+	if (!regs) {
+		printk(KERN_ERR "sbus_set_sbus64: Cannot find regs for %s\n",
+		       op->node->full_name);
+		return;
+	}
+	slot = regs->which_io;
+
 	cfg_reg = iommu->write_complete_reg;
 	switch (slot) {
 	case 0:
diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
index f607e59..7213590 100644
--- a/drivers/atm/fore200e.c
+++ b/drivers/atm/fore200e.c
@@ -819,8 +819,8 @@ fore200e_sba_map(struct fore200e* fore200e)
     /* get the supported DVMA burst sizes */
     bursts = prom_getintdefault(sbus_dev->bus->prom_node, "burst-sizes", 0x00);
 
-    if (sbus_can_dma_64bit(sbus_dev))
-	sbus_set_sbus64(sbus_dev, bursts);
+    if (sbus_can_dma_64bit())
+	sbus_set_sbus64(&sbus_dev->ofdev.dev, bursts);
 
     fore200e->state = FORE200E_STATE_MAP;
     return 0;
diff --git a/drivers/net/myri_sbus.c b/drivers/net/myri_sbus.c
index 858880b..f2a3ff2 100644
--- a/drivers/net/myri_sbus.c
+++ b/drivers/net/myri_sbus.c
@@ -1050,7 +1050,7 @@ static int __devinit myri_ether_init(struct sbus_dev *sdev)
 	mp->myri_bursts = prom_getintdefault(mp->myri_sdev->bus->prom_node,
 					     "burst-sizes", 0x00);
 
-	if (!sbus_can_burst64(sdev))
+	if (!sbus_can_burst64())
 		mp->myri_bursts &= ~(DMA_BURST64);
 
 	DET(("MYRI bursts %02x\n", mp->myri_bursts));
diff --git a/drivers/net/sunhme.c b/drivers/net/sunhme.c
index 69cc771..d15da94 100644
--- a/drivers/net/sunhme.c
+++ b/drivers/net/sunhme.c
@@ -1575,7 +1575,7 @@ static int happy_meal_init(struct happy_meal *hp)
 	if ((hp->happy_bursts & DMA_BURST64) &&
 	    ((hp->happy_flags & HFLAG_PCI) != 0
 #ifdef CONFIG_SBUS
-	     || sbus_can_burst64(hp->happy_dev)
+	     || sbus_can_burst64()
 #endif
 	     || 0)) {
 		u32 gcfg = GREG_CFG_BURST64;
@@ -1585,11 +1585,13 @@ static int happy_meal_init(struct happy_meal *hp)
 		 * do not.  -DaveM
 		 */
 #ifdef CONFIG_SBUS
-		if ((hp->happy_flags & HFLAG_PCI) = 0 &&
-		    sbus_can_dma_64bit(hp->happy_dev)) {
-			sbus_set_sbus64(hp->happy_dev,
-					hp->happy_bursts);
-			gcfg |= GREG_CFG_64BIT;
+		if ((hp->happy_flags & HFLAG_PCI) = 0) {
+			struct sbus_dev *sdev = hp->happy_dev;
+			if (sbus_can_dma_64bit()) {
+				sbus_set_sbus64(&sdev->ofdev.dev,
+						hp->happy_bursts);
+				gcfg |= GREG_CFG_64BIT;
+			}
 		}
 #endif
 
diff --git a/drivers/net/sunqe.c b/drivers/net/sunqe.c
index 66f66ee..4521972 100644
--- a/drivers/net/sunqe.c
+++ b/drivers/net/sunqe.c
@@ -722,7 +722,7 @@ static inline void qec_init_once(struct sunqec *qecp, struct sbus_dev *qsdev)
 {
 	u8 bsizes = qecp->qec_bursts;
 
-	if (sbus_can_burst64(qsdev) && (bsizes & DMA_BURST64)) {
+	if (sbus_can_burst64() && (bsizes & DMA_BURST64)) {
 		sbus_writel(GLOB_CTRL_B64, qecp->gregs + GLOB_CTRL);
 	} else if (bsizes & DMA_BURST32) {
 		sbus_writel(GLOB_CTRL_B32, qecp->gregs + GLOB_CTRL);
diff --git a/drivers/scsi/qlogicpti.c b/drivers/scsi/qlogicpti.c
index 1559d45..e16c56c 100644
--- a/drivers/scsi/qlogicpti.c
+++ b/drivers/scsi/qlogicpti.c
@@ -158,7 +158,7 @@ static inline void set_sbus_cfg1(struct qlogicpti *qpti)
 	 * is a nop and the chip ends up using the smallest burst
 	 * size. -DaveM
 	 */
-	if (sbus_can_burst64(qpti->sdev) && (bursts & DMA_BURST64)) {
+	if (sbus_can_burst64() && (bursts & DMA_BURST64)) {
 		val = (SBUS_CFG1_BENAB | SBUS_CFG1_B64);
 	} else
 #endif
diff --git a/drivers/scsi/sun_esp.c b/drivers/scsi/sun_esp.c
index f750874..ea0c572 100644
--- a/drivers/scsi/sun_esp.c
+++ b/drivers/scsi/sun_esp.c
@@ -265,15 +265,17 @@ static void sbus_esp_reset_dma(struct esp *esp)
 {
 	int can_do_burst16, can_do_burst32, can_do_burst64;
 	int can_do_sbus64, lim;
+	struct sbus_dev *sdev;
 	u32 val;
 
 	can_do_burst16 = (esp->bursts & DMA_BURST16) != 0;
 	can_do_burst32 = (esp->bursts & DMA_BURST32) != 0;
 	can_do_burst64 = 0;
 	can_do_sbus64 = 0;
-	if (sbus_can_dma_64bit(esp->dev))
+	sdev = esp->dev;
+	if (sbus_can_dma_64bit())
 		can_do_sbus64 = 1;
-	if (sbus_can_burst64(esp->sdev))
+	if (sbus_can_burst64())
 		can_do_burst64 = (esp->bursts & DMA_BURST64) != 0;
 
 	/* Put the DVMA into a known state. */
@@ -300,7 +302,7 @@ static void sbus_esp_reset_dma(struct esp *esp)
 
 		if (can_do_sbus64) {
 			esp->prev_hme_dmacsr |= DMA_SCSI_SBUS64;
-			sbus_set_sbus64(esp->dev, esp->bursts);
+			sbus_set_sbus64(&sdev->ofdev.dev, esp->bursts);
 		}
 
 		lim = 1000;
-- 
1.5.6.5.GIT

