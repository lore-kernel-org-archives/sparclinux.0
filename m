From: Rene Rebe <rene@exactcode.de>
Date: Mon, 31 Jul 2006 08:31:24 +0000
Subject: Re: sparc64 fmulq emulation glitch?
Message-Id: <200607311031.24714.rene@exactcode.de>
List-Id: <sparclinux.vger.kernel.org>
References: <200606260902.12375.rene@exactcode.de>
In-Reply-To: <200606260902.12375.rene@exactcode.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Friday 28 July 2006 01:51, David Miller wrote:
> From: Rene Rebe <rene@exactcode.de>
> Date: Mon, 26 Jun 2006 09:02:12 +0200
>=20
> > int main ()
> > {
> >         long double a =3D 2;
> >         long double b =3D 1.0;
> >         a *=3D b;
> >         printf ("%Lf\n", a);
> > }
> >=20
> > built with: gcc -m64 -mhard-quad-float
> >=20
> > yields: 4
>=20
> Something is wrong with _FP_MUL_MEAT_2_wide_3mul, which tries to
> optimize the 2-limb multiply into 3 multiplies instead of 4.  None of
> the other platforms utilizing the soft-fp layer in the kernel try to
> use the _3mul version either.
>=20
> Correctness trumps performance, so we can just use the full 4 multiply
> version to fix this bug.
>=20
> Thanks for the report.
>=20
> diff-tree 92f282988b4ce3967ee8399f7d1184ebfa04e48b (from 64821324ca49f24b=
e1a66f2f432108f96a24e596)
> Author: David S. Miller <davem@sunset.davemloft.net>
> Date:   Thu Jul 27 16:49:21 2006 -0700
>=20
>     [SPARC64]: Fix quad-float multiply emulation.
>    =20
>     Something is wrong with the 3-multiply (vs. 4-multiply) optimized
>     version of _FP_MUL_MEAT_2_*(), so just use the slower version
>     which actually computes correct values.
>    =20
>     Noticed by Rene Rebe
>    =20
>     Signed-off-by: David S. Miller <davem@davemloft.net>
>=20
> diff --git a/include/asm-sparc64/sfp-machine.h b/include/asm-sparc64/sfp-=
machine.h
> index 5015bb8..89d4243 100644
> --- a/include/asm-sparc64/sfp-machine.h
> +++ b/include/asm-sparc64/sfp-machine.h
> @@ -34,7 +34,7 @@
>  #define _FP_MUL_MEAT_D(R,X,Y)					\
>    _FP_MUL_MEAT_1_wide(_FP_WFRACBITS_D,R,X,Y,umul_ppmm)
>  #define _FP_MUL_MEAT_Q(R,X,Y)					\
> -  _FP_MUL_MEAT_2_wide_3mul(_FP_WFRACBITS_Q,R,X,Y,umul_ppmm)
> +  _FP_MUL_MEAT_2_wide(_FP_WFRACBITS_Q,R,X,Y,umul_ppmm)
> =20
>  #define _FP_DIV_MEAT_S(R,X,Y)	_FP_DIV_MEAT_1_imm(S,R,X,Y,_FP_DIV_HELP_im=
m)
>  #define _FP_DIV_MEAT_D(R,X,Y)	_FP_DIV_MEAT_1_udiv_norm(D,R,X,Y)
>=20

I can confirm this patch corrects the emulation.

Yours thankfully,

--=20
  Ren=E9 Rebe - ExactCODE - Berlin (Europe / Germany)
  http://exactcode.de | http://t2-project.org | http://rene.rebe.name
  +49 (0)30 / 255 897 45
