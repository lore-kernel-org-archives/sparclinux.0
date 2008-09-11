From: David Miller <davem@davemloft.net>
Date: Thu, 11 Sep 2008 06:10:53 +0000
Subject: [PATCH 1/2]: sparc64: Get rid of pci_controller_info.
Message-Id: <20080910.231053.122264671.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc64: Get rid of pci_controller_info.

It is just used as a parent to encapsulate two PBM objects.

But that layout is only really relevant and necessary for
psycho PCI controllers, which unlike all the others share
a single IOMMU instance between sibling PCI busses.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/iommu_64.h |    3 +
 arch/sparc64/kernel/pci.c         |    4 +-
 arch/sparc64/kernel/pci_fire.c    |   55 ++++---------
 arch/sparc64/kernel/pci_impl.h    |   16 +---
 arch/sparc64/kernel/pci_psycho.c  |  161 +++++++++++++++++--------------------
 arch/sparc64/kernel/pci_sabre.c   |   33 ++++----
 arch/sparc64/kernel/pci_schizo.c  |   84 +++++++++-----------
 arch/sparc64/kernel/pci_sun4v.c   |   66 ++++++---------
 8 files changed, 181 insertions(+), 241 deletions(-)

diff --git a/arch/sparc/include/asm/iommu_64.h b/arch/sparc/include/asm/iommu_64.h
index d7b9afc..caf798b 100644
--- a/arch/sparc/include/asm/iommu_64.h
+++ b/arch/sparc/include/asm/iommu_64.h
@@ -48,6 +48,9 @@ struct strbuf {
 	unsigned long		strbuf_control;
 	unsigned long		strbuf_pflush;
 	unsigned long		strbuf_fsync;
+	unsigned long		strbuf_err_stat;
+	unsigned long		strbuf_tag_diag;
+	unsigned long		strbuf_line_diag;
 	unsigned long		strbuf_ctxflush;
 	unsigned long		strbuf_ctxmatch_base;
 	unsigned long		strbuf_flushflag_pa;
diff --git a/arch/sparc64/kernel/pci.c b/arch/sparc64/kernel/pci.c
index 8e18fdf..3070f6f 100644
--- a/arch/sparc64/kernel/pci.c
+++ b/arch/sparc64/kernel/pci.c
@@ -977,14 +977,14 @@ int pcibus_to_node(struct pci_bus *pbus)
 EXPORT_SYMBOL(pcibus_to_node);
 #endif
 
-/* Return the domain nuber for this pci bus */
+/* Return the domain number for this pci bus */
 
 int pci_domain_nr(struct pci_bus *pbus)
 {
 	struct pci_pbm_info *pbm = pbus->sysdata;
 	int ret;
 
-	if (pbm = NULL || pbm->parent = NULL) {
+	if (!pbm) {
 		ret = -ENXIO;
 	} else {
 		ret = pbm->index;
diff --git a/arch/sparc64/kernel/pci_fire.c b/arch/sparc64/kernel/pci_fire.c
index 1b44153..b538bfb 100644
--- a/arch/sparc64/kernel/pci_fire.c
+++ b/arch/sparc64/kernel/pci_fire.c
@@ -431,22 +431,13 @@ static void pci_fire_hw_init(struct pci_pbm_info *pbm)
 	fire_write(pbm->pbm_regs + FIRE_PEC_IENAB, ~(u64)0);
 }
 
-static int __init pci_fire_pbm_init(struct pci_controller_info *p,
+static int __init pci_fire_pbm_init(struct pci_pbm_info *pbm,
 				    struct of_device *op, u32 portid)
 {
 	const struct linux_prom64_registers *regs;
 	struct device_node *dp = op->node;
-	struct pci_pbm_info *pbm;
 	int err;
 
-	if ((portid & 1) = 0)
-		pbm = &p->pbm_A;
-	else
-		pbm = &p->pbm_B;
-
-	pbm->next = pci_pbm_root;
-	pci_pbm_root = pbm;
-
 	pbm->numa_node = -1;
 
 	pbm->pci_ops = &sun4u_pci_ops;
@@ -455,7 +446,6 @@ static int __init pci_fire_pbm_init(struct pci_controller_info *p,
 	pbm->index = pci_num_pbms++;
 
 	pbm->portid = portid;
-	pbm->parent = p;
 	pbm->prom_node = dp;
 	pbm->name = dp->full_name;
 
@@ -481,13 +471,9 @@ static int __init pci_fire_pbm_init(struct pci_controller_info *p,
 
 	/* XXX register error interrupt handlers XXX */
 
-	return 0;
-}
+	pbm->next = pci_pbm_root;
+	pci_pbm_root = pbm;
 
-static inline int portid_compare(u32 x, u32 y)
-{
-	if (x = (y ^ 1))
-		return 1;
 	return 0;
 }
 
@@ -495,48 +481,41 @@ static int __devinit fire_probe(struct of_device *op,
 				const struct of_device_id *match)
 {
 	struct device_node *dp = op->node;
-	struct pci_controller_info *p;
 	struct pci_pbm_info *pbm;
 	struct iommu *iommu;
 	u32 portid;
 	int err;
 
 	portid = of_getintprop_default(dp, "portid", 0xff);
-	for (pbm = pci_pbm_root; pbm; pbm = pbm->next) {
-		if (portid_compare(pbm->portid, portid))
-			return pci_fire_pbm_init(pbm->parent, op, portid);
-	}
 
 	err = -ENOMEM;
-	p = kzalloc(sizeof(struct pci_controller_info), GFP_ATOMIC);
-	if (!p) {
-		printk(KERN_ERR PFX "Cannot allocate controller info.\n");
+	pbm = kzalloc(sizeof(*pbm), GFP_KERNEL);
+	if (!pbm) {
+		printk(KERN_ERR PFX "Cannot allocate pci_pbminfo.\n");
 		goto out_err;
 	}
 
-	iommu = kzalloc(sizeof(struct iommu), GFP_ATOMIC);
+	iommu = kzalloc(sizeof(struct iommu), GFP_KERNEL);
 	if (!iommu) {
-		printk(KERN_ERR PFX "Cannot allocate PBM A iommu.\n");
+		printk(KERN_ERR PFX "Cannot allocate PBM iommu.\n");
 		goto out_free_controller;
 	}
 
-	p->pbm_A.iommu = iommu;
+	pbm->iommu = iommu;
 
-	iommu = kzalloc(sizeof(struct iommu), GFP_ATOMIC);
-	if (!iommu) {
-		printk(KERN_ERR PFX "Cannot allocate PBM A iommu.\n");
-		goto out_free_iommu_A;
-	}
+	err = pci_fire_pbm_init(pbm, op, portid);
+	if (err)
+		goto out_free_iommu;
 
-	p->pbm_B.iommu = iommu;
+	dev_set_drvdata(&op->dev, pbm);
 
-	return pci_fire_pbm_init(p, op, portid);
+	return 0;
 
-out_free_iommu_A:
-	kfree(p->pbm_A.iommu);
+out_free_iommu:
+	kfree(pbm->iommu);
 			
 out_free_controller:
-	kfree(p);
+	kfree(pbm);
 
 out_err:
 	return err;
diff --git a/arch/sparc64/kernel/pci_impl.h b/arch/sparc64/kernel/pci_impl.h
index 4125f75..4937ce9 100644
--- a/arch/sparc64/kernel/pci_impl.h
+++ b/arch/sparc64/kernel/pci_impl.h
@@ -56,15 +56,11 @@ struct sparc64_msiq_cookie {
 };
 #endif
 
-struct pci_controller_info;
-
 struct pci_pbm_info {
 	struct pci_pbm_info		*next;
+	struct pci_pbm_info		*sibling;
 	int				index;
 
-	/* PCI controller we sit under. */
-	struct pci_controller_info	*parent;
-
 	/* Physical address base of controller registers. */
 	unsigned long			controller_regs;
 
@@ -107,6 +103,10 @@ struct pci_pbm_info {
 	/* This will be 12 on PCI-E controllers, 8 elsewhere.  */
 	unsigned long			config_space_reg_bits;
 
+	unsigned long			pci_afsr;
+	unsigned long			pci_afar;
+	unsigned long			pci_csr;
+
 	/* State of 66MHz capabilities on this PBM. */
 	int				is_66mhz_capable;
 	int				all_devs_66mhz;
@@ -151,12 +151,6 @@ struct pci_pbm_info {
 	int				numa_node;
 };
 
-struct pci_controller_info {
-	/* The PCI bus modules controlled by us. */
-	struct pci_pbm_info		pbm_A;
-	struct pci_pbm_info		pbm_B;
-};
-
 extern struct pci_pbm_info *pci_pbm_root;
 
 extern int pci_num_pbms;
diff --git a/arch/sparc64/kernel/pci_psycho.c b/arch/sparc64/kernel/pci_psycho.c
index 0be850e..70a7af0 100644
--- a/arch/sparc64/kernel/pci_psycho.c
+++ b/arch/sparc64/kernel/pci_psycho.c
@@ -146,24 +146,16 @@ static unsigned long stc_error_buf[128];
 static unsigned long stc_tag_buf[16];
 static unsigned long stc_line_buf[16];
 
-static void __psycho_check_one_stc(struct pci_pbm_info *pbm,
-				   int is_pbm_a)
+static void psycho_check_stc_error(struct pci_pbm_info *pbm)
 {
 	struct strbuf *strbuf = &pbm->stc;
-	unsigned long regbase = pbm->controller_regs;
 	unsigned long err_base, tag_base, line_base;
 	u64 control;
 	int i;
 
-	if (is_pbm_a) {
-		err_base = regbase + PSYCHO_STC_ERR_A;
-		tag_base = regbase + PSYCHO_STC_TAG_A;
-		line_base = regbase + PSYCHO_STC_LINE_A;
-	} else {
-		err_base = regbase + PSYCHO_STC_ERR_B;
-		tag_base = regbase + PSYCHO_STC_TAG_B;
-		line_base = regbase + PSYCHO_STC_LINE_B;
-	}
+	err_base = strbuf->strbuf_err_stat;
+	tag_base = strbuf->strbuf_tag_diag;
+	line_base = strbuf->strbuf_line_diag;
 
 	spin_lock(&stc_buf_lock);
 
@@ -239,15 +231,6 @@ static void __psycho_check_one_stc(struct pci_pbm_info *pbm,
 	spin_unlock(&stc_buf_lock);
 }
 
-static void __psycho_check_stc_error(struct pci_pbm_info *pbm,
-				     unsigned long afsr,
-				     unsigned long afar,
-				     enum psycho_error_type type)
-{
-	__psycho_check_one_stc(pbm,
-			       (pbm = &pbm->parent->pbm_A));
-}
-
 /* When an Uncorrectable Error or a PCI Error happens, we
  * interrogate the IOMMU state to see if it is the cause.
  */
@@ -386,7 +369,7 @@ static void psycho_check_iommu_error(struct pci_pbm_info *pbm,
 			       (data & PSYCHO_IOMMU_DATA_PPAGE) << IOMMU_PAGE_SHIFT);
 		}
 	}
-	__psycho_check_stc_error(pbm, afsr, afar, type);
+	psycho_check_stc_error(pbm);
 	spin_unlock_irqrestore(&iommu->lock, flags);
 }
 
@@ -412,7 +395,6 @@ static void psycho_check_iommu_error(struct pci_pbm_info *pbm,
 static irqreturn_t psycho_ue_intr(int irq, void *dev_id)
 {
 	struct pci_pbm_info *pbm = dev_id;
-	struct pci_controller_info *p = pbm->parent;
 	unsigned long afsr_reg = pbm->controller_regs + PSYCHO_UE_AFSR;
 	unsigned long afar_reg = pbm->controller_regs + PSYCHO_UE_AFAR;
 	unsigned long afsr, afar, error_bits;
@@ -465,8 +447,9 @@ static irqreturn_t psycho_ue_intr(int irq, void *dev_id)
 	printk("]\n");
 
 	/* Interrogate both IOMMUs for error status. */
-	psycho_check_iommu_error(&p->pbm_A, afsr, afar, UE_ERR);
-	psycho_check_iommu_error(&p->pbm_B, afsr, afar, UE_ERR);
+	psycho_check_iommu_error(pbm, afsr, afar, UE_ERR);
+	if (pbm->sibling)
+		psycho_check_iommu_error(pbm->sibling, afsr, afar, UE_ERR);
 
 	return IRQ_HANDLED;
 }
@@ -573,23 +556,18 @@ static irqreturn_t psycho_ce_intr(int irq, void *dev_id)
 #define PSYCHO_PCI_AFAR_A	0x2018UL
 #define PSYCHO_PCI_AFAR_B	0x4018UL
 
-static irqreturn_t psycho_pcierr_intr_other(struct pci_pbm_info *pbm, int is_pbm_a)
+static irqreturn_t psycho_pcierr_intr_other(struct pci_pbm_info *pbm)
 {
-	unsigned long csr_reg, csr, csr_error_bits;
+	unsigned long csr, csr_error_bits;
 	irqreturn_t ret = IRQ_NONE;
 	u16 stat;
 
-	if (is_pbm_a) {
-		csr_reg = pbm->controller_regs + PSYCHO_PCIA_CTRL;
-	} else {
-		csr_reg = pbm->controller_regs + PSYCHO_PCIB_CTRL;
-	}
-	csr = psycho_read(csr_reg);
+	csr = psycho_read(pbm->pci_csr);
 	csr_error_bits  		csr & (PSYCHO_PCICTRL_SBH_ERR | PSYCHO_PCICTRL_SERR);
 	if (csr_error_bits) {
 		/* Clear the errors.  */
-		psycho_write(csr_reg, csr);
+		psycho_write(pbm->pci_csr, csr);
 
 		/* Log 'em.  */
 		if (csr_error_bits & PSYCHO_PCICTRL_SBH_ERR)
@@ -616,19 +594,12 @@ static irqreturn_t psycho_pcierr_intr_other(struct pci_pbm_info *pbm, int is_pbm
 static irqreturn_t psycho_pcierr_intr(int irq, void *dev_id)
 {
 	struct pci_pbm_info *pbm = dev_id;
-	struct pci_controller_info *p = pbm->parent;
 	unsigned long afsr_reg, afar_reg;
 	unsigned long afsr, afar, error_bits;
-	int is_pbm_a, reported;
+	int reported;
 
-	is_pbm_a = (pbm = &pbm->parent->pbm_A);
-	if (is_pbm_a) {
-		afsr_reg = p->pbm_A.controller_regs + PSYCHO_PCI_AFSR_A;
-		afar_reg = p->pbm_A.controller_regs + PSYCHO_PCI_AFAR_A;
-	} else {
-		afsr_reg = p->pbm_A.controller_regs + PSYCHO_PCI_AFSR_B;
-		afar_reg = p->pbm_A.controller_regs + PSYCHO_PCI_AFAR_B;
-	}
+	afsr_reg = pbm->pci_afsr;
+	afar_reg = pbm->pci_afar;
 
 	/* Latch error status. */
 	afar = psycho_read(afar_reg);
@@ -641,7 +612,7 @@ static irqreturn_t psycho_pcierr_intr(int irq, void *dev_id)
 		 PSYCHO_PCIAFSR_SMA | PSYCHO_PCIAFSR_STA |
 		 PSYCHO_PCIAFSR_SRTRY | PSYCHO_PCIAFSR_SPERR);
 	if (!error_bits)
-		return psycho_pcierr_intr_other(pbm, is_pbm_a);
+		return psycho_pcierr_intr_other(pbm);
 	psycho_write(afsr_reg, error_bits);
 
 	/* Log the error. */
@@ -923,10 +894,16 @@ static void psycho_pbm_strbuf_init(struct pci_pbm_info *pbm,
 		pbm->stc.strbuf_control  = base + PSYCHO_STRBUF_CONTROL_A;
 		pbm->stc.strbuf_pflush   = base + PSYCHO_STRBUF_FLUSH_A;
 		pbm->stc.strbuf_fsync    = base + PSYCHO_STRBUF_FSYNC_A;
+		pbm->stc.strbuf_err_stat = base + PSYCHO_STC_ERR_A;
+		pbm->stc.strbuf_tag_diag = base + PSYCHO_STC_TAG_A;
+		pbm->stc.strbuf_line_diag= base + PSYCHO_STC_LINE_A;
 	} else {
 		pbm->stc.strbuf_control  = base + PSYCHO_STRBUF_CONTROL_B;
 		pbm->stc.strbuf_pflush   = base + PSYCHO_STRBUF_FLUSH_B;
 		pbm->stc.strbuf_fsync    = base + PSYCHO_STRBUF_FSYNC_B;
+		pbm->stc.strbuf_err_stat = base + PSYCHO_STC_ERR_B;
+		pbm->stc.strbuf_tag_diag = base + PSYCHO_STC_TAG_B;
+		pbm->stc.strbuf_line_diag= base + PSYCHO_STC_LINE_B;
 	}
 	/* PSYCHO's streaming buffer lacks ctx flushing. */
 	pbm->stc.strbuf_ctxflush      = 0;
@@ -971,16 +948,10 @@ static void psycho_pbm_strbuf_init(struct pci_pbm_info *pbm,
 #define PSYCHO_MEMSPACE_B	0x180000000UL
 #define PSYCHO_MEMSPACE_SIZE	0x07fffffffUL
 
-static void __init psycho_pbm_init(struct pci_controller_info *p,
+static void __init psycho_pbm_init(struct pci_pbm_info *pbm,
 				   struct of_device *op, int is_pbm_a)
 {
 	struct device_node *dp = op->node;
-	struct pci_pbm_info *pbm;
-
-	if (is_pbm_a)
-		pbm = &p->pbm_A;
-	else
-		pbm = &p->pbm_B;
 
 	pbm->next = pci_pbm_root;
 	pci_pbm_root = pbm;
@@ -996,7 +967,6 @@ static void __init psycho_pbm_init(struct pci_controller_info *p,
 	pbm->chip_version = of_getintprop_default(dp, "version#", 0);
 	pbm->chip_revision = of_getintprop_default(dp, "module-revision#", 0);
 
-	pbm->parent = p;
 	pbm->prom_node = dp;
 	pbm->name = dp->full_name;
 
@@ -1013,6 +983,17 @@ static void __init psycho_pbm_init(struct pci_controller_info *p,
 	psycho_scan_bus(pbm, &op->dev);
 }
 
+static struct pci_pbm_info * __devinit psycho_find_sibling(u32 upa_portid)
+{
+	struct pci_pbm_info *pbm;
+
+	for (pbm = pci_pbm_root; pbm; pbm = pbm->next) {
+		if (pbm->portid = upa_portid)
+			return pbm;
+	}
+	return NULL;
+}
+
 #define PSYCHO_CONFIGSPACE	0x001000000UL
 
 static int __devinit psycho_probe(struct of_device *op,
@@ -1020,7 +1001,6 @@ static int __devinit psycho_probe(struct of_device *op,
 {
 	const struct linux_prom64_registers *pr_regs;
 	struct device_node *dp = op->node;
-	struct pci_controller_info *p;
 	struct pci_pbm_info *pbm;
 	struct iommu *iommu;
 	int is_pbm_a, err;
@@ -1028,33 +1008,26 @@ static int __devinit psycho_probe(struct of_device *op,
 
 	upa_portid = of_getintprop_default(dp, "upa-portid", 0xff);
 
-	for (pbm = pci_pbm_root; pbm; pbm = pbm->next) {
-		struct pci_controller_info *p = pbm->parent;
-
-		if (p->pbm_A.portid = upa_portid) {
-			is_pbm_a = (p->pbm_A.prom_node = NULL);
-			psycho_pbm_init(p, op, is_pbm_a);
-			return 0;
-		}
-	}
-
 	err = -ENOMEM;
-	p = kzalloc(sizeof(struct pci_controller_info), GFP_ATOMIC);
-	if (!p) {
-		printk(KERN_ERR PFX "Cannot allocate controller info.\n");
+	pbm = kzalloc(sizeof(*pbm), GFP_KERNEL);
+	if (!pbm) {
+		printk(KERN_ERR PFX "Cannot allocate pci_pbm_info.\n");
 		goto out_err;
 	}
 
-	iommu = kzalloc(sizeof(struct iommu), GFP_ATOMIC);
-	if (!iommu) {
-		printk(KERN_ERR PFX "Cannot allocate PBM iommu.\n");
-		goto out_free_controller;
+	pbm->sibling = psycho_find_sibling(upa_portid);
+	if (pbm->sibling) {
+		iommu = pbm->sibling->iommu;
+	} else {
+		iommu = kzalloc(sizeof(struct iommu), GFP_KERNEL);
+		if (!iommu) {
+			printk(KERN_ERR PFX "Cannot allocate PBM iommu.\n");
+			goto out_free_controller;
+		}
 	}
 
-	p->pbm_A.iommu = p->pbm_B.iommu = iommu;
-
-	p->pbm_A.portid = upa_portid;
-	p->pbm_B.portid = upa_portid;
+	pbm->iommu = iommu;
+	pbm->portid = upa_portid;
 
 	pr_regs = of_get_property(dp, "reg", NULL);
 	err = -ENODEV;
@@ -1063,29 +1036,43 @@ static int __devinit psycho_probe(struct of_device *op,
 		goto out_free_iommu;
 	}
 
-	p->pbm_A.controller_regs = pr_regs[2].phys_addr;
-	p->pbm_B.controller_regs = pr_regs[2].phys_addr;
+	is_pbm_a = ((pr_regs[0].phys_addr & 0x6000) = 0x2000);
+
+	pbm->controller_regs = pr_regs[2].phys_addr;
+	pbm->config_space = (pr_regs[2].phys_addr + PSYCHO_CONFIGSPACE);
 
-	p->pbm_A.config_space = p->pbm_B.config_space -		(pr_regs[2].phys_addr + PSYCHO_CONFIGSPACE);
+	if (is_pbm_a) {
+		pbm->pci_afsr = pbm->controller_regs + PSYCHO_PCI_AFSR_A;
+		pbm->pci_afar = pbm->controller_regs + PSYCHO_PCI_AFAR_A;
+		pbm->pci_csr  = pbm->controller_regs + PSYCHO_PCIA_CTRL;
+	} else {
+		pbm->pci_afsr = pbm->controller_regs + PSYCHO_PCI_AFSR_B;
+		pbm->pci_afar = pbm->controller_regs + PSYCHO_PCI_AFAR_B;
+		pbm->pci_csr  = pbm->controller_regs + PSYCHO_PCIB_CTRL;
+	}
 
-	psycho_controller_hwinit(&p->pbm_A);
+	psycho_controller_hwinit(pbm);
+	if (!pbm->sibling) {
+		err = psycho_iommu_init(pbm);
+		if (err)
+			goto out_free_iommu;
+	}
 
-	err = psycho_iommu_init(&p->pbm_A);
-	if (err)
-		goto out_free_iommu;
+	psycho_pbm_init(pbm, op, is_pbm_a);
 
-	is_pbm_a = ((pr_regs[0].phys_addr & 0x6000) = 0x2000);
+	if (pbm->sibling)
+		pbm->sibling->sibling = pbm;
 
-	psycho_pbm_init(p, op, is_pbm_a);
+	dev_set_drvdata(&op->dev, pbm);
 
 	return 0;
 
 out_free_iommu:
-	kfree(p->pbm_A.iommu);
+	if (!pbm->sibling)
+		kfree(pbm->iommu);
 
 out_free_controller:
-	kfree(p);
+	kfree(pbm);
 
 out_err:
 	return err;
diff --git a/arch/sparc64/kernel/pci_sabre.c b/arch/sparc64/kernel/pci_sabre.c
index 707d6d6..8f779b5 100644
--- a/arch/sparc64/kernel/pci_sabre.c
+++ b/arch/sparc64/kernel/pci_sabre.c
@@ -734,8 +734,8 @@ static int sabre_iommu_init(struct pci_pbm_info *pbm,
 	return 0;
 }
 
-static void __init sabre_pbm_init(struct pci_controller_info *p,
-				  struct pci_pbm_info *pbm, struct of_device *op)
+static void __init sabre_pbm_init(struct pci_pbm_info *pbm,
+				  struct of_device *op)
 {
 	struct device_node *dp = op->node;
 
@@ -750,7 +750,6 @@ static void __init sabre_pbm_init(struct pci_controller_info *p,
 	pbm->index = pci_num_pbms++;
 
 	pbm->chip_type = PBM_CHIP_TYPE_SABRE;
-	pbm->parent = p;
 	pbm->prom_node = dp;
 	pci_get_pbm_props(pbm);
 
@@ -764,7 +763,6 @@ static int __devinit sabre_probe(struct of_device *op,
 {
 	const struct linux_prom64_registers *pr_regs;
 	struct device_node *dp = op->node;
-	struct pci_controller_info *p;
 	struct pci_pbm_info *pbm;
 	u32 upa_portid, dma_mask;
 	struct iommu *iommu;
@@ -786,26 +784,22 @@ static int __devinit sabre_probe(struct of_device *op,
 	}
 
 	err = -ENOMEM;
-	p = kzalloc(sizeof(*p), GFP_ATOMIC);
-	if (!p) {
-		printk(KERN_ERR PFX "Cannot allocate controller info.\n");
+	pbm = kzalloc(sizeof(*pbm), GFP_KERNEL);
+	if (!pbm) {
+		printk(KERN_ERR PFX "Cannot allocate pci_pbm_info.\n");
 		goto out_err;
 	}
 
-	iommu = kzalloc(sizeof(*iommu), GFP_ATOMIC);
+	iommu = kzalloc(sizeof(*iommu), GFP_KERNEL);
 	if (!iommu) {
 		printk(KERN_ERR PFX "Cannot allocate PBM iommu.\n");
 		goto out_free_controller;
 	}
 
-	pbm = &p->pbm_A;
 	pbm->iommu = iommu;
 
 	upa_portid = of_getintprop_default(dp, "upa-portid", 0xff);
 
-	pbm->next = pci_pbm_root;
-	pci_pbm_root = pbm;
-
 	pbm->portid = upa_portid;
 
 	/*
@@ -840,8 +834,7 @@ static int __devinit sabre_probe(struct of_device *op,
 		     SABRE_PCICTRL_ARBPARK | SABRE_PCICTRL_AEN));
 
 	/* Now map in PCI config space for entire SABRE. */
-	pbm->config_space -		(pbm->controller_regs + SABRE_CONFIGSPACE);
+	pbm->config_space = pbm->controller_regs + SABRE_CONFIGSPACE;
 
 	vdma = of_get_property(dp, "virtual-dma", NULL);
 	if (!vdma) {
@@ -876,14 +869,20 @@ static int __devinit sabre_probe(struct of_device *op,
 	/*
 	 * Look for APB underneath.
 	 */
-	sabre_pbm_init(p, pbm, op);
+	sabre_pbm_init(pbm, op);
+
+	pbm->next = pci_pbm_root;
+	pci_pbm_root = pbm;
+
+	dev_set_drvdata(&op->dev, pbm);
+
 	return 0;
 
 out_free_iommu:
-	kfree(p->pbm_A.iommu);
+	kfree(pbm->iommu);
 
 out_free_controller:
-	kfree(p);
+	kfree(pbm);
 
 out_err:
 	return err;
diff --git a/arch/sparc64/kernel/pci_schizo.c b/arch/sparc64/kernel/pci_schizo.c
index e1c5657..67e3640 100644
--- a/arch/sparc64/kernel/pci_schizo.c
+++ b/arch/sparc64/kernel/pci_schizo.c
@@ -358,11 +358,12 @@ static void schizo_check_iommu_error_pbm(struct pci_pbm_info *pbm,
 	spin_unlock_irqrestore(&iommu->lock, flags);
 }
 
-static void schizo_check_iommu_error(struct pci_controller_info *p,
+static void schizo_check_iommu_error(struct pci_pbm_info *pbm,
 				     enum schizo_error_type type)
 {
-	schizo_check_iommu_error_pbm(&p->pbm_A, type);
-	schizo_check_iommu_error_pbm(&p->pbm_B, type);
+	schizo_check_iommu_error_pbm(pbm, type);
+	if (pbm->sibling)
+		schizo_check_iommu_error_pbm(pbm->sibling, type);
 }
 
 /* Uncorrectable ECC error status gathering. */
@@ -387,7 +388,6 @@ static void schizo_check_iommu_error(struct pci_controller_info *p,
 static irqreturn_t schizo_ue_intr(int irq, void *dev_id)
 {
 	struct pci_pbm_info *pbm = dev_id;
-	struct pci_controller_info *p = pbm->parent;
 	unsigned long afsr_reg = pbm->controller_regs + SCHIZO_UE_AFSR;
 	unsigned long afar_reg = pbm->controller_regs + SCHIZO_UE_AFAR;
 	unsigned long afsr, afar, error_bits;
@@ -450,7 +450,7 @@ static irqreturn_t schizo_ue_intr(int irq, void *dev_id)
 	printk("]\n");
 
 	/* Interrogate IOMMU for error status. */
-	schizo_check_iommu_error(p, UE_ERR);
+	schizo_check_iommu_error(pbm, UE_ERR);
 
 	return IRQ_HANDLED;
 }
@@ -651,7 +651,6 @@ static irqreturn_t schizo_pcierr_intr_other(struct pci_pbm_info *pbm)
 static irqreturn_t schizo_pcierr_intr(int irq, void *dev_id)
 {
 	struct pci_pbm_info *pbm = dev_id;
-	struct pci_controller_info *p = pbm->parent;
 	unsigned long afsr_reg, afar_reg, base;
 	unsigned long afsr, afar, error_bits;
 	int reported;
@@ -745,7 +744,7 @@ static irqreturn_t schizo_pcierr_intr(int irq, void *dev_id)
 	 * a bug in the IOMMU support code or a PCI device driver.
 	 */
 	if (error_bits & (SCHIZO_PCIAFSR_PTA | SCHIZO_PCIAFSR_STA)) {
-		schizo_check_iommu_error(p, PCI_ERR);
+		schizo_check_iommu_error(pbm, PCI_ERR);
 		pci_scan_for_target_abort(pbm, pbm->pci_bus);
 	}
 	if (error_bits & (SCHIZO_PCIAFSR_PMA | SCHIZO_PCIAFSR_SMA))
@@ -806,7 +805,6 @@ static irqreturn_t schizo_pcierr_intr(int irq, void *dev_id)
 static irqreturn_t schizo_safarierr_intr(int irq, void *dev_id)
 {
 	struct pci_pbm_info *pbm = dev_id;
-	struct pci_controller_info *p = pbm->parent;
 	u64 errlog;
 
 	errlog = schizo_read(pbm->controller_regs + SCHIZO_SAFARI_ERRLOG);
@@ -822,7 +820,7 @@ static irqreturn_t schizo_safarierr_intr(int irq, void *dev_id)
 
 	printk("%s: Safari/JBUS interrupt, UNMAPPED error, interrogating IOMMUs.\n",
 	       pbm->name);
-	schizo_check_iommu_error(p, SAFARI_ERR);
+	schizo_check_iommu_error(pbm, SAFARI_ERR);
 
 	return IRQ_HANDLED;
 }
@@ -1329,13 +1327,12 @@ static void schizo_pbm_hw_init(struct pci_pbm_info *pbm)
 	}
 }
 
-static int __devinit schizo_pbm_init(struct pci_controller_info *p,
+static int __devinit schizo_pbm_init(struct pci_pbm_info *pbm,
 				     struct of_device *op, u32 portid,
 				     int chip_type)
 {
 	const struct linux_prom64_registers *regs;
 	struct device_node *dp = op->node;
-	struct pci_pbm_info *pbm;
 	const char *chipset_name;
 	int is_pbm_a, err;
 
@@ -1368,10 +1365,6 @@ static int __devinit schizo_pbm_init(struct pci_controller_info *p,
 	regs = of_get_property(dp, "reg", NULL);
 
 	is_pbm_a = ((regs[0].phys_addr & 0x00700000) = 0x00600000);
-	if (is_pbm_a)
-		pbm = &p->pbm_A;
-	else
-		pbm = &p->pbm_B;
 
 	pbm->next = pci_pbm_root;
 	pci_pbm_root = pbm;
@@ -1384,7 +1377,6 @@ static int __devinit schizo_pbm_init(struct pci_controller_info *p,
 	pbm->index = pci_num_pbms++;
 
 	pbm->portid = portid;
-	pbm->parent = p;
 	pbm->prom_node = dp;
 
 	pbm->chip_type = chip_type;
@@ -1430,10 +1422,21 @@ static inline int portid_compare(u32 x, u32 y, int chip_type)
 	return (x = y);
 }
 
+static struct pci_pbm_info * __devinit schizo_find_sibling(u32 portid,
+							   int chip_type)
+{
+	struct pci_pbm_info *pbm;
+
+	for (pbm = pci_pbm_root; pbm; pbm = pbm->next) {
+		if (portid_compare(pbm->portid, portid, chip_type))
+			return pbm;
+	}
+	return NULL;
+}
+
 static int __devinit __schizo_init(struct of_device *op, unsigned long chip_type)
 {
 	struct device_node *dp = op->node;
-	struct pci_controller_info *p;
 	struct pci_pbm_info *pbm;
 	struct iommu *iommu;
 	u32 portid;
@@ -1442,50 +1445,37 @@ static int __devinit __schizo_init(struct of_device *op, unsigned long chip_type
 	portid = of_getintprop_default(dp, "portid", 0xff);
 
 	err = -ENOMEM;
-	for (pbm = pci_pbm_root; pbm; pbm = pbm->next) {
-		if (portid_compare(pbm->portid, portid, chip_type)) {
-			if (schizo_pbm_init(pbm->parent, op,
-					    portid, chip_type))
-				goto out_err;
-			return 0;
-		}
-	}
-
-	p = kzalloc(sizeof(struct pci_controller_info), GFP_ATOMIC);
-	if (!p) {
-		printk(KERN_ERR PFX "Cannot allocate controller info.\n");
+	pbm = kzalloc(sizeof(*pbm), GFP_KERNEL);
+	if (!pbm) {
+		printk(KERN_ERR PFX "Cannot allocate pci_pbm_info.\n");
 		goto out_err;
 	}
 
-	iommu = kzalloc(sizeof(struct iommu), GFP_ATOMIC);
+	pbm->sibling = schizo_find_sibling(portid, chip_type);
+
+	iommu = kzalloc(sizeof(struct iommu), GFP_KERNEL);
 	if (!iommu) {
 		printk(KERN_ERR PFX "Cannot allocate PBM A iommu.\n");
-		goto out_free_controller;
+		goto out_free_pbm;
 	}
 
-	p->pbm_A.iommu = iommu;
+	pbm->iommu = iommu;
 
-	iommu = kzalloc(sizeof(struct iommu), GFP_ATOMIC);
-	if (!iommu) {
-		printk(KERN_ERR PFX "Cannot allocate PBM B iommu.\n");
-		goto out_free_iommu_A;
-	}
+	if (schizo_pbm_init(pbm, op, portid, chip_type))
+		goto out_free_iommu;
 
-	p->pbm_B.iommu = iommu;
+	if (pbm->sibling)
+		pbm->sibling->sibling = pbm;
 
-	if (schizo_pbm_init(p, op, portid, chip_type))
-		goto out_free_iommu_B;
+	dev_set_drvdata(&op->dev, pbm);
 
 	return 0;
 
-out_free_iommu_B:
-	kfree(p->pbm_B.iommu);
-
-out_free_iommu_A:
-	kfree(p->pbm_A.iommu);
+out_free_iommu:
+	kfree(pbm->iommu);
 
-out_free_controller:
-	kfree(p);
+out_free_pbm:
+	kfree(pbm);
 
 out_err:
 	return err;
diff --git a/arch/sparc64/kernel/pci_sun4v.c b/arch/sparc64/kernel/pci_sun4v.c
index 6bed2f6..233b22b 100644
--- a/arch/sparc64/kernel/pci_sun4v.c
+++ b/arch/sparc64/kernel/pci_sun4v.c
@@ -42,6 +42,7 @@ struct iommu_batch {
 };
 
 static DEFINE_PER_CPU(struct iommu_batch, iommu_batch);
+static int iommu_batch_initialized;
 
 /* Interrupts must be disabled.  */
 static inline void iommu_batch_start(struct device *dev, unsigned long prot, unsigned long entry)
@@ -887,21 +888,12 @@ static void pci_sun4v_msi_init(struct pci_pbm_info *pbm)
 }
 #endif /* !(CONFIG_PCI_MSI) */
 
-static int __init pci_sun4v_pbm_init(struct pci_controller_info *p,
+static int __init pci_sun4v_pbm_init(struct pci_pbm_info *pbm,
 				     struct of_device *op, u32 devhandle)
 {
 	struct device_node *dp = op->node;
-	struct pci_pbm_info *pbm;
 	int err;
 
-	if (devhandle & 0x40)
-		pbm = &p->pbm_B;
-	else
-		pbm = &p->pbm_A;
-
-	pbm->next = pci_pbm_root;
-	pci_pbm_root = pbm;
-
 	pbm->numa_node = of_node_to_nid(dp);
 
 	pbm->pci_ops = &sun4v_pci_ops;
@@ -909,7 +901,6 @@ static int __init pci_sun4v_pbm_init(struct pci_controller_info *p,
 
 	pbm->index = pci_num_pbms++;
 
-	pbm->parent = p;
 	pbm->prom_node = dp;
 
 	pbm->devhandle = devhandle;
@@ -931,6 +922,9 @@ static int __init pci_sun4v_pbm_init(struct pci_controller_info *p,
 
 	pci_sun4v_scan_bus(pbm, &op->dev);
 
+	pbm->next = pci_pbm_root;
+	pci_pbm_root = pbm;
+
 	return 0;
 }
 
@@ -939,7 +933,6 @@ static int __devinit pci_sun4v_probe(struct of_device *op,
 {
 	const struct linux_prom64_registers *regs;
 	static int hvapi_negotiated = 0;
-	struct pci_controller_info *p;
 	struct pci_pbm_info *pbm;
 	struct device_node *dp;
 	struct iommu *iommu;
@@ -972,51 +965,46 @@ static int __devinit pci_sun4v_probe(struct of_device *op,
 	}
 	devhandle = (regs->phys_addr >> 32UL) & 0x0fffffff;
 
-	for (pbm = pci_pbm_root; pbm; pbm = pbm->next) {
-		if (pbm->devhandle = (devhandle ^ 0x40)) {
-			return pci_sun4v_pbm_init(pbm->parent, op, devhandle);
-		}
-	}
-
 	err = -ENOMEM;
-	for_each_possible_cpu(i) {
-		unsigned long page = get_zeroed_page(GFP_ATOMIC);
+	if (!iommu_batch_initialized) {
+		for_each_possible_cpu(i) {
+			unsigned long page = get_zeroed_page(GFP_KERNEL);
 
-		if (!page)
-			goto out_err;
+			if (!page)
+				goto out_err;
 
-		per_cpu(iommu_batch, i).pglist = (u64 *) page;
+			per_cpu(iommu_batch, i).pglist = (u64 *) page;
+		}
+		iommu_batch_initialized = 1;
 	}
 
-	p = kzalloc(sizeof(struct pci_controller_info), GFP_ATOMIC);
-	if (!p) {
-		printk(KERN_ERR PFX "Could not allocate pci_controller_info\n");
+	pbm = kzalloc(sizeof(*pbm), GFP_KERNEL);
+	if (!pbm) {
+		printk(KERN_ERR PFX "Could not allocate pci_pbm_info\n");
 		goto out_err;
 	}
 
-	iommu = kzalloc(sizeof(struct iommu), GFP_ATOMIC);
+	iommu = kzalloc(sizeof(struct iommu), GFP_KERNEL);
 	if (!iommu) {
-		printk(KERN_ERR PFX "Could not allocate pbm A iommu\n");
+		printk(KERN_ERR PFX "Could not allocate pbm iommu\n");
 		goto out_free_controller;
 	}
 
-	p->pbm_A.iommu = iommu;
+	pbm->iommu = iommu;
 
-	iommu = kzalloc(sizeof(struct iommu), GFP_ATOMIC);
-	if (!iommu) {
-		printk(KERN_ERR PFX "Could not allocate pbm B iommu\n");
-		goto out_free_iommu_A;
-	}
+	err = pci_sun4v_pbm_init(pbm, op, devhandle);
+	if (err)
+		goto out_free_iommu;
 
-	p->pbm_B.iommu = iommu;
+	dev_set_drvdata(&op->dev, pbm);
 
-	return pci_sun4v_pbm_init(p, op, devhandle);
+	return 0;
 
-out_free_iommu_A:
-	kfree(p->pbm_A.iommu);
+out_free_iommu:
+	kfree(pbm->iommu);
 
 out_free_controller:
-	kfree(p);
+	kfree(pbm);
 
 out_err:
 	return err;
-- 
1.5.6.5.GIT

