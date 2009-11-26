From: Wolfram Sang <w.sang@pengutronix.de>
Date: Thu, 26 Nov 2009 12:28:42 +0000
Subject: Re: [PATCH 00/11] Yet another series of OF merge patches.
Message-Id: <20091126122842.GC4846@pengutronix.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="JgQwtEuHJzHdouWu"
List-Id: <sparclinux.vger.kernel.org>
References: <20091124081316.6216.66310.stgit@angua>
In-Reply-To: <20091124081316.6216.66310.stgit@angua>
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au, benh@kernel.crashing.org, sfr@canb.auug.org.au, davem@davemloft.net, monstr@monstr.eu


--JgQwtEuHJzHdouWu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2009 at 01:17:41AM -0700, Grant Likely wrote:
> Nothing much to say here other than mostly mechanical merging of OF
> support code.  Some of it remains a little ugly, but I'm taking the
> approach of merging the code first, and refactoring it second.
>=20
> I've pushed this series out to my test-devicetree branch on my git
> server if anyone wants to test.  That branch also includes the
> previous 2 patch series that I've sent out.
>=20
> git://git.secretlab.ca/git/linux-2.6 test-devicetree
>=20
> Compile tested on: ppc64, ppc32, microblaze, sparc64, sparc32.
> Boot tested on mpc5200 (ppc32) platform.

test-devicetree as of today also works fine on my phyCORE-MPC5200B-IO.

Tested-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--JgQwtEuHJzHdouWu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAksOdHkACgkQD27XaX1/VRsPLgCgv0ZKmj3Ea/43SgVMA6CJ/tB0
zy0AoLrdXihljb6X17/9LaL0mQa7ugeS
=eVCc
-----END PGP SIGNATURE-----

--JgQwtEuHJzHdouWu--
