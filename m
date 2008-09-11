From: David Miller <davem@davemloft.net>
Date: Thu, 11 Sep 2008 06:14:37 +0000
Subject: [PATCH 3/3]: sparc64: Commonize large portions of PSYCHO error
Message-Id: <20080910.231437.121743756.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc64: Commonize large portions of PSYCHO error handling.

The IOMMU and streaming cache error interrogation is moved here
as well as the PCI error interrupt handler.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc64/kernel/pci_psycho.c    |  361 -----------------------------------
 arch/sparc64/kernel/pci_sabre.c     |  223 +---------------------
 arch/sparc64/kernel/psycho_common.c |  353 ++++++++++++++++++++++++++++++++++
 arch/sparc64/kernel/psycho_common.h |   11 +
 4 files changed, 369 insertions(+), 579 deletions(-)

diff --git a/arch/sparc64/kernel/pci_psycho.c b/arch/sparc64/kernel/pci_psycho.c
index 2de51fb..bac9c1b 100644
--- a/arch/sparc64/kernel/pci_psycho.c
+++ b/arch/sparc64/kernel/pci_psycho.c
@@ -98,9 +98,6 @@ static void *psycho_pci_config_mkaddr(struct pci_pbm_info *pbm,
 }
 
 /* PSYCHO error handling support. */
-enum psycho_error_type {
-	UE_ERR, CE_ERR, PCI_ERR
-};
 
 /* Helper function of IOMMU error checking, which checks out
  * the state of the streaming buffers.  The IOMMU lock is
@@ -125,112 +122,10 @@ enum psycho_error_type {
 #define PSYCHO_STC_DATA_B	0xc000UL
 #define PSYCHO_STC_ERR_A	0xb400UL
 #define PSYCHO_STC_ERR_B	0xc400UL
-#define  PSYCHO_STCERR_WRITE	 0x0000000000000002UL	/* Write Error */
-#define  PSYCHO_STCERR_READ	 0x0000000000000001UL	/* Read Error */
 #define PSYCHO_STC_TAG_A	0xb800UL
 #define PSYCHO_STC_TAG_B	0xc800UL
-#define  PSYCHO_STCTAG_PPN	 0x0fffffff00000000UL	/* Physical Page Number */
-#define  PSYCHO_STCTAG_VPN	 0x00000000ffffe000UL	/* Virtual Page Number */
-#define  PSYCHO_STCTAG_VALID	 0x0000000000000002UL	/* Valid */
-#define  PSYCHO_STCTAG_WRITE	 0x0000000000000001UL	/* Writable */
 #define PSYCHO_STC_LINE_A	0xb900UL
 #define PSYCHO_STC_LINE_B	0xc900UL
-#define  PSYCHO_STCLINE_LINDX	 0x0000000001e00000UL	/* LRU Index */
-#define  PSYCHO_STCLINE_SPTR	 0x00000000001f8000UL	/* Dirty Data Start Pointer */
-#define  PSYCHO_STCLINE_LADDR	 0x0000000000007f00UL	/* Line Address */
-#define  PSYCHO_STCLINE_EPTR	 0x00000000000000fcUL	/* Dirty Data End Pointer */
-#define  PSYCHO_STCLINE_VALID	 0x0000000000000002UL	/* Valid */
-#define  PSYCHO_STCLINE_FOFN	 0x0000000000000001UL	/* Fetch Outstanding / Flush Necessary */
-
-static DEFINE_SPINLOCK(stc_buf_lock);
-static unsigned long stc_error_buf[128];
-static unsigned long stc_tag_buf[16];
-static unsigned long stc_line_buf[16];
-
-static void psycho_check_stc_error(struct pci_pbm_info *pbm)
-{
-	struct strbuf *strbuf = &pbm->stc;
-	unsigned long err_base, tag_base, line_base;
-	u64 control;
-	int i;
-
-	err_base = strbuf->strbuf_err_stat;
-	tag_base = strbuf->strbuf_tag_diag;
-	line_base = strbuf->strbuf_line_diag;
-
-	spin_lock(&stc_buf_lock);
-
-	/* This is __REALLY__ dangerous.  When we put the
-	 * streaming buffer into diagnostic mode to probe
-	 * it's tags and error status, we _must_ clear all
-	 * of the line tag valid bits before re-enabling
-	 * the streaming buffer.  If any dirty data lives
-	 * in the STC when we do this, we will end up
-	 * invalidating it before it has a chance to reach
-	 * main memory.
-	 */
-	control = psycho_read(strbuf->strbuf_control);
-	psycho_write(strbuf->strbuf_control,
-		     (control | PSYCHO_STRBUF_CTRL_DENAB));
-	for (i = 0; i < 128; i++) {
-		unsigned long val;
-
-		val = psycho_read(err_base + (i * 8UL));
-		psycho_write(err_base + (i * 8UL), 0UL);
-		stc_error_buf[i] = val;
-	}
-	for (i = 0; i < 16; i++) {
-		stc_tag_buf[i] = psycho_read(tag_base + (i * 8UL));
-		stc_line_buf[i] = psycho_read(line_base + (i * 8UL));
-		psycho_write(tag_base + (i * 8UL), 0UL);
-		psycho_write(line_base + (i * 8UL), 0UL);
-	}
-
-	/* OK, state is logged, exit diagnostic mode. */
-	psycho_write(strbuf->strbuf_control, control);
-
-	for (i = 0; i < 16; i++) {
-		int j, saw_error, first, last;
-
-		saw_error = 0;
-		first = i * 8;
-		last = first + 8;
-		for (j = first; j < last; j++) {
-			unsigned long errval = stc_error_buf[j];
-			if (errval != 0) {
-				saw_error++;
-				printk("%s: STC_ERR(%d)[wr(%d)rd(%d)]\n",
-				       pbm->name,
-				       j,
-				       (errval & PSYCHO_STCERR_WRITE) ? 1 : 0,
-				       (errval & PSYCHO_STCERR_READ) ? 1 : 0);
-			}
-		}
-		if (saw_error != 0) {
-			unsigned long tagval = stc_tag_buf[i];
-			unsigned long lineval = stc_line_buf[i];
-			printk("%s: STC_TAG(%d)[PA(%016lx)VA(%08lx)V(%d)W(%d)]\n",
-			       pbm->name,
-			       i,
-			       ((tagval & PSYCHO_STCTAG_PPN) >> 19UL),
-			       (tagval & PSYCHO_STCTAG_VPN),
-			       ((tagval & PSYCHO_STCTAG_VALID) ? 1 : 0),
-			       ((tagval & PSYCHO_STCTAG_WRITE) ? 1 : 0));
-			printk("%s: STC_LINE(%d)[LIDX(%lx)SP(%lx)LADDR(%lx)EP(%lx)"
-			       "V(%d)FOFN(%d)]\n",
-			       pbm->name,
-			       i,
-			       ((lineval & PSYCHO_STCLINE_LINDX) >> 21UL),
-			       ((lineval & PSYCHO_STCLINE_SPTR) >> 15UL),
-			       ((lineval & PSYCHO_STCLINE_LADDR) >> 8UL),
-			       ((lineval & PSYCHO_STCLINE_EPTR) >> 2UL),
-			       ((lineval & PSYCHO_STCLINE_VALID) ? 1 : 0),
-			       ((lineval & PSYCHO_STCLINE_FOFN) ? 1 : 0));
-		}
-	}
-
-	spin_unlock(&stc_buf_lock);
-}
 
 /* When an Uncorrectable Error or a PCI Error happens, we
  * interrogate the IOMMU state to see if it is the cause.
@@ -257,122 +152,7 @@ static void psycho_check_stc_error(struct pci_pbm_info *pbm)
 #define PSYCHO_IOMMU_TSBBASE	0x0208UL
 #define PSYCHO_IOMMU_FLUSH	0x0210UL
 #define PSYCHO_IOMMU_TAG	0xa580UL
-#define  PSYCHO_IOMMU_TAG_ERRSTS (0x3UL << 23UL)
-#define  PSYCHO_IOMMU_TAG_ERR	 (0x1UL << 22UL)
-#define  PSYCHO_IOMMU_TAG_WRITE	 (0x1UL << 21UL)
-#define  PSYCHO_IOMMU_TAG_STREAM (0x1UL << 20UL)
-#define  PSYCHO_IOMMU_TAG_SIZE	 (0x1UL << 19UL)
-#define  PSYCHO_IOMMU_TAG_VPAGE	 0x7ffffUL
 #define PSYCHO_IOMMU_DATA	0xa600UL
-#define  PSYCHO_IOMMU_DATA_VALID (1UL << 30UL)
-#define  PSYCHO_IOMMU_DATA_CACHE (1UL << 28UL)
-#define  PSYCHO_IOMMU_DATA_PPAGE 0xfffffffUL
-static void psycho_check_iommu_error(struct pci_pbm_info *pbm,
-				     unsigned long afsr,
-				     unsigned long afar,
-				     enum psycho_error_type type)
-{
-	struct iommu *iommu = pbm->iommu;
-	unsigned long iommu_tag[16];
-	unsigned long iommu_data[16];
-	unsigned long flags;
-	u64 control;
-	int i;
-
-	spin_lock_irqsave(&iommu->lock, flags);
-	control = psycho_read(iommu->iommu_control);
-	if (control & PSYCHO_IOMMU_CTRL_XLTEERR) {
-		char *type_string;
-
-		/* Clear the error encountered bit. */
-		control &= ~PSYCHO_IOMMU_CTRL_XLTEERR;
-		psycho_write(iommu->iommu_control, control);
-
-		switch((control & PSYCHO_IOMMU_CTRL_XLTESTAT) >> 25UL) {
-		case 0:
-			type_string = "Protection Error";
-			break;
-		case 1:
-			type_string = "Invalid Error";
-			break;
-		case 2:
-			type_string = "TimeOut Error";
-			break;
-		case 3:
-		default:
-			type_string = "ECC Error";
-			break;
-		};
-		printk("%s: IOMMU Error, type[%s]\n",
-		       pbm->name, type_string);
-
-		/* Put the IOMMU into diagnostic mode and probe
-		 * it's TLB for entries with error status.
-		 *
-		 * It is very possible for another DVMA to occur
-		 * while we do this probe, and corrupt the system
-		 * further.  But we are so screwed at this point
-		 * that we are likely to crash hard anyways, so
-		 * get as much diagnostic information to the
-		 * console as we can.
-		 */
-		psycho_write(iommu->iommu_control,
-			     control | PSYCHO_IOMMU_CTRL_DENAB);
-		for (i = 0; i < 16; i++) {
-			unsigned long base = pbm->controller_regs;
-
-			iommu_tag[i] -				psycho_read(base + PSYCHO_IOMMU_TAG + (i * 8UL));
-			iommu_data[i] -				psycho_read(base + PSYCHO_IOMMU_DATA + (i * 8UL));
-
-			/* Now clear out the entry. */
-			psycho_write(base + PSYCHO_IOMMU_TAG + (i * 8UL), 0);
-			psycho_write(base + PSYCHO_IOMMU_DATA + (i * 8UL), 0);
-		}
-
-		/* Leave diagnostic mode. */
-		psycho_write(iommu->iommu_control, control);
-
-		for (i = 0; i < 16; i++) {
-			unsigned long tag, data;
-
-			tag = iommu_tag[i];
-			if (!(tag & PSYCHO_IOMMU_TAG_ERR))
-				continue;
-
-			data = iommu_data[i];
-			switch((tag & PSYCHO_IOMMU_TAG_ERRSTS) >> 23UL) {
-			case 0:
-				type_string = "Protection Error";
-				break;
-			case 1:
-				type_string = "Invalid Error";
-				break;
-			case 2:
-				type_string = "TimeOut Error";
-				break;
-			case 3:
-			default:
-				type_string = "ECC Error";
-				break;
-			};
-			printk("%s: IOMMU TAG(%d)[error(%s) wr(%d) str(%d) sz(%dK) vpg(%08lx)]\n",
-			       pbm->name, i, type_string,
-			       ((tag & PSYCHO_IOMMU_TAG_WRITE) ? 1 : 0),
-			       ((tag & PSYCHO_IOMMU_TAG_STREAM) ? 1 : 0),
-			       ((tag & PSYCHO_IOMMU_TAG_SIZE) ? 64 : 8),
-			       (tag & PSYCHO_IOMMU_TAG_VPAGE) << IOMMU_PAGE_SHIFT);
-			printk("%s: IOMMU DATA(%d)[valid(%d) cache(%d) ppg(%016lx)]\n",
-			       pbm->name, i,
-			       ((data & PSYCHO_IOMMU_DATA_VALID) ? 1 : 0),
-			       ((data & PSYCHO_IOMMU_DATA_CACHE) ? 1 : 0),
-			       (data & PSYCHO_IOMMU_DATA_PPAGE) << IOMMU_PAGE_SHIFT);
-		}
-	}
-	psycho_check_stc_error(pbm);
-	spin_unlock_irqrestore(&iommu->lock, flags);
-}
 
 /* Uncorrectable Errors.  Cause of the error and the address are
  * recorded in the UE_AFSR and UE_AFAR of PSYCHO.  They are errors
@@ -540,150 +320,9 @@ static irqreturn_t psycho_ce_intr(int irq, void *dev_id)
  */
 #define PSYCHO_PCI_AFSR_A	0x2010UL
 #define PSYCHO_PCI_AFSR_B	0x4010UL
