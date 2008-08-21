From: Alan Stern <stern@rowland.harvard.edu>
Date: Thu, 21 Aug 2008 16:40:01 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100 - USB again
Message-Id: <Pine.LNX.4.44L0.0808211233150.2786-100000@iolanthe.rowland.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 21 Aug 2008, Meelis Roos wrote:

> > The ohci_writel call near the end is supposed to clear the RHSC
> > interrupt-enable bit.  You can tell whether it worked by printing out
> > the value of
> > 
> > 	ohci_readl(ohci, &regs->intrenable) & OHCI_INTR_RHSC
> > 
> > immediately afterward.
> 
> returns 0 always.

Okay, so that's working.

> > The earlier ohci_writel call is supposed to clear the RHSC
> > interrupt-status bit.  You can test whether that worked by printing out
> > 
> > 	ohci_readl(ohci, &regs->intrstatus) & OHCI_INTR_RHSC
> 
> returns 64 always (seems to be OHCI_INTR_RHSC).

Possibly indicating that the interrupt is level-triggered rather than 
edge-triggered.

> > In addition, you should take a look at ohci_rhsc_enable() in
> > ohci-hub.c.  That's the place where RHSC interrupts get re-enabled, so
> > make sure it isn't getting called by mistake.
> 
> It seems to be always called from usb_enable_root_hub_irq:

That's how it's supposed to be called.  The question remains whether it
always gets called between invocations of ohci_irq().  The log you
posted seemed to indicate that it wasn't.

Incidentally, this patch might very well affect your problem:

	http://marc.info/?l=linux-usb&m1926736707452&w=2

It may not apply exactly as-is to 2.6.27-rc4 because it was made 
against a development tree, but you should be able to adjust it easily 
enough.

Alan Stern

P.S.: For future logging it would help if you enable 
CONFIG_PRINTK_TIME.

