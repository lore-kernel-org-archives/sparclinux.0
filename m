From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Wed, 11 Jul 2007 18:56:29 +0000
Subject: Re: [sparc64] Strange interaction between 2.6 kernel and 2.5 (and
Message-Id: <469527DD.3030809@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <46933AE8.1080509@systella.fr>
In-Reply-To: <46933AE8.1080509@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

BERTRAND Jo=EBl wrote:
> BERTRAND Jo=EBl wrote:
>> David Miller wrote:
>>> From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
>>> Date: Tue, 10 Jul 2007 09:53:12 +0200
>>>
>>>>     When clamav-daemon (or all other daemons) remain in sleep mode,=20
>>>> I cannot quickly restart this daemon by /etc/init.d/$(daemon)=20
>>>> restart, I have to wait for a timeout.
>>>
>>> Use the kernel sysrq keystrokes to get a task dump to see where
>>> clamav-daemon is sleeping,
>>
>>     I will try tomorrow. I have to build a 2.6.22 (to see if nis works=20
>> because it doesn't with 2.6.22-rc7).
>=20
>     Tests made with a 2.6.22.1 (NIS works with 2.6.22.1 and not with=20
> 2.6.22-rc7, but I don't know why... ;-) )
>=20
>>> my suspicion is that it is stuck
>>> in the kernel futex code somewhere.
>>
>>     I think too.
>=20
>     When I write these lines, my mail server is blocked due to clamd=20
> socket trouble :
>=20
> Root rayleigh:[/etc/mail] > ps -eLf | grep clamd
> clamav    3502     1  3502  1    2 10:53 ?        00:01:23 /usr/sbin/clamd
> clamav    3502     1  7226  0    2 12:00 ?        00:00:00 /usr/sbin/clamd
> root      8091  5893  8091  0    1 12:18 pts/0    00:00:00 grep clamd
>=20
>     clamd remains in S mode.
>=20
>     I have tried to obtain mode information with sysrq+w without any=20
> success, sysrq+w returns no blocked task. In this example, clamd is=20
> blocked, but some other tasks can be blocked.

	David, I cannot obtain more information with sysrq, but I have found=20
another program that randomly stops : seamonkey (not really seamonkey,=20
iceape, its debian package). Iceape randomly stops in sleep state. I=20
have launched iceape in strace :

mprotect(0xf3ad6000, 8192, PROT_READ|PROT_WRITE) =3D 0
mprotect(0xf3ad8000, 8192, PROT_READ|PROT_WRITE) =3D 0
mprotect(0xf3ada000, 8192, PROT_READ|PROT_WRITE) =3D 0
mprotect(0xf3adc000, 8192, PROT_READ|PROT_WRITE) =3D 0
mprotect(0xf3ade000, 8192, PROT_READ|PROT_WRITE) =3D 0
mprotect(0xf3ae0000, 16384, PROT_READ|PROT_WRITE) =3D 0
mprotect(0xf3ae4000, 8192, PROT_READ|PROT_WRITE) =3D 0
mprotect(0xf3ae6000, 8192, PROT_READ|PROT_WRITE) =3D 0
mprotect(0xf3ae8000, 8192, PROT_READ|PROT_WRITE) =3D 0
gettimeofday({1184179749, 741572}, NULL) =3D 0
gettimeofday({1184179749, 741853}, NULL) =3D 0
futex(0x278dac, FUTEX_WAKE, 1)          =3D 1
access("/usr/lib/iceape/chrome/modern.jar", F_OK) =3D 0
gettimeofday({1184179749, 767087}, NULL) =3D 0
gettimeofday({1184179749, 767300}, NULL) =3D 0
gettimeofday({1184179749, 767530}, NULL) =3D 0
futex(0x278dac, FUTEX_WAKE, 1)          =3D 1
futex(0x278da8, FUTEX_WAKE, 1)          =3D 1
access("/usr/lib/iceape/chrome/modern.jar", F_OK) =3D 0
gettimeofday({1184179749, 771232}, NULL) =3D 0
gettimeofday({1184179749, 771447}, NULL) =3D 0
gettimeofday({1184179749, 771677}, NULL) =3D 0
futex(0x278dac, FUTEX_WAKE, 1)          =3D 1
futex(0xf3a00010, FUTEX_WAIT, 2, NULL <unfinished ...>
rayleigh:[~] >

(aborted by CTRL+C)

	If I restart iceape, it always stops with the same message type.

	I don't understand why (with the same kernel and same glibc), my U2/SMP=20
works fine and not my U60/SMP.

	Regards,

	JKB
