From: Alan Stern <stern@rowland.harvard.edu>
Date: Thu, 21 Aug 2008 20:34:03 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100 - USB again
Message-Id: <Pine.LNX.4.44L0.0808211610320.17334-100000@iolanthe.rowland.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Thu, 21 Aug 2008, Meelis Roos wrote:

> > 	http://marc.info/?l=3Dlinux-usb&m=121926736707452&w=3D2
> >=20
> > It may not apply exactly as-is to 2.6.27-rc4 because it was made=20
> > against a development tree, but you should be able to adjust it easily =

> > enough.
>=20
> Applied some chunks by hand and tried it. Still loops.

Looping isn't necessarily bad -- locking up is bad!  I think we should
pursue testing this kernel a little farther.

As a matter of fact, the driver is supposed to poll at intervals of 250
ms for some period of time (until everything settles down and it
switches over to interrupt-driven operation, normally just a few
seconds).  So some looping is to be expected.

> Note that there is the following line in logs between looping:
> ps used greatest stack depth: 0 bytes left
>=20
> Does this mean that the looping used up all the stack??

I have no idea what it means.

> [   77.079395] usb_hcd_poll_rh_status start
> [   77.130979] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=
=FFfff8006e1778c0=20
> [   77.232839] usb_hcd_poll_rh_status before hub_status_data
> [   77.303881] ohci_hub_status_data before spin_lock_irqsave
> [   77.374851] ohci_hub_status_data after spin_lock_irqsave
> [   77.444679] ohci_hub_status_data return
> [   77.495062] usb_hcd_poll_rh_status after hub_status_data

The call returns, and the next line shows another call being made 250
ms later.  That's exactly what should happen.

> [   77.734791] usb_hcd_poll_rh_status start
> [   77.786476] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=
=FFfff8006e1778c0=20
> [   77.888373] usb_hcd_poll_rh_status before hub_status_data
> [   77.959314] ohci_hub_status_data before spin_lock_irqsave
> [   78.030299] ohci_hub_status_data after spin_lock_irqsave
> [   78.100117] ohci_hub_status_data return
> [   78.150496] usb_hcd_poll_rh_status after hub_status_data

At first glance there's nothing wrong.  But looking more closely, it's=20
obvious that the time values are extremely peculiar.

For example, look at the time difference between the "start" line and
the "uses_new_polling" line.  Those are practically adjacent in your
code, right?  How could there possibly be a gap of 50 ms between the
two?  Your CPU isn't running at a clock speed of 0.1 MHz, is it? =20
Could something be monopolizing the PCI or memory bus beyond all
reasonable bounds?

Evidently something is slowing your CPU way, way down.  Or else the=20
clock subsystem is totally messed up.  The time required for a single=20
iteration of usb_hcd_poll_rh_status() looks like 78.150 - 77.734 =3D=20
0.416 ms; that's completely ridiculous.

I don't know what could be messing the timings up so badly.  But I=20
think OHCI is just an innocent bystander here.

Alan Stern

