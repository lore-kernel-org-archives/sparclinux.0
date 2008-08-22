From: Alan Stern <stern@rowland.harvard.edu>
Date: Fri, 22 Aug 2008 16:09:26 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100 - USB again
Message-Id: <Pine.LNX.4.44L0.0808221205040.2230-100000@iolanthe.rowland.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 22 Aug 2008, David Miller wrote:

> Before the OHCI_INTR_RHSC disabling code was moved to the main OHCI
> interrupt handler, it was happening after the root hub status was
> read.
> 
> Perhaps that was important to clear the interrupt reliably?

I don't see why reading the root-hub status should affect whether the 
interrupt gets cleared, but then who knows what bizarre thoughts lurk 
in the minds of chip designers...

Meelis, in keeping with David's suggestion about posting the PCI 
writes, you ought to apply this patch along with the previous one.
I doubt it will make any difference, but it's worth doing anyway.

Alan Stern


Index: usb-2.6/drivers/usb/host/ohci-hcd.c
=================================--- usb-2.6.orig/drivers/usb/host/ohci-hcd.c
+++ usb-2.6/drivers/usb/host/ohci-hcd.c
@@ -879,10 +879,10 @@ static irqreturn_t ohci_irq (struct usb_
 	if (HC_IS_RUNNING(hcd->state)) {
 		ohci_writel (ohci, ints, &regs->intrstatus);
 		ohci_writel (ohci, OHCI_INTR_MIE, &regs->intrenable);
-		// flush those writes
-		(void) ohci_readl (ohci, &ohci->regs->control);
 	}
 
+	/* flush all writes */
+	ohci_readl(ohci, &ohci->regs->control);
 	return IRQ_HANDLED;
 }
 

