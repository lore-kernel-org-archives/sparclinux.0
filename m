From: "Antonino A. Daplas" <adaplas@hotpop.com>
Date: Mon, 14 Feb 2005 16:59:10 +0000
Subject: Re: [atyfb] No display on Sparc Ultra 10 with kernel 2.6.10-rc2 or later
Message-Id: <200502150059.12789.adaplas@hotpop.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200502140251.00645.aragorn@tiscali.nl>
In-Reply-To: <200502140251.00645.aragorn@tiscali.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Monday 14 February 2005 23:34, Frans Pop wrote:
> On Monday 14 February 2005 12:32, Ben Collins wrote:

> atyfb:  Set Visible Mode to 1024x768-8
> atyfb:  Virtual resolution 1024x2016, pixclock_in_ps 22349 (calculated
> 22349) atyfb:  Dot clock:           44 MHz
> atyfb:  Horizontal sync:     35 kHz
> atyfb:  Vertical refresh:    84 Hz

The above timings are screwed.  This is 1024x768 at 85Hz INTERLACED.
The fb_find_mode() function picked up this mode when you specified
1024x768@75, since there is no such mode in the mode database.
And the atyfb driver accepted the mode without differentiating between
interlaced and non-interlaced.

Try the following modes instead (all present in the mode database):

1024x768@60, 1024x768@70, 1024x768@76, 1024x768@100. You can also try
1024x768@85 but you might get the interlaced mode again.

Tony

PS:  There was also a massive atyfb update between 2.6.10-rc1 and rc2.  Her=
e's
the changelog:

#   Alexander Kern <alex.kern@gmx.de>
#   [PATCH] port Daniel Mantione 2.4 driver to 2.6
#   [PATCH] add more pci_id number
#   [PATCH] add accelerated imgblit
#   [PATCH] revert SDRAM_MAGIC_PLL to old behaviour
#   [PATCH] do a "from BIOS" initialisation only by __i386__
#  =20
#   Arnaud FONTAINE <arnaud.fontaine@free.fr>
#   [PATCH atyfb] correction for 3D Rage Mobility L
#  =20
#   Geert Uytterhoeven <geert@linux-m68k.org>
#   [PATCH atyfb] Atari Atyfb fixes
#   [PATCH atyfb] Atyfb on Mach64 GX or Atari
#   [PATCH 468] m68k sparse floating point
#  =20
#   James Simmons <jsimmons@infradead.org>
#   [PATCH add] port to framebuffer_alloc api
#  =20
#   Nicolas Souchu <nsouch@free.fr>
#   [PATCH] I do not found a copy, but it was incorporated too
#  =20
#   Ville Syrj=E4l=E4 <syrjala@sci.fi>
#   [PATCH] fix pan with doublescan
#   [PATCH] another double scan fix
#   [PATCH] disable linear aperture register access
#   [PATCH] Memory type correction
#   [PATCH] atyfb (2.6): Fix mmio_start
#   [PATCH] atyfb (2.6): Fix mem_refresh_rate for Mobility
#   [PATCH] atyfb (2.6): Add RGB565 support
#   [PATCH] atyfb: Blank LCD by turning off backlight voltage
#   [PATCH] atyfb: Rage LT LCD register access
#   [PATCH] atyfb: vblank irq support
#   [PATCH] atyfb: MTRR support
#=20


