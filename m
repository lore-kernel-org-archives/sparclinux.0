From: David Miller <davem@davemloft.net>
Date: Fri, 31 Oct 2014 17:18:49 +0000
Subject: Re: NULL dereference in schizo error handler
Message-Id: <20141031.131849.1633021968682883859.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.11.1410260022340.19758@adalberg.ut.ee>
In-Reply-To: <alpine.LRH.2.11.1410260022340.19758@adalberg.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Sun, 26 Oct 2014 00:35:28 +0300 (EEST)

> I understand there is a bug in earlier revisions of Schizo PCI bridge 
> (that I have in my V480) and we do not have a workaround for that. Now 
> when I happen to hit it, I get a crash in the handler and that seems a 
> bug whether or not we have the workaround.
> 
> In particular, it seems that pbm->pci_bus->self is NULL and that causes 
> a NULL pointer dereference in schizo_pcierr_intr_other:
> 
> pci_read_config_word(pbm->pci_bus->self, PCI_STATUS, &stat);
> 
> Since the error happens during PCI scanning, maybe we just do not have 
> this field initialized yet - in pci_scan_one_pbm() or in something it 
> calls?

I am looking into this now.  Any chance I can get a prtconf dump?

This schizo error handler definitely needs to be adjusted.  The
bus->self value is not necessarily going to be there.  In fact
often it won't be.

The PCI controller's themselves don't show up in the device tree as
bonafide PCI devices, so we don't instantiate them with the PCI
subsystem, and therefore bus->self never takes on a non-NULL value.

If you look at arch/sparc/kernel/psycho_common.c:psycho_pcierr_intr_other()
it addresses this by doing the PCI config space access by hand, thus
avoiding the bus->self dereference.

Meanwhile, this patch might allow things to get further:

diff --git a/arch/sparc/kernel/pci_schizo.c b/arch/sparc/kernel/pci_schizo.c
index 8f76f23..f9c6813 100644
--- a/arch/sparc/kernel/pci_schizo.c
+++ b/arch/sparc/kernel/pci_schizo.c
@@ -581,7 +581,7 @@ static irqreturn_t schizo_pcierr_intr_other(struct pci_pbm_info *pbm)
 {
 	unsigned long csr_reg, csr, csr_error_bits;
 	irqreturn_t ret = IRQ_NONE;
-	u16 stat;
+	u32 stat;
 
 	csr_reg = pbm->pbm_regs + SCHIZO_PCI_CTRL;
 	csr = upa_readq(csr_reg);
@@ -617,7 +617,7 @@ static irqreturn_t schizo_pcierr_intr_other(struct pci_pbm_info *pbm)
 			       pbm->name);
 		ret = IRQ_HANDLED;
 	}
-	pci_read_config_word(pbm->pci_bus->self, PCI_STATUS, &stat);
+	pbm->pci_ops->read(pbm->pci_bus, 0, PCI_STATUS, 2, &stat);
 	if (stat & (PCI_STATUS_PARITY |
 		    PCI_STATUS_SIG_TARGET_ABORT |
 		    PCI_STATUS_REC_TARGET_ABORT |
@@ -625,7 +625,7 @@ static irqreturn_t schizo_pcierr_intr_other(struct pci_pbm_info *pbm)
 		    PCI_STATUS_SIG_SYSTEM_ERROR)) {
 		printk("%s: PCI bus error, PCI_STATUS[%04x]\n",
 		       pbm->name, stat);
-		pci_write_config_word(pbm->pci_bus->self, PCI_STATUS, 0xffff);
+		pbm->pci_ops->write(pbm->pci_bus, 0, PCI_STATUS, 2, 0xffff);
 		ret = IRQ_HANDLED;
 	}
 	return ret;
