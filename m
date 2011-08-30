From: Ryan <admin@nayr.net>
Date: Tue, 30 Aug 2011 07:29:11 +0000
Subject: Re: 3.0.3 on V120 Panic
Message-Id: <ED57AE53-1400-4458-A983-4AEF6E58B0AC@nayr.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Apple-Mail=_2575C883-08EE-4535-B596-CF76ECE9F5F8"
List-Id: <sparclinux.vger.kernel.org>
References: <D5A65271-7B45-4B76-AC73-A4F140F1FB11@nayr.net>
In-Reply-To: <D5A65271-7B45-4B76-AC73-A4F140F1FB11@nayr.net>
To: sparclinux@vger.kernel.org


--Apple-Mail=_2575C883-08EE-4535-B596-CF76ECE9F5F8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

That fixed it, thanks a bunch.. Was a hard day finding out none of the =
3.x kernels would boot on this machine.

Cheers,
-R

On Aug 29, 2011, at 8:34 PM, David Miller wrote:

> From: Ryan <admin@nayr.net>
> Date: Mon, 29 Aug 2011 16:58:21 -0600
>=20
>> Built latest stable kernel and it works perfectly fine on a SunFire
>> T1000, tried to install the same kernel on a V120 and this is the
>> result from boot:
>=20
> I know, I hit this myself earlier today, this should fix it:
>=20
> diff --git a/arch/sparc/kernel/setup_64.c =
b/arch/sparc/kernel/setup_64.c
> index 3e9daea..3c5bb78 100644
> --- a/arch/sparc/kernel/setup_64.c
> +++ b/arch/sparc/kernel/setup_64.c
> @@ -440,8 +440,14 @@ static void __init init_sparc64_elf_hwcap(void)
> 			cap |=3D AV_SPARC_VIS;
> 		if (tlb_type =3D=3D cheetah || tlb_type =3D=3D =
cheetah_plus)
> 			cap |=3D AV_SPARC_VIS | AV_SPARC_VIS2;
> -		if (tlb_type =3D=3D cheetah_plus)
> -			cap |=3D AV_SPARC_POPC;
> +		if (tlb_type =3D=3D cheetah_plus) {
> +			unsigned long impl, ver;
> +
> +			__asm__ __volatile__("rdpr %%ver, %0" : "=3Dr" =
(ver));
> +			impl =3D ((ver >> 32) & 0xffff);
> +			if (impl =3D=3D PANTHER_IMPL)
> +				cap |=3D AV_SPARC_POPC;
> +		}
> 		if (tlb_type =3D=3D hypervisor) {
> 			if (sun4v_chip_type =3D=3D SUN4V_CHIP_NIAGARA1)
> 				cap |=3D AV_SPARC_ASI_BLK_INIT;


--Apple-Mail=_2575C883-08EE-4535-B596-CF76ECE9F5F8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iEYEARECAAYFAk5ckUsACgkQIcAiq3SnceEONgCgnWVQmfw5DqNBXHEbuj89U+Jj
8vUAoJA5A9ryA9JH9qv9vWzLCEb/C/LY
=d16M
-----END PGP SIGNATURE-----

--Apple-Mail=_2575C883-08EE-4535-B596-CF76ECE9F5F8--