-#define  PSYCHO_PCIAFSR_PMA	0x8000000000000000UL /* Primary Master Abort Error   */
-#define  PSYCHO_PCIAFSR_PTA	0x4000000000000000UL /* Primary Target Abort Error   */
-#define  PSYCHO_PCIAFSR_PRTRY	0x2000000000000000UL /* Primary Excessive Retries    */
-#define  PSYCHO_PCIAFSR_PPERR	0x1000000000000000UL /* Primary Parity Error         */
-#define  PSYCHO_PCIAFSR_SMA	0x0800000000000000UL /* Secondary Master Abort Error */
-#define  PSYCHO_PCIAFSR_STA	0x0400000000000000UL /* Secondary Target Abort Error */
-#define  PSYCHO_PCIAFSR_SRTRY	0x0200000000000000UL /* Secondary Excessive Retries  */
-#define  PSYCHO_PCIAFSR_SPERR	0x0100000000000000UL /* Secondary Parity Error       */
-#define  PSYCHO_PCIAFSR_RESV1	0x00ff000000000000UL /* Reserved                     */
-#define  PSYCHO_PCIAFSR_BMSK	0x0000ffff00000000UL /* Bytemask of failed transfer  */
-#define  PSYCHO_PCIAFSR_BLK	0x0000000080000000UL /* Trans was block operation    */
-#define  PSYCHO_PCIAFSR_RESV2	0x0000000040000000UL /* Reserved                     */
-#define  PSYCHO_PCIAFSR_MID	0x000000003e000000UL /* MID causing the error        */
-#define  PSYCHO_PCIAFSR_RESV3	0x0000000001ffffffUL /* Reserved                     */
 #define PSYCHO_PCI_AFAR_A	0x2018UL
 #define PSYCHO_PCI_AFAR_B	0x4018UL
 
-static irqreturn_t psycho_pcierr_intr_other(struct pci_pbm_info *pbm)
-{
-	unsigned long csr, csr_error_bits;
-	irqreturn_t ret = IRQ_NONE;
-	u16 stat;
-
-	csr = psycho_read(pbm->pci_csr);
-	csr_error_bits -		csr & (PSYCHO_PCICTRL_SBH_ERR | PSYCHO_PCICTRL_SERR);
-	if (csr_error_bits) {
-		/* Clear the errors.  */
-		psycho_write(pbm->pci_csr, csr);
-
-		/* Log 'em.  */
-		if (csr_error_bits & PSYCHO_PCICTRL_SBH_ERR)
-			printk("%s: PCI streaming byte hole error asserted.\n",
-			       pbm->name);
-		if (csr_error_bits & PSYCHO_PCICTRL_SERR)
-			printk("%s: PCI SERR signal asserted.\n", pbm->name);
-		ret = IRQ_HANDLED;
-	}
-	pci_read_config_word(pbm->pci_bus->self, PCI_STATUS, &stat);
-	if (stat & (PCI_STATUS_PARITY |
-		    PCI_STATUS_SIG_TARGET_ABORT |
-		    PCI_STATUS_REC_TARGET_ABORT |
-		    PCI_STATUS_REC_MASTER_ABORT |
-		    PCI_STATUS_SIG_SYSTEM_ERROR)) {
-		printk("%s: PCI bus error, PCI_STATUS[%04x]\n",
-		       pbm->name, stat);
-		pci_write_config_word(pbm->pci_bus->self, PCI_STATUS, 0xffff);
-		ret = IRQ_HANDLED;
-	}
-	return ret;
-}
-
-static irqreturn_t psycho_pcierr_intr(int irq, void *dev_id)
-{
-	struct pci_pbm_info *pbm = dev_id;
-	unsigned long afsr_reg, afar_reg;
-	unsigned long afsr, afar, error_bits;
-	int reported;
-
-	afsr_reg = pbm->pci_afsr;
-	afar_reg = pbm->pci_afar;
-
-	/* Latch error status. */
-	afar = psycho_read(afar_reg);
-	afsr = psycho_read(afsr_reg);
-
-	/* Clear primary/secondary error status bits. */
-	error_bits = afsr &
-		(PSYCHO_PCIAFSR_PMA | PSYCHO_PCIAFSR_PTA |
-		 PSYCHO_PCIAFSR_PRTRY | PSYCHO_PCIAFSR_PPERR |
-		 PSYCHO_PCIAFSR_SMA | PSYCHO_PCIAFSR_STA |
-		 PSYCHO_PCIAFSR_SRTRY | PSYCHO_PCIAFSR_SPERR);
-	if (!error_bits)
-		return psycho_pcierr_intr_other(pbm);
-	psycho_write(afsr_reg, error_bits);
-
-	/* Log the error. */
-	printk("%s: PCI Error, primary error type[%s]\n",
-	       pbm->name,
-	       (((error_bits & PSYCHO_PCIAFSR_PMA) ?
-		 "Master Abort" :
-		 ((error_bits & PSYCHO_PCIAFSR_PTA) ?
-		  "Target Abort" :
-		  ((error_bits & PSYCHO_PCIAFSR_PRTRY) ?
-		   "Excessive Retries" :
-		   ((error_bits & PSYCHO_PCIAFSR_PPERR) ?
-		    "Parity Error" : "???"))))));
-	printk("%s: bytemask[%04lx] UPA_MID[%02lx] was_block(%d)\n",
-	       pbm->name,
-	       (afsr & PSYCHO_PCIAFSR_BMSK) >> 32UL,
-	       (afsr & PSYCHO_PCIAFSR_MID) >> 25UL,
-	       (afsr & PSYCHO_PCIAFSR_BLK) ? 1 : 0);
-	printk("%s: PCI AFAR [%016lx]\n", pbm->name, afar);
-	printk("%s: PCI Secondary errors [", pbm->name);
-	reported = 0;
-	if (afsr & PSYCHO_PCIAFSR_SMA) {
-		reported++;
-		printk("(Master Abort)");
-	}
-	if (afsr & PSYCHO_PCIAFSR_STA) {
-		reported++;
-		printk("(Target Abort)");
-	}
-	if (afsr & PSYCHO_PCIAFSR_SRTRY) {
-		reported++;
-		printk("(Excessive Retries)");
-	}
-	if (afsr & PSYCHO_PCIAFSR_SPERR) {
-		reported++;
-		printk("(Parity Error)");
-	}
-	if (!reported)
-		printk("(none)");
-	printk("]\n");
-
-	/* For the error types shown, scan PBM's PCI bus for devices
-	 * which have logged that error type.
-	 */
-
-	/* If we see a Target Abort, this could be the result of an
-	 * IOMMU translation error of some sort.  It is extremely
-	 * useful to log this information as usually it indicates
-	 * a bug in the IOMMU support code or a PCI device driver.
-	 */
-	if (error_bits & (PSYCHO_PCIAFSR_PTA | PSYCHO_PCIAFSR_STA)) {
-		psycho_check_iommu_error(pbm, afsr, afar, PCI_ERR);
-		pci_scan_for_target_abort(pbm, pbm->pci_bus);
-	}
-	if (error_bits & (PSYCHO_PCIAFSR_PMA | PSYCHO_PCIAFSR_SMA))
-		pci_scan_for_master_abort(pbm, pbm->pci_bus);
-
-	/* For excessive retries, PSYCHO/PBM will abort the device
-	 * and there is no way to specifically check for excessive
-	 * retries in the config space status registers.  So what
-	 * we hope is that we'll catch it via the master/target
-	 * abort events.
-	 */
-
-	if (error_bits & (PSYCHO_PCIAFSR_PPERR | PSYCHO_PCIAFSR_SPERR))
-		pci_scan_for_parity_error(pbm, pbm->pci_bus);
-
-	return IRQ_HANDLED;
-}
-
 /* XXX What about PowerFail/PowerManagement??? -DaveM */
 #define PSYCHO_ECC_CTRL		0x0020
 #define  PSYCHO_ECCCTRL_EE	 0x8000000000000000UL /* Enable ECC Checking */
