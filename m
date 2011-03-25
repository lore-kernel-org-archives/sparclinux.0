From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 25 Mar 2011 14:10:46 +0000
Subject: [patch 3/4] sparc: Convert to new irq function names
Message-Id: <20110325140947.124633841@linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Scripted with coccinelle.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/kernel/irq_64.c  |   24 ++++++++++--------------
 arch/sparc/kernel/pci.c     |    2 +-
 arch/sparc/kernel/pci_msi.c |   10 +++++-----
 3 files changed, 16 insertions(+), 20 deletions(-)

Index: linux-2.6-tip/arch/sparc/kernel/irq_64.c
=================================--- linux-2.6-tip.orig/arch/sparc/kernel/irq_64.c
+++ linux-2.6-tip/arch/sparc/kernel/irq_64.c
@@ -526,7 +526,7 @@ void irq_install_pre_handler(int irq,
 			     void (*func)(unsigned int, void *, void *),
 			     void *arg1, void *arg2)
 {
-	struct irq_handler_data *handler_data = get_irq_data(irq);
+	struct irq_handler_data *handler_data = irq_get_handler_data(irq);
 
 	handler_data->pre_handler = func;
 	handler_data->arg1 = arg1;
@@ -550,13 +550,11 @@ unsigned int build_irq(int inofixup, uns
 	if (!irq) {
 		irq = irq_alloc(0, ino);
 		bucket_set_irq(__pa(bucket), irq);
-		set_irq_chip_and_handler_name(irq,
-					      &sun4u_irq,
-					      handle_fasteoi_irq,
-					      "IVEC");
+		irq_set_chip_and_handler_name(irq, &sun4u_irq,
+					      handle_fasteoi_irq, "IVEC");
 	}
 
-	handler_data = get_irq_data(irq);
+	handler_data = irq_get_handler_data(irq);
 	if (unlikely(handler_data))
 		goto out;
 
@@ -565,7 +563,7 @@ unsigned int build_irq(int inofixup, uns
 		prom_printf("IRQ: kzalloc(irq_handler_data) failed.\n");
 		prom_halt();
 	}
-	set_irq_data(irq, handler_data);
+	irq_set_handler_data(irq, handler_data);
 
 	handler_data->imap  = imap;
 	handler_data->iclr  = iclr;
@@ -588,12 +586,11 @@ static unsigned int sun4v_build_common(u
 	if (!irq) {
 		irq = irq_alloc(0, sysino);
 		bucket_set_irq(__pa(bucket), irq);
-		set_irq_chip_and_handler_name(irq, chip,
-					      handle_fasteoi_irq,
+		irq_set_chip_and_handler_name(irq, chip, handle_fasteoi_irq,
 					      "IVEC");
 	}
 
-	handler_data = get_irq_data(irq);
+	handler_data = irq_get_handler_data(irq);
 	if (unlikely(handler_data))
 		goto out;
 
@@ -602,7 +599,7 @@ static unsigned int sun4v_build_common(u
 		prom_printf("IRQ: kzalloc(irq_handler_data) failed.\n");
 		prom_halt();
 	}
-	set_irq_data(irq, handler_data);
+	irq_set_handler_data(irq, handler_data);
 
 	/* Catch accidental accesses to these things.  IMAP/ICLR handling
 	 * is done by hypervisor calls on sun4v platforms, not by direct
@@ -647,8 +644,7 @@ unsigned int sun4v_build_virq(u32 devhan
 	irq = irq_alloc(devhandle, devino);
 	bucket_set_irq(__pa(bucket), irq);
 
-	set_irq_chip_and_handler_name(irq, &sun4v_virq,
-				      handle_fasteoi_irq,
+	irq_set_chip_and_handler_name(irq, &sun4v_virq, handle_fasteoi_irq,
 				      "IVEC");
 
 	handler_data = kzalloc(sizeof(struct irq_handler_data), GFP_ATOMIC);
@@ -660,7 +656,7 @@ unsigned int sun4v_build_virq(u32 devhan
 	 * the interrupt.
 	 */
 	irq_set_status_flags(IRQ_NOAUTOEN);
-	set_irq_data(irq, handler_data);
+	irq_set_handler_data(irq, handler_data);
 
 	/* Catch accidental accesses to these things.  IMAP/ICLR handling
 	 * is done by hypervisor calls on sun4v platforms, not by direct
Index: linux-2.6-tip/arch/sparc/kernel/pci.c
=================================--- linux-2.6-tip.orig/arch/sparc/kernel/pci.c
+++ linux-2.6-tip/arch/sparc/kernel/pci.c
@@ -1012,7 +1012,7 @@ int arch_setup_msi_irq(struct pci_dev *p
 
 void arch_teardown_msi_irq(unsigned int irq)
 {
-	struct msi_desc *entry = get_irq_msi(irq);
+	struct msi_desc *entry = irq_get_msi_desc(irq);
 	struct pci_dev *pdev = entry->dev;
 	struct pci_pbm_info *pbm = pdev->dev.archdata.host_controller;
 
Index: linux-2.6-tip/arch/sparc/kernel/pci_msi.c
=================================--- linux-2.6-tip.orig/arch/sparc/kernel/pci_msi.c
+++ linux-2.6-tip/arch/sparc/kernel/pci_msi.c
@@ -133,8 +133,8 @@ static int sparc64_setup_msi_irq(unsigne
 	if (!*irq_p)
 		goto out_err;
 
-	set_irq_chip_and_handler_name(*irq_p, &msi_irq,
-				      handle_simple_irq, "MSI");
+	irq_set_chip_and_handler_name(*irq_p, &msi_irq, handle_simple_irq,
+				      "MSI");
 
 	err = alloc_msi(pbm);
 	if (unlikely(err < 0))
@@ -160,7 +160,7 @@ static int sparc64_setup_msi_irq(unsigne
 	}
 	msg.data = msi;
 
-	set_irq_msi(*irq_p, entry);
+	irq_set_msi_desc(*irq_p, entry);
 	write_msi_msg(*irq_p, &msg);
 
 	return 0;
@@ -169,7 +169,7 @@ out_msi_free:
 	free_msi(pbm, msi);
 
 out_irq_free:
-	set_irq_chip(*irq_p, NULL);
+	irq_set_chip(*irq_p, NULL);
 	irq_free(*irq_p);
 	*irq_p = 0;
 
@@ -208,7 +208,7 @@ static void sparc64_teardown_msi_irq(uns
 
 	free_msi(pbm, msi_num);
 
-	set_irq_chip(irq, NULL);
+	irq_set_chip(irq, NULL);
 	irq_free(irq);
 }
 


