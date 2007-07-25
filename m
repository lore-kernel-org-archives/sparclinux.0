From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Wed, 25 Jul 2007 06:58:23 +0000
Subject: Re: [sparc64] Strange interaction between 2.6 kernel and 2.5 (and
Message-Id: <46A6F48F.5000007@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <46933AE8.1080509@systella.fr>
In-Reply-To: <46933AE8.1080509@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
> Date: Thu, 12 Jul 2007 11:50:38 +0200
>=20
>> 	Process stops at line 17384 in clamav-strace:
>>
>> futex(0x25944f0, FUTEX_WAIT
>>
>> Line terminaison was written ("2, NULL)   =3D ? ERESTARTSYS (To be=20
>> restarted)") when I have pressed ctrl+C, but process remains in sleep=20
>> state. I have tried kill -15 (without any success). Only kill -9 kills=20
>> clamd.
>=20
> Can you give this patch a try?
>=20
> diff --git a/include/asm-sparc64/futex.h b/include/asm-sparc64/futex.h
> index 876312f..3b5797e 100644
> --- a/include/asm-sparc64/futex.h
> +++ b/include/asm-sparc64/futex.h
> @@ -14,6 +14,7 @@
>  	"	cmp	%2, %1\n"			\
>  	"	bne,pn	%%icc, 1b\n"			\
>  	"	 mov	0, %0\n"			\
> +	"	sra	%1, 0, %1\n"			\
>  	"3:\n"						\
>  	"	.section .fixup,#alloc,#execinstr\n"	\
>  	"	.align	4\n"				\
> @@ -88,6 +89,7 @@ futex_atomic_cmpxchg_inatomic(int __user *uaddr, int ol=
dval, int newval)
>  {
>  	__asm__ __volatile__(
>  	"\n1:	casa	[%3] %%asi, %2, %0\n"
> +	"	sra	%0, 0, %0\n"
>  	"2:\n"
>  	"	.section .fixup,#alloc,#execinstr\n"
>  	"	.align	4\n"

	Applied. My U60 is rebuilding a 2.6.22.1 kernel with your patch. I test=20
and I'll come back with feedback.

	Thanks,

	JKB
