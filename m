From: Wolfram Sang <w.sang@pengutronix.de>
Date: Tue, 04 Dec 2012 21:28:49 +0000
Subject: Re: [PATCH 0/2] sparc: Enable OF functionality for sparc for i2c and spi
Message-Id: <20121204212849.GA28935@pengutronix.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Dxnq1zWXvFF0Q93v"
List-Id: <sparclinux.vger.kernel.org>
References: <1354630178-25387-1-git-send-email-andreas@gaisler.com>
 <CACxGe6sw0zU0NcXw1gjMZka4WyTZgT4heF3r4k0QPHbfcPzbiw@mail.gmail.com>
 <20121204.161001.1397661306369063374.davem@davemloft.net>
In-Reply-To: <20121204.161001.1397661306369063374.davem@davemloft.net>
To: David Miller <davem@davemloft.net>
Cc: grant.likely@secretlab.ca, andreas@gaisler.com, sam@ravnborg.org, sparclinux@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, spi-devel-general@lists.sourceforge.net, linux-i2c@vger.kernel.org, software@gaisler.com


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 04, 2012 at 04:10:01PM -0500, David Miller wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> Date: Tue, 4 Dec 2012 14:44:57 +0000
>=20
> > On Tue, Dec 4, 2012 at 2:09 PM, Andreas Larsson <andreas@gaisler.com> w=
rote:
> >> This series removes the dependency on !SPARC for OF_I2C and removes the
> >> depencency of !defined(CONFIG_SPARC) for the function
> >> of_register_spi_devices. I find no reason for these to be unavailable
> >> for sparc.
> >>
> >> I am not sure if these should go through the sparc tree or the
> >> corresponding subsystem trees.
> >=20
> > They should go through the subsystem trees.
>=20
> I'll take this into the sparc tree after some build testing, thanks.

Checking git history, looks like Grant added the OF-I2C helpers in
2010-06 and some SPARC OF rework was done in 2010-10. Makes sense.

So, if those are going via SPARC tree:

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlC+axEACgkQD27XaX1/VRs9cACdEBW0omPfGE3jKC2AlH95DRab
8Z8An0lcLiSTbgcsHPijMpM9yMRiycN9
=DbTT
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
