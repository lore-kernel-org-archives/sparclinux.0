From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Wed, 25 Jul 2007 08:31:50 +0000
Subject: Re: [sparc64] Strange interaction between 2.6 kernel and 2.5 (and
Message-Id: <46A70A76.1050301@systella.fr>
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

	David,

	I have tried your patch with icemonkey and it hangs (in a futex).=20
Strace output ends with :

futex(0xf2d3b0, FUTEX_WAKE, 1)          =3D 0
write(5, "\372", 1)                     =3D 1
ioctl(3, 0x4004667f, 0xfffe5304)        =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D9, events=3DPOLLIN}, {fd=13,=20
events=3DPOLLIN|POLLPR
I}, {fd=15, events=3DPOLLIN|POLLPRI}, {fd=16, events=3DPOLLIN|POLLPRI},=20
{fd=17, even
ts=3DPOLLIN|POLLPRI}, {fd=3D4, events=3DPOLLIN, revents=3DPOLLIN}], 7, -1) =
=3D 1
gettimeofday({1185351978, 620970}, NULL) =3D 0
gettimeofday({1185351978, 621167}, NULL) =3D 0
gettimeofday({1185351978, 621487}, NULL) =3D 0
gettimeofday({1185351978, 621671}, NULL) =3D 0
futex(0x923ec, FUTEX_WAKE, 1)           =3D 1
futex(0x923e8, FUTEX_WAKE, 1)           =3D 1
read(4, "\372", 1)                      =3D 1
futex(0xf9504, FUTEX_WAKE, 1)           =3D 1
ioctl(3, 0x4004667f, 0xfffe5304)        =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D9, events=3DPOLLIN}, {fd=13,=20
events=3DPOLLIN|POLLPR
I}, {fd=15, events=3DPOLLIN|POLLPRI}, {fd=16, events=3DPOLLIN|POLLPRI},=20
{fd=17, even
ts=3DPOLLIN|POLLPRI}], 6, 0) =3D 0
write(3, "5\30\0\4\1 \30!\0\0\0>\0\22\0\22F\3\0\5\1 \30!\1 \n\236"...,=20
404) =3D 40
4
ioctl(3, 0x4004667f, 0xfffe5304)        =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D9, events=3DPOLLIN}, {fd=13,=20
events=3DPOLLIN|POLLPR
I}, {fd=15, events=3DPOLLIN|POLLPRI}, {fd=16, events=3DPOLLIN|POLLPRI},=20
{fd=17, even
ts=3DPOLLIN|POLLPRI}, {fd=3D4, events=3DPOLLIN, revents=3DPOLLIN}], 7, -1) =
=3D 1
futex(0xf300d4e4, FUTEX_WAKE, 1)        =3D 1
futex(0xf300d4e0, FUTEX_WAKE, 1)        =3D 1
futex(0xf277c8, FUTEX_WAKE, 1)          =3D 1
futex(0xf2d050, FUTEX_WAKE, 1)          =3D 1
futex(0xf2d054, FUTEX_WAIT, 1, NULL)    =3D -1 EAGAIN (Resource=20
temporarily unavai
lable)
futex(0xf277c8, FUTEX_WAKE, 1)          =3D 0
write(5, "\372", 1)                     =3D 1
ioctl(3, 0x4004667f, 0xfffe5304)        =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D9, events=3DPOLLIN}, {fd=13,=20
events=3DPOLLIN|POLLPR
I}, {fd=15, events=3DPOLLIN|POLLPRI}, {fd=16, events=3DPOLLIN|POLLPRI},=20
{fd=17, even
ts=3DPOLLIN|POLLPRI}, {fd=3D4, events=3DPOLLIN, revents=3DPOLLIN}], 7, -1) =
=3D 1
gettimeofday({1185351978, 680377}, NULL) =3D 0
write(3, "(\30\0\4\1 \3:\0\0\0>\0\0\0\0", 16) =3D 16
read(3, "\1\1\277\310\0\0\0\0\0@\0\372\0\1\0\27\0\0\0\1\0\0\0\0"..., 32)=20
=3D 32
write(3, "(\30\0\4\1 \3:\0\0\0>\0\0\0\0", 16) =3D 16
read(3, "\1\1\277\311\0\0\0\0\0@\0\372\0\1\0\27\0\0\0\1\0\0\0\0"..., 32)=20
=3D 32
write(3, "(\30\0\4\1 \3:\0\0\0>\0\0\0\0", 16) =3D 16
read(3, "\1\1\277\312\0\0\0\0\0@\0\372\0\1\0\27\0\0\0\1\0\0\0\0"..., 32)=20
=3D 32
write(3, "(\30\0\4\1 \3:\0\0\0>\0\0\0\0", 16) =3D 16
read(3, "\1\1\277\313\0\0\0\0\0@\0\372\0\1\0\27\0\0\0\1\0\0\0\0"..., 32)=20
=3D 32
write(3, "(\30\0\4\1 \3:\0\0\0>\0\0\0\0", 16) =3D 16
read(3, "\1\1\277\314\0\0\0\0\0@\0\372\0\1\0\27\0\0\0\1\0\0\0\0"..., 32)=20
=3D 32
write(3, "(\30\0\4\1 \3:\0\0\0>\0\0\0\0", 16) =3D 16
read(3, "\1\1\277\315\0\0\0\0\0@\0\372\0\1\0\27\0\0\0\1\0\0\0\0"..., 32)=20
=3D 32
gettimeofday({1185351978, 688447}, NULL) =3D 0
gettimeofday({1185351978, 688650}, NULL) =3D 0
gettimeofday({1185351978, 688958}, NULL) =3D 0
gettimeofday({1185351978, 689146}, NULL) =3D 0
futex(0x923ec, FUTEX_WAKE, 1)           =3D 1
futex(0x923e8, FUTEX_WAKE, 1)           =3D 1
write(5, "\372", 1)                     =3D 1
ioctl(3, 0x4004667f, 0xfffe5304)        =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D9, events=3DPOLLIN}, {fd=13,=20
events=3DPOLLIN|POLLPR
I}, {fd=15, events=3DPOLLIN|POLLPRI}, {fd=16, events=3DPOLLIN|POLLPRI},=20
{fd=17, even
ts=3DPOLLIN|POLLPRI}], 6, 0) =3D 0
write(3, "5\30\0\4\1 \30%\0\0\0>\4\t\3U;\3\0\7\1 \27\220\0\0\0\0"...,=20
7948) =3D 79
48
ioctl(3, 0x4004667f, 0xfffe5304)        =3D 0
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D9, events=3DPOLLIN}, {fd=13,=20
events=3DPOLLIN|POLLPR
I}, {fd=15, events=3DPOLLIN|POLLPRI}, {fd=16, events=3DPOLLIN|POLLPRI},=20
{fd=17, even
ts=3DPOLLIN|POLLPRI}, {fd=3D4, events=3DPOLLIN, revents=3DPOLLIN}], 7, -1) =
=3D 1
futex(0xf72cb648, FUTEX_WAIT, 2, NULL)  =3D ? ERESTARTSYS (To be restarted)
--- SIGWINCH (Window changed) @ 0 (0) ---
futex(0xf72cb648, FUTEX_WAIT, 2, NULL)  =3D ? ERESTARTSYS (To be restarted)
--- SIGWINCH (Window changed) @ 0 (0) ---
futex(0xf72cb648, FUTEX_WAIT, 2, NULL

	Last line is not terminated.

	Regards,

	JKB
