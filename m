From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 28 Aug 2008 07:58:36 +0000
Subject: Re: sparc build failure
Message-Id: <20080828175836.400efd25.sfr@canb.auug.org.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Thu__28_Aug_2008_17_58_36_+1000_nREVDnmBN8i.YwO2"
List-Id: <sparclinux.vger.kernel.org>
References: <20080828114602.6c6df4a2.sfr@canb.auug.org.au>
	<20080827.190409.80969099.davem@davemloft.net>
	<20080827.200350.79735512.davem@davemloft.net>
In-Reply-To: <20080827.200350.79735512.davem@davemloft.net>
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, wli@holomorphy.com

--Signature=_Thu__28_Aug_2008_17_58_36_+1000_nREVDnmBN8i.YwO2
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Wed, 27 Aug 2008 20:03:50 -0700 (PDT) David Miller <davem@davemloft.net>=
 wrote:
>
> Here's what I'll likely push to linus to fix this.
>=20
> Thanks for the report Stephen.
>=20
> sparc32: Implement smp_call_function_single().

I have applied this to linux-next today as well.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__28_Aug_2008_17_58_36_+1000_nREVDnmBN8i.YwO2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAki2WqwACgkQjjKRsyhoI8x4SwCeNG6b91aR7EzRpf+guUJ6Bmr0
/H8An0ldlCAnNhSKRsrJIVkjWi88Q8q7
=XcsN
-----END PGP SIGNATURE-----

--Signature=_Thu__28_Aug_2008_17_58_36_+1000_nREVDnmBN8i.YwO2--
