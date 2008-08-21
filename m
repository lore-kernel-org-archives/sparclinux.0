From: Meelis Roos <mroos@ut.ee>
Date: Thu, 21 Aug 2008 22:33:42 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100 - USB again
Message-Id: <Pine.SOC.4.64.0808220132320.6721@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

> > [   77.734791] usb_hcd_poll_rh_status start
> > [   77.786476] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=
=FFfff8006e1778c0=20
> > [   77.888373] usb_hcd_poll_rh_status before hub_status_data
> > [   77.959314] ohci_hub_status_data before spin_lock_irqsave
> > [   78.030299] ohci_hub_status_data after spin_lock_irqsave
> > [   78.100117] ohci_hub_status_data return
> > [   78.150496] usb_hcd_poll_rh_status after hub_status_data
>=20
> At first glance there's nothing wrong.  But looking more closely, it's=20
> obvious that the time values are extremely peculiar.
>=20
> For example, look at the time difference between the "start" line and
> the "uses_new_polling" line.  Those are practically adjacent in your
> code, right?  How could there possibly be a gap of 50 ms between the
> two?  Your CPU isn't running at a clock speed of 0.1 MHz, is it? =20
> Could something be monopolizing the PCI or memory bus beyond all
> reasonable bounds?

It might be the 9600 baud serial console that I'm using to get these=20
messages. Should I just remove most of the debugging printks and see if=20
it works?

--=20
Meelis Roos (mroos@ut.ee)      http://www.cs.ut.ee/~mroos/
