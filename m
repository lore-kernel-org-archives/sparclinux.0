From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Sun, 16 Sep 2012 06:50:38 +0000
Subject: Re: [PATCH 2/2] PCI: Provide a default pcibios_update_irq()
Message-Id: <20120916065038.GB11030@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="8GpibOaaTibBMecb"
List-Id: <sparclinux.vger.kernel.org>
References: <1347655456-2542-1-git-send-email-thierry.reding@avionic-design.de>
 <1347655456-2542-2-git-send-email-thierry.reding@avionic-design.de>
 <CAMuHMdWuR_tdMw9iVkaQ3D9p1HVU_L05ap=MzBuo1jLD6YdHHw@mail.gmail.com>
 <20120915075301.GA31044@avionic-0098.mockup.avionic-design.de>
 <CAErSpo6WaFv=CXtiWeDDvThjZRBRJKfJMgovuMjjZRpQGK-WJA@mail.gmail.com>
In-Reply-To: <CAErSpo6WaFv=CXtiWeDDvThjZRBRJKfJMgovuMjjZRpQGK-WJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 15, 2012 at 04:23:33PM -0600, Bjorn Helgaas wrote:
> On Sat, Sep 15, 2012 at 1:53 AM, Thierry Reding
> <thierry.reding@avionic-design.de> wrote:
> > On Sat, Sep 15, 2012 at 09:32:10AM +0200, Geert Uytterhoeven wrote:
> >> On Fri, Sep 14, 2012 at 10:44 PM, Thierry Reding
> >> <thierry.reding@avionic-design.de> wrote:
> >> > --- a/drivers/pci/setup-irq.c
> >> > +++ b/drivers/pci/setup-irq.c
> >> > @@ -17,6 +17,14 @@
> >> >  #include <linux/ioport.h>
> >> >  #include <linux/cache.h>
> >> >
> >> > +void __devinit __weak pcibios_update_irq(struct pci_dev *dev, int i=
rq)
> >> > +{
> >> > +#ifdef CONFIG_PCI_DEBUG
> >> > +       printk(KERN_DEBUG "PCI: Assigning IRQ %02d to %s\n", irq,
> >> > +              pci_name(dev));
> >>
> >> pr_debug()?
> >> Or even better, dev_dbg()?
> >
> > The problem with pr_debug() and dev_dbg() is that they will be compiled
> > out if DEBUG is not defined. Perhaps we should pass -DDEBUG if PCI_DEBUG
> > is configured and make this dev_dbg()?
>=20
> Sorry, fat-fingered the previous empty response.
>=20
> We already have this in drivers/pci/Makefile:
>=20
>     ccflags-$(CONFIG_PCI_DEBUG) :=3D -DDEBUG
>=20
> so dev_dbg() should be perfect.

Yeah, this occurred to me as well and I was just about to look it up
when I read your response. I'll make it dev_dbg() then.

Thierry

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQVXa+AAoJEN0jrNd/PrOh00IQAJSTG1Ukqu3ay8m7AznzjD2Y
eRN6wDO0Pd37qkHr46rMO2UVPCavDFnoS6gsGhuTzdQgIOnVO9NKGUPm71xAhBnt
Yq+rYhg8i2cHNjZVKy8Kn5EY0Ly8k0yunH1KFMEodzeS2ZU/wrHSJZmkyKIUzMdN
AdMoFV81Q7So+JEdG1zIaM1hsDl3t18gt+9SlRSJZ6T4kXlv0j1pD9Jy2d0OC7bx
Yu8DDnNI33FIcZQnHsO50okCU0o4SqZHFmL/xm4Aa3JiQ5H4gMKiCYNXvFQ5M/gr
jU+cj0P1WdIPQVof9uie8TCiPCtNEJMbUQsgbhQuFf6eEefuUIbqkfETjmY8rNk9
NoNp1anLNxxxp2L17e8dN9VTJgNUi+lrpvcG6gqVBs7rE9ruo/6NVnFHwUUHd3Q3
o9ivpbuYPfJCRSW1r+TbE74iVQdg7jKO+p1cIZjMQOcv9B88M8KJaS60wpgxn9S+
f/eLoMlUK2wIbP3Zj4MR3DIorUOTyi7f14+J448Y5D9Ci86QU/+4bmMexqEVxsRS
Un+iARiZQlrWnmVjva4iG8g2mOxcmDPzHSlcE9+uIIdNdPCUWusrt81PAyIjTlUX
xo2R3G3LIVA4lfOiUSdQB2RYPmQHAXW/Tul5aBvXk11jsl0BN1Hbk2qO4641Puej
LLzcEjPu0384yupX0hSL
=/+fm
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--
