From: Frans Pop <aragorn@tiscali.nl>
Date: Tue, 15 Feb 2005 06:22:15 +0000
Subject: Re: [atyfb] No display on Sparc Ultra 10 with kernel 2.6.10-rc2 or later
Message-Id: <200502150722.24770.aragorn@tiscali.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart2466069.y69fcxfPBt"
List-Id: <sparclinux.vger.kernel.org>
References: <200502140251.00645.aragorn@tiscali.nl> <200502141855.29202.aragorn@tiscali.nl> <200502150741.01702.adaplas@hotpop.com>
In-Reply-To: <200502150741.01702.adaplas@hotpop.com>
To: adaplas@pol.net
Cc: debian-sparc@lists.debian.org, sparclinux@vger.kernel.org, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

--nextPart2466069.y69fcxfPBt
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Tony,

I've tried your suggestions and the one about using fbset resulted in a=20
breakthrough. 'fbset -depth' gave no results, but comparing the output of=20
'fbset -i' from a working kernel and a new one gave me something to try.

=46rom 2.6.8 kernel (working framebuffer):
mode "1152x900-66"
    # D: 93.870 MHz, H: 61.433 kHz, V: 65.564 Hz
    geometry 1152 900 1152 1792 8
    timings 10653 190 58 31 2 128 4
    hsync high
    csync high
    accel true
    rgba 8/0,8/0,8/0,0/0
endmode

=46rame buffer device information:
    Name        : ATY Mach64
    Address     : 0xe1800000
    Size        : 2088960
    Type        : PACKED PIXELS
    Visual      : PSEUDOCOLOR
    XPanStep    : 8
    YPanStep    : 1
    YWrapStep   : 0
    LineLength  : 1152
    MMIO Address: 0xfffffc00
    MMIO Size   : 2048
    Accelerator : ATI Mach64GT
<end>

=46rom 2.6.10-rc2 (not working):
mode "1024x768-70"
    # D: 74.778 MHz, H: 56.308 kHz, V: 69.862 Hz
    geometry 1024 768 1024 2016 8
    timings 13373 144 24 29 3 136 6
    accel true
    rgba 8/0,8/0,8/0,0/0
endmode

=46rame buffer device information:
    Name        : ATY Mach64
    Address     : 0xe1800000
    Size        : 2088960
    Type        : PACKED PIXELS
    Visual      : PSEUDOCOLOR
    XPanStep    : 8
    YPanStep    : 1
    YWrapStep   : 0
    LineLength  : 1024
    MMIO Address: 0xe17ff800
    MMIO Size   : 2048
    Accelerator : ATI Mach64GT
<end>

The significant difference is in the settings for hsync and csync. After=20
setting both 'high' (hsync alone did nothing) from a SSH terminal the=20
monitor turned on :-D

I hope this will be enough of a clue for those who know the driver code to=
=20
work out a patch.

These values also tell that the old default mode was 1152x900-66,=20
resulting in a 144x56 textconsole. My personal opinion is that that is=20
very high for a default mode. The 1024x768-70 (resulting in 128x48) I've=20
been using now (or maybe even something a bit lower) seems more=20
reasonable to me.

=46or completeness sake I've included the answers to your questions below.

Cheers,
=46rans

On Tuesday 15 February 2005 00:40, Antonino A. Daplas wrote:
> Try editing drivers/video/console/fbcon.c, look for the function
> fbcon_startup(). After the line 'ops->currcon =3D -1;', insert this line:
>
> ops->blank_state =3D -1;

Hmm. Results in a compilation error when I tried that in -rc2: no such=20
variable in that structure.
I checked 2.6.11-rc3-bk2 and noticed it was added there, so I tested this=20
suggestion with that version. No difference.

> Also, try changing the graphics state such as doing an
> fbset -depth 16 or the like.

I tried that from my ssh terminal and only -depth 8 was accepted.
Both 16 and 24 gave the same result:
# fbset -depth 16 -fb /dev/fb0
ioctl FBIOPUT_VSCREENINFO: Invalid argument

> What happens if you switch consoles?

Nothing at all. Hitting keys does nothing either, also not after leaving=20
the system alone for a long time.

> You can also try commenting out .fb_blank =3D atyfb_blank from
> static struct fb_ops atyfb_ops and disable CONFIG_PM from your kernel
> config.

The first suggestion makes no difference.
As to the CONFIG_PM: there is no such setting in my .config for sparc64=20
(i386 does have it). I do have CONFIG_FB_PM2, but that is not set.

> I'll CC fbdev-devel list.

Thanks.

--nextPart2466069.y69fcxfPBt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCEZUggm/Kwh6ICoQRAsLRAJ9Y04fpaZN6fu6gBFFmf6Ta2Yl53ACeOk8P
e2eDrZBoofjpMuXC58AXFA8=
=Dasa
-----END PGP SIGNATURE-----

--nextPart2466069.y69fcxfPBt--
