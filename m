From: Wolfram Sang <w.sang@pengutronix.de>
Date: Thu, 05 Nov 2009 08:49:45 +0000
Subject: Re: [PATCH 05/11] of/flattree: merge of_get_flat_dt_prop
Message-Id: <20091105084945.GC3478@pengutronix.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="jousvV0MzM2p6OtC"
List-Id: <sparclinux.vger.kernel.org>
References: <20091105073728.10460.6061.stgit@angua> <20091105074606.10460.23775.stgit@angua>
In-Reply-To: <20091105074606.10460.23775.stgit@angua>
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, benh@kernel.crashing.org, sfr@canb.auug.org.au, davem@davemloft.net, sparclinux@vger.kernel.org, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au


--jousvV0MzM2p6OtC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 05, 2009 at 12:46:13AM -0700, Grant Likely wrote:
> Merge common code between PowerPC and Microblaze
>=20
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

nanodoc comment again

> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index a6e869e..7a51343 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -100,3 +100,46 @@ unsigned long __init of_get_flat_dt_root(void)
>  	return _ALIGN(p + strlen((char *)p) + 1, 4);
>  }
> =20
> +/**
> + * of_get_flat_dt_prop - Given a node in the flat blob, return the prope=
rty pointer
> + *
> + * This  function can be used within scan_flattened_dt callback to get

double space

> + * access to properties
> + */

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--jousvV0MzM2p6OtC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrykakACgkQD27XaX1/VRviXwCgmd8x2wzO31elQKz+vb54m/fl
LdQAoMIpSqdRZ6QoqDQJON/9Rr7LZ07u
=pnJ0
-----END PGP SIGNATURE-----

--jousvV0MzM2p6OtC--
