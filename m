From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Sat, 15 Sep 2012 07:57:37 +0000
Subject: Re: [PATCH 1/2] PCI: Annotate pci_fixup_irqs with __devinit
Message-Id: <20120915075737.GA31258@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="+QahgC5+KEYLbs62"
List-Id: <sparclinux.vger.kernel.org>
References: <1347655456-2542-1-git-send-email-thierry.reding@avionic-design.de>
 <CAErSpo6BqPUEpMmh2+FuEi-mHFK0U1XCmdCpJfo6V2XcNxzMNg@mail.gmail.com>
 <20120914223531.GA8771@kroah.com>
In-Reply-To: <20120914223531.GA8771@kroah.com>
To: linux-arm-kernel@lists.infradead.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 14, 2012 at 03:35:31PM -0700, Greg Kroah-Hartman wrote:
> On Fri, Sep 14, 2012 at 02:53:11PM -0600, Bjorn Helgaas wrote:
> > +cc Greg KH
> >=20
> > On Fri, Sep 14, 2012 at 2:44 PM, Thierry Reding
> > <thierry.reding@avionic-design.de> wrote:
> > > In order to keep pci_fixup_irqs() around after init (e.g. for hotplug=
),
> > > mark it __devinit instead of __init. This requires the same change for
> > > the implementation of the pcibios_update_irq() function on all
> > > architectures.
> > >
> > > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> > > ---
> > > Note: Ideally these annotations should go away completely in order to
> > > be independent of the HOTPLUG symbol. However, there is work underway
> > > to get rid of HOTPLUG altogether, so I've kept the __devinit for now.
>=20
> No, just take away the __init marking completly.  For 3.7,
> CONFIG_HOTPLUG will always be enabled, making it be the same thing.
> That way this saves me the time and energy from deleting the __devinit
> markings when I get to that point in the patch series :)

Done. I'll give other people some time to comment before sending the
updated series.

Thierry

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQVDTxAAoJEN0jrNd/PrOhY84P/1V6CjM7bTnYamaHDOKyZQUc
IyLN3mZRN6AbMMO8awcN6B4BDXuB6ua8nN7ozdlqRnFSUgSXVwWwrezZnrpc+Sws
yO4Axr8IOBxpG2IDX+d2bGWRV5W34kzty5WsZhlPEJxOBSQH0MiNJCgTojSIIf5n
9a6+7fF5qsSamGnmtWKwe01nwvlAsJg0i3sxyguWlFuBqd1IyQMCptCWsSBzMQVc
1EeCDtWdLTKzxNHhkl97rWcQYi3ov8LTK76zUutTSDlpc2+HhX0nu73Tz34fLs9m
k4Z1mw2VLHRUorvFCptwhvB72LR2hssTZxGDt3xbPLERUECtV3wwpFTDT8J4jZj0
bzHCpbfj11K1Y7/Ku/1FBWBXjFPh1+YS0lA39V00WnHBx9Xv2DX6Ytm8FwGCtqEN
wfV+VGyR+tvIWI6oA8vIgc/1xuMuDlrK4Ldn2uwZBHZfq28ghCiKFHasHA5RW+D/
kTA2p4Yvuujuvh6PbsvJv2h4A9Sudko6rzwlclnv7OGxsxCa624yF8YN+rqLVU9C
7Sq/vSCmpj1E3AQ9TKcnYyFYP1sUsc9BnslLNEHNly+MFRJoAMOAx3M6s/30vRJp
FKyDyeWTzkjnlCYDiH/ebSQRk1tO9h6HJXnzrAAU55iJYHDxCGQ15I2emj8v/bqT
3iUVzezeZpRhZ0IPIxbq
=Q8MZ
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
