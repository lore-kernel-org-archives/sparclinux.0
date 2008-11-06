From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 06 Nov 2008 04:24:21 +0000
Subject: tty warning
Message-Id: <20081106152421.a9cf964f.sfr@canb.auug.org.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Thu__6_Nov_2008_15_24_21_+1100_Z0wfL10ez+IsTWD="
List-Id: <sparclinux.vger.kernel.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "David S. Miller" <davem@davemloft.net>, LKML <linux-kernel@vger.kernel.org>, "William L. Irwin" <wli@holomorphy.com>, sparclinux@vger.kernel.org

--Signature=_Thu__6_Nov_2008_15_24_21_+1100_Z0wfL10ez+IsTWD=
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alan,

A sparc allmodconfig build gives these warnings:

drivers/char/n_tty.c: In function 'n_tty_poll':
drivers/char/n_tty.c:1592: warning: array subscript is above array bounds
drivers/char/n_tty.c:1601: warning: array subscript is above array bounds
drivers/char/n_tty.c: In function 'n_tty_read':
drivers/char/n_tty.c:1306: warning: array subscript is above array bounds
drivers/char/tty_ioctl.c: In function 'set_termios':
drivers/char/tty_ioctl.c:574: warning: array subscript is above array bounds
drivers/char/tty_ioctl.c:578: warning: array subscript is above array bounds
drivers/char/tty_ioctl.c: In function 'tty_mode_ioctl':
drivers/char/tty_ioctl.c:729: warning: array subscript is above array bounds
drivers/char/tty_ioctl.c:963: warning: array subscript is above array bounds
drivers/char/tty_ioctl.c:969: warning: array subscript is above array bounds
drivers/char/tty_ioctl.c:618: warning: array subscript is above array bounds
drivers/char/tty_ioctl.c:1007: warning: array subscript is above array boun=
ds
drivers/char/tty_ioctl.c:1015: warning: array subscript is above array boun=
ds

These are things like:

                termios->c_cc[VTIME] =3D 0;

termios is a (struct ktermios *) which has "cc_t c_cc[NCCS];".  NCCS is
17 and VTIME is also 17.  I assume the intention is to actually fill in
_x_cc[0], but why is it done this way and not more directly?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__6_Nov_2008_15_24_21_+1100_Z0wfL10ez+IsTWD=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkScXUACgkQjjKRsyhoI8zjOACfaIsrUtauz/vDsOusCC4UOmrS
DkYAniz2cV2d8H0c0eFJAL2RORS1o9c8
=eQ5O
-----END PGP SIGNATURE-----

--Signature=_Thu__6_Nov_2008_15_24_21_+1100_Z0wfL10ez+IsTWD=--
