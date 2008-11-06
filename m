From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 06 Nov 2008 04:35:55 +0000
Subject: Re: tty warning
Message-Id: <20081106153555.ed45a874.sfr@canb.auug.org.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Thu__6_Nov_2008_15_35_55_+1100_9UkBm175BGAlgdh3"
List-Id: <sparclinux.vger.kernel.org>
References: <20081106152421.a9cf964f.sfr@canb.auug.org.au>
	<20081105.202557.233628145.davem@davemloft.net>
In-Reply-To: <20081105.202557.233628145.davem@davemloft.net>
To: David Miller <davem@davemloft.net>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, wli@holomorphy.com, sparclinux@vger.kernel.org

--Signature=_Thu__6_Nov_2008_15_35_55_+1100_9UkBm175BGAlgdh3
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Wed, 05 Nov 2008 20:25:57 -0800 (PST) David Miller <davem@davemloft.net>=
 wrote:
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Thu, 6 Nov 2008 15:24:21 +1100
>=20
> > These are things like:
> >=20
> >                 termios->c_cc[VTIME] =3D 0;
> >=20
> > termios is a (struct ktermios *) which has "cc_t c_cc[NCCS];".  NCCS is
> > 17 and VTIME is also 17.  I assume the intention is to actually fill in
> > _x_cc[0], but why is it done this way and not more directly?
>=20
> It's just some historical stuff.
>=20
> I've tried to rectify it, but it is non-trivial to fix and
> all it does is pacify a warning rather than fix a real problem
> so... ;-)
>=20
> This has been brought up perhaps 5 or 6 times in the past half
> year :)

Yeah, I guess that is when the compilers started complaining.

Oh, well :-(

[BTW, the number of warnings is itself becoming a real problem ... :-( ]
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__6_Nov_2008_15_35_55_+1100_9UkBm175BGAlgdh3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkSdCsACgkQjjKRsyhoI8waUgCgh3NeGLTpeN1R+90QwSdomEvA
vd8AoK0AaawR4PiosPH8eV7in2kPc0nU
=9N7B
-----END PGP SIGNATURE-----

--Signature=_Thu__6_Nov_2008_15_35_55_+1100_9UkBm175BGAlgdh3--
