From: Meelis Roos <mroos@ut.ee>
Date: Thu, 21 Aug 2008 15:30:11 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100 - USB again
Message-Id: <Pine.SOC.4.64.0808211825310.28650@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> The ohci_writel call near the end is supposed to clear the RHSC
> interrupt-enable bit.  You can tell whether it worked by printing out
> the value of
> 
> 	ohci_readl(ohci, &regs->intrenable) & OHCI_INTR_RHSC
> 
> immediately afterward.

returns 0 always.

> The earlier ohci_writel call is supposed to clear the RHSC
> interrupt-status bit.  You can test whether that worked by printing out
> 
> 	ohci_readl(ohci, &regs->intrstatus) & OHCI_INTR_RHSC

returns 64 always (seems to be OHCI_INTR_RHSC).

> In addition, you should take a look at ohci_rhsc_enable() in
> ohci-hub.c.  That's the place where RHSC interrupts get re-enabled, so
> make sure it isn't getting called by mistake.

It seems to be always called from usb_enable_root_hub_irq:

Call Trace:
 [0000000000455dec] warn_slowpath+0x6c/0xa0
 [0000000010052404] ohci_rhsc_enable+0x24/0x80 [ohci_hcd]
 [0000000010015978] usb_enable_root_hub_irq+0x38/0x60 [usbcore]
 [0000000010015308] hub_thread+0xe48/0x1340 [usbcore]
 [000000000046e36c] kthread+0x4c/0x80
 [000000000042723c] kernel_thread+0x3c/0x60
 [000000000046e2a8] kthreadd+0x168/0x1e0


-- 
Meelis Roos (mroos@ut.ee)      http://www.cs.ut.ee/~mroos/
