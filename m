From: joshk@triplehelix.org (Joshua Kwan)
Date: Wed, 07 Apr 2004 06:53:59 +0000
Subject: Re: Can't boot linux on sun blade 2000
Message-Id: <20040407065359.GE12701@triplehelix.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="k4f25fnPtRuIRUb3"
List-Id: <sparclinux.vger.kernel.org>
References: <200404071043.30060.snake@penza-gsm.ru>
In-Reply-To: <200404071043.30060.snake@penza-gsm.ru>
To: sparclinux@vger.kernel.org


--k4f25fnPtRuIRUb3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 07, 2004 at 10:43:30AM +0400, Alexey Nezhdanov wrote:
> <TFTP COUNTER (booting=20
> http://www.phunnypharm.org/pub/for/sparc-folks/disks-sparc/current/sparc6=
4/tftpboot.img=20
> image)>

You should really be using the Sarge tftboot images.
http://people.debian.org/~jbailey/d-i/sparc/daily/sparc64/netboot/boot.img

> devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
> devfs: boot_options: 0x0

This is the cause of all your problems.

> VFS: Mounted root (ext2 filesystem).
> Warning: unable to open an initial console.

Pass devfs=3Dmount on the command line and it should Just Work.
Note that this crude hack isn't required in the latest images.

--=20
Joshua Kwan

--k4f25fnPtRuIRUb3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQHOlhqOILr94RG8mAQI25xAAuWXQxQ/xzbk5/bbdApKZsJT+1yBoIgAj
yCTzbO3sLEyREKx0zMFCvQzLki+h/b+eVy3dyjK0hFnRK31vmsC3u+Mh6cDzFTee
wy80uUNVGM4Yz8/bP/VuxSBPcI/60lyOwkgjmAej8Zriv8iTfAM4HAwXTT9f0wWr
e+ggD+Z0K3GP0VaPmIRFCeU5Rj0ArgOHlcrSeMNPf/gojYyvZZZUjj/UT7upyIcd
ylG9p9KU26M58Mb97ZyPe7Rw0LiqnOETwvWHQn3715kq9KBXJzs5ovKWJIY2wvql
1SaORwlScJ7ysjuGnVD1yfvqvT8CfR7jl6K55H3T18wPETG03YKpigTcvQiIvdY1
Ljmt2V8dwbikNTwB4UgXaYARIjkmHetg5TjKfuGgPWjG4pVV46Ay+bl2Vj++M2mv
/Mgfm2q+pS9+K8DTReJAJEJ+cU+63PwGfYK+L0eBCBzxEKRzPwJk2JyC3jgWsO/U
YwY2VEY0C4DnrcXf8WhwW8xdy9sj4fqZXnbX7R9TxbUDly+xAlfvPjrPD6dfPf7U
BRQoE54GpagljesaoJrd9Dre35EUoTp5CiFYECzPS0SKElOqhpr7KDjL+t00+jS6
XDYMP/XB9Lrl8MX1RRzQYGtVbSx/qun5h7b9LiGf58Y9rXyaY1ruooXARrzTw0QU
Z0ycTYgfhlg=
=lsQh
-----END PGP SIGNATURE-----

--k4f25fnPtRuIRUb3--
