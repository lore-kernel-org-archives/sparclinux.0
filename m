From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Sat, 15 Sep 2012 07:53:01 +0000
Subject: Re: [PATCH 2/2] PCI: Provide a default pcibios_update_irq()
Message-Id: <20120915075301.GA31044@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="9jxsPFA5p3P2qPhR"
List-Id: <sparclinux.vger.kernel.org>
References: <1347655456-2542-1-git-send-email-thierry.reding@avionic-design.de>
 <1347655456-2542-2-git-send-email-thierry.reding@avionic-design.de>
 <CAMuHMdWuR_tdMw9iVkaQ3D9p1HVU_L05ap=MzBuo1jLD6YdHHw@mail.gmail.com>
In-Reply-To: <CAMuHMdWuR_tdMw9iVkaQ3D9p1HVU_L05ap=MzBuo1jLD6YdHHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 15, 2012 at 09:32:10AM +0200, Geert Uytterhoeven wrote:
> On Fri, Sep 14, 2012 at 10:44 PM, Thierry Reding
> <thierry.reding@avionic-design.de> wrote:
> > --- a/drivers/pci/setup-irq.c
> > +++ b/drivers/pci/setup-irq.c
> > @@ -17,6 +17,14 @@
> >  #include <linux/ioport.h>
> >  #include <linux/cache.h>
> >
> > +void __devinit __weak pcibios_update_irq(struct pci_dev *dev, int irq)
> > +{
> > +#ifdef CONFIG_PCI_DEBUG
> > +       printk(KERN_DEBUG "PCI: Assigning IRQ %02d to %s\n", irq,
> > +              pci_name(dev));
>=20
> pr_debug()?
> Or even better, dev_dbg()?

The problem with pr_debug() and dev_dbg() is that they will be compiled
out if DEBUG is not defined. Perhaps we should pass -DDEBUG if PCI_DEBUG
is configured and make this dev_dbg()?

Thierry

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQVDPdAAoJEN0jrNd/PrOhyIYP/Ru7vr3AxNAHfW1yg4IPxgM0
HlExgyk6vrHq2RxLK1h714L7sqYK3Gn7AQcXUa8sCHhTqJ7v/nmfnguP9m4K/QJO
SnC+nG4VgwIn7aZHevaupjVcHWXGtL1aR7zUWb7LzqDq+bKYHxpXAz2p8bCzotJG
nZd2OyMdbjVLnONcjdSpbVNHRvKe7UoS4R9I2PvciJI/oUYlV03aMXYpRxujxnIY
DbLxoyCCLsBphYBDx9IvQCFFpBaXqgTVa9PWQ1MlytfuEWoLr6nOVD01bgMizOGS
Ry1Wbs3YAVHjFN/68iLZGjZCz9ODft2MYpw47akDX2InilvlPUH3GZZ4bu+31tP1
bd2M4ZCNAC8EK/UPxAxcyMFhqJ688qpHhDXsPDX349lYdo2SjG90/5CMl6cYL1Xv
Hd/1Uygl+Mmw9oPNX/hpozAJeKvT9P8VqGunn0uabdBxl+4Uo6ucauWRs2V0DY+z
eEX1mVwYSddgcLt9LCU45Io03p3M6W2CRIOwG9beckMj00c07riHX4w6z/OhIsF5
/rhDGvqTr9LHs8L45SzqygsuVWGZiGAryRsHDdXxj2yS+yT1HCDjFboPwsgx6K9P
IcUekJYFy1RxEB7YzK8oyfl7EhigIQAzdyhqL/QgjhtTla6vG7cXcgMYJgXhRtBG
qq23DlFKzpQ/g5tsIqjp
=aCDh
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
