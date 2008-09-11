From: David Miller <davem@davemloft.net>
Date: Thu, 11 Sep 2008 06:14:31 +0000
Subject: [PATCH 1/3]: sparc64: Start commonizing code common between SABRE
Message-Id: <20080910.231431.207347609.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc64: Start commonizing code common between SABRE and PSYCHO.

These are very similar chips, in fact they are identical in some
macro blocks.

So start commonizing code which they can share.  We begin with
the IOMMU initialization sequence.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc64/kernel/Makefile        |    2 +-
 arch/sparc64/kernel/pci_psycho.c    |   65 +++----------------------
 arch/sparc64/kernel/pci_sabre.c     |   63 +-----------------------
 arch/sparc64/kernel/psycho_common.c |   93 +++++++++++++++++++++++++++++++++++
 arch/sparc64/kernel/psycho_common.h |    8 +++
 5 files changed, 111 insertions(+), 120 deletions(-)
 create mode 100644 arch/sparc64/kernel/psycho_common.c
 create mode 100644 arch/sparc64/kernel/psycho_common.h

diff --git a/arch/sparc64/kernel/Makefile b/arch/sparc64/kernel/Makefile
index fb02807..c0b8009 100644
--- a/arch/sparc64/kernel/Makefile
+++ b/arch/sparc64/kernel/Makefile
@@ -16,7 +16,7 @@ obj-y		:= process.o setup.o cpu.o idprom.o reboot.o \
 
 obj-$(CONFIG_DYNAMIC_FTRACE) += ftrace.o
 obj-$(CONFIG_STACKTRACE) += stacktrace.o
-obj-$(CONFIG_PCI)	 += pci.o pci_common.o \
+obj-$(CONFIG_PCI)	 += pci.o pci_common.o psycho_common.o \
 			    pci_psycho.o pci_sabre.o pci_schizo.o \
 			    pci_sun4v.o pci_sun4v_asm.o pci_fire.o
 obj-$(CONFIG_PCI_MSI)	+= pci_msi.o
diff --git a/arch/sparc64/kernel/pci_psycho.c b/arch/sparc64/kernel/pci_psycho.c
index 4562b3e..4681e3d 100644
--- a/arch/sparc64/kernel/pci_psycho.c
+++ b/arch/sparc64/kernel/pci_psycho.c
@@ -20,6 +20,7 @@
 
 #include "pci_impl.h"
 #include "iommu_common.h"
+#include "psycho_common.h"
 
 #define DRIVER_NAME	"psycho"
 #define PFX		DRIVER_NAME ": "
@@ -787,63 +788,6 @@ static void __init psycho_scan_bus(struct pci_pbm_info *pbm,
 	psycho_register_error_handlers(pbm);
 }
 
