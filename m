From: Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 14 Mar 2011 17:03:50 +0000
Subject: Re: Status update on sparc32 genirq support
Message-Id: <alpine.LFD.2.00.1103141800470.2787@localhost6.localdomain6>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="-1463795968-2037753956-1300122231=:2787"
List-Id: <sparclinux.vger.kernel.org>
References: <20110307.230120.226776255.davem@davemloft.net>
In-Reply-To: <20110307.230120.226776255.davem@davemloft.net>
To: sparclinux@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463795968-2037753956-1300122231=:2787
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Sun, 13 Mar 2011, Sam Ravnborg wrote:

> Hi Daniel - thanks for looking at this patch.
>=20
> I was actually planning to send it to David tonight.
> But after your comments I will wait.
>=20
> >  I have begun too look at the patches, one thing that strikes me is
> > why handle_level_irq is used and why the ack functions irq_ack and
> > irq_mask_ack are not defined.
>=20
> The sun4m at least uses level triggered interrupts.
> And looking at the implmentation the enable() and disable() functions
> in all cases did a simple mask and unmask - also the leon variants.
>=20
> So based on this observation I decided to go got the handle_level_irq
> flow handler. From the implmentation in kernel/irq/ I could
> also see that handle_level_irq always called irq_mask() / irq_unmask()
> which was a match towoards to earlier implemtnation.
>=20
> On top of this - this just worked for my sun4m box.
>=20
> > On the LEON architecture IRQs are
> > normally edge triggered, the exception beeing PCI interrupts that is
> > level triggered. Implementing the ack functions in the current
> > implementation would result in acking edge triggered IRQs which means
> > IRQs may be lost (on the LEON at least)? I thought SUN SPARCs also have
> > edge triggered interrupts and that the CPU acks the IRQ automatically
> > when the trap is taken?
> >  =A0
> >  What is the difference between having handle_level_irq without ACKs
> > implemented and having handle_edge_irq doing the interrupt flow
> > handling?
>=20
> Thomas? Can you help here? You are much more into these details than I am.

That largely depends on the hardware. There is hardware which
automatically acks either on trap entry or with the mask.

Also edge triggered interrupts can be handled entirely safe by
handle_level_irq if the hardware latches the edge even when the
interrupt line is masked.

W/o looking at the actual datasheets I can't tell.

Thanks,

	tglx
---1463795968-2037753956-1300122231=:2787--
