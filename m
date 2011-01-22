From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 22 Jan 2011 21:32:20 +0000
Subject: [PATCH 7/7] sparc64: rename virt_irq => irq - II
Message-Id: <1295731940-31697-7-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The generic irq support uses the term 'irq' for the
allocated irq number.
Fix it so sparc64 use the same term for an irq as the
generic irq support does.
For a naive reader this is less confusing.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/irq_64.h   |   18 +++++++-------
 arch/sparc/kernel/pci.c           |   10 ++++----
 arch/sparc/kernel/pci_fire.c      |    8 +++---
 arch/sparc/kernel/pci_impl.h      |    4 +-
 arch/sparc/kernel/pci_msi.c       |   44 ++++++++++++++++++------------------
 arch/sparc/kernel/pci_sun4v.c     |    6 ++--
 arch/sparc/kernel/prom_irqtrans.c |   16 ++++++------
 7 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/arch/sparc/include/asm/irq_64.h b/arch/sparc/include/asm/irq_64.h
index a0b443c..4f09666 100644
--- a/arch/sparc/include/asm/irq_64.h
+++ b/arch/sparc/include/asm/irq_64.h
@@ -33,34 +33,34 @@
 
 /* The largest number of unique interrupt sources we support.
  * If this needs to ever be larger than 255, you need to change
- * the type of ino_bucket->virt_irq as appropriate.
+ * the type of ino_bucket->irq as appropriate.
  *
- * ino_bucket->virt_irq allocation is made during {sun4v_,}build_irq().
+ * ino_bucket->irq allocation is made during {sun4v_,}build_irq().
  */
 #define NR_IRQS    255
 