-static int psycho_iommu_init(struct pci_pbm_info *pbm)
-{
-	struct iommu *iommu = pbm->iommu;
-	unsigned long i;
-	u64 control;
-	int err;
-
-	/* Register addresses. */
-	iommu->iommu_control  = pbm->controller_regs + PSYCHO_IOMMU_CONTROL;
-	iommu->iommu_tsbbase  = pbm->controller_regs + PSYCHO_IOMMU_TSBBASE;
-	iommu->iommu_flush    = pbm->controller_regs + PSYCHO_IOMMU_FLUSH;
-	iommu->iommu_tags     = iommu->iommu_flush + (0xa580UL - 0x0210UL);
-
-	/* PSYCHO's IOMMU lacks ctx flushing. */
-	iommu->iommu_ctxflush = 0;
-
-	/* We use the main control register of PSYCHO as the write
-	 * completion register.
-	 */
-	iommu->write_complete_reg = pbm->controller_regs + PSYCHO_CONTROL;
-
-	/*
-	 * Invalidate TLB Entries.
-	 */
-	control = psycho_read(pbm->controller_regs + PSYCHO_IOMMU_CONTROL);
-	control |= PSYCHO_IOMMU_CTRL_DENAB;
-	psycho_write(pbm->controller_regs + PSYCHO_IOMMU_CONTROL, control);
-	for (i = 0; i < 16; i++) {
-		psycho_write(pbm->controller_regs + PSYCHO_IOMMU_TAG + (i * 8UL), 0);
-		psycho_write(pbm->controller_regs + PSYCHO_IOMMU_DATA + (i * 8UL), 0);
-	}
-
-	/* Leave diag mode enabled for full-flushing done
-	 * in pci_iommu.c
-	 */
-	err = iommu_table_init(iommu, IO_TSB_SIZE, 0xc0000000, 0xffffffff,
-			       pbm->numa_node);
-	if (err) {
-		printk(KERN_ERR PFX "iommu_table_init() fails\n");
-		return err;
-	}
-
-	psycho_write(pbm->controller_regs + PSYCHO_IOMMU_TSBBASE,
-		     __pa(iommu->page_table));
-
-	control = psycho_read(pbm->controller_regs + PSYCHO_IOMMU_CONTROL);
-	control &= ~(PSYCHO_IOMMU_CTRL_TSBSZ | PSYCHO_IOMMU_CTRL_TBWSZ);
-	control |= (PSYCHO_IOMMU_TSBSZ_128K | PSYCHO_IOMMU_CTRL_ENAB);
-	psycho_write(pbm->controller_regs + PSYCHO_IOMMU_CONTROL, control);
-
-	/* If necessary, hook us up for starfire IRQ translations. */
-	if (this_is_starfire)
-		starfire_hookup(pbm->portid);
-
-	return 0;
-}
-
 #define PSYCHO_IRQ_RETRY	0x1a00UL
 #define PSYCHO_PCIA_DIAG	0x2020UL
 #define PSYCHO_PCIB_DIAG	0x4020UL
