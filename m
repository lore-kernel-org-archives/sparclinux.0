From: Emanuele Rocca <ema@debian.org>
Date: Mon, 26 Feb 2007 23:23:28 +0000
Subject: Re:  2.6.20 unaligned accesses
Message-Id: <20070226232328.GA6779@darkmoon.home>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="wac7ysb48OaltWcw"
List-Id: <sparclinux.vger.kernel.org>
References: <200702231155.25915.andrew@walrond.org>
In-Reply-To: <200702231155.25915.andrew@walrond.org>
To: sparclinux@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* David Miller <davem@davemloft.net>, [2007-02-26 15:16 -0800]:
>  From: Emanuele Rocca <ema@debian.org>

>  > On a Sun Blade 2000 I got this one every time I load eth1394:
>  > Kernel unaligned access at TPC[101880c8] ether1394_reset_priv+0x2c/0xb=
8 [eth1394]
>  >=20
>  > I got rid of the message with the following patch:
> =20
>  That is a different bug, and the current 2.6.x tree already has
>  that fix applied so you shouldn't need to apply that patch to
>  the vanilla tree.

Ah, nice. linux-source 2.6.18.dfsg.1-11 (Debian unstable) is affected by
the bug, so maybe we could add the patch?

Thanks.
ciao,
    ema

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFF42vwC6DuA+rxm2ARApGdAJ4oijZK+ZlyuSFl7HrCOYbzydshsgCcDsy/
sGjavSrFIJ7g3mX6/faxi14=
=4b3n
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
