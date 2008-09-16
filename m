From: David Miller <davem@davemloft.net>
Date: Tue, 16 Sep 2008 00:29:29 +0000
Subject: Re: psycho_irq_build: Wacky INO [3c]
Message-Id: <20080915.172929.266363437.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@ut.ee>
Date: Sun, 14 Sep 2008 23:13:25 +0300 (EEST)

> PCI: Scanning PBM /pci@b,2000
> Unable to handle kernel NULL pointer dereference
> tsk->{mm,active_mm}->context = 0000000000000000
> tsk->{mm,active_mm}->pgd = fffff800007e905c
>               \|/ ____ \|/
>               "@'/ .. \`@"
>               /_| \__/ |_\
>                  \__U_/
> swapper(1): Oops [#1]
> TSTATE: 0000000080f01601 TPC: 000000000043dd48 TNPC: 000000000043dd4c Y: 00000000    Not tainted
> TPC: <psycho_pcierr_intr+0xa8/0x360>

Please try this patch:

diff --git a/arch/sparc64/kernel/pci_psycho.c b/arch/sparc64/kernel/pci_psycho.c
index e205ade..f85b6be 100644
--- a/arch/sparc64/kernel/pci_psycho.c
+++ b/arch/sparc64/kernel/pci_psycho.c
@@ -575,7 +575,7 @@ static irqreturn_t psycho_pcierr_intr_other(struct pci_pbm_info *pbm, int is_pbm
 {
 	unsigned long csr_reg, csr, csr_error_bits;
 	irqreturn_t ret = IRQ_NONE;
-	u16 stat;
+	u16 stat, *addr;
 
 	if (is_pbm_a) {
 		csr_reg = pbm->controller_regs + PSYCHO_PCIA_CTRL;
@@ -597,7 +597,9 @@ static irqreturn_t psycho_pcierr_intr_other(struct pci_pbm_info *pbm, int is_pbm
 			printk("%s: PCI SERR signal asserted.\n", pbm->name);
 		ret = IRQ_HANDLED;
 	}
-	pci_read_config_word(pbm->pci_bus->self, PCI_STATUS, &stat);
+	addr = psycho_pci_config_mkaddr(pbm, pbm->pci_first_busno,
+					0, PCI_STATUS);
+	pci_config_read16(addr, &stat);
 	if (stat & (PCI_STATUS_PARITY |
 		    PCI_STATUS_SIG_TARGET_ABORT |
 		    PCI_STATUS_REC_TARGET_ABORT |
@@ -605,7 +607,7 @@ static irqreturn_t psycho_pcierr_intr_other(struct pci_pbm_info *pbm, int is_pbm
 		    PCI_STATUS_SIG_SYSTEM_ERROR)) {
 		printk("%s: PCI bus error, PCI_STATUS[%04x]\n",
 		       pbm->name, stat);
-		pci_write_config_word(pbm->pci_bus->self, PCI_STATUS, 0xffff);
+		pci_config_write16(addr, 0xffff);
 		ret = IRQ_HANDLED;
 	}
 	return ret;
