From: James Hogan <jhogan@kernel.org>
Date: Wed, 02 May 2018 22:09:34 +0000
Subject: Re: [PATCH 08/13] arch: define the ARCH_DMA_ADDR_T_64BIT config symbol in lib/Kconfig
Message-Id: <20180502220933.GB20766@jamesdev>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="wzJLGUyc3ArbnUjN"
List-Id: <sparclinux.vger.kernel.org>
References: <20180425051539.1989-1-hch@lst.de>
 <20180425051539.1989-9-hch@lst.de>
In-Reply-To: <20180425051539.1989-9-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2018 at 07:15:34AM +0200, Christoph Hellwig wrote:
> Define this symbol if the architecture either uses 64-bit pointers or the
> PHYS_ADDR_T_64BIT is set.  This covers 95% of the old arch magic.  We only
> need an additional select for Xen on ARM (why anyway?), and we now always
> set ARCH_DMA_ADDR_T_64BIT on mips boards with 64-bit physical addressing
> instead of only doing it when highmem is set.

I think this should be fine. It only affects alchemy and Netlogic, and
Netlogic supports highmem already.

So for MIPS:
Acked-by: James Hogan <jhogan@kernel.org>

Cheers
James

> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 985388078872..e10cc5c7be69 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1101,9 +1101,6 @@ config GPIO_TXX9
>  config FW_CFE
>  	bool
> =20
> -config ARCH_DMA_ADDR_T_64BIT
> -	def_bool (HIGHMEM && PHYS_ADDR_T_64BIT) || 64BIT
> -
>  config ARCH_SUPPORTS_UPROBES
>  	bool

> diff --git a/lib/Kconfig b/lib/Kconfig
> index ce9fa962d59b..1f12faf03819 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -435,6 +435,9 @@ config NEED_SG_DMA_LENGTH
>  config NEED_DMA_MAP_STATE
>  	bool
> =20
> +config ARCH_DMA_ADDR_T_64BIT
> +	def_bool 64BIT || PHYS_ADDR_T_64BIT
> +
>  config IOMMU_HELPER
>  	bool

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWuo3DwAKCRA1zuSGKxAj
8tikAQDi/ZUNjW7+epg5yVcHFsdN4zPqszjMfOoZb9Tw0/w5/QD+O0gHySriLqfv
vZwnsvl5Mx2kzMLvdMNqFC++weR4XwQ=
=H1g4
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--
