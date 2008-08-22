From: David Miller <davem@davemloft.net>
Date: Fri, 22 Aug 2008 11:01:47 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100 - USB again
Message-Id: <20080822.040147.42645091.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@ut.ee>
Date: Thu, 21 Aug 2008 23:04:21 +0300 (EEST)

> Does this mean that the looping used up all the stack??

I think it does, there are similar messages right before the wedge
in some of your other traces.

I wonder if the PCI write gets posted.

I took a look at the commit that moved the OHCI_INTR_RHSC disabling
code to ohci_irq() (from ohci_hub_status_data()) and the code wasn't
copied exactly:

commit 052ac01aeb84d8427ba8ac3d70991ac01b009b59
Author: Alan Stern <stern@rowland.harvard.edu>
Date:   Fri Oct 27 10:33:11 2006 -0400

    USB: OHCI: disable RHSC inside interrupt handler
    
    This patch (as808b) moves the Root Hub Status Change interrupt-disable
    code in ohci-hcd back into the interrupt handler proper, to avoid the
    chance of adverse interactions with mediocre hardware implementations.
    
    It also deletes the root-hub status timer from within the interrupt-enable
    routine.  There's no need to poll for status any more once interrupts are
    re-enabled.
    
    Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
    Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

The old code goes:

-		ohci_writel (ohci, OHCI_INTR_RHSC, &ohci->regs->intrdisable);
-		(void) ohci_readl (ohci, &ohci->regs->intrdisable);

The new code goes:

+		ohci_writel(ohci, OHCI_INTR_RHSC, &regs->intrdisable);

I guess it is expected that the ohci_hub_status_data() call will always
do some kind of ohci_readl() to flush the write.

It's a long shot, but does this patch fix the problem?

diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 8990196..51065b7 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -809,6 +809,7 @@ static irqreturn_t ohci_irq (struct usb_hcd *hcd)
 		 * re-enables it.
 		 */
 		ohci_writel(ohci, OHCI_INTR_RHSC, &regs->intrdisable);
+		(void) ohci_readl (ohci, &regs->intrdisable);
 		usb_hcd_poll_rh_status(hcd);
 	}
 
