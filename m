From: Alan Stern <stern@rowland.harvard.edu>
Date: Fri, 22 Aug 2008 15:56:18 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100 - USB again
Message-Id: <Pine.LNX.4.44L0.0808221138550.2230-100000@iolanthe.rowland.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 22 Aug 2008, Meelis Roos wrote:

> I removed my debugging printks, leaving just the patch applied, and 
> retried.
> 
> First time it hung in pata_ali startup again.
> 
> Second time it got to the ohci code and hung there:

Okay, then let's get a little more information.  Leave out your 
debugging printks and add the ones below instead (and keep my earlier 
patch).

Also, if you can, increase the serial console baud rate.  (On the boot
command line, put something like "console=ttyS0,115200", or whatever is
appropriate for Sparcs.)  That should help reduce the console
transmission delays.

Alan Stern



Index: usb-2.6/drivers/usb/host/ohci-hcd.c
=================================--- usb-2.6.orig/drivers/usb/host/ohci-hcd.c
+++ usb-2.6/drivers/usb/host/ohci-hcd.c
@@ -757,6 +757,8 @@ static irqreturn_t ohci_irq (struct usb_
 	 * work on all systems (edge triggering for OHCI can be a factor).
 	 */
 	ints = ohci_readl(ohci, &regs->intrstatus);
+	ohci_info(ohci, "irq status %x enable %x\n", ints,
+			ohci_readl(ohci, &regs->intrenable));
 
 	/* Check for an all 1's result which is a typical consequence
 	 * of dead, unclocked, or unplugged (CardBus...) devices
Index: usb-2.6/drivers/usb/host/ohci-hub.c
=================================--- usb-2.6.orig/drivers/usb/host/ohci-hub.c
+++ usb-2.6/drivers/usb/host/ohci-hub.c
@@ -365,6 +365,8 @@ static int ohci_root_hub_state_changes(s
 	int	rhsc;
 
 	rhsc = ohci_readl(ohci, &ohci->regs->intrenable) & OHCI_INTR_RHSC;
+	ohci_info(ohci, "state changed %d rhsc %x\n", changed, rhsc);
+
 	switch (ohci->hc_control & OHCI_CTRL_HCFS) {
 
 	case OHCI_USB_OPER:

