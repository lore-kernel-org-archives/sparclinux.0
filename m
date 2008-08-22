From: David Miller <davem@davemloft.net>
Date: Fri, 22 Aug 2008 11:29:04 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100 - USB again
Message-Id: <20080822.042904.263474616.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>
Date: Thu, 21 Aug 2008 12:40:01 -0400 (EDT)

> On Thu, 21 Aug 2008, Meelis Roos wrote:
> 
> > > The earlier ohci_writel call is supposed to clear the RHSC
> > > interrupt-status bit.  You can test whether that worked by printing out
> > > 
> > > 	ohci_readl(ohci, &regs->intrstatus) & OHCI_INTR_RHSC
> > 
> > returns 64 always (seems to be OHCI_INTR_RHSC).
> 
> Possibly indicating that the interrupt is level-triggered rather than 
> edge-triggered.

Before the OHCI_INTR_RHSC disabling code was moved to the main OHCI
interrupt handler, it was happening after the root hub status was
read.

Perhaps that was important to clear the interrupt reliably?

Just for documentation, when an interrupt handler returns on sparc64
we hit the interrupt clear register for that interrupt source.  This
causes the state machine in the PCI controller (or wherever) to resample
the interrupt signal coming from the device.  If the device is still
showing an interrupt, we'll get another interrupt packet and go through
this sequence again.
