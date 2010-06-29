From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 29 Jun 2010 06:15:44 +0000
Subject: Re: [PATCH 2/4] sparc: break out some prom device-tree building
Message-Id: <20100629161544.e0af63f0.sfr@canb.auug.org.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Tue__29_Jun_2010_16_15_44_+1000_WUxM38Ip/cO_C_Xo"
List-Id: <sparclinux.vger.kernel.org>
References: <20100628215407.2017bf2f@debian>
	<20100628220037.5744c207@debian>
In-Reply-To: <20100628220037.5744c207@debian>
To: Andres Salomon <dilinger@queued.net>
Cc: devicetree-discuss@lists.ozlabs.org, pgf@laptop.org, x86@kernel.org, linux-kernel@vger.kernel.org, Mitch Bradley <wmb@laptop.org>, mingo@redhat.com, hpa@zytor.com, sparclinux@vger.kernel.org, tglx@linutronix.de, cjb@laptop.org, davem@davemloft.net

--Signature=_Tue__29_Jun_2010_16_15_44_+1000_WUxM38Ip/cO_C_Xo
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andres,

On Mon, 28 Jun 2010 22:00:37 -0400 Andres Salomon <dilinger@queued.net> wro=
te:
>
> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index 6f1470b..b4cb63b 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -150,6 +150,7 @@ config ARCH_NO_VIRT_TO_BUS
> =20
>  config OF
>  	def_bool y
> +	select OF_PROMTREE

Please put this select in CONFIG_SPARC instead as we want to move
CONFIG_OF to drivers/og/Kconfig

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__29_Jun_2010_16_15_44_+1000_WUxM38Ip/cO_C_Xo
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMKY+QAAoJEDMEi1NhKgbsDJMH/0lTOUhiEzu+od7cSu8EyqVL
+rHJhvo0mqAbEIF0qMuPj2JqsPJ6/O1cAPTBJ5eSDUXtxTZoLlnFzeU0tD8rtmca
DiXT8+9rYS+vlx93yZe306RNjuCIhwWMoDfraAuo6WUErGN+mzfX26vUbXhHmoYN
22p3jjD/DraYNq+l689oC3LFQCy8fSMpPxlULDijk6sMXgEE1+gTa3OAEVty7QvS
j30YyGrqU3x+Q1co1rC+iw5C9Zc48Fy891Amf6DGPssI74xLqIJNw5euE2pdy4EL
keCZrpK/KJZ8ujcyznRyrClcIc7eqbtsiLZYY2/VVC531yPuJg6C99e4U4xrsig=
=+saU
-----END PGP SIGNATURE-----

--Signature=_Tue__29_Jun_2010_16_15_44_+1000_WUxM38Ip/cO_C_Xo--