diff --git a/arch/sparc64/kernel/pci_sabre.c b/arch/sparc64/kernel/pci_sabre.c
index ae11d67..f8089aa 100644
--- a/arch/sparc64/kernel/pci_sabre.c
+++ b/arch/sparc64/kernel/pci_sabre.c
@@ -210,95 +210,6 @@
 static int hummingbird_p;
 static struct pci_bus *sabre_root_bus;
 
-/* SABRE error handling support. */
-static void sabre_check_iommu_error(struct pci_pbm_info *pbm,
-				    unsigned long afsr,
-				    unsigned long afar)
-{
-	struct iommu *iommu = pbm->iommu;
-	unsigned long iommu_tag[16];
-	unsigned long iommu_data[16];
-	unsigned long flags;
-	u64 control;
-	int i;
-
-	spin_lock_irqsave(&iommu->lock, flags);
-	control = sabre_read(iommu->iommu_control);
-	if (control & SABRE_IOMMUCTRL_ERR) {
-		char *type_string;
-
-		/* Clear the error encountered bit.
-		 * NOTE: On Sabre this is write 1 to clear,
-		 *       which is different from Psycho.
-		 */
-		sabre_write(iommu->iommu_control, control);
-		switch((control & SABRE_IOMMUCTRL_ERRSTS) >> 25UL) {
-		case 1:
-			type_string = "Invalid Error";
-			break;
-		case 3:
-			type_string = "ECC Error";
-			break;
-		default:
-			type_string = "Unknown";
-			break;
-		};
-		printk("%s: IOMMU Error, type[%s]\n",
-		       pbm->name, type_string);
-
-		/* Enter diagnostic mode and probe for error'd
-		 * entries in the IOTLB.
-		 */
-		control &= ~(SABRE_IOMMUCTRL_ERRSTS | SABRE_IOMMUCTRL_ERR);
-		sabre_write(iommu->iommu_control,
-			    (control | SABRE_IOMMUCTRL_DENAB));
-		for (i = 0; i < 16; i++) {
-			unsigned long base = pbm->controller_regs;
-
-			iommu_tag[i] -				sabre_read(base + SABRE_IOMMU_TAG + (i * 8UL));
-			iommu_data[i] -				sabre_read(base + SABRE_IOMMU_DATA + (i * 8UL));
-			sabre_write(base + SABRE_IOMMU_TAG + (i * 8UL), 0);
-			sabre_write(base + SABRE_IOMMU_DATA + (i * 8UL), 0);
-		}
-		sabre_write(iommu->iommu_control, control);
-
-		for (i = 0; i < 16; i++) {
-			unsigned long tag, data;
-
-			tag = iommu_tag[i];
-			if (!(tag & SABRE_IOMMUTAG_ERR))
-				continue;
-
-			data = iommu_data[i];
-			switch((tag & SABRE_IOMMUTAG_ERRSTS) >> 23UL) {
-			case 1:
-				type_string = "Invalid Error";
-				break;
-			case 3:
-				type_string = "ECC Error";
-				break;
-			default:
-				type_string = "Unknown";
-				break;
-			};
-			printk("%s: IOMMU TAG(%d)[RAW(%016lx)error(%s)wr(%d)sz(%dK)vpg(%08lx)]\n",
-			       pbm->name, i, tag, type_string,
-			       ((tag & SABRE_IOMMUTAG_WRITE) ? 1 : 0),
-			       ((tag & SABRE_IOMMUTAG_SIZE) ? 64 : 8),
-			       ((tag & SABRE_IOMMUTAG_VPN) << IOMMU_PAGE_SHIFT));
-			printk("%s: IOMMU DATA(%d)[RAW(%016lx)valid(%d)used(%d)cache(%d)ppg(%016lx)\n",
-			       pbm->name, i, data,
-			       ((data & SABRE_IOMMUDATA_VALID) ? 1 : 0),
-			       ((data & SABRE_IOMMUDATA_USED) ? 1 : 0),
-			       ((data & SABRE_IOMMUDATA_CACHE) ? 1 : 0),
-			       ((data & SABRE_IOMMUDATA_PPN) << IOMMU_PAGE_SHIFT));
-		}
-	}
-	spin_unlock_irqrestore(&iommu->lock, flags);
-}
-
 static irqreturn_t sabre_ue_intr(int irq, void *dev_id)
 {
 	struct pci_pbm_info *pbm = dev_id;
@@ -354,7 +265,7 @@ static irqreturn_t sabre_ue_intr(int irq, void *dev_id)
 	printk("]\n");
 
 	/* Interrogate IOMMU for error status. */
-	sabre_check_iommu_error(pbm, afsr, afar);
+	psycho_check_iommu_error(pbm, afsr, afar, UE_ERR);
 
 	return IRQ_HANDLED;
 }
