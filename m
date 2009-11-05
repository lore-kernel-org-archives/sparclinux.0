From: Wolfram Sang <w.sang@pengutronix.de>
Date: Thu, 05 Nov 2009 08:45:27 +0000
Subject: Re: [PATCH 02/11] of/flattree: merge of_scan_flat_dt
Message-Id: <20091105084527.GB3478@pengutronix.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="rJwd6BRFiFCcLxzm"
List-Id: <sparclinux.vger.kernel.org>
References: <20091105073728.10460.6061.stgit@angua> <20091105074527.10460.23877.stgit@angua>
In-Reply-To: <20091105074527.10460.23877.stgit@angua>
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, benh@kernel.crashing.org, sfr@canb.auug.org.au, davem@davemloft.net, sparclinux@vger.kernel.org, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 05, 2009 at 12:45:35AM -0700, Grant Likely wrote:
> Merge common code between PowerPC and Microblaze

Just minor fixes in nanodoc.

> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 9faa9a5..7c3c13c 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -19,3 +19,68 @@ char *find_flat_dt_string(u32 offset)
>  	return ((char *)initial_boot_params) +
>  		initial_boot_params->off_dt_strings + offset;
>  }
> +
> +/**
> + * of_scan_flat_dt - scan flattend tree blob and call callback on each.

flattened

> + * @it: callback function
> + * @data: context data pointer
> + *
> + * This function is used to scan the flattened device-tree, it is
> + * used to extract the memory informations at boot before we can

I am not a native speaker, yet I have been taught there is no "informations=
".

> + * unflatten the tree
> + */

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrykKcACgkQD27XaX1/VRsLywCgs3Py1XfEtmhn0ZIIgaxE/5HJ
gw0An2Zx/QwbSHDpR+dyZfLr5OkTTpjt
=hGVU
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