@@ -1053,9 +997,14 @@ static int __devinit psycho_probe(struct of_device *op,
 
 	psycho_controller_hwinit(pbm);
 	if (!pbm->sibling) {
-		err = psycho_iommu_init(pbm);
+		err = psycho_iommu_init(pbm, 128, 0xc0000000,
+					0xffffffff, PSYCHO_CONTROL);
 		if (err)
 			goto out_free_iommu;
+
+		/* If necessary, hook us up for starfire IRQ translations. */
+		if (this_is_starfire)
+			starfire_hookup(pbm->portid);
 	}
 
 	psycho_pbm_init(pbm, op, is_pbm_a);
diff --git a/arch/sparc64/kernel/pci_sabre.c b/arch/sparc64/kernel/pci_sabre.c
index 196049b..a3a276d 100644
--- a/arch/sparc64/kernel/pci_sabre.c
+++ b/arch/sparc64/kernel/pci_sabre.c
@@ -20,6 +20,7 @@
 
 #include "pci_impl.h"
 #include "iommu_common.h"
+#include "psycho_common.h"
 
 #define DRIVER_NAME	"sabre"
 #define PFX		DRIVER_NAME ": "
@@ -674,66 +675,6 @@ static void __init sabre_scan_bus(struct pci_pbm_info *pbm,
 	sabre_register_error_handlers(pbm);
 }
 
-static int sabre_iommu_init(struct pci_pbm_info *pbm,
-			    int tsbsize, unsigned long dvma_offset,
-			    u32 dma_mask)
-{
-	struct iommu *iommu = pbm->iommu;
-	unsigned long i;
-	u64 control;
-	int err;
-
-	/* Register addresses. */
-	iommu->iommu_control  = pbm->controller_regs + SABRE_IOMMU_CONTROL;
-	iommu->iommu_tsbbase  = pbm->controller_regs + SABRE_IOMMU_TSBBASE;
-	iommu->iommu_flush    = pbm->controller_regs + SABRE_IOMMU_FLUSH;
-	iommu->iommu_tags     = iommu->iommu_flush + (0xa580UL - 0x0210UL);
-	iommu->write_complete_reg = pbm->controller_regs + SABRE_WRSYNC;
-	/* Sabre's IOMMU lacks ctx flushing. */
-	iommu->iommu_ctxflush = 0;
-                                        
-	/* Invalidate TLB Entries. */
-	control = sabre_read(pbm->controller_regs + SABRE_IOMMU_CONTROL);
-	control |= SABRE_IOMMUCTRL_DENAB;
-	sabre_write(pbm->controller_regs + SABRE_IOMMU_CONTROL, control);
-
-	for(i = 0; i < 16; i++) {
-		sabre_write(pbm->controller_regs + SABRE_IOMMU_TAG + (i * 8UL), 0);
-		sabre_write(pbm->controller_regs + SABRE_IOMMU_DATA + (i * 8UL), 0);
-	}
-
-	/* Leave diag mode enabled for full-flushing done
-	 * in pci_iommu.c
-	 */
-	err = iommu_table_init(iommu, tsbsize * 1024 * 8,
-			       dvma_offset, dma_mask, pbm->numa_node);
-	if (err) {
-		printk(KERN_ERR PFX "iommu_table_init() failed\n");
-		return err;
-	}
-
-	sabre_write(pbm->controller_regs + SABRE_IOMMU_TSBBASE,
-		    __pa(iommu->page_table));
-
-	control = sabre_read(pbm->controller_regs + SABRE_IOMMU_CONTROL);
-	control &= ~(SABRE_IOMMUCTRL_TSBSZ | SABRE_IOMMUCTRL_TBWSZ);
-	control |= SABRE_IOMMUCTRL_ENAB;
-	switch(tsbsize) {
-	case 64:
-		control |= SABRE_IOMMU_TSBSZ_64K;
-		break;
-	case 128:
-		control |= SABRE_IOMMU_TSBSZ_128K;
-		break;
-	default:
-		printk(KERN_ERR PFX "Illegal TSB size %d\n", tsbsize);
-		return -EINVAL;
-	}
-	sabre_write(pbm->controller_regs + SABRE_IOMMU_CONTROL, control);
-
-	return 0;
-}
-
 static void __init sabre_pbm_init(struct pci_pbm_info *pbm,
 				  struct of_device *op)
 {
@@ -862,7 +803,7 @@ static int __devinit sabre_probe(struct of_device *op,
 			goto out_free_iommu;
 	}
 
-	err = sabre_iommu_init(pbm, tsbsize, vdma[0], dma_mask);
+	err = psycho_iommu_init(pbm, tsbsize, vdma[0], dma_mask, SABRE_WRSYNC);
 	if (err)
 		goto out_free_iommu;
 
diff --git a/arch/sparc64/kernel/psycho_common.c b/arch/sparc64/kernel/psycho_common.c
new file mode 100644
index 0000000..07acc13
--- /dev/null
+++ b/arch/sparc64/kernel/psycho_common.c
@@ -0,0 +1,93 @@
+/* psycho_common.c: Code common to PSYCHO and derivative PCI controllers.
+ *
+ * Copyright (C) 2008 David S. Miller <davem@davemloft.net>
+ */
+#include <linux/kernel.h>
+
+#include <asm/upa.h>
+
+#include "pci_impl.h"
+#include "psycho_common.h"
+
+#define PSYCHO_IOMMU_TAG		0xa580UL
+#define PSYCHO_IOMMU_DATA		0xa600UL
+
+static void psycho_iommu_flush(struct pci_pbm_info *pbm)
+{
+	int i;
+
+	for (i = 0; i < 16; i++) {
+		unsigned long off = i * 8;
+
+		upa_writeq(0, pbm->controller_regs + PSYCHO_IOMMU_TAG + off);
+		upa_writeq(0, pbm->controller_regs + PSYCHO_IOMMU_DATA + off);
+	}
+}
+
+#define PSYCHO_IOMMU_CONTROL		0x0200UL
+#define  PSYCHO_IOMMU_CTRL_TSBSZ	0x0000000000070000UL
+#define  PSYCHO_IOMMU_TSBSZ_1K      	0x0000000000000000UL
+#define  PSYCHO_IOMMU_TSBSZ_2K      	0x0000000000010000UL
+#define  PSYCHO_IOMMU_TSBSZ_4K      	0x0000000000020000UL
+#define  PSYCHO_IOMMU_TSBSZ_8K      	0x0000000000030000UL
+#define  PSYCHO_IOMMU_TSBSZ_16K     	0x0000000000040000UL
+#define  PSYCHO_IOMMU_TSBSZ_32K     	0x0000000000050000UL
+#define  PSYCHO_IOMMU_TSBSZ_64K     	0x0000000000060000UL
+#define  PSYCHO_IOMMU_TSBSZ_128K    	0x0000000000070000UL
+#define  PSYCHO_IOMMU_CTRL_TBWSZ    	0x0000000000000004UL
+#define  PSYCHO_IOMMU_CTRL_DENAB    	0x0000000000000002UL
+#define  PSYCHO_IOMMU_CTRL_ENAB     	0x0000000000000001UL
+#define PSYCHO_IOMMU_FLUSH		0x0210UL
+#define PSYCHO_IOMMU_TSBBASE		0x0208UL
+
+int psycho_iommu_init(struct pci_pbm_info *pbm, int tsbsize,
+		      u32 dvma_offset, u32 dma_mask,
+		      unsigned long write_complete_offset)
+{
+	struct iommu *iommu = pbm->iommu;
+	u64 control;
+	int err;
+
+	iommu->iommu_control  = pbm->controller_regs + PSYCHO_IOMMU_CONTROL;
+	iommu->iommu_tsbbase  = pbm->controller_regs + PSYCHO_IOMMU_TSBBASE;
+	iommu->iommu_flush    = pbm->controller_regs + PSYCHO_IOMMU_FLUSH;
+	iommu->iommu_tags     = pbm->controller_regs + PSYCHO_IOMMU_TAG;
+	iommu->write_complete_reg = (pbm->controller_regs +
+				     write_complete_offset);
+
+	iommu->iommu_ctxflush = 0;
+
+	control = upa_readq(iommu->iommu_control);
+	control |= PSYCHO_IOMMU_CTRL_DENAB;
+	upa_writeq(control, iommu->iommu_control);
+
+	psycho_iommu_flush(pbm);
+
+	/* Leave diag mode enabled for full-flushing done in pci_iommu.c */
+	err = iommu_table_init(iommu, tsbsize * 1024 * 8,
+			       dvma_offset, dma_mask, pbm->numa_node);
+	if (err)
+		return err;
+
+	upa_writeq(__pa(iommu->page_table), iommu->iommu_tsbbase);
+
+	control = upa_readq(iommu->iommu_control);
+	control &= ~(PSYCHO_IOMMU_CTRL_TSBSZ | PSYCHO_IOMMU_CTRL_TBWSZ);
+	control |= PSYCHO_IOMMU_CTRL_ENAB;
+
+	switch (tsbsize) {
+	case 64:
+		control |= PSYCHO_IOMMU_TSBSZ_64K;
+		break;
+	case 128:
+		control |= PSYCHO_IOMMU_TSBSZ_128K;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	upa_writeq(control, iommu->iommu_control);
+
+	return 0;
+
+}
diff --git a/arch/sparc64/kernel/psycho_common.h b/arch/sparc64/kernel/psycho_common.h
new file mode 100644
index 0000000..bffaff5
--- /dev/null
+++ b/arch/sparc64/kernel/psycho_common.h
@@ -0,0 +1,8 @@
+#ifndef _PSYCHO_COMMON_H
+#define _PSYCHO_COMMON_H
+
+extern int psycho_iommu_init(struct pci_pbm_info *pbm, int tsbsize,
+			     u32 dvma_offset, u32 dma_mask,
+			     unsigned long write_complete_offset);
+
+#endif /* _PSYCHO_COMMON_H */
-- 
1.5.6.5.GIT

