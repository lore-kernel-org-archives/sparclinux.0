From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Mon, 30 Jul 2007 07:04:27 +0000
Subject: Re: [sparc64] Strange interaction between 2.6 kernel and 2.5 (and
Message-Id: <46AD8D7B.7000903@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <46933AE8.1080509@systella.fr>
In-Reply-To: <46933AE8.1080509@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
> Date: Sat, 28 Jul 2007 10:25:36 +0200
>=20
>> 1/ U2 with two Uii@296 MHz, 2 GB -> I cannot reproduced this bug
>> fermat:[~] > uname -a
>> Linux fermat 2.6.22.1 #2 SMP PREEMPT Wed Jul 11 11:01:38 CEST 2007=20
>> sparc64 GNU/Linux
>>
>> 2/ U60 with two Uii@450 MHz, 1 GB -> bug
>> rayleigh:[~] > uname -a
>> Linux rayleigh 2.6.22.1 #2 SMP Wed Jul 25 09:48:50 CEST 2007 sparc64=20
>> GNU/Linux
>>
>> 3/ U80 with four Uii@450 MHz, 2 GB -> bug
>> kant:[~] > uname -a
>> Linux kant 2.6.20.11-netfilter-route-patch #1 SMP Wed May 9 12:27:15=20
>> CEST 2007 sparc64 GNU/Linux
>> I have patched this kernel with netfilter route patch (and no one other).
>  ...
>> 	I have see a bug report with Iceweasel (debian name for firefox). Thus,=
=20
>> I think you can reproduce this bug with firefox. On U60 or U80,=20
>> Seamonkey is unusable (it quickly hangs).
>=20
> Try as I might I cannot reproduce this on my Ultra60
> with 360Mhz Ultra-II cpus.

	Very strange.

> You seem to see the problem only on the systems that have the 450Mhz
> cpus, any chance you can test the ultra60 with a different cpu
> variant?  Perhaps those chips are part of the problem.

	And we can explain why on my U2/SMP (Uii@296MHz), I cannot reproduce=20
the bug. I only have Uii@296 MHz and Uii@450 MHz, and I cannot switch=20
CPU's between my U2 and one of my U60 (I need a running U2). If you=20
want, I can open a ssh access on one of my U60 to do some tests.
What's cache size on your CPU's ? 450 has 4 MB, 296, only 2 MB.

	Gavin, what are your CPU's ?

	Regards,

	JKB