-extern void irq_install_pre_handler(int virt_irq,
+extern void irq_install_pre_handler(int irq,
 				    void (*func)(unsigned int, void *, void *),
 				    void *arg1, void *arg2);
 #define irq_canonicalize(irq)	(irq)
 extern unsigned int build_irq(int inofixup, unsigned long iclr, unsigned long imap);
 extern unsigned int sun4v_build_irq(u32 devhandle, unsigned int devino);
 extern unsigned int sun4v_build_virq(u32 devhandle, unsigned int devino);
-extern unsigned int sun4v_build_msi(u32 devhandle, unsigned int *virt_irq_p,
+extern unsigned int sun4v_build_msi(u32 devhandle, unsigned int *irq_p,
 				    unsigned int msi_devino_start,
 				    unsigned int msi_devino_end);
-extern void sun4v_destroy_msi(unsigned int virt_irq);
-extern unsigned int sun4u_build_msi(u32 portid, unsigned int *virt_irq_p,
+extern void sun4v_destroy_msi(unsigned int irq);
+extern unsigned int sun4u_build_msi(u32 portid, unsigned int *irq_p,
 				    unsigned int msi_devino_start,
 				    unsigned int msi_devino_end,
 				    unsigned long imap_base,
 				    unsigned long iclr_base);
-extern void sun4u_destroy_msi(unsigned int virt_irq);
+extern void sun4u_destroy_msi(unsigned int irq);
 
-extern unsigned char virt_irq_alloc(unsigned int dev_handle,
+extern unsigned char irq_alloc(unsigned int dev_handle,
 				    unsigned int dev_ino);
 #ifdef CONFIG_PCI_MSI
-extern void virt_irq_free(unsigned int virt_irq);
+extern void irq_free(unsigned int irq);
 #endif
 
 extern void __init init_IRQ(void);
diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 4137579..bfede51 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -1001,22 +1001,22 @@ EXPORT_SYMBOL(pci_domain_nr);
 int arch_setup_msi_irq(struct pci_dev *pdev, struct msi_desc *desc)
 {
 	struct pci_pbm_info *pbm = pdev->dev.archdata.host_controller;
-	unsigned int virt_irq;
+	unsigned int irq;
 
 	if (!pbm->setup_msi_irq)
 		return -EINVAL;
 
-	return pbm->setup_msi_irq(&virt_irq, pdev, desc);
+	return pbm->setup_msi_irq(&irq, pdev, desc);
 }
 
-void arch_teardown_msi_irq(unsigned int virt_irq)
+void arch_teardown_msi_irq(unsigned int irq)
 {
-	struct msi_desc *entry = get_irq_msi(virt_irq);
+	struct msi_desc *entry = get_irq_msi(irq);
 	struct pci_dev *pdev = entry->dev;
 	struct pci_pbm_info *pbm = pdev->dev.archdata.host_controller;
 
 	if (pbm->teardown_msi_irq)
-		pbm->teardown_msi_irq(virt_irq, pdev);
+		pbm->teardown_msi_irq(irq, pdev);
 }
 #endif /* !(CONFIG_PCI_MSI) */
 
diff --git a/arch/sparc/kernel/pci_fire.c b/arch/sparc/kernel/pci_fire.c
index efb896d..539d3a8 100644
--- a/arch/sparc/kernel/pci_fire.c
+++ b/arch/sparc/kernel/pci_fire.c
@@ -277,7 +277,7 @@ static int pci_fire_msiq_build_irq(struct pci_pbm_info *pbm,
 {
 	unsigned long cregs = (unsigned long) pbm->pbm_regs;
 	unsigned long imap_reg, iclr_reg, int_ctrlr;
-	unsigned int virt_irq;
+	unsigned int irq;
 	int fixup;
 	u64 val;
 
@@ -293,14 +293,14 @@ static int pci_fire_msiq_build_irq(struct pci_pbm_info *pbm,
 
 	fixup = ((pbm->portid << 6) | devino) - int_ctrlr;
 
-	virt_irq = build_irq(fixup, iclr_reg, imap_reg);
-	if (!virt_irq)
+	irq = build_irq(fixup, iclr_reg, imap_reg);
+	if (!irq)
 		return -ENOMEM;
 
 	upa_writeq(EVENT_QUEUE_CONTROL_SET_EN,
 		   pbm->pbm_regs + EVENT_QUEUE_CONTROL_SET(msiqid));
 
-	return virt_irq;
+	return irq;
 }
 
 static const struct sparc64_msiq_ops pci_fire_msiq_ops = {
diff --git a/arch/sparc/kernel/pci_impl.h b/arch/sparc/kernel/pci_impl.h
index e20ed5f..6beb60d 100644
--- a/arch/sparc/kernel/pci_impl.h
+++ b/arch/sparc/kernel/pci_impl.h
@@ -131,9 +131,9 @@ struct pci_pbm_info {
 	void				*msi_queues;
 	unsigned long			*msi_bitmap;
 	unsigned int			*msi_irq_table;
-	int (*setup_msi_irq)(unsigned int *virt_irq_p, struct pci_dev *pdev,
+	int (*setup_msi_irq)(unsigned int *irq_p, struct pci_dev *pdev,
 			     struct msi_desc *entry);
-	void (*teardown_msi_irq)(unsigned int virt_irq, struct pci_dev *pdev);
+	void (*teardown_msi_irq)(unsigned int irq, struct pci_dev *pdev);
 	const struct sparc64_msiq_ops	*msi_ops;
 #endif /* !(CONFIG_PCI_MSI) */
 
diff --git a/arch/sparc/kernel/pci_msi.c b/arch/sparc/kernel/pci_msi.c
index b210416..550e937 100644
--- a/arch/sparc/kernel/pci_msi.c
+++ b/arch/sparc/kernel/pci_msi.c
@@ -31,12 +31,12 @@ static irqreturn_t sparc64_msiq_interrupt(int irq, void *cookie)
 		err = ops->dequeue_msi(pbm, msiqid, &head, &msi);
 		if (likely(err > 0)) {
 			struct irq_desc *desc;
-			unsigned int virt_irq;
+			unsigned int irq;
 
-			virt_irq = pbm->msi_irq_table[msi - pbm->msi_first];
-			desc = irq_desc + virt_irq;
+			irq = pbm->msi_irq_table[msi - pbm->msi_first];
+			desc = irq_desc + irq;
 
-			desc->handle_irq(virt_irq, desc);
+			desc->handle_irq(irq, desc);
 		}
 
 		if (unlikely(err < 0))
@@ -121,7 +121,7 @@ static struct irq_chip msi_irq = {
 	/* XXX affinity XXX */
 };
 
-static int sparc64_setup_msi_irq(unsigned int *virt_irq_p,
+static int sparc64_setup_msi_irq(unsigned int *irq_p,
 				 struct pci_dev *pdev,
 				 struct msi_desc *entry)
 {
@@ -131,17 +131,17 @@ static int sparc64_setup_msi_irq(unsigned int *virt_irq_p,
 	int msi, err;
 	u32 msiqid;
 
-	*virt_irq_p = virt_irq_alloc(0, 0);
+	*irq_p = irq_alloc(0, 0);
 	err = -ENOMEM;
-	if (!*virt_irq_p)
+	if (!*irq_p)
 		goto out_err;
 
-	set_irq_chip_and_handler_name(*virt_irq_p, &msi_irq,
+	set_irq_chip_and_handler_name(*irq_p, &msi_irq,
 				      handle_simple_irq, "MSI");
 
 	err = alloc_msi(pbm);
 	if (unlikely(err < 0))
-		goto out_virt_irq_free;
+		goto out_irq_free;
 
 	msi = err;
 
@@ -152,7 +152,7 @@ static int sparc64_setup_msi_irq(unsigned int *virt_irq_p,
 	if (err)
 		goto out_msi_free;
 
-	pbm->msi_irq_table[msi - pbm->msi_first] = *virt_irq_p;
+	pbm->msi_irq_table[msi - pbm->msi_first] = *irq_p;
 
 	if (entry->msi_attrib.is_64) {
 		msg.address_hi = pbm->msi64_start >> 32;
@@ -163,24 +163,24 @@ static int sparc64_setup_msi_irq(unsigned int *virt_irq_p,
 	}
 	msg.data = msi;
 
-	set_irq_msi(*virt_irq_p, entry);
-	write_msi_msg(*virt_irq_p, &msg);
+	set_irq_msi(*irq_p, entry);
+	write_msi_msg(*irq_p, &msg);
 
 	return 0;
 
 out_msi_free:
 	free_msi(pbm, msi);
 
-out_virt_irq_free:
-	set_irq_chip(*virt_irq_p, NULL);
-	virt_irq_free(*virt_irq_p);
-	*virt_irq_p = 0;
+out_irq_free:
+	set_irq_chip(*irq_p, NULL);
+	irq_free(*irq_p);
+	*irq_p = 0;
 
 out_err:
 	return err;
 }
 
-static void sparc64_teardown_msi_irq(unsigned int virt_irq,
+static void sparc64_teardown_msi_irq(unsigned int irq,
 				     struct pci_dev *pdev)
 {
 	struct pci_pbm_info *pbm = pdev->dev.archdata.host_controller;
@@ -189,12 +189,12 @@ static void sparc64_teardown_msi_irq(unsigned int virt_irq,
 	int i, err;
 
 	for (i = 0; i < pbm->msi_num; i++) {
-		if (pbm->msi_irq_table[i] = virt_irq)
+		if (pbm->msi_irq_table[i] = irq)
 			break;
 	}
 	if (i >= pbm->msi_num) {
 		printk(KERN_ERR "%s: teardown: No MSI for irq %u\n",
-		       pbm->name, virt_irq);
+		       pbm->name, irq);
 		return;
 	}
 
@@ -205,14 +205,14 @@ static void sparc64_teardown_msi_irq(unsigned int virt_irq,
 	if (err) {
 		printk(KERN_ERR "%s: teardown: ops->teardown() on MSI %u, "
 		       "irq %u, gives error %d\n",
-		       pbm->name, msi_num, virt_irq, err);
+		       pbm->name, msi_num, irq, err);
 		return;
 	}
 
 	free_msi(pbm, msi_num);
 
-	set_irq_chip(virt_irq, NULL);
-	virt_irq_free(virt_irq);
+	set_irq_chip(irq, NULL);
+	irq_free(irq);
 }
 
 static int msi_bitmap_alloc(struct pci_pbm_info *pbm)
diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index 743344a..825c4a0 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -844,9 +844,9 @@ static int pci_sun4v_msiq_build_irq(struct pci_pbm_info *pbm,
 				    unsigned long msiqid,
 				    unsigned long devino)
 {
-	unsigned int virt_irq = sun4v_build_irq(pbm->devhandle, devino);
+	unsigned int irq = sun4v_build_irq(pbm->devhandle, devino);
 
-	if (!virt_irq)
+	if (!irq)
 		return -ENOMEM;
 
 	if (pci_sun4v_msiq_setstate(pbm->devhandle, msiqid, HV_MSIQSTATE_IDLE))
@@ -854,7 +854,7 @@ static int pci_sun4v_msiq_build_irq(struct pci_pbm_info *pbm,
 	if (pci_sun4v_msiq_setvalid(pbm->devhandle, msiqid, HV_MSIQ_VALID))
 		return -EINVAL;
 
-	return virt_irq;
+	return irq;
 }
 
 static const struct sparc64_msiq_ops pci_sun4v_msiq_ops = {
diff --git a/arch/sparc/kernel/prom_irqtrans.c b/arch/sparc/kernel/prom_irqtrans.c
index ce65114..570b98f 100644
--- a/arch/sparc/kernel/prom_irqtrans.c
+++ b/arch/sparc/kernel/prom_irqtrans.c
@@ -227,7 +227,7 @@ static unsigned int sabre_irq_build(struct device_node *dp,
 	unsigned long imap, iclr;
 	unsigned long imap_off, iclr_off;
 	int inofixup = 0;
-	int virt_irq;
+	int irq;
 
 	ino &= 0x3f;
 	if (ino < SABRE_ONBOARD_IRQ_BASE) {
@@ -247,7 +247,7 @@ static unsigned int sabre_irq_build(struct device_node *dp,
 	if ((ino & 0x20) = 0)
 		inofixup = ino & 0x03;
 
-	virt_irq = build_irq(inofixup, iclr, imap);
+	irq = build_irq(inofixup, iclr, imap);
 
 	/* If the parent device is a PCI<->PCI bridge other than
 	 * APB, we have to install a pre-handler to ensure that
@@ -256,13 +256,13 @@ static unsigned int sabre_irq_build(struct device_node *dp,
 	 */
 	regs = of_get_property(dp, "reg", NULL);
 	if (regs && sabre_device_needs_wsync(dp)) {
-		irq_install_pre_handler(virt_irq,
+		irq_install_pre_handler(irq,
 					sabre_wsync_handler,
 					(void *) (long) regs->phys_hi,
 					(void *) irq_data);
 	}
 
-	return virt_irq;
+	return irq;
 }
 
 static void __init sabre_irq_trans_init(struct device_node *dp)
@@ -382,7 +382,7 @@ static unsigned int schizo_irq_build(struct device_node *dp,
 	unsigned long pbm_regs = irq_data->pbm_regs;
 	unsigned long imap, iclr;
 	int ign_fixup;
-	int virt_irq;
+	int irq;
 	int is_tomatillo;
 
 	ino &= 0x3f;
@@ -409,17 +409,17 @@ static unsigned int schizo_irq_build(struct device_node *dp,
 			ign_fixup = (1 << 6);
 	}
 
-	virt_irq = build_irq(ign_fixup, iclr, imap);
+	irq = build_irq(ign_fixup, iclr, imap);
 
 	if (is_tomatillo) {
-		irq_install_pre_handler(virt_irq,
+		irq_install_pre_handler(irq,
 					tomatillo_wsync_handler,
 					((irq_data->chip_version <= 4) ?
 					 (void *) 1 : (void *) 0),
 					(void *) irq_data->sync_reg);
 	}
 
-	return virt_irq;
+	return irq;
 }
 
 static void __init __schizo_irq_trans_init(struct device_node *dp,
-- 
1.6.0.6

