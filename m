From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Date: Fri, 24 Aug 2018 11:58:52 +0000
Subject: Re: [PATCH] mach64: detect the dot clock divider correctly on sparc
Message-Id: <20180824115851.GC11867@sci.fi>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.02.1808171515550.31883@file01.intranet.prod.int.rdu2.redhat.com>
 <20180819103657.GB11867@sci.fi>
 <alpine.LRH.2.02.1808231706420.13157@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.1808231706420.13157@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: sparclinux@vger.kernel.org, linux-fbdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Thu, Aug 23, 2018 at 05:17:20PM -0400, Mikulas Patocka wrote:
>=20
>=20
> On Sun, 19 Aug 2018, Ville Syrj=E4l=E4 wrote:
>=20
> > On Fri, Aug 17, 2018 at 03:19:37PM -0400, Mikulas Patocka wrote:
> > > On Sun Ultra 5, it happens that the dot clock is not set up properly =
for
> > > some videomodes. For example, if we set the videomode "r1024x768x60" =
in
> > > the firmware, Linux would incorrectly set a videomode with refresh ra=
te
> > > 180Hz when booting (suprisingly, my LCD monitor can display it, altho=
ugh
> > > display quality is very low).
> > >=20
> > > The reason is this: Older mach64 cards set the divider in the register
> > > VCLK_POST_DIV. The register has four 2-bit fields (the field that is
> > > actually used is specified in the lowest two bits of the register
> > > CLOCK_CNTL). The 2 bits select divider "1, 2, 4, 8". On newer mach64 =
cards,
> > > there's another bit added - the top four bits of PLL_EXT_CNTL extend =
the
> > > divider selection, so we have possible dividers "1, 2, 4, 8, 3, 5, 6,=
 12".
> > > The Linux driver clears the top four bits of PLL_EXT_CNTL and never s=
ets
> > > them, so it can work regardless if the card supports them. However, t=
he
> > > sparc64 firmware may set these extended dividers during boot - and the
> > > mach64 driver detects incorrect dot clock in this case.
> > >=20
> > > This patch makes the driver read the additional divider bit from
> > > PLL_EXT_CNTL and calculate the initial refresh rate properly.
> > >=20
> > > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > > Cc: stable@vger.kernel.org
> > >=20
> > > ---
> > >  drivers/video/fbdev/aty/atyfb.h      |    3 ++-
> > >  drivers/video/fbdev/aty/atyfb_base.c |    7 ++++---
> > >  drivers/video/fbdev/aty/mach64_ct.c  |   10 +++++-----
> > >  3 files changed, 11 insertions(+), 9 deletions(-)
> > >=20
> > > Index: linux-stable/drivers/video/fbdev/aty/atyfb.h
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D> > > --- linux-stable.orig/drivers/video/fbd=
ev/aty/atyfb.h	2018-08-13 21:12:11.000000000 +0200
> > > +++ linux-stable/drivers/video/fbdev/aty/atyfb.h	2018-08-13 21:17:14.=
000000000 +0200
> > > @@ -333,6 +333,8 @@ extern const struct aty_pll_ops aty_pll_
> > >  extern void aty_set_pll_ct(const struct fb_info *info, const union a=
ty_pll *pll);
> > >  extern u8 aty_ld_pll_ct(int offset, const struct atyfb_par *par);
> > > =20
> > > +extern const u8 aty_postdividers[8];
> > > +
> > > =20
> > >      /*
> > >       *  Hardware cursor support
> > > @@ -359,7 +361,6 @@ static inline void wait_for_idle(struct
> > > =20
> > >  extern void aty_reset_engine(const struct atyfb_par *par);
> > >  extern void aty_init_engine(struct atyfb_par *par, struct fb_info *i=
nfo);
> > > -extern u8   aty_ld_pll_ct(int offset, const struct atyfb_par *par);
> > > =20
> > >  void atyfb_copyarea(struct fb_info *info, const struct fb_copyarea *=
area);
> > >  void atyfb_fillrect(struct fb_info *info, const struct fb_fillrect *=
rect);
> > > Index: linux-stable/drivers/video/fbdev/aty/atyfb_base.c
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D> > > --- linux-stable.orig/drivers/video/fbd=
ev/aty/atyfb_base.c	2018-08-13 21:12:11.000000000 +0200
> > > +++ linux-stable/drivers/video/fbdev/aty/atyfb_base.c	2018-08-13 21:2=
2:23.000000000 +0200
> > > @@ -3087,17 +3087,18 @@ static int atyfb_setup_sparc(struct pci_
> > >  		/*
> > >  		 * PLL Reference Divider M:
> > >  		 */
> > > -		M =3D pll_regs[2];
> > > +		M =3D pll_regs[PLL_REF_DIV];
> > > =20
> > >  		/*
> > >  		 * PLL Feedback Divider N (Dependent on CLOCK_CNTL):
> > >  		 */
> > > -		N =3D pll_regs[7 + (clock_cntl & 3)];
> > > +		N =3D pll_regs[VCLK0_FB_DIV + (clock_cntl & 3)];
> > > =20
> > >  		/*
> > >  		 * PLL Post Divider P (Dependent on CLOCK_CNTL):
> > >  		 */
> > > -		P =3D 1 << (pll_regs[6] >> ((clock_cntl & 3) << 1));
> > > +		P =3D aty_postdividers[((pll_regs[VCLK_POST_DIV] >> ((clock_cntl &=
 3) << 1)) & 3) |
> > > +		                     ((pll_regs[PLL_EXT_CNTL] >> (2 + (clock_cntl =
& 3))) & 4)];
> > > =20
> > >  		/*
> > >  		 * PLL Divider Q:
> > > Index: linux-stable/drivers/video/fbdev/aty/mach64_ct.c
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D> > > --- linux-stable.orig/drivers/video/fbd=
ev/aty/mach64_ct.c	2018-08-13 21:12:11.000000000 +0200
> > > +++ linux-stable/drivers/video/fbdev/aty/mach64_ct.c	2018-08-13 21:35=
:32.000000000 +0200
> > > @@ -115,7 +115,7 @@ static void aty_st_pll_ct(int offset, u8
> > >   */
> > > =20
> > >  #define Maximum_DSP_PRECISION 7
> > > -static u8 postdividers[] =3D {1,2,4,8,3};
> > > +const u8 aty_postdividers[8] =3D {1,2,4,8,3,5,6,12};
> >=20
> > Not sure about the '5'. That setting is marked as reserved in my docs.
> > So I guess it doesn't really matter what number we put there.
>=20
> I downloaded documentation here:=20
> http://ftp.nluug.nl/ftp/pub/NetBSD/misc/cegger/hw_manuals/ati/mach64_and_=
ragepro/
>=20
> The RAGE XL/XC Register Reference Guide - at page 4-77 it says "select=20
> alternate post dividers", but doesn't say what they are.
> At page 4-89 it lists post dividers 1,2,4,8,3,5,6,12. It's hard to say if=
=20
> they also apply to the PLL_EXT_CNTL register or not.

Oh, I missed the V2CLK reg. Indeed I see the /5 there in my docs as
well.

For the other clocks the Rage II docs I have have the following table:
ALT_VCLKx_POST VCLKx_POST Post Divider
0 00 /1
0 01 /2
0 10 /4
0 11 /8
1 00 /3
1 01 reserved
1 10 /6
1 11 /12

Curiously that table is nowhere to be found in the docs for any of the
more recent chips.

But yeah, given the V2CLK thing /5 seems like a perfectly good=20
value to use here.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
