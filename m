From: Frans Pop <aragorn@tiscali.nl>
Date: Wed, 16 Feb 2005 02:27:38 +0000
Subject: Re: [atyfb] No display on Sparc Ultra 10 with kernel 2.6.10-rc2 or later
Message-Id: <200502160327.47586.aragorn@tiscali.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart2546078.dp8sr8MK2u"
List-Id: <sparclinux.vger.kernel.org>
References: <200502140251.00645.aragorn@tiscali.nl> <200502150722.24770.aragorn@tiscali.nl> <200502152010.22880.adaplas@hotpop.com>
In-Reply-To: <200502152010.22880.adaplas@hotpop.com>
To: adaplas@pol.net
Cc: debian-sparc@lists.debian.org, sparclinux@vger.kernel.org, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

--nextPart2546078.dp8sr8MK2u
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 15 February 2005 13:10, Antonino A. Daplas wrote:
> Can you verify if this is the case?  Insert a bunch of printk's in and
> around this line "if (node =3D=3D pcp->prom_node) {" in
> atyfb_setup_sparc().  For the 2.6.8 kernel, this line is in
> atyfb_init().

Tested that and output is identical for both. That condition you cite is=20
true for both kernels and the resolutions are retrieved from prom:
atyfb (fjp): crtc.vxres 1152
atyfb (fjp): crtc.vyres 900

> As a workaround, a boot option can be added for csync, hsync and vsync.

Hmm. I looked for the syntax for that, but can't find it.
I tried
  video=3Datyfb:1024x768@70,csync:1
and
  video=3Datyfb:1024x768@70,csync:high
but both failed miserably.
(I have checked that csync is sufficient to activate the monitor.)

What I get is boot messages 'vclk out of range' and 'not enough video RAM'=
=20
and I end up with 640x480-60 with both hsync and _v_sync set high, but=20
not csync (and a monitor in suspend of course).

--nextPart2546078.dp8sr8MK2u
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCEq+jgm/Kwh6ICoQRAhAXAKC4BjVjSsXvXQvinh7KQ5Mb0Q9fJQCdFZMN
COC15xScer3osGpdD04dcWo=
=K8ai
-----END PGP SIGNATURE-----

--nextPart2546078.dp8sr8MK2u--