@@ -415,133 +326,6 @@ static irqreturn_t sabre_ce_intr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t sabre_pcierr_intr_other(struct pci_pbm_info *pbm)
-{
-	unsigned long csr_reg, csr, csr_error_bits;
-	irqreturn_t ret = IRQ_NONE;
-	u16 stat;
-
-	csr_reg = pbm->controller_regs + SABRE_PCICTRL;
-	csr = sabre_read(csr_reg);
-	csr_error_bits -		csr & SABRE_PCICTRL_SERR;
-	if (csr_error_bits) {
-		/* Clear the errors.  */
-		sabre_write(csr_reg, csr);
-
-		/* Log 'em.  */
-		if (csr_error_bits & SABRE_PCICTRL_SERR)
-			printk("%s: PCI SERR signal asserted.\n",
-			       pbm->name);
-		ret = IRQ_HANDLED;
-	}
-	pci_bus_read_config_word(sabre_root_bus, 0,
-				 PCI_STATUS, &stat);
-	if (stat & (PCI_STATUS_PARITY |
-		    PCI_STATUS_SIG_TARGET_ABORT |
-		    PCI_STATUS_REC_TARGET_ABORT |
-		    PCI_STATUS_REC_MASTER_ABORT |
-		    PCI_STATUS_SIG_SYSTEM_ERROR)) {
-		printk("%s: PCI bus error, PCI_STATUS[%04x]\n",
-		       pbm->name, stat);
-		pci_bus_write_config_word(sabre_root_bus, 0,
-					  PCI_STATUS, 0xffff);
-		ret = IRQ_HANDLED;
-	}
-	return ret;
-}
-
-static irqreturn_t sabre_pcierr_intr(int irq, void *dev_id)
-{
-	struct pci_pbm_info *pbm = dev_id;
-	unsigned long afsr_reg, afar_reg;
-	unsigned long afsr, afar, error_bits;
-	int reported;
-
-	afsr_reg = pbm->controller_regs + SABRE_PIOAFSR;
-	afar_reg = pbm->controller_regs + SABRE_PIOAFAR;
-
-	/* Latch error status. */
-	afar = sabre_read(afar_reg);
-	afsr = sabre_read(afsr_reg);
-
-	/* Clear primary/secondary error status bits. */
-	error_bits = afsr &
-		(SABRE_PIOAFSR_PMA | SABRE_PIOAFSR_PTA |
-		 SABRE_PIOAFSR_PRTRY | SABRE_PIOAFSR_PPERR |
-		 SABRE_PIOAFSR_SMA | SABRE_PIOAFSR_STA |
-		 SABRE_PIOAFSR_SRTRY | SABRE_PIOAFSR_SPERR);
-	if (!error_bits)
-		return sabre_pcierr_intr_other(pbm);
-	sabre_write(afsr_reg, error_bits);
-
-	/* Log the error. */
-	printk("%s: PCI Error, primary error type[%s]\n",
-	       pbm->name,
-	       (((error_bits & SABRE_PIOAFSR_PMA) ?
-		 "Master Abort" :
-		 ((error_bits & SABRE_PIOAFSR_PTA) ?
-		  "Target Abort" :
-		  ((error_bits & SABRE_PIOAFSR_PRTRY) ?
-		   "Excessive Retries" :
-		   ((error_bits & SABRE_PIOAFSR_PPERR) ?
-		    "Parity Error" : "???"))))));
-	printk("%s: bytemask[%04lx] was_block(%d)\n",
-	       pbm->name,
-	       (afsr & SABRE_PIOAFSR_BMSK) >> 32UL,
-	       (afsr & SABRE_PIOAFSR_BLK) ? 1 : 0);
-	printk("%s: PCI AFAR [%016lx]\n", pbm->name, afar);
-	printk("%s: PCI Secondary errors [", pbm->name);
-	reported = 0;
-	if (afsr & SABRE_PIOAFSR_SMA) {
-		reported++;
-		printk("(Master Abort)");
-	}
-	if (afsr & SABRE_PIOAFSR_STA) {
-		reported++;
-		printk("(Target Abort)");
-	}
-	if (afsr & SABRE_PIOAFSR_SRTRY) {
-		reported++;
-		printk("(Excessive Retries)");
-	}
-	if (afsr & SABRE_PIOAFSR_SPERR) {
-		reported++;
-		printk("(Parity Error)");
-	}
-	if (!reported)
-		printk("(none)");
-	printk("]\n");
-
-	/* For the error types shown, scan both PCI buses for devices
-	 * which have logged that error type.
-	 */
-
-	/* If we see a Target Abort, this could be the result of an
-	 * IOMMU translation error of some sort.  It is extremely
-	 * useful to log this information as usually it indicates
-	 * a bug in the IOMMU support code or a PCI device driver.
-	 */
-	if (error_bits & (SABRE_PIOAFSR_PTA | SABRE_PIOAFSR_STA)) {
-		sabre_check_iommu_error(pbm, afsr, afar);
-		pci_scan_for_target_abort(pbm, pbm->pci_bus);
-	}
-	if (error_bits & (SABRE_PIOAFSR_PMA | SABRE_PIOAFSR_SMA))
-		pci_scan_for_master_abort(pbm, pbm->pci_bus);
-
-	/* For excessive retries, SABRE/PBM will abort the device
-	 * and there is no way to specifically check for excessive
-	 * retries in the config space status registers.  So what
-	 * we hope is that we'll catch it via the master/target
-	 * abort events.
-	 */
-
-	if (error_bits & (SABRE_PIOAFSR_PPERR | SABRE_PIOAFSR_SPERR))
-		pci_scan_for_parity_error(pbm, pbm->pci_bus);
-
-	return IRQ_HANDLED;
-}
-
 static void sabre_register_error_handlers(struct pci_pbm_info *pbm)
 {
 	struct device_node *dp = pbm->op->node;
@@ -588,7 +372,7 @@ static void sabre_register_error_handlers(struct pci_pbm_info *pbm)
 	if (err)
 		printk(KERN_WARNING "%s: Couldn't register CE, err=%d.\n",
 		       pbm->name, err);
-	err = request_irq(op->irqs[0], sabre_pcierr_intr, 0,
+	err = request_irq(op->irqs[0], psycho_pcierr_intr, 0,
 			  "SABRE_PCIERR", pbm);
 	if (err)
 		printk(KERN_WARNING "%s: Couldn't register PCIERR, err=%d.\n",
@@ -679,6 +463,9 @@ static void __init sabre_pbm_init(struct pci_pbm_info *pbm,
 				  struct of_device *op)
 {
 	psycho_pbm_init_common(pbm, op, "SABRE", PBM_CHIP_TYPE_SABRE);
+	pbm->pci_afsr = pbm->controller_regs + SABRE_PIOAFSR;
+	pbm->pci_afar = pbm->controller_regs + SABRE_PIOAFAR;
+	pbm->pci_csr = pbm->controller_regs + SABRE_PCICTRL;
 	sabre_scan_bus(pbm, &op->dev);
 }
 
diff --git a/arch/sparc64/kernel/psycho_common.c b/arch/sparc64/kernel/psycho_common.c
index 1b4d462..6b188df 100644
--- a/arch/sparc64/kernel/psycho_common.c
+++ b/arch/sparc64/kernel/psycho_common.c
@@ -3,15 +3,368 @@
  * Copyright (C) 2008 David S. Miller <davem@davemloft.net>
  */
 #include <linux/kernel.h>
+#include <linux/interrupt.h>
 
 #include <asm/upa.h>
 
 #include "pci_impl.h"
+#include "iommu_common.h"
 #include "psycho_common.h"
 
+#define  PSYCHO_STRBUF_CTRL_DENAB	0x0000000000000002UL
+#define  PSYCHO_STCERR_WRITE		0x0000000000000002UL
+#define  PSYCHO_STCERR_READ		0x0000000000000001UL
+#define  PSYCHO_STCTAG_PPN		0x0fffffff00000000UL
+#define  PSYCHO_STCTAG_VPN		0x00000000ffffe000UL
+#define  PSYCHO_STCTAG_VALID		0x0000000000000002UL
+#define  PSYCHO_STCTAG_WRITE		0x0000000000000001UL
+#define  PSYCHO_STCLINE_LINDX		0x0000000001e00000UL
+#define  PSYCHO_STCLINE_SPTR		0x00000000001f8000UL
+#define  PSYCHO_STCLINE_LADDR		0x0000000000007f00UL
+#define  PSYCHO_STCLINE_EPTR		0x00000000000000fcUL
+#define  PSYCHO_STCLINE_VALID		0x0000000000000002UL
+#define  PSYCHO_STCLINE_FOFN		0x0000000000000001UL
+
+static DEFINE_SPINLOCK(stc_buf_lock);
+static unsigned long stc_error_buf[128];
+static unsigned long stc_tag_buf[16];
+static unsigned long stc_line_buf[16];
+
+static void psycho_check_stc_error(struct pci_pbm_info *pbm)
+{
+	unsigned long err_base, tag_base, line_base;
+	struct strbuf *strbuf = &pbm->stc;
+	u64 control;
+	int i;
+
+	if (!strbuf->strbuf_control)
+		return;
+
+	err_base = strbuf->strbuf_err_stat;
+	tag_base = strbuf->strbuf_tag_diag;
+	line_base = strbuf->strbuf_line_diag;
+
+	spin_lock(&stc_buf_lock);
+
+	/* This is __REALLY__ dangerous.  When we put the streaming
+	 * buffer into diagnostic mode to probe it's tags and error
+	 * status, we _must_ clear all of the line tag valid bits
+	 * before re-enabling the streaming buffer.  If any dirty data
+	 * lives in the STC when we do this, we will end up
+	 * invalidating it before it has a chance to reach main
+	 * memory.
+	 */
+	control = upa_readq(strbuf->strbuf_control);
+	upa_writeq(control | PSYCHO_STRBUF_CTRL_DENAB, strbuf->strbuf_control);
+	for (i = 0; i < 128; i++) {
+		u64 val;
+
+		val = upa_readq(err_base + (i * 8UL));
+		upa_writeq(0UL, err_base + (i * 8UL));
+		stc_error_buf[i] = val;
+	}
+	for (i = 0; i < 16; i++) {
+		stc_tag_buf[i] = upa_readq(tag_base + (i * 8UL));
+		stc_line_buf[i] = upa_readq(line_base + (i * 8UL));
+		upa_writeq(0UL, tag_base + (i * 8UL));
+		upa_writeq(0UL, line_base + (i * 8UL));
+	}
+
+	/* OK, state is logged, exit diagnostic mode. */
+	upa_writeq(control, strbuf->strbuf_control);
+
+	for (i = 0; i < 16; i++) {
+		int j, saw_error, first, last;
+
+		saw_error = 0;
+		first = i * 8;
+		last = first + 8;
+		for (j = first; j < last; j++) {
+			u64 errval = stc_error_buf[j];
+			if (errval != 0) {
+				saw_error++;
+				printk(KERN_ERR "%s: STC_ERR(%d)[wr(%d)"
+				       "rd(%d)]\n",
+				       pbm->name,
+				       j,
+				       (errval & PSYCHO_STCERR_WRITE) ? 1 : 0,
+				       (errval & PSYCHO_STCERR_READ) ? 1 : 0);
+			}
+		}
+		if (saw_error != 0) {
+			u64 tagval = stc_tag_buf[i];
+			u64 lineval = stc_line_buf[i];
+			printk(KERN_ERR "%s: STC_TAG(%d)[PA(%016lx)VA(%08lx)"
+			       "V(%d)W(%d)]\n",
+			       pbm->name,
+			       i,
+			       ((tagval & PSYCHO_STCTAG_PPN) >> 19UL),
+			       (tagval & PSYCHO_STCTAG_VPN),
+			       ((tagval & PSYCHO_STCTAG_VALID) ? 1 : 0),
+			       ((tagval & PSYCHO_STCTAG_WRITE) ? 1 : 0));
+			printk(KERN_ERR "%s: STC_LINE(%d)[LIDX(%lx)SP(%lx)"
+			       "LADDR(%lx)EP(%lx)V(%d)FOFN(%d)]\n",
+			       pbm->name,
+			       i,
+			       ((lineval & PSYCHO_STCLINE_LINDX) >> 21UL),
+			       ((lineval & PSYCHO_STCLINE_SPTR) >> 15UL),
+			       ((lineval & PSYCHO_STCLINE_LADDR) >> 8UL),
+			       ((lineval & PSYCHO_STCLINE_EPTR) >> 2UL),
+			       ((lineval & PSYCHO_STCLINE_VALID) ? 1 : 0),
+			       ((lineval & PSYCHO_STCLINE_FOFN) ? 1 : 0));
+		}
+	}
+
+	spin_unlock(&stc_buf_lock);
+}
+
 #define PSYCHO_IOMMU_TAG		0xa580UL
 #define PSYCHO_IOMMU_DATA		0xa600UL
 
+static void psycho_record_iommu_tags_and_data(struct pci_pbm_info *pbm,
+					      u64 *tag, u64 *data)
+{
+	int i;
+
+	for (i = 0; i < 16; i++) {
+		unsigned long base = pbm->controller_regs;
+		unsigned long off = i * 8UL;
+
+		tag[i] = upa_readq(base + PSYCHO_IOMMU_TAG+off);
+		data[i] = upa_readq(base + PSYCHO_IOMMU_DATA+off);
+
+		/* Now clear out the entry. */
+		upa_writeq(0, base + PSYCHO_IOMMU_TAG + off);
+		upa_writeq(0, base + PSYCHO_IOMMU_DATA + off);
+	}
+}
+
+#define  PSYCHO_IOMMU_TAG_ERRSTS (0x3UL << 23UL)
+#define  PSYCHO_IOMMU_TAG_ERR	 (0x1UL << 22UL)
+#define  PSYCHO_IOMMU_TAG_WRITE	 (0x1UL << 21UL)
+#define  PSYCHO_IOMMU_TAG_STREAM (0x1UL << 20UL)
+#define  PSYCHO_IOMMU_TAG_SIZE	 (0x1UL << 19UL)
+#define  PSYCHO_IOMMU_TAG_VPAGE	 0x7ffffUL
+#define  PSYCHO_IOMMU_DATA_VALID (1UL << 30UL)
+#define  PSYCHO_IOMMU_DATA_CACHE (1UL << 28UL)
+#define  PSYCHO_IOMMU_DATA_PPAGE 0xfffffffUL
+
+static void psycho_dump_iommu_tags_and_data(struct pci_pbm_info *pbm,
+					    u64 *tag, u64 *data)
+{
+	int i;
+
+	for (i = 0; i < 16; i++) {
+		u64 tag_val, data_val;
+		const char *type_str;
+		tag_val = tag[i];
+		if (!(tag_val & PSYCHO_IOMMU_TAG_ERR))
+			continue;
+
+		data_val = data[i];
+		switch((tag_val & PSYCHO_IOMMU_TAG_ERRSTS) >> 23UL) {
+		case 0:
+			type_str = "Protection Error";
+			break;
+		case 1:
+			type_str = "Invalid Error";
+			break;
+		case 2:
+			type_str = "TimeOut Error";
+			break;
+		case 3:
+		default:
+			type_str = "ECC Error";
+			break;
+		}
+
+		printk(KERN_ERR "%s: IOMMU TAG(%d)[error(%s) wr(%d) "
+		       "str(%d) sz(%dK) vpg(%08lx)]\n",
+		       pbm->name, i, type_str,
+		       ((tag_val & PSYCHO_IOMMU_TAG_WRITE) ? 1 : 0),
+		       ((tag_val & PSYCHO_IOMMU_TAG_STREAM) ? 1 : 0),
+		       ((tag_val & PSYCHO_IOMMU_TAG_SIZE) ? 64 : 8),
+		       (tag_val & PSYCHO_IOMMU_TAG_VPAGE) << IOMMU_PAGE_SHIFT);
+		printk(KERN_ERR "%s: IOMMU DATA(%d)[valid(%d) cache(%d) "
+		       "ppg(%016lx)]\n",
+		       pbm->name, i,
+		       ((data_val & PSYCHO_IOMMU_DATA_VALID) ? 1 : 0),
+		       ((data_val & PSYCHO_IOMMU_DATA_CACHE) ? 1 : 0),
+		       (data_val & PSYCHO_IOMMU_DATA_PPAGE)<<IOMMU_PAGE_SHIFT);
+	}
+}
+
+#define  PSYCHO_IOMMU_CTRL_XLTESTAT	0x0000000006000000UL
+#define  PSYCHO_IOMMU_CTRL_XLTEERR	0x0000000001000000UL
+
+void psycho_check_iommu_error(struct pci_pbm_info *pbm,
+			      unsigned long afsr,
+			      unsigned long afar,
+			      enum psycho_error_type type)
+{
+	u64 control, iommu_tag[16], iommu_data[16];
+	struct iommu *iommu = pbm->iommu;
+	unsigned long flags;
+
+	spin_lock_irqsave(&iommu->lock, flags);
+	control = upa_readq(iommu->iommu_control);
+	if (control & PSYCHO_IOMMU_CTRL_XLTEERR) {
+		const char *type_str;
+
+		control &= ~PSYCHO_IOMMU_CTRL_XLTEERR;
+		upa_writeq(control, iommu->iommu_control);
+
+		switch ((control & PSYCHO_IOMMU_CTRL_XLTESTAT) >> 25UL) {
+		case 0:
+			type_str = "Protection Error";
+			break;
+		case 1:
+			type_str = "Invalid Error";
+			break;
+		case 2:
+			type_str = "TimeOut Error";
+			break;
+		case 3:
+		default:
+			type_str = "ECC Error";
+			break;
+		};
+		printk(KERN_ERR "%s: IOMMU Error, type[%s]\n",
+		       pbm->name, type_str);
+
+		/* It is very possible for another DVMA to occur while
+		 * we do this probe, and corrupt the system further.
+		 * But we are so screwed at this point that we are
+		 * likely to crash hard anyways, so get as much
+		 * diagnostic information to the console as we can.
+		 */
+		psycho_record_iommu_tags_and_data(pbm, iommu_tag, iommu_data);
+		psycho_dump_iommu_tags_and_data(pbm, iommu_tag, iommu_data);
+	}
+	psycho_check_stc_error(pbm);
+	spin_unlock_irqrestore(&iommu->lock, flags);
+}
+
+#define  PSYCHO_PCICTRL_SBH_ERR	 0x0000000800000000UL
+#define  PSYCHO_PCICTRL_SERR	 0x0000000400000000UL
+
+static irqreturn_t psycho_pcierr_intr_other(struct pci_pbm_info *pbm)
+{
+	irqreturn_t ret = IRQ_NONE;
+	u64 csr, csr_error_bits;
+	u16 stat;
+
+	csr = upa_readq(pbm->pci_csr);
+	csr_error_bits = csr & (PSYCHO_PCICTRL_SBH_ERR | PSYCHO_PCICTRL_SERR);
+	if (csr_error_bits) {
+		/* Clear the errors.  */
+		upa_writeq(csr, pbm->pci_csr);
+
+		/* Log 'em.  */
+		if (csr_error_bits & PSYCHO_PCICTRL_SBH_ERR)
+			printk(KERN_ERR "%s: PCI streaming byte hole "
+			       "error asserted.\n", pbm->name);
+		if (csr_error_bits & PSYCHO_PCICTRL_SERR)
+			printk(KERN_ERR "%s: PCI SERR signal asserted.\n",
+			       pbm->name);
+		ret = IRQ_HANDLED;
+	}
+	pci_read_config_word(pbm->pci_bus->self, PCI_STATUS, &stat);
+	if (stat & (PCI_STATUS_PARITY |
+		    PCI_STATUS_SIG_TARGET_ABORT |
+		    PCI_STATUS_REC_TARGET_ABORT |
+		    PCI_STATUS_REC_MASTER_ABORT |
+		    PCI_STATUS_SIG_SYSTEM_ERROR)) {
+		printk(KERN_ERR "%s: PCI bus error, PCI_STATUS[%04x]\n",
+		       pbm->name, stat);
+		pci_write_config_word(pbm->pci_bus->self, PCI_STATUS, 0xffff);
+		ret = IRQ_HANDLED;
+	}
+	return ret;
+}
+
+#define  PSYCHO_PCIAFSR_PMA	0x8000000000000000UL
+#define  PSYCHO_PCIAFSR_PTA	0x4000000000000000UL
+#define  PSYCHO_PCIAFSR_PRTRY	0x2000000000000000UL
+#define  PSYCHO_PCIAFSR_PPERR	0x1000000000000000UL
+#define  PSYCHO_PCIAFSR_SMA	0x0800000000000000UL
+#define  PSYCHO_PCIAFSR_STA	0x0400000000000000UL
+#define  PSYCHO_PCIAFSR_SRTRY	0x0200000000000000UL
+#define  PSYCHO_PCIAFSR_SPERR	0x0100000000000000UL
+#define  PSYCHO_PCIAFSR_RESV1	0x00ff000000000000UL
+#define  PSYCHO_PCIAFSR_BMSK	0x0000ffff00000000UL
+#define  PSYCHO_PCIAFSR_BLK	0x0000000080000000UL
+#define  PSYCHO_PCIAFSR_RESV2	0x0000000040000000UL
+#define  PSYCHO_PCIAFSR_MID	0x000000003e000000UL
+#define  PSYCHO_PCIAFSR_RESV3	0x0000000001ffffffUL
+
+irqreturn_t psycho_pcierr_intr(int irq, void *dev_id)
+{
+	struct pci_pbm_info *pbm = dev_id;
+	u64 afsr, afar, error_bits;
+	int reported;
+
+	afsr = upa_readq(pbm->pci_afsr);
+	afar = upa_readq(pbm->pci_afar);
+	error_bits = afsr &
+		(PSYCHO_PCIAFSR_PMA | PSYCHO_PCIAFSR_PTA |
+		 PSYCHO_PCIAFSR_PRTRY | PSYCHO_PCIAFSR_PPERR |
+		 PSYCHO_PCIAFSR_SMA | PSYCHO_PCIAFSR_STA |
+		 PSYCHO_PCIAFSR_SRTRY | PSYCHO_PCIAFSR_SPERR);
+	if (!error_bits)
+		return psycho_pcierr_intr_other(pbm);
+	upa_writeq(error_bits, pbm->pci_afsr);
+	printk(KERN_ERR "%s: PCI Error, primary error type[%s]\n",
+	       pbm->name,
+	       (((error_bits & PSYCHO_PCIAFSR_PMA) ?
+		 "Master Abort" :
+		 ((error_bits & PSYCHO_PCIAFSR_PTA) ?
+		  "Target Abort" :
+		  ((error_bits & PSYCHO_PCIAFSR_PRTRY) ?
+		   "Excessive Retries" :
+		   ((error_bits & PSYCHO_PCIAFSR_PPERR) ?
+		    "Parity Error" : "???"))))));
+	printk(KERN_ERR "%s: bytemask[%04lx] UPA_MID[%02lx] was_block(%d)\n",
+	       pbm->name,
+	       (afsr & PSYCHO_PCIAFSR_BMSK) >> 32UL,
+	       (afsr & PSYCHO_PCIAFSR_MID) >> 25UL,
+	       (afsr & PSYCHO_PCIAFSR_BLK) ? 1 : 0);
+	printk(KERN_ERR "%s: PCI AFAR [%016lx]\n", pbm->name, afar);
+	printk(KERN_ERR "%s: PCI Secondary errors [", pbm->name);
+	reported = 0;
+	if (afsr & PSYCHO_PCIAFSR_SMA) {
+		reported++;
+		printk("(Master Abort)");
+	}
+	if (afsr & PSYCHO_PCIAFSR_STA) {
+		reported++;
+		printk("(Target Abort)");
+	}
+	if (afsr & PSYCHO_PCIAFSR_SRTRY) {
+		reported++;
+		printk("(Excessive Retries)");
+	}
+	if (afsr & PSYCHO_PCIAFSR_SPERR) {
+		reported++;
+		printk("(Parity Error)");
+	}
+	if (!reported)
+		printk("(none)");
+	printk("]\n");
+
+	if (error_bits & (PSYCHO_PCIAFSR_PTA | PSYCHO_PCIAFSR_STA)) {
+		psycho_check_iommu_error(pbm, afsr, afar, PCI_ERR);
+		pci_scan_for_target_abort(pbm, pbm->pci_bus);
+	}
+	if (error_bits & (PSYCHO_PCIAFSR_PMA | PSYCHO_PCIAFSR_SMA))
+		pci_scan_for_master_abort(pbm, pbm->pci_bus);
+
+	if (error_bits & (PSYCHO_PCIAFSR_PPERR | PSYCHO_PCIAFSR_SPERR))
+		pci_scan_for_parity_error(pbm, pbm->pci_bus);
+
+	return IRQ_HANDLED;
+}
+
 static void psycho_iommu_flush(struct pci_pbm_info *pbm)
 {
 	int i;
diff --git a/arch/sparc64/kernel/psycho_common.h b/arch/sparc64/kernel/psycho_common.h
index adfbadb..b53aa8d 100644
--- a/arch/sparc64/kernel/psycho_common.h
+++ b/arch/sparc64/kernel/psycho_common.h
@@ -1,6 +1,17 @@
 #ifndef _PSYCHO_COMMON_H
 #define _PSYCHO_COMMON_H
 
+enum psycho_error_type {
+	UE_ERR, CE_ERR, PCI_ERR
+};
+
+extern void psycho_check_iommu_error(struct pci_pbm_info *pbm,
+				     unsigned long afsr,
+				     unsigned long afar,
+				     enum psycho_error_type type);
+
+extern irqreturn_t psycho_pcierr_intr(int irq, void *dev_id);
+
 extern int psycho_iommu_init(struct pci_pbm_info *pbm, int tsbsize,
 			     u32 dvma_offset, u32 dma_mask,
 			     unsigned long write_complete_offset);
-- 
1.5.6.5.GIT

