From: James Hogan <jhogan@kernel.org>
Date: Wed, 02 May 2018 20:11:25 +0000
Subject: Re: [PATCH 07/13] arch: remove the ARCH_PHYS_ADDR_T_64BIT config symbol
Message-Id: <20180502201123.GA20766@jamesdev>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
List-Id: <sparclinux.vger.kernel.org>
References: <20180425051539.1989-1-hch@lst.de>
 <20180425051539.1989-8-hch@lst.de>
In-Reply-To: <20180425051539.1989-8-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2018 at 07:15:33AM +0200, Christoph Hellwig wrote:
> Instead select the PHYS_ADDR_T_64BIT for 32-bit architectures that need a
> 64-bit phys_addr_t type directly.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>

>  arch/mips/Kconfig                      | 15 ++++++---------

For MIPS:
Acked-by: James Hogan <jhogan@kernel.org>

Cheers
James

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWuobYAAKCRA1zuSGKxAj
8rcSAP9uo9v+ADH7S0A5ptU5zQJbehcDNcjsP+tV3mIWaMxo5AD9Fxc2fxERhWzk
sHBf3K14mN5e+PiMMLB9/hGD7t8eJAo=
=7djd
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
