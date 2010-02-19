From: spender@grsecurity.net (Brad Spengler)
Date: Fri, 19 Feb 2010 23:54:51 +0000
Subject: Re: Execution possible in non-executable mappings in recent 2.6 kernels
Message-Id: <20100219235451.GA30274@grsecurity.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="5vNYLRcllDrimb99"
List-Id: <sparclinux.vger.kernel.org>
References: <20100219225724.GA29861@grsecurity.net>
In-Reply-To: <20100219225724.GA29861@grsecurity.net>
To: sparclinux@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I can confirm this resolved the problem.  Thanks again for the=20
incredibly quick fix!

Tested-by: Brad Spengler <spender@grsecurity.net>

-Brad

On Fri, Feb 19, 2010 at 03:20:11PM -0800, David Miller wrote:
>=20
> Here's the fix, thanks again for the report:
>=20
> sparc64: Fix sun4u execute bit check in TSB I-TLB load.
>=20
> Thanks to testcase and report from Brad Spengler:
>=20
> --------------------
> #include <stdio.h>
>=20
> typedef int (* _wee)(void);
>=20
> int main(void)
> {
>         char buf[8] =3D { '\x81', '\xc7', '\xe0', '\x08', '\x81', '\xe8',
>                         '\x00', '\x00' };
>         _wee wee;
>         printf("%p\n", &buf);
>         wee =3D (_wee)&buf;
>         wee();
>=20
>         return 0;
> }
> --------------------
>=20
> TSB I-tlb load code tries to use andcc to check the _PAGE_EXEC_4U bit,
> but that's bit 12 so it gets sign extended all the way up to bit 63
> and the test nearly always passes as a result.
>=20
> Use sethi to fix the bug.
>=20
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
>  arch/sparc/kernel/tsb.S |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/sparc/kernel/tsb.S b/arch/sparc/kernel/tsb.S
> index 8c91d9b..db15d12 100644
> --- a/arch/sparc/kernel/tsb.S
> +++ b/arch/sparc/kernel/tsb.S
> @@ -191,10 +191,12 @@ tsb_dtlb_load:
> =20
>  tsb_itlb_load:
>  	/* Executable bit must be set.  */
> -661:	andcc		%g5, _PAGE_EXEC_4U, %g0
> -	.section	.sun4v_1insn_patch, "ax"
> +661:	sethi		%hi(_PAGE_EXEC_4U), %g4
> +	andcc		%g5, %g4, %g0
> +	.section	.sun4v_2insn_patch, "ax"
>  	.word		661b
>  	andcc		%g5, _PAGE_EXEC_4V, %g0
> +	nop
>  	.previous
> =20
>  	be,pn		%xcc, tsb_do_fault
> --=20
> 1.6.6.1

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFLfyTJmHm2SUJF1GoRAmspAJ0dV6IyqVUckDrK9ggZC7Rl9eNwhQCcCpNv
6RGtHlgv4kEQ8AcsoNMPUWY=
=FjpX
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
