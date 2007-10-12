From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Fri, 12 Oct 2007 09:16:11 +0000
Subject: Re: sun4v_data_access_exception on new 2.6.23
Message-Id: <470F3B5B.2010104@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <470E6F28.2010709@systella.fr>
In-Reply-To: <470E6F28.2010709@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
> Date: Fri, 12 Oct 2007 09:04:16 +0200
>=20
>> Writing inode tables: Kernel unaligned access at TPC[56004c]=20
>> xor_niagara_4+0x5c/0x128
>> sun4v_data_access_exception: ADDR[000000000053d354] CTX[0000]=20
>> TYPE[000a], going.
>=20
> Please try this patch:
>=20
> diff --git a/arch/sparc64/lib/xor.S b/arch/sparc64/lib/xor.S
> index a79c888..f44f58f 100644
> --- a/arch/sparc64/lib/xor.S
> +++ b/arch/sparc64/lib/xor.S
> @@ -491,12 +491,12 @@ xor_niagara_4:		/* %o0=3Dbytes, %o1=DEst, %o2=3Dsrc=
1, %o3=3Dsrc2, %o4=3Dsrc3 */
>  	ldda		[%i1 + 0x10] %asi, %i2	/* %i2/%i3 =3D src1 + 0x10 */
>  	xor		%g2, %i4, %g2
>  	xor		%g3, %i5, %g3
> -	ldda		[%i7 + 0x10] %asi, %i4	/* %i4/%i5 =3D src2 + 0x10 */
> +	ldda		[%l7 + 0x10] %asi, %i4	/* %i4/%i5 =3D src2 + 0x10 */
>  	xor		%l0, %g2, %l0
>  	xor		%l1, %g3, %l1
>  	stxa		%l0, [%i0 + 0x00] %asi
>  	stxa		%l1, [%i0 + 0x08] %asi
> -	ldda		[%i6 + 0x10] %asi, %g2	/* %g2/%g3 =3D src3 + 0x10 */
> +	ldda		[%l6 + 0x10] %asi, %g2	/* %g2/%g3 =3D src3 + 0x10 */
>  	ldda		[%i0 + 0x10] %asi, %l0	/* %l0/%l1 =3D dest + 0x10 */
> =20
>  	xor		%i4, %i2, %i4
> @@ -504,12 +504,12 @@ xor_niagara_4:		/* %o0=3Dbytes, %o1=DEst, %o2=3Dsrc=
1, %o3=3Dsrc2, %o4=3Dsrc3 */
>  	ldda		[%i1 + 0x20] %asi, %i2	/* %i2/%i3 =3D src1 + 0x20 */
>  	xor		%g2, %i4, %g2
>  	xor		%g3, %i5, %g3
> -	ldda		[%i7 + 0x20] %asi, %i4	/* %i4/%i5 =3D src2 + 0x20 */
> +	ldda		[%l7 + 0x20] %asi, %i4	/* %i4/%i5 =3D src2 + 0x20 */
>  	xor		%l0, %g2, %l0
>  	xor		%l1, %g3, %l1
>  	stxa		%l0, [%i0 + 0x10] %asi
>  	stxa		%l1, [%i0 + 0x18] %asi
> -	ldda		[%i6 + 0x20] %asi, %g2	/* %g2/%g3 =3D src3 + 0x20 */
> +	ldda		[%l6 + 0x20] %asi, %g2	/* %g2/%g3 =3D src3 + 0x20 */
>  	ldda		[%i0 + 0x20] %asi, %l0	/* %l0/%l1 =3D dest + 0x20 */
> =20
>  	xor		%i4, %i2, %i4
> @@ -517,12 +517,12 @@ xor_niagara_4:		/* %o0=3Dbytes, %o1=DEst, %o2=3Dsrc=
1, %o3=3Dsrc2, %o4=3Dsrc3 */
>  	ldda		[%i1 + 0x30] %asi, %i2	/* %i2/%i3 =3D src1 + 0x30 */
>  	xor		%g2, %i4, %g2
>  	xor		%g3, %i5, %g3
> -	ldda		[%i7 + 0x30] %asi, %i4	/* %i4/%i5 =3D src2 + 0x30 */
> +	ldda		[%l7 + 0x30] %asi, %i4	/* %i4/%i5 =3D src2 + 0x30 */
>  	xor		%l0, %g2, %l0
>  	xor		%l1, %g3, %l1
>  	stxa		%l0, [%i0 + 0x20] %asi
>  	stxa		%l1, [%i0 + 0x28] %asi
> -	ldda		[%i6 + 0x30] %asi, %g2	/* %g2/%g3 =3D src3 + 0x30 */
> +	ldda		[%l6 + 0x30] %asi, %g2	/* %g2/%g3 =3D src3 + 0x30 */
>  	ldda		[%i0 + 0x30] %asi, %l0	/* %l0/%l1 =3D dest + 0x30 */
> =20
>  	prefetch	[%i1 + 0x40], #one_read

	David,

	I think that your patch fix this bug. I shall test on other T1000 this=20
afternoon.

	Thanks,

	JKB
