From: David Miller <davem@davemloft.net>
Date: Thu, 11 Sep 2008 06:15:52 +0000
Subject: [PATCH 1/1]: Kill by-hand I/O accessors in PCI controller drivers
Message-Id: <20080910.231552.232646475.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This patch kills off the local foo_read() and foo_write() macros
each PCI controller driver has, and instead uses the existing
upa_readq() and upa_writeq() which are equivalent.

sparc64: Kill hand-crafted I/O accessors in PCI controller drivers.

Use existing upa_{read,write}q() interfaces instead.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc64/kernel/pci_fire.c   |  136 +++++++++++++------------------
 arch/sparc64/kernel/pci_psycho.c |   69 ++++++----------
 arch/sparc64/kernel/pci_sabre.c  |   61 +++++---------
 arch/sparc64/kernel/pci_schizo.c |  167 +++++++++++++++++---------------------
 4 files changed, 177 insertions(+), 256 deletions(-)

diff --git a/arch/sparc64/kernel/pci_fire.c b/arch/sparc64/kernel/pci_fire.c
index 7e1a9b6..9462b68 100644
--- a/arch/sparc64/kernel/pci_fire.c
+++ b/arch/sparc64/kernel/pci_fire.c
@@ -12,27 +12,13 @@
 
 #include <asm/prom.h>
 #include <asm/irq.h>
+#include <asm/upa.h>
 
 #include "pci_impl.h"
 
 #define DRIVER_NAME	"fire"
 #define PFX		DRIVER_NAME ": "
 
-#define fire_read(__reg) \
-({	u64 __ret; \
-	__asm__ __volatile__("ldxa [%1] %2, %0" \
-			     : "=r" (__ret) \
-			     : "r" (__reg), "i" (ASI_PHYS_BYPASS_EC_E) \
-			     : "memory"); \
-	__ret; \
-})
-#define fire_write(__reg, __val) \
-	__asm__ __volatile__("stxa %0, [%1] %2" \
-			     : /* no outputs */ \
-			     : "r" (__val), "r" (__reg), \
-			       "i" (ASI_PHYS_BYPASS_EC_E) \
-			     : "memory")
-
 #define FIRE_IOMMU_CONTROL	0x40000UL
 #define FIRE_IOMMU_TSBBASE	0x40008UL
 #define FIRE_IOMMU_FLUSH	0x40100UL
@@ -65,21 +51,21 @@ static int pci_fire_pbm_iommu_init(struct pci_pbm_info *pbm)
 	/*
 	 * Invalidate TLB Entries.
 	 */
-	fire_write(iommu->iommu_flushinv, ~(u64)0);
+	upa_writeq(~(u64)0, iommu->iommu_flushinv);
 
 	err = iommu_table_init(iommu, tsbsize * 8 * 1024, vdma[0], dma_mask,
 			       pbm->numa_node);
 	if (err)
 		return err;
 
-	fire_write(iommu->iommu_tsbbase, __pa(iommu->page_table) | 0x7UL);
+	upa_writeq(__pa(iommu->page_table) | 0x7UL, iommu->iommu_tsbbase);
 
-	control = fire_read(iommu->iommu_control);
+	control = upa_readq(iommu->iommu_control);
 	control |= (0x00000400 /* TSB cache snoop enable */	|
 		    0x00000300 /* Cache mode */			|
 		    0x00000002 /* Bypass enable */		|
 		    0x00000001 /* Translation enable */);
-	fire_write(iommu->iommu_control, control);
+	upa_writeq(control, iommu->iommu_control);
 
 	return 0;
 }
