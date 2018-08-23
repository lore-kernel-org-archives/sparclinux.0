From: Mikulas Patocka <mpatocka@redhat.com>
Date: Thu, 23 Aug 2018 21:17:20 +0000
Subject: Re: [PATCH] mach64: detect the dot clock divider correctly on sparc
Message-Id: <alpine.LRH.2.02.1808231706420.13157@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="185206533-1055045778-1535059042=:13157"
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.02.1808171515550.31883@file01.intranet.prod.int.rdu2.redhat.com>
 <20180819103657.GB11867@sci.fi>
In-Reply-To: <20180819103657.GB11867@sci.fi>
To: =?ISO-8859-15?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: sparclinux@vger.kernel.org, linux-fbdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--185206533-1055045778-1535059042=:13157
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



On Sun, 19 Aug 2018, Ville Syrj=E4l=E4 wrote:

> On Fri, Aug 17, 2018 at 03:19:37PM -0400, Mikulas Patocka wrote:
> > On Sun Ultra 5, it happens that the dot clock is not set up properly for
> > some videomodes. For example, if we set the videomode "r1024x768x60" in
> > the firmware, Linux would incorrectly set a videomode with refresh rate
> > 180Hz when booting (suprisingly, my LCD monitor can display it, although
> > display quality is very low).
> >=20
> > The reason is this: Older mach64 cards set the divider in the register
> > VCLK_POST_DIV. The register has four 2-bit fields (the field that is
> > actually used is specified in the lowest two bits of the register
> > CLOCK_CNTL). The 2 bits select divider "1, 2, 4, 8". On newer mach64 ca=
rds,
> > there's another bit added - the top four bits of PLL_EXT_CNTL extend the
> > divider selection, so we have possible dividers "1, 2, 4, 8, 3, 5, 6, 1=
2".
> > The Linux driver clears the top four bits of PLL_EXT_CNTL and never sets
> > them, so it can work regardless if the card supports them. However, the
> > sparc64 firmware may set these extended dividers during boot - and the
> > mach64 driver detects incorrect dot clock in this case.
> >=20
> > This patch makes the driver read the additional divider bit from
> > PLL_EXT_CNTL and calculate the initial refresh rate properly.
> >=20
> > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > Cc: stable@vger.kernel.org
> >=20
> > ---
> >  drivers/video/fbdev/aty/atyfb.h      |    3 ++-
> >  drivers/video/fbdev/aty/atyfb_base.c |    7 ++++---
> >  drivers/video/fbdev/aty/mach64_ct.c  |   10 +++++-----
> >  3 files changed, 11 insertions(+), 9 deletions(-)
> >=20
> > Index: linux-stable/drivers/video/fbdev/aty/atyfb.h
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-stable.orig/drivers/video/fbdev/aty/atyfb.h	2018-08-13 21:12:=
11.000000000 +0200
> > +++ linux-stable/drivers/video/fbdev/aty/atyfb.h	2018-08-13 21:17:14.00=
0000000 +0200
> > @@ -333,6 +333,8 @@ extern const struct aty_pll_ops aty_pll_
> >  extern void aty_set_pll_ct(const struct fb_info *info, const union aty=
_pll *pll);
> >  extern u8 aty_ld_pll_ct(int offset, const struct atyfb_par *par);
> > =20
> > +extern const u8 aty_postdividers[8];
> > +
> > =20
> >      /*
> >       *  Hardware cursor support
> > @@ -359,7 +361,6 @@ static inline void wait_for_idle(struct
> > =20
> >  extern void aty_reset_engine(const struct atyfb_par *par);
> >  extern void aty_init_engine(struct atyfb_par *par, struct fb_info *inf=
o);
> > -extern u8   aty_ld_pll_ct(int offset, const struct atyfb_par *par);
> > =20
> >  void atyfb_copyarea(struct fb_info *info, const struct fb_copyarea *ar=
ea);
> >  void atyfb_fillrect(struct fb_info *info, const struct fb_fillrect *re=
ct);
> > Index: linux-stable/drivers/video/fbdev/aty/atyfb_base.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-stable.orig/drivers/video/fbdev/aty/atyfb_base.c	2018-08-13 2=
1:12:11.000000000 +0200
> > +++ linux-stable/drivers/video/fbdev/aty/atyfb_base.c	2018-08-13 21:22:=
23.000000000 +0200
> > @@ -3087,17 +3087,18 @@ static int atyfb_setup_sparc(struct pci_
> >  		/*
> >  		 * PLL Reference Divider M:
> >  		 */
> > -		M =3D pll_regs[2];
> > +		M =3D pll_regs[PLL_REF_DIV];
> > =20
> >  		/*
> >  		 * PLL Feedback Divider N (Dependent on CLOCK_CNTL):
> >  		 */
> > -		N =3D pll_regs[7 + (clock_cntl & 3)];
> > +		N =3D pll_regs[VCLK0_FB_DIV + (clock_cntl & 3)];
> > =20
> >  		/*
> >  		 * PLL Post Divider P (Dependent on CLOCK_CNTL):
> >  		 */
> > -		P =3D 1 << (pll_regs[6] >> ((clock_cntl & 3) << 1));
> > +		P =3D aty_postdividers[((pll_regs[VCLK_POST_DIV] >> ((clock_cntl & 3=
) << 1)) & 3) |
> > +		                     ((pll_regs[PLL_EXT_CNTL] >> (2 + (clock_cntl & =
3))) & 4)];
> > =20
> >  		/*
> >  		 * PLL Divider Q:
> > Index: linux-stable/drivers/video/fbdev/aty/mach64_ct.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-stable.orig/drivers/video/fbdev/aty/mach64_ct.c	2018-08-13 21=
:12:11.000000000 +0200
> > +++ linux-stable/drivers/video/fbdev/aty/mach64_ct.c	2018-08-13 21:35:3=
2.000000000 +0200
> > @@ -115,7 +115,7 @@ static void aty_st_pll_ct(int offset, u8
> >   */
> > =20
> >  #define Maximum_DSP_PRECISION 7
> > -static u8 postdividers[] =3D {1,2,4,8,3};
> > +const u8 aty_postdividers[8] =3D {1,2,4,8,3,5,6,12};
>=20
> Not sure about the '5'. That setting is marked as reserved in my docs.
> So I guess it doesn't really matter what number we put there.

I downloaded documentation here:=20
http://ftp.nluug.nl/ftp/pub/NetBSD/misc/cegger/hw_manuals/ati/mach64_and_ra=
gepro/

The RAGE XL/XC Register Reference Guide - at page 4-77 it says "select=20
alternate post dividers", but doesn't say what they are.
At page 4-89 it lists post dividers 1,2,4,8,3,5,6,12. It's hard to say if=20
they also apply to the PLL_EXT_CNTL register or not.

At lest the divider 3 is valid because the Sparc firmware sets it and it=20
works as expected.

Mikulas

> Reviewed-by: Ville Syrj=E4l=E4 <syrjala@sci.fi>
--185206533-1055045778-1535059042=:13157--
