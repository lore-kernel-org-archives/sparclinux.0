From: Michal Simek <monstr@monstr.eu>
Date: Mon, 18 Sep 2017 17:49:12 +0000
Subject: Re: [PATCH 2/2] arch: change default endian for microblaze
Message-Id: <cf4bd066-b349-070a-ddf9-d6ae02f44cd7@monstr.eu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="w8wI5jvOXsju10d8xtnE5mcxrOGavl9pn"
List-Id: <sparclinux.vger.kernel.org>
References: <1505753609-602923-1-git-send-email-babu.moger@oracle.com>
 <1505753609-602923-3-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1505753609-602923-3-git-send-email-babu.moger@oracle.com>
To: Babu Moger <babu.moger@oracle.com>, jejb@parisc-linux.org, deller@gmx.de, davem@davemloft.net, akpm@linux-foundation.org
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--w8wI5jvOXsju10d8xtnE5mcxrOGavl9pn
Content-Type: multipart/mixed; boundary="sD8A69GodVaAu8XsLbPmmeRUh846P96d9";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Babu Moger <babu.moger@oracle.com>, jejb@parisc-linux.org, deller@gmx.de,
 davem@davemloft.net, akpm@linux-foundation.org
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-parisc@vger.kernel.org
Message-ID: <cf4bd066-b349-070a-ddf9-d6ae02f44cd7@monstr.eu>
Subject: Re: [PATCH 2/2] arch: change default endian for microblaze
References: <1505753609-602923-1-git-send-email-babu.moger@oracle.com>
 <1505753609-602923-3-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1505753609-602923-3-git-send-email-babu.moger@oracle.com>

--sD8A69GodVaAu8XsLbPmmeRUh846P96d9
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18.9.2017 18:53, Babu Moger wrote:
> Fix the default for microblaze. Michal Simek mentioned default for
> microblaze should be CPU_LITTLE_ENDIAN.
>=20
> Fixes : commit 206d3642d8ee ("arch/microblaze: add choice for endiannes=
s
> 	and update Makefile")
>=20
> Signed-off-by: Babu Moger <babu.moger@oracle.com>
> Cc: Michal Simek <monstr@monstr.eu>
> ---
>  arch/microblaze/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
> index 9d26abd..4f798aa 100644
> --- a/arch/microblaze/Kconfig
> +++ b/arch/microblaze/Kconfig
> @@ -39,7 +39,7 @@ config MICROBLAZE
>  # Endianness selection
>  choice
>  	prompt "Endianness selection"
> -	default CPU_BIG_ENDIAN
> +	default CPU_LITTLE_ENDIAN
>  	help
>  	  microblaze architectures can be configured for either little or
>  	  big endian formats. Be sure to select the appropriate mode.
>=20

Acked-by: Michal Simek <michal.simek@xilinx.com>

If you want me to take this through my microblaze tree please let me know=
=2E

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--sD8A69GodVaAu8XsLbPmmeRUh846P96d9--

--w8wI5jvOXsju10d8xtnE5mcxrOGavl9pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlnAByUACgkQykllyylKDCFmMACfYDL1NnvIzjFQPopz2IPnYos9
b+wAnAha9d+de0FJgE2kDYfyilSb7K44
=anIL
-----END PGP SIGNATURE-----

--w8wI5jvOXsju10d8xtnE5mcxrOGavl9pn--
