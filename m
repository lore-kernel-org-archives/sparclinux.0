From: David Miller <davem@davemloft.net>
Date: Fri, 12 Sep 2008 22:14:28 +0000
Subject: Re: psycho_irq_build: Wacky INO [3c]
Message-Id: <20080912.151428.258325847.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Fri, 12 Sep 2008 14:01:11 +0300 (EEST)

> > Can you boot this machine with "of_debug=3" and send me the
> > output?
> 
> The same kernel with of_debug=3:

Ok, we do reall need to pass IRQF_SHARED to request_irq().

This patch below should fix it.

Please get me that bootup log with the sunhme.c debugging patch
applied so we can fix that too.

sparc64: Fix PCI error interrupt registry on PSYCHO.

We need to pass IRQF_SHARED, otherwise we get things like:

IRQ handler type mismatch for IRQ 33
current handler: PSYCHO_UE
Call Trace:
 [000000000048394c] request_irq+0xac/0x120
 [00000000007c5f6c] psycho_scan_bus+0x98/0x158
 [00000000007c2bc0] pcibios_init+0xdc/0x12c
 [0000000000426a5c] do_one_initcall+0x1c/0x160
 [00000000007c0180] kernel_init+0x9c/0xfc
 [0000000000427050] kernel_thread+0x30/0x60
 [00000000006ae1d0] rest_init+0x10/0x60

on e3500 and similar systems.

On a single board, the UE interrupts of two Psycho nodes
are funneled through the same interrupt, from of_debug=3
dump:

/pci@b,4000: direct translate 2ee --> 21
 ...
/pci@b,2000: direct translate 2ee --> 21

Decimal "33" mentioned above is the hex "21" mentioned here.

Thanks to Meelis Roos for dumps and testing.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc64/kernel/pci_psycho.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sparc64/kernel/pci_psycho.c b/arch/sparc64/kernel/pci_psycho.c
index ef5fe29..e205ade 100644
--- a/arch/sparc64/kernel/pci_psycho.c
+++ b/arch/sparc64/kernel/pci_psycho.c
@@ -744,16 +744,16 @@ static void psycho_register_error_handlers(struct pci_pbm_info *pbm)
 	 * the second will just error out since we do not pass in
 	 * IRQF_SHARED.
 	 */
-	err = request_irq(op->irqs[1], psycho_ue_intr, 0,
+	err = request_irq(op->irqs[1], psycho_ue_intr, IRQF_SHARED,
 			  "PSYCHO_UE", pbm);
-	err = request_irq(op->irqs[2], psycho_ce_intr, 0,
+	err = request_irq(op->irqs[2], psycho_ce_intr, IRQF_SHARED,
 			  "PSYCHO_CE", pbm);
 
 	/* This one, however, ought not to fail.  We can just warn
 	 * about it since the system can still operate properly even
 	 * if this fails.
 	 */
-	err = request_irq(op->irqs[0], psycho_pcierr_intr, 0,
+	err = request_irq(op->irqs[0], psycho_pcierr_intr, IRQF_SHARED,
 			  "PSYCHO_PCIERR", pbm);
 	if (err)
 		printk(KERN_WARNING "%s: Could not register PCIERR, "
-- 
1.5.6.5.GIT

