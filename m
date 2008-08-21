From: Alan Stern <stern@rowland.harvard.edu>
Date: Thu, 21 Aug 2008 14:46:03 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100 - USB again
Message-Id: <Pine.LNX.4.44L0.0808211028530.2659-100000@iolanthe.rowland.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Thu, 21 Aug 2008, Meelis Roos wrote:

> > But please turn this thing off and see if that clears everything
> > up.
>=20
> Well, it cleared the strange hang up and got to USB problem again.
> Now I can see the looping in usb startup. Note that there really is a=20
> 'getting stuck' mesasage somewhere down in the messages.

> usb_hcd_poll_rh_status start
> usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFfff8006e0f18c0=
=20
> usb_hcd_poll_rh_status before hub_status_data
> ohci_hub_status_data before spin_lock_irqsave
> ohci_hub_status_data after spin_lock_irqsave
> ohci_hub_status_data return
> usb_hcd_poll_rh_status after hub_status_data
> hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000

> ...
> (and so on)

Okay.  My theory is that your OHCI controller hardware is defective and
is failing to turn off one of the interrupt-enable bits when it should. =20
Thus your CPU gets caught in a permanent interrupt loop.

That is, in ohci-hcd.c:ohci_irq(), this code is running over and over:

	if (ints & OHCI_INTR_RHSC) {
		ohci_vdbg(ohci, "rhsc\n");
		ohci->next_statechange =3D jiffies + STATECHANGE_DELAY;
		ohci_writel(ohci, OHCI_INTR_RD | OHCI_INTR_RHSC,
				&regs->intrstatus);

		/* NOTE: Vendors didn't always make the same implementation
		 * choices for RHSC.  Many followed the spec; RHSC triggers
		 * on an edge, like setting and maybe clearing a port status
		 * change bit.  With others it's level-triggered, active
		 * until khubd clears all the port status change bits.  We'll
		 * always disable it here and rely on polling until khubd
		 * re-enables it.
		 */
		ohci_writel(ohci, OHCI_INTR_RHSC, &regs->intrdisable);
		usb_hcd_poll_rh_status(hcd);
	}

You can verify this easily enough.  If I'm right, it explains why=20
usb_hcd_poll_rh_status() keeps being called constantly.

The ohci_writel call near the end is supposed to clear the RHSC
interrupt-enable bit.  You can tell whether it worked by printing out
the value of

	ohci_readl(ohci, &regs->intrenable) & OHCI_INTR_RHSC

immediately afterward.

The earlier ohci_writel call is supposed to clear the RHSC
interrupt-status bit.  You can test whether that worked by printing out

	ohci_readl(ohci, &regs->intrstatus) & OHCI_INTR_RHSC

In addition, you should take a look at ohci_rhsc_enable() in
ohci-hub.c.  That's the place where RHSC interrupts get re-enabled, so
make sure it isn't getting called by mistake.

Alan Stern