@@ -161,7 +147,7 @@ struct pci_msiq_entry {
 static int pci_fire_get_head(struct pci_pbm_info *pbm, unsigned long msiqid,
 			     unsigned long *head)
 {
-	*head = fire_read(pbm->pbm_regs + EVENT_QUEUE_HEAD(msiqid));
+	*head = upa_readq(pbm->pbm_regs + EVENT_QUEUE_HEAD(msiqid));
 	return 0;
 }
 
@@ -187,8 +173,7 @@ static int pci_fire_dequeue_msi(struct pci_pbm_info *pbm, unsigned long msiqid,
 	*msi = msi_num = ((ep->word0 & MSIQ_WORD0_DATA0) >>
 			  MSIQ_WORD0_DATA0_SHIFT);
 
-	fire_write(pbm->pbm_regs + MSI_CLEAR(msi_num),
-		   MSI_CLEAR_EQWR_N);
+	upa_writeq(MSI_CLEAR_EQWR_N, pbm->pbm_regs + MSI_CLEAR(msi_num));
 
 	/* Clear the entry.  */
 	ep->word0 &= ~MSIQ_WORD0_FMT_TYPE;
@@ -204,7 +189,7 @@ static int pci_fire_dequeue_msi(struct pci_pbm_info *pbm, unsigned long msiqid,
 static int pci_fire_set_head(struct pci_pbm_info *pbm, unsigned long msiqid,
 			     unsigned long head)
 {
-	fire_write(pbm->pbm_regs + EVENT_QUEUE_HEAD(msiqid), head);
+	upa_writeq(head, pbm->pbm_regs + EVENT_QUEUE_HEAD(msiqid));
 	return 0;
 }
 
@@ -213,17 +198,16 @@ static int pci_fire_msi_setup(struct pci_pbm_info *pbm, unsigned long msiqid,
 {
 	u64 val;
 
-	val = fire_read(pbm->pbm_regs + MSI_MAP(msi));
+	val = upa_readq(pbm->pbm_regs + MSI_MAP(msi));
 	val &= ~(MSI_MAP_EQNUM);
 	val |= msiqid;
-	fire_write(pbm->pbm_regs + MSI_MAP(msi), val);
+	upa_writeq(val, pbm->pbm_regs + MSI_MAP(msi));
 
-	fire_write(pbm->pbm_regs + MSI_CLEAR(msi),
-		   MSI_CLEAR_EQWR_N);
+	upa_writeq(MSI_CLEAR_EQWR_N, pbm->pbm_regs + MSI_CLEAR(msi));
 
-	val = fire_read(pbm->pbm_regs + MSI_MAP(msi));
+	val = upa_readq(pbm->pbm_regs + MSI_MAP(msi));
 	val |= MSI_MAP_VALID;
-	fire_write(pbm->pbm_regs + MSI_MAP(msi), val);
+	upa_writeq(val, pbm->pbm_regs + MSI_MAP(msi));
 
 	return 0;
 }
@@ -233,12 +217,12 @@ static int pci_fire_msi_teardown(struct pci_pbm_info *pbm, unsigned long msi)
 	unsigned long msiqid;
 	u64 val;
 
-	val = fire_read(pbm->pbm_regs + MSI_MAP(msi));
+	val = upa_readq(pbm->pbm_regs + MSI_MAP(msi));
 	msiqid = (val & MSI_MAP_EQNUM);
 
 	val &= ~MSI_MAP_VALID;
 
-	fire_write(pbm->pbm_regs + MSI_MAP(msi), val);
+	upa_writeq(val, pbm->pbm_regs + MSI_MAP(msi));
 
 	return 0;
 }
@@ -257,22 +241,19 @@ static int pci_fire_msiq_alloc(struct pci_pbm_info *pbm)
 	memset((char *)pages, 0, PAGE_SIZE << order);
 	pbm->msi_queues = (void *) pages;
 
-	fire_write(pbm->pbm_regs + EVENT_QUEUE_BASE_ADDR_REG,
-		   (EVENT_QUEUE_BASE_ADDR_ALL_ONES |
-		    __pa(pbm->msi_queues)));
+	upa_writeq((EVENT_QUEUE_BASE_ADDR_ALL_ONES |
+		    __pa(pbm->msi_queues)),
+		   pbm->pbm_regs + EVENT_QUEUE_BASE_ADDR_REG);
 
-	fire_write(pbm->pbm_regs + IMONDO_DATA0,
-		   pbm->portid << 6);
-	fire_write(pbm->pbm_regs + IMONDO_DATA1, 0);
+	upa_writeq(pbm->portid << 6, pbm->pbm_regs + IMONDO_DATA0);
+	upa_writeq(0, pbm->pbm_regs + IMONDO_DATA1);
 
-	fire_write(pbm->pbm_regs + MSI_32BIT_ADDR,
-		   pbm->msi32_start);
-	fire_write(pbm->pbm_regs + MSI_64BIT_ADDR,
-		   pbm->msi64_start);
+	upa_writeq(pbm->msi32_start, pbm->pbm_regs + MSI_32BIT_ADDR);
+	upa_writeq(pbm->msi64_start, pbm->pbm_regs + MSI_64BIT_ADDR);
 
 	for (i = 0; i < pbm->msiq_num; i++) {
-		fire_write(pbm->pbm_regs + EVENT_QUEUE_HEAD(i), 0);
-		fire_write(pbm->pbm_regs + EVENT_QUEUE_TAIL(i), 0);
+		upa_writeq(0, pbm->pbm_regs + EVENT_QUEUE_HEAD(i));
+		upa_writeq(0, pbm->pbm_regs + EVENT_QUEUE_TAIL(i));
 	}
 
 	return 0;
@@ -306,9 +287,9 @@ static int pci_fire_msiq_build_irq(struct pci_pbm_info *pbm,
 	/* XXX iterate amongst the 4 IRQ controllers XXX */
 	int_ctrlr = (1UL << 6);
 
-	val = fire_read(imap_reg);
+	val = upa_readq(imap_reg);
 	val |= (1UL << 63) | int_ctrlr;
-	fire_write(imap_reg, val);
+	upa_writeq(val, imap_reg);
 
 	fixup = ((pbm->portid << 6) | devino) - int_ctrlr;
 
@@ -316,9 +297,8 @@ static int pci_fire_msiq_build_irq(struct pci_pbm_info *pbm,
 	if (!virt_irq)
 		return -ENOMEM;
 
-	fire_write(pbm->pbm_regs +
-		   EVENT_QUEUE_CONTROL_SET(msiqid),
-		   EVENT_QUEUE_CONTROL_SET_EN);
+	upa_writeq(EVENT_QUEUE_CONTROL_SET_EN,
+		   pbm->pbm_regs + EVENT_QUEUE_CONTROL_SET(msiqid));
 
 	return virt_irq;
 }
@@ -386,49 +366,47 @@ static void pci_fire_hw_init(struct pci_pbm_info *pbm)
 {
 	u64 val;
 
-	fire_write(pbm->controller_regs + FIRE_PARITY_CONTROL,
-		   FIRE_PARITY_ENAB);
+	upa_writeq(FIRE_PARITY_ENAB,
+		   pbm->controller_regs + FIRE_PARITY_CONTROL);
 
-	fire_write(pbm->controller_regs + FIRE_FATAL_RESET_CTL,
-		   (FIRE_FATAL_RESET_SPARE |
+	upa_writeq((FIRE_FATAL_RESET_SPARE |
 		    FIRE_FATAL_RESET_MB |
 		    FIRE_FATAL_RESET_CPE |
 		    FIRE_FATAL_RESET_APE |
 		    FIRE_FATAL_RESET_PIO |
 		    FIRE_FATAL_RESET_JW |
 		    FIRE_FATAL_RESET_JI |
-		    FIRE_FATAL_RESET_JR));
+		    FIRE_FATAL_RESET_JR),
+		   pbm->controller_regs + FIRE_FATAL_RESET_CTL);
 
-	fire_write(pbm->controller_regs + FIRE_CORE_INTR_ENABLE, ~(u64)0);
+	upa_writeq(~(u64)0, pbm->controller_regs + FIRE_CORE_INTR_ENABLE);
 
-	val = fire_read(pbm->pbm_regs + FIRE_TLU_CTRL);
+	val = upa_readq(pbm->pbm_regs + FIRE_TLU_CTRL);
 	val |= (FIRE_TLU_CTRL_TIM |
 		FIRE_TLU_CTRL_QDET |
 		FIRE_TLU_CTRL_CFG);
-	fire_write(pbm->pbm_regs + FIRE_TLU_CTRL, val);
-	fire_write(pbm->pbm_regs + FIRE_TLU_DEV_CTRL, 0);
-	fire_write(pbm->pbm_regs + FIRE_TLU_LINK_CTRL,
-		   FIRE_TLU_LINK_CTRL_CLK);
-
-	fire_write(pbm->pbm_regs + FIRE_LPU_RESET, 0);
-	fire_write(pbm->pbm_regs + FIRE_LPU_LLCFG,
-		   FIRE_LPU_LLCFG_VC0);
-	fire_write(pbm->pbm_regs + FIRE_LPU_FCTRL_UCTRL,
-		   (FIRE_LPU_FCTRL_UCTRL_N |
-		    FIRE_LPU_FCTRL_UCTRL_P));
-	fire_write(pbm->pbm_regs + FIRE_LPU_TXL_FIFOP,
-		   ((0xffff << 16) | (0x0000 << 0)));
-	fire_write(pbm->pbm_regs + FIRE_LPU_LTSSM_CFG2, 3000000);
-	fire_write(pbm->pbm_regs + FIRE_LPU_LTSSM_CFG3, 500000);
-	fire_write(pbm->pbm_regs + FIRE_LPU_LTSSM_CFG4,
-		   (2 << 16) | (140 << 8));
-	fire_write(pbm->pbm_regs + FIRE_LPU_LTSSM_CFG5, 0);
-
-	fire_write(pbm->pbm_regs + FIRE_DMC_IENAB, ~(u64)0);
-	fire_write(pbm->pbm_regs + FIRE_DMC_DBG_SEL_A, 0);
-	fire_write(pbm->pbm_regs + FIRE_DMC_DBG_SEL_B, 0);
-
-	fire_write(pbm->pbm_regs + FIRE_PEC_IENAB, ~(u64)0);
+	upa_writeq(val, pbm->pbm_regs + FIRE_TLU_CTRL);
+	upa_writeq(0, pbm->pbm_regs + FIRE_TLU_DEV_CTRL);
+	upa_writeq(FIRE_TLU_LINK_CTRL_CLK,
+		   pbm->pbm_regs + FIRE_TLU_LINK_CTRL);
+
+	upa_writeq(0, pbm->pbm_regs + FIRE_LPU_RESET);
+	upa_writeq(FIRE_LPU_LLCFG_VC0, pbm->pbm_regs + FIRE_LPU_LLCFG);
+	upa_writeq((FIRE_LPU_FCTRL_UCTRL_N | FIRE_LPU_FCTRL_UCTRL_P),
+		   pbm->pbm_regs + FIRE_LPU_FCTRL_UCTRL);
+	upa_writeq(((0xffff << 16) | (0x0000 << 0)),
+		   pbm->pbm_regs + FIRE_LPU_TXL_FIFOP);
+	upa_writeq(3000000, pbm->pbm_regs + FIRE_LPU_LTSSM_CFG2);
+	upa_writeq(500000, pbm->pbm_regs + FIRE_LPU_LTSSM_CFG3);
+	upa_writeq((2 << 16) | (140 << 8),
+		   pbm->pbm_regs + FIRE_LPU_LTSSM_CFG4);
+	upa_writeq(0, pbm->pbm_regs + FIRE_LPU_LTSSM_CFG5);
+
+	upa_writeq(~(u64)0, pbm->pbm_regs + FIRE_DMC_IENAB);
+	upa_writeq(0, pbm->pbm_regs + FIRE_DMC_DBG_SEL_A);
+	upa_writeq(0, pbm->pbm_regs + FIRE_DMC_DBG_SEL_B);
+
+	upa_writeq(~(u64)0, pbm->pbm_regs + FIRE_PEC_IENAB);
 }
 
 static int __init pci_fire_pbm_init(struct pci_pbm_info *pbm,
diff --git a/arch/sparc64/kernel/pci_psycho.c b/arch/sparc64/kernel/pci_psycho.c
index bac9c1b..8973346 100644
--- a/arch/sparc64/kernel/pci_psycho.c
+++ b/arch/sparc64/kernel/pci_psycho.c
@@ -17,6 +17,7 @@
 #include <asm/irq.h>
 #include <asm/starfire.h>
 #include <asm/prom.h>
+#include <asm/upa.h>
 
 #include "pci_impl.h"
 #include "iommu_common.h"
@@ -25,25 +26,6 @@
 #define DRIVER_NAME	"psycho"
 #define PFX		DRIVER_NAME ": "
 
-/* All PSYCHO registers are 64-bits.  The following accessor
- * routines are how they are accessed.  The REG parameter
- * is a physical address.
- */
-#define psycho_read(__reg) \
-({	u64 __ret; \
-	__asm__ __volatile__("ldxa [%1] %2, %0" \
-			     : "=r" (__ret) \
-			     : "r" (__reg), "i" (ASI_PHYS_BYPASS_EC_E) \
-			     : "memory"); \
-	__ret; \
-})
-#define psycho_write(__reg, __val) \
-	__asm__ __volatile__("stxa %0, [%1] %2" \
-			     : /* no outputs */ \
-			     : "r" (__val), "r" (__reg), \
-			       "i" (ASI_PHYS_BYPASS_EC_E) \
-			     : "memory")
-
 /* Misc. PSYCHO PCI controller register offsets and definitions. */
 #define PSYCHO_CONTROL		0x0010UL
 #define  PSYCHO_CONTROL_IMPL	 0xf000000000000000UL /* Implementation of this PSYCHO*/
@@ -182,8 +164,8 @@ static irqreturn_t psycho_ue_intr(int irq, void *dev_id)
 	int reported;
 
 	/* Latch uncorrectable error status. */
-	afar = psycho_read(afar_reg);
-	afsr = psycho_read(afsr_reg);
+	afar = upa_readq(afar_reg);
+	afsr = upa_readq(afsr_reg);
 
 	/* Clear the primary/secondary error status bits. */
 	error_bits = afsr &
@@ -191,7 +173,7 @@ static irqreturn_t psycho_ue_intr(int irq, void *dev_id)
 		 PSYCHO_UEAFSR_SPIO | PSYCHO_UEAFSR_SDRD | PSYCHO_UEAFSR_SDWR);
 	if (!error_bits)
 		return IRQ_NONE;
-	psycho_write(afsr_reg, error_bits);
+	upa_writeq(error_bits, afsr_reg);
 
 	/* Log the error. */
 	printk("%s: Uncorrectable Error, primary error type[%s]\n",
@@ -261,8 +243,8 @@ static irqreturn_t psycho_ce_intr(int irq, void *dev_id)
 	int reported;
 
 	/* Latch error status. */
-	afar = psycho_read(afar_reg);
-	afsr = psycho_read(afsr_reg);
+	afar = upa_readq(afar_reg);
+	afsr = upa_readq(afsr_reg);
 
 	/* Clear primary/secondary error status bits. */
 	error_bits = afsr &
@@ -270,7 +252,7 @@ static irqreturn_t psycho_ce_intr(int irq, void *dev_id)
 		 PSYCHO_CEAFSR_SPIO | PSYCHO_CEAFSR_SDRD | PSYCHO_CEAFSR_SDWR);
 	if (!error_bits)
 		return IRQ_NONE;
-	psycho_write(afsr_reg, error_bits);
+	upa_writeq(error_bits, afsr_reg);
 
 	/* Log the error. */
 	printk("%s: Correctable Error, primary error type[%s]\n",
@@ -373,27 +355,26 @@ static void psycho_register_error_handlers(struct pci_pbm_info *pbm)
 		       "err=%d\n", pbm->name, err);
 
 	/* Enable UE and CE interrupts for controller. */
-	psycho_write(base + PSYCHO_ECC_CTRL,
-		     (PSYCHO_ECCCTRL_EE |
-		      PSYCHO_ECCCTRL_UE |
-		      PSYCHO_ECCCTRL_CE));
+	upa_writeq((PSYCHO_ECCCTRL_EE |
+		    PSYCHO_ECCCTRL_UE |
+		    PSYCHO_ECCCTRL_CE), base + PSYCHO_ECC_CTRL);
 
 	/* Enable PCI Error interrupts and clear error
 	 * bits for each PBM.
 	 */
-	tmp = psycho_read(base + PSYCHO_PCIA_CTRL);
+	tmp = upa_readq(base + PSYCHO_PCIA_CTRL);
 	tmp |= (PSYCHO_PCICTRL_SERR |
 		PSYCHO_PCICTRL_SBH_ERR |
 		PSYCHO_PCICTRL_EEN);
 	tmp &= ~(PSYCHO_PCICTRL_SBH_INT);
-	psycho_write(base + PSYCHO_PCIA_CTRL, tmp);
+	upa_writeq(tmp, base + PSYCHO_PCIA_CTRL);
 		     
-	tmp = psycho_read(base + PSYCHO_PCIB_CTRL);
+	tmp = upa_readq(base + PSYCHO_PCIB_CTRL);
 	tmp |= (PSYCHO_PCICTRL_SERR |
 		PSYCHO_PCICTRL_SBH_ERR |
 		PSYCHO_PCICTRL_EEN);
 	tmp &= ~(PSYCHO_PCICTRL_SBH_INT);
-	psycho_write(base + PSYCHO_PCIB_CTRL, tmp);
+	upa_writeq(tmp, base + PSYCHO_PCIB_CTRL);
 }
 
 /* PSYCHO boot time probing and initialization. */
@@ -443,28 +424,28 @@ static void psycho_controller_hwinit(struct pci_pbm_info *pbm)
 {
 	u64 tmp;
 
-	psycho_write(pbm->controller_regs + PSYCHO_IRQ_RETRY, 5);
+	upa_writeq(5, pbm->controller_regs + PSYCHO_IRQ_RETRY);
 
 	/* Enable arbiter for all PCI slots. */
-	tmp = psycho_read(pbm->controller_regs + PSYCHO_PCIA_CTRL);
+	tmp = upa_readq(pbm->controller_regs + PSYCHO_PCIA_CTRL);
 	tmp |= PSYCHO_PCICTRL_AEN;
-	psycho_write(pbm->controller_regs + PSYCHO_PCIA_CTRL, tmp);
+	upa_writeq(tmp, pbm->controller_regs + PSYCHO_PCIA_CTRL);
 
-	tmp = psycho_read(pbm->controller_regs + PSYCHO_PCIB_CTRL);
+	tmp = upa_readq(pbm->controller_regs + PSYCHO_PCIB_CTRL);
 	tmp |= PSYCHO_PCICTRL_AEN;
-	psycho_write(pbm->controller_regs + PSYCHO_PCIB_CTRL, tmp);
+	upa_writeq(tmp, pbm->controller_regs + PSYCHO_PCIB_CTRL);
 
 	/* Disable DMA write / PIO read synchronization on
 	 * both PCI bus segments.
 	 * [ U2P Erratum 1243770, STP2223BGA data sheet ]
 	 */
-	tmp = psycho_read(pbm->controller_regs + PSYCHO_PCIA_DIAG);
+	tmp = upa_readq(pbm->controller_regs + PSYCHO_PCIA_DIAG);
 	tmp |= PSYCHO_PCIDIAG_DDWSYNC;
-	psycho_write(pbm->controller_regs + PSYCHO_PCIA_DIAG, tmp);
+	upa_writeq(tmp, pbm->controller_regs + PSYCHO_PCIA_DIAG);
 
-	tmp = psycho_read(pbm->controller_regs + PSYCHO_PCIB_DIAG);
+	tmp = upa_readq(pbm->controller_regs + PSYCHO_PCIB_DIAG);
 	tmp |= PSYCHO_PCIDIAG_DDWSYNC;
-	psycho_write(pbm->controller_regs + PSYCHO_PCIB_DIAG, tmp);
+	upa_writeq(tmp, pbm->controller_regs + PSYCHO_PCIB_DIAG);
 }
 
 static void psycho_pbm_strbuf_init(struct pci_pbm_info *pbm,
@@ -509,7 +490,7 @@ static void psycho_pbm_strbuf_init(struct pci_pbm_info *pbm,
 	 */
 #undef PSYCHO_STRBUF_RERUN_ENABLE
 #undef PSYCHO_STRBUF_RERUN_DISABLE
-	control = psycho_read(pbm->stc.strbuf_control);
+	control = upa_readq(pbm->stc.strbuf_control);
 	control |= PSYCHO_STRBUF_CTRL_ENAB;
 	control &= ~(PSYCHO_STRBUF_CTRL_LENAB | PSYCHO_STRBUF_CTRL_LPTR);
 #ifdef PSYCHO_STRBUF_RERUN_ENABLE
@@ -519,7 +500,7 @@ static void psycho_pbm_strbuf_init(struct pci_pbm_info *pbm,
 	control |= PSYCHO_STRBUF_CTRL_RRDIS;
 #endif
 #endif
-	psycho_write(pbm->stc.strbuf_control, control);
+	upa_writeq(control, pbm->stc.strbuf_control);
 
 	pbm->stc.strbuf_enabled = 1;
 }
diff --git a/arch/sparc64/kernel/pci_sabre.c b/arch/sparc64/kernel/pci_sabre.c
index f8089aa..713257b 100644
--- a/arch/sparc64/kernel/pci_sabre.c
+++ b/arch/sparc64/kernel/pci_sabre.c
@@ -17,6 +17,7 @@
 #include <asm/iommu.h>
 #include <asm/irq.h>
 #include <asm/prom.h>
+#include <asm/upa.h>
 
 #include "pci_impl.h"
 #include "iommu_common.h"
@@ -25,25 +26,6 @@
 #define DRIVER_NAME	"sabre"
 #define PFX		DRIVER_NAME ": "
 
-/* All SABRE registers are 64-bits.  The following accessor
- * routines are how they are accessed.  The REG parameter
- * is a physical address.
- */
-#define sabre_read(__reg) \
-({	u64 __ret; \
-	__asm__ __volatile__("ldxa [%1] %2, %0" \
-			     : "=r" (__ret) \
-			     : "r" (__reg), "i" (ASI_PHYS_BYPASS_EC_E) \
-			     : "memory"); \
-	__ret; \
-})
-#define sabre_write(__reg, __val) \
-	__asm__ __volatile__("stxa %0, [%1] %2" \
-			     : /* no outputs */ \
-			     : "r" (__val), "r" (__reg), \
-			       "i" (ASI_PHYS_BYPASS_EC_E) \
-			     : "memory")
-
 /* SABRE PCI controller register offsets and definitions. */
 #define SABRE_UE_AFSR		0x0030UL
 #define  SABRE_UEAFSR_PDRD	 0x4000000000000000UL	/* Primary PCI DMA Read */
@@ -219,8 +201,8 @@ static irqreturn_t sabre_ue_intr(int irq, void *dev_id)
 	int reported;
 
 	/* Latch uncorrectable error status. */
-	afar = sabre_read(afar_reg);
-	afsr = sabre_read(afsr_reg);
+	afar = upa_readq(afar_reg);
+	afsr = upa_readq(afsr_reg);
 
 	/* Clear the primary/secondary error status bits. */
 	error_bits = afsr &
@@ -229,7 +211,7 @@ static irqreturn_t sabre_ue_intr(int irq, void *dev_id)
 		 SABRE_UEAFSR_SDTE | SABRE_UEAFSR_PDTE);
 	if (!error_bits)
 		return IRQ_NONE;
-	sabre_write(afsr_reg, error_bits);
+	upa_writeq(error_bits, afsr_reg);
 
 	/* Log the error. */
 	printk("%s: Uncorrectable Error, primary error type[%s%s]\n",
@@ -279,8 +261,8 @@ static irqreturn_t sabre_ce_intr(int irq, void *dev_id)
 	int reported;
 
 	/* Latch error status. */
-	afar = sabre_read(afar_reg);
-	afsr = sabre_read(afsr_reg);
+	afar = upa_readq(afar_reg);
+	afsr = upa_readq(afsr_reg);
 
 	/* Clear primary/secondary error status bits. */
 	error_bits = afsr &
@@ -288,7 +270,7 @@ static irqreturn_t sabre_ce_intr(int irq, void *dev_id)
 		 SABRE_CEAFSR_SDRD | SABRE_CEAFSR_SDWR);
 	if (!error_bits)
 		return IRQ_NONE;
-	sabre_write(afsr_reg, error_bits);
+	upa_writeq(error_bits, afsr_reg);
 
 	/* Log the error. */
 	printk("%s: Correctable Error, primary error type[%s]\n",
@@ -354,19 +336,20 @@ static void sabre_register_error_handlers(struct pci_pbm_info *pbm)
 	 * registering the handler so that we don't get spurious
 	 * interrupts.
 	 */
-	sabre_write(base + SABRE_UE_AFSR,
-		    (SABRE_UEAFSR_PDRD | SABRE_UEAFSR_PDWR |
-		     SABRE_UEAFSR_SDRD | SABRE_UEAFSR_SDWR |
-		     SABRE_UEAFSR_SDTE | SABRE_UEAFSR_PDTE));
+	upa_writeq((SABRE_UEAFSR_PDRD | SABRE_UEAFSR_PDWR |
+		    SABRE_UEAFSR_SDRD | SABRE_UEAFSR_SDWR |
+		    SABRE_UEAFSR_SDTE | SABRE_UEAFSR_PDTE),
+		   base + SABRE_UE_AFSR);
 
 	err = request_irq(op->irqs[1], sabre_ue_intr, 0, "SABRE_UE", pbm);
 	if (err)
 		printk(KERN_WARNING "%s: Couldn't register UE, err=%d.\n",
 		       pbm->name, err);
 
-	sabre_write(base + SABRE_CE_AFSR,
-		    (SABRE_CEAFSR_PDRD | SABRE_CEAFSR_PDWR |
-		     SABRE_CEAFSR_SDRD | SABRE_CEAFSR_SDWR));
+	upa_writeq((SABRE_CEAFSR_PDRD | SABRE_CEAFSR_PDWR |
+		    SABRE_CEAFSR_SDRD | SABRE_CEAFSR_SDWR),
+		   base + SABRE_CE_AFSR);
+
 
 	err = request_irq(op->irqs[2], sabre_ce_intr, 0, "SABRE_CE", pbm);
 	if (err)
@@ -378,9 +361,9 @@ static void sabre_register_error_handlers(struct pci_pbm_info *pbm)
 		printk(KERN_WARNING "%s: Couldn't register PCIERR, err=%d.\n",
 		       pbm->name, err);
 
-	tmp = sabre_read(base + SABRE_PCICTRL);
+	tmp = upa_readq(base + SABRE_PCICTRL);
 	tmp |= SABRE_PCICTRL_ERREN;
-	sabre_write(base + SABRE_PCICTRL, tmp);
+	upa_writeq(tmp, base + SABRE_PCICTRL);
 }
 
 static void apb_init(struct pci_bus *sabre_bus)
@@ -533,16 +516,16 @@ static int __devinit sabre_probe(struct of_device *op,
 
 	/* PCI first */
 	for (clear_irq = SABRE_ICLR_A_SLOT0; clear_irq < SABRE_ICLR_B_SLOT0 + 0x80; clear_irq += 8)
-		sabre_write(pbm->controller_regs + clear_irq, 0x0UL);
+		upa_writeq(0x0UL, pbm->controller_regs + clear_irq);
 
 	/* Then OBIO */
 	for (clear_irq = SABRE_ICLR_SCSI; clear_irq < SABRE_ICLR_SCSI + 0x80; clear_irq += 8)
-		sabre_write(pbm->controller_regs + clear_irq, 0x0UL);
+		upa_writeq(0x0UL, pbm->controller_regs + clear_irq);
 
 	/* Error interrupts are enabled later after the bus scan. */
-	sabre_write(pbm->controller_regs + SABRE_PCICTRL,
-		    (SABRE_PCICTRL_MRLEN   | SABRE_PCICTRL_SERR |
-		     SABRE_PCICTRL_ARBPARK | SABRE_PCICTRL_AEN));
+	upa_writeq((SABRE_PCICTRL_MRLEN   | SABRE_PCICTRL_SERR |
+		    SABRE_PCICTRL_ARBPARK | SABRE_PCICTRL_AEN),
+		   pbm->controller_regs + SABRE_PCICTRL);
 
 	/* Now map in PCI config space for entire SABRE. */
 	pbm->config_space = pbm->controller_regs + SABRE_CONFIGSPACE;
diff --git a/arch/sparc64/kernel/pci_schizo.c b/arch/sparc64/kernel/pci_schizo.c
index c308565..45d9dba 100644
--- a/arch/sparc64/kernel/pci_schizo.c
+++ b/arch/sparc64/kernel/pci_schizo.c
@@ -15,6 +15,7 @@
 #include <asm/irq.h>
 #include <asm/pstate.h>
 #include <asm/prom.h>
+#include <asm/upa.h>
 
 #include "pci_impl.h"
 #include "iommu_common.h"
@@ -22,25 +23,6 @@
 #define DRIVER_NAME	"schizo"
 #define PFX		DRIVER_NAME ": "
 
-/* All SCHIZO registers are 64-bits.  The following accessor
- * routines are how they are accessed.  The REG parameter
- * is a physical address.
- */
-#define schizo_read(__reg) \
-({	u64 __ret; \
-	__asm__ __volatile__("ldxa [%1] %2, %0" \
-			     : "=r" (__ret) \
-			     : "r" (__reg), "i" (ASI_PHYS_BYPASS_EC_E) \
-			     : "memory"); \
-	__ret; \
-})
-#define schizo_write(__reg, __val) \
-	__asm__ __volatile__("stxa %0, [%1] %2" \
-			     : /* no outputs */ \
-			     : "r" (__val), "r" (__reg), \
-			       "i" (ASI_PHYS_BYPASS_EC_E) \
-			     : "memory")
-
 /* This is a convention that at least Excalibur and Merlin
  * follow.  I suppose the SCHIZO used in Starcat and friends
  * will do similar.
@@ -164,25 +146,25 @@ static void __schizo_check_stc_error_pbm(struct pci_pbm_info *pbm,
 	 * invalidating it before it has a chance to reach
 	 * main memory.
 	 */
-	control = schizo_read(strbuf->strbuf_control);
-	schizo_write(strbuf->strbuf_control,
-		     (control | SCHIZO_STRBUF_CTRL_DENAB));
+	control = upa_readq(strbuf->strbuf_control);
+	upa_writeq((control | SCHIZO_STRBUF_CTRL_DENAB),
+		   strbuf->strbuf_control);
 	for (i = 0; i < 128; i++) {
 		unsigned long val;
 
-		val = schizo_read(err_base + (i * 8UL));
-		schizo_write(err_base + (i * 8UL), 0UL);
+		val = upa_readq(err_base + (i * 8UL));
+		upa_writeq(0UL, err_base + (i * 8UL));
 		stc_error_buf[i] = val;
 	}
 	for (i = 0; i < 16; i++) {
-		stc_tag_buf[i] = schizo_read(tag_base + (i * 8UL));
-		stc_line_buf[i] = schizo_read(line_base + (i * 8UL));
-		schizo_write(tag_base + (i * 8UL), 0UL);
-		schizo_write(line_base + (i * 8UL), 0UL);
+		stc_tag_buf[i] = upa_readq(tag_base + (i * 8UL));
+		stc_line_buf[i] = upa_readq(line_base + (i * 8UL));
+		upa_writeq(0UL, tag_base + (i * 8UL));
+		upa_writeq(0UL, line_base + (i * 8UL));
 	}
 
 	/* OK, state is logged, exit diagnostic mode. */
-	schizo_write(strbuf->strbuf_control, control);
+	upa_writeq(control, strbuf->strbuf_control);
 
 	for (i = 0; i < 16; i++) {
 		int j, saw_error, first, last;
@@ -259,14 +241,14 @@ static void schizo_check_iommu_error_pbm(struct pci_pbm_info *pbm,
 	int i;
 
 	spin_lock_irqsave(&iommu->lock, flags);
-	control = schizo_read(iommu->iommu_control);
+	control = upa_readq(iommu->iommu_control);
 	if (control & SCHIZO_IOMMU_CTRL_XLTEERR) {
 		unsigned long base;
 		char *type_string;
 
 		/* Clear the error encountered bit. */
 		control &= ~SCHIZO_IOMMU_CTRL_XLTEERR;
-		schizo_write(iommu->iommu_control, control);
+		upa_writeq(control, iommu->iommu_control);
 
 		switch((control & SCHIZO_IOMMU_CTRL_XLTESTAT) >> 25UL) {
 		case 0:
@@ -296,24 +278,24 @@ static void schizo_check_iommu_error_pbm(struct pci_pbm_info *pbm,
 		 * get as much diagnostic information to the
 		 * console as we can.
 		 */
-		schizo_write(iommu->iommu_control,
-			     control | SCHIZO_IOMMU_CTRL_DENAB);
+		upa_writeq(control | SCHIZO_IOMMU_CTRL_DENAB,
+			   iommu->iommu_control);
 
 		base = pbm->pbm_regs;
 
 		for (i = 0; i < 16; i++) {
 			iommu_tag[i] -				schizo_read(base + SCHIZO_IOMMU_TAG + (i * 8UL));
+				upa_readq(base + SCHIZO_IOMMU_TAG + (i * 8UL));
 			iommu_data[i] -				schizo_read(base + SCHIZO_IOMMU_DATA + (i * 8UL));
+				upa_readq(base + SCHIZO_IOMMU_DATA + (i * 8UL));
 
 			/* Now clear out the entry. */
-			schizo_write(base + SCHIZO_IOMMU_TAG + (i * 8UL), 0);
-			schizo_write(base + SCHIZO_IOMMU_DATA + (i * 8UL), 0);
+			upa_writeq(0, base + SCHIZO_IOMMU_TAG + (i * 8UL));
+			upa_writeq(0, base + SCHIZO_IOMMU_DATA + (i * 8UL));
 		}
 
 		/* Leave diagnostic mode. */
-		schizo_write(iommu->iommu_control, control);
+		upa_writeq(control, iommu->iommu_control);
 
 		for (i = 0; i < 16; i++) {
 			unsigned long tag, data;
@@ -394,7 +376,7 @@ static irqreturn_t schizo_ue_intr(int irq, void *dev_id)
 	int reported, limit;
 
 	/* Latch uncorrectable error status. */
-	afar = schizo_read(afar_reg);
+	afar = upa_readq(afar_reg);
 
 	/* If either of the error pending bits are set in the
 	 * AFSR, the error status is being actively updated by
@@ -402,7 +384,7 @@ static irqreturn_t schizo_ue_intr(int irq, void *dev_id)
 	 */
 	limit = 1000;
 	do {
-		afsr = schizo_read(afsr_reg);
+		afsr = upa_readq(afsr_reg);
 	} while ((afsr & SCHIZO_UEAFSR_ERRPNDG) != 0 && --limit);
 
 	/* Clear the primary/secondary error status bits. */
@@ -411,7 +393,7 @@ static irqreturn_t schizo_ue_intr(int irq, void *dev_id)
 		 SCHIZO_UEAFSR_SPIO | SCHIZO_UEAFSR_SDMA);
 	if (!error_bits)
 		return IRQ_NONE;
-	schizo_write(afsr_reg, error_bits);
+	upa_writeq(error_bits, afsr_reg);
 
 	/* Log the error. */
 	printk("%s: Uncorrectable Error, primary error type[%s]\n",
@@ -482,7 +464,7 @@ static irqreturn_t schizo_ce_intr(int irq, void *dev_id)
 	int reported, limit;
 
 	/* Latch error status. */
-	afar = schizo_read(afar_reg);
+	afar = upa_readq(afar_reg);
 
 	/* If either of the error pending bits are set in the
 	 * AFSR, the error status is being actively updated by
@@ -490,7 +472,7 @@ static irqreturn_t schizo_ce_intr(int irq, void *dev_id)
 	 */
 	limit = 1000;
 	do {
-		afsr = schizo_read(afsr_reg);
+		afsr = upa_readq(afsr_reg);
 	} while ((afsr & SCHIZO_UEAFSR_ERRPNDG) != 0 && --limit);
 
 	/* Clear primary/secondary error status bits. */
@@ -499,7 +481,7 @@ static irqreturn_t schizo_ce_intr(int irq, void *dev_id)
 		 SCHIZO_CEAFSR_SPIO | SCHIZO_CEAFSR_SDMA);
 	if (!error_bits)
 		return IRQ_NONE;
-	schizo_write(afsr_reg, error_bits);
+	upa_writeq(error_bits, afsr_reg);
 
 	/* Log the error. */
 	printk("%s: Correctable Error, primary error type[%s]\n",
@@ -601,7 +583,7 @@ static irqreturn_t schizo_pcierr_intr_other(struct pci_pbm_info *pbm)
 	u16 stat;
 
 	csr_reg = pbm->pbm_regs + SCHIZO_PCI_CTRL;
-	csr = schizo_read(csr_reg);
+	csr = upa_readq(csr_reg);
 	csr_error_bits  		csr & (SCHIZO_PCICTRL_BUS_UNUS |
 		       SCHIZO_PCICTRL_TTO_ERR |
@@ -611,7 +593,7 @@ static irqreturn_t schizo_pcierr_intr_other(struct pci_pbm_info *pbm)
 		       SCHIZO_PCICTRL_SERR);
 	if (csr_error_bits) {
 		/* Clear the errors.  */
-		schizo_write(csr_reg, csr);
+		upa_writeq(csr, csr_reg);
 
 		/* Log 'em.  */
 		if (csr_error_bits & SCHIZO_PCICTRL_BUS_UNUS)
@@ -661,8 +643,8 @@ static irqreturn_t schizo_pcierr_intr(int irq, void *dev_id)
 	afar_reg = base + SCHIZO_PCI_AFAR;
 
 	/* Latch error status. */
-	afar = schizo_read(afar_reg);
-	afsr = schizo_read(afsr_reg);
+	afar = upa_readq(afar_reg);
+	afsr = upa_readq(afsr_reg);
 
 	/* Clear primary/secondary error status bits. */
 	error_bits = afsr &
@@ -674,7 +656,7 @@ static irqreturn_t schizo_pcierr_intr(int irq, void *dev_id)
 		 SCHIZO_PCIAFSR_STTO | SCHIZO_PCIAFSR_SUNUS);
 	if (!error_bits)
 		return schizo_pcierr_intr_other(pbm);
-	schizo_write(afsr_reg, error_bits);
+	upa_writeq(error_bits, afsr_reg);
 
 	/* Log the error. */
 	printk("%s: PCI Error, primary error type[%s]\n",
@@ -807,9 +789,9 @@ static irqreturn_t schizo_safarierr_intr(int irq, void *dev_id)
 	struct pci_pbm_info *pbm = dev_id;
 	u64 errlog;
 
-	errlog = schizo_read(pbm->controller_regs + SCHIZO_SAFARI_ERRLOG);
-	schizo_write(pbm->controller_regs + SCHIZO_SAFARI_ERRLOG,
-		     errlog & ~(SAFARI_ERRLOG_ERROUT));
+	errlog = upa_readq(pbm->controller_regs + SCHIZO_SAFARI_ERRLOG);
+	upa_writeq(errlog & ~(SAFARI_ERRLOG_ERROUT),
+		   pbm->controller_regs + SCHIZO_SAFARI_ERRLOG);
 
 	if (!(errlog & BUS_ERROR_UNMAP)) {
 		printk("%s: Unexpected Safari/JBUS error interrupt, errlog[%016lx]\n",
@@ -909,10 +891,9 @@ static void tomatillo_register_error_handlers(struct pci_pbm_info *pbm)
 	}
 
 	/* Enable UE and CE interrupts for controller. */
-	schizo_write(pbm->controller_regs + SCHIZO_ECC_CTRL,
-		     (SCHIZO_ECCCTRL_EE |
-		      SCHIZO_ECCCTRL_UE |
-		      SCHIZO_ECCCTRL_CE));
+	upa_writeq((SCHIZO_ECCCTRL_EE |
+		    SCHIZO_ECCCTRL_UE |
+		    SCHIZO_ECCCTRL_CE), pbm->controller_regs + SCHIZO_ECC_CTRL);
 
 	/* Enable PCI Error interrupts and clear error
 	 * bits.
@@ -925,10 +906,10 @@ static void tomatillo_register_error_handlers(struct pci_pbm_info *pbm)
 
 	err_no_mask = SCHIZO_PCICTRL_DTO_ERR;
 
-	tmp = schizo_read(pbm->pbm_regs + SCHIZO_PCI_CTRL);
+	tmp = upa_readq(pbm->pbm_regs + SCHIZO_PCI_CTRL);
 	tmp |= err_mask;
 	tmp &= ~err_no_mask;
-	schizo_write(pbm->pbm_regs + SCHIZO_PCI_CTRL, tmp);
+	upa_writeq(tmp, pbm->pbm_regs + SCHIZO_PCI_CTRL);
 
 	err_mask = (SCHIZO_PCIAFSR_PMA | SCHIZO_PCIAFSR_PTA |
 		    SCHIZO_PCIAFSR_PRTRY | SCHIZO_PCIAFSR_PPERR |
@@ -937,7 +918,7 @@ static void tomatillo_register_error_handlers(struct pci_pbm_info *pbm)
 		    SCHIZO_PCIAFSR_SRTRY | SCHIZO_PCIAFSR_SPERR |
 		    SCHIZO_PCIAFSR_STTO);
 
-	schizo_write(pbm->pbm_regs + SCHIZO_PCI_AFSR, err_mask);
+	upa_writeq(err_mask, pbm->pbm_regs + SCHIZO_PCI_AFSR);
 
 	err_mask = (BUS_ERROR_BADCMD | BUS_ERROR_SNOOP_GR |
 		    BUS_ERROR_SNOOP_PCI | BUS_ERROR_SNOOP_RD |
@@ -949,11 +930,11 @@ static void tomatillo_register_error_handlers(struct pci_pbm_info *pbm)
 		    BUS_ERROR_APERR | BUS_ERROR_UNMAP |
 		    BUS_ERROR_BUSERR | BUS_ERROR_TIMEOUT);
 
-	schizo_write(pbm->controller_regs + SCHIZO_SAFARI_ERRCTRL,
-		     (SCHIZO_SAFERRCTRL_EN | err_mask));
+	upa_writeq((SCHIZO_SAFERRCTRL_EN | err_mask),
+		   pbm->controller_regs + SCHIZO_SAFARI_ERRCTRL);
 
-	schizo_write(pbm->controller_regs + SCHIZO_SAFARI_IRQCTRL,
-		     (SCHIZO_SAFIRQCTRL_EN | (BUS_ERROR_UNMAP)));
+	upa_writeq((SCHIZO_SAFIRQCTRL_EN | (BUS_ERROR_UNMAP)),
+		   pbm->controller_regs + SCHIZO_SAFARI_IRQCTRL);
 }
 
 static void schizo_register_error_handlers(struct pci_pbm_info *pbm)
@@ -1005,10 +986,9 @@ static void schizo_register_error_handlers(struct pci_pbm_info *pbm)
 	}
 
 	/* Enable UE and CE interrupts for controller. */
-	schizo_write(pbm->controller_regs + SCHIZO_ECC_CTRL,
-		     (SCHIZO_ECCCTRL_EE |
-		      SCHIZO_ECCCTRL_UE |
-		      SCHIZO_ECCCTRL_CE));
+	upa_writeq((SCHIZO_ECCCTRL_EE |
+		    SCHIZO_ECCCTRL_UE |
+		    SCHIZO_ECCCTRL_CE), pbm->controller_regs + SCHIZO_ECC_CTRL);
 
 	err_mask = (SCHIZO_PCICTRL_BUS_UNUS |
 		    SCHIZO_PCICTRL_ESLCK |
@@ -1024,18 +1004,18 @@ static void schizo_register_error_handlers(struct pci_pbm_info *pbm)
 	/* Enable PCI Error interrupts and clear error
 	 * bits for each PBM.
 	 */
-	tmp = schizo_read(pbm->pbm_regs + SCHIZO_PCI_CTRL);
+	tmp = upa_readq(pbm->pbm_regs + SCHIZO_PCI_CTRL);
 	tmp |= err_mask;
 	tmp &= ~err_no_mask;
-	schizo_write(pbm->pbm_regs + SCHIZO_PCI_CTRL, tmp);
+	upa_writeq(tmp, pbm->pbm_regs + SCHIZO_PCI_CTRL);
 
-	schizo_write(pbm->pbm_regs + SCHIZO_PCI_AFSR,
-		     (SCHIZO_PCIAFSR_PMA | SCHIZO_PCIAFSR_PTA |
-		      SCHIZO_PCIAFSR_PRTRY | SCHIZO_PCIAFSR_PPERR |
-		      SCHIZO_PCIAFSR_PTTO | SCHIZO_PCIAFSR_PUNUS |
-		      SCHIZO_PCIAFSR_SMA | SCHIZO_PCIAFSR_STA |
-		      SCHIZO_PCIAFSR_SRTRY | SCHIZO_PCIAFSR_SPERR |
-		      SCHIZO_PCIAFSR_STTO | SCHIZO_PCIAFSR_SUNUS));
+	upa_writeq((SCHIZO_PCIAFSR_PMA | SCHIZO_PCIAFSR_PTA |
+		    SCHIZO_PCIAFSR_PRTRY | SCHIZO_PCIAFSR_PPERR |
+		    SCHIZO_PCIAFSR_PTTO | SCHIZO_PCIAFSR_PUNUS |
+		    SCHIZO_PCIAFSR_SMA | SCHIZO_PCIAFSR_STA |
+		    SCHIZO_PCIAFSR_SRTRY | SCHIZO_PCIAFSR_SPERR |
+		    SCHIZO_PCIAFSR_STTO | SCHIZO_PCIAFSR_SUNUS),
+		   pbm->pbm_regs + SCHIZO_PCI_AFSR);
 
 	/* Make all Safari error conditions fatal except unmapped
 	 * errors which we make generate interrupts.
@@ -1062,8 +1042,8 @@ static void schizo_register_error_handlers(struct pci_pbm_info *pbm)
 		      BUS_ERROR_CPU0PS | BUS_ERROR_CPU0PB);
 #endif
 
-	schizo_write(pbm->controller_regs + SCHIZO_SAFARI_ERRCTRL,
-		     (SCHIZO_SAFERRCTRL_EN | err_mask));
+	upa_writeq((SCHIZO_SAFERRCTRL_EN | err_mask),
+		   pbm->controller_regs + SCHIZO_SAFARI_ERRCTRL);
 }
 
 static void pbm_config_busmastering(struct pci_pbm_info *pbm)
@@ -1133,12 +1113,12 @@ static void schizo_pbm_strbuf_init(struct pci_pbm_info *pbm)
 	 * streaming buffer and leave the rerun-disable
 	 * setting however OBP set it.
 	 */
-	control = schizo_read(pbm->stc.strbuf_control);
+	control = upa_readq(pbm->stc.strbuf_control);
 	control &= ~(SCHIZO_STRBUF_CTRL_LPTR |
 		     SCHIZO_STRBUF_CTRL_LENAB |
 		     SCHIZO_STRBUF_CTRL_DENAB);
 	control |= SCHIZO_STRBUF_CTRL_ENAB;
-	schizo_write(pbm->stc.strbuf_control, control);
+	upa_writeq(control, pbm->stc.strbuf_control);
 
 	pbm->stc.strbuf_enabled = 1;
 }
@@ -1199,15 +1179,15 @@ static int schizo_pbm_iommu_init(struct pci_pbm_info *pbm)
 	/*
 	 * Invalidate TLB Entries.
 	 */
-	control = schizo_read(iommu->iommu_control);
+	control = upa_readq(iommu->iommu_control);
 	control |= SCHIZO_IOMMU_CTRL_DENAB;
-	schizo_write(iommu->iommu_control, control);
+	upa_writeq(control, iommu->iommu_control);
 
 	tagbase = SCHIZO_IOMMU_TAG, database = SCHIZO_IOMMU_DATA;
 
 	for (i = 0; i < 16; i++) {
-		schizo_write(pbm->pbm_regs + tagbase + (i * 8UL), 0);
-		schizo_write(pbm->pbm_regs + database + (i * 8UL), 0);
+		upa_writeq(0, pbm->pbm_regs + tagbase + (i * 8UL));
+		upa_writeq(0, pbm->pbm_regs + database + (i * 8UL));
 	}
 
 	/* Leave diag mode enabled for full-flushing done
@@ -1220,9 +1200,9 @@ static int schizo_pbm_iommu_init(struct pci_pbm_info *pbm)
 		return err;
 	}
 
-	schizo_write(iommu->iommu_tsbbase, __pa(iommu->page_table));
+	upa_writeq(__pa(iommu->page_table), iommu->iommu_tsbbase);
 
-	control = schizo_read(iommu->iommu_control);
+	control = upa_readq(iommu->iommu_control);
 	control &= ~(SCHIZO_IOMMU_CTRL_TSBSZ | SCHIZO_IOMMU_CTRL_TBWSZ);
 	switch (tsbsize) {
 	case 64:
@@ -1234,7 +1214,7 @@ static int schizo_pbm_iommu_init(struct pci_pbm_info *pbm)
 	}
 
 	control |= SCHIZO_IOMMU_CTRL_ENAB;
-	schizo_write(iommu->iommu_control, control);
+	upa_writeq(control, iommu->iommu_control);
 
 	return 0;
 }
@@ -1277,9 +1257,9 @@ static void schizo_pbm_hw_init(struct pci_pbm_info *pbm)
 {
 	u64 tmp;
 
-	schizo_write(pbm->pbm_regs + SCHIZO_PCI_IRQ_RETRY, 5);
+	upa_writeq(5, pbm->pbm_regs + SCHIZO_PCI_IRQ_RETRY);
 
-	tmp = schizo_read(pbm->pbm_regs + SCHIZO_PCI_CTRL);
+	tmp = upa_readq(pbm->pbm_regs + SCHIZO_PCI_CTRL);
 
 	/* Enable arbiter for all PCI slots.  */
 	tmp |= 0xff;
@@ -1304,13 +1284,13 @@ static void schizo_pbm_hw_init(struct pci_pbm_info *pbm)
 			SCHIZO_PCICTRL_RDO_PREF |
 			SCHIZO_PCICTRL_RDL_PREF);
 
-	schizo_write(pbm->pbm_regs + SCHIZO_PCI_CTRL, tmp);
+	upa_writeq(tmp, pbm->pbm_regs + SCHIZO_PCI_CTRL);
 
-	tmp = schizo_read(pbm->pbm_regs + SCHIZO_PCI_DIAG);
+	tmp = upa_readq(pbm->pbm_regs + SCHIZO_PCI_DIAG);
 	tmp &= ~(SCHIZO_PCIDIAG_D_RTRYARB |
 		 SCHIZO_PCIDIAG_D_RETRY |
 		 SCHIZO_PCIDIAG_D_INTSYNC);
-	schizo_write(pbm->pbm_regs + SCHIZO_PCI_DIAG, tmp);
+	upa_writeq(tmp, pbm->pbm_regs + SCHIZO_PCI_DIAG);
 
 	if (pbm->chip_type = PBM_CHIP_TYPE_TOMATILLO) {
 		/* Clear prefetch lengths to workaround a bug in
@@ -1322,8 +1302,7 @@ static void schizo_pbm_hw_init(struct pci_pbm_info *pbm)
 		       TOMATILLO_IOC_RDONE_CPENAB |
 		       TOMATILLO_IOC_RDLINE_CPENAB);
 
-		schizo_write(pbm->pbm_regs + TOMATILLO_PCI_IOC_CSR,
-			     tmp);
+		upa_writeq(tmp, pbm->pbm_regs + TOMATILLO_PCI_IOC_CSR);
 	}
 }
 
-- 
1.5.6.5.GIT

